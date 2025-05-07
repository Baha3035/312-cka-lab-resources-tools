# File: cka-mock-lab/tests/task-6/sub-task-2.bats
#!/usr/bin/env bats

load "../../../../node_modules/bats-assert/load"
load "../../../../node_modules/bats-support/load"

@test "Sidecar container should use busybox image" {
  pod_name=log-watcher
  namespace=monitoring
  image_name="busybox"
  run bash -c "kubectl get pod $pod_name -n $namespace -o json | jq -r '.spec.containers[1].image'"
  assert_output --partial $image_name
}