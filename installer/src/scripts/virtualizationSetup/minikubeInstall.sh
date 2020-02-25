
set -euo pipefail

install_kvm() {
    sudo apt -y install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils
    sudo adduser `id -un` libvirt
    sudo apt -y install virt-manager
}

install_minikube() {
    curl -Lo /tmp/minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x /tmp/minikube
    sudo mkdir -p /usr/local/bin/
    sudo install /tmp/minikube /usr/local/bin/
}

install_kvm
install_minikube