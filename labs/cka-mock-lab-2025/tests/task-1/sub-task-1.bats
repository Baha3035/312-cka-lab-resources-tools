#!/usr/bin/env bats

load "../../../../node_modules/bats-assert/load"
load "../../../../node_modules/bats-support/load"

@test "HPA 'stellar-api-hpa' exists in namespace 'mission-control'" {
  hpa_name=stellar-api-hpa
  namespace=mission-control
  run bash -c "kubectl get hpa $hpa_name -n $namespace -o json | jq '.metadata.name'"
  assert_output --partial $hpa_name
}