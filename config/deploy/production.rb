if ENV["ON_VAGRANT"]
  server "192.168.50.4", user: "ubuntu", roles: ["app", "web", "db"]
end

set :ssh_options, forward_agent: true
