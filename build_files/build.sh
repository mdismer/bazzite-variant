#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

dnf5 -y install dnf-plugins-core
dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
dnf config-manager addrepo --from-repofile=https://cli.github.com/packages/rpm/gh-cli.repo
rpm --import https://packages.microsoft.com/keys/microsoft.asc 
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | tee /etc/yum.repos.d/vscode.repo > /dev/null


dnf5 install -y code
dnf5 install gh -y --repo gh-cli
dnf5 install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# this installs a package from fedora repos
dnf5 install -y tmux 

dnf5 install -y nodejs

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
systemctl enable docker
