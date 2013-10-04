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
    ensure  => absent,
    require => Package['postfix'],
  }

  package { 'postfix':
    ensure  => latest,
    notify  => Class['postfix::service'],
  }

}
