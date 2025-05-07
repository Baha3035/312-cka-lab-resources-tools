#!/usr/bin/env bats

load "../../../../node_modules/bats-assert/load"
load "../../../../node_modules/bats-support/load"

@test "HPA should have minReplicas set to 1" {
  hpa_name=stellar-api-hpa
  namespace=mission-control
  min_replicas=1
  run bash -c "kubectl get hpa $hpa_name -n $namespace -o json | jq '.spec.minReplicas'"
  assert_output --partial $min_replicas
}