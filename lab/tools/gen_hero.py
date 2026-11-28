# 勇者6職（11/28 本人が2D案を選んだ：約4頭身、職業ごとにシルエットを変える）。形の式は使わず、ここで全部作る。
# 11/28 夕 本人「方向性は合ってる、ディテールだけ」→ 革の縫い目・ベルトと金具・ひも・小物入れ・くつの底と折り返し・よろいの板の重なり・びょう・布のしわ・髪の房を足した
# 材質：15未満は骨について動く（2 肌、3 腰の革すそ、4 ズボン、5 くつ、6 上そで、7 前腕・手ぶくろ、8 巻いた布、9 よろい・腕当て、10 くつ底、11 くつの折り返し、12 ひざ当て、13 手足の金具・ひも）
#       15以上は胴か頭にかたく付く（16 胴の服、17 胴の飾り、18 金具・金のふち、19 ベルト・革ひも、20 肩、21 マント・すそ、22 帽子・かぶと、23 帽子の飾り、24 髪、25 羽、26 口元の布、27 ひげ、28 びょう・ボタン、29 小物入れ、30 矢・石）
# 色はすべて xcol で付ける（XMIN=1.5 で材質2以上を xcol に回す）
COMMON = '''const float XK=0.02;
vec2 U(vec2 a,vec2 b){return b.x<a.x?b:a;}
float hbx(vec3 p,vec3 b){vec3 q=abs(p)-b;return length(max(q,0.0))+min(max(q.x,max(q.y,q.z)),0.0);}
float band(vec3 q,float rx,float rz,float hy){return max(sEll(q,vec3(rx,4.0,rz)),abs(q.y)-hy);}
vec2 headN(vec3 p){vec3 H=J[2];vec3 h=p-H;vec3 e=vec3(abs(h.x),h.y,h.z);
 float hd=sEll(h-vec3(0.0,0.01,0.0),vec3(0.185,0.2,0.18));hd=smin(hd,sEll(h-vec3(0.0,-0.085,0.035),vec3(0.14,0.115,0.135)),0.07);
 hd=smin(hd,sEll(e-vec3(0.18,-0.01,-0.01),vec3(0.028,0.05,0.035)),0.02);
 hd=smin(hd,sEll(h-vec3(0.0,-0.04,0.17),vec3(0.02,0.022,0.02)),0.03);
 hd=smin(hd,sTap(p,J[1]+vec3(0.0,0.05,-0.01),H+vec3(0.0,-0.15,-0.04),0.065,0.06),0.04);
 return vec2(hd,2.0);}
vec2 armsN(vec3 p,float ra,float rf,float mU,float mF,float mH){vec2 r=vec2(1e3,1.0);
 for(int s=0;s<2;s++){vec3 a=s==0?J[3]:J[6],b=s==0?J[4]:J[7],c=s==0?J[5]:J[8];vec3 d=normalize(c-b);
  r=U(r,vec2(smin(sTap(p,a,b,ra,ra*0.85),sEll(p-mix(a,b,0.4),vec3(ra*1.08,0.1,ra*1.05)),0.03),mU));r=U(r,vec2(smin(sTap(p,b,mix(b,c,0.85),ra*0.85,rf),sEll(p-mix(b,c,0.25),vec3(ra*0.95,0.08,ra*0.92)),0.03),mF));
  float hn=sEll(p-c-d*0.03,vec3(0.052,0.062,0.046));hn=smin(hn,sEll(p-c-d*0.075+vec3(0.0,0.0,-0.012),vec3(0.048,0.035,0.05)),0.02);hn=smin(hn,sTap(p,c+d*0.02+vec3(0.0,0.0,0.04),c+d*0.06+vec3(0.0,0.0,0.055),0.016,0.014),0.012);r=U(r,vec2(hn,mH));}
 return r;}
vec2 legsN(vec3 p,float rt,float mP){vec2 r=vec2(1e3,1.0);
 for(int s=0;s<2;s++){vec3 a=s==0?J[9]:J[12],b=s==0?J[10]:J[13],c=s==0?J[11]:J[14];
  float lg=smin(sTap(p,a,b,rt,rt*0.75),sTap(p,b,c,rt*0.72,rt*0.55),0.03);lg=smin(lg,sEll(p-mix(a,b,0.35),vec3(rt*1.06,0.12,rt*1.04)),0.04);lg=smin(lg,sEll(p-mix(b,c,0.3)-vec3(0.0,0.0,-0.025),vec3(rt*0.68,0.1,rt*0.68)),0.04);r=U(r,vec2(lg,mP));}
 return r;}
vec2 bootsN(vec3 p,float rt,float bh,float mB,float mS,float mC,float cuff,float toe){vec2 r=vec2(1e3,1.0);
 for(int s=0;s<2;s++){vec3 c=s==0?J[11]:J[14];vec3 ft=vec3(c.x,0.0,c.z);
  float bt=smin(sTap(p,vec3(c.x,bh,c.z),vec3(c.x,0.07,c.z),rt*0.6+0.004,rt*0.56),sEll(p-ft-vec3(0.0,0.055,0.06+0.02*toe),vec3(0.066,0.05,0.12+0.03*toe)),0.04);r=U(r,vec2(bt,mB));
  float so=max(sEll(p-ft-vec3(0.0,0.03,0.06+0.02*toe),vec3(0.074,0.05,0.13+0.03*toe)),abs(p.y-0.022)-0.022);r=U(r,vec2(so,mS));r=U(r,vec2(max(sEll(p-ft-vec3(0.0,0.03,-0.07),vec3(0.06,0.05,0.05)),abs(p.y-0.045)-0.045),mS));
  if(cuff>0.5){float cf=sTap(p,vec3(c.x,bh-0.015,c.z),vec3(c.x,bh+0.04,c.z),rt*0.66+0.018,rt*0.7+0.022);r=U(r,vec2(cf,mC));}
  else{float st=band(p-vec3(c.x,bh-0.08,c.z),rt*0.6+0.016,rt*0.6+0.016,0.012);r=U(r,vec2(st,mC));r=U(r,vec2(hbx(p-vec3(c.x,bh-0.08,c.z+rt*0.6+0.012),vec3(0.018,0.016,0.006)),13.0));}}
 return r;}
float pouch(vec3 p,vec3 c,vec3 s){float b=hbx(p-c,s)-0.012;b=min(b,hbx(p-c-vec3(0.0,s.y*0.6,s.z*0.25),vec3(s.x*1.04,s.y*0.45,s.z*0.85))-0.01);return b;}
'''

def job(name, body, cols, comment):
    src = '// ' + comment + '\n' + COMMON + 'vec2 hero(vec3 p){vec3 H=J[2];vec3 h=p-H;vec3 e=vec3(abs(h.x),h.y,h.z);vec2 r=headN(p);\n' + body + '\n return r;}\n'
    src += 'vec2 xmod(vec2 b,vec3 p){return hero(p);}\nvec2 xbody(vec3 p){return vec2(1e3,1.0);}\n'
    src += 'float seam(float x,float w){return 1.0-smoothstep(0.0,w,abs(x));}\n'
    src += 'vec4 xcol(vec3 p,vec3 n,float m){float sh=smoothstep(-0.4,0.9,n.y);\n'
    for m, c in sorted(cols.items(), reverse=True):
        src += ' if(m>%.1f){%s}\n' % (m - 0.5, c)
    src += ' return vec4(1.0);}\n'
    open('xtra/%s.glsl' % name, 'w').write(src)

