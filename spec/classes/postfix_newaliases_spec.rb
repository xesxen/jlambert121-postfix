require 'spec_helper'

describe 'postfix::newaliases' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge( {:concat_basedir => '/tmp'} )
        end

        context "default" do
          it { should create_class('postfix::newaliases') }
          it { should contain_exec('newaliases') }
        end
      end # on #{os}
    end # on_supported_os.each
  end # supported operating systems
end # postfix::newalises
