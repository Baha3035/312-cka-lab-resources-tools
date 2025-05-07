# File: cka-mock-lab/tests/task-9/sub-task-2.bats
#!/usr/bin/env bats

load "../../../../node_modules/bats-assert/load"
load "../../../../node_modules/bats-support/load"

@test "PriorityClass 'critical-ops' should have value 1000000" {
  pc_name=critical-ops
  value=1000000
  run bash -c "kubectl get priorityclass $pc_name -o json | jq '.value'"
  assert_output --partial $value
}