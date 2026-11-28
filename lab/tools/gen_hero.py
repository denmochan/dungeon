# 勇者6職（11/28 本人が2D案を選んだ：約4頭身、職業ごとにシルエットを変える）。形の式は使わず、ここで全部作る。
# 材質：15未満は骨について動く（2 肌、4 ズボン、5 くつ、6 上そで、7 前腕・手ぶくろ、8 手、9 よろいの手足）
#       15以上は胴か頭にかたく付く（16 胴の服、17 胴の飾り、18 金のふち、19 ベルト、20 肩、21 マント・すそ、22 帽子・かぶと、23 帽子の飾り、24 髪、25 羽、26 口元の布、27 ひげ）
# 色はすべて xcol で付ける（XMIN=1.5 で材質2以上を xcol に回す）
import os
COMMON = '''const float XK=0.02;
vec2 U(vec2 a,vec2 b){return b.x<a.x?b:a;}
float hbx(vec3 p,vec3 b){vec3 q=abs(p)-b;return length(max(q,0.0))+min(max(q.x,max(q.y,q.z)),0.0);}
vec2 headN(vec3 p){vec3 H=J[2];vec3 h=p-H;vec3 e=vec3(abs(h.x),h.y,h.z);
 float hd=sEll(h-vec3(0.0,0.01,0.0),vec3(0.185,0.2,0.18));hd=smin(hd,sEll(h-vec3(0.0,-0.085,0.035),vec3(0.14,0.115,0.135)),0.07);   // 丸い頭と、ふっくらしたあご
 hd=smin(hd,sEll(e-vec3(0.18,-0.01,-0.01),vec3(0.028,0.05,0.035)),0.02);   // 耳
 hd=smin(hd,sEll(h-vec3(0.0,-0.035,0.18),vec3(0.024,0.03,0.024)),0.02);   // 小さな鼻
 hd=smin(hd,sTap(p,J[1]+vec3(0.0,0.05,-0.01),H+vec3(0.0,-0.15,-0.04),0.065,0.06),0.04);   // 首
 return vec2(hd,2.0);}
vec2 armsN(vec3 p,float ra,float rf,float mU,float mF,float mH){vec2 r=vec2(1e3,1.0);
 for(int s=0;s<2;s++){vec3 a=s==0?J[3]:J[6],b=s==0?J[4]:J[7],c=s==0?J[5]:J[8];
  r=U(r,vec2(sTap(p,a,b,ra,ra*0.85),mU));r=U(r,vec2(sTap(p,b,mix(b,c,0.85),ra*0.85,rf),mF));
  vec3 d=normalize(c-b);r=U(r,vec2(smin(sEll(p-c-d*0.03,vec3(0.05,0.06,0.045)),sTap(p,c+d*0.04,c+d*0.1,0.035,0.028),0.02),mH));}   // 手（にぎりこぶし）
 return r;}
vec2 legsN(vec3 p,float rt,float mP,float mB,float bh){vec2 r=vec2(1e3,1.0);
 for(int s=0;s<2;s++){vec3 a=s==0?J[9]:J[12],b=s==0?J[10]:J[13],c=s==0?J[11]:J[14];
  float lg=smin(sTap(p,a,b,rt,rt*0.75),sTap(p,b,c,rt*0.72,rt*0.55),0.03);lg=smin(lg,sEll(p-mix(b,c,0.3)-vec3(0.0,0.0,-0.025),vec3(rt*0.68,0.1,rt*0.68)),0.04);r=U(r,vec2(lg,mP));   // 太もも・ふくらはぎ
  vec3 ft=vec3(c.x,0.0,c.z);float bt=smin(sTap(p,vec3(c.x,bh,c.z),vec3(c.x,0.06,c.z),rt*0.62,rt*0.62),sEll(p-ft-vec3(0.0,0.05,0.07),vec3(0.07,0.055,0.13)),0.04);r=U(r,vec2(bt,mB));}   // 長ぐつ
 return r;}
'''

