// ガーゴイル（11/28 2D案「神殿の石像」）：うずくまった石の悪魔・広げた石の翼（骨と膜）・角ととがった耳・寄せた眉に赤く光る目・牙の口・3本爪の手足・先のとがった尾・ひびとこけ
const float XK=0.02;
vec2 U(vec2 a,vec2 b){return b.x<a.x?b:a;}
float udTri(vec3 p,vec3 a,vec3 b,vec3 c){vec3 ba=b-a,pa=p-a,cb=c-b,pb=p-b,ac=a-c,pc=p-c,nor=cross(ba,ac);
 return sqrt((sign(dot(cross(ba,nor),pa))+sign(dot(cross(cb,nor),pb))+sign(dot(cross(ac,nor),pc))<2.0)?min(min(dot(ba*clamp(dot(ba,pa)/dot(ba,ba),0.0,1.0)-pa,ba*clamp(dot(ba,pa)/dot(ba,ba),0.0,1.0)-pa),dot(cb*clamp(dot(cb,pb)/dot(cb,cb),0.0,1.0)-pb,cb*clamp(dot(cb,pb)/dot(cb,cb),0.0,1.0)-pb)),dot(ac*clamp(dot(ac,pc)/dot(ac,ac),0.0,1.0)-pc,ac*clamp(dot(ac,pc)/dot(ac,ac),0.0,1.0)-pc)):dot(nor,pa)*dot(nor,pa)/dot(nor,nor));}
float seam(float x,float w){return 1.0-smoothstep(0.0,w,abs(x));}
vec3 stoneC(vec3 p,vec3 n,vec3 base){vec3 c=base*(0.72+0.36*smoothstep(-0.4,0.9,n.y))*(0.84+0.3*fbm(p*10.0));
 c*=1.0-0.55*seam(fbm(p*6.0)-0.5,0.012)*step(0.5,fbm(p*2.5+4.0));   // ひび
 c=mix(c,vec3(0.3,0.42,0.2)*(0.8+0.3*fbm(p*20.0)),0.75*smoothstep(0.66,0.72,fbm(p*5.0+1.0))*smoothstep(0.3,0.8,n.y));   // こけ
 return c;}

