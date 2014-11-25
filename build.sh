#!/bin/sh

echo '
Opencast Matterhorn Dockerfile

This script will help you in the process of building a docker image for
Opencast Matterhorn.
'

# Switch to script dir:
echo $(dirname $(readlink -f $0))
cd $(dirname $(readlink -f $0))

# Check if we are in a local repository or running the script from github:
#build.sh  Dockerfile  matterhorn.repo  matterhorn-testing.repo  readme.md  usr-sbin-matterhorn

echo 'Enter credentials for Matterhorn RPM repository
  http://repo.virtuos.uos.de
'
echo -n 'Username: '
read USER
echo -n 'Password: '
read -s PASSWD
echo

if [[ $USER == "" ]] || [[ $PASSWD == "" ]]
then
	echo No credentials used. This will only work if you have direct access to
	echo the Matterhorn RPM repository.
else
	echo Building Docker image. This might take a while
	cp matterhorn.repo matterhorn.repo.1
	cp matterhorn-testing.repo matterhorn-testing.repo.1
	sed -i "s/repo.virt/${USER}:${PASSWD}@repo.virt/" matterhorn.repo
	sed -i "s/repo.virt/${USER}:${PASSWD}@repo.virt/" matterhorn-testing.repo
	docker build -t opencast-matterhorn16 . && \
		echo Successfully built Matterhorn Docker image && \
		echo Start Matterhorn by running && \
		echo '  docker run -d --name=matterhorn16 -p 8080:8080 opencast-matterhorn16'
	mv matterhorn.repo.1 matterhorn.repo
	mv matterhorn-testing.repo.1 matterhorn-testing.repo
fi
