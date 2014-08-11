class PostsController < ApplicationController
  before_action :require_signin
  before_action :get_user
  before_action :get_group

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @replies = @post.replies
  end

  def update
    fail
  end

  def create
    @post = Post.new(post_params)
    @post.group_id = params[:group_id]
    @post.user_id = @user.id
    if @post.save
      redirect_to group_path(@group), :gflash => { :success => "Posted successfully" }
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :entry, :tag_id)
  end
end
