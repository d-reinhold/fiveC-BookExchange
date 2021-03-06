# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $(".buyer-transaction, .seller-transaction, .buyer-transaction-complete, .seller-transaction-complete").click (event) ->
    location.href= '/transactions/' + @.id

  $("#cancel-transaction").click (event) ->
    $("#cancel-transaction").removeClass "enabled"
    $("#cancel-transaction").addClass "disabled"
    $("#cancel-request-form").submit()
    $("#listing").fadeOut "slow", (event) ->
      $(".loading").css "display","block"
      
      
  $("#complete-transaction").click (event) ->
    $("#book-sold-form").submit()
    $("#listing").fadeOut "slow", (event) ->
      $(".loading").css "display","block"

