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

  def upload_file
    if params[:file]
      FileUtils::mkdir_p(Rails.root.join('public/uploads/files'))
      ext = File.extname(params[:file].original_filename)
      file_name = "#{SecureRandom.urlsafe_base64}#{ext}"
      path = Rails.root.join('public/uploads/files/', file_name)
      File.open(path, "wb") {|f| f.write(params[:file].read)}
      render :text => {:link => "/uploads/files/#{file_name}"}.to_json
    else
      render :text => {:link => nil}.to_json
    end
  end

  def index
    if @user.groups.find_by(:id=>@group.id)
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
    @post.group_id = @group.id
    @post.user_id = @user.id
    if @post.save
      @group.users.each do |member|
        SendEmailJob.set(wait: 20.seconds).perform_later(@group, @post, member)
      end
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
