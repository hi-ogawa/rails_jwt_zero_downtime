lock '3.4.0'

set :application, 'jwt_zero_downtime'
set :repo_url, 'git@github.com:hi-ogawa/rails_jwt_zero_downtime.git'
set :deploy_to, '/home/ubuntu/app'
set :branch, ENV["BRANCH"] || "master"
set :scm, :git
set :format, :pretty
set :log_level, :debug
set :pty, false
set :keep_releases, 5

set :linked_files, [
  'config/database.yml',
  'config/secrets.yml',
  'config/settings.yml'
]
set :linked_dirs, ['log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system']

set :puma_config_file, "config/system/puma/#{fetch(:stage)}.rb"
set :nginx_config_file, "config/system/nginx/#{fetch(:stage)}.conf"

namespace :config do
  desc "push .yml files from local"
  task :push, [:filename] do |task, args|
    on roles(:app), in: :parallel do
      files = fetch(:linked_files).select{|f| f.match(args[:filename] || "")}
      files.each do |file|
        upload!(
          file.gsub(".yml", ".#{fetch(:stage)}.yml"),
          "#{shared_path}/#{file}"
        )
      end
    end
  end
end

namespace :puma do
  desc "start"
  task :start do
    on roles(:app) do
      within current_path do
        execute :bundle, "exec puma -C #{release_path}/#{fetch(:puma_config_file)}"
      end
    end
  end

  desc "pumactl (stop, restart, phased-restart, status)"
  task :ctl, [:command] do |task, args|
    on roles(:app) do
      within current_path do
        execute :bundle, "exec pumactl -F #{release_path}/#{fetch(:puma_config_file)} #{args[:command]}"
      end
    end
  end

  after "deploy:published", "" do
    if ENV["NON_PHASED_RESTART"]
      invoke("puma:ctl", "restart")
    else
      # NOTE: `phased-restart` is INCOMPATIBLE with `preload_app!`
      invoke("puma:ctl", "phased-restart")
    end
  end

  desc "copy puma config file"
  task :push_config do
    on roles(:app) do
      upload!("#{fetch(:puma_config_file)}", "#{release_path}/#{fetch(:puma_config_file)}")
    end
  end
end

# NOTE: don't need to manage nginx setting for usual deployment
namespace :nginx do

  desc "restart"
  task :restart do
    execute "sudo service nginx restart"
  end

  desc "push config file from local"
  task :push_config do
    on roles(:web) do
      upload!("#{fetch(:nginx_config_file)}", "#{release_path}/#{fetch(:nginx_config_file)}")
    end
  end

  desc "set nginx config file"
  task :set_config do
    on roles(:web) do
      execute("sudo ln -sf #{release_path}/#{fetch(:nginx_config_file)} /etc/nginx/sites-enabled/")
    end
  end
end

# usage: cap production invoke[db:seed]
desc 'Invoke a rake command on the remote server'
task :invoke, [:command] => 'deploy:set_rails_env' do |task, args|
  on roles(:db) do
    within release_path do
      with :rails_env => fetch(:rails_env) do
        output = capture :rake, args[:command]
        puts "== command output: start =="
        puts output
        puts "== command output: end =="
      end
    end
  end
end

# for capistrano debug
desc 'do nothing'
task :do_nothing do
  binding.pry
end
