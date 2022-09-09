if [ "${PACKER_BUILDER_TYPE}" == "docker" ]; then
    rm -f /*.tar.gz*
    rm -f /minikube-linux-amd64
    rm -f *.deb*
fi