#!/bin/bash -eux

SSH_USER=${SSH_USERNAME:-vagrant}

export HOME=/home/${SSH_USER}

echo "==> Installing pyenv build tools"
# From https://github.com/yyuu/pyenv/wiki/Common-build-problems
sudo apt-get install -y \
    make \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    curl \
    llvm

echo "==> Preparing pyenv configuration."
cat <<EOF >> /home/${SSH_USER}/.bashrc
export PATH="\$HOME/.pyenv/bin:\$PATH"
eval "\$(pyenv init -)"
eval "\$(pyenv virtualenv-init -)"
EOF

echo "==> Installing pyenv"
su ${SSH_USER} <<EOF
curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
source ~/.bashrc
/home/${SSH_USER}/.pyenv/bin/pyenv install 3.4.3
/home/${SSH_USER}/.pyenv/bin/pyenv global 3.4.3
EOF

chown -R ${SSH_USER}:${SSH_USER} /home/${SSH_USER}
export HOME=/home/root
