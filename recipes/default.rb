#
# Cookbook:: mongodb_server
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

apt_update

package 'mongodb-org' do
	action :purge 
end

# execute 'add key from keyserver' do
# 	command 'sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927'
# end

apt_repository 'mongodb-org' do
  uri 'http://repo.mongodb.org/apt/ubuntu'
  keyserver 'hkp://keyserver.ubuntu.com:80'
  key 'EA312927'
  distribution "xenial/mongodb-org/3.2"
  components ['multiverse']
end

# execute 'create MongoDB list item' do
# 	command 'echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list'
# end

apt_update

package 'mongodb-org' do
	action :upgrade 
end

# file '/home/ubuntu/environment/db/mongod.conf' do
# 	owner 'root'
# 	group 'root'
# 	content ::File.open('/etc/mongod.conf').read 
# 	action :create
# end

file '/etc/mongod.conf' do
	action :delete
end

template '/etc/mongod.conf' do
  source 'mongod.conf.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

template '/lib/systemd/system/mongod.service' do
  source 'mongod.service.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

service 'mongod' do
	supports status: true, restart: true, reload: true
	action [:enable, :start]
end