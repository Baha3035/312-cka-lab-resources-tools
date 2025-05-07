# File: cka-mock-lab/tests/task-2/sub-task-4.bats
#!/usr/bin/env bats

load "../../../../node_modules/bats-assert/load"
load "../../../../node_modules/bats-support/load"

@test "Ingress should use TLS with secret 'galaxy-tls-cert'" {
  ingress_name=galaxy-messenger-ingress
  namespace=comms
  secret_name="galaxy-tls-cert"
  run bash -c "kubectl get ingress $ingress_name -n $namespace -o json | jq -r '.spec.tls[0].secretName'"
  assert_output --partial $secret_name
}