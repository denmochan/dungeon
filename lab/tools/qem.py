# 軽い版（QEM）：形を保ちながら頂点を減らす。色の境目（顔・目・模様）と武器の境目はなるべく残す
# 使い方：python3 qem.py <目標の頂点数> <入力 .bin.gz> <出力 .bin.gz>
# 出力は GB03（位置0.5mm刻みの差分・面の番号は可変長）。読み込みは index.html の loadMon
import gzip, struct, sys, heapq, numpy as np

def read(fn):
    b = gzip.open(fn).read(); mg = b[:4]; NV, NT = struct.unpack('<II', b[4:12]); o = 12
    if mg == b'GB03': raise SystemExit('already GB03')
    P = np.frombuffer(b[o:o+NV*12], np.float32).reshape(-1, 3).astype(np.float64); o += NV*12
    N = np.frombuffer(b[o:o+NV*3], np.int8).reshape(-1, 3).astype(np.float64)/127; o += NV*3
    C = np.frombuffer(b[o:o+NV*3], np.uint8).reshape(-1, 3).astype(np.float64); o += NV*3
    B = np.frombuffer(b[o:o+NV*2], np.uint8).reshape(-1, 2).copy(); o += NV*2
    W = np.frombuffer(b[o:o+NV], np.uint8).copy(); o += NV
    I = np.frombuffer(b[o:o+NT*6], np.uint16).reshape(-1, 3).astype(np.int64).copy(); o += NT*6
    WP = np.frombuffer(b[o:o+NV], np.uint8).copy() if mg == b'GB1W' else np.zeros(NV, np.uint8)
    return mg, P, N, C, B, W, I, WP

def varint(a):
    out = bytearray()
    for v in a.tolist():
        while v >= 128: out.append((v & 127) | 128); v >>= 7
        out.append(v)
    return bytes(out)

def simplify(P, C, I, WP, target, colw=0.004):
    NV = len(P); P = P.copy()
    # 面の平面から誤差の行列（Q）
    v0, v1, v2 = P[I[:, 0]], P[I[:, 1]], P[I[:, 2]]
    fn = np.cross(v1 - v0, v2 - v0); ar = np.linalg.norm(fn, axis=1); fn = fn/(ar[:, None]+1e-12)
    d = -(fn*v0).sum(1); pl = np.concatenate([fn, d[:, None]], 1)
    Kf = pl[:, :, None]*pl[:, None, :]*(ar[:, None, None]+1e-9)
    Q = np.zeros((NV, 4, 4))
    for k in range(3): np.add.at(Q, I[:, k], Kf)
    faces = [list(f) for f in I.tolist()]; alive = [True]*len(faces)
    vf = [set() for _ in range(NV)]
    for fi, f in enumerate(faces):
        for v in f: vf[v].add(fi)
    valive = [True]*NV; ver = [0]*NV
    Cn = C/255.0
    def cost(a, b):
        q = Q[a] + Q[b]; best = None
        for p, keep in ((P[a], a), (P[b], b)):
            h = np.array([p[0], p[1], p[2], 1.0]); e = h @ q @ h
            if best is None or e < best[0]: best = (e, keep)
        e, keep = best
        e += colw*float(((Cn[a]-Cn[b])**2).sum())*float(np.linalg.norm(P[a]-P[b]))   # 色の境目はつぶしにくく
        if WP[a] != WP[b]: e += 1.0   # 武器と体はくっつけない
        return max(e, 0.0), keep
    heap = []
    def push(a, b):
        if a > b: a, b = b, a
        e, keep = cost(a, b); heapq.heappush(heap, (e, a, b, ver[a], ver[b], keep))
    edges = set()
    for f in faces:
        for i in range(3):
            a, b = f[i], f[(i+1) % 3]
            if a > b: a, b = b, a
            edges.add((a, b))
    for a, b in edges: push(a, b)
    nv = NV
    def flips(v, keep, other, newp):
        for fi in vf[v]:
            if not alive[fi]: continue
            f = faces[fi]
            if other in f: continue
            pts = [P[x] if x != v else newp for x in f]
            n0 = np.cross(P[f[1]]-P[f[0]], P[f[2]]-P[f[0]]); n1 = np.cross(pts[1]-pts[0], pts[2]-pts[0])
            if np.dot(n0, n1) <= 1e-12: return True
        return False
    while nv > target and heap:
        e, a, b, va, vb, keep = heapq.heappop(heap)
        if not (valive[a] and valive[b]) or ver[a] != va or ver[b] != vb: continue
        rem = b if keep == a else a
        newp = P[keep]
        if flips(rem, keep, keep, newp): continue
        # リンク条件（共有する近所が2つより多いと穴や重なりができる）
        na = set(x for fi in vf[a] if alive[fi] for x in faces[fi]); nb = set(x for fi in vf[b] if alive[fi] for x in faces[fi])
        if len(na & nb) > 4: continue
        for fi in list(vf[rem]):
            if not alive[fi]: continue
            f = faces[fi]
            if keep in f:
                alive[fi] = False
                for x in f: vf[x].discard(fi)
            else:
                faces[fi] = [keep if x == rem else x for x in f]; vf[keep].add(fi)
        vf[rem] = set(); valive[rem] = False; nv -= 1
        Q[keep] = Q[keep] + Q[rem]; ver[keep] += 1
        nbr = set(x for fi in vf[keep] for x in faces[fi] if x != keep)
        for x in nbr: push(keep, x)
    keepv = np.array([i for i in range(NV) if valive[i]]); remap = -np.ones(NV, np.int64); remap[keepv] = np.arange(len(keepv))
    F = np.array([faces[i] for i in range(len(faces)) if alive[i]], np.int64); F = remap[F]
    F = F[(F[:, 0] >= 0) & (F[:, 0] != F[:, 1]) & (F[:, 1] != F[:, 2]) & (F[:, 0] != F[:, 2])]
    return keepv, F

