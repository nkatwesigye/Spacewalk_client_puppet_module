class spacewalk::autopatch (
#Class enforces auto patching for systems not older than the "age_limit" 
# Support Ubuntu & RHEL Systems
        $age_limit = 6,
) {
  
 if $facts['system_age'] <= $age_limit {
     if $facts['os']['name'] == 'Ubuntu' {
         exec { "Auto Patch":
            command  => "/usr/bin/apt-get upgrade -y"  
              } 
                 }
     else 
              {
         exec { "Auto Patch":
            command  => "yum update --security -y"  
               } 
                   } 
                     }
                        }


