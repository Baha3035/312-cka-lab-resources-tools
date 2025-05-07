#!/usr/bin/env bats

load "../../../../node_modules/bats-assert/load"
load "../../../../node_modules/bats-support/load"

@test "HPA should have CPU utilization target set to 50%" {
  hpa_name=stellar-api-hpa
  namespace=mission-control
  target_cpu=50
  run bash -c "kubectl get hpa $hpa_name -n $namespace -o json | jq '.spec.metrics[0].resource.target.averageUtilization'"
  assert_output --partial $target_cpu
}