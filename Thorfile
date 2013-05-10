# encoding: utf-8

require 'bundler'
require 'bundler/setup'
require 'thor/foodcritic'
require 'berkshelf/thor'

class Openruko < Thor
  desc "logs", "tail logs files"
  method_option :files  , :default => ["/var/log/openruko/*"], :type => :array, :aliases => "-f", :desc => "list of files to tail"
  method_option :wait   , :default => true, :type => :boolean, :aliases => "-w", :desc => "wait for additional data to be appended"
  method_option :colored, :default => true, :type => :boolean, :aliases => "-c", :desc => "colored output"
  method_option :server , :default => "api", :aliases => "-s", :desc => "virtual box server to execute cmd"
  def logs
    c = {
      :no     => '"\033[0m"',
      :red    => '"\033[1;31m"',
      :green  => '"\033[1;32m"',
      :yellow => '"\033[1;33m"',
      :blue   => '"\033[1;34m"',
    }

    roles = {
      '\[info\]'  => 'blue',
      '\[error\]' => 'red',
      '\[post\]'  => 'yellow',
      '\[get\]'   => 'yellow',
    }

    awk = "awk '{
      #{c.map {|k, c| "#{k} = #{c}" } .join("\n")}
      if ($0 ~ /^==/) print green $0 no
      #{roles.map {|r, c| "else if ($0 ~ /#{r}/) print #{c} $0 no" } .join("\n")}
      else print $0
    }'"

    wait = options[:wait] ? '-f' : ''
    colored = options[:colored] ? "| #{awk}" : ''
    exec("vagrant ssh -c \"tail #{wait} #{options[:files].join(" ")}\" #{options[:server]} #{colored}")
  end

  desc "service", "services manage"
  method_option :server , :default => "api", :aliases => "-s", :desc => "virtual box server to execute cmd"
  def service(serv, action)
    exec("vagrant ssh -c \"sudo service #{serv} #{action}\" #{options[:server]}")
  end

private

  def exec(cmd)
    pid = spawn(cmd)

    Signal.trap("SIGINT") do
      Process.kill("SIGINT", pid)
    end

    Process.wait(pid)
  end
end
