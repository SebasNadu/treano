# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
# # #   Character.create(name: "Luke", movie: movies.first)
require 'net/http'
require 'open-uri'
require 'json'
require 'faker'
require 'cloudinary'

providers_file = File.read("t_providers_US.json")
providers = JSON.parse(providers_file)
genres_file = File.read("t_genres.json")
genres = JSON.parse(genres_file)
male_avatars = Cloudinary::Api.resources_by_tag('male_avatar', :max_results => 25)
female_avatars = Cloudinary::Api.resources_by_tag('female_avatar', :max_results => 25)

#  #PLEASE DO NOT UNCOMMENT!! this method is for create a json with all the info related to movies
  #movies_group = movies_0["titles"][125..249]
  #full_movies = []
  #movies_group.each_with_index do |movie, i|
    #uri_tmdb = URI("https://api.themoviedb.org/3/movie/#{movie["tmdb_id"].to_s}?api_key=&language=en-US&append_to_response=credits,videos,images,reviews,keywords,recommendations,similar,lists")
    #response_tmdb = Net::HTTP.get(uri_tmdb)
    #result_tmdb = JSON.parse(response_tmdb)
    #puts "#{i} tmdb responsed"

    #uri_watchmode = URI("https://api.watchmode.com/v1/title/#{movie["id"].to_s}/details/?apiKey=&append_to_response=sources")
    #response_watchmode = Net::HTTP.get(uri_watchmode)
    #result_watchmode = JSON.parse(response_watchmode)
    #puts "#{i} watchmode responsed"

    #full_movies << [result_tmdb, result_watchmode]
    #puts "#{i} array pushed"
  #end
  #File.open("t_full_movies_6.json", "wb") do |file|
    #file.write(JSON.generate(full_movies))
  #end
  #puts "JSON created"


#  #PLEASE DO NOT UNCOMMENT!! this method is for create a json with all the info related to tvs
  #tvs_group = tvs_0["titles"][125..249]
  #full_tvs = []
  #tvs_group.each_with_index do |tv, i|
    #uri_tmdb = URI("https://api.themoviedb.org/3/tv/#{tv["tmdb_id"].to_s}?api_key=43f195cad08ed475966231cae7ae844e&language=en-US&append_to_response=credits,videos,images,reviews,keywords,recommendations,similar")
    #response_tmdb = Net::HTTP.get(uri_tmdb)
    #result_tmdb = JSON.parse(response_tmdb)
    #puts "#{i} tmdb responsed"

    #uri_watchmode = URI("https://api.watchmode.com/v1/title/#{tv["id"].to_s}/details/?apiKey=qBSAgILFtJ75GQ46RbYeTST8v73I3vA5kAi1jkBn&append_to_response=sources")
    #response_watchmode = Net::HTTP.get(uri_watchmode)
    #result_watchmode = JSON.parse(response_watchmode)
    #puts "#{i} watchmode responsed"

    #full_tvs << [result_tmdb, result_watchmode]
    #puts "#{i} array pushed"
  #end
  #File.open("t_full_tvs_6.json", "wb") do |file|
    #file.write(JSON.generate(full_tvs))
  #end
  #puts "JSON created"

puts "restauring Merit"
# 1. Reset all badges/points granting
Merit::BadgesSash.delete_all
Merit::Score::Point.delete_all

# 1.1 Optionally reset activity log (badges/points granted/removed until now)
Merit::ActivityLog.delete_all

# 2. Mark all `merit_actions` as unprocessed
Merit::Action.all.map{|a| a.update_attribute :processed, false }

# 3. Recompute reputation rules
#Merit::Action.check_unprocessed
#Merit::RankRules.new.check_rank_rules
puts "Merit restaured"

 puts "Cleaning up db"
 UserChallenge.destroy_all
 Challenge.destroy_all
 Notification.destroy_all
 Challenge.destroy_all
 Review.destroy_all
 MediaProvider.destroy_all
 Provider.destroy_all
 ListItem.destroy_all
 List.destroy_all
 GenreItem.destroy_all
 Genre.destroy_all
 KeywordItem.destroy_all
 Keyword.destroy_all
 Season.destroy_all
 Movie.destroy_all
 Tv.destroy_all
 User.destroy_all
 puts "Db cleaned"


i = 0

25.times do
  user = User.new(
    email: Faker::Internet.unique.email,
    password: "123456",
    first_name: Faker::Name.unique.female_first_name,
    last_name: Faker::Name.unique.last_name,
    bio: Faker::Movies::HitchhikersGuideToTheGalaxy.quote,
    reputation_score: rand(0..1000)
    )
    user.username = user.first_name + "_" + rand(12345..1234567).to_s
    avatar = URI.open(female_avatars["resources"][i]["url"])
    user.avatar.attach(io: avatar, filename: "image.png", content_type: "image/png")
    user.save
    i += 1
