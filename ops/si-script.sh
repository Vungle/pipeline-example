#!/bin/bash -x

VERSION=0.0.1
SUCCESS=true

if [ "$1" = "version" ]
then
  echo "$VERSION"
  exit 0
fi

if [ -z $DOCKERHUB_PATH ]
then
  DOCKERHUB_PATH="vungle/pipeline-example"
  echo "env variable DOCKERHUB_PATH not defined. using default value $DOCKERHUB_PATH"
fi

if [ -z $DOCKERHUB_TAG ]
then
  DOCKERHUB_TAG="test"
  echo "env variable DOCKERHUB_TAG not defined. using default value $DOCKERHUB_TAG"
fi

if [ -z $PX ]
then
  PX=PX
  echo "env variable PX not defined. using default value $PX"
fi

build ()
{
  docker build -t $DOCKERHUB_PATH:$DOCKERHUB_TAG . || SUCCESS=false
}

cleanup ()
{
  docker rm -f -v ${PX}_pipeline-example || true
}

startcontainers ()
{
  cleanup
  docker run --name=${PX}_pipeline-example -d $DOCKERHUB_PATH:$DOCKERHUB_TAG /bin/sh -c "cd /opt/pipeline-example;node app/server.js" || SUCCESS=false
}

runtests ()
{
  docker exec ${PX}_pipeline-example /bin/sh -c "cd /opt/pipeline-example;npm test" || SUCCESS=false
}

tag ()
{
  docker push $DOCKERHUB_PATH:$DOCKERHUB_TAG
}

case "$1" in
  build)  echo "build artifacts"
          build
          ;;
  test)   echo "test artifacts"
          startcontainers
          runtests
          cleanup
          ;;
  startcontainers)
          startcontainers
          ;;
  runtests)
          runtests
          ;;
  tag)    echo "tag artifacts"
          tag
          ;;
  cleanup) echo "cleanup"
          cleanup
          ;;
  *)      echo "not a valid option.... yet..."
          echo "(build|test|startcontainers|runtests|tag|cleanup)"
          exit 1
esac

if $SUCCESS
then
  echo "pass"
  exit 0
else
  echo "fail"
  exit 1
fi