def flat(r, g, b, gl=0.3, tex=0.15, fs=10.0, extra=''):
    return 'vec3 c=vec3(%.3f,%.3f,%.3f)*(0.74+0.34*sh)*(1.0-%.2f+%.2f*2.0*fbm(p*%.1f));%sreturn vec4(pow(c,vec3(2.2)),%.2f);' % (r, g, b, tex, tex, fs, extra, gl)
def metal(r, g, b, extra=''):
    return 'vec3 c=vec3(%.3f,%.3f,%.3f)*(0.5+0.62*sh)+vec3(0.28)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);c*=0.92+0.12*fbm(p*25.0);%sreturn vec4(pow(c,vec3(2.2)),0.9);' % (r, g, b, extra)
SKIN = flat(0.96, 0.78, 0.64, 0.2, 0.04)
def LEATHER(r, g, b, f=9.0):   # 革：横の縫い目
    return flat(r, g, b, 0.35, 0.22, 14.0, 'c*=1.0-0.35*seam(fract(p.y*%.1f)-0.5,0.03)*step(0.4,fract(p.x*18.0+p.z*18.0));' % f)

# ---------- 戦士 ----------
job('warrior', r'''
 r=U(r,armsN(p,0.088,0.072,2.0,2.0,2.0));
 for(int s=0;s<2;s++){vec3 a=s==0?J[3]:J[6],b=s==0?J[4]:J[7],c=s==0?J[5]:J[8];vec3 d=normalize(c-b);r=U(r,vec2(sTap(p,mix(b,c,0.4),mix(b,c,0.92),0.079,0.073),7.0));
  for(int k=0;k<2;k++){vec3 q=mix(b,c,0.52+0.26*float(k));r=U(r,vec2(sTap(p,q-d*0.012,q+d*0.012,0.086,0.086),13.0));}   // 革のこてと2本の革ひも
  r=U(r,vec2(sTap(p,mix(a,b,0.55),mix(a,b,0.62),0.098,0.096),8.0));}   // 二の腕に巻いた布
 r=U(r,legsN(p,0.112,4.0));r=U(r,bootsN(p,0.112,0.34,5.0,10.0,11.0,1.0,0.0));
 for(int s=0;s<2;s++){vec3 k=s==0?J[10]:J[13];r=U(r,vec2(sEll(p-k-vec3(0.0,0.0,0.06),vec3(0.075,0.08,0.045)),12.0));}   // 革のひざ当て
 float ch=sEll(p-J[1]-vec3(0.0,-0.06,0.0),vec3(0.29,0.24,0.19));ch=smin(ch,sEll(p-J[0]-vec3(0.0,0.1,0.0),vec3(0.22,0.16,0.16)),0.1);
 ch=smin(ch,sEll(p-J[1]-vec3(0.0,-0.02,0.12),vec3(0.24,0.16,0.09)),0.05);ch+=0.003*sin(p.y*70.0);r=U(r,vec2(ch,16.0));   // 広い胸の革の胴
 {float xs=min(sTap(p,J[1]+vec3(-0.22,0.07,0.17),J[0]+vec3(0.16,0.1,0.18),0.022,0.022),sTap(p,J[1]+vec3(-0.22,0.07,-0.17),J[0]+vec3(0.16,0.1,-0.16),0.022,0.022));r=U(r,vec2(xs,19.0));
  r=U(r,vec2(length(p-J[1]-vec3(-0.05,-0.08,0.23))-0.03,18.0));}   // ななめの負いひもと胸の金の輪
 for(int k=0;k<6;k++){float a=-1.1+0.44*float(k);vec3 q=J[1]+vec3(0.26*sin(a),-0.22,0.17*cos(a)+0.02);r=U(r,vec2(length(p-q)-0.016,28.0));}   // びょう
 {vec3 q=p-J[0]-vec3(0.0,-0.06,0.0);float an=atan(q.x,q.z);float sk=max(sEll(q,vec3(0.25,0.2,0.2)),q.y-0.08);sk=max(sk,-(q.y+0.21+0.035*abs(sin(an*5.0))));sk=max(sk,-hbx(q-vec3(0.0,-0.2,0.2),vec3(0.02,0.11,0.06)));r=U(r,vec2(sk,3.0));}   // 腰のすそ（革の板）
 r=U(r,vec2(band(p-J[0]-vec3(0.0,0.03,0.0),0.235,0.18,0.035),19.0));r=U(r,vec2(hbx(p-J[0]-vec3(0.0,0.03,0.18),vec3(0.05,0.045,0.016))-0.008,18.0));r=U(r,vec2(hbx(p-J[0]-vec3(0.0,0.03,0.195),vec3(0.025,0.02,0.01)),19.0));   // ベルトと金のバックル
 r=U(r,vec2(pouch(p,J[0]+vec3(0.17,-0.03,0.11),vec3(0.05,0.055,0.03)),29.0));r=U(r,vec2(pouch(p,J[0]+vec3(-0.2,-0.02,0.02),vec3(0.03,0.05,0.045)),29.0));   // 小物入れ
 for(int s=0;s<2;s++){vec3 sh=s==0?J[3]:J[6];float sg=s==0?-1.0:1.0;vec3 q=p-sh-vec3(0.0,0.05,0.0);float fr=sEll(q,vec3(0.155,0.105,0.145))+0.009*sin(q.x*80.0+q.z*40.0)*sin(q.z*70.0-q.y*50.0);fr=smin(fr,sEll(q-vec3(0.03*sg,-0.06,0.0),vec3(0.13,0.07,0.12))+0.008*sin(q.x*90.0)*sin(q.z*90.0),0.03);r=U(r,vec2(fr,20.0));
  r=U(r,vec2(band(q-vec3(0.0,-0.03,0.0),0.15,0.14,0.012),19.0));}   // 毛皮の肩（二重）と革ひも
 {float hr=max(sEll(h-vec3(0.0,0.05,-0.02),vec3(0.195,0.19,0.195)),-max(h.y-0.06,-h.z-0.02));hr=max(hr,-(h.y+0.06));
  for(int k=0;k<6;k++){float fk=float(k);float a=-1.1+0.44*fk;float ln=0.7+0.3*sin(fk*2.3+1.0);vec3 t0=vec3(0.15*sin(a),0.13+0.02*cos(fk*1.7),0.13*cos(a)-0.02);hr=smin(hr,sTap(h,t0,t0+vec3(0.05*sin(a),0.075,-0.1)*ln,0.055,0.012),0.045);}hr+=0.004*sin(h.x*70.0)*sin(h.z*50.0);r=U(r,vec2(hr,24.0));}   // 立った短い髪
 {float hb=max(abs(length(h.xz)-0.197)-0.013,abs(h.y-0.075)-0.035);r=U(r,vec2(hb,23.0));r=U(r,vec2(sEll(h-vec3(-0.1,0.07,-0.17),vec3(0.035,0.035,0.025)),23.0));
  r=U(r,vec2(sTap(p,H+vec3(-0.11,0.07,-0.17),H+vec3(-0.24,-0.06,-0.3),0.03,0.012),23.0));r=U(r,vec2(sTap(p,H+vec3(-0.1,0.07,-0.18),H+vec3(-0.15,-0.1,-0.31),0.028,0.01),23.0));}   // 赤いはちまき（結び目）
 r=U(r,vec2(sTap(p,H+vec3(0.09,0.03,0.165),H+vec3(0.06,-0.05,0.175),0.007,0.007),17.0));   // ほおの傷
''', {2: SKIN, 3: LEATHER(0.5, 0.32, 0.2), 4: flat(0.36, 0.26, 0.19, 0.2, 0.2, 18.0), 5: flat(0.32, 0.21, 0.13, 0.35), 7: LEATHER(0.47, 0.31, 0.18, 14.0), 8: flat(0.72, 0.64, 0.5, 0.15, 0.2),
      10: flat(0.15, 0.11, 0.09, 0.2), 11: flat(0.8, 0.7, 0.55, 0.1, 0.3, 30.0), 12: LEATHER(0.4, 0.26, 0.16), 13: flat(0.24, 0.15, 0.1, 0.4),
      16: LEATHER(0.56, 0.36, 0.22, 7.0), 17: flat(0.85, 0.6, 0.5, 0.2, 0.0), 18: metal(0.95, 0.75, 0.3), 19: flat(0.24, 0.15, 0.1, 0.45), 20: flat(0.84, 0.74, 0.58, 0.1, 0.35, 30.0),
      23: flat(0.82, 0.12, 0.14, 0.3, 0.1), 24: flat(0.42, 0.25, 0.14, 0.3, 0.25, 40.0), 28: metal(0.7, 0.7, 0.72), 29: LEATHER(0.38, 0.24, 0.14)},
    '戦士（11/28 2D案＋ディテール）：革の胴（縫い目・負いひも・びょう）・板の腰すそ・毛皮の肩（二重）・こての革ひも・立った髪・赤いはちまき・ほおの傷')

