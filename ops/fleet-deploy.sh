#!/bin/bash -x

VERSION=0.0.1
SUCCESS=true

if [ "$1" = "version" ]
then
  echo "$VERSION"
  exit 0
fi

if [ "$ACTION" = "deploy" ]
then
  fleetctl --tunnel=$FLEET_IP stop ${UNIT_FILE}
  sleep 20
  fleetctl --tunnel=$FLEET_IP destroy ${UNIT_FILE}
  sleep 20
  fleetctl --tunnel=$FLEET_IP submit ops/unit/${UNIT_FILE}
  sleep 20
  fleetctl --tunnel=$FLEET_IP start ${UNIT_FILE}
  sleep 20
  fleetctl --tunnel=$FLEET_IP status ${UNIT_FILE}
  exit 0
elif [ "$ACTION" = "restart" ]
then
  fleetctl --tunnel=$FLEET_IP stop ${UNIT_FILE}
  sleep 20
  fleetctl --tunnel=$FLEET_IP start ${UNIT_FILE}
  sleep 20
  fleetctl --tunnel=$FLEET_IP status ${UNIT_FILE}
  exit 0
elif [ "$ACTION" = "stop" ]
then
  fleetctl --tunnel=$FLEET_IP stop ${UNIT_FILE}
  sleep 20
  fleetctl --tunnel=$FLEET_IP status ${UNIT_FILE}
  exit 0
elif [ "$ACTION" = "start" ]
then
  fleetctl --tunnel=$FLEET_IP start ${UNIT_FILE}
  sleep 20
  fleetctl --tunnel=$FLEET_IP status ${UNIT_FILE}
  exit 0
elif [ "$ACTION" = "status" ]
then
  fleetctl --tunnel=$FLEET_IP status ${UNIT_FILE}
  exit 0
elif [ "$ACTION" = "etcdctl_get" ]
then
  fleetctl --tunnel=$FLEET_IP ssh $FLEET_HOST_ID etcdctl get /vulcand/frontends/pipeline-example/frontend
  fleetctl --tunnel=$FLEET_IP ssh $FLEET_HOST_ID etcdctl get /vulcand/backends/pipeline-example/backend
  fleetctl --tunnel=$FLEET_IP ssh $FLEET_HOST_ID etcdctl get /vulcand/backends/pipeline-example/servers/srv00
  exit 0
elif [ "$ACTION" = "etcdctl_set" ]
then
  fleetctl --tunnel=$FLEET_IP ssh $FLEET_HOST_ID etcdctl set /vulcand/frontends/pipeline-example/frontend \
    \'{\"Id\":\"pipeline-example\",\"Route\":\"Host\(\\\"pipeline-example.vungle.com\\\"\)\",\"Type\":\"http\",\"BackendId\":\"pipeline-example\",\"Settings\":{\"Limits\":{\"MaxMemBodyBytes\":0,\"MaxBodyBytes\":0},\"FailoverPredicate\":\"\",\"Hostname\":\"\",\"TrustForwardHeader\":false}}\'
  fleetctl --tunnel=$FLEET_IP ssh $FLEET_HOST_ID etcdctl set /vulcand/backends/pipeline-example/backend \
    \'{\"Id\":\"pipeline-example\",\"Type\":\"http\",\"Settings\":{\"Timeouts\":{\"Read\":\"0\",\"Dial\":\"0\",\"TLSHandshake\":\"0\"},\"KeepAlive\":{\"Period\":\"0\",\"MaxIdleConnsPerHost\":0},\"TLS\":{\"PreferServerCipherSuites\":false,\"InsecureSkipVerify\":false,\"MinVersion\":\"\",\"MaxVersion\":\"\",\"SessionTicketsDisabled\":false,\"SessionCache\":{\"Type\":\"\",\"Settings\":null},\"CipherSuites\":[]}}}\'
  exit 0
fi   

exit 1
