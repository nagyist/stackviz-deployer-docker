#!/bin/bash
set -e
set -x

if [ -d stackviz-deployer ]; then
    echo "--> Using existing copy of stackviz-deployer"
else
    echo "--> Checking out fresh copy of stackviz-deployer"
    git clone https://github.com/timothyb89/stackviz-deployer
fi

if [ -d stackviz ]; then
    echo "--> Using existing copy of stackviz"
else
    echo "--> Checking out fresh copy of stackviz"
    git clone https://github.com/openstack/stackviz
    pushd stackviz
    npm install
    popd
fi

echo "--> Running 'gulp build' on stackviz"
pushd stackviz
gulp prod
popd

echo "--> Building docker image: $1"

sudo docker build -t $1 .
