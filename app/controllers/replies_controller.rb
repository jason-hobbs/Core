class RepliesController < ApplicationController
  respond_to :js, :html
  before_action :require_signin
  before_action :get_user
  before_action :get_group
  before_action :get_post
  before_action :get_reply, only: [:edit, :update, :show, :destroy]


  def index
    @replies = @post.replies.includes(:user).where('id > ?', params[:after].to_i)
  end

  def edit
  end

  def show
  end

  def new
    @reply = Reply.new
    respond_to do |format|
      format.js
      format.html
    end
  end

  def addnewreply
    @reply = Reply.new
  end

  def update
    respond_to do |format|
      if @reply.update(reply_params)
        format.js {render :show}
      else
        format.js {render :edit}
      end
    end
  end

  def create
    @reply = Reply.new(reply_params)
    @reply.post_id = @post.id
    @reply.user_id = @user.id
    respond_to do |format|
      if @reply.save
        @group.users.each do |member|
          #ReplyMailer.new_reply(@group, @post, @reply, member).deliver_now
          SendEmailJob2.set(wait: 20.seconds).perform_later(@group, @post, @reply, member)
        end
        #redirect_to group_post_path(@group, @post, :anchor => "end"), :gflash => { :success => "Posted successfully" }
        format.js {render :addnewreply}
      else
        format.js {render :new}
      end
    end
  end

  def destroy
    @reply.destroy
    respond_to do |format|
      format.js {render :delete}
    end
    #redirect_to group_post_path(@group, @post)
  end

  private

  def reply_params
    params.require(:reply).permit( :entry)
  end

end
