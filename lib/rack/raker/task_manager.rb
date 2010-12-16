module Rack
  module Raker
    class TaskManager

      class RakefileNotFound < Exception; end

      attr_accessor :tasks

      def initialize(rakefile)
        raise RakefileNotFound unless ::File.exists?(rakefile)
        @rakefile = rakefile
      end

      def rake
        @rake ||= %x[ whereis rake ].match(/rake: ([^\s]+)/)[1]
      end

      # Return an array of Rake tasks.
      def tasks
        output = %x[ #{rake} -f #{@rakefile} -s -T ]
        @tasks ||= output.split("\n").map do |task|
          task.match(/^rake\s([^\s]+)\s+#\s(.+)/)[1..2]
        end.compact
      end

      # Run the specified Rake +task+ and returns the (string) output, or false upon failure.
      # TODO: Maybe move the +rake_opts+ elsewhere.
      def run(task, rake_opts = ['-s'])
        output = %x[ #{rake} -f #{@rakefile} #{rake_opts.join(' ')} #{task} 2>/dev/null ]
        output = false if output.empty?
        output
      end

    end # TaskManager
  end # Raker
end # Rack
