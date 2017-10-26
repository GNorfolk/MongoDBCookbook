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

    # it 'adds key to keyring' do
    # end

    # it 'creates mongodb list file' do
    # end

    it 'updates mongodb' do
      expect(chef_run).to upgrade_package 'mongodb'
    end

    it 'enables and starts mongod service' do
      expect(chef_run).to enable_service 'mongod'
      expect(chef_run).to start_service 'mongod'
    end

  end
end