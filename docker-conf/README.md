# Docker Configuration  

Commnads:  
`docker ps -a -q`  
`docker images`   


Load a container  
`docker run --name [name] -p local_port:container_port -d [image_name]`  

List all hosted network   
`docker network ls`  
`docker network inspect <network_name>`  

Link container and run app  

`docker run -it --rm --name <name> --net <net_host> <image_name> <app>`  

ex:  
`docker run -it --rm --name test --net zookeeper_default zookeeper zkCli.sh -server s1`  








