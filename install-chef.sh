#!/bin/sh

if ! gem which chef 2> /dev/null > /dev/null; then
  echo "Installing chef"
  gem install chef --no-ri --no-rdoc
  gem uninstall chef -x
  cd /tmp
  rm -rf 11-stable* chef-11.stable 2>&1 > /dev/null
  wget https://github.com/opscode/chef/archive/11-stable.tar.gz 2> /dev/null
  tar -zxf 11-stable.tar.gz
  cd chef-11-stable
  rake package > /dev/null 2>&1 
  gem install pkg/chef-11.4.0.gem --no-ri --no-rdoc
fi
