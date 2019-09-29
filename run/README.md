# docker-minidlna-env

Ubuntu docker container for running minidlna.

Type      | Source URL
---       | ---
Minidlna  | https://sourceforge.net/p/minidlna/git/
GitHub    | https://github.com/PaulChanHK/minidlna
Cloned    | ' ' branch=master
Patched   | ' ' branch=homedlna

Usage
---------------

Build the image
```
docker build -t minidlna-run .
or
# configure your env in set_env.sh
source set_env.sh
# run script to perform docker build with your env
./build.sh
```

Run the container
```
# local docker image = minidlna-run, or
# docker hub image = paulchan/minidlna:run-v1.0
docker run -d --name minidlna -v /path-to-media_dir:/media minidlna-run
```
```
# external conf as args: -f /conf/minidlna.conf
docker run -d --name minidlna -v /minidlna.conf-here:/conf -v /path-to-media_dir:/media minidlna-run -f /conf/minidlna.conf
```

