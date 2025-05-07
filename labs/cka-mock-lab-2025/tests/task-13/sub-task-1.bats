# File: cka-mock-lab/tests/task-13/sub-task-1.bats
#!/usr/bin/env bats

load "../../../../node_modules/bats-assert/load"
load "../../../../node_modules/bats-support/load"

@test "NetworkPolicy 'frontend-backend-policy' exists in namespace 'microservices'" {
  policy_name=frontend-backend-policy
  namespace=microservices
  run bash -c "kubectl get networkpolicy $policy_name -n $namespace -o json | jq '.metadata.name'"
  assert_output --partial $policy_name
}