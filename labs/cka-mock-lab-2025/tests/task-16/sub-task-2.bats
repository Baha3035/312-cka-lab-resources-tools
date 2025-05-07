# File: cka-mock-lab/tests/task-16/sub-task-2.bats
#!/usr/bin/env bats

load "../../../../node_modules/bats-assert/load"
load "../../../../node_modules/bats-support/load"

@test "ConfigMap 'app-config' in namespace 'security' should not mention TLSv1.2" {
  cm_name=app-config
  namespace=security
  run bash -c "kubectl get configmap $cm_name -n $namespace -o json | jq -r '.data.\"ssl.conf\"' | grep -c 'TLSv1.2' || true"
  assert_output "0"
}