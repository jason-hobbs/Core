class PostsController < ApplicationController
  before_action :require_signin
  before_action :get_user
  def new

  end
end
