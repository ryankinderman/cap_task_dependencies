require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

describe "TaskDependenciesExtension" do

  it "supports dependencies" do
    config = Capistrano::Configuration.new
    invoked_dep = 0
    config.load do
      task :dep_task do
        invoked_dep += 1
      end
      task :some_task, :depends => :dep_task do
        invoked_dep.should == 1
      end      
    end  
    
    config.find_and_execute_task("some_task")      
  end
  
  it "calls dependent tasks in the order in which they are given" do
    config = Capistrano::Configuration.new
    invoked_dep = 0
    config.load do
      task :dep_task1 do
        invoked_dep.should == 0
        invoked_dep += 1
      end
      task :dep_task2 do
        invoked_dep.should == 1
        invoked_dep += 1
      end
      task :some_task, :depends => [:dep_task1, :dep_task2] do
        invoked_dep.should == 2
      end      
    end  
    
    config.find_and_execute_task("some_task")          
  end

  it "supports dependencies in other namespaces" do
    config = Capistrano::Configuration.new
    invoked_dep = 0
    config.load do
      namespace :dependencies do
        task :some_task do
          invoked_dep += 1
        end
      end
      task :some_task, :depends => "dependencies:some_task" do
        invoked_dep.should == 1
      end      
    end  
    
    config.find_and_execute_task("some_task")
  end
  
end