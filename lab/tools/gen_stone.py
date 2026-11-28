# 石の3体：ガーゴイル「神殿の石像」・宝物庫の番人「石の宝箱」・城塞ゴーレム「動く城壁」（11/28 本人が2D案から選んだ）
STONE = '''float seam(float x,float w){return 1.0-smoothstep(0.0,w,abs(x));}
vec3 stoneC(vec3 p,vec3 n,vec3 base){vec3 c=base*(0.72+0.36*smoothstep(-0.4,0.9,n.y))*(0.84+0.3*fbm(p*10.0));
 c*=1.0-0.55*seam(fbm(p*6.0)-0.5,0.012)*step(0.5,fbm(p*2.5+4.0));   // ひび
 c=mix(c,vec3(0.3,0.42,0.2)*(0.8+0.3*fbm(p*20.0)),0.75*smoothstep(0.66,0.72,fbm(p*5.0+1.0))*smoothstep(0.3,0.8,n.y));   // こけ
 return c;}
'''
# ---------- ガーゴイル（インプの骨・材質15未満は骨について動く、15以上は胴か頭にかたく付く） ----------
GARG = '''// ガーゴイル（11/28 2D案「神殿の石像」）：うずくまった石の悪魔・広げた石の翼（骨と膜）・角ととがった耳・寄せた眉に赤く光る目・牙の口・3本爪の手足・先のとがった尾・ひびとこけ
const float XK=0.02;
vec2 U(vec2 a,vec2 b){return b.x<a.x?b:a;}
float udTri(vec3 p,vec3 a,vec3 b,vec3 c){vec3 ba=b-a,pa=p-a,cb=c-b,pb=p-b,ac=a-c,pc=p-c,nor=cross(ba,ac);
 return sqrt((sign(dot(cross(ba,nor),pa))+sign(dot(cross(cb,nor),pb))+sign(dot(cross(ac,nor),pc))<2.0)?min(min(dot(ba*clamp(dot(ba,pa)/dot(ba,ba),0.0,1.0)-pa,ba*clamp(dot(ba,pa)/dot(ba,ba),0.0,1.0)-pa),dot(cb*clamp(dot(cb,pb)/dot(cb,cb),0.0,1.0)-pb,cb*clamp(dot(cb,pb)/dot(cb,cb),0.0,1.0)-pb)),dot(ac*clamp(dot(ac,pc)/dot(ac,ac),0.0,1.0)-pc,ac*clamp(dot(ac,pc)/dot(ac,ac),0.0,1.0)-pc)):dot(nor,pa)*dot(nor,pa)/dot(nor,nor));}
''' + STONE + '''
vec2 garg(vec3 p){vec3 H=J[2];vec3 h=p-H;vec3 e=vec3(abs(h.x),h.y,h.z);vec2 r=vec2(1e3,2.0);
 {float hd=sEll(h-vec3(0.0,0.02,-0.02),vec3(0.21,0.2,0.19));hd=smin(hd,sEll(h-vec3(0.0,-0.07,0.13),vec3(0.13,0.1,0.11)),0.06);   // 頭と鼻づら
  hd=max(hd,-sEll(e-vec3(0.075,0.02,0.17),vec3(0.05,0.035,0.05)));hd=max(hd,-sEll(h-vec3(0.0,-0.12,0.2),vec3(0.09,0.025,0.06)));   // 目のくぼみと口
  hd=smin(hd,sTap(p,J[1]+vec3(0.0,0.05,0.0),H+vec3(0.0,-0.12,-0.05),0.1,0.09),0.05);r=U(r,vec2(hd,2.0));
  r=U(r,vec2(sTap(e,vec3(0.02,0.075,0.19),vec3(0.13,0.1,0.15),0.03,0.025),16.0));   // 寄せた眉
  r=U(r,vec2(length(e-vec3(0.075,0.02,0.15))-0.03,25.0));   // 赤く光る目
  for(int k=0;k<4;k++){float x=-0.06+0.04*float(k);r=U(r,vec2(sTap(p,H+vec3(x,-0.1,0.2),H+vec3(x,-0.15,0.205),0.014,0.003),17.0));}   // 牙
  r=U(r,vec2(smin(sTap(e,vec3(0.12,0.14,-0.02),vec3(0.2,0.3,-0.1),0.055,0.035),sTap(e,vec3(0.2,0.3,-0.1),vec3(0.18,0.42,-0.22),0.035,0.006),0.02),16.0));   // 角
  r=U(r,vec2(sTap(e,vec3(0.18,0.02,-0.02),vec3(0.33,0.06,-0.08),0.04,0.006),16.0));}   // とがった耳
 {float ch=sEll(p-J[1]-vec3(0.0,-0.04,0.0),vec3(0.27,0.24,0.21));ch=smin(ch,sEll(p-J[0]-vec3(0.0,0.1,0.02),vec3(0.21,0.17,0.17)),0.1);r=U(r,vec2(ch,2.0));}   // 胸と腹
 for(int s=0;s<2;s++){vec3 a=s==0?J[3]:J[6],b=s==0?J[4]:J[7],c=s==0?J[5]:J[8];vec3 d=normalize(c-b);float ar=smin(sTap(p,a,b,0.1,0.085),sTap(p,b,c,0.085,0.07),0.03);ar=smin(ar,sEll(p-a,vec3(0.11,0.1,0.11)),0.04);r=U(r,vec2(ar,2.0));
  vec3 sd=normalize(cross(d,vec3(0.0,0.0,1.0)));for(int k=0;k<3;k++){vec3 f=c+d*0.04+sd*0.035*(float(k)-1.0);r=U(r,vec2(smin(sTap(p,f,f+d*0.08,0.02,0.016),sTap(p,f+d*0.08,f+d*0.12+vec3(0.0,0.0,0.03),0.016,0.003),0.01),3.0));}}   // 腕と3本の爪
 for(int s=0;s<2;s++){vec3 a=s==0?J[9]:J[12],b=s==0?J[10]:J[13],c=s==0?J[11]:J[14];float lg=smin(sTap(p,a,b,0.115,0.09),sTap(p,b,c,0.085,0.065),0.03);r=U(r,vec2(lg,2.0));
  vec3 ft=vec3(c.x,0.04,c.z);for(int k=0;k<3;k++){float a2=-0.5+0.5*float(k);vec3 f=ft+vec3(0.06*sin(a2),0.0,0.03);r=U(r,vec2(smin(sTap(p,ft,f+vec3(0.08*sin(a2),0.0,0.1),0.04,0.025),sTap(p,f+vec3(0.08*sin(a2),0.0,0.1),f+vec3(0.1*sin(a2),-0.02,0.15),0.02,0.004),0.01),3.0));}}   // 脚と3本の爪
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;vec3 A=J[1]+vec3(0.12*sg,0.1,-0.16),E=J[1]+vec3(0.5*sg,0.5,-0.36),T=J[1]+vec3(0.92*sg,0.32,-0.42),F1=J[1]+vec3(0.88*sg,-0.12,-0.36),F2=J[1]+vec3(0.6*sg,-0.26,-0.26),F3=J[1]+vec3(0.3*sg,-0.2,-0.2);
  float bn=min(sTap(p,A,E,0.05,0.035),sTap(p,E,T,0.035,0.012));bn=min(bn,min(sTap(p,E,F1,0.025,0.01),sTap(p,E,F2,0.025,0.01)));r=U(r,vec2(bn,18.0));   // 翼の骨
  float mb=min(min(udTri(p,A,E,F3),udTri(p,E,F2,F3)),min(udTri(p,E,F1,F2),udTri(p,E,T,F1)))-0.016;mb=max(mb,-(length(p-mix(F1,F2,0.5)-vec3(0.0,-0.1,0.0))-0.16));mb=max(mb,-(length(p-mix(F2,F3,0.5)-vec3(0.0,-0.08,0.0))-0.13));mb=max(mb,-(length(p-mix(T,F1,0.5)-vec3(0.1*sg,-0.06,0.0))-0.15));r=U(r,vec2(mb,19.0));}   // 翼の膜
 {vec3 a=J[0]+vec3(0.0,-0.02,-0.18),b=J[0]+vec3(0.1,-0.3,-0.48),c=J[0]+vec3(0.36,-0.44,-0.58);float tl=smin(sTap(p,a,b,0.07,0.045),sTap(p,b,c,0.045,0.025),0.03);vec3 q=p-c-vec3(0.06,0.0,-0.02);tl=min(tl,max(sEll(q,vec3(0.08,0.02,0.07)),-sEll(q-vec3(-0.06,0.0,0.03),vec3(0.05,0.03,0.05))));r=U(r,vec2(tl,20.0));}   // 先のとがった尾
 return r;}
vec2 xmod(vec2 b,vec3 p){return garg(p);}
vec2 xbody(vec3 p){return vec2(1e3,2.0);}
vec4 xcol(vec3 p,vec3 n,float m){
 if(m>24.5)return vec4(pow(vec3(1.0,0.15,0.1),vec3(2.2))*2.2,0.6);   // 赤く光る目
 vec3 base=vec3(0.6,0.59,0.57);if(m>18.5&&m<19.5)base=vec3(0.46,0.45,0.45);if(m>16.5&&m<17.5||m>2.5&&m<3.5)base=vec3(0.8,0.78,0.72);
 vec3 c=stoneC(p,n,base);if(m<2.5){c*=1.0-0.25*seam(fract((p.y-J[0].y)*9.0)-0.5,0.04)*step(abs(p.x),0.2)*step(0.0,p.z);}   // 腹の筋
 return vec4(pow(c,vec3(2.2)),0.3);}
'''
open('xtra/gargoyle.glsl', 'w').write(GARG)

