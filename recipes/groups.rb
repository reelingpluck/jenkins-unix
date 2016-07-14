#
# Cookbook Name:: didata-unix
# Recipe:: groups
# Author:: Eugene Narciso <eugene.narciso@itaas.dimensiondata.com>
#
# Copyright 2016, Dimension Data Cloud Solutions, Inc.
#
# All rights reserved - Do Not Redistribute
#

node['didata-unix']['groups'].each do |name, id|
  group name do
    gid id
    action [:create]
  end
end