end

puts "50 female users created"

i = 0

25.times do
  user = User.new(
    email: Faker::Internet.unique.email,
    password: "123456",
    first_name: Faker::Name.unique.male_first_name,
    last_name: Faker::Name.unique.last_name,
    bio: Faker::Books::Dune.quote,
    reputation_score: rand(0..1000)
  )
    user.username = user.first_name + "_" + rand(12345..99999).to_s
    avatar = URI.open(male_avatars["resources"][i]["url"])
    user.avatar.attach(io: avatar, filename: "image.png", content_type: "image/png")
    user.save
    i += 1

end

puts "50 male users created"

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

 genres.each do |genre|
   Genre.create(
     genre_name: genre["name"],
     tmdb_genre_id: genre["tmdb_id"],
     watchmode_id: genre["id"]
   )
 end

 puts "Genres created"

 def movies_seeds(movies)
   movies.each_with_index do |movie, i|
     if Movie.find_by(tmdb_id: movie[0]["id"]).present?
       puts "movie already created" 
     else
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
       if movie[1]["sources"].present?
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
       if movie[0]["reviews"]["results"].present?
         movie[0]["reviews"]["results"].each do |review|
           Review.create(
             user_id: User.order(Arel.sql('RANDOM()')).first.id,
             reviewable_id: this_movie.id,
             reviewable: this_movie,
             content: review["content"],
             rating: rand(2..5),
             tmdb_review_id: review["id"]
           )
         end
         puts "Review created #{i}"
       end
       if movie[1]["genres"].present?
         movie[1]["genres"].each do |genre|
           GenreItem.create(
             genre_id: Genre.find_by(watchmode_id: genre).id,
             genreable: this_movie
           )
         end
         puts "Genre created #{i}"
       end
       if movie[0]["keywords"]["keywords"].present?
         movie[0]["keywords"]["keywords"].each do |keyword|
           if Keyword.find_by(tmdb_id: keyword["id"]).present?
             KeywordItem.create(
               keyword_id: Keyword.find_by(tmdb_id: keyword["id"]).id,
               keywordable: this_movie
             )
           else
             Keyword.create(
               name: keyword["name"],
               tmdb_id: keyword["id"]
             )
             KeywordItem.create(
               keyword_id: Keyword.find_by(tmdb_id: keyword["id"]).id,
               keywordable: this_movie
             )
           end
         end
         puts "keyword created #{i}"
       end
     end
   end
   puts "Movies Created"
 end

 def tvs_seeds(tvs)
   tvs.each_with_index do |tv, i|
     if Tv.find_by(tmdb_id: tv[0]["id"]).present?
       puts "tv already created" 
     else
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
       if tv[1]["sources"].present?
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
       if tv[0]["reviews"]["results"].present?
         tv[0]["reviews"]["results"].each do |review|
           Review.create(
             user_id: User.order(Arel.sql('RANDOM()')).first.id,
             reviewable_id: this_tv.id,
             reviewable: this_tv,
             content: review["content"],
             rating: rand(2..5),
             tmdb_review_id: review["id"]
           )
         end
         puts "Review created #{i}"
       end
       if tv[1]["genres"].present?
         tv[1]["genres"].each do |genre|
           GenreItem.create(
             genre_id: Genre.find_by(watchmode_id: genre).id,
             genreable: this_tv
           )
         end
         puts "Genre created #{i}"
       end
       if tv[0]["keywords"]["keywords"].present?
         tv[0]["keywords"]["keywords"].each do |keyword|
           if Keyword.find_by(tmdb_id: keyword["id"]).present?
             KeywordItem.create(
               keyword_id: Keyword.find_by(tmdb_id: keyword["id"]).id,
               keywordable: this_tv
             )
           else
             Keyword.create(
               name: keyword["name"],
               tmdb_id: keyword["id"]
             )
             KeywordItem.create(
               keyword_id: Keyword.find_by(tmdb_id: keyword["id"]).id,
               keywordable: this_tv
             )
           end
         end
         puts "Keyword created #{i}"
       end
       if tv[0]["seasons"].present?
         tv[0]["seasons"].each do |season|
           Season.create(
             air_date: season["air_date"],
             episode_count: season["episode_count"],
             tmdb_id: season["id"],
             name: season["name"],
             overview: season["overview"],
             poster_path: "https://image.tmdb.org/t/p/w342#{season["poster_path"]}",
             season_number: season["season_number"],
             tv_id: this_tv.id
           )
         end
         puts "Season created #{i}"
       end
     end
   end
   puts "tvs created"
 end