# ---------- 騎士 ----------
job('knight', r'''
 r=U(r,armsN(p,0.08,0.07,9.0,9.0,9.0));
 for(int s=0;s<2;s++){vec3 a=s==0?J[3]:J[6],b=s==0?J[4]:J[7],c=s==0?J[5]:J[8];vec3 d=normalize(c-b);
  r=U(r,vec2(sEll(p-b-vec3(0.0,0.0,-0.01),vec3(0.075,0.072,0.075)),13.0));r=U(r,vec2(sTap(p,b+vec3(0.0,0.0,-0.06),b+vec3(0.0,0.03,-0.1),0.035,0.01),13.0));   // ひじ当て
  for(int k=0;k<3;k++){vec3 q=mix(a,b,0.25+0.25*float(k));r=U(r,vec2(sTap(p,q,q+normalize(b-a)*0.05,0.088-0.004*float(k),0.083-0.004*float(k)),9.0));}   // 二の腕の板
  r=U(r,vec2(sTap(p,mix(b,c,0.55),mix(b,c,0.92),0.075,0.09),9.0));r=U(r,vec2(sTap(p,mix(b,c,0.88),mix(b,c,0.93),0.094,0.095),13.0));
  r=U(r,vec2(sEll(p-c-d*0.03,vec3(0.058,0.066,0.052)),9.0));}
 r=U(r,legsN(p,0.105,9.0));r=U(r,bootsN(p,0.105,0.3,9.0,10.0,13.0,0.0,1.0));
 for(int s=0;s<2;s++){vec3 a=s==0?J[9]:J[12],k=s==0?J[10]:J[13];r=U(r,vec2(sEll(p-k-vec3(0.0,0.0,0.05),vec3(0.075,0.075,0.06)),13.0));r=U(r,vec2(sEll(p-k-vec3(0.0,0.0,0.105),vec3(0.03,0.03,0.015)),12.0));
  for(int q=0;q<3;q++){vec3 c=mix(a,k,0.3+0.22*float(q));r=U(r,vec2(sTap(p,c,c+normalize(k-a)*0.05,0.114-0.006*float(q),0.108-0.006*float(q)),9.0));}}   // ひざ当てと太ももの板
 float ch=sEll(p-J[1]-vec3(0.0,-0.05,0.0),vec3(0.27,0.23,0.19));ch=smin(ch,sEll(p-J[1]-vec3(0.0,-0.04,0.08),vec3(0.24,0.19,0.14)),0.04);r=U(r,vec2(ch,16.0));
 r=U(r,vec2(max(sEll(p-J[1]-vec3(0.0,-0.04,0.08),vec3(0.245,0.195,0.145)),abs(p.x)-0.012),17.0));
 for(int k=0;k<4;k++){float y=J[0].y+0.2-0.065*float(k);vec3 q=p-vec3(0.0,y,0.0);r=U(r,vec2(max(sEll(q,vec3(0.23-0.005*float(k),0.06,0.18-0.004*float(k))),abs(q.y)-0.03)-0.003,16.0));}   // 腹の板
 {vec3 q=p-J[0];float zf=0.17+0.1*smoothstep(0.0,-0.4,q.y)+0.08*smoothstep(0.1,0.35,q.y);float wd=0.15-0.03*smoothstep(0.0,0.35,q.y);vec3 qq=vec3(q.x,q.y+0.02,q.z-zf);float tb=max(hbx(qq,vec3(wd,0.4,0.018))-0.006,-(q.y+0.46-0.5*abs(q.x)));r=U(r,vec2(tb,21.0));
  float fr=max(hbx(qq-vec3(0.0,0.0,0.012),vec3(wd+0.006,0.41,0.01)),-hbx(qq-vec3(0.0,0.0,0.012),vec3(wd-0.022,0.37,0.03)));fr=max(fr,-(q.y+0.45-0.5*abs(q.x)));r=U(r,vec2(fr,18.0));   // 前垂れの金のふち
  r=U(r,vec2(hbx(vec3(q.x,q.y-0.05,q.z-zf-0.02),vec3(0.02,0.16,0.008)),18.0));r=U(r,vec2(hbx(vec3(q.x,q.y-0.11,q.z-zf-0.02),vec3(0.085,0.02,0.008)),18.0));}   // 金の十字
 r=U(r,vec2(band(p-J[0],0.215,0.175,0.03),19.0));r=U(r,vec2(hbx(p-J[0]-vec3(0.0,0.0,0.18),vec3(0.04,0.035,0.012))-0.006,18.0));   // 剣帯
 {vec3 q=p-J[0]-vec3(0.0,-0.05,0.0);float sk=max(sEll(q,vec3(0.24,0.17,0.2)),q.y-0.05);sk=max(sk,-(q.y+0.17));r=U(r,vec2(sk,16.0));}
 {vec3 q=p-J[1]-vec3(0.0,0.1,-0.02);float gg=max(sEll(q,vec3(0.15,0.09,0.14)),-sEll(q-vec3(0.0,0.06,0.0),vec3(0.1,0.08,0.1)));r=U(r,vec2(gg,17.0));}   // のど当て
 for(int s=0;s<2;s++){vec3 sh=s==0?J[3]:J[6];float sg=s==0?-1.0:1.0;vec3 q=p-sh-vec3(-0.01*sg,0.04,0.0);float pd=max(sEll(q,vec3(0.14,0.11,0.13)),-(q.y+0.06));r=U(r,vec2(pd,20.0));
  for(int k=0;k<2;k++){float y=-0.05-0.045*float(k);r=U(r,vec2(max(sEll(q-vec3(0.01*sg,y,0.0),vec3(0.15+0.01*float(k),0.09,0.14+0.01*float(k))),abs(q.y-y)-0.014)-0.002,20.0));}
  r=U(r,vec2(max(sEll(q,vec3(0.145,0.115,0.135)),abs(q.x+0.04*sg)-0.01),18.0));
  for(int k=0;k<3;k++){vec3 t=sh+vec3(-0.02*sg,0.12,-0.08+0.08*float(k));r=U(r,vec2(length(p-t)-0.013,28.0));}}   // 三段の肩当て・金のふち・びょう
 {vec3 q=p-J[1]-vec3(0.0,0.05,-0.09);float t=clamp(-q.y/1.0,0.0,1.0);float rad=0.24+0.12*t;float rr=length(q.xz*vec2(1.0,1.3));float an=atan(q.x,-q.z);
  float cp=max(abs(rr-rad)-0.02,max(q.y,-(q.y+1.0)));cp=max(cp,abs(an)-1.0-0.25*t);cp+=0.006*sin(an*10.0)*t;r=U(r,vec2(cp,21.0));}   // 背中の青いマント
 {float hm=sEll(h-vec3(0.0,0.03,0.0),vec3(0.215,0.235,0.215));hm=smin(hm,sEll(h-vec3(0.0,-0.08,0.04),vec3(0.17,0.15,0.18)),0.06);float vs=hbx(h-vec3(0.0,0.0,0.2),vec3(0.13,0.016,0.05));hm=max(hm,-vs);
  for(int k=0;k<5;k++){hm=max(hm,-hbx(h-vec3(-0.06+0.03*float(k),-0.09,0.21),vec3(0.006,0.03,0.04)));}r=U(r,vec2(hm,22.0));
  r=U(r,vec2(max(sEll(h-vec3(0.0,0.03,0.0),vec3(0.222,0.242,0.222)),abs(h.x)-0.016),17.0));
  r=U(r,vec2(max(sEll(h-vec3(0.0,0.03,0.0),vec3(0.222,0.242,0.222)),abs(h.y-0.035)-0.012),18.0));   // ひさしの金のふち
  for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;r=U(r,vec2(length(h-vec3(0.19*sg,-0.02,0.07))-0.022,18.0));}   // 留め金
  r=U(r,vec2(hbx(h-vec3(0.0,0.0,0.19),vec3(0.12,0.012,0.03)),26.0));
  float pl=sTap(p,H+vec3(0.0,0.24,0.0),H+vec3(0.0,0.42,-0.12),0.03,0.06);pl=smin(pl,sTap(p,H+vec3(0.0,0.42,-0.12),H+vec3(0.0,0.3,-0.36),0.06,0.015),0.05);pl+=0.006*sin(p.z*120.0);r=U(r,vec2(pl,25.0));
  r=U(r,vec2(sTap(p,H+vec3(0.0,0.2,0.0),H+vec3(0.0,0.26,-0.01),0.035,0.03),18.0));}   // 青い羽かざりと金の台
''', {9: metal(0.74, 0.77, 0.83), 10: flat(0.2, 0.2, 0.22, 0.3), 12: metal(0.95, 0.78, 0.32), 13: metal(0.86, 0.88, 0.93), 16: metal(0.78, 0.81, 0.87), 17: metal(0.95, 0.96, 1.0), 18: metal(0.95, 0.78, 0.32),
      19: flat(0.3, 0.2, 0.13, 0.4), 20: metal(0.82, 0.85, 0.9),
      21: flat(0.16, 0.32, 0.72, 0.3, 0.12), 22: metal(0.78, 0.81, 0.87), 25: flat(0.18, 0.4, 0.9, 0.2, 0.2, 30.0), 26: flat(0.04, 0.04, 0.06, 0.1, 0.0), 28: metal(0.95, 0.78, 0.32)},
    '騎士（11/28 2D案＋ディテール）：全身よろい（腹・腕・太ももの板の重なり、とがったひじ当て、三段の肩当てとびょう、のど当て）・青い羽のかぶと（金のふちと留め金）・青い前垂れ（金のふちと十字）・背中の青いマント')

