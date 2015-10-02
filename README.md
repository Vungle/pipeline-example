# pipeline-example
[![Build Status](http://jenkins.vungle.com:8080/buildStatus/icon?job=si-pipeline-example-master)](http://jenkins.vungle.com:8080/view/system-integration/view/si-pipeline-example/job/si-pipeline-example-master/)

## Local Development Requirements
### boot2docker, git

## Local Setup
### startup boot2docker
`$ boot2docker start`
### set boot2docker environment variables
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

## pull request jenkins job runs the following
http://jenkins.vungle.com:8080/view/system-integration/view/si-pipeline-example/job/si-pipeline-example-master/
```
ops/si-script.sh build
ops/si-script.sh test
ops/si-script.sh tag
```

## deploy jenkins job runs the following
http://jenkins.vungle.com:8080/view/system-integration/view/si-pipeline-example/job/deploy-pipeline-example/
```
# gets vulcan values from etcd
export ACTION=etcdctl_get
ops/fleet-deploy.sh
# sets vulcan values to etcd
export ACTION=etcdctl_set
ops/fleet-deploy.sh
# stops and destroys current unit file and submits and starts new unit file
export ACTION=deploy
ops/fleet-deploy.sh
# restarts current unit file
export ACTION=restart
ops/fleet-deploy.sh
# stops current unit file 
export ACTION=stop
ops/fleet-deploy.sh
# start current unit file 
export ACTION=start
ops/fleet-deploy.sh
# displays status of unit file
export ACTION=status
ops/fleet-deploy.sh
```
