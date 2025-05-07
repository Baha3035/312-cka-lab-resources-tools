#!/usr/bin/env bats

load "../../../../node_modules/bats-assert/load"
load "../../../../node_modules/bats-support/load"

@test "NodePort Service named 'nebula' in the 'starblaze' namespace should expose the 'starblaze-deployment' Deployment on TCP port '8888'" {
  service=nebula
  namespace=starblaze
  port=8888
  run bash -c "kubectl get service $service -n $namespace -o json | jq -c '.spec.ports[0].port'"
  assert_output --partial $port
}
