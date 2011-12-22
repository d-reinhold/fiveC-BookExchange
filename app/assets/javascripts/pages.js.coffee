# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
EMAIL_READY = false
TITLE_READY = false
AUTHOR_READY = false
PRICE_READY = false
NAME_READY = false
PASSWORD_READY = false
CPASSWORD_READY = false

$(document).ready ->
  $("#user_email").val("")
  $("#user_name").val("")
  $("#user_listings_attributes_0_title").val('')
  $("#user_listings_attributes_0_author").val('')
  $("#dollas").val("")
  $("#cents").val("")
  $("#user_listings_attributes_0_edition").val("")
  $("#user_listings_attributes_0_isbn").val("")
  $("#user_listings_attributes_0_description").val("")
  $("#user_listings_attributes_0_condition").val("---Condition---")
  check_form()
  
  
  $("a#buttons-search").css("border-top", "20px solid #335ED4")
  $("a#buttons-search").css("border-left", "40px solid #335ED4")
  $("a#buttons-search").css("border-right", "40px solid #335ED4")
  $("a#buttons-search").css("background-color", "#335ED4")
  $("a#buttons-sell").css("border-top", "20px solid #11379E") 
  $("a#buttons-sell").css("border-left", "40px solid #11379E")
  $("a#buttons-sell").css("border-right", "40px solid #11379E")
  $("a#buttons-sell").css("background-color", "#11379E")

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
    
  
    
  $("#user_email").focus (event) ->
    remove_status("p#email","Enter your 5C email address here!")
    
  $("#user_email").blur (event) ->
    unless @value.indexOf('pomona.edu') == -1
      add_success("p#email","Great!")
    else
      add_error("p#email","Sorry, that's not a valid 5C email address!") 
      
      
  $("#user_listings_attributes_0_title").focus (event) ->
    remove_status("p#title","Enter the title of your book here!")

  $("#user_listings_attributes_0_title").blur (event) ->
    if @value.length > 0
      add_success("p#title","Awesome, thanks!") 
    else
      add_error("p#title","Don't forget to enter a title!")
      
      
  $("#user_listings_attributes_0_author").focus (event) ->
    remove_status("p#author","Now tell me the author!")
   
  $("#user_listings_attributes_0_author").blur (event) ->
    if @value.length > 0
      add_success("p#author","Got it!")
    else
      add_error("p#author","Wait, who's the author?")

      
  $("#dollas").focus (event) ->
    remove_status("p#price","How much are you asking for?")
    
  $("#dollas").blur (event) ->
    if @value.length == 0
      add_error("p#price","Well, you have to enter something...")
    else if @value.length == 1 
      add_success("p#price","Bet you could get more than that...")
    else if @value.length <= 3
      add_success("p#price","Perfect")
    else if @value.length > 3
      add_success("p#price","Little greedy, don't ya think!?")

      
  $("a#sell-form-required-button").click (event) ->
    event.preventDefault()  
    if $("a#sell-form-required-button").hasClass("enabled")
      alert "submitting email check"
      $("#check-email-form").submit() 
      
      $("#sell-form-required").fadeOut "slow", ->
        $("#sell-form-required").css("display","none")
        $("#sell-form-optional").css("display","block")
        
        
  $("#user_name").focus (event) ->
    remove_status("p#name","What's your name?")

  $("#user_name").blur (event) ->
    if @value.length > 0
      add_success("p#name","Thanks!")
    else
      add_error("p#name","What do people call you??") 

  $("#user_password").focus (event) ->
    remove_status("p#password","Enter a secure password.")

  $("#user_password").blur (event) ->
    if @value.length > 5
      add_success("p#password","Looks good!")
    else
      add_error("p#password","Sorry, passwords must be at least 6 characters long!") 

  $("#user_password_confirmation").focus (event) ->
    remove_status("p#password-confirm","Retype your password.")

  $("#user_password_confirmation").blur (event) ->
    if @value == $("#user_password").val() and @value != '' and @value.length > 5
      add_success("p#password-confirm","All set!")
    else
      add_error("p#password-confirm","The passwords don't seem to match!")

  $("a#sell-form-optional-button").click (event) ->
    event.preventDefault()  
    $("#sell-form-optional").fadeOut "slow", ->
      $("#sell-form-optional").css("display","none")
      $("#sell-form-final").css("display","block")

  $("a#sell-form-final-button").click (event) ->
    event.preventDefault() 
    if $("a#sell-form-final-button").hasClass("enabled")
      $("a#sell-form-final-button").removeClass("enabled")
      $("a#sell-form-final-button").addClass("disabled")
      $("#sell-form-required").fadeOut "slow", ->
        $("#new_user").submit()       
    
      


add_error = (element,message) ->
  $(element).parent().css("border", "1px solid #FF6161") 
  $(element).parent().css("background-color", "#FFA8A8")
  $(element).text(message)
  if element.indexOf("email") != -1
    EMAIL_READY = false
  else if element.indexOf("title") != -1
    TITLE_READY = false
  else if element.indexOf("author") != -1
    AUTHOR_READY = false
  else if element.indexOf("price") != -1
    PRICE_READY = false
  else if element.indexOf("name") != -1
    NAME_READY = false
  else if element == "p#password"
    PASSWORD_READY = false
  else if element == "p#password-confirm"
    CPASSWORD_READY = false
  check_form()
 
  
add_success = (element,message) ->
  check_form()
  $(element).parent().css("border", "1px solid #00B822") 
  $(element).parent().css("background-color", "#A2FF99")
  $(element).text(message) 
  if element.indexOf("email") != -1
    EMAIL_READY = true
  else if element.indexOf("title") != -1
    TITLE_READY = true
  else if element.indexOf("author") != -1
    AUTHOR_READY = true
  else if element.indexOf("price") != -1
    PRICE_READY = true
  else if element.indexOf("name") != -1
    NAME_READY = true
  else if element == "p#password"
    PASSWORD_READY = true
  else if element == "p#password-confirm"
    CPASSWORD_READY = true
  check_form()


remove_status = (element,message) ->
  $(element).css("display","block")
  $(element).parent().css("border", "none") 
  $(element).parent().css("background-color", "#85B1F2")
  $(element).text(message) 
  
check_form = () ->
  if EMAIL_READY and TITLE_READY and AUTHOR_READY and PRICE_READY 
    $("a#sell-form-required-button").removeClass("disabled") 
    $("a#sell-form-required-button").addClass("enabled")
  else
    $("a#sell-form-required-button").removeClass("enabled")
    $("a#sell-form-required-button").addClass("disabled")
  if NAME_READY and PASSWORD_READY and CPASSWORD_READY
    $("a#sell-form-final-button").removeClass("disabled") 
    $("a#sell-form-final-button").addClass("enabled")
  else 
    $("a#sell-form-final-button").removeClass("enabled") 
    $("a#sell-form-final-button").addClass("disabled")

  
validate_email = () ->
  



