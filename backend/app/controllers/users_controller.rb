# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def show; end

  def index
    authorize_admin # Check if the current user is an admin
    @users = User.all # Retrieve the list of users (adjust as needed)
  end

  def update
    if current_user.update(user_params)
      render :show
    else
      render json: { errors: current_user.errors }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :bio, :image, :role)
  end

  def authorize_admin
    unless current_user && current_user.role == 'admin'
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
