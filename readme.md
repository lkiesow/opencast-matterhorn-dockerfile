Opencast Matterhorn Dockerfile
==============================

To create a docker container for Opencast Matterhorn, please follow these steps:

```
docker build -t opencast-matterhorn .
docker run -d --name=matterhorntest -p 8080:8080 opencast-matterhorn
```
