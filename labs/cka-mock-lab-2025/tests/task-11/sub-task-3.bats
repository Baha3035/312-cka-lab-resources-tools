# File: cka-mock-lab/tests/task-11/sub-task-3.bats
#!/usr/bin/env bats

load "../../../../node_modules/bats-assert/load"
load "../../../../node_modules/bats-support/load"

@test "Deployment 'mariadb' should use PVC 'mariadb-data'" {
  deployment_name=mariadb
  namespace=databases
  pvc_name="mariadb-data"
  run bash -c "kubectl get deployment $deployment_name -n $namespace -o json | jq '.spec.template.spec.volumes[0].persistentVolumeClaim.claimName'"
  assert_output --partial $pvc_name
}