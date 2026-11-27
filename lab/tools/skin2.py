import numpy as np, json, struct
import sys;SP=sys.argv[1];d=np.load(SP+'_mesh.npz');P=d['pos'].astype(np.float64);F=d['faces'];C=d['col'];M=d['mat']
J=d['J']
# 法線
N=np.zeros_like(P);v0,v1,v2=P[F[:,0]],P[F[:,1]],P[F[:,2]];fn=np.cross(v1-v0,v2-v0)
for k in range(3):np.add.at(N,F[:,k],fn)
N/=np.linalg.norm(N,axis=1,keepdims=True)+1e-12
# 外向きか確認（重心から外へ）
c=P.mean(0);s=np.sign(((P-c)*N).sum(1).mean());N*=s;print('normal sign',s)
def seg(a,b,r):
    a=J[a];b=J[b];ba=b-a;h=np.clip(((P-a)@ba)/(ba@ba),0,1);return np.linalg.norm(P-(a+np.outer(h,ba)),axis=1)-r
B=[]
B.append(np.linalg.norm(P-(J[0]+[0,0.2,0.02]),axis=1)-0.3)      # 0 胴
B.append(np.linalg.norm(P-J[2],axis=1)-0.45)                      # 1 頭
B.append(seg(1,2,0.12))                                           # 2 首
B.append(seg(3,4,0.12));B.append(np.minimum(seg(4,5,0.11),np.linalg.norm(P-J[5],axis=1)-0.16))   # 3,4 左腕
B.append(seg(6,7,0.12));B.append(np.minimum(seg(7,8,0.11),np.linalg.norm(P-J[8],axis=1)-0.16))   # 5,6 右腕
B.append(seg(9,10,0.15));B.append(seg(10,11,0.11));B.append(seg(11,15,0.1))                      # 7,8,9 左脚
B.append(seg(12,13,0.15));B.append(seg(13,14,0.11));B.append(seg(14,16,0.1))                     # 10,11,12 右脚
D=np.stack(B,1)
if SP=='slime' or ('kit' in d.files and str(d['kit'])=='slime'): D=np.zeros_like(D)+9; D[:,0]=0
D[M==3,0]-=0.12            # 腰布は胴について行く
D[:,2]+=0.03               # 首は弱め
o=np.argsort(D,1)[:,:2];d1=np.take_along_axis(D,o,1)
w=np.exp(-(d1-d1[:,:1])/0.035);w/=w.sum(1,keepdims=True)
HASW='wpn' in d.files and d['wpn'].sum()>0
if HASW:   # 武器・盾・弓は、近いほうの手の前腕にかたく付ける
    m=d['wpn']>0;hl=np.linalg.norm(P-J[5],axis=1);hr=np.linalg.norm(P-J[8],axis=1);bn=np.where(hl<hr,4,6)
    o[m,0]=bn[m];o[m,1]=bn[m];w[m,0]=1.0;w[m,1]=0.0
print('bone use',np.bincount(o[:,0],minlength=13))
NV=len(P);NT=len(F)
with open('../mon_'+SP+'.bin','wb') as f:
    f.write(b'GB1W' if HASW else b'GB01');f.write(struct.pack('<II',NV,NT))
    f.write(P.astype(np.float32).tobytes())
    f.write(np.clip(np.round(N*127),-127,127).astype(np.int8).tobytes())
    f.write(C.astype(np.uint8).tobytes())
    f.write(o.astype(np.uint8).tobytes())
    f.write(np.round(w[:,0]*255).astype(np.uint8).tobytes())
    f.write(F.astype(np.uint16).tobytes())
    if HASW: f.write(d['wpn'].astype(np.uint8).tobytes())
import os;print('bytes',os.path.getsize('../mon_'+SP+'.bin'))
