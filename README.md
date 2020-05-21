# The BigBlueButton Challenge - Summmer 2020

### First steps
1. Prepare your own Desktop computer installing Ubuntu 18.04 for Desktop and any IDE of your preference
If you have never installed Ubuntu before, you can try this tutorial https://www.linuxtechi.com/ubuntu-18-04-lts-desktop-installation-guide-screenshots/

2. bbb-Install BigBlueButton Server (http://docs.bigbluebutton.org/install/install.html) within LXD Linux Container. You can follow the steps in this other document https://docs.google.com/document/d/19pVSL1h4WHc1oaebpFfBJYm2RpQfpQswHsP6Vdwn8Q8/edit#
Note that you should not install BBB on your localhost. It has to be done on a VM or LXC because 1st, it requires Ubuntu 16.04, 2nd it is easy to mess up with your own OS and break your computer. You would have to reinstall it again.
If you use bbb-install.sh, you are going to need to use the -x option for generating SSL certificates manually, and you are going to need a DNS set up with a subdomain, let’s say student.blindside-dev.com. This is for you to be able to create TXT entries that will allow you to validate your SSL certificates with letsencrypt.
Note: In order to run bbb-install.sh successfully in a linux container, the following values in /etc/systemd/system/redis.service need to be changed:
PrivateTmp=no
PrivateDevice=no
ProtectHome=no

3. Checkout the BigBlueButton source from GitHub

4. Setup a Rails dev environment (https://gorails.com/setup/ubuntu/18.04) and start a new project (bbb-demo).

    You can install rails on a Linux Container or on you own localhost. It is up to you. Most people just go ahead and install it locally, but if you work on multiple projects and multiple environments, LXD is a good way to keep everything isolated and to avoid conflicts in your own localhost.

5. Checkout the BigBlueButton Rails GEM (https://rubygems.org/gems/bigbluebutton-api-ruby/versions/1.7.0)

6. Create a simple Rails app that logs you into a session called “Demo Meeting” using the above Gem to front-end your BigBlueButton server.Setup a Rails dev environment (https://gorails.com/setup/ubuntu/18.04) and start a new project (bbb-demo).

7. Install Greenlight (/bigbluebutton.yml (record and p) within a Linux Container Docker


### Second steps
1. Update your Rails application to show a list of recordings on the home page
2. Add the ability to delete an individual recording
3. Add a test for each operation: create meeting, get recordings, and delete recordings using rSpec

### Third Steps
1. Prepare and deploy your Rails application in a production environment
    * a) Add a TravisCI or CircleCI script to test the build
    * b) Frontend it with Nginx
    * c) Enable HTTPS by adding a LetsEncrypt SSL certificate
    * d) Externalize logs to papertrail
2. Build a Docker image of your application and deploy it in a production environment.
    * a) Add scripts for creating and publishing the Docker image to DockerHub using the CI automated builds.
3. Add a model and use docker-compose for the deployment including a PostgreSQL image.

### Bonus goals
4. Run your application under Kubernetes using Minikube.
5. Run your application under Kubernetes using GCloud.
    * a) Deploy an update to your application under Kubernetes
    * b) Rollback the update
