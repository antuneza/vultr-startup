#!/bin/sh

HOMEDIR=/home
ROOTDIR=/root

USERNAME=${USERNAME:-deploy}

SSH_DIR=".ssh"
USER_HOME="$HOMEDIR/$USERNAME"
ROOT_SSH_DIR="$ROOTDIR/$SSH_DIR"
USER_SSH_DIR="$USER_HOME/$SSH_DIR"

SUDOERS_DEPLOYFILE="/etc/sudoers.d/automate-deploy"

# Create user
adduser --disabled-password --gecos "" $USERNAME

# Copy SSH keys from root
mkdir -p $USER_SSH_DIR
chmod 700 $USER_SSH_DIR

cp "$ROOT_SSH_DIR/authorized_keys" "$USER_SSH_DIR/authorized_keys"
chmod 700 "$USER_SSH_DIR/authorized_keys"

chown -R $USERNAME:$USERNAME $USER_HOME

# Give sudo permissions to user with nopasswd
apt install -y sudo
usermod -aG sudo $USERNAME

echo "$USERNAME ALL = NOPASSWD: ALL" > $SUDOERS_DEPLOYFILE
visudo -c -f $SUDOERS_DEPLOYFILE

# Disable root SSH access
sed -i '/^PermitRootLogin[\t]\+\w\+$/{ s//PermitRootLogin no /g; }' /etc/ssh/sshd_config
systemctl restart ssh
