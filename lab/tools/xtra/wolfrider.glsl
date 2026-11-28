// 狼騎兵（11/28 本人OKの2D案：ゴブリンを大きく、鞍と手綱、槍、赤い襟巻き）。狼は狼と同じ作り込み、乗り手は形の式の小さいゴブリンを消して大きく作り直す
const float XK=0.05;
vec2 U(vec2 a,vec2 b){return b.x<a.x?b:a;}
vec2 xmod(vec2 b,vec3 p){if(b.y>3.5&&b.y<9.5)return vec2(max(b.x,0.05),b.y);   // 形の式の乗り手（小さいゴブリン・槍）は消す
 return vec2(b.x-0.012*fbm(p*16.0),b.y<1.5?15.0:b.y);}
vec2 xbody(vec3 p){float d=sEll(p-J[0]-vec3(0.0,0.02,0.02),vec3(0.2,0.21,0.48));
 float ruff=sEll(p-vec3(0.0,J[0].y+0.08,0.34),vec3(0.25,0.26,0.2))-0.03*fbm(p*12.0);d=smin(d,ruff,0.08);   // 首のたてがみ
 d=smin(d,sEll(p-J[1]-vec3(0.0,-0.06,-0.1),vec3(0.17,0.15,0.17))-0.02*fbm(p*14.0),0.06);   // ほおの毛
 for(int i=0;i<4;i++){vec3 f=i==0?J[5]:i==1?J[6]:i==2?J[7]:J[8];float bk=f.z<J[0].z?1.0:-1.0;vec3 hip=vec3(f.x*0.9,J[0].y-0.02,f.z*0.95),kn=vec3(f.x,0.3,f.z+0.05*bk);
  d=smin(d,sTap(p,hip,kn,0.12,0.07),0.05);d=smin(d,sTap(p,kn,f+vec3(0.0,0.05,0.0),0.065,0.055),0.03);d=smin(d,sEll(p-f-vec3(0.0,0.02,0.04),vec3(0.075,0.05,0.09)),0.03);}   // もも・すね・足
 float tl=min(sTap(p,J[2],J[3],0.11,0.13),sTap(p,J[3],J[4],0.13,0.04))-0.025*fbm(p*12.0);d=smin(d,tl,0.06);   // ふさふさの尾
 vec2 r=vec2(d,15.0);
 r=U(r,vec2(length(p-(J[1]+vec3(0.0,0.0,0.3)))-0.045,16.0));   // 黒い鼻
 vec3 S=J[0]+vec3(0.0,0.24,-0.02);float sd=sEll(p-S,vec3(0.24,0.07,0.3));sd=min(sd,sEll(p-S-vec3(0.0,0.06,-0.2),vec3(0.2,0.08,0.06)));sd=min(sd,max(abs(length((p-J[0]).xy)-0.235)-0.018,abs(p.z-J[0].z-0.05)-0.04));r=U(r,vec2(sd,17.0));   // 鞍と腹帯
 vec3 B=J[0]+vec3(0.0,0.36,-0.02);   // 乗り手のこし
 float g=sEll(p-B-vec3(0.0,0.17,0.02),vec3(0.17,0.21,0.15));   // 胴
 vec3 HC=B+vec3(0.0,0.54,0.08);g=smin(g,sEll(p-HC,vec3(0.23,0.21,0.2)),0.05);   // 大きな頭
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;g=smin(g,sTap(p,HC+vec3(0.17*sg,0.02,-0.02),HC+vec3(0.46*sg,0.14,-0.08),0.07,0.01),0.03);   // 横にのびた耳
  g=smin(g,sTap(p,B+vec3(0.1*sg,0.02,0.04),B+vec3(0.27*sg,-0.12,0.16),0.07,0.06),0.03);g=smin(g,sTap(p,B+vec3(0.27*sg,-0.12,0.16),B+vec3(0.26*sg,-0.36,0.1),0.06,0.05),0.03);}   // もも・すね（またがる）
 g=smin(g,sEll(p-HC-vec3(0.0,-0.04,0.19),vec3(0.06,0.08,0.06)),0.02);   // 鼻
 vec3 sl=B+vec3(-0.17,0.3,0.03),hl=J[1]+vec3(-0.06,0.04,-0.28);g=smin(g,sTap(p,sl,mix(sl,hl,0.5)+vec3(-0.04,-0.05,0.0),0.055,0.045),0.03);g=smin(g,sTap(p,mix(sl,hl,0.5)+vec3(-0.04,-0.05,0.0),hl,0.045,0.04),0.02);   // 手綱を持つ左腕
 vec3 sr=B+vec3(0.17,0.3,0.03),hr=B+vec3(0.33,0.36,0.24);g=smin(g,sTap(p,sr,hr,0.055,0.045),0.03);g=smin(g,length(p-hr)-0.055,0.02);   // 槍を持つ右腕
 r=U(r,vec2(g,21.0));
 vec3 N=B+vec3(0.0,0.37,0.03);float sc=max(abs(length((p-N).xz*vec2(1.0,1.1))-0.17)-0.05,abs(p.y-N.y)-0.05);sc=min(sc,sTap(p,N+vec3(0.06,0.0,-0.14),N+vec3(0.18,-0.12,-0.5),0.06,0.03));r=U(r,vec2(sc,18.0));   // 赤い襟巻き（後ろへなびく）
 float cl=sEll(p-B-vec3(0.0,0.04,0.0),vec3(0.19,0.1,0.16));r=U(r,vec2(cl,22.0));   // 腰布
 float rn=sTap(p,hl,J[1]+vec3(0.0,-0.02,0.2),0.012,0.012);rn=min(rn,sTap(p,hl,J[1]+vec3(0.1,-0.02,0.12),0.012,0.012));r=U(r,vec2(rn,17.0));   // 手綱
 vec3 a0=hr+vec3(-0.02,-0.4,-0.4),a1=hr+vec3(0.04,0.4,0.62);r=U(r,vec2(sTap(p,a0,a1,0.022,0.02),19.0));vec3 dv=normalize(a1-a0);r=U(r,vec2(sTap(p,a1,a1+dv*0.2,0.05,0.004),20.0));   // 槍
 return r;}
