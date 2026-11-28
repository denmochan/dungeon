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
 vec3 L=vec3(0.0,1.0,0.8);bd=smin(bd,sTap(p,vec3(0.0,0.85,0.45),L,0.22,0.18),0.08);   // 獅子の首
 bd=smin(bd,sEll(p-L,vec3(0.19,0.19,0.2)),0.06);bd=smin(bd,sEll(p-L-vec3(0.0,-0.07,0.2),vec3(0.13,0.1,0.13)),0.05);   // 獅子の頭と鼻づら
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;bd=smin(bd,sEll(p-L-vec3(0.13*sg,0.16,-0.02),vec3(0.055,0.06,0.03)),0.03);}   // 丸い耳
 vec2 r=vec2(bd,15.0);
 r=U(r,vec2(sEll(p-L-vec3(0.0,-0.02,0.32),vec3(0.05,0.03,0.03)),21.0));   // 黒い鼻
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;r=U(r,vec2(length(p-L-vec3(0.09*sg,0.05,0.165))-0.04,22.0));}   // 獅子の目（琥珀）
 float mn=sEll(p-L-vec3(0.0,0.0,-0.08),vec3(0.33,0.34,0.25));mn=max(mn,-(p.z-L.z-0.1+0.3*max(0.0,abs(p.x)-0.0)));for(int k=0;k<10;k++){float a=float(k)*0.628;vec3 c=L+vec3(cos(a)*0.24,sin(a)*0.24,-0.06);mn=smin(mn,sTap(p,c,c+vec3(cos(a)*0.16,sin(a)*0.16-0.04,-0.12),0.08,0.015),0.04);}   // たてがみ
 mn=smin(mn,sEll(p-vec3(0.0,0.82,0.46),vec3(0.3,0.26,0.16)),0.06);mn+=0.025*(fbm(p*10.0)-0.5);r=U(r,vec2(mn,16.0));
 vec3 W=vec3(0.44,1.14,0.52);float wf=sTap(p,vec3(0.2,0.95,0.38),W,0.13,0.1);wf=smin(wf,sEll(p-W,vec3(0.13,0.13,0.15)),0.05);wf=smin(wf,sTap(p,W+vec3(0.0,-0.02,0.08),W+vec3(0.04,-0.05,0.33),0.09,0.045),0.04);   // 狼の首と頭と長い鼻づら
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;wf=smin(wf,sTap(p,W+vec3(0.07*sg,0.1,-0.03),W+vec3(0.1*sg,0.27,-0.07),0.05,0.008),0.02);}r=U(r,vec2(wf,17.0));   // とがった耳
 r=U(r,vec2(length(p-W-vec3(0.04,-0.05,0.37))-0.035,21.0));for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;r=U(r,vec2(length(p-W-vec3(0.06*sg,0.04,0.12))-0.026,23.0));}   // 狼の鼻と黄色い目
 vec3 G=vec3(-0.44,1.17,0.5);float gf=sTap(p,vec3(-0.2,0.95,0.38),G,0.13,0.1);gf=smin(gf,sEll(p-G,vec3(0.14,0.15,0.15)),0.05);gf=smin(gf,sEll(p-G-vec3(0.0,-0.08,0.13),vec3(0.1,0.07,0.08)),0.03);gf=smin(gf,sEll(p-G-vec3(0.0,0.06,0.12),vec3(0.13,0.035,0.05)),0.02);   // 石像の首と頭・あご・けわしい眉
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;vec3 a=G+vec3(0.09*sg,0.1,0.0),b=a+vec3(0.1*sg,0.12,-0.06),c=b+vec3(0.02*sg,0.12,-0.14);gf=smin(gf,min(sTap(p,a,b,0.05,0.035),sTap(p,b,c,0.035,0.006)),0.02);}r=U(r,vec2(gf,18.0));   // 石の角
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;r=U(r,vec2(length(p-G-vec3(0.06*sg,0.02,0.13))-0.027,24.0));}   // 石像の赤い目
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;vec3 w=vec3(p.x*sg-0.18,p.y-1.02,p.z+0.02);float ca=cos(0.6),sa=sin(0.6);w=vec3(ca*w.x-sa*w.z,w.y,sa*w.x+ca*w.z);float cb=cos(0.35),sb=sin(0.35);w=vec3(cb*w.x-sb*w.y,sb*w.x+cb*w.y,w.z);vec2 q=w.xy/1.3;
  vec2 S=vec2(0.0),Wr=vec2(0.36,0.3),T0=vec2(0.92,0.4),T1=vec2(0.98,0.0),T2=vec2(0.76,-0.3),T3=vec2(0.42,-0.38),B0=vec2(0.0,-0.22);
  float m2=min(min(cTri(q,S,Wr,T0),cTri(q,S,T0,T1)),min(cTri(q,S,T1,T2),min(cTri(q,S,T2,T3),cTri(q,S,T3,B0))));m2=min(m2,cTri(q,Wr,T0,T1));
  for(int k=0;k<4;k++){vec2 a=k==0?T0:(k==1?T1:(k==2?T2:T3)),c=k==0?T1:(k==1?T2:(k==2?T3:B0));vec2 mid=(a+c)*0.5,nn=normalize(mid-vec2(0.25,0.0));float rr=length(c-a)*0.5;m2=max(m2,-(length(q-(mid+nn*rr*0.15))-rr*0.9));}
  float wg=max(m2*1.3,abs(w.z)-0.03);vec3 q3=vec3(q*1.3,w.z);float bn=min(sTap(q3,vec3(0.0),vec3(Wr*1.3,0.0),0.055,0.045),sTap(q3,vec3(Wr*1.3,0.0),vec3(T0*1.3,0.0),0.045,0.012));for(int k=1;k<4;k++){vec2 t=k==1?T1:(k==2?T2:T3);bn=min(bn,sTap(q3,vec3(Wr*1.3,0.0),vec3(t*1.3,0.0),0.03,0.01));}wg=min(wg,bn);r=U(r,vec2(wg,19.0));}   // 石の翼（横に広げて上へ）
 float tl=min(sTap(p,vec3(0.0,0.8,-0.55),J[2],0.09,0.08),min(sTap(p,J[2],J[3],0.08,0.07),sTap(p,J[3],J[4],0.07,0.06)));tl=smin(tl,sEll(p-J[4]-vec3(0.0,0.02,-0.06),vec3(0.07,0.06,0.1)),0.03);r=U(r,vec2(tl,20.0));   // 蛇の尾と蛇の頭
 return r;}
vec2 xmod(vec2 b,vec3 p){return chim(p);}
vec2 xbody(vec3 p){return vec2(1e3,15.0);}
vec4 xcol(vec3 p,vec3 n,float m){
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
