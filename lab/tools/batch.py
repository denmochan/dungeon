import subprocess,sys,os,json
SPS=sys.argv[1].split(',')
BIP={'goblin','skeleton','imp','kobold','orc','golem','human'}
for sp in SPS:
    if os.path.exists(f'../mon_{sp}.bin.gz') and '--force' not in sys.argv: print('skip',sp,flush=True);continue
    gs=0.017;ok=False
    for _ in range(5):
        r=subprocess.run(['python3','extract2.py',sp,str(gs)],capture_output=True,text=True,timeout=900)
        print(sp,gs,r.stdout.strip().splitlines()[-1:] ,r.stderr.strip()[-300:],flush=True)
        if r.returncode==3: gs*=1.25;continue
        ok=r.returncode==0;break
    if not ok: print('FAIL',sp,flush=True);continue
    import numpy as np
    dd=np.load(f'{sp}_mesh.npz');kit=str(dd['kit']);JJ=dd['J'];bip=all(JJ[i][1]>-5 for i in (3,6,9,12,15,16))
    if bip: r=subprocess.run(['python3','skin2.py',sp],capture_output=True,text=True)
    elif kit=='slime': r=subprocess.run(['python3','skin2.py',sp],capture_output=True,text=True)
    else: r=subprocess.run(['python3','skin3.py',sp],capture_output=True,text=True)
    print(r.stdout.strip()[-200:],r.stderr.strip()[-300:],flush=True)
    subprocess.run(['gzip','-9f',f'../mon_{sp}.bin'])
    os.remove(f'{sp}_mesh.npz')
    print('DONE',sp,kit,os.path.getsize(f'../mon_{sp}.bin.gz'),flush=True)
