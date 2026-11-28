# 目玉系：浮遊眼「まぶたのない目」・石の邪眼「目を閉じこめた像」・心読みの主「目の司祭」（11/28 本人が2D案から選んだ）
# どれも関節は1つ（J[0]=(0,1.05,0)）。形は全部ここで作り、色は全部 xcol（XMIN=0.5）
HEAD = '''const float XK=0.02;
vec2 U(vec2 a,vec2 b){return b.x<a.x?b:a;}
float hbx(vec3 p,vec3 b){vec3 q=abs(p)-b;return length(max(q,0.0))+min(max(q.x,max(q.y,q.z)),0.0);}
float seam(float x,float w){return 1.0-smoothstep(0.0,w,abs(x));}
// 目玉の色（中心 c・半径 R・前の向き +z）：白目に血管、金のふちの虹彩、たての瞳孔
vec3 eyeCol(vec3 p,vec3 n,vec3 c,float R,vec3 iris){vec3 d=normalize(p-c);float a=acos(clamp(d.z,-1.0,1.0));
 vec3 col=vec3(0.96,0.92,0.88);float an=atan(d.y,d.x);float vn=seam(sin(an*9.0+fbm(d*6.0)*5.0),0.12)*smoothstep(0.55,1.4,a);col=mix(col,vec3(0.8,0.15,0.2),vn*0.8);   // 血管
 float ir=smoothstep(0.47,0.45,a);float rim=seam(a-0.46,0.025);vec3 ic=mix(iris*0.5,iris*1.3,smoothstep(0.0,0.45,a))*(0.85+0.3*fbm(d*30.0));col=mix(col,ic,ir);col=mix(col,vec3(1.0,0.8,0.3),rim);
 float pu=step(abs(d.x)/0.07+abs(d.y)/0.3,1.0)*step(0.0,d.z);col=mix(col,vec3(0.06,0.02,0.02),pu);
 return col*(0.78+0.3*smoothstep(-0.4,0.9,n.y));}
'''
def write(name, comment, body, xcol):
    src = '// ' + comment + '\n' + HEAD + 'vec2 eyeb(vec3 p){vec3 C=J[0];vec2 r=vec2(1e3,15.0);\n' + body + '\n return r;}\nvec2 xmod(vec2 b,vec3 p){return eyeb(p);}\nvec2 xbody(vec3 p){return vec2(1e3,15.0);}\n'
    src += 'vec4 xcol(vec3 p,vec3 n,float m){float sh=smoothstep(-0.4,0.9,n.y);vec3 C=J[0];\n' + xcol + '\n}\n'
    open('xtra/%s.glsl' % name, 'w').write(src)

# ---------- 浮遊眼 ----------
write('eye', '浮遊眼（11/28 2D案「まぶたのない目」）：血管の走る白目・金のふちの赤い虹彩・たての瞳孔・下の肉のえり・吸盤のつぶのある5本の触手・上の短い2本の角', r'''
 r=U(r,vec2(length(p-C)-0.42,15.0));   // 目玉
 {vec3 q=p-C-vec3(0.0,-0.36,-0.02);float cl=sEll(q,vec3(0.26,0.12,0.24));r=U(r,vec2(cl,16.0));}   // 下の肉のえり
 for(int k=0;k<5;k++){float a=1.2566*float(k)+0.3;vec3 b0=C+vec3(0.17*sin(a),-0.44,0.17*cos(a));vec3 m1=b0+vec3(0.12*sin(a),-0.3,0.12*cos(a))+vec3(0.06*sin(a*3.0),0.0,0.06*cos(a*2.0));vec3 e1=m1+vec3(0.05*sin(a+1.0),-0.3,0.05*cos(a+1.0));
  float t=smin(sTap(p,b0,m1,0.06,0.042),sTap(p,m1,e1,0.042,0.014),0.03);r=U(r,vec2(t,16.0));
  for(int j=0;j<3;j++){vec3 s=mix(b0,m1,0.3+0.3*float(j))+vec3(sin(a),0.0,cos(a))*0.045;r=U(r,vec2(length(p-s)-0.018,17.0));}}   // 触手と吸盤
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;r=U(r,vec2(sTap(p,C+vec3(0.22*sg,0.32,-0.08),C+vec3(0.3*sg,0.52,-0.12),0.035,0.012),16.0));}   // 上の短い角
''', r''' if(m>16.5)return vec4(pow(vec3(0.42,0.18,0.24)*(0.8+0.3*sh),vec3(2.2)),0.3);   // 吸盤
 if(m>15.5){vec3 c=mix(vec3(0.55,0.32,0.38),vec3(0.78,0.52,0.56),sh)*(0.88+0.2*fbm(p*14.0));return vec4(pow(c,vec3(2.2)),0.4);}   // 肉
 return vec4(pow(eyeCol(p,n,C,0.42,vec3(0.78,0.1,0.14)),vec3(2.2)),0.7);''')

