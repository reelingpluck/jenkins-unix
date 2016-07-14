require 'spec_helper'

describe 'didata-unix::groups' do
  let(:chef_run) { ChefSpec::ServerRunner.new.converge(described_recipe) }

  it 'creates the sysadmin and users group' do
    expect(chef_run).to create_group('sysadmin')
    expect(chef_run).to create_group('users')
  end
end
