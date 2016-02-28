# references:
#  - https://github.com/puma/puma/blob/v2.14.0/examples/config.rb

directory "/home/ubuntu/app/current"
rackup "config.ru"
environment "production"
daemonize true

pidfile "tmp/pids/puma.pid"
state_path "tmp/pids/puma.state"
stdout_redirect "log/puma.out.log", "log/puma.err.log", true

bind "unix:///home/ubuntu/app/shared/tmp/sockets/puma.sock"

threads 1, 6
workers 2

preload_app!

on_worker_boot do
  ActiveRecord::Base.establish_connection
end
