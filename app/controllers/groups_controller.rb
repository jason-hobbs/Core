class GroupsController < ApplicationController
  before_action :require_signin
  before_action :require_admin, except: [:show]
  before_action :get_user

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    if @user.groups.find_by(:id=>@group.id)
      @posts = @group.posts
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

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
