# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'net/http'
require 'open-uri'
require 'rest-client'
require 'json'

movies_file = File.read("t_full_movies_2.json")
tvs_file = File.read("watchmode_tvs.json")
providers_file = File.read("t_providers.json")
movies = JSON.parse(movies_file)
tvs = JSON.parse(tvs_file)
providers = JSON.parse(providers_file)


#PLEASE DO NOT UNCOMMENT this method is for create a json with all the info related to movies
#movies_group = movies["titles"][125..249]
#full_movies = []
#movies_group.each_with_index do |movie, i|
  #uri_tmdb = URI("https://api.themoviedb.org/3/movie/#{movie["tmdb_id"].to_s}?api_key=43f195cad08ed475966231cae7ae844e&language=en-US&append_to_response=credits,videos,images,reviews,keywords,recommendations,similar")
  #response_tmdb = Net::HTTP.get(uri_tmdb)
  #result_tmdb = JSON.parse(response_tmdb)
  #puts "#{i} tmdb responsed"

  #uri_watchmode = URI("https://api.watchmode.com/v1/title/#{movie["id"].to_s}/details/?apiKey=Cr5gip77ClZJLYijZe8xdg2JLdishE3AmHc3E88K&append_to_response=sources")
  #response_watchmode = Net::HTTP.get(uri_watchmode)
  #result_watchmode = JSON.parse(response_watchmode)
  #puts "#{i} watchmode responsed"
  
  #full_movies << [result_tmdb, result_watchmode]
  #puts "#{i} array pushed"
#end
#File.open("t_full_movies_1.json", "wb") do |file|
  #file.write(JSON.generate(full_movies))
#end
#puts "JSON created"


#PLEASE DO NOT UNCOMMENT this method is for create a json with all the info related to tvs
#tvs_group = tvs["titles"][125..249]
#full_tvs = []
#tvs_group.each_with_index do |tv, i|
  #uri_tmdb = URI("https://api.themoviedb.org/3/tv/#{tv["tmdb_id"].to_s}?api_key=43f195cad08ed475966231cae7ae844e&language=en-US&append_to_response=credits,videos,images,reviews,keywords,recommendations,similar")
  #response_tmdb = Net::HTTP.get(uri_tmdb)
  #result_tmdb = JSON.parse(response_tmdb)
  #puts "#{i} tmdb responsed"

  #uri_watchmode = URI("https://api.watchmode.com/v1/title/#{tv["id"].to_s}/details/?apiKey=Cr5gip77ClZJLYijZe8xdg2JLdishE3AmHc3E88K&append_to_response=sources")
  #response_watchmode = Net::HTTP.get(uri_watchmode)
  #result_watchmode = JSON.parse(response_watchmode)
  #puts "#{i} watchmode responsed"
  
  #full_tvs << [result_tmdb, result_watchmode]
  #puts "#{i} array pushed"
#end
#File.open("t_full_tvs_2.json", "wb") do |file|
  #file.write(JSON.generate(full_tvs))
#end
#puts "JSON created"






#puts "Cleaning up db"
#Movie.destroy_all
#Tv.destroy_all
#User.destroy_all
#Provider.destroy_all
#puts "Db cleaned"

#movies["results"].each do |movie|
  #Movie.create(
    #title: movie["title"],
    #overview: movie["overview"],
    #poster_url: "https://image.tmdb.org/t/p/w500#{movie["poster_path"]}",
    #backdrop_url: "https://image.tmdb.org/t/p/w1280#{movie["backdrop_path"]}",
    #rating_average: movie["vote_average"],
    #tmdb_id: movie["id"],
    #release_date: movie["release_date"]
  #)
#end

#puts "Movies Created"

#tvs["results"].each do |tv|
  #Tv.create(
    #title: tv["name"],
    #overview: tv["overview"],
    #poster_url: "https://image.tmdb.org/t/p/w500#{tv["poster_path"]}",
    #backdrop_url: "https://image.tmdb.org/t/p/w1280#{tv["backdrop_path"]}",
    #rating_average: tv["vote_average"],
    #tmdb_id: tv["id"],
    #country: tv["origin_country"],
    #first_air_date: tv["first_air_date"]
  #)
#end

#puts "Tvs Created"

#providers.each do |provider|
  #Provider.create(
    #provider_name: provider["name"],
    #logo_path: provider["logo_100px"],
    #ios_appstore_url: provider["ios_appstore_url"],
    #android_playstore_url: provider["android_playstore_url"],
  #)
#end

#puts "Providers created"

#User.create(
  #email: "sebas@treano.com",
  #password: "123456",
  #username: "Sebs",
  #first_name: "Sebastian",
  #last_name: "Navarro",
  #country: "Colombia",
  #bio: "Movies are my passion",
  #reputation_score: 0
#)
#User.create(
  #email: "meerim@treano.com",
  #password: "123456",
  #username: "Meer",
  #first_name: "Meerim",
  #last_name: "Asylbekova",
  #country: "Kyrgyzstan",
  #bio: "Movies are my passion",
  #reputation_score: 0
#)

#puts "Users created"

