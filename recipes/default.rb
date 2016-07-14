#
# Cookbook Name:: didata-unix
# Recipe:: default
# Author:: Eugene Narciso <eugene.narciso@itaas.dimensiondata.com>
#
# Copyright 2016, Dimension Data Cloud Solutions, Inc.
#
# All rights reserved - Do Not Redistribute
#

# Make chef-client remove the validation pem if it exists.
node.override['chef-client']['delete_validation'] = true

include_recipe 'chef-client::delete_validation'
