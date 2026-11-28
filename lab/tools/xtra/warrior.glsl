// 戦士（11/28 2D案）：がっしり・革の胴・毛皮の肩・赤いはちまき・太い素の腕
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

 r=U(r,armsN(p,0.085,0.07,2.0,2.0,2.0));   // 太い素の腕
 for(int s=0;s<2;s++){vec3 b=s==0?J[4]:J[7],c=s==0?J[5]:J[8];r=U(r,vec2(sTap(p,mix(b,c,0.45),mix(b,c,0.92),0.078,0.072),7.0));}   // 革のこて
 r=U(r,legsN(p,0.11,4.0,5.0,0.34));
 float ch=sEll(p-J[1]-vec3(0.0,-0.06,0.0),vec3(0.29,0.24,0.19));ch=smin(ch,sEll(p-J[0]-vec3(0.0,0.1,0.0),vec3(0.22,0.16,0.16)),0.1);r=U(r,vec2(ch,16.0));   // 広い胸の革の胴
 {vec3 q=p-J[0]-vec3(0.0,-0.06,0.0);float sk=max(sEll(q,vec3(0.25,0.2,0.2)),q.y-0.08);sk=max(sk,-(q.y+0.2+0.03*sin(atan(q.x,q.z)*9.0)));r=U(r,vec2(sk,3.0));}   // 腰のすそ（ぎざぎざ）
 r=U(r,vec2(max(sEll(p-J[0]-vec3(0.0,0.03,0.0),vec3(0.235,0.06,0.18)),abs(p.y-J[0].y-0.03)-0.035),19.0));r=U(r,vec2(hbx(p-J[0]-vec3(0.0,0.03,0.18),vec3(0.045,0.04,0.015))-0.008,18.0));   // ベルトと金のバックル
 for(int s=0;s<2;s++){vec3 sh=s==0?J[3]:J[6];float sg=s==0?-1.0:1.0;r=U(r,vec2(sEll(p-sh-vec3(0.0,0.05,0.0),vec3(0.15,0.1,0.14))+0.006*sin(p.x*90.0)*sin(p.z*90.0),20.0));}   // 毛皮の肩
 {float hr=max(sEll(h-vec3(0.0,0.05,-0.02),vec3(0.195,0.19,0.195)),-max(h.y-0.06,-h.z-0.02));hr=max(hr,-(h.y+0.06));hr+=0.006*sin(h.x*70.0)*sin(h.z*50.0);r=U(r,vec2(hr,24.0));}   // 短い茶色の髪
 {float hb=max(abs(length(h.xz*vec2(1.0,1.0)-vec2(0.0,0.0))-0.195)-0.012,abs(h.y-0.07)-0.035);r=U(r,vec2(hb,23.0));
  r=U(r,vec2(sTap(p,H+vec3(-0.12,0.07,-0.17),H+vec3(-0.22,-0.05,-0.28),0.03,0.012),23.0));r=U(r,vec2(sTap(p,H+vec3(-0.1,0.07,-0.18),H+vec3(-0.14,-0.08,-0.3),0.028,0.01),23.0));}   // 赤いはちまき（うしろでたなびく）

 return r;}
vec2 xmod(vec2 b,vec3 p){return hero(p);}
vec2 xbody(vec3 p){return vec2(1e3,1.0);}
vec4 xcol(vec3 p,vec3 n,float m){float sh=smoothstep(-0.4,0.9,n.y);
 if(m>23.5){vec3 c=vec3(0.420,0.250,0.140)*(0.78+0.3*sh)*(1.0-0.25+0.25*2.0*fbm(p*40.0));return vec4(pow(c,vec3(2.2)),0.30);}
 if(m>22.5){vec3 c=vec3(0.820,0.120,0.140)*(0.78+0.3*sh)*(1.0-0.10+0.10*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.30);}
 if(m>19.5){vec3 c=vec3(0.820,0.720,0.560)*(0.78+0.3*sh)*(1.0-0.30+0.30*2.0*fbm(p*30.0));return vec4(pow(c,vec3(2.2)),0.10);}
 if(m>18.5){vec3 c=vec3(0.240,0.150,0.100)*(0.78+0.3*sh)*(1.0-0.15+0.15*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.40);}
 if(m>17.5){vec3 c=vec3(0.950,0.750,0.300)*(0.55+0.6*sh)+vec3(0.25)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>15.5){vec3 c=vec3(0.550,0.360,0.220)*(0.78+0.3*sh)*(1.0-0.22+0.22*2.0*fbm(p*14.0));return vec4(pow(c,vec3(2.2)),0.35);}
 if(m>6.5){vec3 c=vec3(0.450,0.300,0.180)*(0.78+0.3*sh)*(1.0-0.20+0.20*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.30);}
 if(m>4.5){vec3 c=vec3(0.300,0.200,0.130)*(0.78+0.3*sh)*(1.0-0.15+0.15*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.30);}
 if(m>3.5){vec3 c=vec3(0.380,0.270,0.190)*(0.78+0.3*sh)*(1.0-0.15+0.15*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.30);}
 if(m>2.5){vec3 c=vec3(0.500,0.320,0.200)*(0.78+0.3*sh)*(1.0-0.25+0.25*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.20);}
 if(m>1.5){vec3 c=vec3(0.960,0.780,0.640)*(0.78+0.3*sh)*(1.0-0.04+0.04*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.20);}
 return vec4(1.0);}
