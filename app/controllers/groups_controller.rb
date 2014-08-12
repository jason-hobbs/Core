class GroupsController < ApplicationController
  before_action :require_signin
  before_action :require_admin, except: [:show]
  before_action :get_user
  before_action :current_group, only: [:edit, :update, :destroy, :show]
  before_action :get_all_users, only: [:edit, :new]
  before_action :get_allowed, only: [:show]

  def index
    @groups = Group.all.order(:name)
  end

  def show
    if @user.groups.find_by(:id=>@group.id)
      @posts = @group.posts.order(created_at: :desc).page(params[:page]).per_page(15)
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






  private

  def get_all_users
    @users = User.all
  end

  def current_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, user_ids: [])
  end
end
