# Class: postfix::newaliases
#
# Provides newalises command
#
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@eml.cc>
#
class postfix::newaliases {

  exec { 'newaliases':
    command     => 'newaliases',
    refreshonly => true,
    path        => ['/bin', '/usr/bin'],
  }

}
