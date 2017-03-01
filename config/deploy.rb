lock "3.7.2"

set :application, "odot"
set :repo_url, "git@github.com:carlosmorantes/odot.git"
set :deploy_to, '/home/carlos/odot'
set :user, 'carlos'
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}


namespace :deploy do

  %w[start stop restart].each do |command|
    desc 'Manage Unicorn'
    task command do
      on roles(:app), in: :sequence, wait: 1 do
        execute "/etc/init.d/unicorn_#{fetch(:application)} #{command}"
      end
    end
  end

  after :publishing, :restart

end
