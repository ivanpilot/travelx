General
[X] Generate the resources (models, controllers, views, database tables)
[X] Create table/ model relationships
[X] Create the rspec for the models
[X] Create the relationships between models to pass the rspec
[X] Create login system with and session controllers
[X] Create a login system via Facebook with the oauth
[X] Create a sign_up system via own sign_up process
[X] Create a logout functionality
[X] Create a seed file to seed the database with dummy data to be able to work on concrete example

Authorisation
[X] Install Pundit
[X] Create a context for pundit
[X] Add a display authorisation for view based and using pundit
[X] Add a activity policy
[X] check if activity policy working well
[X] Add a board policy
[X] check if board policy working well
[X] using pundit in the view for activities
[X] using pundit in the view for boards

Board
[X] Create a board index page that will be the landing page once logged in
  [X] Add the possibility to simply add an activity not related to a board from that page
  [X] Add the possibility to create a board with nested activity
  [X] Add the possibility to view the boards
[X] Edit and Delete a board
[ ] Fix the creation of a board with appropriate actions depending if user or admin
[ ] Modify create action and helper method so factor in case where admin is creating an activity on behalf of a user

Activity
[X] Create a activity index page
  [X] Add the possibility to create an activity not related to a board from that page
  [X] Add the possibility to view the activities and to which boards each of them is related
  [X] Be able to edit and delete an activity
[X] add a button to switch from standard user to an admin user (development phase of the website)
[ ] Fix the creation of a activity with appropriate actions depending if user or admin
[ ] Modify create action and helper method so factor in case where admin is creating an activity on behalf of a user

BoardActivity
[ ] Create authorisation for destroy action within BoardActivity controller
[ ] Create the appropriate route
  [ ] Choose if should be only 1 or 2 routes including a nested one
[ ] Implement helper for deleting a BoardActivity relationship within the show view of a board

Friend
[X] Create the user / friends model and relationships
[X] Add / delete friends
[X] Visit the boards page of friends
[X] Visit the activity page of friends - board
[ ] Visit the activity page of friends - activities
[ ] Transfer an activity from a friend to your own board (duplicating the activity)

Admin
[ ] Create admin resources with namespace routes
[ ] Allow admin user to do everything a user can do and to take control of a user account including deleting a user account
