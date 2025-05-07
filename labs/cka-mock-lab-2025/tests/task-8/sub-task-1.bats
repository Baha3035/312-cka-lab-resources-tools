# File: cka-mock-lab/tests/task-8/sub-task-1.bats
#!/usr/bin/env bats

load "../../../../node_modules/bats-assert/load"
load "../../../../node_modules/bats-support/load"

@test "Deployment 'frontend-app' container 'nginx' should expose port 80" {
  deployment_name=frontend-app
  namespace=web-frontend
  port=80
  run bash -c "kubectl get deployment $deployment_name -n $namespace -o json | jq '.spec.template.spec.containers[0].ports[0].containerPort'"
  assert_output --partial $port
}