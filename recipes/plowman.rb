include_recipe "erlang"

git "#{node['openruko']['home']}/plowman" do
  user node['user']
  group node['group']
  repository node['openruko']['repositories']['plowman']
  action :checkout
  revision node["versions"]["plowman"]
end

bash "setup-plowman" do
  user node['user']
  group node['group']
  cwd   "#{node['openruko']['home']}/plowman"
  environment Hash['HOME' => node['home']]

  code <<-EOF
  set -e
  if [ ! -f ./bin/activate ]; then
    make
  fi
  EOF
end

bash "setup-plowman-certs" do
  user node['user']
  group node['group']
  cwd   "#{node['openruko']['home']}/plowman"

  code <<-EOF
  rm -fr certs
  make certs
  EOF
end

template "/etc/init/openruko-plowman.conf" do
  source "upstart-openruko-plowman.conf.erb"
  owner "root"
  group "root"
  mode 0644
end
