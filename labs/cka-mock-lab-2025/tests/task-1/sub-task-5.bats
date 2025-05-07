# File: cka-mock-lab/tests/task-1/sub-task-5.bats
#!/usr/bin/env bats

load "../../../../node_modules/bats-assert/load"
load "../../../../node_modules/bats-support/load"

@test "HPA should have scale down stabilization window of 3 minutes (180 seconds)" {
  hpa_name=stellar-api-hpa
  namespace=mission-control
  stabilization_seconds=180
  run bash -c "kubectl get hpa $hpa_name -n $namespace -o json | jq '.spec.behavior.scaleDown.stabilizationWindowSeconds'"
  assert_output --partial $stabilization_seconds
}