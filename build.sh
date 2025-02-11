#!/usr/bin/env bash
#
# Copyright 2019 OpenIndex.de
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

OPENJDK_VERSION="jdk11u"
OPENJDK_TAG="jdk-11.0.3+6"
OPENJDK_NAME="jdk-11.0.3"
#OPENJDK_CONFIGURE_ARGS=""
OPENJDK_CONFIGURE_ARGS="--disable-warnings-as-errors"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TARGET_DIR="${DIR}/package"
TARGET_FILE_JDK="${OPENJDK_TAG}-linux-x86.tar.gz"
TARGET_FILE_JRE="${OPENJDK_TAG}-jre-linux-x86.tar.gz"

# Remove target directory.
rm -Rf "${TARGET_DIR}"

# Extract Bootstrap JDK.
BOOTSTRAP_JDK="${DIR}/bootstrap/zulu10.3+5-jdk10.0.2-linux_i686"
if [[ ! -d "${BOOTSTRAP_JDK}" ]] ; then
  cd "${DIR}/bootstrap"
  cat zulu10.3+5-jdk10.0.2-linux_i686.tar.gz-* | tar xz
fi

# Update git submodule for openjdk-build by AdoptOpenJDK.
cd "${DIR}/openjdk-build"
git submodule update --init --recursive

# Build OpenJDK.
cd "${DIR}/openjdk-build"
./makejdk-any-platform.sh \
  --jdk-boot-dir "${BOOTSTRAP_JDK}" \
  --tag "${OPENJDK_TAG}" \
  --use-jep319-certs \
  --configure-args "${OPENJDK_CONFIGURE_ARGS}" \
  "${OPENJDK_VERSION}"

# Copy created images into target directory.
IMAGE_NAME="$( ls -1 "${DIR}/openjdk-build/workspace/build/src/build" )"
IMAGE_DIR="${DIR}/openjdk-build/workspace/build/src/build/${IMAGE_NAME}/images"
mkdir -p "${TARGET_DIR}"
if [[ -d "${IMAGE_DIR}/${OPENJDK_NAME}" ]] ; then
  cd "${IMAGE_DIR}"
  echo "Copy JDK image to ${TARGET_DIR}/${TARGET_FILE_JDK}"
  tar cfz "${TARGET_DIR}/${TARGET_FILE_JDK}" "${OPENJDK_NAME}"
fi

if [[ -d "${IMAGE_DIR}/${OPENJDK_NAME}-jre" ]] ; then
  cd "${IMAGE_DIR}"
  echo "Copy JRE image to ${TARGET_DIR}/${TARGET_FILE_JRE}"
  tar cfz "${TARGET_DIR}/${TARGET_FILE_JRE}" "${OPENJDK_NAME}-jre"
fi
