#!/usr/bin/env bash

# Copyright 2018 Rafal Zajac <rzajac@gmail.com>.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations

# Script for initializing ESP8266 development environment.

echo "Initializing up ESP8266 development environment."
if [ "${ESPROOT}" == "" ]; then export ESPROOT=$HOME/esproot; fi
if ! [ -d "${ESPROOT}" ]; then mkdir -p ${ESPROOT}; fi
echo "Using ${ESPROOT} as ESPROOT."

echo "export ESPROOT=$ESPROOT" >> ~/.profile
echo "export PATH=\$ESPROOT/esp-open-sdk/xtensa-lx106-elf/bin:\$PATH" >> ~/.profile

(
    cd ${ESPROOT}
    mkdir lib include bin src

    
    ESP_CMAKE_REPO="https://github.com/rzajac/esp-dev-env.git"

    # No modifications below this comment unless you know what you're doing.
    ESP_ENV_DST_DIR=${ESPROOT}/src/esp-dev-env
    ESP_CMAKE_DST_DIR=${ESPROOT}/esp-cmake

    echo "Cloning ${ESP_CMAKE_REPO} to ${ESP_ENV_DST_DIR}."
    if [ -d "${ESP_ENV_DST_DIR}" ]; then
        echo "Directory ${ESP_ENV_DST_DIR} already exists. Will git reset."
        (cd ${ESP_ENV_DST_DIR} && git fetch && git reset --hard origin master)
    else
        git clone ${ESP_CMAKE_REPO} ${ESP_ENV_DST_DIR}
        if [ $? != 0 ]; then
            echo "Error: Cloning ${ESP_CMAKE_REPO} failed!"
            exit 1
        fi
    fi

    echo "Creating copy ${ESP_CMAKE_DST_DIR}"
    rm -rf ${ESP_CMAKE_DST_DIR}
    cp -r ${ESP_ENV_DST_DIR}/esp-cmake ${ESP_CMAKE_DST_DIR}
    cp ${ESP_ENV_DST_DIR}/src/include/esp.h ${ESPROOT}/include/esp.h
    cp ${ESP_ENV_DST_DIR}/src/include/user_config.h ${ESPROOT}/include/user_config.h
    cp ${ESP_ENV_DST_DIR}/lib-install.sh  ${ESPROOT}/bin

    git clone https://github.com/espressif/esptool.git
    if [ $? != 0 ]; then exit 1; fi

    git clone --recursive https://github.com/pfalcon/esp-open-sdk.git
    if [ $? != 0 ]; then exit 1; fi
)

echo
echo "Directory structure and all the necessary software has been checked out."
echo "Before you can compile and flash ESP8266 programs you must build "
echo "standalone version of esp-open-sdk:"
echo
echo "cd ${ESPROOT}/esp-open-sdk"
cd ${ESPROOT}/esp-open-sdk
echo "make"
make STANDALONE=y
echo
echo "Visit https://github.com/pfalcon/esp-open-sdk for more details."
echo "Good luck!"
echo
