#!/usr/bin/env bats

load "../../../../node_modules/bats-assert/load"
load "../../../../node_modules/bats-support/load"

@test "Create a NodePort Service named 'nebula' in the 'starblaze' namespace" {
  service=nebula
  namespace=starblaze
  svc_type="NodePort"
  run bash -c "kubectl get service $service -n $namespace -o json | jq -c '.spec.type'"
  assert_output --partial $svc_type
}
