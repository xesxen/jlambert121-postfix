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
  $mydomain                     = $::postfix::mydomain,
  $smtp_relay                   = $::postfix::smtp_relay,
  $tls                          = $::postfix::tls,
  $tls_bundle                   = $::postfix::tls_bundle,
  $tls_package                  = $::postfix::tls_package,
  $relay_networks               = $::postfix::relay_networks,
  $relay_domains                = $::postfix::relay_domains,
  $relay_host                   = $::postfix::relay_host,
  $relay_port                   = $::postfix::relay_port,
  $relay_username               = $::postfix::relay_username,
  $relay_password               = $::postfix::relay_password,
  $master_config_services       = $::postfix::master_config_services,
  $main_options_hash            = $::postfix::main_options_hash,
  $smtpd_client_restrictions    = $::postfix::smtpd_client_restrictions,
  $smtpd_helo_restrictions      = $::postfix::smtpd_helo_restrictions,
  $smtpd_sender_restrictions    = $::postfix::smtpd_sender_restrictions,
  $smtpd_recipient_restrictions = $::postfix::smtpd_recipient_restrictions,
  $smtpd_data_restrictions      = $::postfix::smtpd_data_restrictions,
) {

  file { '/etc/postfix/master.cf':
    owner   => root,
    group   => root,
    mode    => '0444',
    content => template('postfix/master.cf.erb'),
    notify  => Class['postfix::service'],
  }

  file { '/etc/postfix/main.cf':
    owner   => root,
    group   => root,
    mode    => '0444',
    content => template('postfix/main.cf.erb'),
    notify  => Class['postfix::service'],
  }

  if ( $relay_username and $relay_password ) {
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
