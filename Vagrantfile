# -*- mode: ruby -*-
# vi: set ft=ruby :

require File.join(File.dirname(__FILE__), "vagrant_common")

Vagrant.configure("2") do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # Api node definition
  config.vm.define :api do |conf|
    conf.vm.network :private_network, :ip => "10.10.10.100"

    conf.berkshelf.enabled = true

    conf.vm.provision :chef_solo do |chef|
      # First apply proxy recipe
      proxy_set(chef)

      # Set run list from solo.json
      json_load(chef)
      chef.json["api_run_list"].reject! { |r| r == 'recipe[openruko::dynohost]' }
      chef.json["api_run_list"].each do |recipe_name|
        chef.add_recipe recipe_name
      end
    end
  end

  # Dynohost node definition
  config.vm.define :dynohost do |conf|
    conf.vm.network :private_network, :ip => "10.10.10.101"

    conf.berkshelf.enabled = true

    conf.vm.provision :chef_solo do |chef|
      # First apply proxy recipe
      proxy_set(chef)

      # Set run list from solo.json
      json_load(chef)
      chef.json["openruko"]["apiserver_ip"] = "10.10.10.100"
      chef.json["dyno_run_list"].each do |recipe_name|
        chef.add_recipe recipe_name
      end
    end
  end
end
