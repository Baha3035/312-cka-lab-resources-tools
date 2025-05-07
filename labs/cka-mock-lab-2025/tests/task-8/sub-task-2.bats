# File: cka-mock-lab/tests/task-8/sub-task-2.bats
#!/usr/bin/env bats

load "../../../../node_modules/bats-assert/load"
load "../../../../node_modules/bats-support/load"

@test "Service 'frontend-svc' exists in namespace 'web-frontend'" {
  service_name=frontend-svc
  namespace=web-frontend
  run bash -c "kubectl get svc $service_name -n $namespace -o json | jq '.metadata.name'"
  assert_output --partial $service_name
}