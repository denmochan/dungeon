# 軽い版：近い頂点をまとめて数をへらし（cell m ごと）、位置を0.5mm刻み・差分・面の番号を可変長で詰める（GB03）
import gzip,struct,numpy as np,sys,os,glob
CELL=float(sys.argv[1]) if len(sys.argv)>1 else 0.024
def read(fn):
    b=gzip.open(fn).read();mg=b[:4];NV,NT=struct.unpack('<II',b[4:12]);o=12
    P=np.frombuffer(b[o:o+NV*12],np.float32).reshape(-1,3).astype(np.float64);o+=NV*12
    N=np.frombuffer(b[o:o+NV*3],np.int8).reshape(-1,3).astype(np.float64);o+=NV*3
    C=np.frombuffer(b[o:o+NV*3],np.uint8).reshape(-1,3).astype(np.float64);o+=NV*3
    B=np.frombuffer(b[o:o+NV*2],np.uint8).reshape(-1,2);o+=NV*2
    W=np.frombuffer(b[o:o+NV],np.uint8);o+=NV
    I=np.frombuffer(b[o:o+NT*6],np.uint16).reshape(-1,3).astype(np.int64);o+=NT*6
    WP=np.frombuffer(b[o:o+NV],np.uint8) if mg==b'GB1W' else np.zeros(NV,np.uint8)
    return mg,P,N,C,B,W,I,WP
def varint(a):
    out=bytearray()
    for v in a.tolist():
        while v>=128: out.append((v&127)|128); v>>=7
        out.append(v)
    return bytes(out)
for fn in sorted(glob.glob(os.path.join(os.path.dirname(__file__),'..','mon_*.bin.gz'))+[os.path.join(os.path.dirname(__file__),'..','gob3d.bin.gz')]):
    mg,P,N,C,B,W,I,WP=read(fn)
    cell=np.where(WP[:,None]>0,CELL*0.6,CELL)
    key=np.floor(P/cell).astype(np.int64);key=key[:,0]*73856093^key[:,1]*19349663^key[:,2]*83492791^(WP.astype(np.int64)<<40)   # 武器と体は混ぜない
    uk,inv=np.unique(key,return_inverse=True);n=len(uk)
    cnt=np.bincount(inv,minlength=n).astype(np.float64)
    P2=np.stack([np.bincount(inv,P[:,k],n)/cnt for k in range(3)],1)
    N2=np.stack([np.bincount(inv,N[:,k],n) for k in range(3)],1);N2/=np.linalg.norm(N2,axis=1,keepdims=True)+1e-9
    C2=np.stack([np.bincount(inv,C[:,k],n)/cnt for k in range(3)],1)
    rep=np.zeros(n,np.int64);d=np.linalg.norm(P-P2[inv],axis=1);order=np.lexsort((d,inv));first=np.ones(len(order),bool);first[1:]=inv[order][1:]!=inv[order][:-1];rep[inv[order][first]]=order[first]
    B2=B[rep];W2=W[rep];WP2=WP[rep]
    I2=inv[I];ok=(I2[:,0]!=I2[:,1])&(I2[:,1]!=I2[:,2])&(I2[:,0]!=I2[:,2]);I2=I2[ok]
    s=np.sort(I2,1);_,ui=np.unique(s,axis=0,return_index=True);I2=I2[np.sort(ui)]
    q=np.round(P2/0.0005).astype(np.int32);qd=np.diff(np.concatenate([np.zeros((1,3),np.int32),q]),axis=0).astype(np.int16)
    fl=I2.flatten();dd=np.diff(np.concatenate([[0],fl]));zz=((dd<<1)^(dd>>63)).astype(np.uint64)
    flag=1 if mg==b'GB02' else (2 if mg==b'GB1W' else 0)
    body=b''.join(qd[:,k].tobytes() for k in range(3))+b''.join(np.clip(np.round(N2[:,k]*127),-127,127).astype(np.int8).tobytes() for k in range(3))+b''.join(np.round(C2[:,k]).astype(np.uint8).tobytes() for k in range(3))+B2[:,0].tobytes()+B2[:,1].tobytes()+W2.tobytes()+(WP2.tobytes() if flag==2 else b'')+varint(zz)
    out=b'GB03'+struct.pack('<IIB',n,len(I2),flag)+body
    nm=os.path.basename(fn).replace('.bin.gz','.bin.gz')
    dst=os.path.join(os.path.dirname(__file__),'..','lite',nm)
    open(dst,'wb').write(gzip.compress(out,9))
    print(nm,len(P),'->',n,os.path.getsize(fn),'->',os.path.getsize(dst),flush=True)
