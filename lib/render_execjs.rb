require "active_support/concern"

require "execjs"

require "render_execjs/configuration"
require "render_execjs/renderer"
require "render_execjs/railtie"
require "render_execjs/version"

module RenderExecJS
  include Configuration
end