# ---------- 石の邪眼 ----------
write('stoneeye', '石の邪眼（11/28 2D案「目を閉じこめた像」）：ガーゴイルの石像の顔に目玉が埋まる・角・たたんだ翼・寄せた石の眉・牙の口・ひび・二段の台座', r'''
 r=U(r,vec2(hbx(p-vec3(0.0,0.07,0.0),vec3(0.42,0.07,0.36))-0.015,15.0));r=U(r,vec2(hbx(p-vec3(0.0,0.2,0.0),vec3(0.34,0.07,0.29))-0.015,15.0));   // 台座
 {float bd=sEll(p-vec3(0.0,0.62,0.0),vec3(0.32,0.38,0.27));bd=smin(bd,sEll(p-vec3(0.0,0.98,0.04),vec3(0.36,0.34,0.3)),0.12);
  for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;bd=smin(bd,sEll(p-vec3(0.27*sg,0.45,0.18),vec3(0.1,0.17,0.12)),0.05);bd=smin(bd,sEll(p-vec3(0.22*sg,0.3,0.22),vec3(0.1,0.05,0.12)),0.04);}   // うずくまった前脚
  bd=max(bd,-sEll(p-vec3(0.0,0.98,0.34),vec3(0.21,0.2,0.14)));   // 目のはまるくぼみ
  bd=max(bd,-hbx(p-vec3(0.0,0.72,0.3),vec3(0.17,0.035,0.1)));   // 口
  r=U(r,vec2(bd,16.0));
  for(int k=0;k<6;k++){float x=-0.135+0.054*float(k);r=U(r,vec2(sTap(p,vec3(x,0.755,0.3),vec3(x,0.715,0.31),0.016,0.004),17.0));r=U(r,vec2(sTap(p,vec3(x+0.027,0.685,0.3),vec3(x+0.027,0.72,0.31),0.014,0.004),17.0));}   // 牙
  for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;r=U(r,vec2(sTap(p,vec3(0.06*sg,1.2,0.25),vec3(0.24*sg,1.14,0.28),0.04,0.035),16.0));   // 寄せた石の眉
   r=U(r,vec2(smin(sTap(p,vec3(0.2*sg,1.24,0.0),vec3(0.3*sg,1.42,-0.06),0.07,0.03),sTap(p,vec3(0.3*sg,1.42,-0.06),vec3(0.28*sg,1.56,-0.14),0.03,0.006),0.02),16.0));   // 角
   vec3 q=p-vec3(0.36*sg,0.82,-0.12);q.x*=sg;float wg=max(hbx(q,vec3(0.05,0.32,0.18))-0.01,dot(q-vec3(0.0,0.32,-0.18),normalize(vec3(0.0,1.0,0.5))));wg=max(wg,-(q.y+0.3-0.25*sin((q.z+0.2)*14.0)*0.3));r=U(r,vec2(wg,18.0));}}   // たたんだ翼
 r=U(r,vec2(length(p-vec3(0.0,0.98,0.32))-0.2,20.0));   // 目玉
''', r''' if(m>19.5)return vec4(pow(eyeCol(p,n,vec3(0.0,0.98,0.32),0.2,vec3(0.78,0.1,0.14)),vec3(2.2)),0.7);
 vec3 c=mix(vec3(0.42,0.41,0.4),vec3(0.66,0.64,0.6),sh)*(0.82+0.3*fbm(p*10.0));if(m>17.5)c*=0.85;if(m>16.5&&m<17.5)c=vec3(0.78,0.76,0.7)*(0.8+0.25*sh);
 c*=1.0-0.6*seam(fbm(p*6.0)-0.5,0.012)*step(0.5,fbm(p*2.5+4.0));   // ひび
 c=mix(c,vec3(0.3,0.42,0.2),0.7*smoothstep(0.66,0.72,fbm(p*6.0+1.0))*smoothstep(0.3,0.8,n.y));   // こけ
 return vec4(pow(c,vec3(2.2)),0.3);''')