# ---------- 盗賊 ----------
job('thief', r'''
 r=U(r,armsN(p,0.066,0.056,6.0,7.0,7.0));
 for(int s=0;s<2;s++){vec3 b=s==0?J[4]:J[7],c=s==0?J[5]:J[8];vec3 d=normalize(c-b);vec3 ax=normalize(d+vec3(0.0,0.25,0.0));for(int k=0;k<5;k++){vec3 a=mix(b,c,0.18+0.14*float(k));r=U(r,vec2(sTap(p,a,a+ax*0.022,0.068,0.068),8.0));}}   // 前腕に巻いた布
 r=U(r,legsN(p,0.086,4.0));r=U(r,bootsN(p,0.086,0.42,5.0,10.0,11.0,0.0,0.0));
 for(int s=0;s<2;s++){vec3 a=s==0?J[9]:J[12],k=s==0?J[10]:J[13];float sg=s==0?-1.0:1.0;
  r=U(r,vec2(pouch(p,mix(a,k,0.35)+vec3(0.085*sg,0.0,0.0),vec3(0.025,0.045,0.035)),13.0));r=U(r,vec2(band(p-mix(a,k,0.35),0.1,0.095,0.012),13.0));}   // 太ももの小物入れ
 float ch=sEll(p-J[1]-vec3(0.0,-0.07,0.0),vec3(0.22,0.22,0.16));ch=smin(ch,sEll(p-J[0]-vec3(0.0,0.1,0.0),vec3(0.16,0.15,0.13)),0.1);ch+=0.004*sin(p.x*40.0+p.y*60.0);r=U(r,vec2(ch,16.0));
 {vec3 q=p-J[1];float vs=max(sEll(q-vec3(0.0,-0.08,0.0),vec3(0.228,0.21,0.168)),-(q.z-0.12));vs=max(vs,-(abs(q.x)-0.04+0.15*(q.y+0.3)));r=U(r,vec2(vs,17.0));}   // 革の胸当て
 for(int k=0;k<3;k++){r=U(r,vec2(length(p-J[1]-vec3(0.07,-0.04-0.08*float(k),0.155))-0.012,28.0));}
 {float bs=sTap(p,J[1]+vec3(0.2,0.08,0.13),J[0]+vec3(-0.17,0.12,0.15),0.02,0.02);bs=min(bs,sTap(p,J[1]+vec3(0.2,0.08,-0.13),J[0]+vec3(-0.17,0.12,-0.14),0.02,0.02));r=U(r,vec2(bs,19.0));
  for(int k=0;k<3;k++){vec3 a=mix(J[1]+vec3(0.2,0.08,0.15),J[0]+vec3(-0.17,0.12,0.17),0.25+0.2*float(k));r=U(r,vec2(hbx(p-a-vec3(0.0,0.0,0.015),vec3(0.018,0.045,0.012))-0.004,29.0));r=U(r,vec2(sTap(p,a+vec3(0.0,0.04,0.02),a+vec3(0.0,0.08,0.02),0.01,0.008),18.0));}}   // ななめの負いひもと投げナイフ
 r=U(r,vec2(band(p-J[0]-vec3(0.0,0.04,0.0),0.175,0.145,0.03),19.0));r=U(r,vec2(hbx(p-J[0]-vec3(0.0,0.04,0.145),vec3(0.03,0.028,0.01))-0.005,18.0));
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;r=U(r,vec2(pouch(p,J[0]+vec3(0.11*sg,-0.02,0.12),vec3(0.04,0.045,0.025)),29.0));}
 {vec3 q=p-J[1]-vec3(0.0,0.08,-0.06);float t=clamp(-q.y/0.55,0.0,1.0);float rad=0.24+0.12*t;float rr=length(q.xz*vec2(1.0,1.2));float an=atan(q.x,-q.z);
  float cp=max(abs(rr-rad)-0.02,max(q.y,-(q.y+0.55-0.12*abs(sin(an*3.0)))));cp=max(cp,abs(an)-1.7);cp+=0.008*sin(an*9.0)*t;r=U(r,vec2(cp,21.0));}   // 短いマント
 {float hd=sEll(h-vec3(0.0,0.03,-0.02),vec3(0.215,0.24,0.22));hd=max(hd,-sEll(h-vec3(0.0,-0.02,0.12),vec3(0.17,0.19,0.16)));hd=max(hd,-(h.y+0.26));hd=smin(hd,sTap(p,H+vec3(0.0,0.2,-0.1),H+vec3(0.0,0.08,-0.34),0.06,0.015),0.05);
  hd=smin(hd,sEll(p-J[1]-vec3(0.0,0.08,0.0),vec3(0.21,0.07,0.17)),0.06);hd+=0.005*sin(atan(h.x,h.z)*12.0)*smoothstep(0.0,0.2,-h.y);r=U(r,vec2(hd,22.0));
  r=U(r,vec2(max(abs(sEll(h-vec3(0.0,-0.02,0.12),vec3(0.17,0.19,0.16)))-0.012,sEll(h-vec3(0.0,0.03,-0.02),vec3(0.222,0.247,0.227))),23.0));}   // フードとふちの縫い取り
 {float mk=max(sEll(h-vec3(0.0,-0.08,0.035),vec3(0.152,0.13,0.15)),-(-0.012-h.y+0.04*abs(h.x)));mk=max(mk,-sEll(h-vec3(0.0,-0.08,0.035),vec3(0.13,0.11,0.128)));mk+=0.003*sin(h.y*90.0);r=U(r,vec2(mk,26.0));
  r=U(r,vec2(sEll(h-vec3(-0.1,-0.06,-0.12),vec3(0.035,0.03,0.03)),26.0));r=U(r,vec2(sTap(p,H+vec3(-0.1,-0.06,-0.13),H+vec3(-0.17,-0.2,-0.22),0.025,0.01),26.0));}   // 鼻まで隠す布とうしろの結び目
''', {2: SKIN, 4: flat(0.2, 0.17, 0.25, 0.2, 0.2, 18.0), 5: flat(0.18, 0.13, 0.15, 0.3), 6: flat(0.28, 0.22, 0.34), 7: flat(0.22, 0.17, 0.27), 8: flat(0.55, 0.48, 0.42, 0.2, 0.25, 20.0),
      10: flat(0.1, 0.08, 0.08, 0.2), 11: flat(0.32, 0.22, 0.14, 0.4), 13: LEATHER(0.4, 0.27, 0.15),
      16: flat(0.3, 0.24, 0.38, 0.3, 0.15), 17: LEATHER(0.32, 0.22, 0.16), 18: metal(0.82, 0.84, 0.88), 19: flat(0.42, 0.28, 0.16, 0.4), 21: flat(0.36, 0.16, 0.44, 0.3, 0.12), 22: flat(0.38, 0.17, 0.46, 0.25, 0.12),
      23: flat(0.75, 0.62, 0.35, 0.3, 0.1), 26: flat(0.22, 0.17, 0.27, 0.25, 0.18, 30.0), 28: metal(0.8, 0.7, 0.4), 29: LEATHER(0.4, 0.27, 0.15)},
    '盗賊（11/28 2D案＋ディテール）：紫のフード（ふちの縫い取り）・鼻まで隠す布（うしろで結ぶ）・革の胸当て・ななめの負いひもに投げナイフ・小物入れ（腰と太もも）・前腕に巻いた布・短いマント')

