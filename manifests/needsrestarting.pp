## expose systems state after patching , triggering reboot decisions

class spacewalk::needsrestarting() 
  {
  file { '/bin/needs-restarting':
       source => 'puppet:///modules/spacewalk/needs-restarting',
       mode  => '0755',
                   }
                       } 


