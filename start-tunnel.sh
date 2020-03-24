#chmod 755 start-tunnel.sh
#To Start Tunnel using fresh binary download on current directory or use specified location


if [ -z "$1" ]; then
	echo "Tunnel Binary Path not supplied !!"
	# use curl or wget, depending on which one we find
	curl_or_wget=$(if hash curl 2>/dev/null; then echo "curl -O"; elif hash wget 2>/dev/null; then echo "wget -qO-"; fi);

	if [ -z "$curl_or_wget" ]; then
	    echo "Neither curl nor wget found. Cannot use http method." >&2
	    exit 1
	fi
	echo $curl_or_wget
  	
	# Check OS Type
	if [ "$(uname)" == "Darwin" ]; then
		echo "Downloading Latest Tunnel binary for Mac OS"
		$($curl_or_wget "https://downloads.lambdatest.com/tunnel/mac/64bit/LT_Mac.zip") 
		unzip LT_Mac.zip
		chmod +x LT
		./LT  -user LT_USERNAME -key LT_ACCESS_KEY -v
		sleep 30
	elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	    echo "Downloading Latest Tunnel binary for Linux"
	    $($curl_or_wget "https://downloads.lambdatest.com/tunnel/linux/64bit/LT_Linux.zip") 
		unzip LT_Linux.zip
		chmod +x LT
		./LT  -user LT_USERNAME -key LT_ACCESS_KEY -v
		sleep 30
	fi
else
	echo "Tunnel Binary Path supplied "
	echo $1
	$1 -user LT_USERNAME -key LT_ACCESS_KEY -v
	sleep 30
fi
exit 0
