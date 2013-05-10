# openruko-cookbook

Chef recipes for bootstrapping [OpenRuko](https://github.com/openruko).

Both a Vagrantfile for running local development environments and, using Vagrant 1.2, for deploying to VPSs.

# Requirements

- Vagrant 1.2 or major
- Ruby 1.9.2 or major

# Install

```bash
$ git clone https://github.com/azukiapp/openruko-cookbook.git
$ cd openruko-cookbook
$ gem install bundler --no-ri --no-rdoc
$ bundle install
$ vagrant plugin install vagrant-gem
$ vagrant plugin install vagrant-berkshelf
$ vagrant gem install berkshelf --no-ri --no-rdoc
$ vagrant up
```

Add in `/etc/hosts`:

```
33.33.33.10 mymachine.me php.mymachine.me rack.mymachine.me node.mymachine.me
```

# Usage

In a terminal:

```bash
$ cd openruko-cookbook
$ thor openruko:logs
```

In other terminal, connect to the server with SSH, and create a new project (we will use node.js):

```bash
$ vagrant ssh api
$ cd /vagrant/openruko
$ mkdir myapp && cd myapp
$ git init
$ npm init
$ cat > index.js << EOF
var http = require('http');
http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('Hello World\n');
}).listen(process.env.PORT);
console.log('Server running');
EOF

$ cat > Procfile << EOF
web: node index.js
EOF

$ git add -A
$ git commit -m 'fisrt commit'

$ ~/openruko/client/openruko keys:add

$ ~/openruko/client/openruko create myapp
# email: rukosan@openruko.com
# Password: rukosan

$ git push heroku master
$ curl http://myapp.mymachine.me:8080/
```

# Author

Author:: Éverton Antônio (<nuxlli@gmail.com>)
