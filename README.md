#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with postfix](#setup)
    * [What postfix affects](#what-postfix-affects)
    * [Beginning with postfix](#beginning-with-postfix)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

A puppet module to install and configure [postfix](https://www.postfix.org/).

## Module Description

A puppet module that installs and configures postfix to either accept mail on locahost only and forward it on to a server responsible for sending it to its final destination, or as a server accepting mail and responsible to forwarding it to its final destination. This is to keep this module simple and is not intended to handle mailboxes, spam/av filtering, or any advanced postfix configs, but rather to configure internal email servers for utility purposes.


## Setup

### What postfix affects

* postfix package
* postfix configuration
* postfix service

### Beginning with postfix

postfix can be installed simply by including the module:

```puppet
    class { 'postfix': }
```

## Usage

If you have a webserver that sends mail and you would like a local SMTP server running you trust not to loose the message if upstream is down:

```puppet
  class { 'postfix':
    relay_domains => 'myotherdomain.com',
  }
```
Note: This assumes $::domain has proper MX records in place and the configured MX hosts will accept mail from this host.


To configure a relay server responsible for delivering all of those messages (and assuming your internal network is 10/8):
```puppet
  class { 'postfix':
    smtp_relay      => true,
    relay_networks  => '10.0.0.0/8',
  }
```

## Reference

### Public classes

#### Class: `postfix`

##### `smtp_relay`

Boolean.  If true, this host will forward to final destination.  If false, postfix will forward to relayhost
Default: true

##### `relay_host`

String.  If smtp_relay == false, what is the next hop for mail?
Default: $::domain


##### `mydomain`

String.  Local domain of this machine
Default: $::domain

##### `relay_networks`

String.  Networks that are allowed to relay mail through this host.
Default: 127.0.0.1

##### `relay_domains`

String.  Domains this machine will relay mail for.
Default: undef

##### `relay_username`

String.  Username for relayhosts that require SMTP AUTH.
Default: undef

##### `relay_password`

String.  Password for relayhosts that require SMTP AUTH.
Default: undef

##### `relay_port`

String.  Port for relayhosts that require SMTP AUTH.
Default: 25

##### `tls`

Boolean.  Enable TLS for SMTP connections.
Default: false

##### `tls_bundle`

String.  Path to TLS certificate bundle.
Default: Sensible defaults for RedHat and Debian systems, otherwise false.

##### `tls_package`

String.  Package containing TLS certificate bundle..
Default: Sensible defaults for RedHat and Debian systems, otherwise false.

##### `master_config_services`

Array.  List of additional services to be included in the master.cf
Default: []

##### `main_options_hash`

Hash.  Additional options to specify in the main.cf.  Format is {'parameter' => 'value'}
Default: {}

##### `smtpd_client_restrictions`

String.  Value of the smtpd_client_restrictions parameter.
Default: 'permit_mynetworks, reject'

##### `smtpd_helo_restrictions`

String.  Value of the smtpd_helo_restrictions parameter.
Default: undef

##### `smtpd_sender_restrictions`

String.  Value of the smtpd_sender_restrictions parameter.
Default: undef

##### `smtpd_recipient_restrictions`

String.  Value of the smtpd_recipient_restrictions parameter.
Default: 'permit_mynetworks, reject_unauth_destination'

##### `smtpd_data_restrictions`

String Value of the smtpd_data_restrictions parameter.  
Default: 'reject_unauth_pipelining'

### Private classes

#### Class: `postfix::config`

Writes the postfix configuration

#### Class: `postfix::install`

Manages the postfix package

#### Class: `postfix::service`

Manages the postfix service


## Limitations

This has only been tested on CentOS 6 and 7.

## Development

Improvements and bug fixes are greatly appreciated.  See the [contributing guide](https://github.com/jlambert121/jlambert121-postfix/CONTRIBUTING.md) for information on adding and validating tests for PRs.

## Changelog / Contributors

[Changelog](https://github.com/jlambert121/jlambert121-postfix/blob/master/CHANGELOG)

[Contributors](https://github.com/jlambert121/jlambert121-postfix/graphs/contributors)
