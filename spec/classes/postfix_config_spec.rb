require 'spec_helper'

describe 'postfix::config', :type => :class do
  let(:facts) { { :osfamily => 'RedHat' } }

  let(:pre_condition) { 'class { "postfix":
    mydomain       => "example.tld",
    smtp_relay     => false,
    tls            => true,
    tls_bundle     => "/etc/ssl/certs/ca-certificates.crt",
    tls_package    => "ca-certificates",
    relay_networks => "127.0.0.1",
    relay_domains  => "example.tld",
    relay_host     => "mail.example.tld",
    relay_port     => "25",
    relay_username => "username",
    relay_password => "password",
  }' }

  it { should create_class('postfix::config') }
  it { should contain_file('/etc/postfix/master.cf') }
  it { should contain_file('/etc/postfix/main.cf') }

end
