name             'didata-unix'
maintainer       'Dimension Data Cloud Solutions, Inc.'
maintainer_email 'eugene.narciso@itaas.dimensiondata.com'
license          'All rights reserved'
description      'Installs/Configures didata-unix'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.1.0'
source_url       'https://github.com/DimensionDataDevOps/cookbook-didata-unix' if respond_to?(:source_url)
issues_url       'https://github.com/DimensionDataDevOps/cookbook-didata-unix/issues' if respond_to?(:issues_url)

%w(ubuntu debian redhat centos fedora).each do |os|
  supports os
end

depends 'apt', '~> 4.0.0'
depends 'chef-client', '4.6.0'
depends 'chef-vault', '~> 1.3.3'