def job(name, body, cols, comment):
    src = '// ' + comment + '\n' + COMMON + 'vec2 hero(vec3 p){vec3 H=J[2];vec3 h=p-H;vec3 e=vec3(abs(h.x),h.y,h.z);vec2 r=headN(p);\n' + body + '\n return r;}\n'
    src += 'vec2 xmod(vec2 b,vec3 p){return hero(p);}\nvec2 xbody(vec3 p){return vec2(1e3,1.0);}\n'
    src += 'vec4 xcol(vec3 p,vec3 n,float m){float sh=smoothstep(-0.4,0.9,n.y);\n'
    for m, c in sorted(cols.items(), reverse=True):
        src += ' if(m>%.1f){%s}\n' % (m - 0.5, c)
    src += ' return vec4(1.0);}\n'
    open('xtra/%s.glsl' % name, 'w').write(src)

def flat(r, g, b, gl=0.3, tex=0.15, fs=10.0):
    return 'vec3 c=vec3(%.3f,%.3f,%.3f)*(0.78+0.3*sh)*(1.0-%.2f+%.2f*2.0*fbm(p*%.1f));return vec4(pow(c,vec3(2.2)),%.2f);' % (r, g, b, tex, tex, fs, gl)
def metal(r, g, b):
    return 'vec3 c=vec3(%.3f,%.3f,%.3f)*(0.55+0.6*sh)+vec3(0.25)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);return vec4(pow(c,vec3(2.2)),0.9);' % (r, g, b)
SKIN = flat(0.96, 0.78, 0.64, 0.2, 0.04)

# ---------- 戦士：がっしり・革の胴・毛皮の肩・赤いはちまき・太い素の腕 ----------
job('warrior', r'''
 r=U(r,armsN(p,0.085,0.07,2.0,2.0,2.0));   // 太い素の腕
 for(int s=0;s<2;s++){vec3 b=s==0?J[4]:J[7],c=s==0?J[5]:J[8];r=U(r,vec2(sTap(p,mix(b,c,0.45),mix(b,c,0.92),0.078,0.072),7.0));}   // 革のこて
 r=U(r,legsN(p,0.11,4.0,5.0,0.34));
 float ch=sEll(p-J[1]-vec3(0.0,-0.06,0.0),vec3(0.29,0.24,0.19));ch=smin(ch,sEll(p-J[0]-vec3(0.0,0.1,0.0),vec3(0.22,0.16,0.16)),0.1);r=U(r,vec2(ch,16.0));   // 広い胸の革の胴
 {vec3 q=p-J[0]-vec3(0.0,-0.06,0.0);float sk=max(sEll(q,vec3(0.25,0.2,0.2)),q.y-0.08);sk=max(sk,-(q.y+0.2+0.03*sin(atan(q.x,q.z)*9.0)));r=U(r,vec2(sk,3.0));}   // 腰のすそ（ぎざぎざ）
 r=U(r,vec2(max(sEll(p-J[0]-vec3(0.0,0.03,0.0),vec3(0.235,0.06,0.18)),abs(p.y-J[0].y-0.03)-0.035),19.0));r=U(r,vec2(hbx(p-J[0]-vec3(0.0,0.03,0.18),vec3(0.045,0.04,0.015))-0.008,18.0));   // ベルトと金のバックル
 for(int s=0;s<2;s++){vec3 sh=s==0?J[3]:J[6];float sg=s==0?-1.0:1.0;r=U(r,vec2(sEll(p-sh-vec3(0.0,0.05,0.0),vec3(0.15,0.1,0.14))+0.006*sin(p.x*90.0)*sin(p.z*90.0),20.0));}   // 毛皮の肩
 {float hr=max(sEll(h-vec3(0.0,0.05,-0.02),vec3(0.195,0.19,0.195)),-max(h.y-0.06,-h.z-0.02));hr=max(hr,-(h.y+0.06));hr+=0.006*sin(h.x*70.0)*sin(h.z*50.0);r=U(r,vec2(hr,24.0));}   // 短い茶色の髪
 {float hb=max(abs(length(h.xz*vec2(1.0,1.0)-vec2(0.0,0.0))-0.195)-0.012,abs(h.y-0.07)-0.035);r=U(r,vec2(hb,23.0));
  r=U(r,vec2(sTap(p,H+vec3(-0.12,0.07,-0.17),H+vec3(-0.22,-0.05,-0.28),0.03,0.012),23.0));r=U(r,vec2(sTap(p,H+vec3(-0.1,0.07,-0.18),H+vec3(-0.14,-0.08,-0.3),0.028,0.01),23.0));}   // 赤いはちまき（うしろでたなびく）
''', {2: SKIN, 3: flat(0.5, 0.32, 0.2, 0.2, 0.25), 4: flat(0.38, 0.27, 0.19), 5: flat(0.3, 0.2, 0.13, 0.3), 7: flat(0.45, 0.3, 0.18, 0.3, 0.2),
      16: flat(0.55, 0.36, 0.22, 0.35, 0.22, 14.0), 18: metal(0.95, 0.75, 0.3), 19: flat(0.24, 0.15, 0.1, 0.4), 20: flat(0.82, 0.72, 0.56, 0.1, 0.3, 30.0),
      23: flat(0.82, 0.12, 0.14, 0.3, 0.1), 24: flat(0.42, 0.25, 0.14, 0.3, 0.25, 40.0)}, '戦士（11/28 2D案）：がっしり・革の胴・毛皮の肩・赤いはちまき・太い素の腕')

