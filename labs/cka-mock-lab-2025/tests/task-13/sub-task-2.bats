# File: cka-mock-lab/tests/task-13/sub-task-2.bats
#!/usr/bin/env bats

load "../../../../node_modules/bats-assert/load"
load "../../../../node_modules/bats-support/load"

@test "NetworkPolicy 'frontend-backend-policy' should select pods with label 'app: frontend'" {
  policy_name=frontend-backend-policy
  namespace=microservices
  selector=frontend
  run bash -c "kubectl get networkpolicy $policy_name -n $namespace -o json | jq -r '.spec.podSelector.matchLabels.app'"
  assert_output --partial $selector
}