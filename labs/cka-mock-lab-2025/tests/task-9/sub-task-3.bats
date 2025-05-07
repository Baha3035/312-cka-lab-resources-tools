# File: cka-mock-lab/tests/task-9/sub-task-3.bats
#!/usr/bin/env bats

load "../../../../node_modules/bats-assert/load"
load "../../../../node_modules/bats-support/load"

@test "Pod 'ops-controller' should use PriorityClass 'critical-ops'" {
  pod_name=ops-controller
  namespace=operations
  pc_name="critical-ops"
  run bash -c "kubectl get pod $pod_name -n $namespace -o json | jq '.spec.priorityClassName'"
  assert_output --partial $pc_name
}