# ---------- 心読みの主 ----------
write('mindlord', '心読みの主（11/28 2D案A「目の司祭」）：フードの奥の顔が一つ目（紫の虹彩）・顔から垂れる触手・紫のローブに金の線・呪術師の骨の冠・緑がかった爪の手・まわりに浮かぶ3つの小さな目', r'''
 {float t=clamp((1.25-p.y)/1.25,0.0,1.0);float rr=length(p.xz*vec2(1.0,1.15));float an=atan(p.x,p.z);float ro=max(rr-(0.16+0.36*t*t)-0.015*sin(an*7.0)*t,max(p.y-1.25,0.02-p.y));ro=smin(ro,sEll(p-vec3(0.0,1.12,0.0),vec3(0.27,0.18,0.22)),0.08);r=U(r,vec2(ro,15.0));}   // ローブ
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;vec3 a=vec3(0.24*sg,1.12,0.0),b=vec3(0.38*sg,0.8,0.12),c=vec3(0.44*sg,0.56,0.22);r=U(r,vec2(smin(sTap(p,a,b,0.08,0.07),sTap(p,b,c,0.07,0.11),0.03),15.0));   // そで
  for(int k=0;k<4;k++){vec3 f=c+vec3(0.03*sg*(float(k)-1.5),-0.06,0.025*(float(k)-1.5));r=U(r,vec2(smin(sTap(p,f,f+vec3(0.01*sg,-0.1,0.02),0.018,0.012),sTap(p,f+vec3(0.01*sg,-0.1,0.02),f+vec3(0.0,-0.16,0.06),0.012,0.003),0.008),17.0));}}   // 爪の手
 {vec3 q=p-vec3(0.0,1.45,0.0);float hd=sEll(q,vec3(0.3,0.34,0.3));hd=max(hd,-sEll(q-vec3(0.0,-0.04,0.18),vec3(0.21,0.25,0.2)));hd=smin(hd,sTap(p,vec3(0.0,1.7,-0.12),vec3(0.0,1.6,-0.34),0.07,0.02),0.05);r=U(r,vec2(hd,16.0));   // フード
  r=U(r,vec2(sEll(q-vec3(0.0,-0.04,0.02),vec3(0.2,0.24,0.18)),19.0));   // フードの奥の暗がり
  r=U(r,vec2(length(q-vec3(0.0,-0.02,0.12))-0.16,20.0));   // 一つ目
  for(int k=0;k<4;k++){float x=-0.09+0.06*float(k);vec3 b0=vec3(x,1.32,0.18);r=U(r,vec2(smin(sTap(p,b0,b0+vec3(0.02*sin(float(k)*2.0),-0.2,0.04),0.028,0.02),sTap(p,b0+vec3(0.02*sin(float(k)*2.0),-0.2,0.04),b0+vec3(0.0,-0.36,0.02),0.02,0.008),0.02),18.0));}   // 顔から垂れる触手
  for(int k=0;k<5;k++){float a=-0.9+0.45*float(k);vec3 b0=vec3(0.26*sin(a),1.72,0.26*cos(a)-0.04);r=U(r,vec2(sTap(p,b0,b0+vec3(0.03*sin(a),0.12+0.06*(1.0-abs(a)),0.0),0.03,0.006),17.0));}}   // 骨の冠
 for(int k=0;k<3;k++){float a=2.1*float(k)+0.6;vec3 c=vec3(0.62*sin(a),1.3+0.2*float(k),0.62*cos(a));r=U(r,vec2(length(p-c)-0.09,21.0+float(k)));}   // まわりに浮かぶ小さな目
''', r''' if(m>20.5){float k=m-21.0;vec3 c=k<0.5?vec3(0.62*sin(0.6),1.3,0.62*cos(0.6)):(k<1.5?vec3(0.62*sin(2.7),1.5,0.62*cos(2.7)):vec3(0.62*sin(4.8),1.7,0.62*cos(4.8)));return vec4(pow(eyeCol(p,n,c,0.09,vec3(0.6,0.2,0.85)),vec3(2.2)),0.7);}
 if(m>19.5)return vec4(pow(eyeCol(p,n,vec3(0.0,1.43,0.12),0.16,vec3(0.6,0.2,0.85)),vec3(2.2)),0.7);
 if(m>18.5)return vec4(pow(vec3(0.05,0.02,0.07),vec3(2.2)),0.1);   // 暗がり
 if(m>17.5){vec3 c=mix(vec3(0.45,0.26,0.5),vec3(0.7,0.46,0.72),sh);return vec4(pow(c,vec3(2.2)),0.4);}   // 触手
 if(m>16.5){vec3 c=vec3(0.62,0.66,0.48)*(0.74+0.34*sh);return vec4(pow(c,vec3(2.2)),0.3);}   // 骨の冠・爪
 vec3 c=mix(vec3(0.16,0.08,0.22),vec3(0.3,0.16,0.38),sh)*(0.88+0.2*fbm(p*8.0));c=mix(c,vec3(0.85,0.66,0.26),seam(p.x,0.012)*step(0.0,p.z)*step(p.y,1.1)+step(p.y,0.08));return vec4(pow(c,vec3(2.2)),0.3);''')
print('ok')
