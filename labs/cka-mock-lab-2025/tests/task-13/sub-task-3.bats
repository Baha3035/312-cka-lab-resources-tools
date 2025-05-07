# File: cka-mock-lab/tests/task-13/sub-task-3.bats
#!/usr/bin/env bats

load "../../../../node_modules/bats-assert/load"
load "../../../../node_modules/bats-support/load"

@test "NetworkPolicy 'frontend-backend-policy' should allow egress to pods with label 'app: backend'" {
  policy_name=frontend-backend-policy
  namespace=microservices
  selector=backend
  run bash -c "kubectl get networkpolicy $policy_name -n $namespace -o json | jq -r '.spec.egress[0].to[0].podSelector.matchLabels.app'"
  assert_output --partial $selector
}