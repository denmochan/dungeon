// 騎士（11/28 2D案）：全身よろい・青い羽のかぶと・青い前垂れに金の十字
const float XK=0.02;
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
vec2 hero(vec3 p){vec3 H=J[2];vec3 h=p-H;vec3 e=vec3(abs(h.x),h.y,h.z);vec2 r=headN(p);

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

 return r;}
vec2 xmod(vec2 b,vec3 p){return hero(p);}
vec2 xbody(vec3 p){return vec2(1e3,1.0);}
vec4 xcol(vec3 p,vec3 n,float m){float sh=smoothstep(-0.4,0.9,n.y);
 if(m>25.5){vec3 c=vec3(0.040,0.040,0.060)*(0.78+0.3*sh)*(1.0-0.00+0.00*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.10);}
 if(m>24.5){vec3 c=vec3(0.180,0.400,0.900)*(0.78+0.3*sh)*(1.0-0.20+0.20*2.0*fbm(p*30.0));return vec4(pow(c,vec3(2.2)),0.20);}
 if(m>21.5){vec3 c=vec3(0.780,0.810,0.870)*(0.55+0.6*sh)+vec3(0.25)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>20.5){vec3 c=vec3(0.160,0.320,0.720)*(0.78+0.3*sh)*(1.0-0.12+0.12*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.30);}
 if(m>19.5){vec3 c=vec3(0.820,0.850,0.900)*(0.55+0.6*sh)+vec3(0.25)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>17.5){vec3 c=vec3(0.950,0.780,0.320)*(0.55+0.6*sh)+vec3(0.25)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>16.5){vec3 c=vec3(0.950,0.960,1.000)*(0.55+0.6*sh)+vec3(0.25)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>15.5){vec3 c=vec3(0.780,0.810,0.870)*(0.55+0.6*sh)+vec3(0.25)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>8.5){vec3 c=vec3(0.740,0.770,0.830)*(0.55+0.6*sh)+vec3(0.25)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);return vec4(pow(c,vec3(2.2)),0.9);}
 return vec4(1.0);}
