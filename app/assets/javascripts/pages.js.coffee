# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
TITLE_READY = false
AUTHOR_READY = false
PRICE_DOLLARS_READY = false

$(document).ready ->
  if location.href.match(/(\?|&)autofill_title($|&|=)/)
    #alert "got params!"
    remove_status("p#price_dollars","How much are you asking for?")
    add_success("p#title","Title") 
    add_success("p#author","Author")
    $("#sell-your-books").css("display","block")
    $("#search-for-books").css("display", "none")
    $("a#buttons-search").css("border-top", "20px solid #11379E")
    $("a#buttons-search").css("border-left", "40px solid #11379E")
    $("a#buttons-search").css("border-right", "40px solid #11379E")
    $("a#buttons-search").css("background-color", "#11379E")
    $("a#buttons-sell").css("border-top", "20px solid #71B1F2")
    $("a#buttons-sell").css("border-left", "40px solid #71B1F2")
    $("a#buttons-sell").css("border-right", "40px solid #71B1F2")
    $("a#buttons-sell").css("background-color", "#71B1F2")
    
  #don't use ajax??

  $("body").delegate ".sell-this-book", "click", (event) ->
    title = $("ul.data li#title-"+@.id.split('$-$')[1]).text()
    author = $("ul.data li#author-"+@.id.split('$-$')[1]).text() 
    isbn = $("ul.data li#isbn-"+@.id.split('$-$')[1]).text()
    edition = $("ul.data li#edition-"+@.id.split('$-$')[1]).text()
    $(".loading").css "display","block"
    $("#search-for-books, #index-background").fadeOut "slow", ->
      location.href= '/?autofill_title=' + title + '&autofill_author=' + author + '&autofill_isbn=' + isbn + '&autofill_edition=' + edition

  $("body").delegate ".request-this-book", "click", (event) ->
    title = $("ul.data li#title-"+@.id.split('$-$')[1]).text()
    author = $("ul.data li#author-"+@.id.split('$-$')[1]).text() 
    isbn = $("ul.data li#isbn-"+@.id.split('$-$')[1]).text()
    edition = $("ul.data li#edition-"+@.id.split('$-$')[1]).text()
    $(".loading").css "display","block"
    $("#search-for-books, #index-background").fadeOut "slow", ->
      location.href= '/requests/new?autofill_title=' + title + '&autofill_author=' + author + '&autofill_isbn=' + isbn + '&autofill_edition=' + edition




  $("a#buttons-sell").click (event) ->
    $("#search-for-books").css("display","none")
    $("#sell-your-books").css("display","block")
    $("a#buttons-search").css("border-top", "20px solid #11379E")
    $("a#buttons-search").css("border-left", "40px solid #11379E")
    $("a#buttons-search").css("border-right", "40px solid #11379E")
    $("a#buttons-search").css("background-color", "#11379E")
    $("a#buttons-sell").css("border-top", "20px solid #71B1F2")
    $("a#buttons-sell").css("border-left", "40px solid #71B1F2")
    $("a#buttons-sell").css("border-right", "40px solid #71B1F2")
    $("a#buttons-sell").css("background-color", "#71B1F2")
    event.preventDefault()

  $("a#buttons-search").click (event) ->
    $("#sell-your-books").css("display","none")
    $("#search-for-books").css("display","block")
    $("a#buttons-sell").css("border-top", "20px solid #11379E") 
    $("a#buttons-sell").css("border-left", "40px solid #11379E")
    $("a#buttons-sell").css("border-right", "40px solid #11379E")
    $("a#buttons-sell").css("background-color", "#11379E")
    $("a#buttons-search").css("border-top", "20px solid #71B1F2")
    $("a#buttons-search").css("border-left", "40px solid #71B1F2")
    $("a#buttons-search").css("border-right", "40px solid #71B1F2")
    $("a#buttons-search").css("background-color", "#71B1F2")
    event.preventDefault()
    
  $("input[name='search_type']").change ->
    if $("input#search_type_keywords").is(':checked')
      $("#searchbar-keywords").css "display", "block"
      $("#searchbar-courses").css "display", "none"
      $(".checkboxes").css "display", "none"
      $("#search_keywords").val($("#search_courses").val())
      $("#search_courses").val("")
    else
      $("#searchbar-courses").css "display", "block"
      $("#searchbar-keywords").css "display", "none"
      $(".checkboxes").css "display", "block"
      $("#search_courses").val($("#search_keywords").val())
      $("#search_keywords").val("")
    
    
  $("body").delegate "button.fancy_button", "click", (event) ->
    event.preventDefault()
    
  $("body").delegate "button#search-button", "click", (event) ->
    if $("button#search-button").hasClass("enabled")
      $("button#search-button").removeClass("enabled")
      $("button#search-button").addClass("disabled")
      $("button#search-button").html('Searching...')
      $("form#search").submit()
      
  $(".course_searchbar").bind "railsAutocomplete.select", (event, data) ->
    if $("button#search-button").hasClass("enabled")
      $("button#search-button").removeClass("enabled")
      $("button#search-button").addClass("disabled")
      $("button#search-button").html('Searching...')
      $("form#search").submit()
      $("form#search input#id").val('')
      $("form#search input.course_searchbar").val('')      

 
  $(".book_title").focus (event) ->
    remove_status("p#title","What book are you selling?")

  $(".book_title").blur (event) ->
    if @value.length > 0
      add_success("p#title","Awesome, thanks!") 
    else
      add_error("p#title","Don't forget to enter a title!")
      
  $(".book_title").bind "railsAutocomplete.select", (event, data) ->
    add_success("p#author","Got it!")
    add_success("p#title","Awesome, thanks!")
    

  $(".book_author").focus (event) ->
    remove_status("p#author","Who's the author?")
   
  $(".book_author").blur (event) ->
    if @value.length > 0
      add_success("p#author","Got it!")
    else
      add_error("p#author","Wait, who's the author?")

  $(".price_dollars").focus (event) ->
    remove_status("p#price_dollars","How much are you asking for?")

  $(".price_dollars").blur (event) ->
    check_dollar_field(@value)
      
  $("button#sell-form-required-button").click (event) -> 
    if $("button#sell-form-required-button").hasClass("enabled")
      $("#sell-form-required").fadeOut "slow", ->
        $("#sell-form-required").css("display","none")
        $("#sell-form-optional").css("display","block")
  
  $("body").delegate "button#sell-form-optional-button", "click", (event) ->
    $("#sell-form-optional").fadeOut "slow", ->
      $("#sell-form-optional").css("display","none")
      $("#sell-form-final").css("display","block")
      
  $("body").delegate "button#sell-form-optional-final-button", "click", (event) ->
    if $("button#sell-form-optional-final-button").hasClass("enabled")
      $("button#sell-form-optional-final-button").removeClass("enabled")
      $("button#sell-form-optional-final-button").addClass("disabled")
      $("#sell-form-optional").fadeOut "slow", ->
        $("#new_listing").submit()
        $(".loading").css "display","block"    
        
        
  $("body").delegate "button#sell-form-final-button", "click", (event) ->
    if $("button#sell-form-final-button").hasClass("enabled")
      $("button#sell-form-final-button").removeClass("enabled")
      $("button#sell-form-final-button").addClass("disabled")
      $("#sell-form-final").fadeOut "slow", ->
        $("#new_listing").submit()
        $(".loading").css "display","block"
                   

