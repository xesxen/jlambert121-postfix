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
  $mydomain                     = $postfix::mydomain,
  $smtp_relay                   = $postfix::smtp_relay,
  $tls                          = $postfix::tls,
  $tls_bundle                   = $postfix::tls_bundle,
  $tls_package                  = $postfix::tls_package,
  $relay_networks               = $postfix::relay_networks,
  $relay_domains                = $postfix::relay_domains,
  $relay_host                   = $postfix::relay_host,
  $relay_port                   = $postfix::relay_port,
  $relay_username               = $postfix::relay_username,
  $relay_password               = $postfix::relay_password,
  $master_config_services       = [],
  $main_options_hash            = hash([]),
  $smtpd_client_restrictions    = 'permit_mynetworks, reject',
  $smtpd_helo_restrictions      = undef,
  $smtpd_sender_restrictions    = undef,
  $smtpd_recipient_restrictions = 'permit_mynetworks, reject_unauth_destination',
  $smtpd_data_restrictions      = 'reject_unauth_pipelining'
) {

  validate_array($master_config_services)
  validate_hash($main_options_hash)
  validate_string($smtpd_client_restrictions)
  validate_string($smtpd_helo_restrictions)
  validate_string($smtpd_sender_restrictions)
  validate_string($smtpd_recipient_restrictions)
  validate_string($smtpd_data_restrictions)

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
