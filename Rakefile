require 'bundler/setup'
#require 'bundler/gem_tasks'
require 'rake/testtask'

require 'rubocop/rake_task'

Rake::TestTask.new do |t|
  t.test_files = FileList["test/**/*_test.rb"]
  t.libs << "test"
  t.verbose = true
end


desc 'Run RuboCop on the lib directory'
Rubocop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['lib/**/*.rb', 'test/**/*.rb']
  # don't abort rake on failure
  task.fail_on_error = false
end

task :default => [:test]
