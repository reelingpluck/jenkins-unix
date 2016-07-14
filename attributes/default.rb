# Hosting & Package Attributes
# Packages outside of system package managers (eg; YUM, Apt or Chocolatey) should be put on a http server and define here.
# Override using roles or env as needed.
default['didata-unix']['package_url'] = nil # example: http://node['fqdn']/base

# Data_bag to search; default is users for public and private_keys for encrypted data_bag via chef-vault
# This is useful if you need to create different roles w/ different data_bag names eg; users & service accounts.
default['didata-unix']['pub_data_bag'] = 'users'
default['didata-unix']['priv_data_bag'] = 'private_keys'
default['didata-unix']['priv_data_bag_item'] = 'user_array'

# Default group to search and configure. Must be a key => value (integer) pair
default['didata-unix']['groups'] = { 'sysadmin' => 2300, 'users' => 100 }

# Override using roles or environment. Always set as an array
# Set the linux platform as an array per default below.
case node['platform_family']
when 'debian'
  default['didata-unix']['packages'] = [
    'git',
    'git-flow',
    'git-svn',
    'subversion',
    'build-essential'
  ]
when 'rhel'
  default['didata-unix']['packages'] = [
    'git',
    'git-svn',
    'subversion',
    'subversion-devel'
  ]
end
