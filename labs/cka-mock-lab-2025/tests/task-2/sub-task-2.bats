# File: cka-mock-lab/tests/task-2/sub-task-2.bats
#!/usr/bin/env bats

load "../../../../node_modules/bats-assert/load"
load "../../../../node_modules/bats-support/load"

@test "Ingress should have host 'messenger.galaxy.com'" {
  ingress_name=galaxy-messenger-ingress
  namespace=comms
  host="messenger.galaxy.com"
  run bash -c "kubectl get ingress $ingress_name -n $namespace -o json | jq -r '.spec.rules[0].host'"
  assert_output --partial $host
}