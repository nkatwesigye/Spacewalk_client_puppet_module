class spacewalk::xmlrpclib (  ) {
  file { '/usr/lib/python2.7/xmlrpclib.py':
        ensure => 'present', 
        mode   => '0644',
        source => 'puppet:///modules/spacewalk/xmlrpclib.py',
        }
           }
