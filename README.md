# hts-demo-docker
音響モデル作成ソフトウェアをDockerイメージで提供します。
1. lib/README.mdを読んで、必要なライブラリをダウンロードする。
1. http://hts.sp.nitech.ac.jp/?Download から、HTS-2.3 Speaker dependent training demo Japaneseをダウンロードし、このディレクトリに**HTS-demo_NIT-ATR503-M001**フォルダを保存
1. `docker build -t hts_demo .`
1. `docker run -v path/to/hts-demo-docker/HTS-demo_NIT-ATR503-M001:/mnt hts_demo`
1. `docker run -it -v ~/hts-demo-docker/HTS-demo_NIT-ATR503-M001:/mnt hts_demo /bin/bash` to enter bash terminal

* todo: how can this be actually used with your dataset?
* todo: convert wav to raw if necessary

# references
* http://mahoro-ba.net/e1876.html
* https://qiita.com/u6k/items/ca3e6486ac8e675c61cb
