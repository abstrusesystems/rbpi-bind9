#!/bin/sh

# exit on error
set -e

# initialize data directory
init_data() {
	# create root directory
	mkdir -p ${DATA}
	
	# if not directory /etc then create
	if [[ ! -d ${DATA}/etc ]];
	then
		mv /etc/bind ${DATA}/etc
	fi
	
	# delete old location
	rm -rf /etc/bind
	
	# link old location to new directory
	ln -sf ${DATA}/etc /etc/bind


	# if not directory /var then create
	if [[ ! -d ${DATA}/var ]];
	then
		mv /var/bind ${DATA}/var
	fi
	
	# delete old location
	rm -rf /var/bind
	
	# link old location to new directory
	ln -sf ${DATA}/var /var/bind
}

init_data

#check for bind configuration in default location
if [[ ! -f ${DATA}/etc/named.conf ]]
then
	echo "Please place your bind9 configuration in ${DATA}/etc/named.conf"
fi

# run CMD
echo "Running '$@'"
exec "$@"
