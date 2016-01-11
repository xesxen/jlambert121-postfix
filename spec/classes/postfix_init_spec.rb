require 'spec_helper'

describe 'postfix' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge( {:concat_basedir => '/tmp'} )
        end

        context "default" do
          it { should create_class('postfix') }
          it { should contain_class('postfix::params') }
          it { should contain_class('postfix::install') }
          it { should contain_class('postfix::config') }
          it { should contain_class('postfix::service') }
          it { should contain_class('postfix::newaliases') }
        end
      end # on #{os}
    end # on_supported_os.each
  end # supported operating systems
end # postfix
