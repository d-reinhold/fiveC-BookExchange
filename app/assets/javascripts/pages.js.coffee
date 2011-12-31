# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
EMAIL_READY = false
TITLE_READY = false
AUTHOR_READY = false
PRICE_DOLLARS_READY = false
PRICE_CENTS_READY = false
NAME_READY = false
PASSWORD_READY = false
CPASSWORD_READY = false

$(document).ready ->
  $("#user_email").val("")
  $("#user_name").val("")
  $("#user_password").val("")
  $("#user_password_confirmation").val("")
  $("#email_checker").val("")
  $("#name_checker").val("")
  $("#title_checker").val('')
  $("#author_checker").val('')
  $("#user_listings_attributes_0_title").val('')
  $("#user_listings_attributes_0_author").val('')
  $("#price_dollars_checker").val('')
  $("#price_cents_checker").val('')
  $("#dollas").val("")
  $("#cents").val("")
  $("#user_listings_attributes_0_edition").val("")
  $("#user_listings_attributes_0_isbn").val("")
  $("#user_listings_attributes_0_description").val("")
  $("#user_listings_attributes_0_condition").val("---Condition---")
  check_form()


  $("a#buttons-sell").click (event) ->
    $("#search-for-books").css("display","none")
    $("#sell-your-books").css("display","block")
    $("a#buttons-search").css("border-top", "20px solid #11379E")
    $("a#buttons-search").css("border-left", "40px solid #11379E")
    $("a#buttons-search").css("border-right", "40px solid #11379E")
    $("a#buttons-search").css("background-color", "#11379E")
    $("a#buttons-sell").css("border-top", "20px solid #578BF2")
    $("a#buttons-sell").css("border-left", "40px solid #578BF2")
    $("a#buttons-sell").css("border-right", "40px solid #578BF2")
    $("a#buttons-sell").css("background-color", "#578BF2")
    event.preventDefault()

  $("a#buttons-search").click (event) ->
    $("#sell-your-books").css("display","none")
    $("#search-for-books").css("display","block")
    $("a#buttons-sell").css("border-top", "20px solid #11379E") 
    $("a#buttons-sell").css("border-left", "40px solid #11379E")
    $("a#buttons-sell").css("border-right", "40px solid #11379E")
    $("a#buttons-sell").css("background-color", "#11379E")
    $("a#buttons-search").css("border-top", "20px solid #578BF2")
    $("a#buttons-search").css("border-left", "40px solid #578BF2")
    $("a#buttons-search").css("border-right", "40px solid #578BF2")
    $("a#buttons-search").css("background-color", "#578BF2")
    event.preventDefault()
    
    
  $("body").delegate "button.fancy_button", "click", (event) ->
    event.preventDefault()
    
  $("body").delegate "button#search-button", "click", (event) ->
    $("form#search").submit()
  

  $("#email_checker").focus (event) ->
    remove_status("p#email","What's your 5C email address?")
    
  $("#email_checker").blur (event) ->
    if @value == ''
      add_error("p#email","Email can't be blank!")
    else if @value.indexOf('pomona.edu') != -1 or @value.indexOf('hmc.edu') != -1 or @value.indexOf('pitzer.edu') != -1 or @value.indexOf('cmc.edu') != -1 or @value.indexOf('scrippscollege.edu') != -1
      add_success("p#email","Great!")
    else
      add_error("p#email","Sorry, that's not a 5C email address!") 
      
      
  $(".book_title").focus (event) ->
    remove_status("p#title","What book are you selling?")

  $(".book_title").blur (event) ->
    if @value.length > 0
      add_success("p#title","Awesome, thanks!") 
    else
      add_error("p#title","Don't forget to enter a title!")
      
      
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
    
  $(".price_cents").focus (event) ->
    remove_status("p#price_cents","How much are you asking for?")
      
  $(".price_cents").blur (event) ->
    check_cents_field(@value)      

      
  $("button#sell-form-required-button").click (event) -> 
    if $("button#sell-form-required-button").hasClass("enabled")
      $("#check-email-form").submit() 
      
  $("button#sell-form-signed-in-required-button").click (event) -> 
    if $("button#sell-form-signed-in-required-button").hasClass("enabled")
      $("#sell-form-required").fadeOut "slow", ->
        $("#sell-form-required").css("display","none")
        $("#sell-form-optional").css("display","block")

      
      
      
    
        
  $("body").delegate "#user_name", "focus", (event) ->
    remove_status("p#name","What's your name?")

  $("body").delegate "#user_name", "blur", (event) ->
    if @value.length > 0
      add_success("p#name","Thanks!")
    else
      add_error("p#name","What do people call you??") 

  $("body").delegate  "#user_password", "focus", (event) ->
    remove_status("p#password","Enter a secure password.")
    remove_status("p#password-signin","Enter your password.")

  $("body").delegate "#user_password", "blur", (event) ->
    if @value == ''
      add_error("p#password","Password can't be blank!")     
      add_error("p#password-signin","Password can't be blank!")   
    if @value.length > 5
      add_success("p#password","Looks good!")
      add_success("p#password-signin","Looks good!")
    else
      add_error("p#password","Passwords must be at least 6 characters long!") 
      add_error("p#password-signin","Passwords must be at least 6 characters long!") 

  $("body").delegate "#user_password_confirmation", "focus", (event) ->
    remove_status("p#password-confirm","Retype your password.")

  $("body").delegate "#user_password_confirmation", "blur", (event) ->
    if @value == $("#user_password").val() and @value != '' and @value.length > 5
      add_success("p#password-confirm","All set!")
    else
      add_error("p#password-confirm","The passwords don't seem to match!")

  $("body").delegate "button#sell-form-optional-button", "click", (event) ->
    $("#sell-form-optional").fadeOut "slow", ->
      $("#sell-form-optional").css("display","none")
      $("#sell-form-final").css("display","block")

  $("body").delegate "button#sell-form-final-signup-button", "click", (event) ->
    if $("button#sell-form-final-signup-button").hasClass("enabled")
      $("button#sell-form-final-signup-button").removeClass("enabled")
      $("button#sell-form-final-signup-button").addClass("disabled")
      $("#new_user input#user_email").val($("#check-email-form input#email_checker").val())
      $("#new_user input#user_listings_attributes_0_title").val($("#check-email-form input#title_checker").val())
      $("#new_user input#user_listings_attributes_0_author").val($("#check-email-form input#author_checker").val())
      $("#new_user input#user_listings_attributes_0_price_dollars").val($("#check-email-form input#price_dollars_checker").val())
      $("#new_user input#user_listings_attributes_0_price_cents").val($("#check-email-form input#price_cents_checker").val())
      $("#new_user").submit()
      $("#sell-form-final").fadeOut "slow", ->
        
      
  $("body").delegate "button#sell-form-signed-in-final-button", "click", (event) ->
    if $("button#sell-form-signed-in-final-button").hasClass("enabled")
      $("button#sell-form-signed-in-final-button").removeClass("enabled")
      $("button#sell-form-signed-in-final-button").addClass("disabled")
      $("#sell-form-optional").fadeOut "slow", ->
        $("#new_listing").submit()

        
        
  $("body").delegate "button#sell-form-final-signin-button", "click", (event) ->
    if $("button#sell-form-final-signin-button").hasClass("enabled")
      #$("a#sell-form-final-signin-button").removeClass("enabled")
      #$("a#sell-form-final-signin-button").addClass("disabled")
      $("#new_listing input#listing_title").val($("#check-email-form input#title_checker").val())
      $("#new_listing input#listing_author").val($("#check-email-form input#author_checker").val())
      $("#new_listing input#listing_price_dollars").val($("#check-email-form input#price_dollars_checker").val())
      $("#new_listing input#listing_price_cents").val($("#check-email-form input#price_cents_checker").val())
      $("#authenticate-form input#email").val($("#check-email-form input#email_checker").val())
      $("#authenticate-form").submit()
         

