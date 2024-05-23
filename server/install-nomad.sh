# Config-Manager install
sudo dnf install -y dnf-plugins-core
# Add HashiCorp repo
sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
# Nomad install
sudo dnf -y install nomad

# CNI plugin install
curl -L -o cni-plugins.tgz "https://github.com/containernetworking/plugins/releases/download/v1.0.0/cni-plugins-linux-$( [ $(uname -m) = aarch64 ] && echo arm64 || echo amd64)"-v1.0.0.tgz && \
  sudo mkdir -p /opt/cni/bin && \
  sudo tar -C /opt/cni/bin -xzf cni-plugins.tgz

# Set iptable tunables
echo 1 | sudo tee /proc/sys/net/bridge/bridge-nf-call-arptables && \
  echo 1 | sudo tee /proc/sys/net/bridge/bridge-nf-call-ip6tables && \
  echo 1 | sudo tee /proc/sys/net/bridge/bridge-nf-call-iptables

# Preserve tunables on startup
sudo echo "net.bridge.bridge-nf-call-arptables = 1\nnet.bridge.bridge-nf-call-ip6tables = 1\nnet.bridge.bridge-nf-call-iptables = 1\n\n" >> /etc/sysctl.d/bridge.conf

# Verify cgroups
cat /sys/fs/cgroup/cgroup.controllers

# Nomad version
nomad -v
