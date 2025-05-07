# Solution:
# 1. Install cri-dockerd
sudo apt-get update
sudo apt-get install -y cri-dockerd

# 2. Enable and start the service
sudo systemctl enable cri-dockerd
sudo systemctl start cri-dockerd

# 3. Set the required sysctl parameters
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward = 1
net.ipv6.conf.all.forwarding = 1
net.netfilter.nf_conntrack_max = 131072
EOF

sudo sysctl --system

# Verify the settings
sudo sysctl -a | grep -E 'net.bridge.bridge-nf-call-ip|net.ipv4.ip_forward|net.ipv6.conf.all.forwarding|net.netfilter.nf_conntrack_max'