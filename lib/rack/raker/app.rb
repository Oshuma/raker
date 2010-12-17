require 'erb'

module Rack
  module Raker
    class App
      def initialize(rakefile, path = '/rake')
        @rakefile = rakefile
        @path = path.chomp('/')
        @manager = TaskManager.new(@rakefile)
      end

      def call(env)
        request = Request.new(env)

        if request.path_info =~ /^#{@path}\/$/
          process 'index', lambda { index }
        elsif request.path_info =~ /^#{@path}\/([^\/]+)\/$/ && @manager.has?($1)
          process 'show', lambda { show($1) }
        elsif request.path_info[-1] != 47
          [301, {'Content-Type' => 'text/plain','Location' => "#{request.path}/"}, ['moved permanently']]
        else
          [404, {'Content-Type' => 'text/plain'}, ['not found']]
        end
      end

      def index
        @tasks = @manager.tasks
      end

      def show(task)
        begin
          @output = @manager.run(task)
        rescue Exception => ex
          @error = ex.message
        end
      end

      private

      def process(action, block)
        block.call
        html = render('layout') { render(action) }
        [200, {'Content-Type' => 'text/html'}, [html]]
      end

      def render(view)
        path = ::File.join(::File.dirname(__FILE__), "views/#{view}.erb")
        content = ::File.open(path) { |file| file.read }
        ERB.new(content).result(binding)
      end

    end # App
  end # Raker
end # Rack