check_dollar_field = (value) ->
  if value*1 < 0
    add_error("p#price_dollars","Only positive values please!")
  else if value.length == 0
    add_error("p#price_dollars","Well, you have to enter something...")
  else unless is_int(value)
    add_error("p#price_dollars","You have to enter a number!")
  else if value.length <= 3
    add_success("p#price_dollars","Looks good!")
  else if value.length > 3
    add_success("p#price_dollars","Little greedy, don't ya think!?")

add_error = (element,message) ->
  $(element).parent().css("border", "1px solid #FF6161") 
  $(element).parent().css("background-color", "#FFA8A8")
  $(element).text(message)
  if element.indexOf("title") != -1
    TITLE_READY = false
  else if element.indexOf("author") != -1
    AUTHOR_READY = false
  else if element.indexOf("dollars") != -1
    PRICE_DOLLARS_READY = false
  
add_success = (element,message) ->
  $(element).parent().css("border", "1px solid #00B822") 
  $(element).parent().css("background-color", "#A2FF99")
  $(element).text(message) 
  if element.indexOf("title") != -1
    TITLE_READY = true
  else if element.indexOf("author") != -1
    AUTHOR_READY = true
  else if element.indexOf("dollars") != -1
    PRICE_DOLLARS_READY = true
  check_form()

remove_status = (element,message) ->
  $(element).css("display","block")
  $(element).parent().css("display", "block") 
  $(element).parent().css("border", "1px solid #5691A9") 
  $(element).parent().css("background-color", "#8DD8EA")
  $(element).text(message) 

clear_form = () ->
  $("#title_checker").val('')
  $("#author_checker").val('')
  $("#new_listing_title").val('')
  $("#new_listing_author").val('')
  $(".book_title").val('')
  $("#dollas").val("")
  $("#cents").val(".00")
  $("#user_listings_attributes_0_edition").val("")
  $("#user_listings_attributes_0_isbn").val("")
  $("#user_listings_attributes_0_description").val("")
  $("#user_listings_attributes_0_condition").val("---Condition---")

check_form = () ->
  if TITLE_READY and AUTHOR_READY and PRICE_DOLLARS_READY
    $("button#sell-form-required-button").removeClass("disabled") 
    $("button#sell-form-required-button").addClass("enabled")
  else
    $("button#sell-form-required-button").removeClass("enabled")
    $("button#sell-form-required-button").addClass("disabled")
    

is_int = (value) ->
  if (parseFloat(value) is parseInt(value)) and not isNaN(value)
    true
  else
    false

  



