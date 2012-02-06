module RenderExecJS
  class Railtie < ::Rails::Railtie
    initializer "render_execjs.setup" do
      ActionController::Renderers.add :execjs do |obj, options|
        RenderExecJS::Renderer.exec obj
      end

      if defined? CoffeeScript
        ActionController::Renderers.add :execcs do |obj, options|
          RenderExecJS::Renderer.exec obj, :coffee_script => true
        end
      end
    end
  end
end