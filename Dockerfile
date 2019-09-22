FROM ubuntu:bionic
MAINTAINER u6k <u6k.apps@gmail.com>

# ビルドに必要なソフトウェアをインストール
RUN apt-get update && \
    apt-get install -y build-essential curl

# HTKをセットアップ
WORKDIR /usr/local/src/

COPY lib/HTK-3.4.1.tar.gz .
COPY lib/HDecode-3.4.1.tar.gz .

RUN curl -o HTS-2.3_for_HTK-3.4.1.tar.bz2 http://hts.sp.nitech.ac.jp/archives/2.3/HTS-2.3_for_HTK-3.4.1.tar.bz2

RUN apt-get install -y libx11-dev sox libc6-dev-i386 libf2c2

RUN tar zxvf HTK-3.4.1.tar.gz && \
    tar zxvf HDecode-3.4.1.tar.gz && \
    mv HTS-2.3_for_HTK-3.4.1.tar.bz2 htk/ && \
    cd htk/ && \
    tar jxvf HTS-2.3_for_HTK-3.4.1.tar.bz2 && \
    patch -p1 -d . < HTS-2.3_for_HTK-3.4.1.patch || true && \
    ./configure --prefix=/usr/local/lib/htk/ --disable-hslab CFLAGS='-DARCH=\"x86_64\"' && \
    make all && \
    make install

# hts_engine_APIをセットアップ
RUN curl -L -o hts_engine_API-1.10.tar.gz http://downloads.sourceforge.net/hts-engine/hts_engine_API-1.10.tar.gz

RUN tar zxvf hts_engine_API-1.10.tar.gz && \
    cd hts_engine_API-1.10/ && \
    ./configure --prefix=/usr/local/lib/hts_engine_API/ && \
    make && \
    make install

# SPTKをセットアップ
RUN curl -L -o SPTK-3.9.tar.gz http://downloads.sourceforge.net/sp-tk/SPTK-3.9.tar.gz

RUN apt-get install -y csh

RUN tar zxvf SPTK-3.9.tar.gz && \
    cd SPTK-3.9/ && \
    ./configure --prefix=/usr/local/lib/SPTK/ && \
    make && \
    make install

# Tcl、その他をセットアップ
# avoid prompt when installing tk8.6
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tk8.6
RUN apt-get install -y bc

# 音響モデルを作成
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
VOLUME mnt

RUN chmod a+x /usr/local/bin/entrypoint.sh

CMD ["/usr/local/bin/entrypoint.sh"]
