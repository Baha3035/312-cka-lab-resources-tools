# File: cka-mock-lab/tests/task-6/sub-task-1.bats
#!/usr/bin/env bats

load "../../../../node_modules/bats-assert/load"
load "../../../../node_modules/bats-support/load"

@test "Pod 'log-watcher' should have a sidecar container named 'log-collector'" {
  pod_name=log-watcher
  namespace=monitoring
  container_name="log-collector"
  run bash -c "kubectl get pod $pod_name -n $namespace -o json | jq -r '.spec.containers[1].name'"
  assert_output --partial $container_name
}