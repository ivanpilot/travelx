// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$(function(){

  $("form#board-form").submit(function(e){
    e.preventDefault();
    var $form = $(this);
    var action = $form.attr("action") + ".json";
    var params = $form.serialize();

    $.ajax({
      type: "POST",
      url: action,
      data: params,
      dataType: "json"
    }).done(function(response){
      var board = response
      if(board.title !== ""){
        displayList(board)
        displayLatestBoard(board)
      }
    }).fail(function(message){
      console.log("there was an error: ", message)
    });
  });

  $("#circle").on("click", function(event){
    var source = $("#js-add-activity-template").html();
    var template = Handlebars.compile(source);
    $("#add-activity-field").append(template())
  })
})

function displayList(board){
  var templateList = Handlebars.compile($("#js-board-list-template").html());
  var displayList = templateList(board);
  $("ul#list-of-boards").append(displayList);
}

function displayLatestBoard(board){
  var templateLatestBoard = Handlebars.compile($("#js-latestboard-template").html());
  var displayLatestBoard = templateLatestBoard(board);
  $("#latest-board").html(displayLatestBoard);
}

function clearFormFields(){
  
}
