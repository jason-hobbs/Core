class PostsController < ApplicationController
  respond_to :js, :html
  before_action :require_signin
  before_action :get_user
  before_action :get_group
  before_action :get_post, only: [:show, :edit, :update, :destroy ]
  before_action :get_allowed

  def new
    @post = Post.new
  end

  def show
    @replies = @post.replies.includes(:user).order(:created_at)
    @reply = Reply.new
  end

  def edit
  end

  def index
    if @user.groups.find_by(:id=>@group.id)
      #@posts = @group.posts.where('title @@ ? or entry @@ ?', "#{params[:search]}", "#{params[:search]}" ).order('created_at desc').includes(:tag).includes(:user)
      @posts = @group.posts.text_search(params[:query]).includes(:tag).includes(:user).page(params[:page]).per_page(40)
    else
      redirect_to root_path, :gflash => { :notice => "Not authorized for group" }
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.js {render :show}
      else
        format.js {render :edit}
      end
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

  def destroy
    @post.destroy
    redirect_to group_path(@group), :gflash => { :success => "Post deleted" }
  end

  private

  def get_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :entry, :tag_id)
  end
end
