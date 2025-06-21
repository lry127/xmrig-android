all: download libuv openssl hwloc xmrig install

download: libuv_dl openssl_dl hwloc_dl xmrig_dl
	echo "download finished"
	
libuv_dl:
	script/libuv-fetch.sh

openssl_dl:
	script/openssl-fetch.sh

hwloc_dl:
	script/hwloc-fetch.sh

xmrig_dl:
	script/xmrig-fetch.sh

libuv: 
	script/libuv-build.sh

openssl: openssl_dl
	script/openssl-build.sh

xmrig:
	script/xmrig-build.sh

hwloc:
	script/hwloc-build.sh


install:
	script/install.sh

clean:
	script/clean.sh
