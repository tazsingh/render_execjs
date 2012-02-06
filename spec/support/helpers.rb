module RenderExecJS
  module Helpers
    class ExecutionError < StandardError
      attr_accessor :output

      def initialize message, output = nil
        super message

        self.output = output
      end

      def message
        "#{super}\nOutput was:\n#{output}"
      end
    end

    def base_dir
      File.expand_path '../../..', __FILE__
    end

    def rails_project_dir
      @@tmpdir ||= Dir.mktmpdir 'tmp', base_dir
    end

    def create_rails_project
      Dir.chdir(rails_project_dir) do
        run_cmd "rails new ."
        File.delete "#{rails_project_dir}/public/index.html"

        working_gems = {
          "rails" => {
            :version => "4.0.0.beta"
          }
        }.merge $gem_options

        File.open "Gemfile", "w" do |f|
          gemfile = <<-GEMFILE
            source 'http://rubygems.org'

            gem 'rails', '~> #{working_gems["rails"][:version]}'
            gem 'sqlite3'
            gem 'render_execjs', :path => '#{base_dir}'
          GEMFILE

          f.write(gemfile.tap do |g|
            working_gems.delete "rails"
            working_gems.each do |gem, options|
              g << "gem '#{gem}', '~> #{options[:version]}'\n"
            end
          end)
        end
      end
    end

    def delete_rails_project
      FileUtils.remove_entry_secure rails_project_dir
      @@tmpdir = nil
    end

    def run_cmd cmd, working_directory = rails_project_dir, clean_env = false, gemfile = "Gemfile", env = {}
      env["BUNDLE_GEMFILE"] = "#{working_directory}/#{gemfile}" if clean_env
      todo = Proc.new do
        r, w = IO.pipe
        Kernel.spawn env, cmd, :out =>w , :err => w, :chdir => working_directory
        w.close
        Process.wait
        output = r.read
        r.close
        unless $?.exitstatus == 0
          raise ExecutionError, "Command failed with exit status #{$?.exitstatus}: #{cmd}", output
        end
        $last_ouput = output
      end

      if clean_env
        Bundler.with_clean_env &todo
      else
        todo.call
      end
    end
  end
end