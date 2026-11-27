# 足のない子・四つ足など（人の形でない種族）：近い関節2つに重みをつける（GB02）。頭（関節1、ないときは0）は頭の回転HRで回す
import numpy as np, struct, sys, os
SP=sys.argv[1];d=np.load(SP+'_mesh.npz');P=d['pos'].astype(np.float64);F=d['faces'];C=d['col'];J=d['J']
N=np.zeros_like(P);v0,v1,v2=P[F[:,0]],P[F[:,1]],P[F[:,2]];fn=np.cross(v1-v0,v2-v0)
for k in range(3):np.add.at(N,F[:,k],fn)
N/=np.linalg.norm(N,axis=1,keepdims=True)+1e-12
c=P.mean(0);s=np.sign(((P-c)*N).sum(1).mean());N*=s
valid=[i for i in range(len(J)) if J[i][1]>-5 and i<40]
JV=J[valid];D=np.linalg.norm(P[:,None,:]-JV[None,:,:],axis=2)
if len(valid)==1: o=np.zeros((len(P),2),int);w=np.ones((len(P),2))*[1,0]
else:
    o=np.argsort(D,1)[:,:2];d1=np.take_along_axis(D,o,1);w=np.exp(-(d1-d1[:,:1])/0.08);w/=w.sum(1,keepdims=True)
bi=np.array(valid)[o]
NV=len(P);NT=len(F)
out='../mon_'+SP+'.bin'
with open(out,'wb') as f:
    f.write(b'GB02');f.write(struct.pack('<II',NV,NT))
    f.write(P.astype(np.float32).tobytes());f.write(np.clip(np.round(N*127),-127,127).astype(np.int8).tobytes())
    f.write(C.astype(np.uint8).tobytes());f.write(bi.astype(np.uint8).tobytes());f.write(np.round(w[:,0]*255).astype(np.uint8).tobytes());f.write(F.astype(np.uint16).tobytes())
print(SP,'joints',valid,'NV',NV,'bytes',os.path.getsize(out))
