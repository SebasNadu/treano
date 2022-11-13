# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "json"

file = File.read("movies.json")
movies = JSON.parse(file)
p movies["results"][0]["backdrop_path"]

puts "Cleaning up db"
Movie.destroy_all
puts "Db cleaned"

movies["results"].each do |movie|
  Movie.create(
    title: movie["title"],
    overview: movie["overview"],
    poster_url: "https://image.tmdb.org/t/p/w780#{movie["poster_path"]}",
    backdrop_url: "https://image.tmdb.org/t/p/w1280#{movie["backdrop_path"]}",
    rating_average: movie["vote_average"],
    tmdb_id: movie["id"],
    release_date: movie["release_date"]
  )
end

puts "Movies Created"

User.create(
  email: "sebas@treano.com",
  password: "123456",
  username: "Sebs",
  first_name: "Sebastian",
  last_name: "Navarro",
  country: "Colombia",
  bio: "Movies are my passion",
  reputation_score: 0,
)
User.create(
  email: "meerim@treano.com",
  password: "123456",
  username: "Meer",
  first_name: "Meerim",
  last_name: "Asylbekova",
  country: "Kyrgyzstan",
  bio: "Movies are my passion",
  reputation_score: 0,
)

puts "Users created"
