# Storm Security Vagrant setup

This project contains vagrant and additional configs to run storm security cluster with nimbus HA.
You can checkout nimbus HA code from here https://github.com/Parth-Brahmbhatt/incubator-storm/tree/STORM-166 .
Build the storm dist package and copy storm-dist/target/apache-storm-0.10.0-SNAPSHOT.zip , drop it under storm-vagrant.
It will spin up 5 vms with kerberos and storm cluster running.

### requirements
+ Vagrant 
+ Virtual box
+ wget 

### Install
+ git clone git@github.com:harshach/storm-vagrant.git; git checkout -b nimbus-ha-security origin/nimbus-ha-security
+ vagrant up

### SSH
+ vagrant ssh hostname (nimbus,zookeeper, supervisor1 etcc..)

### VM Hosts
+ zookeeper (zookeeper.withend.com, kdc.witzend.com)  
	This host runs both zookeeper and kerberos. 
+ nimbus ( nimbus1.witzend.com )  
	This host runs nimbus , ui, drpc-server. 
	To start or stop services run sudo supervisorctl.
+ nimbus (nimbus2.witzend.com)
  This host runs nimbus, drpc-server.
+ supervisor1( supervisor1.witzend.com )  
    This host runs supervisor dameon. use supervisorctl to start/stop.
+ supervisor2 (supervisor2.witzend.com)  
	 This host runs supervisor daemon. use supervisorctl to start/stop.

### Kerberos Keytabs
+ all the keytabs generated during the install are stored /vagrant/keytabs(storm-vagrant/keytabs)
+ nimbus runs with /vagrant/storm_jaas.conf
+ There are testuser1, testuser2 users created for submitting topologies

### Storm UI
+ Storm UI is configured to run with hadoop-auth authentication filter
+ To access storm UI from your host
+ copy storm-vagrant/kerberos/krb5.conf /etc/krb5.conf
+ Add nimbus, kdc ip to your /etc/hosts . In this case it would be  
   192.168.202.4 nimbus1.witzend.com
   192.168.202.3 kdc.witzend.com
+ Open firefox goto about:config 
  search for network.negotiate-auth.allow-proxies and set it true  
  network.negotiate-auth.allow-non-fqdn set it true  
  network.negotiate-auth.trusted-uris set it to http://nimbus1.witzend.com:8080 
+ You can use safari browser without any change to config.
+ run kinit -k -t storm-vagrant/keytabs/testuser1.keytab testuser1/nimbus1.witzend.com
+ you'll be logged into nimbus as testuser1

### wordcount topology
+ vagrant ssh nimbus
+ sudo su testuser1
+ kinit -k -t /vagrant/keytabs/testuser1.keytab testuser1/nimbus1.witzend.com
+ storm jar /usr/share/storm/examples/storm-starter/storm-starter-topologies-0.10.0-SNAPSHOT.jar storm.starter.WordCountTopology wordcount
