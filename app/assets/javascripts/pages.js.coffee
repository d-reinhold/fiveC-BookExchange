# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$(document).ready ->
  $("a#buttons-search").css("border-top", "20px solid #335ED4")
  $("a#buttons-search").css("border-left", "40px solid #335ED4")
  $("a#buttons-search").css("border-right", "40px solid #335ED4")
  $("a#buttons-search").css("background-color", "#335ED4")
  $("a#buttons-sell").css("border-top", "20px solid #11379E") 
  $("a#buttons-sell").css("border-left", "40px solid #11379E")
  $("a#buttons-sell").css("border-right", "40px solid #11379E")
  $("a#buttons-sell").css("background-color", "#11379E")

  $("a#sell-form-final-button").click (event) ->
    $("#new_user").submit()
    event.preventDefault()


  $("a#buttons-sell").click (event) ->
    $("#search-for-books").css("display","none")
    $("#sell-your-books").css("display","block")
    $("a#buttons-search").css("border-top", "20px solid #11379E")
    $("a#buttons-search").css("border-left", "40px solid #11379E")
    $("a#buttons-search").css("border-right", "40px solid #11379E")
    $("a#buttons-search").css("background-color", "#11379E")
    $("a#buttons-sell").css("border-top", "20px solid #335ED4")
    $("a#buttons-sell").css("border-left", "40px solid #335ED4")
    $("a#buttons-sell").css("border-right", "40px solid #335ED4")
    $("a#buttons-sell").css("background-color", "#335ED4")
    event.preventDefault()

  $("a#buttons-search").click (event) ->
    $("#sell-your-books").css("display","none")
    $("#search-for-books").css("display","block")
    $("a#buttons-sell").css("border-top", "20px solid #11379E") 
    $("a#buttons-sell").css("border-left", "40px solid #11379E")
    $("a#buttons-sell").css("border-right", "40px solid #11379E")
    $("a#buttons-sell").css("background-color", "#11379E")
    $("a#buttons-search").css("border-top", "20px solid #335ED4")
    $("a#buttons-search").css("border-left", "40px solid #335ED4")
    $("a#buttons-search").css("border-right", "40px solid #335ED4")
    $("a#buttons-search").css("background-color", "#335ED4")
    event.preventDefault()