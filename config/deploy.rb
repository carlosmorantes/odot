lock "3.7.2"

set :application, "odot"
set :repo_url, "git@github.com:carlosmorantes/odot.git"
set :deploy_to, '/home/carlos/odot'
set :user, 'carlos'
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end
