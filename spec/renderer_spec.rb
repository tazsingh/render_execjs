require 'helper'

module RenderExecJS
  describe Renderer do
    it "should execute simple JavaScript" do
      Renderer.exec("return 'hello!';").should == "hello!"
    end

    it "should execute JavaScript in the context of environment" do
      RenderExecJS.environment = "var a = 'hi there';"

      Renderer.exec("return a;").should == "hi there"
    end

    it "should render correctly when environment is changed" do
      RenderExecJS.environment = "var a = 'hi there';"
      Renderer.exec("return a;").should == "hi there"

      RenderExecJS.environment = "var b = 'oh hai';"
      Renderer.exec("return b;").should == "oh hai"
    end

    it "should call a function in the environment" do
      RenderExecJS.environment = <<-JS
        function add_three(first, second, third) {
          return first + second + third;
        }
      JS

      Renderer.call("add_three", 1, 2, 3).should == 6
      Renderer.call("add_three", "lol", "cat", "!").should == "lolcat!"
      Renderer.exec("return add_three(
        add_three('l','o','l'),
        add_three('c','a','t'),
        add_three('!',1,'!'));").should == "lolcat!1!"
    end

    it "should raise an error when a function is not in the environment" do
      RenderExecJS.environment = <<-JS
        function add_three(first, second, third) {
          return first + second + third;
        }
      JS

      expect do
        Renderer.call "add_four", 1, 2, 3, 4
      end.to raise_error ExecJS::ProgramError
    end

    it "should raise an error when calling something that isn't a function" do
      RenderExecJS.environment = <<-JS
        var b = 'hai';
      JS

      expect do
        Renderer.call "b", 1, 2, 3
      end.to raise_error ExecJS::ProgramError
    end

    it "should compile and execute CoffeeScript" do
      RenderExecJS.environment <<-JS
        function hello() {
          return 'hi';
        }
      JS

      Renderer.exec("return hello() is hello() is hello()", :coffee_script => true).should == true
    end

    it "should compile and execute a CoffeeScript environment" do
      RenderExecJS.coffeescript_environment <<-CS
        hello = ->
          'hi'
      CS

      Renderer.call("hello").should == "hi"
    end
  end
end