# == Class: postfix::logging::beaver
#
# Adds beaver log aggregation to postfix hosts
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
class postfix::logging::beaver {

  beaver::stanza { '/var/log/maillog':
    type    => 'syslog',
    tags    => ['maillog', $::disposition],
  }

}
