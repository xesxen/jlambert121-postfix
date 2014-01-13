require 'spec_helper'

describe 'postfix', :type => :class do
  let(:facts) { { :concat_basedir => '/var/lib/puppet/concat' } }

  it { should create_class('postfix') }
  it { should contain_class('postfix::install') }
  it { should contain_class('postfix::config') }
  it { should contain_class('postfix::service') }

  context 'logging' do
    let(:params) { { :logging => 'beaver' } }
    it { should include_class('postfix::logging::beaver') }
  end

end
