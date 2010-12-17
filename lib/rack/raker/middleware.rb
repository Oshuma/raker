module Rack
  module Raker
    class Middleware

      def initialize(*args)
        @rack = args.shift
        @app  = App.new(*args)
      end

      def call(env)
        res = @app.call(env)
        res = @rack.call(env) if res[0] == 404
        res
      end

    end # Middleware
  end # Raker
end # Rack
