What is it?
===========

A puppet module that installs and configures postfix to either accept mail on
locahost only and forward it on to a server responsible for sending it to its
final destination, or as a server accepting mail and responsible to forwarding
it to its final destination. This is to keep this module simple and is not
intended to handle mailboxes, spam/av filtering, or any advanced postfix
configs, but rather to configure internal email servers for utility purposes.


Usage:
------

If you have a webserver that sends mail and you would like a local SMTP server
running you trust not to loose the message if upstream is down:
<pre>
  class { 'postfix':
    relay_domains => 'myotherdomain.com',
  }
</pre>
Note: This assumes $::domain has proper MX records in place and the configured
MX hosts will accept mail from this host.


To configure a relay server responsible for delivering all of those messages
(and assuming your internal network is 10/8):
<pre>
  class { 'postfix':
    smtp_relay      => true,
    relay_networks  => '10.0.0.0/8',
  }
</pre>


Known Issues:
-------------
Only tested on CentOS 6


License:
_______

Released under the Apache 2.0 licence


Contribute:
-----------
* Fork it
* Create a topic branch
* Improve/fix (with spec tests)
* Push new topic branch
* Submit a PR
