require 'helper'

describe "Install Generator" do
  before :all do
    create_rails_project
  end

  after :all do
    delete_rails_project
  end

  it "adds the configuration file" do
    file = "#{rails_project_dir}/config/initializers/render_execjs.rb"

    File.exists?(file).should == false
    run_cmd "rails generate render_execjs:install"
    File.exists?(file).should == true
  end
end