# ---------- 狩人 ----------
job('hunter', r'''
 r=U(r,armsN(p,0.072,0.06,6.0,7.0,7.0));
 for(int s=0;s<2;s++){vec3 b=s==0?J[4]:J[7],c=s==0?J[5]:J[8];vec3 d=normalize(c-b);r=U(r,vec2(sTap(p,mix(b,c,0.35),mix(b,c,0.9),0.072,0.078),9.0));for(int k=0;k<3;k++){vec3 q=mix(b,c,0.45+0.18*float(k));r=U(r,vec2(sTap(p,q,q+d*0.01,0.082,0.082),13.0));}}   // 革の腕当て
 r=U(r,legsN(p,0.095,4.0));r=U(r,bootsN(p,0.095,0.42,5.0,10.0,11.0,1.0,0.0));
 for(int s=0;s<2;s++){vec3 k=s==0?J[10]:J[13];r=U(r,vec2(sEll(p-k-vec3(0.0,0.0,0.05),vec3(0.07,0.07,0.04)),12.0));}   // ひざのつぎあて
 float ch=sEll(p-J[1]-vec3(0.0,-0.06,0.0),vec3(0.25,0.23,0.17));ch=smin(ch,sEll(p-J[0]-vec3(0.0,0.08,0.0),vec3(0.19,0.17,0.15)),0.1);r=U(r,vec2(ch,16.0));
 {vec3 q=p-J[1];float vs=max(sEll(q-vec3(0.0,-0.1,0.0),vec3(0.258,0.21,0.178)),-(q.z-0.06));vs=max(vs,-(abs(q.x)-0.035));r=U(r,vec2(vs,17.0));
  for(int k=0;k<4;k++){float y=-0.02-0.06*float(k);for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;r=U(r,vec2(length(p-J[1]-vec3(0.045*sg,y,0.165))-0.009,28.0));}r=U(r,vec2(sTap(p,J[1]+vec3(-0.045,y,0.168),J[1]+vec3(0.045,y-0.03,0.168),0.005,0.005),19.0));}}   // 革のベスト（前をひもで結ぶ）
 {vec3 q=p-J[0]-vec3(0.0,-0.04,0.0);float sk=max(sEll(q,vec3(0.22,0.24,0.19)),q.y-0.06);sk=max(sk,-(q.y+0.24));sk=max(sk,-hbx(q-vec3(0.0,-0.2,0.2),vec3(0.03,0.12,0.06)));sk+=0.005*sin(atan(q.x,q.z)*8.0)*smoothstep(0.0,-0.2,q.y);r=U(r,vec2(sk,16.0));}   // 腰までの上着
 r=U(r,vec2(band(p-J[0]-vec3(0.0,0.06,0.0),0.205,0.165,0.03),19.0));r=U(r,vec2(hbx(p-J[0]-vec3(0.0,0.06,0.168),vec3(0.03,0.028,0.01))-0.005,28.0));
 r=U(r,vec2(pouch(p,J[0]+vec3(-0.15,0.0,0.12),vec3(0.045,0.05,0.03)),29.0));r=U(r,vec2(sTap(p,J[0]+vec3(0.18,0.03,0.08),J[0]+vec3(0.2,-0.15,0.12),0.025,0.02),29.0));   // 小物入れと腰の小刀
 r=U(r,vec2(sTap(p,J[3]+vec3(0.05,0.08,0.12),J[0]+vec3(0.18,0.05,0.12),0.02,0.02),19.0));
 {vec3 a=J[1]+vec3(0.14,0.12,-0.2),b=J[0]+vec3(-0.06,0.08,-0.24);vec3 ax=normalize(a-b);r=U(r,vec2(sTap(p,a,b,0.075,0.065),29.0));for(int k=0;k<2;k++){vec3 q=mix(b,a,0.25+0.5*float(k));r=U(r,vec2(sTap(p,q,q+ax*0.02,0.082,0.08),18.0));}
  for(int k=0;k<5;k++){vec3 t=a+vec3(-0.04+0.02*float(k),0.0,-0.02+0.012*float(k));r=U(r,vec2(sTap(p,t,t+ax*0.12,0.007,0.007),30.0));r=U(r,vec2(sEll(p-t-ax*0.14,vec3(0.022,0.04,0.008)),25.0));}}   // 背中の矢筒と矢
 {vec3 q=p-J[1]-vec3(0.0,0.1,-0.04);float t=clamp(-q.y/0.95,0.0,1.0);float rad=0.25+0.16*t;float rr=length(q.xz*vec2(1.0,1.2));float an=atan(q.x,-q.z);
  float cp=max(abs(rr-rad)-0.02,max(q.y,-(q.y+0.95-0.04*abs(sin(an*4.0)))));cp=max(cp,abs(an)-1.25-0.3*t);cp=max(cp,-sTap(p,J[1]+vec3(0.14,0.12,-0.2),J[0]+vec3(-0.06,0.08,-0.24),0.1,0.09));cp+=0.008*sin(an*11.0)*t;r=U(r,vec2(cp,21.0));
  float hd=sEll(p-J[1]-vec3(0.0,0.12,-0.16),vec3(0.2,0.1,0.11));hd=max(hd,-sEll(p-J[1]-vec3(0.0,0.16,-0.1),vec3(0.17,0.09,0.1)));r=U(r,vec2(hd,21.0));
  r=U(r,vec2(max(sEll(p-J[1]-vec3(0.0,0.08,-0.01),vec3(0.24,0.07,0.2)),-(p.y-J[1].y-0.05)),21.0));r=U(r,vec2(length(p-J[1]-vec3(0.0,0.09,0.19))-0.028,18.0));}   // マント・うしろのフード・えりの留め具
 {vec3 q=h-vec3(0.0,0.17,-0.02);q.yz=vec2(q.y*0.985-q.z*0.17,q.y*0.17+q.z*0.985);float ht=sEll(q,vec3(0.205,0.1,0.25));ht=max(ht,-q.y-0.02);ht=smin(ht,sEll(q,vec3(0.22,0.03,0.27)),0.02);ht=smin(ht,sTap(q,vec3(0.0,0.06,-0.05),vec3(0.0,0.02,0.26),0.06,0.01),0.04);ht+=0.004*sin(q.x*50.0);r=U(r,vec2(ht,22.0));
  r=U(r,vec2(max(sEll(q,vec3(0.212,0.105,0.258)),abs(q.y-0.015)-0.018),23.0));
  float fe=sTap(p,H+vec3(0.15,0.2,-0.03),H+vec3(0.22,0.48,-0.24),0.03,0.008);fe=smin(fe,sTap(p,H+vec3(0.15,0.2,-0.03),H+vec3(0.2,0.42,-0.27),0.02,0.004),0.02);fe+=0.004*sin(p.y*150.0);r=U(r,vec2(fe,25.0));}   // 帽子と赤い羽
 {float hr=max(sEll(h-vec3(0.0,0.02,-0.03),vec3(0.198,0.2,0.198)),-max(h.y,-h.z-0.02));hr=max(hr,-(h.y+0.1));for(int k=0;k<6;k++){float a=(k<3?1.35:-1.35)+(k<3?1.0:-1.0)*0.45*float(k<3?k:k-3);vec3 t0=vec3(0.18*sin(a),0.02,0.18*cos(a)-0.03);hr=smin(hr,sTap(h,t0,t0+vec3(0.02*sin(a),-0.11,-0.02),0.035,0.01),0.03);}r=U(r,vec2(hr,24.0));}   // 髪
''', {2: SKIN, 4: flat(0.42, 0.33, 0.2, 0.2, 0.2, 18.0), 5: flat(0.38, 0.24, 0.13, 0.35), 6: flat(0.26, 0.45, 0.22), 7: flat(0.4, 0.28, 0.16, 0.3), 9: LEATHER(0.42, 0.28, 0.16, 14.0),
      10: flat(0.15, 0.11, 0.09, 0.2), 11: flat(0.45, 0.3, 0.17, 0.35), 12: flat(0.36, 0.3, 0.2, 0.2, 0.25), 13: flat(0.24, 0.15, 0.1, 0.4),
      16: flat(0.27, 0.48, 0.24, 0.25, 0.15), 17: LEATHER(0.45, 0.3, 0.17), 18: metal(0.72, 0.6, 0.38), 19: flat(0.36, 0.22, 0.12, 0.35, 0.2), 21: flat(0.16, 0.32, 0.17, 0.3, 0.15), 22: flat(0.25, 0.45, 0.22, 0.25, 0.1),
      23: flat(0.4, 0.26, 0.13, 0.3), 24: flat(0.55, 0.33, 0.15, 0.3, 0.2, 40.0), 25: flat(0.85, 0.14, 0.12, 0.2, 0.15, 40.0), 28: metal(0.72, 0.6, 0.38), 29: LEATHER(0.38, 0.24, 0.13), 30: flat(0.6, 0.45, 0.28, 0.3)},
    '狩人（11/28 2D案＋ディテール）：羽つき帽子・革のベスト（前をひもで結ぶ）・腕当て・ひざのつぎあて・腰の小刀と小物入れ・背中の矢筒（矢5本）・ひざまでのマントとうしろのフード')

