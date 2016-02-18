FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y python python-dev python-pip supervisor nginx git
RUN pip install uwsgi

WORKDIR /home/docker
ADD stackviz-deployer stackviz-deployer
ADD stackviz/build/ stackviz

RUN pip install -r /home/docker/stackviz-deployer/requirements.txt

ADD nginx.conf /etc/nginx/nginx.conf
ADD supervisor_flask.conf /etc/supervisor/conf.d/supervisor_flask.conf
ADD supervisor_nginx.conf /etc/supervisor/conf.d/supervisor_nginx.conf

EXPOSE 80

CMD ["supervisord", "-n"]
