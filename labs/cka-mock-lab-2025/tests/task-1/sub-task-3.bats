#!/usr/bin/env bats

load "../../../../node_modules/bats-assert/load"
load "../../../../node_modules/bats-support/load"

@test "HPA should have maxReplicas set to 4" {
  hpa_name=stellar-api-hpa
  namespace=mission-control
  max_replicas=4
  run bash -c "kubectl get hpa $hpa_name -n $namespace -o json | jq '.spec.maxReplicas'"
  assert_output --partial $max_replicas
}