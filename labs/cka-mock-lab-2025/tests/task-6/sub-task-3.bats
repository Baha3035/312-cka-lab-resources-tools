# File: cka-mock-lab/tests/task-6/sub-task-3.bats
#!/usr/bin/env bats

load "../../../../node_modules/bats-assert/load"
load "../../../../node_modules/bats-support/load"

@test "Sidecar container should have command to tail the logs" {
  pod_name=log-watcher
  namespace=monitoring
  run bash -c "kubectl get pod $pod_name -n $namespace -o json | jq -r '.spec.containers[1].args[0]'"
  assert_output --partial "tail -f -n 5"
}