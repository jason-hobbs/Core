class PostsController < ApplicationController
  before_action :require_signin
  before_action :get_user
  before_action :get_group
  before_action :get_post, only: [:show, :edit, :update ]

  def new
    @post = Post.new
  end

  def show
    @replies = @post.replies.includes(:user)
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit
    end
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

  def get_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :entry, :tag_id)
  end
end
