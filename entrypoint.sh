#!/bin/sh
set -eux
# export LC_ALL="en_GB.UTF-8"

UID=${1:-1000}
USER=${2:-kankyo}
GID=${3:-1000}
GROUP=${4:-kankyo}
DOCKER_GROUP=${5:-999}

# delgroup ping
# delgroup docker
# addgroup -g ${GID} ${GROUP}
# addgroup -g ${DOCKER_GROUP} docker
# adduser -D -h /home/kankyo -G ${GROUP} -u ${UID} ${USER}
# addgroup ${USER} docker

# if [[ "${UID}" != "1000" ]]; then
#     chown -R ${UID} /home/${USER}
# fi
# echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
# sudo -E -u ${USER} tmux
tmux
