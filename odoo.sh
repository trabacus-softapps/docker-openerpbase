#!/bin/bash
set -e
source /pd_build/buildconfig

header "Installing Odoo Runint Script... "

## Install Odoo runit service.
run mkdir /etc/service/odoo
run cp /pd_build/runit/odoo /etc/service/odoo/run
