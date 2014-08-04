class GroupsController < ApplicationController
  before_action :require_signin
  before_action :require_admin
  before_action :get_user

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @posts = @group.posts
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
