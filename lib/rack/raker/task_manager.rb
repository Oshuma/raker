require 'open3'

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

      def has?(task)
        tasks.select { |name,desc| task == name }.size == 1
      end

      # Run the specified Rake +task+ and returns the (string) output, or false upon failure.
      # TODO: Maybe move the +rake_opts+ elsewhere.
      def run(task, rake_opts = ['-s'])
        Open3.popen3("#{rake} -f #{@rakefile} #{rake_opts.join(' ')} #{task}") do |stdinn, stdout, stderr|
          err = stderr.read
          raise err unless err.empty?
          stdout.read
        end
      end

    end # TaskManager
  end # Raker
end # Rack
