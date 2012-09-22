class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
   	@movie = Movie.find(id) # look up movie by unique ID
		# will render app/views/movies/show.<extension> by default
  end

  def index
		@all_ratings = Movie.ratings
		@checked = {'G'=>"1", 'PG'=> "1", 'PG-13' => '1', 'R'=>'1'}
		if !params[:ratings]
    	selection = Movie.all
		else
			@checked = params[:ratings]
			condition = {:conditions => { :rating => params[:ratings].keys} }
			selection = Movie.find(:all, condition)
		end
		if !params[:sort]
    	@movies = selection
		else
			sort = params[:sort]
			if sort == 'title'
				sort_by = {:order => :title}
				@title_header = "hilite"
			else
				sort_by = {:order => :release_date}
				@release_date_header = "hilite"
			end
  		@movies = Movie.find(:all, condition, sort_by)
		end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def sort
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
