class UsersController < ApplicationController
  def new; end

  def create
    user = User.new(user_params)
    check_passwords 
    if user.save
      redirect_to "/users/#{user.id}"
      flash[:success] = "Welcome, #{user.name}!"
    else
      flash[:alert] = "Error: #{error_message(user.errors)}"
      binding.pry 
      redirect_to '/register'
    end
  end

  def show
    @user = User.find(params[:id])
    @viewing_parties = @user.viewing_parties
    movie_ids = @viewing_parties.map { |vp| vp.movie_id }
    @movies = MovieFacade.movies(movie_ids)
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end

    def check_passwords
      if params[:password] != params[:password_conf]
        
      end
    end
end
