# 吸血鬼・屍の伯爵（11/28 本人が2D案A「燕尾服の紳士」）。形の式は使わず、ここで全部作る。
# 腕や脚に付く所は材質15未満（skin2 で骨に付く）：1 肌（腰より下は黒いズボン、手は黒い手袋に色が変わる）、2 白（腰より上はシャツ）、4 黒い服、5 黒、6 赤く光る、7 金、13 黒い髪、14 赤
BODY='''const float XK=0.02;
vec2 U(vec2 a,vec2 b){return b.x<a.x?b:a;}
vec2 vamp(vec3 p){vec3 H=J[2];vec3 h=p-H;vec3 e=vec3(abs(h.x),h.y,h.z);
 float hd=sEll(h-vec3(0.0,0.01,0.01),vec3(0.165,0.212,0.19));hd=smin(hd,sEll(h-vec3(0.0,-0.1,0.05),vec3(0.122,0.125,0.13)),0.08);hd=smin(hd,sEll(h-vec3(0.0,-0.185,0.07),vec3(0.055,0.04,0.045)),0.06);   // 小さな頭と細いあご
 hd=smin(hd,sTap(e,vec3(0.17,0.02,-0.02),vec3(0.31,0.1,-0.08),0.05,0.006),0.02);   // とがった耳
 hd=smin(hd,sTap(h,vec3(0.0,0.03,0.175),vec3(0.0,-0.045,0.215),0.022,0.016),0.02);   // 細い鼻
 float nk=sTap(p,J[1]+vec3(0.0,0.05,-0.02),H+vec3(0.0,-0.16,-0.05),0.062,0.055);hd=smin(hd,nk,0.04);
 vec2 r=vec2(hd,1.0);
 float hr=sEll(h-vec3(0.0,0.03,-0.03),vec3(0.2,0.235,0.232));hr=smin(hr,sEll(h-vec3(0.0,0.1,-0.13),vec3(0.18,0.16,0.22)),0.06);float hl=0.115-0.6*max(0.0,0.06-abs(h.x))-0.3*max(0.0,abs(h.x)-0.11);hr=max(hr,-max(h.y-hl,-0.04-h.z));hr=max(hr,-max(h.y+0.06,-h.z));hr=max(hr,-(h.y+0.2));hr+=0.0035*sin(h.x*62.0+2.0*h.z);hr=smin(hr,sTap(h,vec3(0.02,0.18,0.15),vec3(0.06,0.06,0.2),0.026,0.007),0.02);hr=smin(hr,sTap(h,vec3(0.0,0.17,0.16),vec3(0.03,0.08,0.195),0.018,0.006),0.015);   // なでつけた髪（額のとがり・顔と耳は出す）
 r=U(r,vec2(hr,24.0));   // 後ろへなでつけた銀髪
 float fg=sTap(e,vec3(0.035,-0.13,0.18),vec3(0.035,-0.18,0.18),0.012,0.002);r=U(r,vec2(fg,2.0));   // 牙
 // 体
 vec3 W=J[0]+vec3(0.0,0.12,0.0);float ch=sEll(p-J[1]-vec3(0.0,-0.04,0.0),vec3(0.27,0.22,0.17));ch=smin(ch,sEll(p-W,vec3(0.17,0.14,0.13)),0.12);ch=smin(ch,sEll(p-J[0],vec3(0.18,0.1,0.13)),0.06);   // 広い胸と細い腰
 for(int s=0;s<2;s++){vec3 sh=s==0?J[3]:J[6];float sg=s==0?-1.0:1.0;ch=smin(ch,sEll(p-sh-vec3(-0.04*sg,0.04,0.0),vec3(0.11,0.07,0.1)),0.05);}   // 肩（パッド）
 r=U(r,vec2(ch,4.0));
 vec3 q=p-J[1]-vec3(0.0,-0.02,0.0);float sv=max(sEll(q,vec3(0.275,0.225,0.18)),-sEll(q,vec3(0.25,0.2,0.16)));sv=max(sv,-(q.z-0.04));sv=max(sv,abs(q.x)-(0.02+0.6*max(0.0,q.y+0.05)));r=U(r,vec2(sv-0.005,2.0));   // 胸元の白いシャツ（Vの形）
 float cv=sTap(p,J[1]+vec3(0.0,0.14,0.15),J[1]+vec3(0.0,0.02,0.18),0.04,0.015);r=U(r,vec2(cv,14.0));r=U(r,vec2(length(p-J[1]-vec3(0.0,0.08,0.19))-0.03,6.0));   // 赤いクラバットと宝石
 // 腕
 for(int s=0;s<2;s++){vec3 a=s==0?J[3]:J[6],b=s==0?J[4]:J[7],c=s==0?J[5]:J[8];float ar=min(sTap(p,a,b,0.075,0.062),sTap(p,b,c,0.062,0.052));r=U(r,vec2(ar,4.0));
  float cf=sTap(p,mix(b,c,0.82),mix(b,c,0.97),0.064,0.066);r=U(r,vec2(cf,2.0));   // 白いそで口
  float hn=sEll(p-c-normalize(c-b)*0.05,vec3(0.05,0.065,0.045));for(int k=0;k<3;k++){vec3 d=normalize(c-b);vec3 f=c+d*0.08+vec3(0.02*(float(k)-1.0),0.0,0.0);hn=min(hn,sTap(p,f,f+d*0.09,0.016,0.004));}r=U(r,vec2(hn,1.0));}   // 手と長いつめ
 // 脚
 for(int s=0;s<2;s++){vec3 a=s==0?J[9]:J[12],b=s==0?J[10]:J[13],c=s==0?J[11]:J[14],f=s==0?J[15]:J[16];float lg=min(sTap(p,a,b,0.085,0.068),sTap(p,b,c,0.068,0.055));r=U(r,vec2(lg,1.0));   // 細いズボン
  vec3 ft=vec3(c.x,0.05,c.z);float sh=smin(sTap(p,ft+vec3(0.0,0.06,-0.04),ft+vec3(0.0,0.03,0.2),0.06,0.035),sEll(p-ft-vec3(0.0,0.0,0.02),vec3(0.065,0.05,0.1)),0.03);r=U(r,vec2(sh,5.0));}   // とがった黒い靴

 // ベスト（灰色・ボタン）
 {vec3 q=p-J[1]-vec3(0.0,-0.1,0.0);float vs=max(sEll(q,vec3(0.255,0.23,0.172)),-sEll(q,vec3(0.24,0.21,0.15)));vs=max(vs,-(q.z-0.05));vs=max(vs,abs(q.x)-(0.11-0.25*max(0.0,q.y-0.05)));vs=max(vs,q.y-0.09);r=U(r,vec2(vs-0.004,23.0));
  for(int k=0;k<3;k++)r=U(r,vec2(length(p-J[1]-vec3(0.0,-0.06-0.07*float(k),0.175))-0.016,22.0));}
 // マント（肩から床まで、前は開く。外は黒・内とふちは赤）と、横へ大きく張り出すとがった襟
 {vec3 S=J[1]+vec3(0.0,0.1,-0.04);float top=S.y;vec3 q=p-vec3(0.0,0.0,S.z);float t=clamp((top-p.y)/top,0.0,1.0);float rad=0.32+0.3*t+0.05*t*t+(0.012+0.05*t)*sin(atan(p.x,-(p.z-S.z))*8.0);float rr=length(q.xz*vec2(1.0,1.15));float ang=atan(q.x,-q.z);
  float sh=rr-rad;float cp=max(abs(sh)-0.035,max(p.y-top-0.04*(1.0-abs(ang)/3.14),-(p.y-0.05)));cp=max(cp,abs(ang)-2.35+0.2*t);
  float ed=abs(abs(ang)-2.35+0.2*t);r=U(r,vec2(cp,sh<-0.008||ed<0.08?21.0:20.0));
  for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;r=U(r,vec2(length(p-S-vec3(0.2*sg,-0.06,0.24))-0.035,22.0));}}   // 赤い留め具
 {vec3 c=J[2]+vec3(0.0,-0.22,-0.2);for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;vec3 q=p-c;q.x*=sg;
   vec2 A=vec2(0.1,0.0),B=vec2(0.56,0.36),C=vec2(0.14,0.56);vec2 u=vec2(q.x,q.y);vec2 e0=B-A,e1=C-B,e2=A-C,v0=u-A,v1=u-B,v2=u-C;vec2 pq0=v0-e0*clamp(dot(v0,e0)/dot(e0,e0),0.0,1.0),pq1=v1-e1*clamp(dot(v1,e1)/dot(e1,e1),0.0,1.0),pq2=v2-e2*clamp(dot(v2,e2)/dot(e2,e2),0.0,1.0);float sgn=sign(e0.x*e2.y-e0.y*e2.x);vec2 dd=min(min(vec2(dot(pq0,pq0),sgn*(v0.x*e0.y-v0.y*e0.x)),vec2(dot(pq1,pq1),sgn*(v1.x*e1.y-v1.y*e1.x))),vec2(dot(pq2,pq2),sgn*(v2.x*e2.y-v2.y*e2.x)));float tri=-sqrt(dd.x)*sign(dd.y);
   float bend=0.55*q.x*q.x-0.12*q.y;float cl=max(tri,abs(q.z-bend)-0.03);r=U(r,vec2(cl,q.z-bend>0.0?21.0:20.0));}}   // 横へとがって張り出す襟（前は赤、後ろは黒）
'''
END=''' return r;}
vec2 xmod(vec2 b,vec3 p){return vamp(p);}
vec2 xbody(vec3 p){return vec2(1e3,1.0);}
vec4 xcol(vec3 p,vec3 n,float m){
 if(m>23.5){vec3 hh=p-J[2];float st=0.5+0.5*sin(hh.x*70.0+hh.y*10.0);vec3 c=mix(vec3(0.3,0.33,0.42),vec3(0.86,0.9,0.98),smoothstep(-0.2,0.95,n.y))*(0.7+0.36*st);return vec4(pow(c,vec3(2.2)),0.2);}   // 銀髪（なでつけた筋）
 if(m>22.5){vec3 c=vec3(0.28,0.27,0.3)*(0.8+0.3*fbm(p*vec3(30.0,30.0,30.0)));return vec4(pow(c,vec3(2.2)),0.2);}   // 灰色のベスト
 if(m>21.5)return vec4(pow(vec3(0.85,0.08,0.12),vec3(2.2))*1.3,0.8);   // 赤い留め具・ボタン
 if(m>20.5)return vec4(pow(vec3(0.62,0.05,0.09)*(0.85+0.2*fbm(p*8.0)),vec3(2.2)),0.3);   // 赤い裏地
 if(m>19.5){vec3 c=mix(vec3(0.05,0.045,0.06),vec3(0.24,0.22,0.27),smoothstep(-0.3,0.9,n.y))*(0.85+0.2*fbm(p*vec3(6.0,18.0,6.0)));return vec4(pow(c,vec3(2.2)),0.5);}   // 黒いマント（つや）
 return vec4(1.0);}
'''
COUNT=''' {vec3 h2=p-H-vec3(0.0,0.14,-0.02);h2.yz=vec2(h2.y*0.98+h2.z*0.2,-h2.y*0.2+h2.z*0.98);float hat=max(length(h2.xz*vec2(1.0,1.1))-0.19,abs(h2.y-0.18)-0.2)-0.01;hat=min(hat,max(length(h2.xz*vec2(1.0,1.1))-0.32,abs(h2.y+0.01)-0.016)-0.006);r=U(r,vec2(hat,5.0));   // シルクハット（目深に・前へかたむける）
  float bd=max(abs(length(h2.xz*vec2(1.0,1.1))-0.192)-0.012,abs(h2.y-0.06)-0.04);r=U(r,vec2(bd,14.0));   // 赤い帯
  vec3 nq=p-J[1]-vec3(0.0,0.0,0.19);float nap=max(sEll(nq,vec3(0.15,0.17,0.04)),-(nq.y-0.1+0.4*abs(nq.x)));nap=min(nap,sEll(nq-vec3(0.0,0.11,-0.01),vec3(0.05,0.035,0.03)));for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;nap=min(nap,sEll(nq-vec3(0.06*sg,0.13,-0.02),vec3(0.05,0.03,0.025)));}r=U(r,vec2(nap,2.0));   // 首に結んだナプキン
  vec3 mo2=H+vec3(0.085,0.02,0.215);float mc=max(abs(length((p-mo2).xy)-0.05)-0.01,abs(p.z-mo2.z)-0.01);mc=min(mc,sTap(p,mo2+vec3(0.04,-0.03,0.0),J[1]+vec3(0.14,0.06,0.16),0.005,0.005));r=U(r,vec2(mc,7.0));}   // 金の片めがねと鎖
'''
VHAT=''' {vec3 h3=p-H-vec3(0.0,0.185,-0.02);h3.yz=vec2(h3.y*0.989+h3.z*0.15,-h3.y*0.15+h3.z*0.989);float rr=length(h3.xz*vec2(1.0,0.95));
  float cr=max(rr-0.185+0.06*h3.y,abs(h3.y-0.075)-0.075)-0.012;cr=max(cr,-(sEll(h3-vec3(0.0,0.2,0.0),vec3(0.05,0.06,0.15))));   // 丸い山（上に縦のへこみ）
  float br=max(rr-0.36,abs(h3.y+0.05*smoothstep(0.2,0.37,rr)*(0.4+0.6*smoothstep(-0.1,0.3,h3.z)))-0.013)-0.004;   // 広いつば（前が下がる）
  r=U(r,vec2(min(cr,br),5.0));
  float bd=max(rr-0.192+0.06*h3.y,abs(h3.y-0.03)-0.022)-0.006;r=U(r,vec2(bd,14.0));}   // 赤い帯
'''
open('xtra/vampire.glsl','w').write('// 吸血鬼（11/28 本人が2D案A「燕尾服の紳士」）：小さな頭・なでつけた黒髪・とがった耳・つり上がった赤い目、広い肩と細い腰の燕尾服、白いシャツと赤いクラバット、立てた襟（外は黒・内は赤）、細いズボンととがった靴、長いつめ\n'+BODY+VHAT+END)
open('xtra/count.glsl','w').write('// 屍の伯爵（11/28）：吸血鬼と同じ燕尾服の紳士に、シルクハット・首に結んだナプキン・金の片めがね\n'+BODY+COUNT+END)
print('ok')
