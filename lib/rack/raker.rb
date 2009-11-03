module Rack
  module Raker

    autoload :App,         'rack/raker/app'
    autoload :Middleware,  'rack/raker/middleware'
    autoload :TaskManager, 'rack/raker/task_manager'

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