# ---------- 魔法使い ----------
job('mage', r'''
 r=U(r,armsN(p,0.068,0.058,6.0,6.0,2.0));
 for(int s=0;s<2;s++){vec3 b=s==0?J[4]:J[7],c=s==0?J[5]:J[8];vec3 d=normalize(c-b);r=U(r,vec2(sTap(p,mix(b,c,0.35),c-d*0.02,0.07,0.115)+0.004*sin(dot(p,d)*80.0),6.0));r=U(r,vec2(sTap(p,c-d*0.05,c-d*0.02,0.116,0.119),7.0));}   // 広がるそでと金のそで口
 r=U(r,legsN(p,0.085,4.0));r=U(r,bootsN(p,0.085,0.3,5.0,10.0,11.0,0.0,1.0));
 float ch=sEll(p-J[1]-vec3(0.0,-0.06,0.0),vec3(0.23,0.23,0.17));r=U(r,vec2(ch,16.0));
 {vec3 q=p-J[0];float t=clamp((J[1].y-p.y)/J[1].y,0.0,1.0);float rr=length(q.xz*vec2(1.0,1.15));float an=atan(q.x,q.z);
  float ro=max(rr-(0.2+0.2*t*t)-0.014*sin(an*7.0)*t,max(p.y-J[1].y,0.03-p.y));ro=smin(ro,ch,0.08);r=U(r,vec2(ro,16.0));}   // すそまで広がるローブ
 {vec3 q=p-J[1]-vec3(0.0,0.06,-0.04);float cl=max(abs(sEll(q,vec3(0.24,0.2,0.22)))-0.016,max(-q.y-0.02,q.y-0.16));cl=max(cl,-(q.z-0.06+0.6*q.y));r=U(r,vec2(cl,21.0));}   // 立てたえり
 r=U(r,vec2(band(p-J[0]-vec3(0.0,0.1,0.0),0.2,0.175,0.03),18.0));
 for(int k=0;k<2;k++){float x=-0.04+0.08*float(k);r=U(r,vec2(sTap(p,J[0]+vec3(x,0.08,0.18),J[0]+vec3(x+0.02,-0.18,0.2),0.012,0.012),23.0));r=U(r,vec2(sEll(p-J[0]-vec3(x+0.02,-0.2,0.2),vec3(0.022,0.035,0.022)),23.0));}   // 帯のふさ
 r=U(r,vec2(sTap(p,J[0]+vec3(-0.17,0.06,0.1),J[0]+vec3(-0.19,-0.12,0.13),0.03,0.03),29.0));r=U(r,vec2(sTap(p,J[0]+vec3(-0.19,-0.13,0.13),J[0]+vec3(-0.19,-0.1,0.13),0.034,0.034),18.0));   // 腰の巻物
 {vec3 q=p-J[1]-vec3(0.0,0.0,0.17);float mo=max(abs(length(q.xy)-0.035)-0.008,abs(q.z-0.02)-0.01);mo=max(mo,-(length(q.xy-vec2(0.02,0.01))-0.03));r=U(r,vec2(mo,18.0));}   // 胸の月飾り
 {float bd=sEll(h-vec3(0.0,-0.17,0.12),vec3(0.13,0.13,0.08));bd=smin(bd,sTap(p,H+vec3(0.0,-0.2,0.15),H+vec3(0.0,-0.42,0.17),0.09,0.02),0.06);bd=max(bd,-(h.y+0.04-0.08*abs(h.x)));bd=max(bd,-sEll(h-vec3(0.0,-0.1,0.2),vec3(0.05,0.022,0.04)));bd+=0.005*sin(h.x*90.0);
  float ms=sTap(e,vec3(0.02,-0.06,0.19),vec3(0.13,-0.11,0.15),0.025,0.012);r=U(r,vec2(min(bd,ms),27.0));r=U(r,vec2(sTap(p,H+vec3(0.0,-0.36,0.17),H+vec3(0.0,-0.39,0.17),0.03,0.028),23.0));}   // 白いひげと金の輪
 {float eb=sTap(e,vec3(0.035,0.055,0.17),vec3(0.11,0.06,0.15),0.018,0.012);r=U(r,vec2(eb,27.0));}
 {vec3 q=h-vec3(0.0,0.2,-0.01);float lq=length(q.xz);float br=max(lq-0.44,abs(q.y+0.12*lq*lq)-0.014)-0.004;br+=0.006*sin(atan(q.x,q.z)*6.0)*smoothstep(0.25,0.44,lq);
  float tt=clamp(q.y/0.55,0.0,1.0);float cn=length(q.xz-vec2(0.0,-0.16*tt*tt))-0.2*(1.0-tt)-0.012+0.008*sin(q.y*30.0)*tt;cn=max(cn,max(-q.y,q.y-0.6));
  r=U(r,vec2(min(br,cn),22.0));r=U(r,vec2(max(lq-0.21,abs(q.y-0.04)-0.035),23.0));r=U(r,vec2(hbx(q-vec3(0.0,0.04,0.205),vec3(0.035,0.035,0.012))-0.006,18.0));   // 帽子（波うつつば・しわ）・金の帯と留め金
  for(int k=0;k<3;k++){float y=0.18+0.11*float(k);float tk=clamp(y/0.55,0.0,1.0);float a=float(k)*2.1+0.4;vec3 sp=vec3(0.0,y,-0.16*tk*tk)+vec3(sin(a),0.0,cos(a))*(0.2*(1.0-tk)+0.012);r=U(r,vec2(length(q-sp)-0.018,23.0));}}   // 帽子の星
 {float hr=max(sEll(h-vec3(0.0,0.0,-0.04),vec3(0.2,0.2,0.2)),-max(h.y+0.03,-h.z-0.02));hr=max(hr,h.y-0.16);for(int k=0;k<4;k++){float a=1.2+0.35*float(k);for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;vec3 t0=vec3(0.18*sin(a)*sg,0.05,0.18*cos(a));hr=smin(hr,sTap(h,t0,t0+vec3(0.02*sg,-0.16,-0.02),0.035,0.012),0.03);}}r=U(r,vec2(hr,27.0));}   // 白い髪（長くたれる）
''', {2: SKIN, 4: flat(0.2, 0.18, 0.3), 5: flat(0.3, 0.2, 0.14, 0.35), 6: flat(0.2, 0.22, 0.52, 0.25, 0.12), 7: metal(0.95, 0.75, 0.3), 10: flat(0.12, 0.1, 0.1, 0.2), 11: metal(0.95, 0.75, 0.3), 13: metal(0.95, 0.75, 0.3),
      16: 'float tr=step(abs(p.x),0.03)*step(p.y,J[1].y-0.05)+step(p.y,0.1);float st=step(0.82,fbm(p*vec3(26.0)));vec3 c=mix(vec3(0.2,0.22,0.54),vec3(0.9,0.72,0.28),max(tr,st))*(0.74+0.34*sh)*(0.9+0.2*fbm(p*8.0));return vec4(pow(c,vec3(2.2)),0.3);',
      18: metal(0.95, 0.75, 0.3), 21: flat(0.16, 0.17, 0.44, 0.25, 0.12), 22: flat(0.17, 0.18, 0.46, 0.25, 0.12), 23: metal(0.95, 0.75, 0.3), 27: flat(0.93, 0.93, 0.95, 0.2, 0.08, 40.0), 29: flat(0.88, 0.8, 0.62, 0.2, 0.15)},
    '魔法使い（11/28 2D案＋ディテール）：つばの広いとんがり帽子（波うつつば・星・留め金）・立てたえり・すそまで広がる青いローブ（金のふちと星の模様）・金の帯とふさ・腰の巻物・胸の月飾り・長い白ひげと白い髪')

