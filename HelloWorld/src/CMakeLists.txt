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
# under the License.

file(GLOB SOURCE_FILES *.c)
file(GLOB HEADER_FILES *.h)
set(PRIVATE_HEADER_FILES)

add_executable(${PROJECT_NAME} ${SOURCE_FILES})

message(${ESP_USER_CONFIG_DIR})

target_include_directories(${PROJECT_NAME} PUBLIC ${ESP_USER_CONFIG_DIR})

set_target_properties(
    ${PROJECT_NAME}
    PROPERTIES
    FRAMEWORK ON
    PUBLIC_HEADER "${HEADER_FILES}"
    PRIVATE_HEADER "${PRIVATE_HEADER_FILES}")

esp_gen_exec_targets(${PROJECT_NAME})
