#!/bin/bash
# 全種族を QEM で軽い版に（lab/lite/）
cd "$(dirname "$0")"
ls ../mon_*.bin.gz ../gob3d.bin.gz | xargs -P 2 -I{} sh -c 'f={}; b=$(basename $f); case $b in mon_warrior*|mon_knight*|mon_thief*|mon_hunter*|mon_mage*|mon_priest*|mon_human*|mon_lord*|mon_slimeknight*|mon_vampire*|mon_count*|mon_noble*|mon_dragon*|mon_bonedragon*|mon_elderdragon*|mon_maou*|mon_demon*|mon_underlord*) T=8000;; *) T=7000;; esac; timeout 1200 python3 qem.py $T $f ../lite/$b'
