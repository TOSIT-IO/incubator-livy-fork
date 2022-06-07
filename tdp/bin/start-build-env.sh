#!/bin/bash

IMAGE_NAME=tdp-builder-livy

docker build . -t "${IMAGE_NAME}"

USER_NAME="${SUDO_USER:=$USER}"
USER_ID=$(id -u "${USER_NAME}")
GROUP_ID=$(id -g "${USER_NAME}")

docker build -t "${IMAGE_NAME}-${USER_NAME}" - <<UserSpecificDocker
FROM ${IMAGE_NAME}
RUN groupadd --non-unique -g ${GROUP_ID} ${USER_NAME}
RUN useradd -g ${GROUP_ID} -u ${USER_ID} -k /root -m ${USER_NAME}
RUN echo "${USER_NAME} ALL=NOPASSWD: ALL" > "/etc/sudoers.d/tdp-builder-${USER_ID}"
ENV HOME /home/${USER_NAME}

UserSpecificDocker

TDP_HOME="${TDP_HOME:=$(pwd)}"

docker run --rm=true -t -i \
  -v "${TDP_HOME}:/tdp" \
  -w "/tdp" \
  -v "${HOME}/.m2:/home/${USER_NAME}/.m2${V_OPTS:-}" \
  -u "${USER_NAME}" \
  --ulimit nofile=500000:500000 \
  "${IMAGE_NAME}-${USER_NAME}"
