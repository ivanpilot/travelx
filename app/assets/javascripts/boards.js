// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$(function(){

  // console.log("hi")

  $(":button#js-button").click(function(e){
    // e.preventDefault();
    // alert("stop")

    console.log($(this));
  });

  // $("#circle").on("click", function(event){
  //   console.log($(this))
  //   $("js-add-activity").html()
  // })


})
// $( ":button#js-button" ).submit(function( event ) {
//   alert( "Handler for .submit() called." );
//   event.preventDefault();
// });
