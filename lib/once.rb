require 'capistrano/configuration'

module OnceTaskExtension
  
  def self.included(mod)
    mod.send :include, InstanceMethods
    mod.send :alias_method, :task_without_execution_once, :task
    mod.send :alias_method, :task, :task_with_execution_once
  end
  
  module InstanceMethods
    
    def task_with_execution_once(name, options={}, &block)
      once = options[:once] || false
      proc = block
      if once
        called = false
        task = Capistrano::TaskDefinition.new(name, self, options, &block)
        proc = Proc.new do
          unless called
            task.body.call
          else
            logger.debug "skipping execution of `#{task.fully_qualified_name}': already called"
          end
          called = true
        end
      end
      
      task_without_execution_once(name, options, &proc)
    end
            
  end
  
end
Capistrano::Configuration.send :include, OnceTaskExtension
Capistrano::Configuration::Namespace.send :include, OnceTaskExtension