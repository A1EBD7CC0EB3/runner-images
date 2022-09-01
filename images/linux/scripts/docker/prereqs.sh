#!/bin/bash -e
if [ "${PACKER_BUILDER_TYPE}" == "docker" ]; then
    apt-get update 
    apt-get install -y apt-utils
    # apt-get install -y \
    #     sudo \
    #     lsb-release \
    #     wget \
    #     apt-utils \
    #     jq \
    #     apt-transport-https \
    #     software-properties-common

    # Root is not in sudoers file message ????
    adduser root sudo

    # get powershell
    wget -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb"
    dpkg -i packages-microsoft-prod.deb
    apt-get update
    apt-get install -y powershell
fi
