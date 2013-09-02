# == Class: postfix::monitoring::sensu
#
# Adds sensu monitoring to postfix hosts
#
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
# === Copyright
#
# Copyright 2013 EvenUp.
#
class postfix::monitoring::sensu {

  # Checking postfix is running
  sensu::check { 'postfix-running':
    handlers  => 'default',
    command   => '/etc/sensu/plugins/check-procs.rb -p /usr/libexec/postfix/master -w 5 -c 10',
  }

  # Check mailq size
  sensu::check { 'postfix-mailq':
    handlers  => 'default',
    command   => '/etc/sensu/plugins/check-mailq.rb -w 5 -c 10',
  }

  sensu::subscription { 'postfix': }

}
