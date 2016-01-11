require 'spec_helper'

describe 'postfix::config' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge( {:concat_basedir => '/tmp'} )
        end

        context "default" do
          it { should create_class('postfix::config') }
          it { should contain_file('/etc/postfix/master.cf') }
          it { should contain_file('/etc/postfix/main.cf') }
        end
      end # on #{os}
    end # on_supported_os.each
  end # supported operating systems
end # postfix::config
