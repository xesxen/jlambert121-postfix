require 'spec_helper'

describe 'postfix::install', :type => :class do
  let(:title) { 'postfix' }
  let(:params) { {
    :tls         => true,
    :tls_package => 'openssl',
  } }

  it { should create_class('postfix::install') }
  it { should contain_package('sendmail').with_ensure('absent') }
  it { should contain_package('postfix').with_ensure('latest') }
  it { should contain_package('openssl').with_ensure('latest') }

end
