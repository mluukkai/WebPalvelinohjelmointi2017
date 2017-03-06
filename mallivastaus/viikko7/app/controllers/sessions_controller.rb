class SessionsController < ApplicationController
  def new
    # renderöi kirjautumissivun
  end

  def create
    user = User.find_by username: params[:username]
    if user and user.authenticate(params[:password]) 
      if user.blocked?
        redirect_to :back, notice: "Your accout is frozen, please contact admin"
      else
        session[:user_id] = user.id
        redirect_to user_path(user), notice: "Welcome back!"
      end
    else
      redirect_to :back, notice: "Username and/or password mismatch"
    end
  end

  def create_oauth
    username = env["omniauth.auth"].info['name']
    user = User.find_by username: username
    if user.nil?
      user = User.new username: username
      user.save(validate: false)
    end
    session[:user_id] = user.id
    redirect_to user_path(user), notice: "Welcome back!"    
  end

  def destroy
    # nollataan sessio
    session[:user_id] = nil
    # uudelleenohjataan sovellus pääsivulle
    redirect_to :root
  end
end