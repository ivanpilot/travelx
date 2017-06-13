// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$(function(){

  // ********** JS FUNCTION FOR BOARDS CONTROLLER INDEX VIEW ONLY **********
  $(document).on("turbolinks:load", function() {
    if (!($(".boards-index").length > 0)) {
      return;
    }

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
    });
  });

  // ********** JS FUNCTION FOR BOARDS CONTROLLER SHOW VIEW ONLY **********
  $(document).on("turbolinks:load", function() {
    if (!($(".boards-show").length > 0)) {
      return;
    }
    // var currentBoardId = $("#board-title").data("id")
    // checkIfCurrentBoardIsFirstOrLast(currentBoardId);
    // showNextBoard(currentBoardId);

    var currentBoardId = $("#board-title").data("id")
    $.get('/boards.json', function(data){
      var boardIds = data.map( element => element.id )
      displayPreviousNextBoard(currentBoardId, boardIds)



    });
  });
});


function showNextBoard(currentBoardId){
  var nextBoardId = currentBoardId + 1
  debugger
  $.get("/boards/" + nextBoardId + ".json", function(data){
    console.log(data)
  })
}

function CurrentBoardPosition(currentBoardId, boards){
  for (let i = 0, l = boards.length; i < l; i++){
    if(currentBoardId === boards[i]){
      return i;
    }
  }
}

function nextBoardId(currentBoardId, boards){
  var position = CurrentBoardPosition(currentBoardId, boards)
  return boards[position + 1]
}

function previousBoardId(currentBoardId, boards){
  var position = CurrentBoardPosition(currentBoardId, boards)
  return boards[position - 1]
}


// function checkIfCurrentBoardIsFirstOrLast(currentBoardId){
//   $.get('/boards.json', function(data){
//     var boardIds = data.map( element => element.id )
//     displayPreviousNextBoard(currentBoardId, boardIds)
//   });
// }

function displayPreviousNextBoard(currentBoard, boards){
  // debugger
  if(!isCurrentBoardFirstBoard(currentBoard, boards)){
    $("button#previous-board").removeClass("is-not-visible")
  }
  if(!isCurrentBoardLastBoard(currentBoard, boards)){
    $("button#next-board").removeClass("is-not-visible")
  }
}

function isCurrentBoardFirstBoard(currentBoard, boards){
  return currentBoard === boards[0] ? true : false;
}

function isCurrentBoardLastBoard(currentBoardId, boards){
  // debugger
  return currentBoardId === boards[boards.length - 1] ? true : false;
}


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
