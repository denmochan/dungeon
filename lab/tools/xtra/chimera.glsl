// キマイラ（11/28 本人が2D案B：獅子の体＋3つの頭（獅子・狼・石像）＋石の翼＋蛇の尾）。形はまるごと差しかえ
const float XK=0.04;
float cTri(vec2 p,vec2 a,vec2 b,vec2 c){vec2 e0=b-a,e1=c-b,e2=a-c,v0=p-a,v1=p-b,v2=p-c;
 vec2 pq0=v0-e0*clamp(dot(v0,e0)/dot(e0,e0),0.0,1.0),pq1=v1-e1*clamp(dot(v1,e1)/dot(e1,e1),0.0,1.0),pq2=v2-e2*clamp(dot(v2,e2)/dot(e2,e2),0.0,1.0);
 float s=sign(e0.x*e2.y-e0.y*e2.x);vec2 d=min(min(vec2(dot(pq0,pq0),s*(v0.x*e0.y-v0.y*e0.x)),vec2(dot(pq1,pq1),s*(v1.x*e1.y-v1.y*e1.x))),vec2(dot(pq2,pq2),s*(v2.x*e2.y-v2.y*e2.x)));return -sqrt(d.x)*sign(d.y);}
vec2 U(vec2 a,vec2 b){return b.x<a.x?b:a;}
vec2 chim(vec3 p){
 float bd=sEll(p-vec3(0.0,0.72,0.0),vec3(0.36,0.33,0.62));bd=smin(bd,sEll(p-vec3(0.0,0.8,0.4),vec3(0.35,0.35,0.3)),0.12);   // 獅子の胴と厚い胸
 for(int i=0;i<4;i++){vec3 f=i==0?J[5]:i==1?J[6]:i==2?J[7]:J[8];float bk=f.z<J[0].z?1.0:-1.0;vec3 hip=vec3(f.x*1.05,J[0].y-0.02,f.z*0.95),kn=vec3(f.x,0.3,f.z+0.05*bk);
  bd=smin(bd,smin(smin(sTap(p,hip,kn,0.14,0.085),sTap(p,kn,f+vec3(0.0,0.05,0.0),0.08,0.07),0.04),sEll(p-f-vec3(0.0,0.02,0.05),vec3(0.1,0.06,0.11)),0.03),0.06);}   // 太い足と大きな足先
 vec3 L=vec3(0.0,1.02,0.82);bd=smin(bd,sTap(p,vec3(0.0,0.85,0.45),L,0.22,0.18),0.08);   // 獅子の首
 bd=smin(bd,sEll(p-L,vec3(0.2,0.19,0.2)),0.06);bd=smin(bd,sEll(p-L-vec3(0.0,0.08,0.12),vec3(0.17,0.05,0.08)),0.03);   // 獅子の頭・けわしい眉
 bd=smin(bd,sTap(p,L+vec3(0.0,-0.02,0.1),L+vec3(0.0,-0.05,0.34),0.14,0.1),0.04);   // 長い鼻づら（上あご）
 bd=smin(bd,sTap(p,L+vec3(0.0,-0.12,0.08),L+vec3(0.0,-0.24,0.28),0.1,0.07),0.03);   // 開いた下あご
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;bd=smin(bd,sEll(p-L-vec3(0.14*sg,0.17,-0.03),vec3(0.06,0.065,0.03)),0.03);}   // 耳
 vec2 r=vec2(bd,15.0);
 r=U(r,vec2(sEll(p-L-vec3(0.0,0.0,0.41),vec3(0.055,0.035,0.035)),21.0));   // 鼻
 r=U(r,vec2(sEll(p-L-vec3(0.0,-0.14,0.25),vec3(0.07,0.04,0.09)),27.0));   // 口の奥
 {float fg=9.0;for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;fg=min(fg,sTap(p,L+vec3(0.06*sg,-0.08,0.36),L+vec3(0.06*sg,-0.18,0.36),0.025,0.004));fg=min(fg,sTap(p,L+vec3(0.05*sg,-0.25,0.31),L+vec3(0.05*sg,-0.16,0.33),0.022,0.004));}r=U(r,vec2(fg,26.0));}   // 牙
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;r=U(r,vec2(sEll(p-L-vec3(0.09*sg,0.035,0.19),vec3(0.04,0.025,0.02)),22.0));}   // 細い獅子の目
 float mn=sEll(p-L-vec3(0.0,0.0,-0.08),vec3(0.33,0.34,0.25));mn=max(mn,-(p.z-L.z-0.08));for(int k=0;k<14;k++){float a=float(k)*0.4488;vec3 c=L+vec3(cos(a)*0.26,sin(a)*0.26,-0.08);mn=smin(mn,sTap(p,c,c+vec3(cos(a)*0.2,sin(a)*0.2-0.04,-0.2),0.07,0.008),0.03);}   // とがったたてがみ
 mn=smin(mn,sEll(p-vec3(0.0,0.82,0.46),vec3(0.3,0.26,0.16)),0.06);mn+=0.025*(fbm(p*10.0)-0.5);r=U(r,vec2(mn,16.0));
 vec3 W=vec3(0.55,1.38,0.6),Wd=normalize(vec3(0.4,-0.15,1.0));   // 狼の頭（長い首で高く、外を向く）
 float wf=min(sTap(p,vec3(0.2,0.95,0.36),vec3(0.42,1.18,0.44),0.15,0.12),sTap(p,vec3(0.42,1.18,0.44),W,0.12,0.11));for(int k=0;k<6;k++){float a=float(k)*1.05;vec3 c=vec3(0.36,1.12,0.42)+vec3(cos(a)*0.12,sin(a)*0.12,0.0);wf=smin(wf,sTap(p,c,c+vec3(cos(a)*0.08,sin(a)*0.06-0.04,-0.12),0.06,0.01),0.03);}   // 首の毛
 wf=smin(wf,sEll(p-W,vec3(0.16,0.15,0.17)),0.05);wf=smin(wf,sTap(p,W+Wd*0.08+vec3(0.0,-0.01,0.0),W+Wd*0.42+vec3(0.0,-0.03,0.0),0.1,0.05),0.04);wf=smin(wf,sTap(p,W+Wd*0.06+vec3(0.0,-0.1,0.0),W+Wd*0.34+vec3(0.0,-0.2,0.0),0.07,0.04),0.03);   // 頭・長い鼻づら・開いた下あご
 wf=smin(wf,sEll(p-W-Wd*0.12-vec3(0.0,0.08,0.0),vec3(0.14,0.04,0.07)),0.02);for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;wf=smin(wf,sTap(p,W+vec3(0.09*sg,0.11,-0.04),W+vec3(0.12*sg,0.34,-0.12),0.06,0.008),0.02);}r=U(r,vec2(wf,17.0));   // 眉・とがった耳
 r=U(r,vec2(length(p-W-Wd*0.46)-0.04,21.0));r=U(r,vec2(sEll(p-W-Wd*0.26-vec3(0.0,-0.1,0.0),vec3(0.05,0.03,0.08)),27.0));
 {float fg=9.0;for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;vec3 q=W+Wd*0.38+vec3(0.04*sg,-0.06,0.0);fg=min(fg,sTap(p,q,q+vec3(0.0,-0.09,0.0),0.02,0.003));vec3 q2=W+Wd*0.3+vec3(0.04*sg,-0.2,0.0);fg=min(fg,sTap(p,q2,q2+vec3(0.0,0.08,0.0),0.018,0.003));}r=U(r,vec2(fg,26.0));}
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;r=U(r,vec2(sEll(p-W-Wd*0.16-vec3(0.07*sg,0.04,0.0),vec3(0.035,0.02,0.02)),23.0));}   // 狼の黄色い目
 vec3 G=vec3(-0.55,1.4,0.56),Gd=normalize(vec3(-0.4,-0.1,1.0));   // 石像の頭（長い首で高く、反対の外を向く）
 float gf=min(sTap(p,vec3(-0.2,0.95,0.36),vec3(-0.42,1.2,0.42),0.15,0.12),sTap(p,vec3(-0.42,1.2,0.42),G,0.12,0.11));for(int k=0;k<5;k++){float f=float(k)/4.0;vec3 c=mix(vec3(-0.2,1.05,0.2),G+vec3(0.0,0.1,-0.12),f);gf=min(gf,sTap(p,c,c+vec3(0.0,0.12,-0.06),0.045,0.005));}   // 首の石のとげ
 gf=smin(gf,sEll(p-G,vec3(0.16,0.16,0.16)),0.05);gf=smin(gf,sTap(p,G+Gd*0.06,G+Gd*0.3+vec3(0.0,-0.04,0.0),0.11,0.07),0.03);gf=smin(gf,sTap(p,G+Gd*0.05+vec3(0.0,-0.1,0.0),G+Gd*0.26+vec3(0.0,-0.2,0.0),0.08,0.05),0.03);   // 頭・口・開いた下あご
 gf=smin(gf,sEll(p-G-Gd*0.1-vec3(0.0,0.08,0.0),vec3(0.16,0.045,0.07)),0.02);
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;vec3 a=G+vec3(0.1*sg,0.1,-0.02),b=a+vec3(0.14*sg,0.16,-0.08),c=b+vec3(0.0,0.16,-0.2);gf=smin(gf,min(sTap(p,a,b,0.06,0.045),sTap(p,b,c,0.045,0.006)),0.02);}r=U(r,vec2(gf,18.0));   // 大きな石の角
 r=U(r,vec2(sEll(p-G-Gd*0.22-vec3(0.0,-0.1,0.0),vec3(0.05,0.03,0.07)),27.0));
 {float fg=9.0;for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;vec3 q=G+Gd*0.3+vec3(0.05*sg,-0.06,0.0);fg=min(fg,sTap(p,q,q+vec3(0.0,-0.09,0.0),0.022,0.003));}r=U(r,vec2(fg,26.0));}
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;r=U(r,vec2(sEll(p-G-Gd*0.14-vec3(0.07*sg,0.04,0.0),vec3(0.035,0.02,0.02)),24.0));}   // 石像の赤い目
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;vec3 w=vec3(p.x*sg-0.16,p.y-1.08,p.z+0.08);float ca=cos(0.95),sa=sin(0.95);w=vec3(ca*w.x-sa*w.z,w.y,sa*w.x+ca*w.z);float cb=cos(0.6),sb=sin(0.6);w=vec3(cb*w.x+sb*w.y,-sb*w.x+cb*w.y,w.z);vec2 q=w.xy/1.55;
  vec2 S=vec2(0.0),Wr=vec2(0.36,0.3),T0=vec2(0.92,0.4),T1=vec2(0.98,0.0),T2=vec2(0.76,-0.3),T3=vec2(0.42,-0.38),B0=vec2(0.0,-0.22);
  float m2=min(min(cTri(q,S,Wr,T0),cTri(q,S,T0,T1)),min(cTri(q,S,T1,T2),min(cTri(q,S,T2,T3),cTri(q,S,T3,B0))));m2=min(m2,cTri(q,Wr,T0,T1));
  for(int k=0;k<4;k++){vec2 a=k==0?T0:(k==1?T1:(k==2?T2:T3)),c=k==0?T1:(k==1?T2:(k==2?T3:B0));vec2 mid=(a+c)*0.5,nn=normalize(mid-vec2(0.25,0.0));float rr=length(c-a)*0.5;m2=max(m2,-(length(q-(mid+nn*rr*0.15))-rr*0.9));}
  float bend=0.42*q.x*q.x-0.16*q.y+0.1*q.x;float wg=max(m2*1.55,abs(w.z-bend)-0.03);vec3 q3=vec3(q*1.55,w.z-bend);float bn=min(sTap(q3,vec3(0.0),vec3(Wr*1.55,0.0),0.06,0.05),sTap(q3,vec3(Wr*1.55,0.0),vec3(T0*1.55,0.0),0.05,0.012));for(int k=1;k<4;k++){vec2 t=k==1?T1:(k==2?T2:T3);bn=min(bn,sTap(q3,vec3(Wr*1.55,0.0),vec3(t*1.55,0.0),0.035,0.01));}wg=min(wg,bn);r=U(r,vec2(wg,19.0));}   // 石の翼（上へ立て、膜は後ろへそらせて丸み）
 vec3 t0=vec3(0.0,0.8,-0.5),t1=vec3(0.14,0.74,-0.82),t2=vec3(-0.04,0.6,-1.08),t3=vec3(0.1,0.58,-1.3);float tl=min(min(sTap(p,t0,t1,0.1,0.08),sTap(p,t1,t2,0.08,0.06)),sTap(p,t2,t3,0.06,0.05));
 vec3 sh=t3+vec3(0.03,0.04,-0.06);tl=smin(tl,sEll(p-sh,vec3(0.08,0.06,0.11)),0.03);r=U(r,vec2(tl,20.0));for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;r=U(r,vec2(length(p-sh-vec3(0.05*sg,0.03,-0.05))-0.018,24.0));}r=U(r,vec2(sTap(p,sh+vec3(0.0,-0.02,-0.1),sh+vec3(0.0,-0.06,-0.12),0.012,0.003),26.0));   // 蛇の尾と蛇の頭
 return r;}
