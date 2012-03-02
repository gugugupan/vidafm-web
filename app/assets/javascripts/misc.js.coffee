# Place all the behaviors and hooks related to the matching controller here.  # All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $("a[data-remote=true]").live 'click', ->
      $(@).text($(@).attr("data-disable-with"))


  $("#v .close").click ->
  	$(@).parent("#v").remove()
  	# 关闭`moment show`页面的banner之后，不再出现。
  	$.cookie('is_banner_closed', true);