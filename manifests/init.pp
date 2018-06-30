# Class: spacewalk
# ===========================
#
# Install and configure spacewalk client.
#
# Authors
# -------
# nkatwesigye@gmail.com

class spacewalk (
    $osad_version  = 'latest',
    $yumserver     = 'yum.domain.local',
    $spacewalk_key = '/etc/pki/rpm-gpg/RPM-GPG-KEY-spacewalk-2015',
    $spacewalk_ubunturepo_key = '/etc/pki/keyFile',
    $spacewalk_ubunturepo_key_id = 'D55D5DCC',
) {

  #Based on os add gpg keys , for RHEL or Centos systems and install the osad client
  if $facts['os']['name']        !='Ubuntu'{
                $osad_packages     = ['osad']
                package { $osad_packages:
                ensure  => $osad_version,
                require => Exec['import gpg keys for spacewalk channels'],

            }
         file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-spacewalk-2015':
                source => 'puppet:///modules/spacewalk/RPM-GPG-KEY-spacewalk-2015',
                mode   => '0640',
                    }
         exec { 'import gpg keys for spacewalk channels':
                command => '/bin/rpm --import  /etc/pki/rpm-gpg/*',
                require => File[$spacewalk_key],
                unless  => 'rpm -qi gpg-pubkey-b8002de1-553126bd > /dev/null 2>&1',
                  } 
        }
  else
      { 
        
       file { '/etc/pki/':
                ensure => 'directory',
                mode   => '0640',
          }
 
        file { '/etc/pki/keyFile':
                source => 'puppet:///modules/spacewalk/keyFile',
                mode   => '0640',
                require => File['/etc/pki/'],
          }
          
      
        exec { 'import gpg keys for ubuntu spacewalk channels':
                command => '/usr/bin/apt-key add  /etc/pki/keyFile',
                require => File[$spacewalk_ubunturepo_key],
                unless  => ["/usr/bin/apt-key list | grep \"${spacewalk_ubunturepo_key_id}\""],

          }
        }

          }


