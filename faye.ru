require 'faye'
require File.expand_path('../config/initializers/faye_token.rb', __FILE__)
Faye::WebSocket.load_adapter('thin')
class ServerAuth
  def incoming(message, callback)
    if message['channel'] !~ %r{^/meta/}
      if message['ext'].nil? || message['ext']['auth_token'] != FAYE_TOKEN
        message['error'] = 'Invalid authentication token'
      end
    end
    callback.call(message)
  end
end
class OneSub
  def outgoing(message, callback)
    unless message['channel'] == '/meta/subscribe'
      return callback.call(message)
    end
    subscription = message['subscription']
    client_id = message['clientId']
    puts "sub = #{subscription} --- client = #{client_id}"
    return callback.call(message)
  end
end


faye_server = Faye::RackAdapter.new(:mount => '/faye', :timeout => 10)
faye_server.add_extension(ServerAuth.new)
faye_server.add_extension(OneSub.new)
faye_server.on(:handshake) do |client_id|
  #puts "#{client_id} handshake"
end
faye_server.on(:subscribe) do |client_id, channel|
  puts "#{client_id} subscribed to #{channel}"
end
faye_server.on(:unsubscribe) do |client_id, channel|
  puts "#{client_id} unsubscribed to #{channel}"
end
faye_server.on(:publish) do |client_id, channel, data|
  puts "#{client_id} published #{data} to #{channel}"
end
faye_server.on(:disconnect) do |client_id|
  puts "#{client_id} disconnected"
end

run faye_server
