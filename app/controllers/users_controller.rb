class UsersController < ApplicationController
  before_filter :authenticate, :except => [:show, :new, :create]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy
  before_filter :trying_to_delete_himself, :only => :destroy
  before_filter :non_signed_in, :only => [:new, :create]

  def new
    @user = User.new
    @title = "Sign up"
  end

  def index 
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page])
    @title = @user.name
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      @title = "Sign up"
      @user.password = ""
      @user.password_confirmation = ""
      render 'new'
    end
  end

  def edit
    @title = "Edit user"
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

  def following
    show_follow(:following)
  end

  def followers
    show_follow(:followers)
  end

  private

    def show_follow(action)
      @title = action.to_s.capitalize
      @user = User.find(params[:id])
      @users = @user.send(action).paginate(:page => params[:page])
      render 'show_follow'
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
      
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

    def non_signed_in
      if signed_in?
        redirect_to root_path 
        flash[:error] = "Signed-in users are not allowed to sign-up!"
        return
      end
    end

    def trying_to_delete_himself
      @user = User.find(params[:id])
      if current_user?(@user)
        redirect_to users_path
        flash[:error] = "You can't delete yourself!"
        return
      end
    end
end
