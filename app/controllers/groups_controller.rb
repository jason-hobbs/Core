class GroupsController < ApplicationController
  before_action :require_signin
  before_action :require_admin
  before_action :get_user
  def index
  end
end
