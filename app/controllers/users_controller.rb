class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :require_login, except: [:new, :create]
  before_action :require_correct_user, only: [:edit, :update] # Ensure only the correct user can edit
  before_action :require_admin, only: [:destroy] # Admins can destroy users (not editing and updating)

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    # Standard users can only edit their own details; admins can edit any user's details
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        session[:first_name] = @user.first_name
        session[:is_admin] = @user.is_admin

        format.html { redirect_to login_path, notice: "Sign up successful. Please log in." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "Your account details were successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path, status: :see_other, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Ensure user is logged in
    def require_login
      unless logged_in?
        redirect_to login_path, alert: "You must be logged in to perform this action."
      end
    end

    # Ensure user can only edit their own details or an admin can edit any user's details
    def require_correct_user
      unless current_user == @user || current_user.admin?
        redirect_to root_path, alert: "You can only edit your own account details, or admins can edit any user's details."
      end
    end

    # Ensure user is an admin for specific actions (only for destroy in this case)
    def require_admin
      unless current_user&.admin?
        redirect_to root_path, alert: "Access denied. Admins only."
      end
    end

    # Only allow a list of trusted parameters through
    def user_params
      # Admins can update is_admin and other fields
      if current_user&.admin?
        params.require(:user).permit(:is_admin, :status, :first_name, :last_name, :email, :password_digest, :password_confirmation)
      else
        # Non-admin users can only update their own personal information
        params.require(:user).permit(:first_name, :last_name, :email, :password_digest, :password_confirmation)
      end
    end
end
