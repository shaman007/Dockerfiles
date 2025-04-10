#!/bin/bash
PATH=/root/bin:/usr/local/bin::/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
git pull
apps=( $(ls -la|grep drw|grep -v "\."| awk '{ print $9 }') )
registry="registry.andreybondarenko.com"
label="latest"

for app in "${apps[@]}"
do
  cd $app
  echo "-------- BUILDING $registry/$app:$label --------"
  docker buildx build --platform linux/amd64,linux/arm64 -t $registry/$app:$label .  
  echo "-------- PUSHING $registry/$app:$label --------"
  docker push $registry/$app:$label
  cd ..
done