# ---------- 騎士：全身よろい・青い羽のかぶと・青い前垂れ ----------
job('knight', r'''
 r=U(r,armsN(p,0.08,0.07,9.0,9.0,9.0));
 for(int s=0;s<2;s++){vec3 b=s==0?J[4]:J[7];r=U(r,vec2(sEll(p-b,vec3(0.07,0.07,0.07)),9.0));vec3 c=s==0?J[5]:J[8];r=U(r,vec2(sTap(p,mix(b,c,0.6),mix(b,c,0.9),0.072,0.085),9.0));}   // ひじ当て・こて
 r=U(r,legsN(p,0.105,9.0,9.0,0.3));
 for(int s=0;s<2;s++){vec3 k=s==0?J[10]:J[13];r=U(r,vec2(sEll(p-k-vec3(0.0,0.0,0.05),vec3(0.07,0.07,0.06)),9.0));}   // ひざ当て
 float ch=sEll(p-J[1]-vec3(0.0,-0.05,0.0),vec3(0.27,0.23,0.19));ch=smin(ch,sEll(p-J[0]-vec3(0.0,0.1,0.0),vec3(0.2,0.16,0.16)),0.1);r=U(r,vec2(ch,16.0));   // 胸よろい
 r=U(r,vec2(max(sEll(p-J[1]-vec3(0.0,-0.05,0.0),vec3(0.275,0.235,0.195)),abs(p.x)-0.012),17.0));   // 胸の稜線
 {vec3 q=p-J[0];float zf=0.17+0.1*smoothstep(0.0,-0.4,q.y)+0.08*smoothstep(0.1,0.35,q.y);float tb=max(hbx(vec3(q.x,q.y+0.02,q.z-zf),vec3(0.15-0.03*smoothstep(0.0,0.35,q.y),0.4,0.018))-0.006,-(q.y+0.46-0.5*abs(q.x)));r=U(r,vec2(tb,21.0));
  r=U(r,vec2(hbx(vec3(q.x,q.y-0.05,q.z-zf-0.02),vec3(0.02,0.16,0.008)),18.0));r=U(r,vec2(hbx(vec3(q.x,q.y-0.11,q.z-zf-0.02),vec3(0.085,0.02,0.008)),18.0));}   // 青い前垂れと金の十字
 {vec3 q=p-J[0]-vec3(0.0,-0.05,0.0);float sk=max(sEll(q,vec3(0.24,0.17,0.2)),q.y-0.05);sk=max(sk,-(q.y+0.17));r=U(r,vec2(sk,16.0));}   // 腰のよろい
 for(int s=0;s<2;s++){vec3 sh=s==0?J[3]:J[6];float sg=s==0?-1.0:1.0;vec3 q=p-sh-vec3(-0.01*sg,0.04,0.0);float pd=max(sEll(q,vec3(0.14,0.11,0.13)),-(q.y+0.06));pd=min(pd,max(sEll(q-vec3(0.0,-0.05,0.0),vec3(0.15,0.1,0.14)),abs(q.y+0.05)-0.012));r=U(r,vec2(pd,20.0));}   // 肩当て（二段）
 {float hm=sEll(h-vec3(0.0,0.03,0.0),vec3(0.215,0.235,0.215));hm=smin(hm,sEll(h-vec3(0.0,-0.08,0.04),vec3(0.17,0.15,0.18)),0.06);float vs=hbx(h-vec3(0.0,0.0,0.2),vec3(0.13,0.016,0.05));hm=max(hm,-vs);
  for(int k=0;k<5;k++){hm=max(hm,-hbx(h-vec3(-0.06+0.03*float(k),-0.09,0.21),vec3(0.006,0.03,0.04)));}r=U(r,vec2(hm,22.0));   // かぶと（目の細いすき間・口の息穴）
  r=U(r,vec2(max(sEll(h-vec3(0.0,0.03,0.0),vec3(0.22,0.24,0.22)),abs(h.x)-0.014),17.0));   // かぶとの稜線
  r=U(r,vec2(hbx(h-vec3(0.0,0.0,0.19),vec3(0.12,0.012,0.03)),26.0));   // すき間の奥（黒）
  float pl=sTap(p,H+vec3(0.0,0.24,0.0),H+vec3(0.0,0.42,-0.12),0.03,0.06);pl=smin(pl,sTap(p,H+vec3(0.0,0.42,-0.12),H+vec3(0.0,0.3,-0.36),0.06,0.015),0.05);r=U(r,vec2(pl,25.0));}   // 青い羽かざり
''', {9: metal(0.74, 0.77, 0.83), 16: metal(0.78, 0.81, 0.87), 17: metal(0.95, 0.96, 1.0), 18: metal(0.95, 0.78, 0.32), 20: metal(0.82, 0.85, 0.9),
      21: flat(0.16, 0.32, 0.72, 0.3, 0.12), 22: metal(0.78, 0.81, 0.87), 25: flat(0.18, 0.4, 0.9, 0.2, 0.2, 30.0), 26: flat(0.04, 0.04, 0.06, 0.1, 0.0)}, '騎士（11/28 2D案）：全身よろい・青い羽のかぶと・青い前垂れに金の十字')

