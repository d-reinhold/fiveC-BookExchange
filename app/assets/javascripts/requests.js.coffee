# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $("body").delegate "#request-this-book-final", "click", (event) ->
    $("form#new_request").submit()
    $("#new-request").fadeOut (event) ->
      $(".loading").css "display","block"
      
  $(".request-available").click (event) ->
    location.href= '/listings/' + @.id.split('-')[1]
  
  
  $(".delete-request a").click (event) ->
    event.preventDefault()
    agree = confirm "Are you sure you want to delete this request?"
    if agree
      $("form#delete-request-form input#id").val(@.id.split('-')[1])
      $("form#delete-request-form").submit()
      $("form#delete-request-form input#id").val('')
      $("[id*="+@.id.split('-')[1]+"]").fadeOut (event) ->

  