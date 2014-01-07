#!/bin/bash

PKG=${1:?No Package given}
DEB=${2}

mkdir -p "$PKG/recipes"

if test x"$DEB" = "x"; then
	cat <<EOF >"$PKG/recipes/default.rb"
package '$PKG'

EOF
else
	cat <<EOF >"$PKG/recipes/default.rb"
if node['platform_family'] == 'debian' then
	package '$DEB'
else
	package '$PKG'
end

EOF
fi

cat <<EOF >"$PKG/README.md"
This cookbook installs "$PKG"
EOF

cat <<EOF >"$PKG/metadata.rb"
name	'$PKG'
version	'0.1.0'
EOF
