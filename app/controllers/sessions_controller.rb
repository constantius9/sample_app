class SessionsController < ApplicationController

  def new
    @title = "Sign in"
  end

  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid user/password combination"
      @title = "Sign in"
      render 'new'
    else
      # sign in the user and redirect
    end
  end

  def destroy
  end

end
