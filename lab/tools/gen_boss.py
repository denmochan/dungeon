# 冥王（案B「血の皇帝」）と腐海の主（案A「菌の母胎」）（11/28 本人が2D案から選んだ）。形の式は使わず、ここで全部作る。
# 色はすべて xcol（XMIN=1.5）。材質15未満は骨について動く、15以上は胴・頭にかたく付く
HEAD = '''const float XK=0.02;
vec2 U(vec2 a,vec2 b){return b.x<a.x?b:a;}
float hbx(vec3 p,vec3 b){vec3 q=abs(p)-b;return length(max(q,0.0))+min(max(q.x,max(q.y,q.z)),0.0);}
float band(vec3 q,float rx,float rz,float hy){return max(sEll(q,vec3(rx,4.0,rz)),abs(q.y)-hy);}
float seam(float x,float w){return 1.0-smoothstep(0.0,w,abs(x));}
'''
def flat(r, g, b, gl=0.3, tex=0.15, fs=10.0, extra=''):
    return 'vec3 c=vec3(%.3f,%.3f,%.3f)*(0.74+0.34*sh)*(1.0-%.2f+%.2f*2.0*fbm(p*%.1f));%sreturn vec4(pow(c,vec3(2.2)),%.2f);' % (r, g, b, tex, tex, fs, extra, gl)
def metal(r, g, b):
    return 'vec3 c=vec3(%.3f,%.3f,%.3f)*(0.5+0.62*sh)+vec3(0.28)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);c*=0.92+0.12*fbm(p*25.0);return vec4(pow(c,vec3(2.2)),0.9);' % (r, g, b)
def write(name, comment, body, cols):
    src = '// ' + comment + '\n' + HEAD + 'vec2 boss(vec3 p){vec3 H=J[2];vec3 h=p-H;vec3 e=vec3(abs(h.x),h.y,h.z);vec2 r=vec2(1e3,1.0);\n' + body + '\n return r;}\n'
    src += 'vec2 xmod(vec2 b,vec3 p){return boss(p);}\nvec2 xbody(vec3 p){return vec2(1e3,1.0);}\n'
    src += 'vec4 xcol(vec3 p,vec3 n,float m){float sh=smoothstep(-0.4,0.9,n.y);vec3 h=p-J[2];\n'
    for m, c in sorted(cols.items(), reverse=True):
        src += ' if(m>%.1f){%s}\n' % (m - 0.5, c)
    src += ' return vec4(1.0);}\n'
    open('xtra/%s.glsl' % name, 'w').write(src)

