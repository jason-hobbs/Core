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
    @post = Post.new(post_params)
    @post.group_id = params[:group_id]
    if @post.save
      redirect_to root_path, :gflash => { :success => "Posted successfully" }
    else
      render :new
    end
  end

  private

  def get_group
    @group = Group.find(params[:group_id])
  end

  def post_params
    params.require(:post).permit(:entry)
  end
end
