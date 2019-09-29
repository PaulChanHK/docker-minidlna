# docker-minidlna/run

Ubuntu docker container for running minidlna.

Type      | Source URL
---       | ---
Minidlna  | https://sourceforge.net/p/minidlna/git/
GitHub    | https://github.com/PaulChanHK/minidlna
Cloned    | ' ' branch=master
Patched   | ' ' branch=homedlna

Changes
---------------

For latest or v*-p-X (like v1.2.1-48-p.1), they are minidlna containers
that contain patches made for my home for:
- Samsung TV (ESamsungSeries E...)
- LG Bluray (ENetFrontLivingConnect)

Example changes (refer to https://github.com/PaulChanHK/minidlna for full list):
- printf with socket fd in upnphttp.c
- fix warn & show more info msg
- put Folders first in the display list
- support force_sort_criteria as suffix per media_dir
- renew subscription with different port
- handle subscription timeout, default changed to 900s from 300s
- workarounds of NetFrontLivingConnect for rmvb & partial caption
- support partial range of caption
- simplify jpeg rotate
- support rm/rmvb


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
docker run -d --name minidlna -v /dir-entry_sh-and-conf:/conf -v /path-to-media_dir:/media minidlna-run -f /conf/minidlna.conf
```
