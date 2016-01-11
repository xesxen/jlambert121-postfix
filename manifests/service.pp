# Class: postfix::service
#
# Manages the postfix service.  Not intended to be called directly
#
class postfix::service {

  service { 'postfix':
    ensure => running,
    enable => true,
  }

}
