Design / CSS
  [X] create a better welcome page with js-css so we can swith to login / sign up form
  [X] create 'add activity' button on board index view to add ass many activities simultaneously with the creation of a board
  [X] improve the navbar design
  [X] improve left side of navbar when visiting a friend
  [X] add where necessary an id or class to div or other element to be able to identify specific element with jquery and append information to the DOM

BoardsController #index
  [X] allow user to add several activities simultaneously with the creation of a board
    [X] create a Handlebars template to add more activity fields when user click on the '+' button
    [X] use Ajax to submit the form to create a board with activities
    [X] hijack the submit button of the form
    [X] post the data within the form to the create action of the BoardsController
    [X] make sure the create action can handle json format
    [X] build the done function once the data are received back from the server
    [X] add the fail function to handle situation where the board and activities couldn't be created

  [X] add the new board created to the list of boards displayed on the index page without refreshing / reloading the page
    [X] within the done function of the Ajax request, add a function to append the new board to the DOM
    [X] use handlebars template to display this new board

  [X] show the latest board created on the page with its associated activities if any
    [X] within the done function of the Ajax request, add a function to append the new board and its associated activities just created to the DOM
    [X] use handlebars template to display the new board and its activities

BoardsController #show
  [X] add a previous and next button allowing user to navigate through various board without going back to the index page
  [X] use Active Model Serializer to select the information and relationship between objects that should be available
  [X] make sure the #show action accepts json format
  [X] require to load all the board of the current user to know which one would be next and which one would be the previous one
  [X] use Ajax to display next and previous board with its respective associated activities
  [X] define additional method within Serializer class to pass on the authorization defined by Pundit for editing, destroying and importing activities and boards
  [X] update the url by using pushState method and make sure that user experience is good when clicking on next/previous page in the browser

  [X] define a Board constructor to create board object
  [X] define an Activity constructor to create activity object
    [X] define a prototype method accessible to all activity object to display the list of activities when navigating through other boards

  [X] make sure all the above work whether user is navigating through its own board and activities or through his friends boards and activities

Login with oauth facebook
[X] make sure it is still working