# ---------- 盗賊：細身・紫のフード・口元の布・短いマント ----------
job('thief', r'''
 r=U(r,armsN(p,0.065,0.055,6.0,7.0,7.0));
 for(int s=0;s<2;s++){vec3 b=s==0?J[4]:J[7],c=s==0?J[5]:J[8];for(int k=0;k<3;k++){vec3 a=mix(b,c,0.25+0.2*float(k));r=U(r,vec2(max(sTap(p,a,a+normalize(c-b)*0.03,0.068,0.068),0.0),8.0));}}   // 前腕に巻いた布
 r=U(r,legsN(p,0.085,4.0,5.0,0.36));
 float ch=sEll(p-J[1]-vec3(0.0,-0.07,0.0),vec3(0.22,0.22,0.16));ch=smin(ch,sEll(p-J[0]-vec3(0.0,0.1,0.0),vec3(0.16,0.15,0.13)),0.1);r=U(r,vec2(ch,16.0));   // 細い胴
 r=U(r,vec2(max(sEll(p-J[0]-vec3(0.0,0.04,0.0),vec3(0.175,0.05,0.145)),abs(p.y-J[0].y-0.04)-0.03),19.0));   // 帯
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;r=U(r,vec2(hbx(p-J[0]-vec3(0.1*sg,-0.03,0.13),vec3(0.05,0.05,0.025))-0.01,19.0));}   // 腰の小物入れ
 {vec3 q=p-J[1]-vec3(0.0,0.08,-0.06);float t=clamp(-q.y/0.55,0.0,1.0);float rad=0.24+0.12*t;float rr=length(q.xz*vec2(1.0,1.2));float an=atan(q.x,-q.z);
  float cp=max(abs(rr-rad)-0.022,max(q.y,-(q.y+0.55-0.12*abs(sin(an*3.0)))));cp=max(cp,abs(an)-1.7);r=U(r,vec2(cp,21.0));}   // 短いマント（すそがぎざぎざ）
 {float hd=sEll(h-vec3(0.0,0.03,-0.02),vec3(0.215,0.24,0.22));hd=max(hd,-sEll(h-vec3(0.0,-0.02,0.12),vec3(0.17,0.19,0.16)));hd=max(hd,-(h.y+0.26));hd=smin(hd,sTap(p,H+vec3(0.0,0.2,-0.1),H+vec3(0.0,0.08,-0.34),0.06,0.015),0.05);
  hd=smin(hd,sEll(p-J[1]-vec3(0.0,0.08,0.0),vec3(0.21,0.07,0.17)),0.06);r=U(r,vec2(hd,22.0));}   // フード（先がうしろへたれる）
 {float mk=max(sEll(h-vec3(0.0,-0.08,0.035),vec3(0.152,0.13,0.15)),-(-0.012-h.y+0.04*abs(h.x)));mk=max(mk,-sEll(h-vec3(0.0,-0.08,0.035),vec3(0.13,0.11,0.128)));r=U(r,vec2(mk,26.0));}   // 口元の布
 ''', {2: SKIN, 4: flat(0.2, 0.17, 0.25), 5: flat(0.16, 0.12, 0.14, 0.3), 6: flat(0.28, 0.22, 0.34), 7: flat(0.22, 0.17, 0.27), 8: flat(0.4, 0.33, 0.28, 0.2, 0.2),
      16: flat(0.3, 0.24, 0.38, 0.3, 0.15), 19: flat(0.45, 0.3, 0.17, 0.4), 21: flat(0.36, 0.16, 0.44, 0.3, 0.12), 22: flat(0.38, 0.17, 0.46, 0.25, 0.12), 24: flat(0.15, 0.12, 0.14, 0.3, 0.2, 40.0),
      26: flat(0.38, 0.17, 0.46, 0.25, 0.12)}, '盗賊（11/28 2D案）：細身・紫のフード（先がたれる）・口元の布・短いマント')

