FROM runner-base:22.04

ARG source_github_repository="A1EBD7CC0EB3/runner-images"
ARG helper_script_folder="/imagegeneration/scripts/helpers"
ARG image_folder="/imagegeneration"
ARG image_os="ubuntu22"
ARG image_version="dev"
ARG imagedata_file="/imagegeneration/imagedata.json"
ARG installer_script_folder="/imagegeneration/scripts/installers"
ARG install_password=""
ARG run_validation_diskspace=false
ARG copy_dir="/imagegeneration"
ARG packer_builder_type="docker"
ARG installer_source="dockerfile"

# Make sure vars are available everywhere since the sudos reset the shell if using ENV
RUN sudo mv /etc/environment /etc/environment.clean \
 && echo RUNNER_SOURCE_GITHUB_REPOSITORY="${source_github_repository}" | sudo tee -a /etc/environment \
 && echo HELPER_SCRIPTS="${helper_script_folder}" | sudo tee -a /etc/environment \
 && echo IMAGE_FODLER="${image_folder}" | sudo tee -a /etc/environment \
 && echo IMAGE_OS="${image_os}" | sudo tee -a /etc/environment \
 && echo IMAGE_VERSION="${image_version}" | sudo tee -a /etc/environment \
 && echo IMAGEDATA_FILE="${imagedata_file}" | sudo tee -a /etc/environment \
 && echo INSTALLER_SCRIPT_FOLDER="${installer_script_folder}" | sudo tee -a /etc/environment \
 && echo INSTALLER_PASSWORD="${install_password}" | sudo tee -a /etc/environment \
 && echo RUN_VALIDATION_DISKSPACE=${run_validation_diskspace} | sudo tee -a /etc/environment \
 && echo PACKER_BUILDER_TYPE="${packer_builder_type}" | sudo tee -a /etc/environment \
 && echo INSTALLER_SOURCE="${installer_source}" | sudo tee -a /etc/environment 

LABEL org.opencontainers.image.source https:#github.com/${source_github_repository}

# TODO: (perhaps) Copy each script right before execution for better caching
#COPY ./scripts ${copy_dir}/scripts

COPY ./scripts/base/ ${copy_dir}/scripts/base/
COPY ./scripts/docker/ ${copy_dir}/scripts/docker/
COPY ./scripts/helpers/ ${copy_dir}/scripts/helpers/
COPY ./scripts/installers/ ${copy_dir}/scripts/installers/
COPY ./scripts/tests ${copy_dir}/scripts/tests

COPY ./toolsets/toolset-2204.json ${copy_dir}/installers/toolset.json
# COPY ./scripts/base/ ${copy_dir}/scripts/base/
# COPY ./scripts/docker/ ${copy_dir}/scripts/docker/
# COPY ./scripts/helpers/ ${copy_dir}/scripts/helpers/
# COPY ./scripts/installers/ ${copy_dir}/scripts/installers/
# COPY ./scripts/SoftwareReport/ ${copy_dir}/SoftwareReport/
# COPY ./scripts/tests ${copy_dir}/tests
# COPY ./toolsets/toolset-2204.json ${installer_script_folder}/toolset.json
# COPY ./toolsets/toolset-2204.json ${copy_dir}/installers/toolset.json

# Matching packer build even though its gross
# RUN sudo mkdir -p ${copy_dir}/helpers/ \
#     ${copy_dir}/SoftwareReport/ \
#     ${copy_dir}/tests/ \
#     ${copy_dir}/installers/ \
 RUN sudo ln -s ${copy_dir}/scripts/tests/ ${copy_dir}/tests \
 && sudo ln -s ${copy_dir}/scripts/helpers/ ${copy_dir}/helpers \
 && sudo ln -s ${copy_dir}/installers/toolset.json ${copy_dir}/scripts/installers/toolset.json

WORKDIR ${copy_dir}

# Sudo to emulate what packer is doing
RUN sudo find ./ -iname '*.sh' -exec chmod +x {} \;

RUN sudo ./scripts/docker/prereqs.sh
RUN sudo chmod 777 ${image_folder}

RUN sudo ./scripts/base/apt-mock.sh
RUN sudo ./scripts/base/repos.sh
RUN sudo ./scripts/base/apt.sh
RUN sudo ./scripts/base/limits.sh


RUN sudo ./scripts/installers/preimagedata.sh
RUN sudo ./scripts/installers/configure-environment.sh

RUN sudo ./scripts/installers/powershellcore.sh


RUN sudo pwsh -f ./scripts/installers/Install-PowerShellModules.ps1 \
 && sudo pwsh -f ./scripts/installers/Install-AzureModules.ps1

