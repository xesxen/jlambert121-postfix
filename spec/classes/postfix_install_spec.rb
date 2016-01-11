require 'spec_helper'

describe 'postfix::install' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge( {:concat_basedir => '/tmp'} )
        end

        context "default" do
          it { should create_class('postfix::install') }
          it { should contain_package('sendmail').with_ensure('absent') }
          it { should contain_package('postfix').with_ensure('latest') }
          it { should_not contain_package('openssl') }
        end

        describe 'with ssl' do
          let(:params) do
            {
              :tls         => true,
              :tls_package => 'openssl',
            }
          end

          it { should create_class('postfix::install') }
          it { should contain_package('sendmail').with_ensure('absent') }
          it { should contain_package('postfix').with_ensure('latest') }
          it { should contain_package('openssl').with_ensure('latest') }
        end
      end # on #{os}
    end # on_supported_os.each
  end # supported operating systems
end # postfix::install
