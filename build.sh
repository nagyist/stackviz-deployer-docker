#!/bin/bash

if [ -d stackviz-deployer ]; then
    pushd stackviz-deployer
    git pull origin master
    popd
else
    git clone https://github.com/timothyb89/stackviz-deployer
fi

if [ -d stackviz ]; then
    pushd stackviz
    git pull origin master
    popd
else
    git clone https://github.com/openstack/stackviz
    pushd stackviz
    npm install
    popd
fi

pushd stackviz
gulp prod
popd

sudo docker build -t $1 .
