# Class: postfix::service
#
# Manages the postfix service.  Not intended to be called directly
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
class postfix::service {

  service { 'postfix':
    ensure => running,
    enable => true,
  }

}
