#
# Cookbook:: mongodb_server
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'mongodb_server::default' do
  context 'When all attributes are default, on an Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'does apt-update' do
      expect(chef_run).to update_apt_update 'update'
    end

    # it 'adds key to keyring' do
    # end

    # it 'creates mongodb list file' do
    # end

    it 'updates mongodb-org' do
      expect(chef_run).to upgrade_package 'mongodb-org'
    end

    it 'enables and starts mongod service' do
      expect(chef_run).to enable_service 'mongod'
      expect(chef_run).to start_service 'mongod'
    end

    it 'adds repo for mongo' do
      expect(chef_run).to add_apt_repository 'mongodb-org'
    end

    it 'expects to make service template' do
      expect(chef_run).to create_template '/lib/systemd/system/mongod.service'
      template = chef_run.template('/lib/systemd/system/mongod.service')
    end

    it 'expects to make conf template' do
      expect(chef_run).to create_template '/etc/mongod.conf'
      template = chef_run.template('/etc/mongod.conf')
    end

  end
end