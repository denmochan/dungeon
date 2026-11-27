#!/bin/bash
# 顔のある種族を、顔を焼かずに取り直す（顔はなめらかな絵で貼る）
cd "$(dirname "$0")"
for sp in human orc myconid imp ghost slime bat gobx hunter warrior thief priest mage knight slimeknight rotlord ifrit webgoblin sapper shaman ghoul rotslime lavaslime ghostslime gemeater firebat minerorc berserker ogremage bogtroll sporewraith fungus gargoyle; do
  SH=$sp; [ $sp = gargoyle ] && SH=imp
  XT=""; [ -f xtra/$sp.glsl ] && XT=xtra/$sp.glsl
  T=7000; case $sp in human|hunter|warrior|thief|priest|mage|knight|slimeknight) T=8000;; esac
  NOFACE=1 ./rebuild.sh $sp $SH "$XT" $T 2>&1 | grep -v agent-proxy | tail -1
done
echo ALLDONE
