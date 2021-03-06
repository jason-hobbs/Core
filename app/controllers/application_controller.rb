class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def require_signin
    unless current_user
      session[:intended_url] = request.url
      redirect_to new_session_url, :gflash => {:warning => "Please sign in first!"}
    end
  end
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  def current_user?(user)
    current_user == user
  end

  helper_method :current_user?

  def require_admin
    unless current_user_admin?
      redirect_to root_url, :gflash => {:warning => "Unauthorized access!"}
    end
  end

  def current_user_admin?
    current_user && current_user.admin?
  end

  helper_method :current_user_admin?

  def get_user
    if session[:user_id]
      @user = current_user
    end
  end

  helper_method :get_user

  def get_group
    @group = Group.find_by(slug: params[:group_id])
  end

  def get_post
    @post = Post.find(params[:post_id])
  end

  def get_allowed
    @allowed = @user.groups.order(:name)
  end

  def get_reply
    @reply = Reply.find(params[:id])
  end

  def update_visit
    time = DateTime.now
    visit = @user.groupmembers.find_by(:group_id => @group.id)
    @last_visit = visit.last_visit
    visit.last_visit = time
    visit.save!
  end

  def get_tags
    @tags = Tag.all.order(:name)
  end

end
