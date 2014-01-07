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
nginx - installs and runs nginx
varnish - installs and runs varnish, configured to listen on [::]:80
