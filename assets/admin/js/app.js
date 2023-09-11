'use strict';

$(function(){
  $('#sidebar__menuWrapper').slimScroll({
    height: 'calc(100vh - 86.75px)',
    railVisible: true,
		alwaysVisible: true
  });
});

$(function(){
  $('.dropdown-menu__body').slimScroll({
    height: '270px'
  });
});

// modal-dialog-scrollable
$(function(){
  $('.modal-dialog-scrollable .modal-body').slimScroll({
    height: '100%'
  });
});

// activity-list 
$(function(){
  $('.activity-list').slimScroll({
    height: '385px'
  });
});

// recent ticket list 
$(function(){
  $('.recent-ticket-list__body').slimScroll({
    height: '295px'
  });
});

$('.navbar-search-field').on('input', function () {
    var search = $(this).val().toLowerCase();
    var search_result_pane = $('.search-list');
    $(search_result_pane).html('');
    if (search.length == 0) {
      $('.search-list').addClass('d-none');
        return;
    }
    $('.search-list').removeClass('d-none');

    // search
    var match = $('.sidebar__menu-wrapper .nav-link').filter(function (idx, elem) {
        return $(elem).text().trim().toLowerCase().indexOf(search) >= 0 ? elem : null;
    }).sort();



    // search not found
    if (match.length == 0) {
        $(search_result_pane).append('<li class="text-muted pl-5">No search result found.</li>');
        return;
    }

    // search found
    match.each(function (idx, elem) {
      var parent = $(elem).parents('.sidebar-menu-item.sidebar-dropdown').find('.menu-title').first().text();
      if (!parent) {
        parent = `Main Menu`
      }
      parent = `<small class="d-block">${parent}</small>`
      var item_url = $(elem).attr('href') || $(elem).data('default-url');
      var item_text = $(elem).text().replace(/(\d+)/g, '').trim();
      $(search_result_pane).append(`
        <li>
          ${parent}
          <a href="${item_url}" class="fw-bold text-color--3 d-block">${item_text}</a>
        </li>
      `);
    });

});


  $(function () {
    $('[data-bs-toggle="tooltip"]').tooltip()
  })

  // responsive sidebar expand js 
  $('.res-sidebar-open-btn').on('click', function (){
    $('.sidebar').addClass('open');
  }); 

  $('.res-sidebar-close-btn').on('click', function (){
    $('.sidebar').removeClass('open');
  }); 

/* Get the documentElement (<html>) to display the page in fullscreen */
let elem = document.documentElement;

$('.sidebar-dropdown > a').on('click', function () {
  if ($(this).parent().find('.sidebar-submenu').length) {
    if ($(this).parent().find('.sidebar-submenu').first().is(':visible')) {
      $(this).find('.side-menu__sub-icon').removeClass('transform rotate-180');
      $(this).removeClass('side-menu--open');
      $(this).parent().find('.sidebar-submenu').first().slideUp({
        done: function done() {
          $(this).removeClass('sidebar-submenu__open');
        }
      });
    } else {
      $(this).find('.side-menu__sub-icon').addClass('transform rotate-180');
      $(this).addClass('side-menu--open');
      $(this).parent().find('.sidebar-submenu').first().slideDown({
        done: function done() {
          $(this).addClass('sidebar-submenu__open');
        }
      });
    }
  }
});

// select-2 init
$('.select2-basic').select2();
$('.select2-multi-select').select2();
$(".select2-auto-tokenize").select2({
  tags: true,
  tokenSeparators: [',']
});


function proPicURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            var preview = $(input).parents('.thumb').find('.profilePicPreview');
            $(preview).css('background-image', 'url(' + e.target.result + ')');
            $(preview).addClass('has-image');
            $(preview).hide();
            $(preview).fadeIn(650);
        }
        reader.readAsDataURL(input.files[0]);
    }
}
$(".profilePicUpload").on('change', function () {
    proPicURL(this);
});

$(".remove-image").on('click', function () {
    $(this).parents(".profilePicPreview").css('background-image', 'none');
    $(this).parents(".profilePicPreview").removeClass('has-image');
    $(this).parents(".thumb").find('input[type=file]').val('');
});

$("form").on("change", ".file-upload-field", function(){
  $(this).parent(".file-upload-wrapper").attr("data-text",$(this).val().replace(/.*(\/|\\)/, '') );
});



var inputElements = $('input,select,textarea');

