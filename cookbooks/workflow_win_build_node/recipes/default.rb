#
# Cookbook Name:: workflow_win_build_node
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#



## irvings stuff goes here


include_recipe 'chef-sugar'


# delivery-base boiled down
# attributes for push jobs stuff
node.default['push_jobs']['allow_unencrypted'] = true
case node['platform_family']
when 'windows'
  node.default['push_jobs']['package_url']      = 'https://packages.chef.io/stable/windows/2008r2/push-jobs-client-2.1.1-1-x86.msi'
  node.default['push_jobs']['package_checksum'] = 'b8e76d54bb931949bcc94a6c764ccebda0e6957820b0c3fe62c96e6c3a184d9f'
end

delivery_cmd = File.join(node['delivery_build']['bin'], 'delivery-cmd')
node.default['push_jobs']['whitelist'] = { 'chef-client'         => 'chef-client',
                                      /^delivery-cmd (.+)$/ => "#{delivery_cmd} '\\1'" }
include_recipe 'push-jobs'


# Make sure client.rb is readable by dbuild
include_recipe 'delivery_build::chef_client'


# delivery_build::_git boiled down
#need to stop ssh-agent if present, or git will fail on windows
powershell_script 'get-process ssh-agent* | stop-process -force'
include_recipe 'git::windows'



# Install the Chef DK
node.override['delivery_build']['chefdk_version'] = '0.15.16'
include_recipe 'delivery_build::chefdk'

gem_package 'knife-windows' do
  # version '0.2.2'
  gem_binary 'C:\opscode\chefdk\embedded\bin\gem'
end


# Create the root delivery job workspace
include_recipe 'delivery_build::workspace'


# skipping - not useful for now
# # Add trusted_certs to chefdk/cacert.pem
# include_recipe 'delivery_build::trusted_certs'
