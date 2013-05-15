This is our first approach at using salt as a deployment system.
We initially are using it to deploy a webserver that can host multiple 
websites/webservices.

The general rational is that each machine will have nginx installed
globally, and then each website/webservice will be deployed to a user
directory and have dedicated uwsgi instances for that website.

