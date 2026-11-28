// 盗賊（11/28 2D案＋ディテール）：紫のフード（ふちの縫い取り）・鼻まで隠す布（うしろで結ぶ）・革の胸当て・ななめの負いひもに投げナイフ・小物入れ（腰と太もも）・前腕に巻いた布・短いマント
const float XK=0.02;
vec2 U(vec2 a,vec2 b){return b.x<a.x?b:a;}
float hbx(vec3 p,vec3 b){vec3 q=abs(p)-b;return length(max(q,0.0))+min(max(q.x,max(q.y,q.z)),0.0);}
float band(vec3 q,float rx,float rz,float hy){return max(sEll(q,vec3(rx,4.0,rz)),abs(q.y)-hy);}
vec2 headN(vec3 p){vec3 H=J[2];vec3 h=p-H;vec3 e=vec3(abs(h.x),h.y,h.z);
 float hd=sEll(h-vec3(0.0,0.01,0.0),vec3(0.185,0.2,0.18));hd=smin(hd,sEll(h-vec3(0.0,-0.085,0.035),vec3(0.14,0.115,0.135)),0.07);
 hd=smin(hd,sEll(e-vec3(0.18,-0.01,-0.01),vec3(0.028,0.05,0.035)),0.02);
 hd=smin(hd,sEll(h-vec3(0.0,-0.035,0.18),vec3(0.024,0.03,0.024)),0.02);
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

 return r;}
vec2 xmod(vec2 b,vec3 p){return hero(p);}
vec2 xbody(vec3 p){return vec2(1e3,1.0);}
float seam(float x,float w){return 1.0-smoothstep(0.0,w,abs(x));}
vec4 xcol(vec3 p,vec3 n,float m){float sh=smoothstep(-0.4,0.9,n.y);
 if(m>28.5){vec3 c=vec3(0.400,0.270,0.150)*(0.74+0.34*sh)*(1.0-0.22+0.22*2.0*fbm(p*14.0));c*=1.0-0.35*seam(fract(p.y*9.0)-0.5,0.03)*step(0.4,fract(p.x*18.0+p.z*18.0));return vec4(pow(c,vec3(2.2)),0.35);}
 if(m>27.5){vec3 c=vec3(0.800,0.700,0.400)*(0.5+0.62*sh)+vec3(0.28)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);c*=0.92+0.12*fbm(p*25.0);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>25.5){vec3 c=vec3(0.220,0.170,0.270)*(0.74+0.34*sh)*(1.0-0.18+0.18*2.0*fbm(p*30.0));return vec4(pow(c,vec3(2.2)),0.25);}
 if(m>22.5){vec3 c=vec3(0.750,0.620,0.350)*(0.74+0.34*sh)*(1.0-0.10+0.10*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.30);}
 if(m>21.5){vec3 c=vec3(0.380,0.170,0.460)*(0.74+0.34*sh)*(1.0-0.12+0.12*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.25);}
 if(m>20.5){vec3 c=vec3(0.360,0.160,0.440)*(0.74+0.34*sh)*(1.0-0.12+0.12*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.30);}
 if(m>18.5){vec3 c=vec3(0.420,0.280,0.160)*(0.74+0.34*sh)*(1.0-0.15+0.15*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.40);}
 if(m>17.5){vec3 c=vec3(0.820,0.840,0.880)*(0.5+0.62*sh)+vec3(0.28)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);c*=0.92+0.12*fbm(p*25.0);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>16.5){vec3 c=vec3(0.320,0.220,0.160)*(0.74+0.34*sh)*(1.0-0.22+0.22*2.0*fbm(p*14.0));c*=1.0-0.35*seam(fract(p.y*9.0)-0.5,0.03)*step(0.4,fract(p.x*18.0+p.z*18.0));return vec4(pow(c,vec3(2.2)),0.35);}
 if(m>15.5){vec3 c=vec3(0.300,0.240,0.380)*(0.74+0.34*sh)*(1.0-0.15+0.15*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.30);}
 if(m>12.5){vec3 c=vec3(0.400,0.270,0.150)*(0.74+0.34*sh)*(1.0-0.22+0.22*2.0*fbm(p*14.0));c*=1.0-0.35*seam(fract(p.y*9.0)-0.5,0.03)*step(0.4,fract(p.x*18.0+p.z*18.0));return vec4(pow(c,vec3(2.2)),0.35);}
 if(m>10.5){vec3 c=vec3(0.320,0.220,0.140)*(0.74+0.34*sh)*(1.0-0.15+0.15*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.40);}
 if(m>9.5){vec3 c=vec3(0.100,0.080,0.080)*(0.74+0.34*sh)*(1.0-0.15+0.15*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.20);}
 if(m>7.5){vec3 c=vec3(0.550,0.480,0.420)*(0.74+0.34*sh)*(1.0-0.25+0.25*2.0*fbm(p*20.0));return vec4(pow(c,vec3(2.2)),0.20);}
 if(m>6.5){vec3 c=vec3(0.220,0.170,0.270)*(0.74+0.34*sh)*(1.0-0.15+0.15*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.30);}
 if(m>5.5){vec3 c=vec3(0.280,0.220,0.340)*(0.74+0.34*sh)*(1.0-0.15+0.15*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.30);}
 if(m>4.5){vec3 c=vec3(0.180,0.130,0.150)*(0.74+0.34*sh)*(1.0-0.15+0.15*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.30);}
 if(m>3.5){vec3 c=vec3(0.200,0.170,0.250)*(0.74+0.34*sh)*(1.0-0.20+0.20*2.0*fbm(p*18.0));return vec4(pow(c,vec3(2.2)),0.20);}
 if(m>1.5){vec3 c=vec3(0.960,0.780,0.640)*(0.74+0.34*sh)*(1.0-0.04+0.04*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.20);}
 return vec4(1.0);}
