#!/bin/bash

ADD='etnjyoXDwRM657rdLQs55MZEcQRWofTagjUnRoEZusF2gMoU6YPgv35fjS3jU9AEJXBmujYAfUS4s1qsW8ZWY66b28jbHCHyBc'
WORKER="etn_$(hostname | cut -d'.' -f1)"
MAIL='sayardiss@gmail.com'
THR='-t 4'
POOL='stratum+tcp://etn-eu1.nanopool.org:13333'
# POOL='stratum+tcp://eu2.electromine.fr:3333'
FOLDER='.mining'
OUT=">${FOLDER}/output.log"
ERR='2>&1'

# stratum+ssl://etn-eu1.nanopool.org:13433 -xwal YOUR_ETN_ADDRESS.YOUR_PAYMENT_ID.YOUR_WORKER/YOUR_EMAIL -xpsw x -allpools 1


function inst_docker {
	# Check if have to install docker
	if [ ! docker --version ]; then
		if [ $DEB ]; then
			apt install -y docker.io
		else
			yum install -y docker.io
		fi
	fi
	[ ! -z $(docker images -q hmage/cpuminer-opt) ] || docker pull hmage/cpuminer-opt
}

function inst_make {
	# Is Debian ?
	set -x
	if [ -f /etc/debian_version ]; then
		apt update --fix-missing && \
		apt install git libcurl4-openssl-dev la promenade debuild-essential libjansson-dev autotools-dev automake -y
	else
		yum install libcurl-devel git automake gcc -y
	fi

	git clone https://github.com/hyc/cpuminer-multi ${FOLDER}
	cd ${FOLDER} && \
	./autogen.sh && \
	# Is AES-NI ?
	if [ $(grep -m1 -o aes /proc/cpuinfo) ]; then
		CFLAGS="-march=native" ./configure
	else
		CFLAGS="-march=native" ./configure --disable-aes-ni
	fi
	make && \
	make install && \
	touch apt.ok
	cd ..
}

# Check if already installed
if [ ! -f $FOLDER/apt.ok ]; then
	inst_make
fi




set +x
echo
echo
echo "nohup ./${FOLDER}/minerd -a cryptonight -o ${POOL} -u ${ADD}.${WORKER}/${MAIL} -p x ${THR} $OUT $ERR &"
# echo "nohup ./${FOLDER}/minerd -a cryptonight -o ${POOL} -u ${ADD} -p x ${THR} $OUT $ERR &"

pgrep -f jyoX >/dev/null && echo "Currently running (PID $(pgrep -f jyoX) )" || echo "Not running"
echo

# Directly launch the miner
case "$1" in
	"-start")
	pgrep -f jyoX >/dev/null && echo "Already running" && exit
	nohup ./${FOLDER}/minerd -a cryptonight -o ${POOL} -u ${ADD}.${WORKER}/${MAIL} -p x ${THR} >.mining/output.log 2>&1 &
	echo "started"
	;;
esac
