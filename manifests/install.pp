# Class: postfix::install
#
# Manges the postfix package.  Not intended to be called directly
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
class postfix::install {

  package { 'sendmail':
    ensure => absent,
  }

  package { 'postfix':
    ensure  => latest,
    require => Package['sendmail'],
    notify  => Class['postfix::service'],
  }

}
