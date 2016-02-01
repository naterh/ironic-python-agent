#!/bin/bash

# Copyright 2013 Rackspace, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This script reboots by echoing into /proc/sysrq_trigger.

set -e

# Make sure all functions of sysrq is enabled.
echo "1" > /proc/sys/kernel/sysrq

# Stop any MD Raid devices twice to make sure ordering is correct
mdadm --stop /dev/md*
mdadm --stop /dev/md*

echo "s" > /proc/sysrq-trigger
if [[ $1 = '-h' ]]; then
    echo "o" > /proc/sysrq-trigger
elif [[ $1 = '-r' ]]; then
    echo "b" > /proc/sysrq-trigger
fi
