# Setting up IBM DB2 on local machine using Docker

1. Make sure Docker is installed `docker --version`
2. `cd` to docker directory 
	- or create one `mkdir docker`
3. Create directories for DB2 instance `mkdir db2inst1`
4. Create file to store environment variables `touch db2inst1.env_list`

```sh
LICENSE=accept
DB2INSTANCE=db2inst1
DB2INST1_PASSWORD=mypasswd
DBNAME=
BLU=false
ENABLE_ORACLE_COMPATIBILITY=false
UPDATEAVAIL=NO
SAMPLEDB=false
REPODB=false
IS_OSXFS=true
PERSISTENT_HOME=true
HADR_ENABLED=false
ETCD_ENDPOINT=
ETCD_USERNAME=
ETCD_PASSWORD=
```

5. Log into docker `docker login`
6. Pull DB2 image `docker pull ibmcom/db2`
7. Run DB2 docker

```sh
docker run -h db2inst1 --name db2inst1 --restart=unless-stopped  \
 --detach --privileged=true -p 50000:50000 -p 55000:55000 \
 --env-file ~/Docker/db2inst1.env_list \
 -v ~/Docker/db2inst1:/database \
 -v ~/Docker/db2backup:/backup \
 ibmcom/db2
```

8. Open a shell to check the container `docker exec -ti db2inst1 /bin/bash`
9. Set up your password

```shell
chage -M -1 db2inst1
passwd db2inst1
```

10. Switch to DB2 user so we can create databases, tables, etc 

```shell
su - db2inst1
db2sampl
db2 list database directory
db2 create database TEST
```

11. Finally run DB2

```shell
db2 -t
CONNECT to YOUR_DATABASE_NAME;

// list all tables
LIST TABLES;

// ... Other SQL commands
```