float hbx(vec3 p,vec3 b){vec3 q=abs(p)-b;return length(max(q,0.0))+min(max(q.x,max(q.y,q.z)),0.0);}
vec2 garg(vec3 p){vec3 H=J[2];vec3 h=p-H;vec3 e=vec3(abs(h.x),h.y,h.z);vec2 r=vec2(1e3,2.0);
 {float pd=hbx(p-vec3(0.0,0.07,0.02),vec3(0.44,0.07,0.4))-0.01;pd=min(pd,hbx(p-vec3(0.0,0.17,0.02),vec3(0.39,0.035,0.35))-0.008);r=U(r,vec2(pd,21.0));}   // 台座（二段）
 {float hd=sEll(h-vec3(0.0,0.02,-0.03),vec3(0.17,0.16,0.17));hd=smin(hd,sTap(h,vec3(0.0,-0.02,0.04),vec3(0.0,-0.06,0.22),0.11,0.065),0.05);   // 頭と長い鼻づら
  hd=smin(hd,sEll(e-vec3(0.09,-0.09,0.05),vec3(0.07,0.06,0.08)),0.04);hd=max(hd,-sEll(h-vec3(0.0,-0.12,0.2),vec3(0.05,0.018,0.06)));   // あごと口
  hd=smin(hd,sTap(p,J[1]+vec3(0.0,0.08,0.02),H+vec3(0.0,-0.08,-0.06),0.12,0.09),0.05);r=U(r,vec2(hd,2.0));
  r=U(r,vec2(sTap(e,vec3(0.02,0.07,0.13),vec3(0.11,0.09,0.09),0.028,0.022),16.0));   // 眉
  r=U(r,vec2(length(e-vec3(0.07,0.035,0.12))-0.025,25.0));   // 赤く光る目
  for(int k=0;k<2;k++){float sg=k==0?-1.0:1.0;r=U(r,vec2(sTap(p,H+vec3(0.03*sg,-0.1,0.19),H+vec3(0.03*sg,-0.15,0.19),0.012,0.003),17.0));}   // 牙
  r=U(r,vec2(smin(sTap(e,vec3(0.07,0.12,-0.04),vec3(0.12,0.3,-0.1),0.04,0.022),sTap(e,vec3(0.12,0.3,-0.1),vec3(0.1,0.42,-0.18),0.022,0.004),0.015),16.0));   // 角
  r=U(r,vec2(sTap(e,vec3(0.13,0.06,-0.05),vec3(0.26,0.22,-0.1),0.045,0.008),16.0));}   // 長い耳
 {vec3 a=J[0],b=J[1];float ch=smin(sTap(p,a+vec3(0.0,0.02,0.0),b,0.25,0.22),sEll(p-mix(a,b,0.45)-vec3(0.0,0.0,0.06),vec3(0.24,0.22,0.2)),0.06);ch=smin(ch,sEll(p-b-vec3(0.0,0.02,-0.06),vec3(0.27,0.18,0.2)),0.06);r=U(r,vec2(ch,2.0));}   // 丸い胴と肩
 for(int s=0;s<2;s++){vec3 a=s==0?J[3]:J[6],b=s==0?J[4]:J[7],c=s==0?J[5]:J[8];vec3 d=normalize(c-b);float ar=smin(sTap(p,a,b,0.095,0.075),sTap(p,b,c,0.075,0.065),0.03);ar=smin(ar,sEll(p-a,vec3(0.11,0.1,0.11)),0.04);r=U(r,vec2(ar,2.0));
  for(int k=0;k<3;k++){vec3 f=vec3(c.x+0.035*(float(k)-1.0),0.245,c.z+0.02);r=U(r,vec2(smin(sTap(p,vec3(c.x,0.28,c.z-0.02),f+vec3(0.0,0.0,0.06),0.04,0.025),sTap(p,f+vec3(0.0,0.0,0.06),f+vec3(0.0,-0.01,0.1),0.022,0.004),0.01),3.0));}}   // 前脚と、台座をつかむ爪
 for(int s=0;s<2;s++){vec3 a=s==0?J[9]:J[12],b=s==0?J[10]:J[13],c=s==0?J[11]:J[14];float lg=smin(sTap(p,a,b,0.13,0.1),sTap(p,b,c,0.09,0.065),0.03);lg=smin(lg,sEll(p-mix(a,b,0.5),vec3(0.13,0.12,0.15)),0.04);r=U(r,vec2(lg,2.0));
  vec3 ft=vec3(c.x,0.25,c.z);for(int k=0;k<3;k++){float a2=-0.5+0.5*float(k);r=U(r,vec2(smin(sTap(p,ft,ft+vec3(0.06*sin(a2),0.0,0.14),0.045,0.03),sTap(p,ft+vec3(0.06*sin(a2),0.0,0.14),ft+vec3(0.08*sin(a2),-0.015,0.19),0.025,0.004),0.01),3.0));}}   // たたんだ後ろ脚と爪
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;vec3 B=J[1];vec3 A=B+vec3(0.1*sg,0.04,-0.16),E=B+vec3(0.3*sg,0.42,-0.22),T=B+vec3(0.55*sg,0.66,-0.2),F1=B+vec3(0.74*sg,0.42,-0.2),F2=B+vec3(0.7*sg,0.12,-0.2),F3=B+vec3(0.44*sg,-0.02,-0.2);
  float bn=min(sTap(p,A,E,0.05,0.035),sTap(p,E,T,0.035,0.012));bn=min(bn,min(sTap(p,E,F1,0.025,0.01),sTap(p,E,F2,0.025,0.01)));r=U(r,vec2(bn,18.0));
  float mb=min(min(udTri(p,A,E,F3),udTri(p,E,F2,F3)),min(udTri(p,E,F1,F2),udTri(p,E,T,F1)))-0.016;
  mb=max(mb,-(length(p-mix(F1,F2,0.5)-vec3(0.1*sg,0.0,0.0))-0.12));mb=max(mb,-(length(p-mix(F2,F3,0.5)-vec3(0.05*sg,-0.08,0.0))-0.11));mb=max(mb,-(length(p-mix(T,F1,0.5)-vec3(0.1*sg,0.06,0.0))-0.1));r=U(r,vec2(mb,19.0));}   // 上へ立てた翼（すそを弧に切る）
 {vec3 a=J[0]+vec3(0.0,-0.04,-0.2),b=vec3(0.3,0.24,-0.3),c=vec3(0.36,0.23,0.08);float tl=smin(sTap(p,a,b,0.06,0.045),sTap(p,b,c,0.045,0.025),0.03);vec3 q=p-c-vec3(0.0,0.0,0.05);tl=min(tl,max(sEll(q,vec3(0.06,0.02,0.07)),-sEll(q-vec3(0.0,0.0,-0.05),vec3(0.04,0.03,0.04))));r=U(r,vec2(tl,20.0));}   // 台座の上にまわした尾
 return r;}
vec2 xmod(vec2 b,vec3 p){return garg(p);}
vec2 xbody(vec3 p){return vec2(1e3,2.0);}
vec4 xcol(vec3 p,vec3 n,float m){
 if(m>24.5)return vec4(pow(vec3(1.0,0.15,0.1),vec3(2.2))*2.2,0.6);   // 赤く光る目
 vec3 base=vec3(0.66,0.65,0.72);if(m>18.5&&m<19.5)base=vec3(0.6,0.59,0.66);if(m>20.5)base=vec3(0.58,0.57,0.62);if(m>16.5&&m<17.5||m>2.5&&m<3.5)base=vec3(0.82,0.8,0.82);
 vec3 c=stoneC(p,n,base);c*=0.85+0.25*smoothstep(0.35,0.65,fbm(p*4.0+7.0));   // 腹の筋
 return vec4(pow(c,vec3(2.2)),0.3);}