if __name__ == '__main__':
    target = int(sys.argv[1]); src = sys.argv[2]; dst = sys.argv[3]
    mg, P, N, C, B, W, I, WP = read(src)
    if len(P) <= target: keepv = np.arange(len(P)); F = I
    else: keepv, F = simplify(P, C, I, WP, target)
    P2 = P[keepv]; C2 = C[keepv]; B2 = B[keepv]; W2 = W[keepv]; WP2 = WP[keepv]
    # 法線は新しい面から作り直す
    N2 = np.zeros_like(P2); fn = np.cross(P2[F[:, 1]]-P2[F[:, 0]], P2[F[:, 2]]-P2[F[:, 0]])
    for k in range(3): np.add.at(N2, F[:, k], fn)
    N2 /= np.linalg.norm(N2, axis=1, keepdims=True)+1e-12
    flag = 1 if mg == b'GB02' else (2 if mg == b'GB1W' else 0)
    q = np.round(P2/0.0005).astype(np.int32); qd = np.diff(np.concatenate([np.zeros((1, 3), np.int32), q]), axis=0).astype(np.int16)
    fl = F.flatten(); dd = np.diff(np.concatenate([[0], fl])); zz = ((dd << 1) ^ (dd >> 63)).astype(np.uint64)
    body = b''.join(qd[:, k].tobytes() for k in range(3)) + b''.join(np.clip(np.round(N2[:, k]*127), -127, 127).astype(np.int8).tobytes() for k in range(3)) \
        + b''.join(np.round(C2[:, k]).astype(np.uint8).tobytes() for k in range(3)) + B2[:, 0].tobytes() + B2[:, 1].tobytes() + W2.tobytes() + (WP2.tobytes() if flag == 2 else b'') + varint(zz)
    out = b'GB03' + struct.pack('<IIB', len(P2), len(F), flag) + body
    open(dst, 'wb').write(gzip.compress(out, 9))
    import os; print(os.path.basename(src), len(P), '->', len(P2), 'tris', len(F), 'bytes', os.path.getsize(dst), flush=True)
