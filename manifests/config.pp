# Class: postfix::config
#
# Configures postfix.  Not intended to be called directly
#
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
#
# === Copyright
#
# Copyright 2013 EvenUp.
#
class postfix::config (
  $mydomain,
  $smtp_relay,
  $tls,
  $tls_bundle,
  $tls_package,
  $relay_networks,
  $relay_domains,
  $relay_host,
  $relay_port,
  $relay_username,
  $relay_password
) {

  file { '/etc/postfix/master.cf':
    owner   => root,
    group   => root,
    mode    => '0444',
    source  => 'puppet:///modules/postfix/master.cf',
    notify  => Class['postfix::service'],
  }

  file { '/etc/postfix/main.cf':
    owner   => root,
    group   => root,
    mode    => '0444',
    content => template('postfix/main.cf.erb'),
    notify  => Class['postfix::service'],
  }

  if ( $postfix::config::relay_username != '' and $postfix::config::relay_password != '' ) {
    file { '/etc/postfix/relay_password':
      owner   => root,
      group   => root,
      mode    => '0440',
      content => template('postfix/relay_password.erb'),
      notify  => Exec['postmap-relay_password'],
    }

    exec { 'postmap-relay_password':
      path        => '/usr/bin:/usr/sbin:/bin:/sbin',
      command     => 'postmap hash:/etc/postfix/relay_password',
      refreshonly => true,
      logoutput   => 'on_failure',
      require     => File['/etc/postfix/relay_password'],
      notify      => Class['postfix::service'],
    }
  }
}
