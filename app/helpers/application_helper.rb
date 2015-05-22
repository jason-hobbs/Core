module ApplicationHelper
  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def broadcast(channel, &block)
    message = {:channel => channel, :data => capture(&block), :ext => {:auth_token => FAYE_TOKEN}}
    uri = URI.parse("http://localhost:9292/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end

end
