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
class postfix::config {

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

}
