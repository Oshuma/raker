module Rack
  module Raker

    autoload :App, 'lib/rack/raker/app'
    autoload :Middleware, 'lib/rack/raker/middleware'
    autoload :TaskManager, 'lib/rack/raker/task_manager'

    # TODO: Add optional URL map.
    def self.new(*args)
      if args.first.class == String
        # run
        Raker::App.new(*args)
      else
        # use
        Raker::Middleware.new(*args)
      end
    end

  end # Raker
end # Rack
