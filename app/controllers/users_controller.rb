class UsersController < ApplicationController
  
  def index
    if User.count == 0
      render plain: "There are no users!"
    else 
      render json: User.all  
    end
  end

  def create
    user = User.new(user_params)
    text_string = user.username.gsub(/\W/,'')

    if user.username != text_string
      render html: "Illegal character in username! Please try a different username. text_string is #{text_string}. user.username is #{user.username}"
      # render json: user.errors.full_messages, status: :unprocessable_entity
    elsif user.save
      render json: user
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end

  end

  def show
    found = User.find(params[:id])
    if found
      render json: found
    else
      render json: found.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    user = User.find(params[:id])

    if user.update(user_params)
      render json: user
    else
    render json: user.errors.full_messages, status: :unprocessable_entity
    end

  end

  def destroy
    User.find(params[:id]).destroy
    render json: @user
    # redirect_to :action => 'index'
  end


  private

  def user_params
    params.require(:user).permit(:username)
  end

end