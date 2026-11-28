// 僧侶（11/28 2D案＋ディテール）：白い法衣（しわ）・肩かけと金のふち・前に下がる金のストール（輪の模様）・首から下げた十字と鎖・なわの帯とふさ・白い頭巾（金の帯とふち・額の青い石）・金髪
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

 return r;}
vec2 xmod(vec2 b,vec3 p){return hero(p);}
vec2 xbody(vec3 p){return vec2(1e3,1.0);}
float seam(float x,float w){return 1.0-smoothstep(0.0,w,abs(x));}
vec4 xcol(vec3 p,vec3 n,float m){float sh=smoothstep(-0.4,0.9,n.y);
 if(m>29.5){vec3 c=vec3(0.300,0.600,1.000)*(0.5+0.62*sh)+vec3(0.28)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);c*=0.92+0.12*fbm(p*25.0);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>27.5){vec3 c=vec3(0.980,0.850,0.450)*(0.5+0.62*sh)+vec3(0.28)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);c*=0.92+0.12*fbm(p*25.0);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>23.5){vec3 c=vec3(0.950,0.800,0.420)*(0.74+0.34*sh)*(1.0-0.20+0.20*2.0*fbm(p*40.0));return vec4(pow(c,vec3(2.2)),0.35);}
 if(m>22.5){vec3 c=vec3(0.950,0.780,0.320)*(0.5+0.62*sh)+vec3(0.28)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);c*=0.92+0.12*fbm(p*25.0);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>21.5){vec3 c=vec3(0.960,0.940,0.890)*(0.74+0.34*sh)*(1.0-0.06+0.06*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.20);}
 if(m>20.5){vec3 c=vec3(0.970,0.950,0.900)*(0.74+0.34*sh)*(1.0-0.05+0.05*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.20);}
 if(m>18.5){vec3 c=vec3(0.780,0.660,0.440)*(0.74+0.34*sh)*(1.0-0.25+0.25*2.0*fbm(p*30.0));return vec4(pow(c,vec3(2.2)),0.30);}
 if(m>17.5){vec3 c=vec3(0.950,0.780,0.320)*(0.5+0.62*sh)+vec3(0.28)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);c*=0.92+0.12*fbm(p*25.0);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>16.5){vec3 c=vec3(1.000,1.000,0.980)*(0.74+0.34*sh)*(1.0-0.00+0.00*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.30);}
 if(m>15.5){float tr=step(p.y,0.1);vec3 c=mix(vec3(0.95,0.93,0.87),vec3(0.92,0.74,0.3),tr)*(0.76+0.32*sh);return vec4(pow(c,vec3(2.2)),0.2);}
 if(m>12.5){vec3 c=vec3(0.950,0.780,0.320)*(0.5+0.62*sh)+vec3(0.28)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);c*=0.92+0.12*fbm(p*25.0);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>10.5){vec3 c=vec3(0.950,0.780,0.320)*(0.5+0.62*sh)+vec3(0.28)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);c*=0.92+0.12*fbm(p*25.0);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>9.5){vec3 c=vec3(0.300,0.220,0.150)*(0.74+0.34*sh)*(1.0-0.15+0.15*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.20);}
 if(m>6.5){vec3 c=vec3(0.950,0.780,0.320)*(0.5+0.62*sh)+vec3(0.28)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);c*=0.92+0.12*fbm(p*25.0);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>5.5){vec3 c=vec3(0.950,0.930,0.870)*(0.74+0.34*sh)*(1.0-0.06+0.06*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.20);}
 if(m>4.5){vec3 c=vec3(0.500,0.360,0.220)*(0.74+0.34*sh)*(1.0-0.15+0.15*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.30);}
 if(m>3.5){vec3 c=vec3(0.850,0.820,0.740)*(0.74+0.34*sh)*(1.0-0.15+0.15*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.30);}
 if(m>1.5){vec3 c=vec3(0.960,0.780,0.640)*(0.74+0.34*sh)*(1.0-0.04+0.04*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.20);}
 return vec4(1.0);}
