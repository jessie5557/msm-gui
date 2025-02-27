class MoviesController < ApplicationController

  def create
    #Retrieve the user's inputs from params (fetch out each value)
    # pramas hash looks like: {"the_title"=>"1", "the_year"=>"2", "the_duration"=>"3", "the_description"=>"4", "the_image"=>"5", "the_director_id"=>"6"}

    # Create a record in the movie table; populate each column with the user input
    # Table name: movies
      #
      #  id          :integer          not null, primary key
      #  description :text
      #  duration    :integer
      #  image       :string
      #  title       :string
      #  year        :integer
      #  created_at  :datetime         not null
      #  updated_at  :datetime         not null
      #  director_id :integer
      #
      #class Movie < ApplicationRecord

    m = Movie.new
    m.title = params.fetch("the_title")
    m.year = params.fetch("the_year")
    m.duration = params.fetch("the_duration")
    m.description = params.fetch("the_description")
    m.image = params.fetch("the_image")
    m.director_id = params.fetch("the_director_id")

    m.save

    redirect_to("/movies")
  end

  def delete
    
    the_id = params.fetch("an_id")
    matching_movie_records = Movie.where({:id => the_id})
    the_movie = matching_movie_records.at(0)

    the_movie.destroy

    redirect_to("/movies")
  end


  def modify
    #Get the ID out of params
    the_id = params.fetch("an_id")

    #Look up the existing record
    matching_movie_record = Movie.where({:id => the_id})
    the_movie = matching_movie_record.at(0)

    #Overwrite each column with the values from user inputs
    the_movie.title = params.fetch("the_title")
    the_movie.year = params.fetch("the_year")
    the_movie.duration = params.fetch("the_duration")
    the_movie.description = params.fetch("the_description")
    the_movie.image = params.fetch("the_image")
    the_movie.director_id = params.fetch("the_director_id")

    #Save
    the_movie.save

    redirect_to("/movies/#{the_movie.id}")
  
  end


  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end
end
