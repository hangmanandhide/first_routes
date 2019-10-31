class UsersController < ApplicationController
  
  def index
    if User.count == 0
      render plain: "There are no users!"
    else 
      render json: User.all  
    end
  end

  def create
    user = User.new(user_param)

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

    if user.update_attributes(user_param)
      redirect_to :action => 'show', :id => user
    else
      user = User.all
      render :action => 'edit'
    end

  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to :action => 'index'
  end


  private

  def user_param
    params.require(:user).permit(:username)
  end

end