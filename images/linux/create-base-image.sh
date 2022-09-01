#!/bin/bash

git clone https://github.com/actions-runner-controller/actions-runner-controller.git
cd actions-runner-controller/runner
sed -i 's/ubuntu:20.04/ubuntu:22.04/g' action-runner.dockerfile
docker build -t runner-base:22.04 -f action-runner.dockerfile .

cd ../../
rm -rf actions-runner-controller