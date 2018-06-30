# spacewalk_client_puppet_module
puppet Module that installs and rigesters spacewalk clients at scale within respective groups
Module can allows all the paramterised components to be pulled from external sources like Hiera or anyother ENC
Main Classes of Init,Config and Service - Build and install the rhn_client
Config -appends the clients to the respective groups
Service - startup and ensure the osad service is running for realtime job scheduling .
