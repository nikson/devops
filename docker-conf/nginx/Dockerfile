# Docker image with nginx

FROM ubuntu:trusty

MAINTAINER Nikson Paul <niksonpaul@facebook.com>

# update packages 
RUN sudo apt-get -qq update

# install nginx 
RUN sudo apt-get --assume-yes -qq install nginx 

COPY static /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf


# RUN ls /usr/share/nginx/html
# RUN cat /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]


