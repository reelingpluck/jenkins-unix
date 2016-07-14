didata-unix Cookbook
====================
*Nix all purpose utility cookbook.

Supported Platforms
------------
#### Platforms (tested)
- Debian, Ubuntu
- CentOS, Red Hat, Fedora

Recipes
-----
#### default.rb
General use, primarily to delete the validation.pem file off client nodes after convertions. All other recipes have `default.rb` recipe included so there's no need to add this to any role or node run_list.

#### users.rb
The `users` recipe will loop through data bag items from a designated public data bag (default is `users`) including appropriate action to be used on a given user. Valid actions are `create`, `lock`, `manage`, `modify`, `nothing`, `remove`, `unlock`. Additionally it will query a hash array from an encrypted data bag item managed by `chef-vault` (default vault data bag: `private_keys` and default data bag item: `user_array`). The vault item stores all sensitive data of the user such as `md5`, `private ssh keys`, `clear password`, etc.

##### Sample data bag items (public and encrypted)
Unencrypted data_bag_item `usertest` example:
```json
{
  "id": "usertest",
  "uid": "8008",
  "groups": [
    "sysadmin"
  ],
  "shell": "/bin/bash",
  "home_dir": "/home/usertest",
  "comment": "Test Account",
  "ssh_keys": "ssh-rsa really really long characters"
}
```
Encrypted `private_keys` data_bag, data_bag_item `user_array`  example:
```json
{
  "id": "user_array",
  "usertest": {
    "passwordclear": "itsmeMario1",
    "passwordmd5": "$6$NbzIK6cs6L$Z3ESdSSsgpX96QTJb.dn1HYUDyBxmA5APxNnrbFiiFkx/P4tSyKzOau14lh6EmZeFbVc4/lE9/eEMf3TTmccN/",
    "private_key": "-----BEGIN RSA PRIVATE KEY-----\nsomething really really long\n-----END RSA PRIVATE KEY-----\n"
  },
  "usertest1": {
    "passwordclear": "itsmeMario2",
    "passwordmd5": "$6$NbzIK6cs6L$Z3ESdSSsgpX96QTJb.dn1HYUDyBxmA5APxNnrbFiiFkx/P4tSyKzOau14lh6EmZeFbVc4/lE9/eEMf3TTmccN/",
    "private_key": "-----BEGIN RSA PRIVATE KEY-----\nsomething really really long\n-----END RSA PRIVATE KEY-----\n"
  }
}
```

#### groups.rb
A simple loop through a `key => value` hash to create unix groups in linux systems.
*Note:*<br>
The `users.rb` recipe depends on this recipe as it creates the group (be default) a user is associated to.

##### Sample `node attribute` usage
```ruby
node['didata-unix']['groups'] = { 
  'sysadmin' => 2300, 
  'users' => 100
}
```

#### package.rb
Simple loop through a array of packages needed to be installed on a given node.

##### Sample `node attribute` usage
```ruby
node['didata-unix']['packages'] = [
  'git',
  'git-flow',
  'git-svn',
  'subversion',
  'build-essential'
]
```

Chef-Vault
----------
To understand how chef-vault works, please read the following blog:
* https://www.chef.io/blog/2013/09/19/managing-secrets-with-chef-vault/ <br>

Further reading is available on the chef-vault cookbook itself:
* https://github.com/opscode-cookbooks/chef-vault

Support & Bugs
--------------
**All support and bugs** should be filed in the [issue] (https://github.com/DimensionDataDevOps/cookbook-didata-unix/issues) page of the repository

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

**Use the git-flow process:**
* http://yakiloo.com/getting-started-git-flow/
* https://www.atlassian.com/git/tutorials/comparing-workflows/feature-branch-workflow

License and Author(s)
-------------------
Author: Eugene Narciso (<eugene.narciso@itaas.dimensiondata.com>)
```text
Copyright:: 2016, Dimension Data Cloud Solutions, Inc.
All rights reserved
```