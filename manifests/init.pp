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
# [*logging*]
#   String.  Additonal logging inclusion
#   Default: ''
#   Valid values: '', beaver
#
# [*monitoring*]
#   String.  What monitoring to include
#   Default: ''
#   Valid values: '', sensu
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
  $smtp_relay     = false,
  $relay_host     = $::domain,
  $mydomain       = $::domain,
  $relay_networks = '127.0.0.1',
  $relay_domains  = '',
  $logging        = '',
  $monitoring     = '',
){

  class { 'postfix::install': }
  class { 'postfix::config': }
  class { 'postfix::service': }

  case $logging {
    'beaver': {
      include postfix::logging::beaver
    }
    default: {}
  }

  case $monitoring {
    'sensu':  {
      include postfix::monitoring::sensu
    }
    default: {}
  }

  # Containment
  anchor { 'postfix::begin': } ->
  Class['postfix::install'] ->
  Class['postfix::config'] ->
  Class['postfix::service'] ->
  anchor { 'postfix::end': }

}
