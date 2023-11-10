#!/bin/bash
apps=( $(ls -la|grep drw|grep -v "\."| awk '{ print $9 }') )

registry="registry.example.com"
label="latest"

for app in "${apps[@]}"
do
  cd $app
  docker build -t $registry/$app:label .
  docker push $registry/$app:label
  cd ..
done
