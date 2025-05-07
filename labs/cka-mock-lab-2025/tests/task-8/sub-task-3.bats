# File: cka-mock-lab/tests/task-8/sub-task-3.bats
#!/usr/bin/env bats

load "../../../../node_modules/bats-assert/load"
load "../../../../node_modules/bats-support/load"

@test "Service 'frontend-svc' should target port 80" {
  service_name=frontend-svc
  namespace=web-frontend
  port=80
  run bash -c "kubectl get svc $service_name -n $namespace -o json | jq '.spec.ports[0].port'"
  assert_output --partial $port
}