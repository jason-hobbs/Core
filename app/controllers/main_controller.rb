class MainController < ApplicationController
  before_action :require_signin
  before_action :get_user
  before_action :get_allowed

  def index
    @group = Group.find_by(:name => 'community')
    @posts = @group.posts    
  end

end
