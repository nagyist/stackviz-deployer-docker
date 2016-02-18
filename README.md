stackviz-deployer-docker
========================
Docker configurations for the StackViz deployer.

Building
--------
1. Clone this repository
2. Run: `./build.sh [name]`, where `[name]` is the name to give to the built
   image.

The build script will clone StackViz and the deployer automatically. On the
first run, `npm install` with automatically be run.

If you want to try a specific revision or Gerrit patch, you can manually check
out whatever you like into the respective directory (`stackviz` or
`stackviz-deployer`). The build script will use it if it already exists.

Running
-------
You'll need MySQL and Redis containers to link:

    docker run --name stackviz-mysql -d \
        -e MYSQL_ROOT_PASSWORD=password \
        -e MYSQL_USER=stackviz \
        -e MYSQL_PASSWORD=stackviz \
        -e MYSQL_DATABASE=stackviz
        mysql

    docker run --name stackviz-redis -d redis

Then you can run the deployer:

    docker run --name stackviz-deployer -it \
        --link stackviz-redis:redis \
        --link stackviz-mysql:mysql \
        -p 8080:80 \
        [name]

... where `[name]` is the name you gave the build script. Assuming all goes
well, the deployer should be running at http://localhost:8080/.
