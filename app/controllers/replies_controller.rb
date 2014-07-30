class RepliesController < ApplicationController
  before_action :require_signin
  before_action :get_user
  before_action :get_group
  before_action :get_post

  def new
    @reply = Reply.new
  end

  def create
    @reply = Reply.new(reply_params)
    @reply.post_id = @post.id
    @reply.user_id = @user.id
    if @reply.save
      redirect_to group_post_path(@group, @post), :gflash => { :success => "Posted successfully" }
    else
      render :new
    end
  end

  private

  def reply_params
    params.require(:reply).permit( :entry)
  end

end
