module Rack
  module Raker
    class TaskManager

      attr_accessor :tasks

      def initialize(rakefile)
        @rakefile = rakefile
      end

      # Return an array of Rake tasks.
      def tasks
        output = %x[ rake -f #{@rakefile} -s -T ]
        @tasks ||= output.split("\n").map do |task|
          task.match(/^rake\s([\w:]+)/)[1]
        end
      end

      # Run the specified Rake +task+ and returns the (string) output, or false upon failure.
      # TODO: Maybe move the +rake_opts+ elsewhere.
      def run(task, rake_opts = ['-s'])
        output = %x[ rake -f #{@rakefile} #{rake_opts.join(' ')} #{task} 2>/dev/null ]
        output = false if output.empty?
        output
      end

    end # TaskManager
  end # Raker
end # Rack
