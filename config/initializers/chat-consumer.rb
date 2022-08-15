require 'bunny'

connection = Bunny.new(host: 'rabbitmq')
connection.start

channel = connection.create_channel
channel.prefetch(1)
puts ' [*] Waiting for chats. To exit press CTRL+C'
queue=channel.queue("chat")
exchange = channel.fanout("exchange_chat", durable: true)
begin
  queue.subscribe(manual_ack: true, block: false) do |delivery_info, _properties, token|
    puts " [x] Received from chats'#{token}'"
    @chat=Chat.new
    @application = Application.find_by(password_reset_token:token)
    @chat.application_id=@application.id
    @chat.messages_count=0
    @chat.chat_number=@application.chats.size+1 #it uses counter cache so it won't affect database preformance
    @chat.save
    # imitate some work
    puts ' [x] Done'
    channel.ack(delivery_info.delivery_tag)
  end
rescue Interrupt => _
  connection.close
end