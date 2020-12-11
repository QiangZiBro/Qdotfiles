# go to http://www.c-nergy.be/products.html
set -e
wget -c http://c-nergy.be/downloads/xRDP/xrdp-installer-1.2.zip
unzip xrdp-installer-1.2.zip
bash xrdp-installer-1.2.sh
rm xrdp-installer-1.2.*
