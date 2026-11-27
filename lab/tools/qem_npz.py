# 細かい格子で取った形（npz）を、骨づけの前に 6万頂点以内へ減らす（色の境目＝顔の目・口を残す）
import sys,numpy as np
sys.path.insert(0,'.')
from qem import simplify
sp=sys.argv[1];T=int(sys.argv[2]) if len(sys.argv)>2 else 40000
d=dict(np.load(sp+'_mesh.npz'))
P=d['pos'].astype(np.float64);F=d['faces'].astype(np.int64);C=d['col'].astype(np.float64)
WP=d['wpn'] if 'wpn' in d else np.zeros(len(P),np.uint8)
if len(P)>T:
    keep,F2=simplify(P,C,F,WP,T,colw=0.02)
    for k in ('pos','col','mat'):
        if k in d: d[k]=d[k][keep]
    if 'wpn' in d: d['wpn']=d['wpn'][keep]
    d['faces']=F2.astype(np.int32)
np.savez(sp+'_mesh.npz',**d);print(sp,len(P),'->',len(d['pos']))
