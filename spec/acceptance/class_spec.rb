require 'spec_helper_acceptance'

describe 'postfix classes' do
  context 'defaults' do
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      class { 'postfix':
        relay_host => 'example.com',
        mydomain   => 'example.com',
      }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

    describe package('sendmail') do
      it { is_expected.not_to be_installed }
    end

    describe package('postfix') do
      it { is_expected.to be_installed }
    end

    describe service('postfix') do
      it { is_expected.to be_running }
      it { is_expected.to be_enabled }
    end

    describe port(25) do
      it { should be_listening }
    end
  end
end
