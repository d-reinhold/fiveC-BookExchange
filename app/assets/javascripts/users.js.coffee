# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $("body").delegate "table#current-listings-table tbody tr", "click", (event) ->
    if @.id != "unavailable"
      location.href= '/listings/' + @.id
    

 # $("body").delegate "table#current-listings-table tbody tr", "onHover", (event) ->
#    @.child("td.current-listings-info-cell").css "display", "block"

  $("#sign-up-button").click (event) ->
    $("#new_user").submit()
    
  $("#sign-in-button").click (event) ->
    $("#sign-in-form").submit()