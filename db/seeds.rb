# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ivan = User.create(username: "Ivan", email: "ivanpilot@gmail.com", password: "password", password_confirmation: "password")
User.create(username: "James", email: "james@gmail.com", password: "password", password_confirmation: "password")
User.create(username: "Pierre", email: "pierre@gmail.com", password: "password", password_confirmation: "password")
jean = User.create(username: "Jean", email: "jean@gmail.com", password: "password", password_confirmation: "password")

ivan.activities.create(description: "Walk in Hyde Park during summer time", rating:"4")
ivan.activities.create(description: "Winter run for 10km around St Pauls and Trafalgar Square", rating:"5")
ivan.activities.create(description: "Lunch at the Alain Ducas Dorchester", rating:"5")
ivan.activities.create(description: "Epiphany cake from Lenotre in Paris", rating:"5")
jean.activities.create(description: "Cycling in the forest under the rain", rating:"5")
jean.activities.create(description: "Sharing amazing moments with friends during wakeboard", rating:"8")
jean.activities.create(description: "Wandering in Vancouver just because it is fun", rating:"5")

ivan.boards.create(title: "London Winter 2017")
ivan.boards.create(title: "Paris Winter 2017")
jean.boards.create(title: "2018 objectives")

Friendship.create(user_id:"1", friend_id:"4")

BoardActivity.create(board_id:"1", activity_id:"1")
BoardActivity.create(board_id:"1", activity_id:"2")
BoardActivity.create(board_id:"2", activity_id:"4")
BoardActivity.create(board_id:"3", activity_id:"5")
BoardActivity.create(board_id:"3", activity_id:"6")
BoardActivity.create(board_id:"3", activity_id:"7")
