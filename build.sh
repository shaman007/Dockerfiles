#!/bin/bash
apps=( $(ls -la|grep drw|grep -v "\."| awk '{ print $9 }') )

registry="registry.andreybondarenko.com"
label="latest"

for app in "${apps[@]}"
do
  cd $app
  echo "-------- BUILDING $registry/$app:$label --------"
  docker build -t $registry/$app:$label .
  echo "-------- PUSHING $registry/$app:$label --------"
  docker push $registry/$app:$label
  cd ..
done