# ---------- 冥王「血の皇帝」：顔の右半分がガイコツの吸血鬼、角の黒い王冠、よろいの肩、床までの法衣とマント ----------
# 2 顔（左は青白い肌・右は骨の色）、4 そで、7 骨の手、9 ひざ下（見えない）、16 法衣、17 胸の板、18 金、19 帯、20 肩よろい、21 マント外、22 マント内（赤）、23 王冠、24 髪、28 赤い玉
write('underlord', '冥王（11/28 本人が2D案B「血の皇帝」を選んだ）：顔の右半分がガイコツの吸血鬼・角の黒い王冠・よろいの肩・赤い玉・床までの法衣・赤い裏地のマント・骨の手', r'''
 {float hd=sEll(h-vec3(0.0,0.01,0.0),vec3(0.17,0.215,0.19));hd=smin(hd,sEll(h-vec3(0.0,-0.1,0.045),vec3(0.12,0.12,0.13)),0.07);
  hd=smin(hd,sEll(h-vec3(0.0,-0.04,0.18),vec3(0.02,0.03,0.022)),0.025);
  hd=max(hd,-sEll(h-vec3(0.075,0.0,0.19),vec3(0.05,0.045,0.05)));   // 右の目のくぼみ（ガイコツ側）
  hd=max(hd,-sEll(h-vec3(0.1,-0.09,0.15),vec3(0.05,0.04,0.06)));   // 右のほおのくぼみ
  hd=smin(hd,sTap(p,J[1]+vec3(0.0,0.05,-0.01),H+vec3(0.0,-0.16,-0.04),0.06,0.055),0.04);r=U(r,vec2(hd,2.0));
  for(int k=0;k<5;k++){vec3 t=vec3(0.03+0.022*float(k),-0.155+0.004*float(k),0.14-0.012*float(k));r=U(r,vec2(hbx(h-t,vec3(0.008,0.02,0.01))-0.003,2.0));}   // 右のむき出しの歯
  r=U(r,vec2(length(h-vec3(0.075,0.0,0.17))-0.016,28.0));   // ガイコツ側の目の奥の赤い光
  r=U(r,vec2(sTap(e,vec3(0.14,0.0,-0.02),vec3(0.27,0.1,-0.08),0.04,0.006),2.0));}   // とがった耳
 {float hr=max(sEll(h-vec3(0.0,0.03,-0.03),vec3(0.185,0.235,0.215)),-max(h.y-0.1+0.4*max(0.0,0.05-abs(h.x)),-0.03-h.z));hr=max(hr,-(h.y+0.22));for(int k=0;k<4;k++){float a=2.2+0.3*float(k);for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;vec3 t0=vec3(0.17*sin(a)*sg,-0.02,0.17*cos(a));hr=smin(hr,sTap(h,t0,t0+vec3(0.03*sg,-0.22,-0.03),0.04,0.012),0.03);}}r=U(r,vec2(hr,24.0));}   // うしろへ流れる黒髪
 {vec3 q=h-vec3(0.0,0.17,-0.01);float cr=max(band(q,0.19,0.2,0.04),-band(q,0.165,0.175,0.06));for(int k=0;k<5;k++){float a=-0.9+0.45*float(k);vec3 b0=vec3(0.18*sin(a),0.03,0.19*cos(a));cr=min(cr,sTap(q,b0,b0+vec3(0.0,0.1+0.08*(1.0-abs(a)),0.0),0.03,0.005));}
  for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;vec3 b0=vec3(0.17*sg,0.04,0.0);cr=min(cr,sTap(q,b0,b0+vec3(0.08*sg,0.1,-0.04),0.035,0.025));cr=min(cr,sTap(q,b0+vec3(0.08*sg,0.1,-0.04),b0+vec3(0.06*sg,0.26,-0.1),0.025,0.004));}r=U(r,vec2(cr,23.0));   // 角の黒い王冠
  r=U(r,vec2(length(q-vec3(0.0,0.06,0.19))-0.028,28.0));}   // 王冠の赤い玉
 for(int s=0;s<2;s++){vec3 a=s==0?J[3]:J[6],b=s==0?J[4]:J[7],c=s==0?J[5]:J[8];vec3 d=normalize(c-b);
  r=U(r,vec2(sTap(p,a,b,0.075,0.065),4.0));r=U(r,vec2(sTap(p,b,c-d*0.03,0.068,0.1),4.0));r=U(r,vec2(sTap(p,c-d*0.06,c-d*0.035,0.102,0.104),18.0-10.0));
  vec3 sd=normalize(cross(d,vec3(0.0,0.0,1.0)));for(int k=0;k<4;k++){vec3 f0=c+d*0.02+sd*(0.03*(float(k)-1.5));r=U(r,vec2(min(sTap(p,f0,f0+d*0.08+vec3(0.0,0.0,0.02),0.013,0.01),sTap(p,f0+d*0.08+vec3(0.0,0.0,0.02),f0+d*0.13+vec3(0.0,0.0,0.05),0.01,0.003)),7.0));}r=U(r,vec2(sEll(p-c,vec3(0.045,0.04,0.035)),7.0));}   // 長いそでと、骨の指
 for(int s=0;s<2;s++){vec3 a=s==0?J[9]:J[12],b=s==0?J[10]:J[13],c=s==0?J[11]:J[14];r=U(r,vec2(min(sTap(p,a,b,0.08,0.065),sTap(p,b,c,0.065,0.05)),9.0));}
 {vec3 q=p-J[0];float t=clamp((J[1].y-p.y)/J[1].y,0.0,1.0);float rr=length(q.xz*vec2(1.0,1.15));float an=atan(q.x,q.z);float ch=sEll(p-J[1]-vec3(0.0,-0.06,0.0),vec3(0.25,0.24,0.18));
  float ro=max(rr-(0.2+0.2*t*t)-0.012*sin(an*7.0)*t,max(p.y-J[1].y,0.02-p.y));ro=smin(ro,ch,0.08);r=U(r,vec2(ro,16.0));}   // 床までの法衣
 {vec3 q=p-J[1]-vec3(0.0,-0.08,0.0);float pl=max(sEll(q,vec3(0.255,0.22,0.19)),-(q.z-0.06));pl=max(pl,abs(q.x)-0.13+0.2*max(0.0,q.y));r=U(r,vec2(pl,17.0));r=U(r,vec2(length(p-J[1]-vec3(0.0,-0.1,0.2))-0.05,28.0));r=U(r,vec2(max(abs(length(p-J[1]-vec3(0.0,-0.1,0.2))-0.058)-0.012,abs(p.z-J[1].z-0.2)-0.025),18.0));}   // 胸の板と、金の台の赤い玉
 r=U(r,vec2(band(p-J[0]-vec3(0.0,0.05,0.0),0.215,0.19,0.035),19.0));r=U(r,vec2(hbx(p-J[0]-vec3(0.0,0.05,0.19),vec3(0.05,0.045,0.012))-0.006,18.0));
 {vec3 q=p-J[0];float sl=max(hbx(q-vec3(0.0,-0.45,0.2+0.18*clamp(-q.y-0.2,0.0,1.0)),vec3(0.07,0.48,0.016))-0.004,-(p.y-0.04));r=U(r,vec2(sl,19.0));r=U(r,vec2(max(hbx(q-vec3(0.0,-0.45,0.215+0.18*clamp(-q.y-0.2,0.0,1.0)),vec3(0.075,0.49,0.01)),-hbx(q-vec3(0.0,-0.45,0.215+0.18*clamp(-q.y-0.2,0.0,1.0)),vec3(0.055,0.47,0.03))),18.0));}   // 前に下がる赤い布と金のふち
 for(int s=0;s<2;s++){vec3 sh=s==0?J[3]:J[6];float sg=s==0?-1.0:1.0;vec3 q=p-sh-vec3(-0.02*sg,0.06,0.0);float pd=max(sEll(q,vec3(0.17,0.13,0.16)),-(q.y+0.07));for(int k=0;k<2;k++){float y=-0.06-0.05*float(k);pd=min(pd,max(sEll(q-vec3(0.01*sg,y,0.0),vec3(0.18+0.01*float(k),0.1,0.165+0.01*float(k))),abs(q.y-y)-0.016));}r=U(r,vec2(pd,20.0));
  r=U(r,vec2(sTap(p,sh+vec3(0.05*sg,0.15,-0.02),sh+vec3(0.2*sg,0.32,-0.08),0.04,0.006),18.0));r=U(r,vec2(sTap(p,sh+vec3(0.1*sg,0.12,0.05),sh+vec3(0.22*sg,0.22,0.05),0.03,0.004),18.0));}   // 肩よろい（三段）と金のとげ
 {vec3 q=p-J[1]-vec3(0.0,0.08,-0.06);float top=0.0;float t=clamp(-q.y/(J[1].y+0.08),0.0,1.0);float rad=mix(0.32,0.44,smoothstep(0.0,0.15,-q.y))+0.22*t+0.03*sin(atan(q.x,-q.z)*8.0)*t;float rr=length(q.xz*vec2(1.0,1.15));float an=atan(q.x,-q.z);float lim=mix(1.9,1.3,smoothstep(0.03,0.2,-q.y))+0.8*smoothstep(0.55,1.0,t);
  float cp=max(abs(rr-rad)-0.03,max(q.y,-(p.y-0.03)));cp=max(cp,abs(an)-lim);r=U(r,vec2(cp,rr<rad-0.008?22.0:21.0));}   // マント（外は黒、内は赤）
 {vec3 q=p-J[1]-vec3(0.0,0.12,-0.08);float cl=max(abs(sEll(q,vec3(0.28,0.24,0.24)))-0.018,max(-q.y-0.02,q.y-0.26));cl=max(cl,-(q.z-0.02+0.5*q.y));r=U(r,vec2(cl,q.z>0.0?22.0:21.0));}   // 立てた高いえり
''', {2: 'vec3 c=mix(vec3(0.84,0.8,0.88),vec3(0.9,0.86,0.74),step(0.004,h.x))*(0.72+0.36*sh)*(0.95+0.1*fbm(p*20.0));return vec4(pow(c,vec3(2.2)),0.2);',
      4: flat(0.16, 0.12, 0.2, 0.3, 0.1), 7: flat(0.88, 0.84, 0.72, 0.3, 0.1, 30.0), 8: metal(0.9, 0.7, 0.28), 9: flat(0.12, 0.1, 0.14),
      16: flat(0.17, 0.12, 0.22, 0.3, 0.12, 8.0), 17: metal(0.22, 0.2, 0.26), 18: metal(0.92, 0.72, 0.28), 19: flat(0.62, 0.06, 0.12, 0.4, 0.1),
      20: metal(0.24, 0.22, 0.3), 21: flat(0.07, 0.06, 0.08, 0.5, 0.12, 6.0), 22: flat(0.6, 0.05, 0.1, 0.3, 0.12), 23: metal(0.14, 0.12, 0.17), 24: flat(0.1, 0.08, 0.12, 0.4, 0.2, 40.0),
      28: 'return vec4(pow(vec3(1.0,0.12,0.18),vec3(2.2))*1.6,0.9);'})

