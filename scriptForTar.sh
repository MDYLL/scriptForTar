echo script for tar
while true
	do
	echo 1 - pack
	echo 2 - unpack
	echo 0 - exit
	read -p 'action: ' action
	echo $action
	if [ $action -eq 0 ];then
		break
	fi
	if [ $action -ne 1 ] && [ $action -ne 2 ];then
		continue
	fi
	read -p 'archiveName: ' archiveName
	read -p 'destination: ' destination
	read -p 'passowd: ' password
	encName=$archiveName
	encName+=".enc"
	echo $encName
	if [ $action -eq 1 ];then
		tar -cvzf ${archiveName} ${destination}
		openssl enc -aes-256-cbc -salt -in ${archiveName} -out ${encName} -k ${password}
		rm ${archiveName}
	else
		openssl enc -aes-256-cbc -d -in ${encName} -out ${archiveName} -k ${password}
		tar -xvf ${archiveName} -C ${destination}
		rm ${archiveName}

	fi
	done	
