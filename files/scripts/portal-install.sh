#!/usr/bin/env bash
# Встановлює BlueShift Portal (вендорений yafti-gtk, GPL-3.0) у образ
set -euo pipefail
cd "$(dirname "$0")/../.."

install -Dm755 portal/yafti_gtk.py /usr/lib/blueshift/portal/yafti_gtk.py
install -Dm644 portal/blueshift-portal.desktop /usr/share/applications/blueshift-portal.desktop
install -Dm644 portal/blueshift-portal.png /usr/share/pixmaps/blueshift-portal.png
install -Dm644 portal/yafti.yml /usr/share/yafti/yafti.yml
install -Dm644 portal/LICENSE-yafti-gtk /usr/share/doc/blueshift-portal/LICENSE-yafti-gtk
