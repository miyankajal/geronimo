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

    # Publish some test data in a bit, after all queues are declared & bound
    EventMachine.add_timer(1.2) do
      10.times { |i| exchange.publish("Hello #{i}, direct exchanges world!", :routing_key => "shared.key1", :persistent => true) }
    end

    show_stopper = Proc.new { connection.close { EventMachine.stop; raise "channel error: #{channel_close.reply_text}" } }

    Signal.trap "TERM", show_stopper
    EM.add_timer(10, show_stopper)
  end
end