check_dollar_field = (value) ->
  if value.length == 0
    add_error("p#price_dollars","Well, you have to enter something...")
  else unless is_int(value)
    add_error("p#price_dollars","You have to enter a number!")
  else if value.length == 1
    add_success("p#price_dollars","Bet you could get more than that...")
  else if value.length <= 3
    add_success("p#price_dollars","Looks good!")
  else if value.length > 3
    add_success("p#price_dollars","Little greedy, don't ya think!?")
    
check_cents_field = (value) ->
  if value.length == 0
    add_error("p#price_cents","Well, you have to enter something...")
  else if value.length == 1
    add_error("p#price_cents","Please enter 2 digits (03, 59, etc).")
  else unless is_int(value)
    add_error("p#price_cents","You have to enter a number!")
  else if value.length >= 3
    add_error("p#price_cents","What?!")
  else if value.length < 3
    add_success("p#price_cents","Looks good!")

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
  else if element.indexOf("dollars") != -1
    $(element).css("display", "block")
    $("p#price_cents").css("display","none")
    PRICE_DOLLARS_READY = false
  else if element.indexOf("cents") != -1
    $(element).css("display", "block")
    $("p#price_dollars").css("display","none")
    PRICE_CENTS_READY = false
  else if element.indexOf("name") != -1
    NAME_READY = false
  else if element == "p#password" or element == "p#password-signin"
    PASSWORD_READY = false
  else if element == "p#password-confirm"
    CPASSWORD_READY = false
 
  
