// 腐海の主（11/28 本人が2D案A「菌の母胎」を選んだ）：腐った沼の山の上に菌の森・涙の筋のあるうつろな仮面の顔・根の腕・光る胞子
const float XK=0.02;
vec2 U(vec2 a,vec2 b){return b.x<a.x?b:a;}
float hbx(vec3 p,vec3 b){vec3 q=abs(p)-b;return length(max(q,0.0))+min(max(q.x,max(q.y,q.z)),0.0);}
float band(vec3 q,float rx,float rz,float hy){return max(sEll(q,vec3(rx,4.0,rz)),abs(q.y)-hy);}
float seam(float x,float w){return 1.0-smoothstep(0.0,w,abs(x));}
vec2 boss(vec3 p){vec3 H=J[2];vec3 h=p-H;vec3 e=vec3(abs(h.x),h.y,h.z);vec2 r=vec2(1e3,1.0);

 vec3 C=vec3(0.0,0.0,0.0);
 {float an=atan(p.x,p.z);float bd=sEll(p-vec3(0.0,0.34,0.0),vec3(0.6,0.5,0.54));bd=smin(bd,sEll(p-vec3(0.0,0.07,0.0),vec3(0.78,0.12,0.72)),0.12);
  bd+=0.025*sin(an*5.0+p.y*6.0)*smoothstep(0.5,0.0,p.y)+0.012*sin(p.x*17.0)*sin(p.z*15.0)*sin(p.y*13.0);bd=max(bd,-p.y);r=U(r,vec2(bd,16.0));   // 沼の山（すそが広がり波うつ）
  for(int k=0;k<7;k++){float a=0.9*float(k)+0.3;vec3 d0=vec3(0.6*sin(a),0.3,0.54*cos(a));float dr=sTap(p,d0,vec3(0.72*sin(a),0.02,0.66*cos(a)),0.035,0.05);r=U(r,vec2(dr,17.0));}}   // たれる沼
 {vec3 c=vec3(0.0,0.44,0.5);vec3 q=(p-c)/1.45;float mk=sEll(q,vec3(0.145,0.24,0.1));mk=smin(mk,sEll(q-vec3(0.0,-0.2,-0.02),vec3(0.075,0.09,0.07)),0.05);   // 細長い仮面
  for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;vec3 qe=q-vec3(0.06*sg,0.06,0.08);qe.y+=0.35*qe.x*sg;mk=max(mk,-sEll(qe,vec3(0.036,0.068,0.06)));}   // 目じりの下がった目の穴
  mk=max(mk,-sEll(q-vec3(0.0,-0.16,0.08),vec3(0.032,0.07,0.06)));   // 縦に長くあいた口（泣きさけぶ形）
  mk=max(mk,-sTap(q,vec3(0.03,0.25,0.1),vec3(0.05,0.15,0.11),0.009,0.005));mk=max(mk,-sTap(q,vec3(0.05,0.15,0.11),vec3(0.03,0.1,0.11),0.006,0.003));mk=max(mk,-sTap(q,vec3(-0.12,0.0,0.06),vec3(-0.08,-0.12,0.08),0.008,0.003));   // ひび
  r=U(r,vec2(mk*1.45,18.0));
  for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;r=U(r,vec2((length(q-vec3(0.06*sg,0.05,0.04))-0.026)*1.45,28.0));}}   // 穴の奥で光る目
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;vec3 a=vec3(0.5*sg,0.36,0.18),b=vec3(0.78*sg,0.32,0.36),c=vec3(0.86*sg,0.05,0.46);float rt=smin(sTap(p,a,b,0.09,0.06),sTap(p,b,c,0.06,0.04),0.04);
  for(int k=0;k<3;k++){vec3 f=c+vec3(0.06*sg*(float(k)-1.0),0.0,0.06*(float(k)-1.0)*0.5);rt=smin(rt,sTap(p,c,f+vec3(0.04*sg*(float(k)-1.0),-0.03,0.1),0.04,0.012),0.02);}
  rt=smin(rt,sTap(p,mix(a,b,0.5),mix(a,b,0.5)+vec3(0.05*sg,0.15,-0.05),0.03,0.006),0.02);r=U(r,vec2(rt,19.0));}   // 根の腕と根の指
 {vec3 P0[5];float R0[5];float Hh[5];P0[0]=vec3(-0.25,0.62,0.02);R0[0]=0.26;Hh[0]=0.34;P0[1]=vec3(0.1,0.7,-0.12);R0[1]=0.36;Hh[1]=0.56;P0[2]=vec3(0.38,0.55,0.0);R0[2]=0.21;Hh[2]=0.32;P0[3]=vec3(-0.46,0.42,-0.12);R0[3]=0.12;Hh[3]=0.18;P0[4]=vec3(0.22,0.6,0.28);R0[4]=0.09;Hh[4]=0.14;
  for(int k=0;k<5;k++){vec3 b0=P0[k],t0=b0+vec3(0.03*float(k-2),Hh[k],0.0);float st=sTap(p,b0-vec3(0.0,0.1,0.0),t0,R0[k]*0.3,R0[k]*0.22);r=U(r,vec2(st,20.0));
   vec3 q=p-t0;float cap=max(sEll(q,vec3(R0[k],R0[k]*0.55,R0[k])),-(q.y+0.0));cap=max(cap,-sEll(q-vec3(0.0,-0.02,0.0),vec3(R0[k]*0.85,R0[k]*0.3,R0[k]*0.85)));r=U(r,vec2(cap,k==1?22.0:(k==2?23.0:21.0)));}}   // 菌の森（5本のキノコ）
 {float ms=sEll(p-vec3(0.0,0.6,-0.1),vec3(0.5,0.25,0.45))+0.015*sin(p.x*30.0)*sin(p.z*30.0);ms=max(ms,sEll(p-vec3(0.0,0.34,0.0),vec3(0.62,0.52,0.56)));r=U(r,vec2(ms,24.0));}   // 上をおおうこけ
 for(int k=0;k<9;k++){float a=1.7*float(k);vec3 sp=vec3(0.55*sin(a),0.2+0.06*float(k),0.5*cos(a));r=U(r,vec2(length(p-sp)-0.022,28.0));}   // 体に付いた光る胞子のつぶ

 return r;}
