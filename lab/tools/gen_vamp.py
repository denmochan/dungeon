# 吸血鬼・屍の伯爵（11/28 本人が2D案A「燕尾服の紳士」）。形の式は使わず、ここで全部作る。
# 腕や脚に付く所は材質15未満（skin2 で骨に付く）：1 肌（腰より下は黒いズボン、手は黒い手袋に色が変わる）、2 白（腰より上はシャツ）、4 黒い服、5 黒、6 赤く光る、7 金、13 黒い髪、14 赤
BODY='''const float XK=0.02;
vec2 U(vec2 a,vec2 b){return b.x<a.x?b:a;}
vec2 vamp(vec3 p){vec3 H=J[2];vec3 h=p-H;vec3 e=vec3(abs(h.x),h.y,h.z);
 float hd=sEll(h-vec3(0.0,0.0,0.02),vec3(0.2,0.235,0.21));hd=smin(hd,sEll(h-vec3(0.0,-0.13,0.07),vec3(0.12,0.09,0.12)),0.06);   // 小さな頭と細いあご
 hd=smin(hd,sTap(e,vec3(0.17,0.02,-0.02),vec3(0.31,0.1,-0.08),0.05,0.006),0.02);   // とがった耳
 hd=smin(hd,sTap(h,vec3(0.0,0.02,0.2),vec3(0.0,-0.05,0.25),0.03,0.025),0.02);   // 細い鼻
 float nk=sTap(p,J[1]+vec3(0.0,0.05,0.0),H+vec3(0.0,-0.18,0.0),0.065,0.06);hd=smin(hd,nk,0.04);
 vec2 r=vec2(hd,1.0);
 float hr=sEll(h-vec3(0.0,0.035,-0.02),vec3(0.225,0.255,0.235));float face=max(h.z-0.06,-(h.y-0.07-0.15*abs(h.x)+0.25*max(0.0,0.08-abs(h.x))));hr=max(hr,-face);hr=max(hr,-(h.y+0.08-0.4*max(0.0,-h.z)));hr=max(hr,-(h.y+0.0-0.1*max(0.0,abs(h.x)-0.16)+0.0)+0.0*h.z);   // なでつけた髪（額のとがり）
 r=U(r,vec2(hr,5.0));
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
 // 燕尾
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;vec3 t0=J[0]+vec3(0.1*sg,0.08,-0.1),t1=vec3(0.15*sg,J[0].y*0.42,-0.2);float tl=sTap(p,t0,t1,0.1,0.05);tl=max(tl,abs(dot(p-t0,normalize(vec3(0.0,0.25,-1.0))))-0.025);r=U(r,vec2(tl,4.0));}   // 燕尾服のしっぽ
 // 立てた襟
 {vec3 c=H+vec3(0.0,-0.2,-0.1);vec3 q2=p-c;float rr=length(q2.xz);float hy=clamp(q2.y/0.42,0.0,1.0);float sh=rr-0.27-0.17*hy;float cl=max(abs(sh)-0.018,max(-q2.y,q2.y-0.38-0.14*abs(q2.x)));cl=max(cl,q2.z+0.02-0.45*q2.y);
  r=U(r,vec2(cl,sh<0.0?14.0:4.0));}   // 外は黒・内は赤
'''
END=''' return r;}
vec2 xmod(vec2 b,vec3 p){return vamp(p);}
vec2 xbody(vec3 p){return vec2(1e3,1.0);}
vec4 xcol(vec3 p,vec3 n,float m){return vec4(1.0);}
'''
COUNT=''' {vec3 h2=p-H-vec3(0.0,0.2,-0.02);float hat=max(length(h2.xz*vec2(1.0,1.1))-0.17,abs(h2.y-0.18)-0.2)-0.01;hat=min(hat,max(length(h2.xz*vec2(1.0,1.1))-0.3,abs(h2.y+0.01)-0.016)-0.006);r=U(r,vec2(hat,5.0));   // シルクハット
  float bd=max(abs(length(h2.xz*vec2(1.0,1.1))-0.172)-0.012,abs(h2.y-0.06)-0.04);r=U(r,vec2(bd,14.0));   // 赤い帯
  vec3 nq=p-J[1]-vec3(0.0,0.0,0.19);float nap=max(sEll(nq,vec3(0.15,0.17,0.04)),-(nq.y-0.1+0.4*abs(nq.x)));nap=min(nap,sEll(nq-vec3(0.0,0.11,-0.01),vec3(0.05,0.035,0.03)));for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;nap=min(nap,sEll(nq-vec3(0.06*sg,0.13,-0.02),vec3(0.05,0.03,0.025)));}r=U(r,vec2(nap,2.0));   // 首に結んだナプキン
  vec3 mo2=H+vec3(0.085,0.02,0.215);float mc=max(abs(length((p-mo2).xy)-0.05)-0.01,abs(p.z-mo2.z)-0.01);mc=min(mc,sTap(p,mo2+vec3(0.04,-0.03,0.0),J[1]+vec3(0.14,0.06,0.16),0.005,0.005));r=U(r,vec2(mc,7.0));}   // 金の片めがねと鎖
'''
open('xtra/vampire.glsl','w').write('// 吸血鬼（11/28 本人が2D案A「燕尾服の紳士」）：小さな頭・なでつけた黒髪・とがった耳・つり上がった赤い目、広い肩と細い腰の燕尾服、白いシャツと赤いクラバット、立てた襟（外は黒・内は赤）、細いズボンととがった靴、長いつめ\n'+BODY+END)
open('xtra/count.glsl','w').write('// 屍の伯爵（11/28）：吸血鬼と同じ燕尾服の紳士に、シルクハット・首に結んだナプキン・金の片めがね\n'+BODY+COUNT+END)
print('ok')
