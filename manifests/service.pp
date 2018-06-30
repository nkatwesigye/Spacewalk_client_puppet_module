#Class starts up spacewalk Services on the client , in particular osad which implements 
#realtime job execution

class spacewalk::service {
    # Startup Spacewalk_client service "osad"
  if $facts['os']['name']        !='Ubuntu'{
     service { 'osad':
        ensure     => running,
        enable     => true,
        hasstatus  => true,
        hasrestart => true,
        require => Package['osad'],
      }


         }

  else {

if $facts['osad_package_state'] == 'osad_installed'{
     service { 'osad':
        ensure     => running,
        enable     => true,
        hasstatus  => true,
        hasrestart => true,
      }
          }

              }

                  }




