#!/bin/bash
# 箱で切れていた種族を取り直す（11/28）。種族ごとの決まり（顔なし・足し形・形を借りる・格子・頂点数）はここにまとめる
cd "$(dirname "$0")"
NF=" bogtroll fungus gargoyle ghostslime ifrit imp mage rotlord rotslime sapper shaman webgoblin myconid lord "
for sp in "$@"; do
  SH=$sp; [ $sp = gargoyle ] && SH=imp; [ $sp = jackal ] && SH=kobold
  XT=""; [ -f xtra/$sp.glsl ] && XT=xtra/$sp.glsl; [ $sp = sporerat ] && XT=xtra/rat.glsl
  T=7000; case $sp in lord|mage|count|dragon|bonedragon|elderdragon|maou|underlord|bogtroll) T=8000;; slimeknight) T=9000;; esac
  G=0.017; case $sp in bogtroll|slimeknight) G=0.019;; dragon|bonedragon|elderdragon|lord) G=0.02;; esac
  NFV=""; [[ "$NF" == *" $sp "* ]] && NFV=1
  VZ=""; [ $sp = underlord ] && VZ=2
  NOFACE=$NFV VARZ=$VZ GS=$G ./rebuild.sh $sp $SH "$XT" $T 2>&1 | grep -iE "^mon_|error|TOO" | tail -2
done
