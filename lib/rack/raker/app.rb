require 'sinatra/base'

module Rack
  module Raker

    class App < Sinatra::Base
      def initialize(*args)
        $stdout.puts "-- DEBUG: App: #{args.inspect}"
        @args = args
        @rakefile = args.first
      end

      get '/' do
        'Rake the shit out of it!'
      end
    end # App

  end # Raker
end # Rack