#movies_file_0 = File.read("t_movies_3.json")
movies_file_1 = File.read("t_full_movies_1.json")
movies_file_2 = File.read("t_full_movies_2.json")
movies_file_3 = File.read("t_full_movies_3.json")
movies_file_4 = File.read("t_full_movies_4.json")
movies_file_5 = File.read("t_full_movies_5.json")
movies_file_6 = File.read("t_full_movies_6.json")
movies_file_7 = File.read("t_full_movies_7.json")
movies_file_8 = File.read("t_full_movies_8.json")
#movies_0 = JSON.parse(movies_file_0)
movies_1 = JSON.parse(movies_file_1)
movies_2 = JSON.parse(movies_file_2)
movies_3 = JSON.parse(movies_file_3)
movies_4 = JSON.parse(movies_file_4)
movies_5 = JSON.parse(movies_file_5)
movies_6 = JSON.parse(movies_file_6)
movies_7 = JSON.parse(movies_file_7)
movies_8 = JSON.parse(movies_file_8)
#tvs_file_0 = File.read("t_tvs_3.json")
tvs_file_1 = File.read("t_full_tvs_1.json")
tvs_file_2 = File.read("t_full_tvs_2.json")
tvs_file_3 = File.read("t_full_tvs_3.json")
tvs_file_4 = File.read("t_full_tvs_4.json")
tvs_file_5 = File.read("t_full_tvs_5.json")
tvs_file_6 = File.read("t_full_tvs_6.json")
tvs_file_7 = File.read("t_full_tvs_7.json")
tvs_file_8 = File.read("t_full_tvs_8.json")
#tvs_0 = JSON.parse(tvs_file_0)
tvs_1 = JSON.parse(tvs_file_1)
tvs_2 = JSON.parse(tvs_file_2)
tvs_3 = JSON.parse(tvs_file_3)
tvs_4 = JSON.parse(tvs_file_4)
tvs_5 = JSON.parse(tvs_file_5)
tvs_6 = JSON.parse(tvs_file_6)
tvs_7 = JSON.parse(tvs_file_7)
tvs_8 = JSON.parse(tvs_file_8)

 tvs_seeds(tvs_1)
 tvs_seeds(tvs_2)
 tvs_seeds(tvs_3)
 tvs_seeds(tvs_4)
 tvs_seeds(tvs_5)
 tvs_seeds(tvs_6)
 tvs_seeds(tvs_7)
 tvs_seeds(tvs_8)
 movies_seeds(movies_1)
 movies_seeds(movies_2)
 movies_seeds(movies_3)
 movies_seeds(movies_4)
 movies_seeds(movies_5)
 movies_seeds(movies_6)
 movies_seeds(movies_7)
 movies_seeds(movies_8)

i = 1
200.times do
  list = List.create(
    user_id: User.order(Arel.sql('RANDOM()')).first.id,
    list_name: Genre.order(Arel.sql('RANDOM()')).first.genre_name,
    description: Faker::Movies::HitchhikersGuideToTheGalaxy.quote
  )
  url = Cloudinary::Api.resources_by_tag(list.list_name)["resources"][0]["url"]
  cover_picture = URI.open(url)
  list.cover_picture.attach(io: cover_picture, filename: "image.png", content_type: "image/png")
  list.save
  rand(0..5).times do
    ListItem.create(
      list_id: list.id,
      listable: Tv.order(Arel.sql('RANDOM()')).first
    )
  end
  rand(0..5).times do
    ListItem.create(
      list_id: list.id,
      listable: Movie.order(Arel.sql('RANDOM()')).first
    )
  end
  puts "List #{i} created"
  i += 1
end
puts "Lists created"

 sebas = User.new(
   email: "sebas@treano.co",
   password: "123456",
   username: "Sebs",
   first_name: "Sebastian",
   last_name: "Navarro",
   bio: "Professional coder during the day, amateur movie critic during the night. I specialise in Ruby on Rails and thrillers. I am passionate about beautiful apps and skilfully executed scenes. Follow me for good tech related lists and more.",
   reputation_score: 0,
 )
 sebas_uri = URI.open('https://avatars.githubusercontent.com/u/98430438?v=4')
 sebas.avatar.attach(io: sebas_uri, filename: "image.png", content_type: "image/png")
 if sebas.save
   sebas.save
   puts "Sebas created"
 end

 meerim = User.new(
   email: "meerim@treano.co",
   password: "123456",
   username: "Meer",
   first_name: "Meerim",
   last_name: "Asylbekova",
   bio: "Being tired of looking for what movies and tv shows to watch, I decided to create the best lists for like-minded people. Follow me for more awesome lists and recommendations. I also happen to write good reviews, check them out too!",
   reputation_score: 0
 )
 meerim_uri = URI.open('https://avatars.githubusercontent.com/u/108770937?v=4')
 meerim.avatar.attach(io: meerim_uri, filename: "image.png", content_type: "image/png")
 if meerim.save
   meerim.save
   puts "Meerim created"
 end
