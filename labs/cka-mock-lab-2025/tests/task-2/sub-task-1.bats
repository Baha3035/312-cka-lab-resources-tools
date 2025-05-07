#!/usr/bin/env bats

load "../../../../node_modules/bats-assert/load"
load "../../../../node_modules/bats-support/load"

@test "Ingress 'galaxy-messenger-ingress' exists in namespace 'comms'" {
  ingress_name=galaxy-messenger-ingress
  namespace=comms
  run bash -c "kubectl get ingress $ingress_name -n $namespace -o json | jq '.metadata.name'"
  assert_output --partial $ingress_name
}