# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "json"

movies_file = File.read("t_movies.json")
tvs_file = File.read("t_tvs.json")
providers_file = File.read("t_providers.json")
movies = JSON.parse(movies_file)
tvs = JSON.parse(tvs_file)
providers = JSON.parse(providers_file)

puts "Cleaning up db"
Movie.destroy_all
Tv.destroy_all
User.destroy_all
Provider.destroy_all
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

tvs["results"].each do |tv|
  Tv.create(
    title: tv["name"],
    overview: tv["overview"],
    poster_url: "https://image.tmdb.org/t/p/w780#{tv["poster_path"]}",
    backdrop_url: "https://image.tmdb.org/t/p/w1280#{tv["backdrop_path"]}",
    rating_average: tv["vote_average"],
    tmdb_id: tv["id"],
    country: tv["origin_country"],
    first_air_date: tv["first_air_date"]
  )
end

puts "Tvs Created"

providers.each do |provider|
  Provider.create(
    provider_name: provider["name"],
    logo_path: provider["logo_100px"],
    ios_appstore_url: provider["ios_appstore_url"],
    android_playstore_url: provider["android_playstore_url"],
  )
end

puts "Providers created"

User.create(
  email: "sebas@treano.com",
  password: "123456",
  username: "Sebs",
  first_name: "Sebastian",
  last_name: "Navarro",
  country: "Colombia",
  bio: "Movies are my passion",
  reputation_score: 0
)
User.create(
  email: "meerim@treano.com",
  password: "123456",
  username: "Meer",
  first_name: "Meerim",
  last_name: "Asylbekova",
  country: "Kyrgyzstan",
  bio: "Movies are my passion",
  reputation_score: 0
)

puts "Users created"

#all_file = File.read("t_all_movies.json")
#all = JSON.parse(all_file)
#all = JSON[all_file].sort_by{ |x| x['popularity'].to_f }
#puts all.first(20)
