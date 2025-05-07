# File: cka-mock-lab/tests/task-11/sub-task-2.bats
#!/usr/bin/env bats

load "../../../../node_modules/bats-assert/load"
load "../../../../node_modules/bats-support/load"

@test "PVC 'mariadb-data' should have storage request of 250Mi" {
  pvc_name=mariadb-data
  namespace=databases
  storage="250Mi"
  run bash -c "kubectl get pvc $pvc_name -n $namespace -o json | jq '.spec.resources.requests.storage'"
  assert_output --partial $storage
}