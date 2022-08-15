require 'bunny'

connection = Bunny.new(host: 'rabbitmq')
connection.start

channel = connection.create_channel
channel.prefetch(1)
puts ' [*] Waiting for messages. To exit press CTRL+C'
queue=channel.queue("message")
exchange = channel.fanout("exchange_message", durable: true)
begin
  queue.subscribe(manual_ack: true, block: false) do |delivery_info, _properties, body|
    puts " [x] Received from messages '#{body}'"
    # imitate some work
    values = body.split(",")
    token= values[0]
    chat_number= values[1]
    message=values[2]
    @application = Application.find_by(password_reset_token:token)
    @chat=@application.chats.find_by(chat_number:chat_number)
    @message=Message.new
    @message.body=message
    @message.chat_id= @chat.id
    @message.message_number=@chat.messages.size+1
    @message.save
    puts ' [x] Done'
    channel.ack(delivery_info.delivery_tag)
  end
rescue Interrupt => _
  connection.close
end