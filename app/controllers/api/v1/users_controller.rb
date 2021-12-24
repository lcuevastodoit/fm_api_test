class Api::V1::UsersController < ApplicationController
  respond_to :json
  before_action :http_basic_authenticate, only: :show

  # -/api/v1/users GET
  def index
    @users = User.all
    if @users.blank?
      render json: { error: 'Not Found Users' }, status: 400
    else
      paginate User.unscoped, per_page: 5, root: 'data', each_serializer: Api::V1::UserSerializer, status: :ok
    end
  end

  #-/api/v1/users/:id GET
  def show
    @user = User.find(params[:id])
    render json: @user, root: 'data', each_serializer: Api::V1::UserSerializer, status: :ok
  end

  #-/api/v1/users/:id POST
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, root: 'data', each_serializer: Api::V1::UserSerializer, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  #-/api/v1/users/:id PUT
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      render json: @user, root: 'data', each_serializer: Api::V1::UserSerializer, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  #-/api/v1/users/:id DELETE
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    head :no_content
  end

  private

  # Basic authentication for show action
  def http_basic_authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == 'user' && password == 'password'
    end
  end

  # strong parameters
  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :avatar)
  end
end
