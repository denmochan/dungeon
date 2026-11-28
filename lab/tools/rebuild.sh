#!/bin/bash
# 1種族を作り直す：./rebuild.sh 種族 [形を借りる種族] [GLSLの足し形] [軽い版の頂点数]
cd "$(dirname "$0")"; SP=$1; SH=${2:-$1}; XT=$3; T=${4:-7000}
SHAPE=$SH XTRA=$XT timeout 900 python3 extract2.py $SP ${GS:-0.017} 2>&1 | grep -E "^mesh|ERROR|Error" | head -3
python3 - "$SP" <<'PY'
import numpy as np,sys,subprocess
sp=sys.argv[1];d=np.load(sp+'_mesh.npz');J=d['J'];bip=all(J[i][1]>-5 for i in (3,6,9,12,15,16));kit=str(d['kit'])
subprocess.run(['python3','skin2.py' if (bip or kit=='slime') else 'skin3.py',sp])
PY
gzip -9f ../mon_$SP.bin && python3 qem.py $T ../mon_$SP.bin.gz ../lite/mon_$SP.bin.gz && rm -f ${SP}_mesh.npz
python3 - "$SP" <<'PY'
import json,os,gzip,struct,sys
sp=sys.argv[1];os.chdir('..');d=json.load(open('mon_index.json'))
b=gzip.open('lite/mon_%s.bin.gz'%sp).read();NV,NT,fl=struct.unpack('<IIB',b[4:13])
e=d.setdefault(sp,{"file":"lite/mon_%s.bin.gz"%sp,"fmt":"GB03","scale":None,"full":{"file":"mon_%s.bin.gz"%sp}})
e.update(bytes=os.path.getsize('lite/mon_%s.bin.gz'%sp),verts=NV,tris=NT,kind=["biped","pointskin","biped+weapon"][fl]);e['full']['bytes']=os.path.getsize('mon_%s.bin.gz'%sp);e['full']['fmt']=gzip.open('mon_%s.bin.gz'%sp).read()[:4].decode()
json.dump(d,open('mon_index.json','w'),ensure_ascii=False,indent=1)
PY
