#!/usr/bin/env ruby
# encoding: utf-8

require "bundler"
Bundler.setup

$:.unshift(File.expand_path("../../../lib", __FILE__))

require "amqp"

EventMachine.run do
  AMQP.connect do |connection|
    channel1  = AMQP::Channel.new(connection)

    exchange = channel1.direct("amqpgem.examples.exchanges.direct", :auto_delete => true, :auto_delete => false)

    q1 = channel1.queue("amqpgem.examples.queues.shared1", :durable => true).bind(exchange, :routing_key => "shared.key1")
    channel1.on_error do |ch, channel_close|
		puts channel_close.reply_text
		connection.close { EventMachine.stop }
	end
	
	q1.subscribe(:exclusive => true, :ack => true) do |payload|
      puts "Queue #{q1.name} on channel 1 received #{payload}"
    end
	
  end
end