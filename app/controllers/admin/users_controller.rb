class Admin::UsersController < ApplicationController
  after_action :verify_authorized, except: :index
  before_action :set_user, only: [:approve, :show, :edit, :update, :destroy]

  def index
    @users = params[:approved] ? User.where(approved: false) : User.all
  end

  def approve
    authorize @user, :create?
    @user.approve!
    redirect_to admin_users_url, notice: "Utilisateur '#{@user.email}' approuvé avec succès."
  end

  def show
    authorize @user
  end

  def new
    @user = User.new
    authorize @user
  end

  def create
    @user = User.create(user_params)
    authorize @user
    if @user.save
      redirect_to admin_users_url, notice: "L'utilisateur #{@user.email} a été créé avec succès."
    else
      render :new
    end
  end

  def edit
    authorize @user
  end

  def update
    authorize @user
    if @user.update_with_password(user_params)
      redirect_to admin_users_url, notice: "L'utilisateur #{@user.email} a été modifié avec succès."
    else
      render :edit
    end
  end

  def destroy
    authorize @user
    @user.destroy
    redirect_to admin_users_url
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :approved)
  end
end
