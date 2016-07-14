#
# Cookbook Name:: didata-unix
# Recipe:: packages
# Author:: Eugene Narciso <eugene.narciso@itaas.dimensiondata.com>
#
# Copyright 2016, Dimension Data Cloud Solutions, Inc.
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'didata-unix::default'

# Update apt-get if platform_family == debian
if node['platform_family'] == 'debian'
  include_recipe 'apt'
end

packages = node['didata-unix']['packages'].to_a # Making sure this is an array
packages.each do |pkg|
  package pkg
end
