module Rack
  module Raker
    class TaskManager

      class RakefileNotFound < Exception; end

      attr_accessor :tasks

      def initialize(rakefile)
        raise RakefileNotFound unless File.exists?(rakefile)
        @rakefile = rakefile
      end

      # Return an array of Rake tasks.
      def tasks
        output = %x[ rake -f #{@rakefile} -s -T ]
        @tasks ||= output.split("\n").map do |task|
          rake_line = task.match(/^rake\s([\w:]+)/)
          rake_line ? rake_line[1] : nil
        end.compact
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
