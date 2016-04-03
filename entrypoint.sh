#!/bin/sh

cd /mnt/
./configure --with-sptk-search-path=/usr/local/lib/SPTK/bin --with-hts-search-path=/usr/local/lib/htk/bin --with-hts-engine-search-path=/usr/local/lib/hts_engine_API/bin | tee log
make | tee -a log
/usr/bin/perl scripts/Training.pl scripts/Config.pm | tee -a log
