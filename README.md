### Motivation

This repository is for understanding:

- zero downtime deployment
  - ansible
  - aws (sdk automation) (test on vagrant is enough?)
  - capistrano
  - puma

- jwt based authentication within multi backend and multi frontend

### Notes

- ansible
  - check if postgresql connection works:
    - run `psql -h 192.168.33.10 -U <username> -W zerodb_production`
      from the server whose role is `db`

- zero downtime by puma
  - imitate slow server starts with `config/initializers/slowdown_server_start.rb`
  - `pumactl restart` with `preload_app!`: even though
  - `pumactl phased-restart`:

### References

- ansible:
  - ruby:
    - https://github.com/geerlingguy/ansible-role-ruby
  - postgresql:
    - https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-14-04
    - https://github.com/radar/ansible-rails-app/tree/master/roles/database

- puma, nginx:
  - http://ruby-journal.com/how-to-setup-rails-app-with-puma-and-nginx/
  - https://www.digitalocean.com/community/tutorials/how-to-deploy-a-rails-app-with-puma-and-nginx-on-ubuntu-14-04

- puma
  - various way of restart: https://github.com/puma/puma/tree/v2.14.0#restart
  - about thread safety: https://bearmetal.eu/theden/how-do-i-know-whether-my-rails-app-is-thread-safe-or-not/
  - deploy: https://github.com/seuros/capistrano-puma/blob/master/lib/capistrano/tasks/puma.rake
  - heroku doc: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server
  - rails server comparison: https://www.engineyard.com/articles/rails-server

- jwt
  - tutorial: https://egghead.io/series/angularjs-authentication-with-jwt
  - auth0 articles:
    - https://auth0.com/blog/2014/01/27/ten-things-you-should-know-about-tokens-and-cookies/
    - https://auth0.com/blog/2014/01/07/angularjs-authentication-with-cookies-vs-token/
  - ruby library: https://github.com/jwt/ruby-jwt
  - SSO (single sign on): https://auth0.com/docs/sso/single-sign-on
