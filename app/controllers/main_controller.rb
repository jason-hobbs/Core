class MainController < ApplicationController
  before_action :require_signin
  before_action :get_user
  def index
    @group = Group.find_by(:name => 'main')
    @posts = @group.posts
  end
end
