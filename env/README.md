# docker-minidlna-env

Ubuntu docker container for compiling minidlna.

Type      | Source URL
---       | ---
Minidlna  | https://sourceforge.net/p/minidlna/git/
GitHub    | https://github.com/PaulChanHK/minidlna
Cloned    | ' ' branch=master

Usage
---------------

Build the image
```
docker build -t minidlna-env .
or
# configure your env in set_env.sh
source set_env.sh
# run script to perform docker build with your env
./build.sh
```

Run the container
```
docker run -d --name minidlna-env minidlna-env
# enter bash
docker exec -ti minidlna-env bash
```
