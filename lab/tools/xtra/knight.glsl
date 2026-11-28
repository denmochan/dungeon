// 騎士（11/28 2D案＋ディテール）：全身よろい（腹・腕・太ももの板の重なり、とがったひじ当て、三段の肩当てとびょう、のど当て）・青い羽のかぶと（金のふちと留め金）・青い前垂れ（金のふちと十字）・背中の青いマント
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

 return r;}
vec2 xmod(vec2 b,vec3 p){return hero(p);}
vec2 xbody(vec3 p){return vec2(1e3,1.0);}
float seam(float x,float w){return 1.0-smoothstep(0.0,w,abs(x));}
vec4 xcol(vec3 p,vec3 n,float m){float sh=smoothstep(-0.4,0.9,n.y);
 if(m>27.5){vec3 c=vec3(0.950,0.780,0.320)*(0.5+0.62*sh)+vec3(0.28)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);c*=0.92+0.12*fbm(p*25.0);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>25.5){vec3 c=vec3(0.040,0.040,0.060)*(0.74+0.34*sh)*(1.0-0.00+0.00*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.10);}
 if(m>24.5){vec3 c=vec3(0.180,0.400,0.900)*(0.74+0.34*sh)*(1.0-0.20+0.20*2.0*fbm(p*30.0));return vec4(pow(c,vec3(2.2)),0.20);}
 if(m>21.5){vec3 c=vec3(0.780,0.810,0.870)*(0.5+0.62*sh)+vec3(0.28)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);c*=0.92+0.12*fbm(p*25.0);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>20.5){vec3 c=vec3(0.160,0.320,0.720)*(0.74+0.34*sh)*(1.0-0.12+0.12*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.30);}
 if(m>19.5){vec3 c=vec3(0.820,0.850,0.900)*(0.5+0.62*sh)+vec3(0.28)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);c*=0.92+0.12*fbm(p*25.0);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>18.5){vec3 c=vec3(0.300,0.200,0.130)*(0.74+0.34*sh)*(1.0-0.15+0.15*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.40);}
 if(m>17.5){vec3 c=vec3(0.950,0.780,0.320)*(0.5+0.62*sh)+vec3(0.28)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);c*=0.92+0.12*fbm(p*25.0);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>16.5){vec3 c=vec3(0.950,0.960,1.000)*(0.5+0.62*sh)+vec3(0.28)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);c*=0.92+0.12*fbm(p*25.0);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>15.5){vec3 c=vec3(0.780,0.810,0.870)*(0.5+0.62*sh)+vec3(0.28)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);c*=0.92+0.12*fbm(p*25.0);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>12.5){vec3 c=vec3(0.860,0.880,0.930)*(0.5+0.62*sh)+vec3(0.28)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);c*=0.92+0.12*fbm(p*25.0);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>11.5){vec3 c=vec3(0.950,0.780,0.320)*(0.5+0.62*sh)+vec3(0.28)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);c*=0.92+0.12*fbm(p*25.0);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>9.5){vec3 c=vec3(0.200,0.200,0.220)*(0.74+0.34*sh)*(1.0-0.15+0.15*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.30);}
 if(m>8.5){vec3 c=vec3(0.740,0.770,0.830)*(0.5+0.62*sh)+vec3(0.28)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);c*=0.92+0.12*fbm(p*25.0);return vec4(pow(c,vec3(2.2)),0.9);}
 return vec4(1.0);}
