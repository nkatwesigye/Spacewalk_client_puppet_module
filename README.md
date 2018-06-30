# spacewalk_client_puppet_module
Puppet Module that installs and rigesters spacewalk clients at scale within respective groups
Module can allows all the paramterised components to be pulled from external sources i.e 
Hiera or anyother ENC
Main Classes of Init,Config and Service 
  1. Init - Build and install the rhn_client
  2. Config -appends the clients to the respective groups
  3.Service - startup and ensure the osad service is running for realtime job scheduling .
