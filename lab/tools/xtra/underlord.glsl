// 冥王（11/28 本人が2D案B「血の皇帝」を選んだ）：顔の右半分がガイコツの吸血鬼・角の黒い王冠・よろいの肩・赤い玉・床までの法衣・赤い裏地のマント・骨の手
const float XK=0.02;
vec2 U(vec2 a,vec2 b){return b.x<a.x?b:a;}
float hbx(vec3 p,vec3 b){vec3 q=abs(p)-b;return length(max(q,0.0))+min(max(q.x,max(q.y,q.z)),0.0);}
float band(vec3 q,float rx,float rz,float hy){return max(sEll(q,vec3(rx,4.0,rz)),abs(q.y)-hy);}
float seam(float x,float w){return 1.0-smoothstep(0.0,w,abs(x));}
vec2 boss(vec3 p){vec3 H=J[2];vec3 h=p-H;vec3 e=vec3(abs(h.x),h.y,h.z);vec2 r=vec2(1e3,1.0);

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
  r=U(r,vec2(length(q-vec3(0.0,0.06,0.19))-0.028,28.0));r=U(r,vec2(sTap(q,vec3(0.0,0.04,-0.19),vec3(0.0,0.3,-0.26),0.04,0.006),23.0));r=U(r,vec2(length(q-vec3(0.0,0.07,-0.21))-0.024,28.0));}   // 王冠の赤い玉と、うしろの高いとげと玉
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
  float cp=max(abs(rr-rad)-0.03,max(q.y,-(p.y-0.03-0.06*max(0.0,sin(an*11.0))*step(0.3,abs(an)))));cp=max(cp,abs(an)-lim);r=U(r,vec2(cp,rr<rad-0.008?22.0:21.0));}   // マント（外は黒、内は赤）
 {vec3 q=p-J[1]-vec3(0.0,0.12,-0.08);float cl=max(abs(sEll(q,vec3(0.28,0.24,0.24)))-0.018,max(-q.y-0.02,q.y-0.26));cl=max(cl,-(q.z-0.02+0.5*q.y));r=U(r,vec2(cl,q.z>0.0?22.0:21.0));}   // 立てた高いえり

 return r;}
vec2 xmod(vec2 b,vec3 p){return boss(p);}
vec2 xbody(vec3 p){return vec2(1e3,1.0);}
vec4 xcol(vec3 p,vec3 n,float m){float sh=smoothstep(-0.4,0.9,n.y);vec3 h=p-J[2];
 if(m>27.5){return vec4(pow(vec3(1.0,0.12,0.18),vec3(2.2))*1.6,0.9);}
 if(m>23.5){vec3 c=vec3(0.100,0.080,0.120)*(0.74+0.34*sh)*(1.0-0.20+0.20*2.0*fbm(p*40.0));return vec4(pow(c,vec3(2.2)),0.40);}
 if(m>22.5){vec3 c=vec3(0.140,0.120,0.170)*(0.5+0.62*sh)+vec3(0.28)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);c*=0.92+0.12*fbm(p*25.0);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>21.5){vec3 c=vec3(0.600,0.050,0.100)*(0.74+0.34*sh)*(1.0-0.12+0.12*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.30);}
 if(m>20.5){vec3 q=p-J[1]-vec3(0.0,-0.25,0.0);vec2 u=vec2(q.x,q.y);float rg=seam(length(u)-0.2,0.012)+seam(length(u)-0.16,0.006);float cr=step(abs(q.x),0.11)*step(-0.07,q.y)*step(q.y,0.03+0.05*step(0.5,fract(q.x*13.6+0.5)))*step(length(u),0.15);float sk=step(length(u-vec2(0.0,-0.06)),0.05);float bk=step(p.z,J[1].z-0.1);vec3 c=vec3(0.07,0.06,0.08)*(0.74+0.34*sh)*(0.88+0.24*fbm(p*6.0));c=mix(c,vec3(0.85,0.66,0.26),min(1.0,rg)*bk);c=mix(c,vec3(0.7,0.06,0.12),cr*bk);c=mix(c,vec3(0.8,0.76,0.66),sk*bk);return vec4(pow(c,vec3(2.2)),0.5);}
 if(m>19.5){vec3 c=vec3(0.240,0.220,0.300)*(0.5+0.62*sh)+vec3(0.28)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);c*=0.92+0.12*fbm(p*25.0);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>18.5){vec3 c=vec3(0.620,0.060,0.120)*(0.74+0.34*sh)*(1.0-0.10+0.10*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.40);}
 if(m>17.5){vec3 c=vec3(0.920,0.720,0.280)*(0.5+0.62*sh)+vec3(0.28)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);c*=0.92+0.12*fbm(p*25.0);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>16.5){vec3 c=vec3(0.220,0.200,0.260)*(0.5+0.62*sh)+vec3(0.28)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);c*=0.92+0.12*fbm(p*25.0);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>15.5){vec3 c=vec3(0.170,0.120,0.220)*(0.74+0.34*sh)*(1.0-0.12+0.12*2.0*fbm(p*8.0));return vec4(pow(c,vec3(2.2)),0.30);}
 if(m>8.5){vec3 c=vec3(0.120,0.100,0.140)*(0.74+0.34*sh)*(1.0-0.15+0.15*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.30);}
 if(m>7.5){vec3 c=vec3(0.900,0.700,0.280)*(0.5+0.62*sh)+vec3(0.28)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);c*=0.92+0.12*fbm(p*25.0);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>6.5){vec3 c=vec3(0.880,0.840,0.720)*(0.74+0.34*sh)*(1.0-0.10+0.10*2.0*fbm(p*30.0));return vec4(pow(c,vec3(2.2)),0.30);}
 if(m>3.5){vec3 c=vec3(0.160,0.120,0.200)*(0.74+0.34*sh)*(1.0-0.10+0.10*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.30);}
 if(m>1.5){vec3 c=mix(vec3(0.84,0.8,0.88),vec3(0.9,0.86,0.74),step(0.004,h.x))*(0.72+0.36*sh)*(0.95+0.1*fbm(p*20.0));return vec4(pow(c,vec3(2.2)),0.2);}
 return vec4(1.0);}
