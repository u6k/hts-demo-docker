#!/bin/sh

cd /mnt/
./configure --with-sptk-search-path=/usr/local/lib/SPTK/bin --with-hts-search-path=/usr/local/lib/htk/bin --with-hts-engine-search-path=/usr/local/lib/hts_engine_API/bin
make

# add the path that holds Config.pm to the path for Perl so that it can be found
export PERL5LIB=/mnt/scripts

# this is used in SPTK/bin/raw2wav
export uid=root

/usr/bin/perl scripts/Training.pl Config.pm