# ---------- 狩人：羽つき帽子・緑の服とマント・矢筒 ----------
job('hunter', r'''
 r=U(r,armsN(p,0.072,0.06,6.0,7.0,7.0));
 r=U(r,legsN(p,0.095,4.0,5.0,0.4));
 for(int s=0;s<2;s++){vec3 c=s==0?J[11]:J[14];r=U(r,vec2(max(sTap(p,vec3(c.x,0.4,c.z),vec3(c.x,0.34,c.z),0.075,0.075),0.0),5.0));}   // 長ぐつの折り返し
 float ch=sEll(p-J[1]-vec3(0.0,-0.06,0.0),vec3(0.25,0.23,0.17));ch=smin(ch,sEll(p-J[0]-vec3(0.0,0.08,0.0),vec3(0.19,0.17,0.15)),0.1);r=U(r,vec2(ch,16.0));
 {vec3 q=p-J[0]-vec3(0.0,-0.04,0.0);float sk=max(sEll(q,vec3(0.22,0.24,0.19)),q.y-0.06);sk=max(sk,-(q.y+0.24));sk=max(sk,-hbx(q-vec3(0.0,-0.2,0.2),vec3(0.03,0.12,0.06)));r=U(r,vec2(sk,16.0));}   // 腰までの上着（前にスリット）
 r=U(r,vec2(max(sEll(p-J[0]-vec3(0.0,0.06,0.0),vec3(0.205,0.05,0.165)),abs(p.y-J[0].y-0.06)-0.03),19.0));
 r=U(r,vec2(sTap(p,J[3]+vec3(0.05,0.08,0.12),J[0]+vec3(0.18,0.05,0.12),0.022,0.022),19.0));   // 矢筒の負いひも
 {vec3 a=J[1]+vec3(0.14,0.12,-0.2),b=J[0]+vec3(-0.06,0.08,-0.24);r=U(r,vec2(sTap(p,a,b,0.075,0.065),19.0));for(int k=0;k<4;k++){vec3 t=a+vec3(-0.03+0.025*float(k),0.0,0.01*float(k));r=U(r,vec2(sTap(p,t,t+normalize(a-b)*0.12,0.008,0.008),18.0));r=U(r,vec2(sEll(p-t-normalize(a-b)*0.14,vec3(0.025,0.035,0.01)),25.0));}}   // 背中の矢筒と矢羽
 {vec3 q=p-J[1]-vec3(0.0,0.1,-0.04);float t=clamp(-q.y/0.95,0.0,1.0);float rad=0.25+0.16*t;float rr=length(q.xz*vec2(1.0,1.2));float an=atan(q.x,-q.z);
  float cp=max(abs(rr-rad)-0.022,max(q.y,-(q.y+0.95)));cp=max(cp,abs(an)-1.25-0.3*t);cp=max(cp,-sTap(p,J[1]+vec3(0.14,0.12,-0.2),J[0]+vec3(-0.06,0.08,-0.24),0.1,0.09));r=U(r,vec2(cp,21.0));
  r=U(r,vec2(max(sEll(p-J[1]-vec3(0.0,0.08,-0.01),vec3(0.24,0.07,0.2)),-(p.y-J[1].y-0.05)),21.0));}   // ひざまでのマント（矢筒の所はあける）と、えり
 {vec3 q=h-vec3(0.0,0.17,-0.02);q.yz=vec2(q.y*0.985-q.z*0.17,q.y*0.17+q.z*0.985);float ht=sEll(q,vec3(0.205,0.1,0.25));ht=max(ht,-q.y-0.02);ht=smin(ht,sEll(q-vec3(0.0,0.0,0.0),vec3(0.22,0.03,0.27)),0.02);ht=smin(ht,sTap(q,vec3(0.0,0.06,-0.05),vec3(0.0,0.02,0.26),0.06,0.01),0.04);r=U(r,vec2(ht,22.0));   // 先のとがった帽子
  r=U(r,vec2(max(sEll(q,vec3(0.212,0.105,0.258)),abs(q.y-0.015)-0.018),23.0));   // 帽子の帯
  float fe=sTap(p,H+vec3(0.15,0.2,-0.03),H+vec3(0.22,0.48,-0.24),0.03,0.008);fe=smin(fe,sTap(p,H+vec3(0.15,0.2,-0.03),H+vec3(0.2,0.42,-0.27),0.02,0.004),0.02);r=U(r,vec2(fe,25.0));}   // 赤い羽
 {float hr=max(sEll(h-vec3(0.0,0.02,-0.03),vec3(0.198,0.2,0.198)),-max(h.y-0.0,-h.z-0.02));hr=max(hr,-(h.y+0.1));r=U(r,vec2(hr,24.0));}   // 髪
''', {2: SKIN, 4: flat(0.42, 0.33, 0.2), 5: flat(0.38, 0.24, 0.13, 0.35), 6: flat(0.26, 0.45, 0.22), 7: flat(0.4, 0.28, 0.16, 0.3),
      16: flat(0.27, 0.48, 0.24, 0.25, 0.15), 18: flat(0.85, 0.8, 0.7, 0.2, 0.0), 19: flat(0.42, 0.26, 0.13, 0.35, 0.2), 21: flat(0.16, 0.32, 0.17, 0.3, 0.15), 22: flat(0.25, 0.45, 0.22, 0.25, 0.1),
      23: flat(0.4, 0.26, 0.13, 0.3), 24: flat(0.55, 0.33, 0.15, 0.3, 0.2, 40.0), 25: flat(0.85, 0.14, 0.12, 0.2, 0.15, 40.0)}, '狩人（11/28 2D案）：羽つき帽子・緑の服とひざまでのマント・背中の矢筒（弓は実行時に持つ）')

