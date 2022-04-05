#!/bin/sh

set -euxo pipefail

cd examples/single-account
terraform init
terraform validate
