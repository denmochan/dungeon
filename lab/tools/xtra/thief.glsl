// 盗賊（11/28 2D案）：細身・紫のフード（先がたれる）・口元の布・短いマント
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

 r=U(r,armsN(p,0.065,0.055,6.0,7.0,7.0));
 for(int s=0;s<2;s++){vec3 b=s==0?J[4]:J[7],c=s==0?J[5]:J[8];for(int k=0;k<3;k++){vec3 a=mix(b,c,0.25+0.2*float(k));r=U(r,vec2(max(sTap(p,a,a+normalize(c-b)*0.03,0.068,0.068),0.0),8.0));}}   // 前腕に巻いた布
 r=U(r,legsN(p,0.085,4.0,5.0,0.36));
 float ch=sEll(p-J[1]-vec3(0.0,-0.07,0.0),vec3(0.22,0.22,0.16));ch=smin(ch,sEll(p-J[0]-vec3(0.0,0.1,0.0),vec3(0.16,0.15,0.13)),0.1);r=U(r,vec2(ch,16.0));   // 細い胴
 r=U(r,vec2(max(sEll(p-J[0]-vec3(0.0,0.04,0.0),vec3(0.175,0.05,0.145)),abs(p.y-J[0].y-0.04)-0.03),19.0));   // 帯
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;r=U(r,vec2(hbx(p-J[0]-vec3(0.1*sg,-0.03,0.13),vec3(0.05,0.05,0.025))-0.01,19.0));}   // 腰の小物入れ
 {vec3 q=p-J[1]-vec3(0.0,0.08,-0.06);float t=clamp(-q.y/0.55,0.0,1.0);float rad=0.24+0.12*t;float rr=length(q.xz*vec2(1.0,1.2));float an=atan(q.x,-q.z);
  float cp=max(abs(rr-rad)-0.022,max(q.y,-(q.y+0.55-0.12*abs(sin(an*3.0)))));cp=max(cp,abs(an)-1.7);r=U(r,vec2(cp,21.0));}   // 短いマント（すそがぎざぎざ）
 {float hd=sEll(h-vec3(0.0,0.03,-0.02),vec3(0.215,0.24,0.22));hd=max(hd,-sEll(h-vec3(0.0,-0.02,0.12),vec3(0.17,0.19,0.16)));hd=max(hd,-(h.y+0.26));hd=smin(hd,sTap(p,H+vec3(0.0,0.2,-0.1),H+vec3(0.0,0.08,-0.34),0.06,0.015),0.05);
  hd=smin(hd,sEll(p-J[1]-vec3(0.0,0.08,0.0),vec3(0.21,0.07,0.17)),0.06);r=U(r,vec2(hd,22.0));}   // フード（先がうしろへたれる）
 {float mk=max(sEll(h-vec3(0.0,-0.08,0.035),vec3(0.152,0.13,0.15)),-(-0.012-h.y+0.04*abs(h.x)));mk=max(mk,-sEll(h-vec3(0.0,-0.08,0.035),vec3(0.13,0.11,0.128)));r=U(r,vec2(mk,26.0));}   // 口元の布
 
 return r;}
vec2 xmod(vec2 b,vec3 p){return hero(p);}
vec2 xbody(vec3 p){return vec2(1e3,1.0);}
vec4 xcol(vec3 p,vec3 n,float m){float sh=smoothstep(-0.4,0.9,n.y);
 if(m>25.5){vec3 c=vec3(0.380,0.170,0.460)*(0.78+0.3*sh)*(1.0-0.12+0.12*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.25);}
 if(m>23.5){vec3 c=vec3(0.150,0.120,0.140)*(0.78+0.3*sh)*(1.0-0.20+0.20*2.0*fbm(p*40.0));return vec4(pow(c,vec3(2.2)),0.30);}
 if(m>21.5){vec3 c=vec3(0.380,0.170,0.460)*(0.78+0.3*sh)*(1.0-0.12+0.12*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.25);}
 if(m>20.5){vec3 c=vec3(0.360,0.160,0.440)*(0.78+0.3*sh)*(1.0-0.12+0.12*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.30);}
 if(m>18.5){vec3 c=vec3(0.450,0.300,0.170)*(0.78+0.3*sh)*(1.0-0.15+0.15*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.40);}
 if(m>15.5){vec3 c=vec3(0.300,0.240,0.380)*(0.78+0.3*sh)*(1.0-0.15+0.15*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.30);}
 if(m>7.5){vec3 c=vec3(0.400,0.330,0.280)*(0.78+0.3*sh)*(1.0-0.20+0.20*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.20);}
 if(m>6.5){vec3 c=vec3(0.220,0.170,0.270)*(0.78+0.3*sh)*(1.0-0.15+0.15*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.30);}
 if(m>5.5){vec3 c=vec3(0.280,0.220,0.340)*(0.78+0.3*sh)*(1.0-0.15+0.15*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.30);}
 if(m>4.5){vec3 c=vec3(0.160,0.120,0.140)*(0.78+0.3*sh)*(1.0-0.15+0.15*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.30);}
 if(m>3.5){vec3 c=vec3(0.200,0.170,0.250)*(0.78+0.3*sh)*(1.0-0.15+0.15*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.30);}
 if(m>1.5){vec3 c=vec3(0.960,0.780,0.640)*(0.78+0.3*sh)*(1.0-0.04+0.04*2.0*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.20);}
 return vec4(1.0);}
