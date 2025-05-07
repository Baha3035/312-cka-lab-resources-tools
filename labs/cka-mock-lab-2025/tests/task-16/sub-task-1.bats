# File: cka-mock-lab/tests/task-16/sub-task-1.bats
#!/usr/bin/env bats

load "../../../../node_modules/bats-assert/load"
load "../../../../node_modules/bats-support/load"

@test "ConfigMap 'app-config' in namespace 'security' should enable TLSv1.3" {
  cm_name=app-config
  namespace=security
  run bash -c "kubectl get configmap $cm_name -n $namespace -o json | jq -r '.data.\"ssl.conf\"'"
  assert_output --partial "TLSv1.3"
}