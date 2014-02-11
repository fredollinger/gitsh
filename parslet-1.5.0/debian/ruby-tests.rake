require 'rspec/core/rake_task'

task :default => :spec
RSpec::Core::RakeTask.new do |t|
  t = "spec/parslet/**/*_spec.rb"
end
