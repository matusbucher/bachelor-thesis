#!/bin/bash

make distclean
./configure --without-ndiff --without-nmap-update --without-zenmap --without-ssl --without-nping --disable-rdma LDFLAGS="-static" CFLAGS="-static"
make
sudo make install
