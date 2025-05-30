# File: cka-mock-lab/tests/task-5/sub-task-3.bats
#!/usr/bin/env bats

load "../../../../node_modules/bats-assert/load"
load "../../../../node_modules/bats-support/load"

@test "Deployment 'wordpress-main' should specify CPU request for init containers" {
  deployment_name=wordpress-main
  namespace=web-apps
  cpu_request="100m"
  run bash -c "kubectl get deployment $deployment_name -n $namespace -o json | jq -r '.spec.template.spec.initContainers[0].resources.requests.cpu'"
  assert_output --partial $cpu_request
}