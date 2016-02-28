__motivation__

- zero downtime
  - ansible
  - aws (sdk automation) (test on vagrant is enough?)
  - capistrano
  - puma

- jwt based authentication

__notes__

- check if postgresql connection works:
  - from the server whose role is `db`
    - `psql -h 192.168.33.10 -U <username> -W zerodb_production`


__questions__

- how to test "zero downtime"-ness
  - locally monitor api endpoint for each 1 sec.
- how to imitate server restart taking long:
  - A. `config/initializers/slowdown_server_start.rb`

__references__

- ansible:
  - ruby:
    - https://github.com/geerlingguy/ansible-role-ruby
  - postgresql:
    - https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-14-04
    - https://github.com/radar/ansible-rails-app/tree/master/roles/database

- puma, nginx:
  - various way of restart: https://github.com/puma/puma/tree/v2.14.0#restart
  - http://ruby-journal.com/how-to-setup-rails-app-with-puma-and-nginx/
  - https://www.digitalocean.com/community/tutorials/how-to-deploy-a-rails-app-with-puma-and-nginx-on-ubuntu-14-04
  - https://github.com/seuros/capistrano-puma/blob/master/lib/capistrano/tasks/puma.rake
