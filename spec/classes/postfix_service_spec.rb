require 'spec_helper'

describe 'postfix::service', :type => :class do
  let(:title) { 'postfix' }

  it { should create_class('postfix::service') }
  it { should contain_service('postfix') }
end