# ---------- 僧侶 ----------
job('priest', r'''
 r=U(r,armsN(p,0.068,0.058,6.0,6.0,2.0));
 for(int s=0;s<2;s++){vec3 b=s==0?J[4]:J[7],c=s==0?J[5]:J[8];vec3 d=normalize(c-b);r=U(r,vec2(sTap(p,mix(b,c,0.35),c-d*0.03,0.068,0.09)+0.004*sin(dot(p,d)*80.0),6.0));r=U(r,vec2(sTap(p,c-d*0.07,c-d*0.045,0.092,0.093),7.0));}   // そでと金のそで口
 r=U(r,legsN(p,0.085,4.0));r=U(r,bootsN(p,0.085,0.24,5.0,10.0,11.0,0.0,0.0));
 float ch=sEll(p-J[1]-vec3(0.0,-0.06,0.0),vec3(0.23,0.23,0.17));r=U(r,vec2(ch,16.0));
 {vec3 q=p-J[0];float t=clamp((J[1].y-p.y)/J[1].y,0.0,1.0);float rr=length(q.xz*vec2(1.0,1.15));float an=atan(q.x,q.z);
  float ro=max(rr-(0.2+0.17*t*t)-0.01*sin(an*8.0)*t,max(p.y-J[1].y,0.03-p.y));ro=smin(ro,ch,0.08);r=U(r,vec2(ro,16.0));}   // 白い法衣
 {vec3 q=p-J[1];float sl=max(hbx(q-vec3(0.0,-0.5,0.19+0.2*max(0.0,-q.y-0.4)),vec3(0.065,0.6,0.02)),q.y-0.05);sl=max(sl,-(p.y-0.05));r=U(r,vec2(sl-0.004,18.0));
  for(int k=0;k<5;k++){float y=-0.3-0.17*float(k);vec3 c=vec3(0.0,y,0.215+0.2*max(0.0,-y-0.4));r=U(r,vec2(max(abs(length((q-c).xy)-0.03)-0.006,abs(q.z-c.z)-0.012),28.0));}}   // 金のストールと輪の模様
 {vec3 q=p-J[1]-vec3(0.0,-0.18,0.215);float cr=min(hbx(q,vec3(0.014,0.07,0.014)),hbx(q-vec3(0.0,0.025,0.0),vec3(0.05,0.014,0.014)));r=U(r,vec2(cr-0.004,17.0));
  r=U(r,vec2(sTap(p,J[1]+vec3(-0.12,0.1,0.12),J[1]+vec3(0.0,-0.1,0.21),0.006,0.006),18.0));r=U(r,vec2(sTap(p,J[1]+vec3(0.12,0.1,0.12),J[1]+vec3(0.0,-0.1,0.21),0.006,0.006),18.0));}   // 白い十字と金の鎖
 {vec3 q=p-J[1];float cp=max(abs(sEll(q,vec3(0.27,0.17,0.21)))-0.016,-(q.y+0.06));cp=max(cp,q.y-0.12);cp+=0.004*sin(atan(q.x,q.z)*14.0);r=U(r,vec2(cp,21.0));
  r=U(r,vec2(max(abs(sEll(q,vec3(0.272,0.172,0.212)))-0.018,abs(q.y+0.055)-0.012),18.0));}   // 肩かけと金のふち
 {vec3 q=p-J[0]-vec3(0.0,0.08,0.0);float rp=band(q,0.21,0.18,0.018);rp+=0.004*sin(atan(q.x,q.z)*30.0);r=U(r,vec2(rp,19.0));
  r=U(r,vec2(sTap(p,J[0]+vec3(0.12,0.07,0.15),J[0]+vec3(0.14,-0.22,0.18),0.012,0.01),19.0));r=U(r,vec2(sEll(p-J[0]-vec3(0.14,-0.25,0.18),vec3(0.022,0.04,0.022)),19.0));}   // なわの帯とふさ
 {float hd=sEll(h-vec3(0.0,0.03,-0.02),vec3(0.215,0.24,0.22));hd=max(hd,-sEll(h-vec3(0.0,-0.03,0.14),vec3(0.165,0.2,0.16)));hd=max(hd,-(h.y+0.22));hd+=0.004*sin(atan(h.x,h.z)*10.0)*smoothstep(0.0,0.2,-h.y);
  hd=smin(hd,sEll(p-J[1]-vec3(0.0,0.06,-0.02),vec3(0.25,0.08,0.2)),0.07);r=U(r,vec2(hd,22.0));
  r=U(r,vec2(max(sEll(h-vec3(0.0,0.03,-0.02),vec3(0.222,0.247,0.227)),abs(h.y-0.1)-0.02),23.0));r=U(r,vec2(max(abs(sEll(h-vec3(0.0,-0.03,0.14),vec3(0.165,0.2,0.16)))-0.012,sEll(h-vec3(0.0,0.03,-0.02),vec3(0.224,0.249,0.229))),23.0));
  r=U(r,vec2(sEll(h-vec3(0.0,0.1,0.215),vec3(0.03,0.03,0.012)),30.0));}   // 白い頭巾・金の帯とふち・額の青い石
 {float hr=sEll(h-vec3(0.0,0.08,0.07),vec3(0.17,0.09,0.15));hr=max(hr,-(h.y-0.01));for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;hr=smin(hr,sTap(p,H+vec3(0.12*sg,0.04,0.1),H+vec3(0.14*sg,-0.14,0.1),0.04,0.025),0.03);hr=smin(hr,sTap(p,H+vec3(0.06*sg,0.06,0.15),H+vec3(0.1*sg,-0.02,0.17),0.03,0.012),0.02);}hr+=0.003*sin(h.x*80.0);r=U(r,vec2(hr,24.0));}   // 金髪
''', {2: SKIN, 4: flat(0.85, 0.82, 0.74), 5: flat(0.5, 0.36, 0.22, 0.3), 6: flat(0.95, 0.93, 0.87, 0.2, 0.06), 7: metal(0.95, 0.78, 0.32), 10: flat(0.3, 0.22, 0.15, 0.2), 11: metal(0.95, 0.78, 0.32), 13: metal(0.95, 0.78, 0.32),
      16: 'float tr=step(p.y,0.1);vec3 c=mix(vec3(0.95,0.93,0.87),vec3(0.92,0.74,0.3),tr)*(0.76+0.32*sh);return vec4(pow(c,vec3(2.2)),0.2);',
      17: flat(1.0, 1.0, 0.98, 0.3, 0.0), 18: metal(0.95, 0.78, 0.32), 19: flat(0.78, 0.66, 0.44, 0.3, 0.25, 30.0), 21: flat(0.97, 0.95, 0.9, 0.2, 0.05), 22: flat(0.96, 0.94, 0.89, 0.2, 0.06), 23: metal(0.95, 0.78, 0.32),
      24: flat(0.95, 0.8, 0.42, 0.35, 0.2, 40.0), 28: metal(0.98, 0.85, 0.45), 30: metal(0.3, 0.6, 1.0)},
    '僧侶（11/28 2D案＋ディテール）：白い法衣（しわ）・肩かけと金のふち・前に下がる金のストール（輪の模様）・首から下げた十字と鎖・なわの帯とふさ・白い頭巾（金の帯とふち・額の青い石）・金髪')
print('ok')
