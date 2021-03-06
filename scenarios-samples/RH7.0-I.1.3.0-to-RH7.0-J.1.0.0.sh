#!/bin/bash
#
# Copyright (C) 2015 eNovance SAS <licensing@enovance.com>
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.
set -x

PREFIX="I13_J10"
source common/infra-virt.function

if snapshot_exists RH7.0-I.1.3.0; then
    snapshot_restore RH7.0-I.1.3.0
else
    drop_hosts os-ci-test4 router os-ci-test10 os-ci-test11 os-ci-test12
    deploy ~/data/sps-snippets/RH7.0-I.1.3.0-qcow/
    call_jenkins_job "puppet"
    snapshot_create RH7.0-I.1.3.0
fi

drop_hosts os-ci-test4 router
deploy ~/data/sps-snippets/RH7.0-J.1.0-qcow/
call_jenkins_job "upgrade"
