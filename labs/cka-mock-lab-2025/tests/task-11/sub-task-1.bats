# File: cka-mock-lab/tests/task-11/sub-task-1.bats
#!/usr/bin/env bats

load "../../../../node_modules/bats-assert/load"
load "../../../../node_modules/bats-support/load"

@test "PVC 'mariadb-data' exists in namespace 'databases'" {
  pvc_name=mariadb-data
  namespace=databases
  run bash -c "kubectl get pvc $pvc_name -n $namespace -o json | jq '.metadata.name'"
  assert_output --partial $pvc_name
}