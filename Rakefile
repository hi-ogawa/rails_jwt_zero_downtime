# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

# show raw sql log for any rake tasks
ActiveRecord::Base.logger = Logger.new(STDOUT) if ENV['ACTIVE_RECORD_LOG']
