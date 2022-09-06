class UsersController < ApplicationController
  def new; end

  def create
    @user = User.new(user_params)
    input_check 
  end

  def show
    @user = User.find(params[:id])
    @viewing_parties = @user.viewing_parties
    movie_ids = @viewing_parties.map { |vp| vp.movie_id }
    @movies = MovieFacade.movies(movie_ids)
  end

  def login_form
    
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end

    def input_check
      if params[:user][:password] != params[:user][:password_conf]
        flash[:alert] = "Error: Passwords do not match."
        redirect_to '/register'
      elsif @user.save
        redirect_to "/users/#{@user.id}"
        flash[:success] = "Welcome, #{@user.name}!"
      else
        flash[:alert] = "Error: #{error_message(@user.errors)}"
        redirect_to '/register'
      end
    end
end
