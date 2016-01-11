# == Class: postfix
#
# This class configures postfix as either a node listening on localhost which
# forwards mail on to a relayhost or as a relayhost which delivers mail to its
# final destination.
#
# This module is not intended to be a "do it all" postfix module but rather a
# simple module to configure postfix for one of these two scenarios.
#
#
# === Parameters
#
# [*smtp_relay*]
#   Boolean.  If true, this host will forward to final destinatoin.  If false,
#     postfix will forward to relayhost
#   Default: true
#
# [*relay_host*]
#   String.  If smtp_relay == false, what is the next hop for mail?
#   Default: $::domain
#
# [*mydomain*]
#   String.  Local domain of this machine
#   Default: $::domain
#
# [*relay_networks*]
#   String.  Networks that are allowed to relay mail through this host.
#   Default: 127.0.0.1
#
# [*relay_domains*]
#   String.  Domains this machine will relay mail for.
#   Default: ''
#
# [*relay_username*]
#   String.  Username for relayhosts that require SMTP AUTH.
#   Default: ''
#
# [*relay_password*]
#   String.  Password for relayhosts that require SMTP AUTH.
#   Default: ''
#
# [*relay_port*]
#   String.  Port for relayhosts that require SMTP AUTH.
#   Default: 25
#
# [*tls*]
#   Boolean.  Enable TLS for SMTP connections.
#   Default: false
#
# [*tls_bundle*]
#   String.  Path to TLS certificate bundle.
#   Default: Sensible defaults for RedHat and Debian systems, otherwise false.
#
# [*tls_package*]
#   String.  Package containing TLS certificate bundle..
#   Default: Sensible defaults for RedHat and Debian systems, otherwise false.
#
#
# === Examples
#
#   class { 'postfix':
#     smtp_relay  => false,
#     relay_host  => 'mail.internal.com',
#   }
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
class postfix (
  $smtp_relay                   = $postfix::params::smtp_relay,
  $relay_host                   = $postfix::params::relay_host,
  $mydomain                     = $postfix::params::mydomain,
  $relay_networks               = $postfix::params::relay_networks,
  $relay_domains                = $postfix::params::relay_domains,
  $relay_username               = $postfix::params::relay_username,
  $relay_password               = $postfix::params::relay_password,
  $relay_port                   = $postfix::params::relay_port,
  $tls                          = $postfix::params::tls,
  $tls_bundle                   = $postfix::params::tls_bundle,
  $tls_package                  = $postfix::params::tls_package,
  $master_config_services       = $postfix::params::master_config_services,
  $main_options_hash            = $postfix::params::main_options_hash,
  $smtpd_client_restrictions    = $postfix::params::smtpd_client_restrictions,
  $smtpd_helo_restrictions      = $postfix::params::smtpd_helo_restrictions,
  $smtpd_sender_restrictions    = $postfix::params::smtpd_sender_restrictions,
  $smtpd_recipient_restrictions = $postfix::params::smtpd_recipient_restrictions,
  $smtpd_data_restrictions      = $postfix::params::smtpd_data_restrictions,
) inherits postfix::params {

  validate_bool($smtp_relay)
  validate_string($relay_host)
#  validate_num($relay_port)
  validate_string($mydomain)
  validate_string($relay_networks)
  validate_string($relay_domains)
  validate_string($relay_username)
  validate_string($relay_password)
  validate_bool($tls)
  validate_array($master_config_services)
  validate_hash($main_options_hash)
  validate_string($smtpd_client_restrictions)
  validate_string($smtpd_helo_restrictions)
  validate_string($smtpd_sender_restrictions)
  validate_string($smtpd_recipient_restrictions)
  validate_string($smtpd_data_restrictions)

  class { '::postfix::install': } ->
  class { '::postfix::config': } ~>
  class { '::postfix::service': }
  Class['postfix::install'] ~> Class['postfix::service']

}