vec4 xcol(vec3 p,vec3 n,float m){
 if(m>21.5){vec3 c=vec3(0.42,0.27,0.14)*(0.8+0.35*fbm(p*vec3(10.0,24.0,10.0)));return vec4(pow(c,vec3(2.2)),0.03);}   // 腰布
 if(m>20.5){vec3 c=vec3(0.48,0.62,0.22)*(0.82+0.32*fbm(p*5.0))*(0.93+0.12*fbm(p*13.0+7.0));return vec4(pow(c,vec3(2.2)),0.08);}   // ゴブリンの肌
 if(m>19.5)return vec4(pow(vec3(0.75,0.78,0.85),vec3(2.2)),0.6);   // 槍の穂先
 if(m>18.5)return vec4(pow(vec3(0.42,0.27,0.13)*(0.8+0.3*fbm(p*vec3(4.0,30.0,4.0))),vec3(2.2)),0.1);   // 槍の柄
 if(m>17.5){vec3 c=vec3(0.75,0.14,0.12)*(0.8+0.3*fbm(p*vec3(10.0,20.0,10.0)));return vec4(pow(c,vec3(2.2)),0.05);}   // 赤い襟巻き
 if(m>16.5){vec3 c=vec3(0.36,0.22,0.12)*(0.8+0.3*fbm(p*18.0));return vec4(pow(c,vec3(2.2)),0.25);}   // 革
 if(m>15.5)return vec4(vec3(0.015),0.4);

 float belly=smoothstep(0.1,-0.5,n.y)*smoothstep(0.62,0.4,p.y);vec3 sk=pow(vec3(0.56,0.56,0.6),vec3(2.2));vec3 c=mix(sk*0.75,sk*1.35+0.03,belly);c*=0.85+0.3*fbm(p*vec3(6.0,18.0,6.0));return vec4(c,0.05);}
