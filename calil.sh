#!/bin/bash
cd `dirname $0`
git reset --hard
git pull

git submodule update --init
for i in gfwlist genpac
do
	(cd $i;git pull origin master)
done

rm -rf env
virtualenv env
source env/bin/activate
(cd genpac;python setup.py install)

env/bin/genpac \
	--pac-proxy "PROXY 127.0.0.1:9999" \
	--gfwlist-url - \
	--gfwlist-local gfwlist/gfwlist.txt \
	--user-rule-from ./my-rules.txt \
	-o gfwlist.pac
sed -e '5d' -e '3d' -i gfwlist.pac
deactivate

./gen-clash.sh

git add .
git commit -m "[$(LANG=C date)]auto update"
git push origin master
