# pipeline-example
[![Build Status](http://jenkins.vungle.com:8080/buildStatus/icon?job=si-pipeline-example-master)](http://jenkins.vungle.com:8080/view/system-integration/view/si-pipeline-example/job/si-pipeline-example-master/)

## Local Setup
### build image locally
`ops/si-script.sh build`
### start service locally 
`ops/si-script.sh startcontainers`
### run tests locally
`ops/si-script.sh runtests`
### cleanup
`ops/si-scripts.sh cleanup`

## jenkins job runs the following
### builds image
`ops/si-script.sh build`
### tests image (startscontainers|runtests|cleanup)
`ops/si-script.sh test`
### tags and pushes image to docker hub
`ops/si-script.sh tag`
