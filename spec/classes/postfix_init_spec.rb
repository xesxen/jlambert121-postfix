require 'spec_helper'

describe 'postfix', :type => :class do
  let(:facts) { { :concat_basedir => '/var/lib/puppet/concat', :osfamily => 'RedHat', :disposition => 'prod' } }

  it { should create_class('postfix') }
  it { should contain_class('postfix::install') }
  it { should contain_class('postfix::config') }
  it { should contain_class('postfix::service') }
end
