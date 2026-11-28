// 魔法使い（11/28 2D案＋ディテール）：つばの広いとんがり帽子（波うつつば・星・留め金）・立てたえり・すそまで広がる青いローブ（金のふちと星の模様）・金の帯とふさ・腰の巻物・胸の月飾り・長い白ひげと白い髪
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

 return r;}
vec2 xmod(vec2 b,vec3 p){return hero(p);}
vec2 xbody(vec3 p){return vec2(1e3,1.0);}
float seam(float x,float w){return 1.0-smoothstep(0.0,w,abs(x));}
vec4 xcol(vec3 p,vec3 n,float m){float sh=smoothstep(-0.4,0.9,n.y);
 if(m>28.5){vec3 c=vec3(0.880,0.800,0.620)*(0.74+0.34*sh)*(1.0-0.15+0.15*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.20);}
 if(m>26.5){vec3 c=vec3(0.930,0.930,0.950)*(0.74+0.34*sh)*(1.0-0.08+0.08*2.0*fbm(p*40.0));return vec4(pow(c,vec3(2.2)),0.20);}
 if(m>22.5){vec3 c=vec3(0.950,0.750,0.300)*(0.5+0.62*sh)+vec3(0.28)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);c*=0.92+0.12*fbm(p*25.0);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>21.5){vec3 c=vec3(0.170,0.180,0.460)*(0.74+0.34*sh)*(1.0-0.12+0.12*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.25);}
 if(m>20.5){vec3 c=vec3(0.160,0.170,0.440)*(0.74+0.34*sh)*(1.0-0.12+0.12*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.25);}
 if(m>17.5){vec3 c=vec3(0.950,0.750,0.300)*(0.5+0.62*sh)+vec3(0.28)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);c*=0.92+0.12*fbm(p*25.0);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>15.5){float tr=step(abs(p.x),0.03)*step(p.y,J[1].y-0.05)+step(p.y,0.1);float st=step(0.82,fbm(p*vec3(26.0)));vec3 c=mix(vec3(0.2,0.22,0.54),vec3(0.9,0.72,0.28),max(tr,st))*(0.74+0.34*sh)*(0.9+0.2*fbm(p*8.0));return vec4(pow(c,vec3(2.2)),0.3);}
 if(m>12.5){vec3 c=vec3(0.950,0.750,0.300)*(0.5+0.62*sh)+vec3(0.28)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);c*=0.92+0.12*fbm(p*25.0);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>10.5){vec3 c=vec3(0.950,0.750,0.300)*(0.5+0.62*sh)+vec3(0.28)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);c*=0.92+0.12*fbm(p*25.0);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>9.5){vec3 c=vec3(0.120,0.100,0.100)*(0.74+0.34*sh)*(1.0-0.15+0.15*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.20);}
 if(m>6.5){vec3 c=vec3(0.950,0.750,0.300)*(0.5+0.62*sh)+vec3(0.28)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);c*=0.92+0.12*fbm(p*25.0);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>5.5){vec3 c=vec3(0.200,0.220,0.520)*(0.74+0.34*sh)*(1.0-0.12+0.12*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.25);}
 if(m>4.5){vec3 c=vec3(0.300,0.200,0.140)*(0.74+0.34*sh)*(1.0-0.15+0.15*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.35);}
 if(m>3.5){vec3 c=vec3(0.200,0.180,0.300)*(0.74+0.34*sh)*(1.0-0.15+0.15*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.30);}
 if(m>1.5){vec3 c=vec3(0.960,0.780,0.640)*(0.74+0.34*sh)*(1.0-0.04+0.04*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.20);}
 return vec4(1.0);}
