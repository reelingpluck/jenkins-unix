#
# Cookbook Name:: didata-unix
# Recipe:: users
# Author:: Eugene Narciso <eugene.narciso@itaas.dimensiondata.com>
#
# Copyright 2016, Dimension Data Cloud Solutions, Inc.
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'chef-vault'
include_recipe 'didata-unix::default'
include_recipe 'didata-unix::groups'

require 'chef-vault'

pub_data_bag = node['didata-unix']['pub_data_bag']
priv_data_bag = node['didata-unix']['priv_data_bag']
priv_data_bag_item = node['didata-unix']['priv_data_bag_item']

# Use search resource and loop through results
search(pub_data_bag, "*:*").each do |usr|
  priv_usr_data = chef_vault_item(priv_data_bag, priv_data_bag_item)[usr['id']]

  # Manage user
  user usr['id'] do
    supports :manage_home => true
    comment usr['comment']
    uid usr['uid']
    home usr['home_dir']
    shell usr['shell']
    action usr['action']
    password priv_usr_data['passwordmd5']
  end

  # Create ~/.ssh dir if ssh_keys hash is not nil
  directory "#{usr['home_dir']}/.ssh" do
    recursive true
    owner usr['id']
    group usr['id']
    mode '700'
    only_if { !usr['ssh_keys'].nil? }
  end

  # Generate ~/.ssh/authorized_keys if public ssh key exist in the data bag item
  file ::File.join(usr['home_dir'], '.ssh', 'authorized_keys') do
    owner usr['id']
    mode '600'
    content usr['ssh_keys']
    only_if { !usr['ssh_keys'].nil? }
  end

  # Add usr['id'] to groups
  usr['groups'].each do |grp|
    group grp do
      members usr['id']
      append true
      action :manage
    end
  end
end