// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$(function(){

  $("form#board-form").submit(function(e){
    e.preventDefault();

    // $.post()
    // console.log("this is ...", $(this));
    // console.log($(this).attr("action"))
    // console.log($(this).serialize())

    var $form = $(this);
    var action = $form.attr("action");
    var params = $form.serialize();
    // var data = $(this)[0].form;

    $.ajax({
      type: "POST",
      url: action,
      data: params,
    }).done(function(response){
      console.log(response)
      alert("it is working")
    });
    // console.log($(this)[0].form.action);
    // console.log($(this)[0].form.method);
  });

  $("#circle").on("click", function(event){
    var source = $("#js_add_activity_template").html();
    var template = Handlebars.compile(source);
    $("#add-activity-field").append(template())
  })
})
// $( ":button#js-button" ).submit(function( event ) {
//   alert( "Handler for .submit() called." );
//   event.preventDefault();
// });
