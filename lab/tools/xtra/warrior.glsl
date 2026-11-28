// 戦士（11/28 2D案＋ディテール）：革の胴（縫い目・負いひも・びょう）・板の腰すそ・毛皮の肩（二重）・こての革ひも・立った髪・赤いはちまき・ほおの傷
const float XK=0.02;
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
vec2 hero(vec3 p){vec3 H=J[2];vec3 h=p-H;vec3 e=vec3(abs(h.x),h.y,h.z);vec2 r=headN(p);

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

 return r;}
vec2 xmod(vec2 b,vec3 p){return hero(p);}
vec2 xbody(vec3 p){return vec2(1e3,1.0);}
float seam(float x,float w){return 1.0-smoothstep(0.0,w,abs(x));}
vec4 xcol(vec3 p,vec3 n,float m){float sh=smoothstep(-0.4,0.9,n.y);
 if(m>28.5){vec3 c=vec3(0.380,0.240,0.140)*(0.74+0.34*sh)*(1.0-0.22+0.22*2.0*fbm(p*14.0));c*=1.0-0.35*seam(fract(p.y*9.0)-0.5,0.03)*step(0.4,fract(p.x*18.0+p.z*18.0));return vec4(pow(c,vec3(2.2)),0.35);}
 if(m>27.5){vec3 c=vec3(0.700,0.700,0.720)*(0.5+0.62*sh)+vec3(0.28)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);c*=0.92+0.12*fbm(p*25.0);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>23.5){vec3 c=vec3(0.420,0.250,0.140)*(0.74+0.34*sh)*(1.0-0.25+0.25*2.0*fbm(p*40.0));return vec4(pow(c,vec3(2.2)),0.30);}
 if(m>22.5){vec3 c=vec3(0.820,0.120,0.140)*(0.74+0.34*sh)*(1.0-0.10+0.10*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.30);}
 if(m>19.5){vec3 c=vec3(0.840,0.740,0.580)*(0.74+0.34*sh)*(1.0-0.35+0.35*2.0*fbm(p*30.0));return vec4(pow(c,vec3(2.2)),0.10);}
 if(m>18.5){vec3 c=vec3(0.240,0.150,0.100)*(0.74+0.34*sh)*(1.0-0.15+0.15*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.45);}
 if(m>17.5){vec3 c=vec3(0.950,0.750,0.300)*(0.5+0.62*sh)+vec3(0.28)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);c*=0.92+0.12*fbm(p*25.0);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>16.5){vec3 c=vec3(0.850,0.600,0.500)*(0.74+0.34*sh)*(1.0-0.00+0.00*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.20);}
 if(m>15.5){vec3 c=vec3(0.560,0.360,0.220)*(0.74+0.34*sh)*(1.0-0.22+0.22*2.0*fbm(p*14.0));c*=1.0-0.35*seam(fract(p.y*7.0)-0.5,0.03)*step(0.4,fract(p.x*18.0+p.z*18.0));return vec4(pow(c,vec3(2.2)),0.35);}
 if(m>12.5){vec3 c=vec3(0.240,0.150,0.100)*(0.74+0.34*sh)*(1.0-0.15+0.15*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.40);}
 if(m>11.5){vec3 c=vec3(0.400,0.260,0.160)*(0.74+0.34*sh)*(1.0-0.22+0.22*2.0*fbm(p*14.0));c*=1.0-0.35*seam(fract(p.y*9.0)-0.5,0.03)*step(0.4,fract(p.x*18.0+p.z*18.0));return vec4(pow(c,vec3(2.2)),0.35);}
 if(m>10.5){vec3 c=vec3(0.800,0.700,0.550)*(0.74+0.34*sh)*(1.0-0.30+0.30*2.0*fbm(p*30.0));return vec4(pow(c,vec3(2.2)),0.10);}
 if(m>9.5){vec3 c=vec3(0.150,0.110,0.090)*(0.74+0.34*sh)*(1.0-0.15+0.15*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.20);}
 if(m>7.5){vec3 c=vec3(0.720,0.640,0.500)*(0.74+0.34*sh)*(1.0-0.20+0.20*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.15);}
 if(m>6.5){vec3 c=vec3(0.470,0.310,0.180)*(0.74+0.34*sh)*(1.0-0.22+0.22*2.0*fbm(p*14.0));c*=1.0-0.35*seam(fract(p.y*14.0)-0.5,0.03)*step(0.4,fract(p.x*18.0+p.z*18.0));return vec4(pow(c,vec3(2.2)),0.35);}
 if(m>4.5){vec3 c=vec3(0.320,0.210,0.130)*(0.74+0.34*sh)*(1.0-0.15+0.15*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.35);}
 if(m>3.5){vec3 c=vec3(0.360,0.260,0.190)*(0.74+0.34*sh)*(1.0-0.20+0.20*2.0*fbm(p*18.0));return vec4(pow(c,vec3(2.2)),0.20);}
 if(m>2.5){vec3 c=vec3(0.500,0.320,0.200)*(0.74+0.34*sh)*(1.0-0.22+0.22*2.0*fbm(p*14.0));c*=1.0-0.35*seam(fract(p.y*9.0)-0.5,0.03)*step(0.4,fract(p.x*18.0+p.z*18.0));return vec4(pow(c,vec3(2.2)),0.35);}
 if(m>1.5){vec3 c=vec3(0.960,0.780,0.640)*(0.74+0.34*sh)*(1.0-0.04+0.04*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.20);}
 return vec4(1.0);}
