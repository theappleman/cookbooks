#!/bin/bash

. ~/.venv/supernova/bin/activate

get_image() {
	#echo "supernova ${REGION:-uk} image-list | awk \"/$1/{print \$2}\""
	supernova ${REGION:-uk} image-list | awk "/$1/{print \$2}"
}

get_generic() {
	tr A-Z a-z <<<"$1" | awk '{print$1}'
}

get_name() {
	#start with the prefix
	# prefix is 2 characters, lowercase, no vowels
	class="$(get_generic "$1" | tr -d aeiou | cut -b1,2)"

	for i in $(seq -w 0 999)
	do
		isF=no
		isC=no
		isN=no
		pot="${class}${i}"
		test -f $PWD/.cs/$pot && isF=yes
		knife client list | grep -q -o $pot && isC=yes
		knife node list | grep -q -o $pot && isN=yes

		test x"$isF" = "xno" && \
		test x"$isC" = "xno" && \
		test x"$isN" = "xno" && \
			echo $pot && \
			return
	done
}

get() {
	typ="$1" # image, name
	class="$2" # image name, or name prefix

	case "$typ" in
	image)
		get_image "$class"
		;;
	name)
		get_name "$class"
		;;
	esac
}

REGION=${CS_REGION:-uk}
FLAV=${CS_FLAVOUR:-performance1-2}
CLASS=${CS_CLASS:-Debian 7}
NAME=$(get name "$CLASS")

touch $PWD/.cs/$NAME
time supernova ${REGION} boot \
	--key-name $(hostname) \
	--flavor ${FLAV} \
	--image $(get image "$CLASS") \
	--poll \
	$NAME

IP=$(supernova uk list | awk -F= "/$NAME/{print\$2}" | egrep -m1 -o '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+')

knife bootstrap -r chef -d $(get_generic "$CLASS") "$IP"

