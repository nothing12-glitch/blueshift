#!/usr/bin/env bash
# ostree/bootc inherits the base image's initramfs, which carries the base
# Plymouth theme. Regenerate it here so the early boot splash uses ours.
plymouth-set-default-theme blueshift || true
dracut --regenerate-all --force || true
exit 0
