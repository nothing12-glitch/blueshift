#!/usr/bin/env bash
# The files module copies without exec bits; restore them for our launchers.
set -euo pipefail
chmod 755 /usr/lib/blueshift/portal/yafti_gtk.py
chmod 755 /usr/lib/blueshift/firstboot.sh
exit 0