# ---------- 宝物庫の番人（ミミックの形・ふたの開け閉めをそのまま） ----------
VAULT = '''// 宝物庫の番人（11/28 2D案「石の宝箱」）：石の箱に金の帯・ふたの正面にガーゴイルの顔（赤い目）・ふたの角・箱の横の石の翼・口の中に金貨・石の歯・奥の赤い目
const float XK=0.006;
vec2 xmod(vec2 b,vec3 p){if(b.y>2.5&&b.y<3.5)b.x+=0.08;return b;}   // 舌をしまう（口には金貨）
float hbx(vec3 p,vec3 b){vec3 q=abs(p)-b;return length(max(q,0.0))+min(max(q.x,max(q.y,q.z)),0.0);}
vec2 U(vec2 a,vec2 b){return b.x<a.x?b:a;}
vec3 lidP(vec3 p){vec3 q=p-vec3(0.0,0.48,-0.36);float a=0.15,ca=cos(a),sa=sin(a);return vec3(q.x,ca*q.y-sa*q.z,sa*q.y+ca*q.z);}
''' + STONE + '''
vec2 xbody(vec3 p){vec2 r=vec2(1e3,15.0);vec3 l=lidP(p);
 for(int s=0;s<2;s++){float sx=s==0?-0.33:0.33;float bb=max(hbx(p-vec3(sx,0.24,-0.01),vec3(0.05,0.245,0.385)),-hbx(p-vec3(sx,0.26,-0.01),vec3(0.07,0.22,0.36)));r=U(r,vec2(bb-0.004,15.0));
  float lb=max(hbx(vec3(l.x-sx,l.y-0.095,l.z-0.36),vec3(0.05,0.112,0.375)),-hbx(vec3(l.x-sx,l.y-0.075,l.z-0.36),vec3(0.07,0.112,0.355)));lb=max(lb,-l.y);r=U(r,vec2(lb-0.004,15.0));}   // 金の帯
 {vec3 q=vec3(l.x,l.y-0.1,l.z-0.72);float fc=sEll(q,vec3(0.15,0.1,0.06));for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;fc=smin(fc,sTap(q,vec3(0.02*sg,0.05,0.04),vec3(0.13*sg,0.08,0.03),0.026,0.02),0.02);}r=U(r,vec2(fc,16.0));   // ふたのガーゴイルの顔と眉
  for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;r=U(r,vec2(length(q-vec3(0.06*sg,0.01,0.05))-0.022,17.0));}}   // 顔の赤い目
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;r=U(r,vec2(smin(sTap(l,vec3(0.4*sg,0.18,0.6),vec3(0.5*sg,0.32,0.52),0.06,0.035),sTap(l,vec3(0.5*sg,0.32,0.52),vec3(0.46*sg,0.44,0.4),0.035,0.006),0.02),16.0));   // ふたの角
  vec3 q=p-vec3(0.5*sg,0.3,-0.05);q.x*=sg;float wg=max(abs(q.z+0.1*q.x)-0.03,max(-q.x,max(q.x-0.3,max(q.y-0.25+0.4*q.x,-(q.y+0.15-0.2*q.x)))));wg=max(wg,-(q.y+0.08-0.06*sin(q.x*30.0)));r=U(r,vec2(wg,16.0));}   // 箱の横の石の翼
 for(int k=0;k<7;k++){float fk=float(k);vec3 c=vec3(-0.3+0.1*fk,0.45+0.02*sin(fk*2.0),0.05+0.1*sin(fk*1.7+0.5));r=U(r,vec2(max(length(vec2(c.x,c.z)-vec2(p.x,p.z))-0.05,abs(p.y-c.y)-0.012),18.0));}   // 口の中の金貨
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;r=U(r,vec2(length(p-vec3(0.2*sg,0.47,-0.12))-0.04,17.0));}   // 奥の赤い目
 return r;}
vec4 xcol(vec3 p,vec3 n,float m){float sh=smoothstep(-0.4,0.9,n.y);
 if(m>17.5){vec3 c=vec3(0.98,0.76,0.25)*(0.6+0.55*sh);return vec4(pow(c,vec3(2.2)),0.9);}   // 金貨
 if(m>16.5)return vec4(pow(vec3(1.0,0.2,0.1),vec3(2.2))*2.0,0.6);   // 赤い目
 if(m>15.5)return vec4(pow(stoneC(p,n,vec3(0.56,0.55,0.53)),vec3(2.2)),0.3);   // 顔・角・翼
 if(m>14.5){vec3 c=vec3(0.86,0.66,0.26)*(0.6+0.55*sh)+vec3(0.25)*pow(max(0.0,n.y*0.7+n.z*0.4),8.0);return vec4(pow(c,vec3(2.2)),0.9);}   // 金の帯
 if(m>5.5)return vec4(pow(vec3(1.0,0.2,0.1),vec3(2.2))*2.0,0.6);
 if(m>4.5){vec3 c=vec3(0.86,0.66,0.26)*(0.6+0.55*sh);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>3.5){vec3 an=abs(n);float u=an.y>0.6?p.x:(an.x>an.z?p.z:p.x);float row=floor(p.y*6.0);float sm=max(seam(fract(p.y*6.0)-0.5,0.05)*step(an.y,0.6),seam(fract(u*4.0+0.5*row)-0.5,0.035));vec3 c=stoneC(p,n,vec3(0.62,0.6,0.56))*(1.0-0.4*sm);return vec4(pow(c,vec3(2.2)),0.3);}   // 石積みの箱
 if(m>2.5)return vec4(pow(vec3(0.3,0.08,0.1),vec3(2.2)),0.3);
 return vec4(pow(vec3(0.78,0.76,0.7)*(0.75+0.3*sh),vec3(2.2)),0.3);}   // 石の歯
'''
open('xtra/vaultkeeper.glsl', 'w').write(VAULT)