add_success = (element,message) ->
  $(element).parent().css("border", "1px solid #00B822") 
  $(element).parent().css("background-color", "#A2FF99")
  $(element).text(message) 
  if element.indexOf("email") != -1
    EMAIL_READY = true
  else if element.indexOf("title") != -1
    TITLE_READY = true
  else if element.indexOf("author") != -1
    AUTHOR_READY = true
  else if element.indexOf("dollars") != -1
    $(element).css("display", "block")
    $("p#price_cents").css("display","none")
    PRICE_DOLLARS_READY = true
  else if element.indexOf("cents") != -1
    $(element).css("display", "block")
    $("p#price_dollars").css("display","none")
    PRICE_CENTS_READY = true
  else if element.indexOf("name") != -1
    NAME_READY = true
  else if element == "p#password" or element == "p#password-signin"
    PASSWORD_READY = true
  else if element == "p#password-confirm"
    CPASSWORD_READY = true
  check_form()


remove_status = (element,message) ->
  $(element).css("display","block")
  $(element).parent().css("display", "block") 
  $(element).parent().css("border", "1px solid #85B1F2") 
  $(element).parent().css("background-color", "#85B1F2")
  $(element).text(message) 
  if element.indexOf("dollars") != -1
    $("p#price_cents").parent().css("display","none")
  else if element.indexOf("cents") != -1
     $("p#price_dollars").parent().css("display","none")
  
check_form = () ->
  if PASSWORD_READY
    $("button#sell-form-final-signin-button").removeClass("disabled") 
    $("button#sell-form-final-signin-button").addClass("enabled")
  if TITLE_READY and AUTHOR_READY and PRICE_DOLLARS_READY and PRICE_CENTS_READY
    $("button#sell-form-signed-in-required-button").removeClass("disabled") 
    $("button#sell-form-signed-in-required-button").addClass("enabled")
    if EMAIL_READY
      $("button#sell-form-required-button").removeClass("disabled") 
      $("button#sell-form-required-button").addClass("enabled")
    else 
      $("button#sell-form-required-button").removeClass("enabled")
      $("button#sell-form-required-button").addClass("disabled")
  else
    $("button#sell-form-required-button").removeClass("enabled")
    $("button#sell-form-required-button").addClass("disabled")
    $("button#sell-form-signed-in-required-button").removeClass("enabled") 
    $("button#sell-form-signed-in-required-button").addClass("disabled")
  if NAME_READY and PASSWORD_READY and CPASSWORD_READY
    $("button#sell-form-final-signup-button").removeClass("disabled") 
    $("button#sell-form-final-signup-button").addClass("enabled")
  else 
    $("button#sell-form-final-signup-button").removeClass("enabled") 
    $("button#sell-form-final-signup-button").addClass("disabled")

is_int = (value) ->
  if (parseFloat(value) is parseInt(value)) and not isNaN(value)
    true
  else
    false

  



