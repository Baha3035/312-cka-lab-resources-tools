# File: cka-mock-lab/tests/task-7/sub-task-1.bats
#!/usr/bin/env bats

load "../../../../node_modules/bats-assert/load"
load "../../../../node_modules/bats-support/load"

@test "StorageClass 'data-analytics-storage' exists" {
  sc_name=data-analytics-storage
  run bash -c "kubectl get sc $sc_name -o json | jq '.metadata.name'"
  assert_output --partial $sc_name
}