set :application, "vida.fm"

set :deploy_to, "/home/vidafm/dev/#{application}"

set :scm, :git
set :repository,  "git@github.com:moregg/vidafm.git"
set :branch, "master"
set :deploy_via, :remote_cache

set :user, 'vidafm'
set :ssh_options, { :forward_agent => true }
default_run_options[:pty] = true

set :rvm_ruby_string, 'ruby-1.8.7-p352@rails3.1'

role :web, "api.vida.fm:33356"                         # Your HTTP server, Apache/etc
role :app, "api.vida.fm:33356"                          # This may be the same as your `Web` server
role :db,  "api.vida.fm:33356", :primary => true # This is where Rails migrations will run

# $:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'rvm/capistrano'
require 'bundler/capistrano'

after 'deploy:update_code', 'deploy:symlink_db'
after "deploy", "rvm:trust_rvmrc"
# before "bundle:install", "bundler:set_server_gems"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  desc "Symlinks the database.yml"
  task :symlink_db, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
  end
  desc "Symlinks the android_download.yml"
  task :symlink_download_yml, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/config/download.yml #{release_path}/config/download.yml"
  end
end

namespace :rvm do
  task :trust_rvmrc do
    run "rvm rvmrc trust #{release_path}"
  end
end

namespace :bundler do
  task :set_server_gems do
    ["Gemfile"].each do |f|
      run "cp #{release_path}/#{f}.server #{release_path}/#{f}"
    end
  end
end

require './config/boot'
require 'airbrake/capistrano'
