$(function(){

  // ********** JS FUNCTION FOR BOARDS CONTROLLER INDEX VIEW ONLY **********
  if($(".boards-index").length == 1){
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
  }

  // ********** JS FUNCTION FOR BOARDS CONTROLLER SHOW VIEW ONLY **********
  if($(".boards-show").length == 1){
    console.log("hello")

    window.addEventListener('popstate', function(event) {
      loadTemplate(event.state)
    });

    var pathSection = window.location.pathname.split("/").slice(1,2)

    if(isUserNestedPath(pathSection)){
      var userId = window.location.pathname.split("/").slice(2,3)

      $.get('/users/' + userId + '/boards.json', function(data){
        var listBoards = data.map( board => board.id )
        var initBoard = $("#board-title").data("id")
        var newPath;
        displayPreviousNextBoardButtons(initBoard, listBoards)

        $("button#previous-board").click(function(e){
          e.preventDefault();
          initBoard = getPreviousBoardId(initBoard, listBoards);
          newPath = "/users/" + userId + "/boards/" + initBoard + ".json"
          loadBoardInfo(newPath, initBoard, userId);
          displayPreviousNextBoardButtons(initBoard, listBoards);
        });

        $("button#next-board").click(function(e){
          e.preventDefault();
          initBoard = getNextBoardId(initBoard, listBoards);
          newPath = "/users/" + userId + "/boards/" + initBoard + ".json"
          loadBoardInfo(newPath, initBoard, userId);
          displayPreviousNextBoardButtons(initBoard, listBoards);
        });
      });
    } else {
      $.get('/boards.json', function(data){
        var listBoards = data.map( board => board.id )
        var initBoard = $("#board-title").data("id")
        var newPath;
        displayPreviousNextBoardButtons(initBoard, listBoards)

        $("button#previous-board").click(function(e){
          e.preventDefault();
          initBoard = getPreviousBoardId(initBoard, listBoards);
          newPath = "/boards/" + initBoard + ".json"
          loadBoardInfo(newPath, initBoard);
          displayPreviousNextBoardButtons(initBoard, listBoards);
        });

        $("button#next-board").click(function(e){
          e.preventDefault();
          initBoard = getNextBoardId(initBoard, listBoards);
          newPath = "/boards/" + initBoard + ".json"
          loadBoardInfo(newPath, initBoard);
          displayPreviousNextBoardButtons(initBoard, listBoards);
        });
      });
    }
  }

});


function isUserNestedPath(path){
  return path == "users" ? true : false
}

function loadBoardInfo(path, boardId, userVisited){
  $.get(path, function(data){
    history.pushState(data, null, boardId)
    loadTemplate(data, userVisited);
  });
}

function loadTemplate(object, userVisited){
  console.log("THIS IS THE OBJECT.... ", object)

  //display the board based on authorization from Pundit (see board serializer)
  $("#board-title").html("<h2>" + object.title + "</h2>")
  var stringBoard = "";
  if(object.is_authorized_edit_board){
    stringBoard += `<a data-method="get" href="/boards/${object.id}/edit">Edit title</a>`
  }
  if(object.is_authorized_destroy_board){
    stringBoard += `<a data-confirm="Are you sure?" rel="nofollow" data-method="delete" href="/boards/${object.id}">Delete board</a>`
  }
  $("#board-edit-delete").text("")
  $("#board-edit-delete").html(stringBoard)


  //display the activities based on authorization from Pundit (see activity serializer)
  var stringActivity = '<ol>'
  var boardActivity = object.board_activities[0]
  var activity;
  var importLink;
  for (let i = 0, l = object.activities.length; i < l; i ++){
    activity = object.activities[i]
    importLink = userVisited ? `<a data-method="post" href="/users/${object.user_id}/activities/${activity.id}/import">| Import</a>` : ""
    stringActivity += `<li>Description: ${activity.description} | Rating: ${activity.rating}</li><a href="/activities/${activity.id}/edit">| Edit </a><a data-confirm="This will delete the activity from the board only. Are you sure?" rel="nofollow" data-method="delete" href="/board_activities/${boardActivity.id}">| Delete </a>`
    stringActivity += importLink
  }
  stringActivity += '</ol>'
  $("#display-activities").text("")
  $("#display-activities").html(stringActivity)
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
