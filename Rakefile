require 'rake'
require 'spec/rake/spectask'

desc "Run all examples"
Spec::Rake::SpecTask.new('examples') do |t|
  t.spec_files = FileList['examples/**/*.rb']
  t.spec_opts = ["--colour", "--format", "progress", "--loadby", "mtime", "--reverse"]
end

task :default => :examples
