<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Artisan;
use App\Lib\CurlRequest;
use App\Lib\FileManager;
use App\Models\UpdateLog;
use App\Rules\FileTypeValidate;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Laramin\Utility\VugiChugi;

class SystemController extends Controller
{
    public function systemInfo(){
        $laravelVersion = app()->version();
        $timeZone = config('app.timezone');
        $pageTitle = 'Application Information';
        return view('admin.system.info',compact('pageTitle', 'laravelVersion','timeZone'));
    }

    public function optimize(){
        $pageTitle = 'Clear System Cache';
        return view('admin.system.optimize',compact('pageTitle'));
    }

    public function optimizeClear(){
        Artisan::call('optimize:clear');
        $notify[] = ['success','Cache cleared successfully'];
        return back()->withNotify($notify);
    }

    public function systemServerInfo(){
        $currentPHP = phpversion();
        $pageTitle = 'Server Information';
        $serverDetails = $_SERVER;
        return view('admin.system.server',compact('pageTitle', 'currentPHP', 'serverDetails'));
    }

    public function systemUpdate() {
        $pageTitle = 'System Updates';
        $updates = UpdateLog::orderBy('id','desc')->paginate(getPaginate());
        return view('admin.system.update',compact('pageTitle','updates'));
    }

    public function updateUpload(Request $request) {
        if (gs()->system_customized) {
            $notify[]=['error','The system already customized. You can\'t update the project.'];
            return back()->withNotify($notify);
        }
        
        $request->validate([
            'purchase_code' => 'required',
            'envato_username'        => 'required',
            'file'                   => ['required', new FileTypeValidate(['zip'])],
        ]);

        if(!extension_loaded('zip')){
            $notify[]=['error','zip Extension is required to install the template'];
            return back()->withNotify($notify);
        }

        $location = 'core/temp';

        //Upload the zip file
        try {
            $fileName = fileUploader($request->file, $location);
        } catch (\Exception $e) {
            $notify[] = ['error', $e->getMessage()];
            return back()->withNotify($notify);
        }

        $rand    = Str::random(10);
        $dir     = base_path('temp/' . $rand);
        $extract = $this->extractZip(base_path('temp/' . $fileName), $dir);

        if ($extract == false) {
            $this->removeDir($dir);
            $notify[] = ['error', 'Something went wrong to extract'];
            return back()->withNotify($notify);
        }

        //get config file
        if (!file_exists($dir . '/config.json')) {
            $this->removeDir($dir);
            $notify[] = ['error', 'Config file not found'];
            return back()->withNotify($notify);
        }

        $getConfig = file_get_contents($dir . '/config.json');
        $config    = json_decode($getConfig);

        $this->removeFile($location . '/' . $fileName);

        $param['code']    = $request->purchase_code;
        $param['url']     = env("APP_URL");
        $param['email']    = auth()->guard('admin')->user()->email;
        $param['user']    = $request->envato_username;
        $param['product'] = systemDetails()['name'];
        $reqRoute         = VugiChugi::lcLabSbm();
        $response         = CurlRequest::curlPostContent($reqRoute, $param);
        $response         = json_decode($response);

        if ($response->error == 'error') {
            $this->removeDir($dir);
            $general = gs();
            $general->maintenance_mode = 9;
            $general->save();
            $notify[] = ['error', $response->message];
            return back()->withNotify($notify);
        }

        $mainFile = $dir . '/update.zip';
        if (!file_exists($mainFile)) {
            $this->removeDir($dir);
            $notify[] = ['error', 'Main file not found'];
            return back()->withNotify($notify);
        }

        //move file
        $extract = $this->extractZip(base_path('temp/' . $rand . '/update.zip'), base_path('../'));
        if ($extract == false) {
            $notify[] = ['error', 'Something went wrong to extract'];
            return back()->withNotify($notify);
        }

        //Execute database
        if (file_exists($dir . '/update.sql')) {
            $sql = file_get_contents($dir . '/update.sql');
            DB::unprepared($sql);
        }

        $updateLog = new UpdateLog();
        $updateLog->version = $config->version;
        $updateLog->update_log = $config->changes;
        $updateLog->save();

        $this->removeDir($dir);

        $notify[] = ['success', 'Template uploaded successfully'];
        return back()->withNotify($notify);
    }

    protected function extractZip($file, $extractTo)
    {
        $zip = new \ZipArchive;
        $res = $zip->open($file);
        if ($res != true) {
            return false;
        }
        $res = $zip->extractTo($extractTo);
        $zip->close();
        return true;
    }

    protected function removeFile($path)
    {
        $fileManager = new FileManager();
        $fileManager->removeFile($path);
    }

    protected function removeDir($location)
    {
        $fileManager = new FileManager();
        $fileManager->removeDirectory($location);
    }
}