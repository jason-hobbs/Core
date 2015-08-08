class GroupsController < ApplicationController
  before_action :require_signin
  before_action :require_admin, except: [:show]
  before_action :get_user
  before_action :get_tags
  before_action :current_group, only: [:edit, :update, :destroy, :show, :groupposts]
  before_action :get_all_users, only: [:edit, :new]
  before_action :get_allowed, only: [:show]

  def index
    @groups = Group.all.order(:name)
  end

  def show
    if @user.groups.find_by(id: @group.id)
      unless params[:tag].nil?
        @tag = Tag.find_by(name: params[:tag])
        session[:tag] = @tag.id
        @tagname = @tag.name
        @posts = @group.posts.order(created_at: :desc).where(tag_id: @tag.id).includes(:tag).includes(:user).page(params[:page]).per_page(40)
      else
        @tagname = 'All'
        session[:tag] = nil
        @posts = @group.posts.order(created_at: :desc).includes(:tag).includes(:user).page(params[:page]).per_page(40)
      end
      update_visit
    else
      redirect_to root_path, :gflash => { :notice => "Not authorized for group" }
    end
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to groups_path, :gflash => { :success => "Group created successfully" }
    else
      render :new
    end
  end

  def edit
  end

  def update
    @group.slug = params[:name]
    if @group.update(group_params)
      redirect_to @group, :gflash => { :success => "Group updated!" }
    else
      render :edit
    end
  end

  def destroy
      @group.destroy
      redirect_to groups_path, :gflash => { :success => "Group deleted" }
  end

  def groupposts
    if @user.groups.find_by(:id=>@group.id)
      update_visit
      #@posts = @group.posts.text_search(params[:query]).includes(:tag).includes(:user).page(params[:page]).per_page(40)
      unless session[:tag].nil?
        #@tag = Tag.find(session[:tag])
        tagid=session[:tag]
        @posts = @group.posts.order(created_at: :desc).where(tag_id: tagid).includes(:tag).includes(:user).page(params[:page]).per_page(40)
      else
        @posts = @group.posts.order(created_at: :desc).includes(:tag).includes(:user).page(params[:page]).per_page(40)
      end
    end
  end




  private

  def get_all_users
    @users = User.all
  end

  def current_group
    @group = Group.find_by(slug: params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :slug, user_ids: [])
  end
end
