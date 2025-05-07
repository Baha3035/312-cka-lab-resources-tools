# File: cka-mock-lab/tests/task-7/sub-task-2.bats
#!/usr/bin/env bats

load "../../../../node_modules/bats-assert/load"
load "../../../../node_modules/bats-support/load"

@test "StorageClass should use 'rancher.io/local-path' provisioner" {
  sc_name=data-analytics-storage
  provisioner="rancher.io/local-path"
  run bash -c "kubectl get sc $sc_name -o json | jq '.provisioner'"
  assert_output --partial $provisioner
}