vec2 xmod(vec2 b,vec3 p){return boss(p);}
vec2 xbody(vec3 p){return vec2(1e3,1.0);}
vec4 xcol(vec3 p,vec3 n,float m){float sh=smoothstep(-0.4,0.9,n.y);vec3 h=p-J[2];
 if(m>27.5){return vec4(pow(vec3(0.75,1.0,0.35),vec3(2.2))*1.5,0.9);}
 if(m>23.5){vec3 c=vec3(0.340,0.460,0.200)*(0.74+0.34*sh)*(1.0-0.30+0.30*2.0*fbm(p*30.0));return vec4(pow(c,vec3(2.2)),0.20);}
 if(m>22.5){vec3 c=vec3(0.460,0.320,0.600)*(0.74+0.34*sh)*(1.0-0.10+0.10*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.40);}
 if(m>21.5){vec3 c=vec3(0.75,0.36,0.14)*(0.74+0.34*sh);c=mix(c,vec3(0.95,0.92,0.86),step(0.62,fbm(p*10.0))*step(0.0,n.y));return vec4(pow(c,vec3(2.2)),0.4);}
 if(m>20.5){vec3 c=vec3(0.66,0.16,0.2)*(0.74+0.34*sh);c=mix(c,vec3(0.95,0.92,0.86),step(0.62,fbm(p*11.0))*step(0.0,n.y));return vec4(pow(c,vec3(2.2)),0.4);}
 if(m>19.5){vec3 c=vec3(0.900,0.860,0.760)*(0.74+0.34*sh)*(1.0-0.10+0.10*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.20);}
 if(m>18.5){vec3 c=vec3(0.380,0.280,0.180)*(0.74+0.34*sh)*(1.0-0.25+0.25*2.0*fbm(p*20.0));return vec4(pow(c,vec3(2.2)),0.30);}
 if(m>17.5){float tr=seam(p.x-0.087+0.012*sin(p.y*28.0),0.018)+seam(p.x+0.087+0.012*sin(p.y*31.0+1.0),0.018);tr*=step(p.y,0.47)*step(0.12,p.y);vec3 c=vec3(0.86,0.8,0.66)*(0.72+0.36*sh)*(0.92+0.12*fbm(p*20.0));c=mix(c,vec3(0.18,0.22,0.1),min(1.0,tr)*0.85);c*=0.85+0.15*smoothstep(0.3,0.7,fbm(p*14.0));return vec4(pow(c,vec3(2.2)),0.3);}
 if(m>16.5){vec3 c=vec3(0.340,0.240,0.360)*(0.74+0.34*sh)*(1.0-0.20+0.20*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.50);}
 if(m>15.5){float w=fbm(p*5.0);vec3 c=mix(vec3(0.22,0.16,0.26),vec3(0.38,0.27,0.4),w)*(0.72+0.36*sh);c=mix(c,vec3(0.4,0.5,0.2),smoothstep(0.62,0.72,fbm(p*9.0+2.0)));return vec4(pow(c,vec3(2.2)),0.4);}
 return vec4(1.0);}
