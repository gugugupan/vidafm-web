// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery.cycle.lite 
//= require spin.min
//= require jquery.cookie
//= require jquery.spin
//= require underscore-min
//= require humane.min
//= require video
//= require misc
//= require users


// underscore.js的模版设置，暂时不用。
// _.templateSettings = {
//   interpolate : /\{\{(.+?)\}\}/g,
//   evaluate : /\{\-(.+?)\-\}/g
// };

function gup( name )
{
  name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
  var regexS = "[\\?&]"+name+"=([^&#]*)";
  var regex = new RegExp( regexS );
  var results = regex.exec( window.location.href );
  if( results == null )
    return "";
  else
    return results[1];
}

$("[data-login-required=true]").live('ajax:before', function(e) {
	if (current_user.id) {
	} else {
    humane.error("对不起，请登陆后再操作。");
		return false;
	}
});


$("[data-disable-with-spin]").live('click', function(e) {
  var opts = {
    lines: 8, // The number of lines to draw
    length: 3, // The length of each line
    width: 2, // The line thickness
    radius: 4, // The radius of the inner circle
    color: '#000', // #rgb or #rrggbb
    speed: 1, // Rounds per second
    trail: 60, // Afterglow percentage
    shadow: false, // Whether to render a shadow
    hwaccel: false, // Whether to use hardware acceleration
    className: 'spinner', // The CSS class to assign to the spinner
    zIndex: 2e9, // The z-index (defaults to 2000000000)
    top: 'auto', // Top position relative to parent in px
    left: 'auto' // Left position relative to parent in px
  };
  $(e.currentTarget).css('color', 'white').spin(opts);
});