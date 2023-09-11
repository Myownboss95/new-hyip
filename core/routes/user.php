<?php

use Illuminate\Support\Facades\Route;

Route::namespace('User\Auth')->name('user.')->group(function () {

    Route::controller('LoginController')->group(function () {
        Route::get('/login', 'showLoginForm')->name('login');
        Route::post('/login', 'login');
        Route::get('logout', 'logout')->middleware('auth')->name('logout');

        Route::post('login/metamask', 'metamaskLogin')->name('login.metamask');
        Route::post('login/metamask/verify', 'metamaskLoginVerify')->name('login.metamask.verify');
    });

    Route::controller('RegisterController')->group(function () {
        Route::get('register', 'showRegistrationForm')->name('register');
        Route::post('register', 'register')->middleware('registration.status');
        Route::post('check-mail', 'checkUser')->name('checkUser');
    });

    Route::controller('ForgotPasswordController')->prefix('password')->name('password.')->group(function () {
        Route::get('reset', 'showLinkRequestForm')->name('request');
        Route::post('email', 'sendResetCodeEmail')->name('email');
        Route::get('code-verify', 'codeVerify')->name('code.verify');
        Route::post('verify-code', 'verifyCode')->name('verify.code');
    });
    Route::controller('ResetPasswordController')->group(function () {
        Route::post('password/reset', 'reset')->name('password.update');
        Route::get('password/reset/{token}', 'showResetForm')->name('password.reset');
    });
});

Route::middleware('auth')->name('user.')->group(function () {

    //authorization
    Route::namespace('User')->middleware('registration.complete')->controller('AuthorizationController')->group(function () {
        Route::get('authorization', 'authorizeForm')->name('authorization');
        Route::get('resend-verify/{type}', 'sendVerifyCode')->name('send.verify.code');
        Route::post('verify-email', 'emailVerification')->name('verify.email');
        Route::post('verify-mobile', 'mobileVerification')->name('verify.mobile');
        Route::post('verify-g2fa', 'g2faVerification')->name('go2fa.verify');
    });

    Route::get('user-data', 'User\UserController@userData')->name('data');
    Route::post('check-user', 'User\UserController@checkUser')->name('check.user');
    Route::post('user-data-submit', 'User\UserController@userDataSubmit')->name('data.submit');

    Route::middleware(['check.status'])->group(function () {

        Route::middleware('registration.complete')->namespace('User')->group(function () {

            Route::controller('UserController')->group(function () {
                Route::get('dashboard', 'home')->name('home');

                //2FA
                Route::get('twofactor', 'show2faForm')->name('twofactor');
                Route::post('twofactor/enable', 'create2fa')->name('twofactor.en
                able');
                Route::post('twofactor/disable', 'disable2fa')->name('twofactor.disable');

                //KYC
                Route::get('kyc-form', 'kycForm')->name('kyc.form');
                Route::get('kyc-data', 'kycData')->name('kyc.data');
                Route::post('kyc-submit', 'kycSubmit')->name('kyc.submit');

                //Report
                Route::any('deposit/history', 'depositHistory')->name('deposit.history');
                Route::get('transactions', 'transactions')->name('transactions');

                Route::get('attachment-download/{fil_hash}', 'attachmentDownload')->name('attachment.download');

                Route::get('referrals', 'referrals')->name('referrals');

                Route::get('promotional-banners', 'promotionalBanners')->name('promotional.banner');

                //Balance Transfer
                Route::get('transfer-balance', 'transferBalance')->name('transfer.balance');
                Route::post('transfer-balance', 'transferBalanceSubmit');

                Route::post('find-user', 'findUser')->name('findUser');
            });

            //Profile setting
            Route::controller('ProfileController')->group(function () {
                Route::get('profile-setting', 'profile')->name('profile.setting');
                Route::post('profile-setting', 'submitProfile');
                Route::get('change-password', 'changePassword')->name('change.password');
                Route::post('change-password', 'submitPassword');
            });

            // Withdraw
            Route::controller('WithdrawController')->prefix('withdraw')->name('withdraw')->group(function () {
                Route::middleware('kyc')->group(function () {
                    Route::get('/', 'withdrawMoney');
                    Route::post('/', 'withdrawStore')->name('.money');
                    Route::get('preview', 'withdrawPreview')->name('.preview');
                    Route::post('preview', 'withdrawSubmit')->name('.submit');
                });
                Route::get('history', 'withdrawLog')->name('.history');
            });

            //Investment
            Route::controller('InvestController')->group(function () {
                Route::name('invest.')->prefix('invest')->group(function () {
                    Route::post('/', 'invest')->name('submit');
                    Route::get('statistics', 'statistics')->name('statistics');
                    Route::get('log', 'log')->name('log');
                    Route::get('details/{id}', 'details')->name('details');
                    Route::get('ranking', 'ranking')->name('ranking');

                    Route::post('capital/manage', 'manageCapital')->name('capital.manage');

                    Route::get('schedule', 'scheduleInvests')->name('schedule');
                    Route::post('schedule/status/{id}', 'scheduleInvestStatus')->name('schedule.status');
                });

                Route::name('staking.')->prefix('staking')->group(function () {
                    Route::get('/', 'staking')->name('index');
                    Route::post('save', 'saveStaking')->name('save');
                });

                Route::name('pool.')->prefix('pool')->group(function () {
                    Route::get('/', 'pool')->name('index');
                    Route::get('invest', 'poolInvests')->name('invests');
                    Route::post('invest', 'poolInvest')->name('invest');
                });
            });
        });

        // Payment
        Route::middleware('registration.complete')->prefix('deposit')->name('deposit.')->controller('Gateway\PaymentController')->group(function () {
            Route::any('/', 'deposit')->name('index');
            Route::post('insert', 'depositInsert')->name('insert');
            Route::get('confirm', 'depositConfirm')->name('confirm');
            Route::get('manual', 'manualDepositConfirm')->name('manual.confirm');
            Route::post('manual', 'manualDepositUpdate')->name('manual.update');
        });
    });
});
