require 'erb'

module Rack
  module Raker
    class App
      def initialize(rakefile, *args)
        @rakefile = rakefile
        @users = args.pop if args.last.is_a?(Hash)
        @path = (args.first || '/rake').chomp('/')
        @manager = TaskManager.new(@rakefile)
      end

      def call(env)
        request = Request.new(env)

        if request.path_info =~ /^#{@path}\/$/
          process 'index', lambda { index }, env
        elsif request.path_info =~ /^#{@path}\/([^\/]+)\/$/ && @manager.has?($1)
          process 'show', lambda { show($1) }, env
        elsif request.path_info.start_with?(@path) && request.path_info[-1] != 47
          [301, {'Content-Type' => 'text/plain','Location' => "#{request.path}/"}, ['moved permanently']]
        else
          [404, {'Content-Type' => 'text/plain'}, ['not found']]
        end
      end

      def index
        @tasks = @manager.tasks
      end

      def show(task)
        @output, @error = nil, nil
        begin
          @output = @manager.run(task)
        rescue Exception => ex
          @error = ex.message
        end
      end

      private

      def process(action, block, env)
        if @users.nil?
          process_internal(action, block)
        else
          app = Rack::Auth::Digest::MD5.new(lambda { process_internal(action, block) }) do |username|
            @users[username]
          end
          app.realm  = 'Rack::Raker'
          app.opaque = opaque
          app.call(env)
        end
      end

      def opaque
        @opaque ||= @users.key?('opaque') ? @users.delete('opaque') : 'rack-raker'
      end

      def process_internal(action, block)
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