vec2 xmod(vec2 b,vec3 p){return chim(p);}
vec2 xbody(vec3 p){return vec2(1e3,15.0);}
vec4 xcol(vec3 p,vec3 n,float m){
 if(m>26.5)return vec4(pow(vec3(0.25,0.05,0.05),vec3(2.2)),0.3);   // 口の奥
 if(m>25.5)return vec4(pow(vec3(0.95,0.92,0.82),vec3(2.2)),0.3);   // 牙
 if(m>23.5)return vec4(pow(vec3(1.0,0.2,0.1),vec3(2.2))*2.2,0.5);   // 石像の目
 if(m>22.5)return vec4(pow(vec3(1.0,0.85,0.2),vec3(2.2))*1.8,0.5);   // 狼の目
 if(m>21.5)return vec4(pow(vec3(1.0,0.6,0.1),vec3(2.2))*1.6,0.5);   // 獅子の目
 if(m>20.5)return vec4(pow(vec3(0.08,0.05,0.05),vec3(2.2)),0.7);   // 鼻
 if(m>19.5){vec3 c=mix(vec3(0.26,0.4,0.16),vec3(0.5,0.62,0.3),smoothstep(-0.4,0.6,n.y));c*=0.85+0.25*smoothstep(0.4,0.6,fract(p.z*14.0+0.3*sin(p.x*20.0)));return vec4(pow(c,vec3(2.2)),0.3);}   // 蛇の尾（うろこの縞）
 if(m>18.5){vec3 c=vec3(0.5,0.49,0.47)*(0.75+0.35*fbm(p*7.0));c=mix(c,vec3(0.3,0.3,0.3),smoothstep(0.62,0.7,fbm(p*16.0))*0.6);return vec4(pow(c,vec3(2.2)),0.1);}   // 石（翼・角）
 if(m>17.5){vec3 c=vec3(0.56,0.55,0.52)*(0.78+0.3*fbm(p*9.0));c=mix(c,vec3(0.32,0.32,0.32),smoothstep(0.62,0.7,fbm(p*18.0))*0.6);return vec4(pow(c,vec3(2.2)),0.1);}   // 石像の頭
 if(m>16.5){vec3 c=mix(vec3(0.3,0.3,0.34),vec3(0.62,0.62,0.66),smoothstep(-0.4,0.8,n.y))*(0.8+0.35*fbm(p*vec3(10.0,26.0,10.0)));return vec4(pow(c,vec3(2.2)),0.05);}   // 狼の灰色の毛
 if(m>15.5){vec3 c=mix(vec3(0.36,0.18,0.07),vec3(0.62,0.34,0.12),fbm(p*vec3(8.0,20.0,8.0)));return vec4(pow(c,vec3(2.2)),0.04);}   // たてがみ
 vec3 c=mix(vec3(0.62,0.42,0.2),vec3(0.86,0.66,0.38),smoothstep(-0.4,0.7,n.y))*(0.82+0.28*fbm(p*vec3(9.0,24.0,9.0)));c=mix(c,vec3(0.93,0.82,0.6),smoothstep(0.2,-0.6,n.y)*0.5);return vec4(pow(c,vec3(2.2)),0.05);}   // 獅子の毛