# many things
# Can split to individual copies to improve caching if want to unwind everything
RUN sudo ./scripts/installers/azcopy.sh
RUN sudo ./scripts/installers/azure-cli.sh
RUN sudo ./scripts/installers/azure-devops-cli.sh
RUN sudo ./scripts/installers/basic.sh
RUN sudo ./scripts/installers/bicep.sh
RUN sudo ./scripts/installers/aliyun-cli.sh
#RUN sudo"./scripts/installers/apache.sh
RUN sudo ./scripts/installers/aws.sh
RUN sudo ./scripts/installers/clang.sh
RUN sudo ./scripts/installers/cmake.sh
RUN sudo ./scripts/installers/codeql-bundle.sh
RUN sudo ./scripts/installers/containers.sh
RUN sudo ./scripts/installers/dotnetcore-sdk.sh
RUN sudo ./scripts/installers/microsoft-edge.sh
RUN sudo ./scripts/installers/gcc.sh
RUN sudo ./scripts/installers/gfortran.sh
RUN sudo ./scripts/installers/git.sh
RUN sudo ./scripts/installers/github-cli.sh
RUN sudo ./scripts/installers/google-chrome.sh
RUN sudo ./scripts/installers/google-cloud-sdk.sh
RUN sudo ./scripts/installers/haskell.sh
RUN sudo ./scripts/installers/heroku.sh
RUN sudo ./scripts/installers/java-tools.sh
RUN sudo ./scripts/installers/kubernetes-tools.sh
RUN sudo ./scripts/installers/oc.sh
RUN sudo ./scripts/installers/leiningen.sh
RUN sudo ./scripts/installers/miniconda.sh
RUN sudo ./scripts/installers/mono.sh
RUN sudo ./scripts/installers/kotlin.sh
#RUN sudo"./scripts/installers/mysql.sh
RUN sudo ./scripts/installers/mssql-cmd-tools.sh
#RUN sudo"./scripts/installers/sqlpackage.sh
#RUN sudo"./scripts/installers/nginx.sh
RUN sudo ./scripts/installers/nvm.sh
RUN sudo ./scripts/installers/nodejs.sh
RUN sudo ./scripts/installers/bazel.sh
RUN sudo ./scripts/installers/oras-cli.sh
RUN sudo ./scripts/installers/php.sh
#RUN sudo"./scripts/installers/postgresql.sh
RUN sudo ./scripts/installers/pulumi.sh
RUN sudo ./scripts/installers/ruby.sh
RUN sudo ./scripts/installers/r.sh
RUN sudo ./scripts/installers/rust.sh
RUN sudo ./scripts/installers/julia.sh
RUN sudo ./scripts/installers/sbt.sh
RUN sudo ./scripts/installers/selenium.sh
RUN sudo ./scripts/installers/terraform.sh
RUN sudo ./scripts/installers/packer.sh
RUN sudo ./scripts/installers/vcpkg.sh
RUN sudo ./scripts/installers/dpkg-config.sh
RUN sudo ./scripts/installers/yq.sh
RUN sudo ./scripts/installers/android.sh
RUN sudo ./scripts/installers/pypy.sh
RUN sudo ./scripts/installers/python.sh
RUN sudo ./scripts/installers/graalvm.sh


RUN sudo pwsh -f ./scripts/installers/Install-Toolset.ps1 \
 && sudo pwsh -f  ./scripts/installers/Configure-Toolset.ps1 \
 && sudo rm -rf /imagegeneration/*.tar.gz \
 && sudo rm -rf /imagegeneration/scripts/installers/*.tar.gz \
 && sudo rm -f /imagegeneration/minikube-linux-amd64


RUN sudo ./scripts/installers/pipx-packages.sh

RUN sudo ./scripts/installers/homebrew.sh
RUN sudo ./scripts/docker/cpan-setup.sh
RUN sudo ./scripts/docker/homebrew-setup.sh
RUN sudo ./scripts/installers/cleanup.sh
RUN sudo ./scripts/base/apt-mock-remove.sh

# Brew not found -- something is wrong with the PATH and ENV inside powershell :(
#   Turns out our base image set PATH as an ENV and we can't simply UNSET it :((
#    May need to dump this to file
ENV PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/runner/.local/bin:/opt/pipx_bin:/usr/local/.ghcup/bin:/etc/skel/.cargo/bin:/etc/skel/.dotnet/tools"

# RUN sudo sed -i 's;PATH=.*;PATH='$PATH';g' \
# /home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/runner/.local/bin:/opt/pipx_bin:/usr/local/.ghcup/bin:/etc/skel/.cargo/bin:/etc/skel/.dotnet/tools;g' /etc/environment \
#     && echo source /etc/environment >> ~/.bashrc

# missing $HOME/.config/composer/vendor/bin
# Could also add /opt/hostedtoolcache/CodeQL/0.0.0-20220825/x64/codeql/codeql

# Updating tests wont bust cache
COPY ./scripts/SoftwareReport/ ${copy_dir}/scripts/SoftwareReport/
RUN sudo ln -s ${copy_dir}/scripts/SoftwareReport/ ${copy_dir}/SoftwareReport

RUN sudo pwsh -File ${image_folder}/SoftwareReport/SoftwareReport.Generator.ps1 -OutputDirectory ${image_folder} \
 && sudo pwsh -File ${image_folder}/tests/RunAll-Tests.ps1 -OutputDirectory ${image_folder}

# Mocking file created by packer
# RUN sudo touch post-generation
# This CHMODs files after the fact. Bad to do in docker
# RUN sudo ./scripts/installers/post-deployment.sh
# Cleanup script not useful at end of dockerfile
# RUN sudo ./scripts/docker/cleanup.sh
RUN sudo ./scripts/installers/validate-disk-space.sh
# RUN sudo mkdir -p /etc/vsts \
# COPY ubuntu2204.conf /etc/vsts/machine_instance.conf

RUN sudo sed -i 's;PATH=.*;PATH='$PATH';g' /etc/environment \
 && echo source /etc/environment >> ~/.bashrc

WORKDIR /
