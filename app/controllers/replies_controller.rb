class RepliesController < ApplicationController
  respond_to :js, :html
  before_action :require_signin
  before_action :get_user
  before_action :get_group
  before_action :get_post, except: [:upload_file]
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
        @post.updated_at = @reply.created_at
        @post.save!
        @group.users.each do |member|
          SendEmailJob2.set(wait: 20.seconds).perform_later(@group, @post, @reply, member)
        end
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
  end

  private

  def reply_params
    params.require(:reply).permit( :entry)
  end

end
