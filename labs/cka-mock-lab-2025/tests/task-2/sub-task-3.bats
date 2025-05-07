# File: cka-mock-lab/tests/task-2/sub-task-3.bats
#!/usr/bin/env bats

load "../../../../node_modules/bats-assert/load"
load "../../../../node_modules/bats-support/load"

@test "Ingress should have host 'chat.galaxy.com'" {
  ingress_name=galaxy-messenger-ingress
  namespace=comms
  host="chat.galaxy.com"
  run bash -c "kubectl get ingress $ingress_name -n $namespace -o json | jq -r '.spec.rules[1].host'"
  assert_output --partial $host
}