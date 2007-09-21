require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

describe "OnceTaskExtension" do

  it "calls a task multiple times without once" do
    config = Capistrano::Configuration.new
    invoked_times = 0
    config.load do
      task :called_once do
        invoked_times += 1
      end    
    end
    
    config.find_and_execute_task("called_once")
    config.find_and_execute_task("called_once")
    
    invoked_times.should == 2
  end

  it "calls a task multiple times with once equal to false" do
    config = Capistrano::Configuration.new
    invoked_times = 0
    config.load do
      task :called_once, :once => false do
        invoked_times += 1
      end    
    end
    
    config.find_and_execute_task("called_once")
    config.find_and_execute_task("called_once")
    
    invoked_times.should == 2
  end

  it "can define a task that is only called once" do
    config = Capistrano::Configuration.new
    invoked_times = 0
    config.load do
      task :called_once, :once => true do
        invoked_times += 1
      end    
    end
    
    config.find_and_execute_task("called_once")
    config.find_and_execute_task("called_once")
    
    invoked_times.should == 1
  end

  it "can define a task within a namespace that is only called once" do
    config = Capistrano::Configuration.new
    invoked_times = 0
    config.load do
      namespace :some_ns do
        task :called_once, :once => true do
          invoked_times += 1
        end
      end
    end
    
    config.find_and_execute_task("some_ns:called_once")
    config.find_and_execute_task("some_ns:called_once")
    
    invoked_times.should == 1
  end
  
end