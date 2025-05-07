# File: cka-mock-lab/tests/task-9/sub-task-1.bats
#!/usr/bin/env bats

load "../../../../node_modules/bats-assert/load"
load "../../../../node_modules/bats-support/load"

@test "PriorityClass 'critical-ops' exists" {
  pc_name=critical-ops
  run bash -c "kubectl get priorityclass $pc_name -o json | jq '.metadata.name'"
  assert_output --partial $pc_name
}