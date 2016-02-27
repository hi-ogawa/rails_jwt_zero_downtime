__motivation__

- zero downtime
  - ansible
  - aws (sdk automation) (test on vagrant is enough?)
  - capistrano
  - puma

- jwt based authentication

__questions__

- how to test "zero downtime"-ness
  - locally monitor api endpoint for each 1 sec.
- how to imitate server restart taking long:
  - A. `config/initializers/slowdown_server_start.rb`
