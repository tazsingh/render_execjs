require 'helper'

module RenderExecJS
  describe Configuration do
    it "should support a configure block" do
      expect do
        RenderExecJS.configure do
        end
      end.should_not raise_error
    end

    it "should get and set the environment in the configure block" do
      expect do
        RenderExecJS.configure do
          self.environment = "'the environment!'"
        end
      end.should_not raise_error

      RenderExecJS.configure do
        self.environment.should == "'the environment!'"
      end
    end

    it "should allow no 'self.' or equal sign when setting the environment in a configure block" do
      expect do
        RenderExecJS.configure do
          environment "'some environment'"
        end
      end.should_not raise_error

      RenderExecJS.configure do
        self.environment.should == "'some environment'"
      end
    end

    it "should allow configuration of the environment outside of a configuration block" do
      expect do
        RenderExecJS.environment = "'a environment!'"
      end.should_not raise_error

      RenderExecJS.environment.should == "'a environment!'"

      expect do
        RenderExecJS.environment "'another environment!'"
      end.should_not raise_error

      RenderExecJS.environment.should == "'another environment!'"
    end

    it "should be a proxy to Renderer for the environment" do
      RenderExecJS.environment = "'some env'"
      RenderExecJS::Renderer.environment.should == "'some env'"

      RenderExecJS.configure do
        environment "'another env'"
      end

      RenderExecJS::Renderer.environment.should == "'another env'"
    end

    it "should only set coffeescript_environment" do
      expect do
        RenderExecJS.coffeescript_environment = '"#{"a"} coffee #{"environment"}"'
      end.should_not raise_error

      expect do
        RenderExecJS.coffeescript_environment '"#{"a"} coffeescript #{"environment"}"'
      end.should_not raise_error

      expect do
        RenderExecJS.configure do
          coffeescript_environment '"#{"another"} coffee #{"environment"}"'
        end
      end.should_not raise_error

      expect do
        RenderExecJS.coffeescript_environment
      end.should raise_error

      expect do
        RenderExecJS.configure do
          self.coffeescript_environment
        end
      end.should raise_error
    end

    it "should proxy coffeescript_environment to Renderer" do
      RenderExecJS::Renderer.environment = nil

      RenderExecJS.coffeescript_environment = '"#{"some"} coffeescript #{"environment"}"'
      RenderExecJS::Renderer.environment.should_not == nil
    end
  end
end