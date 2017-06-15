// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$(function(){

  // ********** JS FUNCTION FOR BOARDS CONTROLLER INDEX VIEW ONLY **********
  // $(document).on("turbolinks:load", function() {
  //   if (!($(".boards-index").length > 0)) {
  //     return;
  //   }

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
  // });

  // ********** JS FUNCTION FOR BOARDS CONTROLLER SHOW VIEW ONLY **********
  // $(document).on("turbolinks:load", function() {
  //   if (!($(".boards-show").length > 0)) {
  //     return;
  //   }

    window.addEventListener('popstate', function(event) {
      loadHandlebarsTemplate(event.state)
    });


    $.get('/boards.json', function(data){
      var listBoards = data.map( board => board.id )
      var initBoard = $("#board-title").data("id")
      displayPreviousNextBoardButtons(initBoard, listBoards)

      $("button#previous-board").click(function(e){
        e.preventDefault();
        initBoard = getPreviousBoardId(initBoard, listBoards);
        loadBoardInfo(initBoard);
        displayPreviousNextBoardButtons(initBoard, listBoards);
      });

      $("button#next-board").click(function(e){
        e.preventDefault();
        initBoard = getNextBoardId(initBoard, listBoards);
        loadBoardInfo(initBoard);
        displayPreviousNextBoardButtons(initBoard, listBoards);
      });

      // $(".delete-board-activity").click(function(e){
      //   e.preventDefault;
      //   console.log($(this).attr("href"))
      //
      // })
    });
  // });

});


function loadBoardInfo(boardId){
  $.get("/boards/" + boardId + ".json", function(data){
    history.pushState(data, null, boardId)
    loadHandlebarsTemplate(data);
  });
}

function loadHandlebarsTemplate(object){
  $("#board-title").html("<h2>" + object.title + "</h2>")

  var boardEditDeleteTemplate = Handlebars.compile($("#js-board-edit-delete-template").html());
  $("#board-edit-delete").text("")
  $("#board-edit-delete").html(boardEditDeleteTemplate(object))

  var activitiesTemplate = Handlebars.compile($("#js-activities-template").html());
  $("#display-activities").text("")
  $("#display-activities").html(activitiesTemplate(object))
}

function CurrentBoardPosition(currentBoardId, boardIds){
  for (let i = 0, l = boardIds.length; i < l; i++){
    if(currentBoardId === boardIds[i]){
      return i;
    }
  }
}

function getNextBoardId(currentBoardId, boardIds){
  var position = CurrentBoardPosition(currentBoardId, boardIds)
  return boardIds[position + 1]
}

function getPreviousBoardId(currentBoardId, boardIds){
  var position = CurrentBoardPosition(currentBoardId, boardIds)
  return boardIds[position - 1]
}

function displayPreviousNextBoardButtons(currentBoardId, boardIds){
  if(!isCurrentBoardFirstBoard(currentBoardId, boardIds)){
    $("button#previous-board").removeClass("is-not-visible")
  } else {
    $("button#previous-board").addClass("is-not-visible")
  }
  if(!isCurrentBoardLastBoard(currentBoardId, boardIds)){
    $("button#next-board").removeClass("is-not-visible")
  } else {
    $("button#next-board").addClass("is-not-visible")
  }
}

function isCurrentBoardFirstBoard(currentBoardId, boardIds){
  return currentBoardId === boardIds[0] ? true : false;
}

function isCurrentBoardLastBoard(currentBoardId, boardIds){
  return currentBoardId === boardIds[boardIds.length - 1] ? true : false;
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
