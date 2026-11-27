import json,base64,numpy as np,time,sys
from playwright.sync_api import sync_playwright
from skimage import measure
sp=sys.argv[1]; GS=float(sys.argv[2]) if len(sys.argv)>2 else 0.017
sh0=json.load(open('shaders.json'));pk0=json.load(open('face.json'))
SAMP_MAIN=sh0['samp'][10047:];COLR_MAIN=sh0['colr'][10047:]
with sync_playwright() as p:
    b=p.chromium.launch(executable_path='/usr/bin/google-chrome',args=['--use-gl=angle','--use-angle=swiftshader','--enable-unsafe-swiftshader','--ignore-gpu-blocklist','--no-sandbox'])
    pg=b.new_page();pg.goto('http://localhost:8777/lab/');pg.wait_for_timeout(2500)
    info=pg.evaluate("""sp=>{const fs=makeFS24("train",[{sp}],1),kit=kitOf24(sp);const R=rigSp24(sp,'idle',0);
      return {fs,kit,FI:(FACEIDX24[kit]??-1),col:spCol24(sp),vr:(typeof varOf24!=='undefined'?varOf24(sp,0):spVar24(sp)),scl:spScl24(sp),J:R.J,HR:R.HR,TR:R.TR,tool:R.tool,deb:R.deb||[]}}""",sp)
    fs=info['fs'];i=fs.index('void main(){')
    sh={'vs':sh0['vs'],'samp':fs[:i]+SAMP_MAIN,'colr':fs[:i]+COLR_MAIN}
    pack={'face':pk0['face'],'faceIdx':info['FI']}
    rig={'J':info['J'],'HR':info['HR'],'TR':info['TR']};L={'col':info['col'],'vr':info['vr']}
    J=np.array([j for j in info['J'] if j[1]>-5]);print(sp,info['kit'],'FI',info['FI'],'scl',info['scl'],'tool',info['tool'],'J',J.min(0),J.max(0))
    lo=np.array([J[:,0].min()-0.8,-0.05,J[:,2].min()-0.7]);hi=np.array([J[:,0].max()+0.8,J[:,1].max()+0.8,J[:,2].max()+0.7])
    N=np.ceil((hi-lo)/GS).astype(int)+1;NX,NY,NZ=map(int,N);print('grid',NX,NY,NZ)
    pg2=b.new_page();pg2.goto('file://'+__import__('os').path.abspath('sampler.html')+'');pg2.evaluate('([s,p])=>init(s,p)',[sh,pack]);pg2.evaluate('p=>{window.__P=p}',pack)
    # sampler setRig uses tool=0, deb zeros
    def grid(tool):
        rig['tool']=tool
        D=np.zeros((NZ,NY,NX),np.float32);M=np.zeros((NZ,NY,NX),np.uint8);step=12
        for z0 in range(0,NZ,step):
            nz=min(step,NZ-z0)
            s=pg2.evaluate('([r,L,G0,GS,NX,NY,z0,nz])=>sample(window.__P,r,L,G0,GS,NX,NY,z0,nz)',[rig,L,lo.tolist(),GS,NX,NY,z0,nz])
            a=np.frombuffer(base64.b64decode(s),np.uint8).reshape(nz,NY,NX,4).astype(np.float32)
            D[z0:z0+nz]=(a[...,0]/255+a[...,1]/255/255)*0.5-0.25;M[z0:z0+nz]=np.round(a[...,2]/255*20).astype(np.uint8)
        return D,M
    t=time.time();D,M=grid(0)
    TOOL=info['tool'] if len(sys.argv)<=3 else float(sys.argv[3])
    DW=None
    if TOOL and TOOL!=0:
        Dt,_=grid(TOOL);DW=np.maximum(Dt,-D+0.004)   # 道具だけ：道具ありの形から体を引く
        if (DW<0).sum()<30: DW=None
    rig['tool']=0
    print('sampled',round(time.time()-t,1),'inside',(D<0).sum(),'tool',TOOL,'wpn',None if DW is None else int((DW<0).sum()))
    verts,faces,norms,_=measure.marching_cubes(D,0.0,spacing=(GS,GS,GS))
    if len(verts)>int(__import__("os").environ.get("VMAX","60000")): print('TOO_MANY',len(verts));b.close();sys.exit(3)
    verts=verts[:,::-1]+lo;faces=faces[:,::-1]
    print('mesh',len(verts),len(faces))
    wpn=np.zeros(len(verts),np.uint8)
    if DW is not None:
        vw,fw,_,_=measure.marching_cubes(DW,0.0,spacing=(GS,GS,GS));vw=vw[:,::-1]+lo;fw=fw[:,::-1]
        faces=np.concatenate([faces,fw+len(verts)]);verts=np.concatenate([verts,vw]);wpn=np.concatenate([wpn,np.ones(len(vw),np.uint8)])
        print('weapon verts',len(vw))
        if len(verts)>int(__import__("os").environ.get("VMAX","60000")): print('TOO_MANY',len(verts));b.close();sys.exit(3)
    pos=verts.astype(np.float32)
    def cols(tool):
        rig['tool']=tool
        s=pg2.evaluate('([r,L,pb,nv])=>colors(window.__P,r,L,pb,nv)',[rig,L,base64.b64encode(pos.tobytes()).decode(),len(pos)])
        return np.frombuffer(base64.b64decode(s),np.uint8).reshape(-1,4)
    c=cols(0)
    if DW is not None: c2=cols(TOOL);c=np.where(wpn[:,None]>0,c2,c)
    rig['tool']=0
    np.savez(f'{sp}_mesh.npz',pos=pos,faces=faces.astype(np.int32),col=c[:,:3],mat=np.round(c[:,3]/255*20).astype(np.uint8),J=np.array(info['J']),scl=info['scl'],kit=info['kit'],wpn=wpn,tool=TOOL,J33=np.array(info['J']))
    b.close()
print('saved')
