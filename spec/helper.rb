require 'rubygems'
require 'bundler/setup'

require 'rails'
require 'render_execjs'
require 'coffee-script'

require 'tmpdir'
require 'fileutils'

$gem_options = {}
possible_dev_dependencies = %w[rails execjs coffeescript]
Bundler.load.specs.each do |s|
  if possible_dev_dependencies.include? s.name
    $gem_options[s.name] = {
      :version => s.version.to_s
    }.tap do |hash|
      hash[:path] = s.full_gem_path if File.exists?("#{s.full_gem_path}/#{s.name}.gemspec")
    end
  end
end

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each do |f|
  require f
end

RSpec.configure do |config|
  config.include RenderExecJS::Helpers
end