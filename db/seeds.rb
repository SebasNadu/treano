# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'net/http'
require 'open-uri'
require 'json'

movies_file_1 = File.read("t_full_movies_1.json")
movies_file_2 = File.read("t_full_movies_2.json")
movies_1 = JSON.parse(movies_file_1)
movies_2 = JSON.parse(movies_file_2)
tvs_file_1 = File.read("t_full_tvs_1.json")
tvs_file_2 = File.read("t_full_tvs_2.json")
tvs_1 = JSON.parse(tvs_file_1)
tvs_2 = JSON.parse(tvs_file_2)
providers_file = File.read("t_providers_US.json")
providers = JSON.parse(providers_file)


#PLEASE DO NOT UNCOMMENT!! this method is for create a json with all the info related to movies
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


#PLEASE DO NOT UNCOMMENT!! this method is for create a json with all the info related to tvs
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




puts "Cleaning up db"
Review.destroy_all
List.destroy_all
User.destroy_all
Movie.destroy_all
Tv.destroy_all
MediaProvider.destroy_all
Provider.destroy_all
puts "Db cleaned"

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

providers.each do |provider|
  Provider.create(
    name: provider["name"],
    service: provider["type"],
    regions: provider["regions"],
    logo_url: provider["logo_100px"],
    ios_appstore_url: provider["ios_appstore_url"],
    android_playstore_url: provider["android_playstore_url"],
    watchmode_id: provider["id"]
  )
end

puts "Providers created"


def movies_seeds(movies)
  movies.each_with_index do |movie, i|
    this_movie = Movie.create(
      title: movie[1]["title"],
      homepage: movie[0]["homepage"],
      poster_url: "https://image.tmdb.org/t/p/w342#{movie[0]["poster_path"]}",
      backdrop_url: "https://image.tmdb.org/t/p/w1280#{movie[0]["backdrop_path"]}",
      trailer: movie[1]["trailer"],
      overview: movie[1]["plot_overview"],
      tagline: movie[0]["tagline"],
      runtime: movie[1]["runtime_minutes"],
      budget: movie[0]["budget"],
      revenue: movie[0]["revenue"],
      status: movie[0]["status"],
      original_language: movie[1]["original_language"],
      year: movie[1]["year"],
      release_date: movie[1]["release_date"],
      rating_average: movie[1]["user_rating"],
      critic_score: movie[1]["critic_score"],
      popularity: movie[0]["popularity"],
      genre_names: movie[1]["genre_names"],
      similar_titles_watchmode: movie[1]["similar_titles"],
      recommendations_tmdb: movie[0]["recommendations"]["results"].map { |each| each["id"] },
      us_rating: movie[1]["us_rating"],
      tmdb_id: movie[0]["id"],
      watchmode_id: movie[1]["id"],
      imdb_id: movie[0]["imdb_id"]
    )
    puts "movie created #{i}"
    movie[1]["sources"].each do |source|
      MediaProvider.create(
        name: source["name"],
        region: source["region"],
        ios_url: source["ios_url"],
        android_url: source["android_url"],
        web_url: source["web_url"],
        format: source["format"],
        price: source["price"],
        seasons: source["seasons"],
        episodes: source["episodes"],
        provider_id: Provider.find_by(watchmode_id: source["source_id"]).id,
        providable: this_movie
      )
    end
    puts "media providers created #{i}"
  end
  puts "Movies Created"
end

def tvs_seeds(tvs)
  tvs.each_with_index do |tv, i|
    this_tv = Tv.create(
      title: tv[0]["name"],
      overview: tv[0]["overview"],
      homepage: tv[0]["homepage"],
      first_air_date: tv[0]["first_air_date"],
      last_air_date: tv[0]["last_air_date"],
      poster_url: "https://image.tmdb.org/t/p/w342#{tv[0]["poster_path"]}",
      backdrop_url: "https://image.tmdb.org/t/p/w1280#{tv[0]["backdrop_path"]}",
      trailer: tv[1]["trailer"],
      number_of_episodes: tv[0]["number_of_episodes"],
      number_of_seasons: tv[0]["number_of_seasons"],
      runtime: tv[1]["runtime_minutes"],
      original_language: tv[1]["original_language"],
      popularity: tv[0]["popularity"],
      rating_average: tv[1]["user_rating"],
      critic_score: tv[1]["critic_score"],
      us_rating: tv[1]["us_rating"],
      year: tv[1]["year"],
      status: tv[0]["status"],
      tagline: tv[0]["tagline"],
      recommendations_tmdb: tv[0]["recommendations"]["results"].map { |each| each["id"] },
      similar_titles_watchmode: tv[1]["similar_titles"],
      genre_names: tv[1]["genre_names"],
      tmdb_id: tv[0]["id"],
      watchmode_id: tv[1]["id"],
      imdb_id: tv[1]["imdb_id"]
    )
    puts "Tv Created #{i}"
    tv[1]["sources"].each do |source|
      MediaProvider.create(
        name: source["name"],
        region: source["region"],
        ios_url: source["ios_url"],
        android_url: source["android_url"],
        web_url: source["web_url"],
        format: source["format"],
        price: source["price"],
        seasons: source["seasons"],
        episodes: source["episodes"],
        provider_id: Provider.find_by(watchmode_id: source["source_id"]).id,
        providable: this_tv
      )
    end
    puts "media providers created #{i}"
  end
  puts "tvs created"
end

movies_seeds(movies_1)
movies_seeds(movies_2)
tvs_seeds(tvs_1)
tvs_seeds(tvs_2)
