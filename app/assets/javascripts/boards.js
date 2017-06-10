// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$(function(){

  $("form#board-form").submit(function(e){
    e.preventDefault();
    var $form = $(this);
    var action = $form.attr("action");
    var params = $form.serialize();

    $.ajax({
      type: "POST",
      url: action,
      data: params,
      dataType: "json"
    }).done(function(response){
      var board = {
        list: response
      }
      console.log(board.list)
      var source = $("#js-board-list-template").html();
      var template = Handlebars.compile(source);
      var result = template(board)
      $("ul#list-of-boards").append(result)
    });
  });

  $("#circle").on("click", function(event){
    var source = $("#js-add-activity-template").html();
    var template = Handlebars.compile(source);
    $("#add-activity-field").append(template())
  })
})
