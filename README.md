# spacewalk_client_puppet_module
Puppet Module that installs and rigesters spacewalk clients at scale within respective groups
Module can allows all the paramterised components to be pulled from external sources i.e 
Hiera or anyother ENC
Main Classes of Init,Config and Service 
  * Init - Build and install the rhn_client
  * Config -appends the clients to the respective groups
  * Service - startup and ensure the osad service is running for realtime job scheduling .
  * autopatch - when turned on required a system age number which is the number of hours since the system was installed
     autopatch will trigger a yum update or apt-get update on system which have been alive for time less than system age
