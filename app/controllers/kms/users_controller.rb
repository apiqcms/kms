module Kms
  class UsersController < ApplicationController
    before_action :authenticate_kms_user!
    load_and_authorize_resource
    skip_authorize_resource only: :kms_user
    wrap_parameters :user, include: [:email, :password, :password_confirmation, :role]

    def index
      render json: User.all
    end

    def create
      @user = User.new(user_params)
      if @user.save
        head :no_content
      else
        render json: { errors: @user.errors.full_messages }.to_json, status: :unprocessable_entity
      end
    end

    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        head :no_content
      else
        render json: { errors: @user.errors.full_messages }.to_json, status: :unprocessable_entity
      end
    end

    def show
      @user = User.find(params[:id])
      render json: @user
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      head :no_content
    end

    def kms_user
      render json: current_kms_user
    end

    protected

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :role)
    end


  end
end
