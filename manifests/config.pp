#Class installs the rhn_client and registers the system into spacewalk 
# Author nkatwesigye@gmail.com 

class spacewalk::config (
        $spacewalk_server  = 'server1.domain.com',
        $osflavour_key     = 'activation_key',
        $envapp_key        = 'envapp_key',
        $datacenter_key    = 'ACTIVATION_KEY',
        $spacewalkchannels = 'centos-7.3',
) {

  # Enforce rhn_client checkin interval 
     $spacewalk_checkin_interval = 'INTERVAL=60'
     # update file rhnsd
     file { "/etc/sysconfig/rhn/rhnsd":
      mode    => '600',
      owner   => "root",
      group   => "root",
      content => $spacewalk_checkin_interval,
      notify  => Service["rhnsd"], # Restart rhnsd server if being updated
         }

    #Ensure rhnsd service is running
     service { "rhnsd":
       ensure  => "running",
       enable  => "true",
                  }
   # Register system into spacewalk , with the respective activation keys for groups 
   #, channels and puppet environment 
        $channel_labels= $spacewalkchannels.join('\|')
        if $facts['os']['name'] =='Ubuntu'{
                exec { "Register client with spacewalk Server $channel_labels":
                command  => "/usr/sbin/rhnreg_ks --serverUrl= \
                http://${spacewalk_server}/XMLRPC --activationkey=\ 
               ${osflavour_key},${envapp_key},${datacenter_key} --force  --profile=`hostname -f `",
                unless  => ["/usr/sbin/rhn-channel -l | grep \"${channel_labels}\""],
                onlyif  => ["dpkg -l  pyjabber > /dev/null 2>&1"],
                    } 
   
               file { '/usr/share/rhn/actions/errata.py':
               source => 'puppet:///modules/spacewalk/errata.py',
               mode  => '0755',
                   }

               file {'/usr/share/rhn/up2date_client/debUtils.py':
                     source => 'puppet:///modules/spacewalk/debUtils.py',
                     mode  => '0755',
                     require => Package[rhn-client-tools],
                       }
 
               cron { 'auto_rhn_check':
                  ensure  => 'absent',
                  command => '/usr/sbin/rhn_check  -v  > /dev/null 2>&1',
                  user    => 'root',
                  hour    => '*',
                  minute  => '*/5',
                  require => Exec["Register client with spacewalk Server $channel_labels"], 

                          }

                        }   
       else {

                exec { "Register client with spacewalk Server $channel_labels":
                  command => "/usr/sbin/rhnreg_ks --serverUrl=http://${spacewalk_server}/XMLRPC \
                  --activationkey=${osflavour_key},${envapp_key},${datacenter_key} \
                  --force  --profile=`hostname -f `",
                  unless => ["/usr/sbin/rhn-channel -l | grep \"${channel_labels}\""],
                      } 
                
                if ($facts['operatingsystem'] == 'Centos') and ($facts['operatingsystemmajrelease'] == '7') {
                cron { 'auto_rhn_check_rhel':
                  command => '/sbin/rhn_check -v  > /dev/null 2>&1',
                  user    => 'root',
                  hour    => '*',
                  minute  => '*/5',
                  require => Exec["Register client with spacewalk Server $channel_labels"],

                     }
                       }

                else  {

                 file { '/usr/share/rhn/RHNS-CA-CERT':
                     source => 'puppet:///modules/spacewalk/RHN-ORG-TRUSTED-SSL-CERT',
                     mode  => '0640',
                       }

                cron { 'auto_rhn_check_rhel':
                  command => '/usr/sbin/rhn_check -v  > /dev/null 2>&1',
                  user    => 'root',
                  hour    => '*',
                  minute  => '*/5',
                  require => Exec["Register client with spacewalk Server $channel_labels"],

                     }

                        }
              }
              
# Deliver the spacewalk Certificate for automation between the server and the client 
              
              file { '/usr/share/rhn/RHN-ORG-TRUSTED-SSL-CERT':
              source => 'puppet:///modules/spacewalk/RHN-ORG-TRUSTED-SSL-CERT',
              mode  => '0640',
                   }
}   

