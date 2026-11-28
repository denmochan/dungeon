// 僧侶（11/28 2D案）：白い法衣に金のふちとストール・白い頭巾・金髪
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

 r=U(r,armsN(p,0.068,0.058,6.0,6.0,2.0));
 for(int s=0;s<2;s++){vec3 b=s==0?J[4]:J[7],c=s==0?J[5]:J[8];vec3 d=normalize(c-b);r=U(r,vec2(sTap(p,mix(b,c,0.35),c-d*0.03,0.068,0.09),6.0));r=U(r,vec2(sTap(p,c-d*0.07,c-d*0.045,0.092,0.093),7.0));}   // 広がるそでと金のそで口
 r=U(r,legsN(p,0.085,4.0,5.0,0.3));
 float ch=sEll(p-J[1]-vec3(0.0,-0.06,0.0),vec3(0.23,0.23,0.17));r=U(r,vec2(ch,16.0));
 {vec3 q=p-J[0];float t=clamp((J[1].y-p.y)/J[1].y,0.0,1.0);float rr=length(q.xz*vec2(1.0,1.15));float rb=sEll(p-J[1]-vec3(0.0,-0.06,0.0),vec3(0.23,0.23,0.17));
  float ro=max(rr-(0.2+0.17*t*t),max(p.y-J[1].y,0.03-p.y));ro=smin(ro,rb,0.08);r=U(r,vec2(ro,16.0));}   // 白い法衣
 {vec3 q=p-J[1];float sl=max(hbx(q-vec3(0.0,-0.5,0.19+0.2*max(0.0,-q.y-0.4)),vec3(0.06,0.6,0.02)),q.y-0.05);sl=max(sl,-(p.y-0.05));r=U(r,vec2(sl-0.004,18.0));}   // 前に下がる金のストール
 {vec3 q=p-J[1]-vec3(0.0,-0.22,0.2);float cr=min(hbx(q,vec3(0.012,0.06,0.02)),hbx(q-vec3(0.0,0.02,0.0),vec3(0.045,0.012,0.02)));r=U(r,vec2(cr-0.004,17.0));}   // 白い十字
 r=U(r,vec2(max(sEll(p-J[0]-vec3(0.0,0.08,0.0),vec3(0.205,0.04,0.175)),abs(p.y-J[0].y-0.08)-0.025),18.0));
 {float hd=sEll(h-vec3(0.0,0.03,-0.02),vec3(0.215,0.24,0.22));hd=max(hd,-sEll(h-vec3(0.0,-0.03,0.14),vec3(0.165,0.2,0.16)));hd=max(hd,-(h.y+0.22));
  hd=smin(hd,sEll(p-J[1]-vec3(0.0,0.06,-0.02),vec3(0.25,0.08,0.2)),0.07);r=U(r,vec2(hd,22.0));
  r=U(r,vec2(max(sEll(h-vec3(0.0,0.03,-0.02),vec3(0.222,0.247,0.227)),abs(h.y-0.1+0.25*h.z*0.0)-0.02),23.0));}   // 白い頭巾と金の帯
 {float hr=sEll(h-vec3(0.0,0.08,0.07),vec3(0.17,0.09,0.15));hr=max(hr,-(h.y-0.01));for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;hr=smin(hr,sTap(p,H+vec3(0.12*sg,0.04,0.1),H+vec3(0.14*sg,-0.14,0.1),0.04,0.025),0.03);}r=U(r,vec2(hr,24.0));}   // 金髪（前髪と横の房）

 return r;}
vec2 xmod(vec2 b,vec3 p){return hero(p);}
vec2 xbody(vec3 p){return vec2(1e3,1.0);}
vec4 xcol(vec3 p,vec3 n,float m){float sh=smoothstep(-0.4,0.9,n.y);
 if(m>23.5){vec3 c=vec3(0.950,0.800,0.420)*(0.78+0.3*sh)*(1.0-0.20+0.20*2.0*fbm(p*40.0));return vec4(pow(c,vec3(2.2)),0.35);}
 if(m>22.5){vec3 c=vec3(0.950,0.780,0.320)*(0.55+0.6*sh)+vec3(0.25)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>21.5){vec3 c=vec3(0.960,0.940,0.890)*(0.78+0.3*sh)*(1.0-0.06+0.06*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.20);}
 if(m>17.5){vec3 c=vec3(0.950,0.780,0.320)*(0.55+0.6*sh)+vec3(0.25)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>16.5){vec3 c=vec3(1.000,1.000,0.980)*(0.78+0.3*sh)*(1.0-0.00+0.00*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.30);}
 if(m>15.5){float tr=step(p.y,0.1);vec3 c=mix(vec3(0.95,0.93,0.87),vec3(0.92,0.74,0.3),tr)*(0.8+0.28*sh);return vec4(pow(c,vec3(2.2)),0.2);}
 if(m>6.5){vec3 c=vec3(0.950,0.780,0.320)*(0.55+0.6*sh)+vec3(0.25)*pow(max(0.0,n.y*0.6+n.z*0.5),6.0);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>5.5){vec3 c=vec3(0.950,0.930,0.870)*(0.78+0.3*sh)*(1.0-0.06+0.06*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.20);}
 if(m>4.5){vec3 c=vec3(0.450,0.320,0.200)*(0.78+0.3*sh)*(1.0-0.15+0.15*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.30);}
 if(m>3.5){vec3 c=vec3(0.850,0.820,0.740)*(0.78+0.3*sh)*(1.0-0.15+0.15*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.30);}
 if(m>1.5){vec3 c=vec3(0.960,0.780,0.640)*(0.78+0.3*sh)*(1.0-0.04+0.04*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.20);}
 return vec4(1.0);}
