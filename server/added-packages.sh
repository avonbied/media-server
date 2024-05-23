# Podman install
sudo dnf install -v podman
# Podman Cockpit Module
sudo dnf install -y cockpit-podman

# Config-Manager install
sudo dnf install -y dnf-plugins-core
# Add HashiCorp repo
sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
# Nomad install
sudo dnf -y install nomad
