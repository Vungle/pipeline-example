# pipeline-example
[![Build Status](http://jenkins.vungle.com:8080/buildStatus/icon?job=si-pipeline-example-master)](http://jenkins.vungle.com:8080/view/system-integration/view/si-pipeline-example/job/si-pipeline-example-master/)

## Local Setup
### startup boot2docker
`$ boot2docker start`
### set docker environment variables
`$ boot2docker shellinit`
### get ip address of boot2docker
```
$ boot2docker ip
192.168.59.103
```
### build image locally
`$ ops/si-script.sh build`
### start service locally 
`$ ops/si-script.sh startcontainers`
### run tests locally
`$ ops/si-script.sh runtests`
### get port number of container
```
$ docker port PX_pipeline-example
3000/tcp -> 0.0.0.0:32770
```
### hit container directly
`http://192.168.59.103:32770/rgbToHex?red=255&green=255&blue=255`

### cleanup
`$ ops/si-scripts.sh cleanup`

## jenkins job runs the following
### builds image
`ops/si-script.sh build`
### tests image (startscontainers|runtests|cleanup)
`ops/si-script.sh test`
### tags and pushes image to docker hub
`ops/si-script.sh tag`
