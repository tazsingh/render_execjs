module RenderExecJS
  class Renderer
    class << self
      def environment
        @environment
      end

      def environment= new_environment
        @context = nil
        @environment = new_environment
      end

      def coffeescript_environment= new_environment
        if defined? CoffeeScript
          @context = nil
          @environment = CoffeeScript.compile new_environment, :bare => true
        elsif !new_environment.blank?
          puts "Can't find CoffeeScript. Did you forget to add it to your Gemfile?"
        end
      end

      def exec js, options = {}
        if options[:coffee_script]
          js = CoffeeScript.compile js, :bare => true
        end

        context.exec js
      end

      def call func, *args
        context.call func, *args
      end

      private
      def context
        @context ||= ExecJS.compile environment
      end
    end
  end
end