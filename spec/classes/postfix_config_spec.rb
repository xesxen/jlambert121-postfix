require 'spec_helper'

describe 'postfix::config', :type => :class do
  let(:title) { 'postfix' }

  it { should create_class('postfix::config') }
  it { should contain_file('/etc/postfix/master.cf') }
  it { should contain_file('/etc/postfix/main.cf') }

end
