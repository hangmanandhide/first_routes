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

    if user.save
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
    params.require(:user).permit(:name, :email)
  end

end