# ---------- 魔法使い：大きなとんがり帽子・長いローブ・白ひげ ----------
job('mage', r'''
 r=U(r,armsN(p,0.068,0.058,6.0,6.0,2.0));
 for(int s=0;s<2;s++){vec3 b=s==0?J[4]:J[7],c=s==0?J[5]:J[8];vec3 d=normalize(c-b);r=U(r,vec2(sTap(p,mix(b,c,0.35),c-d*0.02,0.07,0.115),6.0));}   // 広がるそで
 r=U(r,legsN(p,0.085,4.0,5.0,0.3));
 float ch=sEll(p-J[1]-vec3(0.0,-0.06,0.0),vec3(0.23,0.23,0.17));r=U(r,vec2(ch,16.0));
 {vec3 q=p-J[0];float t=clamp((J[1].y-p.y)/J[1].y,0.0,1.0);float rr=length(q.xz*vec2(1.0,1.15));float rb=sEll(p-J[1]-vec3(0.0,-0.06,0.0),vec3(0.23,0.23,0.17));
  float ro=max(rr-(0.2+0.2*t*t)-0.01*sin(atan(q.x,q.z)*7.0)*t,max(p.y-J[1].y,0.03-p.y));ro=smin(ro,rb,0.08);r=U(r,vec2(ro,16.0));}   // すそまで広がるローブ
 r=U(r,vec2(max(sEll(p-J[0]-vec3(0.0,0.1,0.0),vec3(0.2,0.045,0.175)),abs(p.y-J[0].y-0.1)-0.03),18.0));   // 金の帯
 {float bd=sEll(h-vec3(0.0,-0.17,0.12),vec3(0.13,0.13,0.08));bd=smin(bd,sTap(p,H+vec3(0.0,-0.2,0.15),H+vec3(0.0,-0.4,0.16),0.09,0.02),0.06);bd=max(bd,-(h.y+0.04-0.08*abs(h.x)));bd=max(bd,-sEll(h-vec3(0.0,-0.1,0.2),vec3(0.05,0.022,0.04)));
  float ms=sTap(e,vec3(0.02,-0.06,0.19),vec3(0.13,-0.11,0.15),0.025,0.012);r=U(r,vec2(min(bd,ms),27.0));}   // 白いひげと口ひげ
 {float eb=sTap(e,vec3(0.035,0.055,0.17),vec3(0.11,0.06,0.15),0.018,0.012);r=U(r,vec2(eb,27.0));}   // 白い眉
 {vec3 q=h-vec3(0.0,0.2,-0.01);float br=max(length(q.xz)-0.44,abs(q.y+0.015*length(q.xz)*length(q.xz)*8.0)-0.014)-0.004;
  float tt=clamp(q.y/0.55,0.0,1.0);vec3 c=vec3(0.0,0.0,-0.16*tt*tt);float cn=length(q.xz-c.xz)-0.2*(1.0-tt)-0.012;cn=max(cn,max(-q.y,q.y-0.6));
  r=U(r,vec2(min(br,cn),22.0));r=U(r,vec2(max(length(q.xz)-0.21,abs(q.y-0.04)-0.035),23.0));}   // つばの広いとんがり帽子（先がうしろへ折れる）と金の帯
 {float hr=max(sEll(h-vec3(0.0,0.0,-0.04),vec3(0.2,0.2,0.2)),-max(h.y+0.03,-h.z-0.02));hr=max(hr,h.y-0.16);r=U(r,vec2(hr,27.0));}   // 白い髪（帽子の下）
''', {2: SKIN, 4: flat(0.2, 0.18, 0.3), 5: flat(0.25, 0.17, 0.12, 0.3), 6: flat(0.2, 0.22, 0.52, 0.25, 0.12),
      16: 'float tr=step(abs(p.x),0.03)*step(p.y,J[1].y-0.05)+step(p.y,0.1);vec3 c=mix(vec3(0.2,0.22,0.54),vec3(0.9,0.72,0.28),tr)*(0.78+0.3*sh)*(0.9+0.2*fbm(p*8.0));return vec4(pow(c,vec3(2.2)),0.3);',
      18: metal(0.95, 0.75, 0.3), 22: flat(0.17, 0.18, 0.46, 0.25, 0.12), 23: metal(0.95, 0.75, 0.3), 27: flat(0.93, 0.93, 0.95, 0.2, 0.08, 40.0)}, '魔法使い（11/28 2D案）：つばの広いとんがり帽子・すそまで広がる青いローブ（金のふち）・白ひげ')

