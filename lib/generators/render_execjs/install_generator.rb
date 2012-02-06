module RenderExecjs
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../../templates', __FILE__)

      desc 'Installs RenderExecJS'
      def copy_initializer
        template "render_execjs.rb", "config/initializers/render_execjs.rb"
      end
    end
  end
end