# ---------- 城塞ゴーレム（ゴーレムの形に足す） ----------
FORT = '''// 城塞ゴーレム（11/28 2D案「動く城壁」）：石積みの体・肩の胸壁・胸の鉄格子の門・明かりのついた窓・肩の旗・背中の飾りの石の翼・関節を縛る縄・光る目
const float XK=0.01;
#define XSKIN 1
vec2 xmod(vec2 b,vec3 p){return b;}
float hbx(vec3 p,vec3 b){vec3 q=abs(p)-b;return length(max(q,0.0))+min(max(q.x,max(q.y,q.z)),0.0);}
vec2 U(vec2 a,vec2 b){return b.x<a.x?b:a;}
float ringAt(vec3 p,vec3 a,vec3 b,float t,float R,float r){vec3 ax=normalize(b-a);vec3 c=mix(a,b,t);vec3 q=p-c;float h=dot(q,ax);float rd=length(q-ax*h);return length(vec2(rd-R,h))-r;}
''' + STONE + '''
vec2 xbody(vec3 p){vec2 r=vec2(1e3,15.0);float rp=9.0;
 for(int s=0;s<2;s++){vec3 a=s==0?J[3]:J[6],b=s==0?J[4]:J[7],c=s==0?J[5]:J[8];rp=min(rp,ringAt(p,a,b,0.85,0.15,0.024));vec3 h=s==0?J[9]:J[12],k=s==0?J[10]:J[13];rp=min(rp,ringAt(p,h,k,0.85,0.15,0.024));}r=U(r,vec2(rp,8.0));   // 縄
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;for(int k=0;k<2;k++){for(int j=0;j<2;j++){vec3 c=vec3(sg*(0.3+0.2*float(k)),1.22,-0.06+0.2*float(j));r=U(r,vec2(hbx(p-c,vec3(0.045,0.05,0.045))-0.008,16.0));}}}   // 肩の胸壁
 {vec3 q=p-vec3(0.0,0.62,0.3);float gate=min(hbx(q-vec3(0.0,-0.04,0.0),vec3(0.1,0.1,0.02)),max(length(q.xy-vec2(0.0,0.06))-0.1,abs(q.z)-0.02));r=U(r,vec2(gate,17.0));   // 門の暗い口
  for(int k=0;k<4;k++){float x=-0.06+0.04*float(k);r=U(r,vec2(sTap(p,vec3(x,0.5,0.33),vec3(x,0.74,0.33),0.01,0.01),18.0));}r=U(r,vec2(sTap(p,vec3(-0.1,0.64,0.33),vec3(0.1,0.64,0.33),0.01,0.01),18.0));
  float ar=max(abs(length(q.xy-vec2(0.0,0.06))-0.125)-0.025,max(abs(q.z-0.01)-0.025,-(q.y-0.06)));ar=min(ar,max(abs(abs(q.x)-0.125)-0.025,max(abs(q.z-0.01)-0.025,abs(q.y+0.03)-0.09)));r=U(r,vec2(ar,16.0));}   // 門と石のアーチ
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;r=U(r,vec2(hbx(p-vec3(0.24*sg,0.9,0.32),vec3(0.03,0.045,0.02)),19.0));}   // 明かりのついた窓
 r=U(r,vec2(sTap(p,vec3(-0.45,1.2,-0.06),vec3(-0.45,1.75,-0.06),0.012,0.012),20.0));r=U(r,vec2(hbx(p-vec3(-0.38,1.68,-0.06)-vec3(0.0,0.0,0.0),vec3(0.07,0.05,0.006)),21.0));   // 旗
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;vec3 q=p-vec3(0.2*sg,1.0,-0.22);q.x*=sg;float wg=max(abs(q.z+0.25*q.x)-0.03,max(-q.x,max(q.x-0.55,max(q.y-0.15-0.5*q.x+0.6*max(0.0,q.x-0.35),-(q.y+0.3-0.3*q.x)))));wg=max(wg,-(q.y+0.25-0.3*q.x-0.06*sin(q.x*25.0)));r=U(r,vec2(wg,16.0));}   // 背中の飾りの石の翼
 return r;}
vec4 xskin(vec3 p,vec3 n,float m){vec3 an=abs(n);float u=an.y>0.6?p.x:(an.x>an.z?p.z:p.x);float row=floor(p.y*5.0);
 float sm=max(seam(fract(p.y*5.0)-0.5,0.05)*step(an.y,0.6),seam(fract(u*4.0+0.5*row)-0.5,0.035));vec3 c=stoneC(p,n,vec3(0.55,0.52,0.47))*(1.0-0.45*sm);return vec4(pow(c,vec3(2.2)),0.3);}
vec4 xcol(vec3 p,vec3 n,float m){float sh=smoothstep(-0.4,0.9,n.y);
 if(m>20.5)return vec4(pow(vec3(0.78,0.12,0.14)*(0.8+0.3*sh),vec3(2.2)),0.3);   // 旗の布
 if(m>19.5)return vec4(pow(vec3(0.4,0.28,0.16)*(0.8+0.3*sh),vec3(2.2)),0.3);   // 旗ざお
 if(m>18.5)return vec4(pow(vec3(1.0,0.8,0.35),vec3(2.2))*1.8,0.6);   // 窓の明かり
 if(m>17.5)return vec4(pow(vec3(0.3,0.3,0.34)*(0.6+0.5*sh),vec3(2.2)),0.8);   // 鉄格子
 if(m>16.5)return vec4(pow(vec3(0.05,0.03,0.03),vec3(2.2)),0.1);   // 門の奥
 if(m>15.5)return vec4(pow(stoneC(p,n,vec3(0.6,0.57,0.52)),vec3(2.2)),0.3);   // 胸壁・アーチ・翼
 vec3 c=vec3(0.72,0.58,0.36)*(0.74+0.34*sh)*(0.85+0.2*sin(dot(p,vec3(60.0,60.0,0.0))));return vec4(pow(c,vec3(2.2)),0.2);}   // 縄
'''
open('xtra/fortgolem.glsl', 'w').write(FORT)
print('ok')
