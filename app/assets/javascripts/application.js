// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= custom
//= require_tree .

jQuery(document).ready(function() {

  jQuery.fn.content_count_down = function() {
    if(jQuery('#micropost_content').length > 0){
      var content_size = jQuery('#micropost_content').val().length;
      var difference = 140 - content_size;
      var display_message = 'Now You can type ' + difference + ' characters';
      jQuery('#content_text').html(display_message);
    }
  }

  jQuery(this).content_count_down();
    
  jQuery('#micropost_content').keyup(function(){
    jQuery(this).content_count_down();
  })

  jQuery.fn.followers_count = function() {
    jQuery.get('/relationships/total_followers', function(data) {
      jQuery("#followers").html(data.followers);
    });
  }

  jQuery("#post-form").live("click",function(){
    jQuery.ajax({
      url: jQuery(this).attr('action'),
      data: jQuery(this).serializeArray(),
      type: "POST",
      dataType: 'HTML',
      success: function(data) {
        jQuery("#follow_form").html(data);
        jQuery(this).followers_count();
      }
    });
    return false;
  })

  jQuery("#delete-form").live("click",function(){
    jQuery.ajax({
      url: jQuery(this).attr('action'),
      data: jQuery(this).serializeArray(),
      type: "DELETE",
      dataType: 'HTML',
      success: function(data) {
        jQuery("#follow_form").html(data);
        jQuery(this).followers_count();
      }
    });
    return false;
  })

})