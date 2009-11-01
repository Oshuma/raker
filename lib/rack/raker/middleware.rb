module Rack
  module Raker
    class Middleware

      def initialize(*args)
        @args = args
        @app = args.shift
        @rakefile = args.first
      end

      def call(env)
        request = Request.new(env)
        @status, @headers, @body = @app.call(env)
        return [@status, @headers, @body] unless request.path =~ /^\/rake/
        raker = App.new(@rakefile)
        raker.call(env)
      end

    end # Middleware
  end # Raker
end # Rack
