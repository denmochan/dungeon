// 目玉コウモリ（11/28 コウモリの案Bの羽を、大きな目玉の左右につける）。もと：コウモリ（11/28 本人が2D案B：細身・とがった羽・赤い目）：体を細く、頭は小さく、耳は高くとがる。羽は指の骨と、骨のあいだがえぐれたぎざぎざの膜。顔（赤い目・牙）は試し場で絵を貼る
const float XK=0.03;
float sdTri(vec2 p,vec2 a,vec2 b,vec2 c){vec2 e0=b-a,e1=c-b,e2=a-c,v0=p-a,v1=p-b,v2=p-c;
 vec2 pq0=v0-e0*clamp(dot(v0,e0)/dot(e0,e0),0.0,1.0),pq1=v1-e1*clamp(dot(v1,e1)/dot(e1,e1),0.0,1.0),pq2=v2-e2*clamp(dot(v2,e2)/dot(e2,e2),0.0,1.0);
 float s=sign(e0.x*e2.y-e0.y*e2.x);vec2 d=min(min(vec2(dot(pq0,pq0),s*(v0.x*e0.y-v0.y*e0.x)),vec2(dot(pq1,pq1),s*(v1.x*e1.y-v1.y*e1.x))),vec2(dot(pq2,pq2),s*(v2.x*e2.y-v2.y*e2.x)));return -sqrt(d.x)*sign(d.y);}
vec2 batBody(vec3 p){vec3 b=p-J[0];vec3 e=vec3(abs(b.x),b.y,b.z);
 float d=length(b)-0.28;vec2 r=vec2(d,15.0);   // 目玉
 float lid=max(abs(length(b)-0.29)-0.014,-(b.y-0.17-0.12*b.z));lid=max(lid,b.z-0.2);if(lid<r.x)r=vec2(lid,18.0);   // うすい上まぶた（ほとんど目玉が見える）
 d=sTap(e,vec3(0.06,-0.26,-0.02),vec3(0.07,-0.42,0.0),0.035,0.014);if(d<r.x)r=vec2(d,18.0);   // 足
 const float WS=1.3;vec3 w=vec3(e.x-0.25,b.y+0.06,b.z+0.04)/WS;vec2 S=vec2(0.0,0.0),W=vec2(0.36,0.32),T0=vec2(0.92,0.42),T1=vec2(0.98,0.02),T2=vec2(0.76,-0.28),T3=vec2(0.42,-0.36),B0=vec2(0.0,-0.2);
 float m2=min(min(sdTri(w.xy,S,W,T0),sdTri(w.xy,S,T0,T1)),min(sdTri(w.xy,S,T1,T2),min(sdTri(w.xy,S,T2,T3),sdTri(w.xy,S,T3,B0))));
 m2=min(m2,sdTri(w.xy,W,T0,T1));
 for(int k=0;k<4;k++){vec2 a=k==0?T0:(k==1?T1:(k==2?T2:T3)),c=k==0?T1:(k==1?T2:(k==2?T3:B0));vec2 mid=(a+c)*0.5,nrm2=normalize(mid-S*0.2-vec2(0.25,0.0));float rr=length(c-a)*0.5;m2=max(m2,-(length(w.xy-(mid+nrm2*rr*0.12))-rr*0.9));}   // 骨のあいだのえぐれ
 float mem=max(m2,abs(w.z+0.02*w.x)-0.022)*WS;if(mem<r.x)r=vec2(mem,16.0);   // 羽の膜
 float bn=min(sTap(w,vec3(S,0.0),vec3(W,0.0),0.04,0.03),sTap(w,vec3(W,0.0),vec3(T0,0.0),0.028,0.008));
 for(int k=1;k<4;k++){vec2 t=k==1?T1:(k==2?T2:T3);bn=min(bn,sTap(w,vec3(W,0.0),vec3(t,0.0),0.02,0.007));}
 bn=min(bn,sTap(w,vec3(W,0.0),vec3(W+vec2(0.0,0.1),0.0)+vec3(0.0,0.0,0.03),0.03,0.006));   // 親指のつめ
 bn*=WS;if(bn<r.x)r=vec2(bn,17.0);   // 指の骨
 return r;}
vec2 xmod(vec2 b,vec3 p){return batBody(p);}
vec2 xbody(vec3 p){return vec2(1e3,15.0);}
vec4 xcol(vec3 p,vec3 n,float m){vec3 b=p-J[0];
 if(m>17.5){vec3 c=vec3(0.36,0.26,0.42)*(0.8+0.35*fbm(p*14.0));return vec4(pow(c,vec3(2.2)),0.1);}   // まぶたと足
 if(m>16.5)return vec4(pow(vec3(0.42,0.33,0.48),vec3(2.2)),0.1);
 if(m>15.5){vec3 c=vec3(0.3,0.2,0.36)*(0.85+0.25*fbm(p*vec3(14.0,14.0,4.0)));return vec4(pow(c,vec3(2.2)),0.05);}
 vec3 q=normalize(b);float a=acos(clamp(q.z,-1.0,1.0));vec3 c=vec3(0.93,0.9,0.84);
 float vein=smoothstep(0.03,0.0,abs(fbm(vec3(q.xy*6.0,1.0))-0.5))*smoothstep(0.5,1.2,a);c=mix(c,vec3(0.75,0.1,0.1),vein*0.8);   // 白目と血管
 c=mix(c,vec3(0.78,0.1,0.08),1.0-smoothstep(0.42,0.45,a));c=mix(c,vec3(1.0,0.35,0.2),(1.0-smoothstep(0.3,0.42,a))*0.4);c=mix(c,vec3(0.03,0.02,0.02),1.0-smoothstep(0.2,0.23,a));   // 赤い虹彩と黒いひとみ
 c=mix(c,vec3(1.0),1.0-smoothstep(0.05,0.07,length(q.xy-vec2(-0.12,0.14))));return vec4(pow(c,vec3(2.2)),0.5);}
