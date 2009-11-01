require 'sinatra/base'

module Rack
  module Raker
    class App < Sinatra::Base

      set :root, ::File.dirname(__FILE__) + '/app'

      def initialize(*args)
        @args = args
        @rakefile = args.first
        @manager = TaskManager.new(@rakefile)
      end

      # TODO: Show task descriptions (or make an actual UI).
      get '/rake/?' do
        @tasks = @manager.tasks
        erb :index
      end

      get '/rake/:task' do |task|
        @task = task
        @output = @manager.run(task)
        # TODO: Maybe show a helpful failure message.
        redirect '/' unless @output
        erb :show
      end

      not_found do
        redirect '/rake'
      end

    end # App
  end # Raker
end # Rack