$.each(inputElements, function (index, element) {
    element = $(element);
    if (!element.hasClass('profilePicUpload') && (!element.attr('id')) && element.attr('type') != 'hidden') {
      element.closest('.form-group').find('label').attr('for',element.attr('name'));
      element.attr('id',element.attr('name'))
    }
});



var tooltipTriggerList = [].slice.call(document.querySelectorAll('[title], [data-title], [data-bs-title]'))
tooltipTriggerList.map(function (tooltipTriggerEl) {
  return new bootstrap.Tooltip(tooltipTriggerEl)
});

$.each($('input, select, textarea'), function (i, element) {
  
  if (element.hasAttribute('required')) {
    $(element).closest('.form-group').find('label').first().addClass('required');
  }

});


//Custom Data Table
$('.custom-data-table').closest('.card').find('.card-body').attr('style','padding-top:0px');
var tr_elements = $('.custom-data-table tbody tr');
$(document).on('input','input[name=search_table]',function(){
  var search = $(this).val().toUpperCase();
  var match = tr_elements.filter(function (idx, elem) {
    return $(elem).text().trim().toUpperCase().indexOf(search) >= 0 ? elem : null;
  }).sort();
  var table_content = $('.custom-data-table tbody');
  if (match.length == 0) {
    table_content.html('<tr><td colspan="100%" class="text-center">Data Not Found</td></tr>');
  }else{
    table_content.html(match);
  }
});

$('.pagination').closest('nav').addClass('d-flex justify-content-end');

$('.showFilterBtn').on('click',function(){
  $('.responsive-filter-card').slideToggle();
});

$(document).on('click','.short-codes',function () {
  var text = $(this).text();
  var vInput = document.createElement("input");
  vInput.value = text;
  document.body.appendChild(vInput);
  vInput.select();
  document.execCommand("copy");
  document.body.removeChild(vInput);
  $(this).addClass('copied');
  setTimeout(() => {
      $(this).removeClass('copied');
  }, 1000);
});


Array.from(document.querySelectorAll('table')).forEach(table => {
  let heading = table.querySelectorAll('thead tr th');
  Array.from(table.querySelectorAll('tbody tr')).forEach((row) => {
      Array.from(row.querySelectorAll('td')).forEach((colum, i) => {
          colum.setAttribute('data-label', heading[i].innerText)
      });
  });
});

var len = 0;
var clickLink = 0;
var search = null;
var process = false;
$('#searchInput').on('keydown', function(e){
  var length = $('.search-list li').length;
  if(search != $(this).val() && process){
      len = 0;
      clickLink = 0;
      $(`.search-list li:eq(${len}) a`).focus();
      $(`#searchInput`).focus();
  }
  //Down
  if(e.keyCode == 40 && length){
      process = true;
      var contra = false;
      if(len < clickLink && clickLink < length){
          len += 2;
      }
      $(`.search-list li[class="bg--dark"]`).removeClass('bg--dark');
      $(`.search-list li a[class="text--white"]`).removeClass('text--white');
      $(`.search-list li:eq(${len}) a`).focus().addClass('text--white');
      $(`.search-list li:eq(${len})`).addClass('bg--dark');
      $(`#searchInput`).focus();
      clickLink = len;
      if(!$(`.search-list li:eq(${clickLink}) a`).length){
          $(`.search-list li:eq(${len})`).addClass('text--white');
      }
      len += 1;
      if(length == Math.abs(clickLink)){
          len = 0;
      }
  }
  //Up
  else if(e.keyCode == 38 && length){
      process = true;
      if(len > clickLink && len != 0){
          len -= 2;
      }
      $(`.search-list li[class="bg--dark"]`).removeClass('bg--dark');
      $(`.search-list li a[class="text--white"]`).removeClass('text--white');
      $(`.search-list li:eq(${len}) a`).focus().addClass('text--white');
      $(`.search-list li:eq(${len})`).addClass('bg--dark');
      $(`#searchInput`).focus();
      clickLink = len;
      if(!$(`.search-list li:eq(${clickLink}) a`).length){
          $(`.search-list li:eq(${len})`).addClass('text--white');
      }
      len -= 1;
      if(length == Math.abs(clickLink)){
          len = 0;
      }
  }
  //Enter
  else if(e.keyCode == 13){
      e.preventDefault();
      if($(`.search-list li:eq(${clickLink}) a`).length && process){
          $(`.search-list li:eq(${clickLink}) a`)[0].click();
      }
  }
  //Retry
  else if(e.keyCode == 8){
      len = 0;
      clickLink = 0;
      $(`.search-list li:eq(${len}) a`).focus();
      $(`#searchInput`).focus();
  }
  search = $(this).val();
});