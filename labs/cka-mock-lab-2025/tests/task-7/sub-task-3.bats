# File: cka-mock-lab/tests/task-7/sub-task-3.bats
#!/usr/bin/env bats

load "../../../../node_modules/bats-assert/load"
load "../../../../node_modules/bats-support/load"

@test "StorageClass should have volumeBindingMode set to WaitForFirstConsumer" {
  sc_name=data-analytics-storage
  binding_mode="WaitForFirstConsumer"
  run bash -c "kubectl get sc $sc_name -o json | jq '.volumeBindingMode'"
  assert_output --partial $binding_mode
}