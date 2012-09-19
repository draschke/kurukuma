require 'em-websocket'

EM.run {
  @channel = EM::Channel.new

  EM::WebSocket.start(:host => "localhost", :port => 60000) do |ws|
    sid = nil
    ws.onopen { sid = @channel.subscribe { |msg| ws.send msg } }
    ws.onmessage { |msg| @channel.push "#{sid}: #{msg}" }
    ws.onclose { @channel.unsubscribe(sid) }
  end
}