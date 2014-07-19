class PostsController < ApplicationController
  before_action :require_signin
  before_action :get_user
  before_action :get_group
  def new
    @post = Post.new
  end


  def update
    fail
  end

  def create
    fail
  end

  private

  def get_group
    @group = Group.find(params[:group_id])
  end
end
