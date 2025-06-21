all: libuv hwloc openssl xmrig install

libuv: libuv_dl 
	script/libuv-build.sh

libuv_dl:
	script/libuv-fetch.sh

openssl: openssl_dl
	script/openssl-build.sh

openssl_dl:
	script/openssl-fetch.sh

xmrig: xmrig_dl
	script/xmrig-build.sh

xmrig_dl:
	script/xmrig-fetch.sh

xmrig-mo: xmrig-mo_dl
	script/xmrig-mo-build.sh

xmrig-mo_dl:
	script/xmrig-mo-fetch.sh

hwloc: hwloc_dl
	script/hwloc-build.sh

hwloc_dl:
	script/hwloc-fetch.sh

install:
	script/install.sh

clean:
	script/clean.sh
