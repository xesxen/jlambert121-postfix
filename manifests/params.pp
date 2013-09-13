# Class:: postfix::params
#
#
class postfix::params {
  $smtp_relay     = false
  $relay_host     = $::domain
  $mydomain       = $::domain
  $relay_networks = '127.0.0.1'
  $relay_domains  = ''
  $relay_username = ''
  $relay_password = ''
  $relay_port     = 25
  $tls            = false
  $logging        = ''
  $monitoring     = ''

  case $::osfamily {
    'RedHat': {
      $tls_bundle = '/etc/pki/tls/certs/ca-bundle.crt'
      $tls_package = 'openssl'
    }
    'Debian': {
      $tls_bundle = '/etc/ssl/certs/ca-certificates.crt'
      $tls_package = 'ca-certificates'
    }
    default: {
      $tls_bundle = false
      $tls_package = false
    }
  }
} # Class:: postfix::params