# ---------- 腐海の主「菌の母胎」：腐った沼の山に菌の森、うつろな仮面の顔、根の腕 ----------
# 16 沼の体、17 たれた沼、18 仮面、19 根、20 キノコの柄、21 赤いかさ、22 だいだいのかさ、23 紫のかさ、24 こけ、28 光る目・胞子
write('rotlord', '腐海の主（11/28 本人が2D案A「菌の母胎」を選んだ）：腐った沼の山の上に菌の森・涙の筋のあるうつろな仮面の顔・根の腕・光る胞子', r'''
 vec3 C=vec3(0.0,0.0,0.0);
 {float an=atan(p.x,p.z);float bd=sEll(p-vec3(0.0,0.34,0.0),vec3(0.6,0.5,0.54));bd=smin(bd,sEll(p-vec3(0.0,0.07,0.0),vec3(0.78,0.12,0.72)),0.12);
  bd+=0.025*sin(an*5.0+p.y*6.0)*smoothstep(0.5,0.0,p.y)+0.012*sin(p.x*17.0)*sin(p.z*15.0)*sin(p.y*13.0);bd=max(bd,-p.y);r=U(r,vec2(bd,16.0));   // 沼の山（すそが広がり波うつ）
  for(int k=0;k<7;k++){float a=0.9*float(k)+0.3;vec3 d0=vec3(0.6*sin(a),0.3,0.54*cos(a));float dr=sTap(p,d0,vec3(0.72*sin(a),0.02,0.66*cos(a)),0.035,0.05);r=U(r,vec2(dr,17.0));}}   // たれる沼
 {vec3 c=vec3(0.0,0.44,0.5);vec3 q=(p-c)/1.45;float mk=sEll(q,vec3(0.17,0.21,0.1));mk=smin(mk,sEll(q-vec3(0.0,-0.16,-0.02),vec3(0.1,0.08,0.07)),0.05);
  for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;mk=max(mk,-sEll(q-vec3(0.068*sg,0.04,0.08),vec3(0.042,0.058,0.06)));}mk=max(mk,-sEll(q-vec3(0.0,-0.11,0.08),vec3(0.05,0.025,0.06)));r=U(r,vec2(mk*1.45,18.0));   // うつろな仮面（目と口の穴）
  for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;r=U(r,vec2((length(q-vec3(0.068*sg,0.03,0.04))-0.026)*1.45,28.0));}}   // 穴の奥で光る目
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;vec3 a=vec3(0.5*sg,0.36,0.18),b=vec3(0.78*sg,0.32,0.36),c=vec3(0.86*sg,0.05,0.46);float rt=smin(sTap(p,a,b,0.09,0.06),sTap(p,b,c,0.06,0.04),0.04);
  for(int k=0;k<3;k++){vec3 f=c+vec3(0.06*sg*(float(k)-1.0),0.0,0.06*(float(k)-1.0)*0.5);rt=smin(rt,sTap(p,c,f+vec3(0.04*sg*(float(k)-1.0),-0.03,0.1),0.04,0.012),0.02);}
  rt=smin(rt,sTap(p,mix(a,b,0.5),mix(a,b,0.5)+vec3(0.05*sg,0.15,-0.05),0.03,0.006),0.02);r=U(r,vec2(rt,19.0));}   // 根の腕と根の指
 {vec3 P0[5];float R0[5];float Hh[5];P0[0]=vec3(-0.25,0.62,0.02);R0[0]=0.26;Hh[0]=0.34;P0[1]=vec3(0.1,0.7,-0.12);R0[1]=0.36;Hh[1]=0.56;P0[2]=vec3(0.38,0.55,0.0);R0[2]=0.21;Hh[2]=0.32;P0[3]=vec3(-0.46,0.42,-0.12);R0[3]=0.12;Hh[3]=0.18;P0[4]=vec3(0.22,0.6,0.28);R0[4]=0.09;Hh[4]=0.14;
  for(int k=0;k<5;k++){vec3 b0=P0[k],t0=b0+vec3(0.03*float(k-2),Hh[k],0.0);float st=sTap(p,b0-vec3(0.0,0.1,0.0),t0,R0[k]*0.3,R0[k]*0.22);r=U(r,vec2(st,20.0));
   vec3 q=p-t0;float cap=max(sEll(q,vec3(R0[k],R0[k]*0.55,R0[k])),-(q.y+0.0));cap=max(cap,-sEll(q-vec3(0.0,-0.02,0.0),vec3(R0[k]*0.85,R0[k]*0.3,R0[k]*0.85)));r=U(r,vec2(cap,k==1?22.0:(k==2?23.0:21.0)));}}   // 菌の森（5本のキノコ）
 {float ms=sEll(p-vec3(0.0,0.6,-0.1),vec3(0.5,0.25,0.45))+0.015*sin(p.x*30.0)*sin(p.z*30.0);ms=max(ms,sEll(p-vec3(0.0,0.34,0.0),vec3(0.62,0.52,0.56)));r=U(r,vec2(ms,24.0));}   // 上をおおうこけ
 for(int k=0;k<9;k++){float a=1.7*float(k);vec3 sp=vec3(0.55*sin(a),0.2+0.06*float(k),0.5*cos(a));r=U(r,vec2(length(p-sp)-0.022,28.0));}   // 体に付いた光る胞子のつぶ
''', {16: 'float w=fbm(p*5.0);vec3 c=mix(vec3(0.22,0.16,0.26),vec3(0.38,0.27,0.4),w)*(0.72+0.36*sh);c=mix(c,vec3(0.4,0.5,0.2),smoothstep(0.62,0.72,fbm(p*9.0+2.0)));return vec4(pow(c,vec3(2.2)),0.4);',
      17: flat(0.34, 0.24, 0.36, 0.5, 0.2), 18: 'float tr=seam(p.x-0.1,0.014)+seam(p.x+0.1,0.014);tr*=step(p.y,0.42)*step(0.16,p.y);vec3 c=vec3(0.86,0.8,0.66)*(0.72+0.36*sh)*(0.92+0.12*fbm(p*20.0));c=mix(c,vec3(0.4,0.34,0.26),tr*0.8);return vec4(pow(c,vec3(2.2)),0.3);',
      19: flat(0.38, 0.28, 0.18, 0.3, 0.25, 20.0), 20: flat(0.9, 0.86, 0.76, 0.2, 0.1),
      21: 'vec3 c=vec3(0.66,0.16,0.2)*(0.74+0.34*sh);c=mix(c,vec3(0.95,0.92,0.86),step(0.62,fbm(p*11.0))*step(0.0,n.y));return vec4(pow(c,vec3(2.2)),0.4);',
      22: 'vec3 c=vec3(0.75,0.36,0.14)*(0.74+0.34*sh);c=mix(c,vec3(0.95,0.92,0.86),step(0.62,fbm(p*10.0))*step(0.0,n.y));return vec4(pow(c,vec3(2.2)),0.4);',
      23: flat(0.46, 0.32, 0.6, 0.4, 0.1), 24: flat(0.34, 0.46, 0.2, 0.2, 0.3, 30.0),
      28: 'return vec4(pow(vec3(0.75,1.0,0.35),vec3(2.2))*1.5,0.9);'})
print('ok')
