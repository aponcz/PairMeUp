PairMeUp
========
Install
-------

Run the script:

    test -f /tmp/setup && rm /tmp/setup
    curl -s https://raw.github.com/CDEI/PairMeUp/master/setup -o /tmp/setup
    chmod 0700 /tmp/setup
    . /tmp/setup

Remote Pairing script and essential files

This will set up your machine for remote pairing.


Then run the pairme and specify the ip to connect to and the username of the person that you wish to connect to.

** You will need to either a) have the hosts password for their username. b) have the host add your ssh pub key(id_rsa.pub) to their ~/.ssh/authorized_keys file. 