# ---------- 僧侶：白い法衣に金のふち・頭巾・金髪 ----------
job('priest', r'''
 r=U(r,armsN(p,0.068,0.058,6.0,6.0,2.0));
 for(int s=0;s<2;s++){vec3 b=s==0?J[4]:J[7],c=s==0?J[5]:J[8];vec3 d=normalize(c-b);r=U(r,vec2(sTap(p,mix(b,c,0.35),c-d*0.03,0.068,0.09),6.0));r=U(r,vec2(sTap(p,c-d*0.07,c-d*0.045,0.092,0.093),7.0));}   // 広がるそでと金のそで口
 r=U(r,legsN(p,0.085,4.0,5.0,0.3));
 float ch=sEll(p-J[1]-vec3(0.0,-0.06,0.0),vec3(0.23,0.23,0.17));r=U(r,vec2(ch,16.0));
 {vec3 q=p-J[0];float t=clamp((J[1].y-p.y)/J[1].y,0.0,1.0);float rr=length(q.xz*vec2(1.0,1.15));float rb=sEll(p-J[1]-vec3(0.0,-0.06,0.0),vec3(0.23,0.23,0.17));
  float ro=max(rr-(0.2+0.17*t*t),max(p.y-J[1].y,0.03-p.y));ro=smin(ro,rb,0.08);r=U(r,vec2(ro,16.0));}   // 白い法衣
 {vec3 q=p-J[1];float sl=max(hbx(q-vec3(0.0,-0.5,0.19+0.2*max(0.0,-q.y-0.4)),vec3(0.06,0.6,0.02)),q.y-0.05);sl=max(sl,-(p.y-0.05));r=U(r,vec2(sl-0.004,18.0));}   // 前に下がる金のストール
 {vec3 q=p-J[1]-vec3(0.0,-0.22,0.2);float cr=min(hbx(q,vec3(0.012,0.06,0.02)),hbx(q-vec3(0.0,0.02,0.0),vec3(0.045,0.012,0.02)));r=U(r,vec2(cr-0.004,17.0));}   // 白い十字
 r=U(r,vec2(max(sEll(p-J[0]-vec3(0.0,0.08,0.0),vec3(0.205,0.04,0.175)),abs(p.y-J[0].y-0.08)-0.025),18.0));
 {float hd=sEll(h-vec3(0.0,0.03,-0.02),vec3(0.215,0.24,0.22));hd=max(hd,-sEll(h-vec3(0.0,-0.03,0.14),vec3(0.165,0.2,0.16)));hd=max(hd,-(h.y+0.22));
  hd=smin(hd,sEll(p-J[1]-vec3(0.0,0.06,-0.02),vec3(0.25,0.08,0.2)),0.07);r=U(r,vec2(hd,22.0));
  r=U(r,vec2(max(sEll(h-vec3(0.0,0.03,-0.02),vec3(0.222,0.247,0.227)),abs(h.y-0.1+0.25*h.z*0.0)-0.02),23.0));}   // 白い頭巾と金の帯
 {float hr=sEll(h-vec3(0.0,0.08,0.07),vec3(0.17,0.09,0.15));hr=max(hr,-(h.y-0.01));for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;hr=smin(hr,sTap(p,H+vec3(0.12*sg,0.04,0.1),H+vec3(0.14*sg,-0.14,0.1),0.04,0.025),0.03);}r=U(r,vec2(hr,24.0));}   // 金髪（前髪と横の房）
''', {2: SKIN, 4: flat(0.85, 0.82, 0.74), 5: flat(0.45, 0.32, 0.2, 0.3), 6: flat(0.95, 0.93, 0.87, 0.2, 0.06), 7: metal(0.95, 0.78, 0.32),
      16: 'float tr=step(p.y,0.1);vec3 c=mix(vec3(0.95,0.93,0.87),vec3(0.92,0.74,0.3),tr)*(0.8+0.28*sh);return vec4(pow(c,vec3(2.2)),0.2);',
      17: flat(1.0, 1.0, 0.98, 0.3, 0.0), 18: metal(0.95, 0.78, 0.32), 22: flat(0.96, 0.94, 0.89, 0.2, 0.06), 23: metal(0.95, 0.78, 0.32), 24: flat(0.95, 0.8, 0.42, 0.35, 0.2, 40.0)}, '僧侶（11/28 2D案）：白い法衣に金のふちとストール・白い頭巾・金髪')
print('ok')
