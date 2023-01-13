#!/bin/bash

containers=`docker ps --format '{{.Names}}'`
name=`printf "$containers" | fzf --print-query --prompt="name: " --cycle`
# name=`echo $name | awk '{print $1}'` 

if !(printf "$containers" | grep -qs $name); then
	dbList=`cat list_of_databases.txt | tr "\n" "|"`

	images=`docker images --format '{{.Repository}}' | grep -Ew "^${dbList::-1}$"`
	image=`printf "$images" | fzf --print-query --prompt="image: " --cycle`	
	image=`echo $image | awk '{print $1}'` 

	if !(printf "$images" | grep -qs $image); then
		docker pull $image:latest
		echo "${image}" >> list_of_databases.txt 
	fi

	read -p "host-port(s): " Ports
	read -p "container port(s): " containerPorts
	read -p "env: " envOps
  
	if !([ -z $envOps ]); then
		docker run --name $name -p $Ports -e $res -d $image:latest
	else
		docker run --name $name -p $Ports -d $image:latest
	fi
fi

read -p "exec: [bash]" commando
docker exec -it $name ${commando:=bash}
