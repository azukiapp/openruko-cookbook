include_recipe "openruko::default"

package "htop"
package "ruby1.9.1-dev"
package "libxslt-dev"
package "libxml2-dev"

bash "install bundler" do
  code <<-EOF
    sudo su - #{node['user']} -c "gem install bundler --no-rdoc --no-ri"
  EOF

  not_if "sudo su - #{node['user']} -c 'gem which bundler'"
end

bash "run bundler install" do
  code <<-EOF
    sudo su - #{node['user']} -c "cd /vagrant && bundle install"
  EOF
end
