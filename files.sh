#!/bin/bash

set -e

PKG=${1:?Need cookbook name}
TGT=${2:?Need target directory}

test -d "$PKG/files"
test -d "$PKG/recipes"

for i in $(find "$PKG/files" -type d); do
	REC=$(basename "$i")
	test -f "$PKG/recipes/${REC}.rb" && \
		for j in $(find "$i" -type f); do
			FIL=$(basename "$j")
			grep -q "$FIL" "$PKG/recipes/${REC}.rb" || \
				cat <<EOF >>"$PKG/recipes/${REC}.rb"
cookbook_file '$TGT/$FIL' do
	source '$FIL'
end

EOF
		done
done

