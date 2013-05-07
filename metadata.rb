name             "openruko"
maintainer       "Éverton Ribeiro"
maintainer_email "everton@azukiapp.com"
license          "All rights reserved"
description      "Installs/Configures openruko"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

depends "apt"
depends "git"
depends "nodejs", "~> 1.1.2"
depends "postgresql", "~> 0.10.1"
depends "erlang", "~> 1.2.0"
