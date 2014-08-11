class TagsController < ApplicationController
  before_action :require_signin
  before_action :require_admin

  def index
    @tags = Tag.all.order(:name)
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to tags_path, :gflash => { :success => "Tag Created" }
      else
        render :new
      end
    end

    def edit
      @tag = Tag.find(params[:id])
    end

    def update
      @tag = Tag.find(params[:id])
      if @tag.update(tag_params)
        redirect_to tags_path, :gflash => { :success => "Tag updated" }
      else
        render :edit
      end
    end

    def destroy
      @newtag = Tag.find(params[:id])
      @newtag.destroy
      redirect_to tags_path, :gflash => { :success => "Tag deleted" }
    end

    private

    def tag_params
        params.require(:tag).permit(:name, :color, :textcolor)
    end

end
