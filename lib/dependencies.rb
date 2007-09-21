require 'capistrano/configuration'

module TaskDependenciesExtension
  
  def self.included(mod)
    mod.send :include, InstanceMethods
    mod.send :alias_method, :task_without_dependencies, :task
    mod.send :alias_method, :task, :task_with_dependencies
  end
  
  module InstanceMethods
    
    def task_with_dependencies(name, options={}, &block)
      dependencies = options[:depends] || []
      dependencies = [dependencies] unless dependencies.is_a?(Array)

      proc = Proc.new do
        dependencies.each do |dependency|
          find_and_execute_task(dependency)
        end
        block.call
      end
      
      task_without_dependencies(name, options, &proc)
    end
        
  end
  
end
Capistrano::Configuration.send :include, TaskDependenciesExtension
Capistrano::Configuration::Namespace.send :include, TaskDependenciesExtension