class SessionsController < ApplicationController
	def new
  end

  def create
  	if user = User.authenticate(params[:email], params[:password])
      session[:user_id] = user.id

			gflash :success => "Logged in"
   		redirect_to(session[:intended_url] || dashboards_path)
      session[:intended_url] = nil
  	else
  		gflash :now, :warning => "Invalid email/password combination!"
	    render :new
  	end
	end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :gflash => { :success => "Logged out successfully" }
  end

end
