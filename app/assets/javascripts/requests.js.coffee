# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $("body").delegate "#request-this-book-final", "click", (event) ->
    $("form#new_request").submit()
    $("#new-request").fadeOut (event) ->
      $(".loading").css "display","block"
      
  $(".request-available").click (event) ->
    location.href= '/listings/' + @.id