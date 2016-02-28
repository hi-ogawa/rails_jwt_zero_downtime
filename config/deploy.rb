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

## custom tasks ##

namespace :config do
  task :push, [:filename] do |task, args|
    on roles(:app), in: :parallel do
      files = fetch(:linked_files).select{|f| f.match(args[:filename] || "")}
      files.each do |file|
        upload!(
          file.gsub(".yml", ".#{fetch(:stage)}.yml"),
          "#{fetch(:deploy_to)}/shared/#{file}"
        )
      end
    end
  end
end

namespace :deploy do

  namespace :puma do
    task :start do
    end

    task :stop do
    end

    task :restart do
    end

    task :status do
    end
  end

  desc "place nginx config files to where nginx recognizes"
  task :copy_nginx_config do
    on roles(:web) do
      if ENV["COPY_FROM_LOCAL"]
        upload!(
          "config/system/nginx/#{fetch(:stage)}.conf",
          "#{release_path}/config/system/nginx"
        )
      end
      execute "sudo ln -sf #{release_path}/config/system/nginx/#{fetch(:stage)}.conf /etc/nginx/sites-enabled/"
    end
  end
  before :published, :copy_nginx_config
end

# usage: cap production invoke[db:seed]
desc 'Invoke a rake command on the remote server'
task :invoke, [:command] => 'deploy:set_rails_env' do |task, args|
  on roles(:db) do
    within release_path do
      with :rails_env => fetch(:rails_env) do
        rake args[:command]
      end
    end
  end
end

def rsync(from, to)
  "rsync -avz -e 'ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null' --delete #{from} #{to}"
end

# for capistrano debug
desc 'do nothing'
task :do_nothing do
  binding.pry
end
