// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/


let boards;
// debugger
$(function(){

  // ********** JS FUNCTION FOR BOARDS CONTROLLER INDEX VIEW ONLY **********
  if($("body").has(".boards-index")){
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
          resetFormFields()
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
  }

  // ********** JS FUNCTION FOR BOARDS CONTROLLER SHOW VIEW ONLY **********
  if($("body").has(".boards-show")){

    loadBoardIds();


// isCurrentBoardFirstBoard(currentBoardId, akal)

    // $("button#previous-board").on("click", function(event){
    //   console.log("you clicked")
    //   var $boardId = $(this).data("id")
    //   // loadBoardIds();
    //
    //
    // });

  }

});


function loadBoardIds(){
  $.get('/boards.json', function(data){
    var ids = data.map( element => element.id )
    // debugger
    boards = ids
    // sendBoardIds(ids);
    // debugger
    var currentBoardId = $("#board-title").data("id")
    // debugger
    if(isCurrentBoardFirstBoard(currentBoardId, boards)){
      // debugger
      console.log("yes first one")
    }
  });
}

// function sendBoardIds(data){
//   woke = data;
//   // debugger
// }

function isCurrentBoardFirstBoard(currentBoard, boards){
  // debugger
  return currentBoard === boards[0] ? true : false;
}

// function isCurrentBoardLastBoard(currentBoardId, boardIds){
//   return currentBoardId === boardIds[-1] ? true : false;
// }


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

function resetFormFields(){
  var descriptionField = $("input.description-field")
  var ratingField = $("input.rating-field")

  $("input.title-field")[0].value = ""
  for (let i = 0, l = descriptionField.length; i < l; i++){
    descriptionField[i].value = ""
  }
  for (let i = 0, l = ratingField.length; i < l; i++){
    ratingField[i].value = ""
  }
}
