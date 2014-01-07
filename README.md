cookbooks
=========

These cookbooks are written for me to use on Gentoo and Debian installs
(as they are what I use most often)

No attempt has been made to make these portable, as my Ruby knowledge sucks.

Scripts
-------

bootstrap/ - contains bootstrap scripts suitable for 'knife bootstrap --distro'
newpkg.sh - create a new cookbook that installs a package
files.sh - macro to create cookbook\_file entries in a folder

Cookbooks
---------

apache2 - installs and runs apache2, configures it to listen on port [::1]:8080
btrfs-progs - installs btrfs userland programs/tools
chef - ensures chef-client periodically runs
consblank - disables linux console blanking
curl - installs the curl cli tool
fail2ban - installs fail2ban package
glusterfs - installs glusterfs server
htop - installs htop
iptables - sets up basic software firewall rules
nginx - installs and runs nginx
nmap - installs nmap
opendkim - installs and configures opendkim
openssl - configures openssl (mainly ECDSA support)
portage - helper cookbook for USE-flags and keywords
ssh - configure openssh (ECDSA support) and a customised sshd\_config
sysctl - tweak some sysctl parameters
tcpdump - installs tcpdump
telnet - installs telnet (telnet-bsd on gentoo)
varnish - installs and runs varnish, configured to listen on [::]:80
vim - install vim
