require 'rake/testtask'

Rake::TestTask.new do |t|
	t.pattern = "spec/*_spec.rb"
end
