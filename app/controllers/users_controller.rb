class UsersController < ApplicationController
  def new; end

  def create
    user = user_params 
    user[:email] = user[:email].downcase 
    @new_user = User.new(user_params)
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

  def login_user
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id 
      redirect_to user_path(user)
    else 
      flash[:error] = 'Sorry, your credentials are bad.' 
      render :login_form
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end

    def input_check
      if params[:user][:password] != params[:user][:password_conf]
        flash[:alert] = "Error: Passwords do not match."
        redirect_to '/register'
      elsif @new_user.save
        redirect_to "/users/#{@new_user.id}"
        flash[:success] = "Welcome, #{@new_user.name}!"
      else
        flash[:alert] = "Error: #{error_message(@new_user.errors)}"
        redirect_to '/register'
      end
    end
end
