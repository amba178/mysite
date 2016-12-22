# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'
require 'rake'
require 'rspec/core/rake_task'

Rails.application.load_tasks

namespace :spec do 
	desc "Run spec with RCov"
	RSpec::Core::RakeTask.new('rcov') do |t|
		t.pattern = 'spec/**/*_spec.rb'
		t.rcov = true
		t.rcov_opts = ['--execlude', '\/Library\/Ruby']
	end
end
