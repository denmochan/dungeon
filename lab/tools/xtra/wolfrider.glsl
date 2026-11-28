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
 vec3 S=J[0]+vec3(0.0,0.24,-0.02);float sd=sEll(p-S,vec3(0.25,0.07,0.32));sd=smin(sd,sEll(p-S-vec3(0.0,0.07,0.22),vec3(0.09,0.09,0.05)),0.03);sd=smin(sd,sEll(p-S-vec3(0.0,0.08,-0.24),vec3(0.2,0.09,0.05)),0.03);   // 鞍（前の突起と後ろの背もたれ）
 sd=min(sd,max(abs(length((p-J[0]).xy)-0.235)-0.018,abs(p.z-J[0].z-0.05)-0.04));r=U(r,vec2(sd,17.0));   // 腹帯
 float bl=max(sEll(p-S-vec3(0.0,-0.03,0.0),vec3(0.34,0.06,0.4)),-(p.y-J[0].y-0.12));bl=max(bl,abs(p.x)-0.3);r=U(r,vec2(bl,23.0));   // 鞍の下の布（ふちが垂れる）
 vec3 B=J[0]+vec3(0.0,0.44,-0.04);mat2 lean=mat2(cos(0.25),-sin(0.25),sin(0.25),cos(0.25));   // 乗り手のこし。上半身は前へかがむ
 vec3 pl=p-B;pl.yz=lean*pl.yz;pl+=B;
 float g=sEll(pl-B-vec3(0.0,0.17,0.02),vec3(0.17,0.21,0.15));   // 胴
 vec3 HC=B+vec3(0.0,0.52,0.2);g=smin(g,sEll(p-HC,vec3(0.22,0.2,0.19)),0.05);g=smin(g,sEll(p-HC-vec3(0.0,0.08,0.13),vec3(0.18,0.045,0.06)),0.02);   // 頭・眉
 g=smin(g,sTap(p,HC+vec3(0.0,0.0,0.17),HC+vec3(0.0,-0.1,0.29),0.05,0.03),0.02);   // かぎ鼻
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;g=smin(g,sTap(p,HC+vec3(0.16*sg,0.02,-0.02),HC+vec3(0.48*sg,0.16,-0.12),0.075,0.008),0.03);   // 横にのびた耳
  g=smin(g,sTap(p,B+vec3(0.1*sg,0.02,0.04),B+vec3(0.28*sg,-0.12,0.16),0.08,0.065),0.03);g=smin(g,sTap(p,B+vec3(0.28*sg,-0.12,0.16),B+vec3(0.27*sg,-0.36,0.08),0.065,0.055),0.03);}   // もも・すね
 vec3 sl=B+vec3(-0.17,0.3,0.12),hl=J[1]+vec3(-0.06,0.06,-0.3),el=mix(sl,hl,0.5)+vec3(-0.06,-0.06,0.0);g=smin(g,sTap(p,sl,el,0.06,0.05),0.03);g=smin(g,sTap(p,el,hl,0.05,0.045),0.02);   // 手綱を持つ左腕
 vec3 sr=B+vec3(0.17,0.3,0.12),er=B+vec3(0.32,0.24,0.18),hr=B+vec3(0.34,0.44,0.34);g=smin(g,sTap(p,sr,er,0.06,0.05),0.03);g=smin(g,sTap(p,er,hr,0.05,0.045),0.02);   // 槍を持つ右腕
 for(int k=0;k<3;k++){float a=(float(k)-1.0)*0.5;g=smin(g,sTap(p,hl+vec3(0.0,0.0,0.0),hl+vec3(0.03*sin(a),-0.05,0.05+0.02*cos(a)),0.025,0.012),0.01);g=smin(g,sTap(p,hr,hr+vec3(0.05*sin(a)-0.03,-0.04,0.03),0.025,0.012),0.01);}   // 指
 r=U(r,vec2(g,21.0));
 float lt=sEll(pl-B-vec3(0.0,0.15,0.03),vec3(0.185,0.2,0.165));lt=max(lt,-(pl.y-B.y-0.3));float lb=max(abs(sEll(pl-B-vec3(0.0,0.05,0.02),vec3(0.19,0.06,0.17)))-0.012,abs(pl.y-B.y-0.05)-0.02);lt=min(lt,lb);   // 革の胴着とベルト
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;vec3 sh=(s==0?sl:sr)+vec3(0.02*sg,0.04,-0.02);lt=min(lt,max(sEll(p-sh,vec3(0.11,0.07,0.1)),-(p.y-sh.y+0.04)));vec3 ec=s==0?el:er;vec3 hh=s==0?hl:hr;lt=min(lt,sTap(p,mix(ec,hh,0.35),mix(ec,hh,0.85),0.058,0.052));   // 肩当て・腕当て
  vec3 kn=B+vec3(0.28*sg,-0.12,0.16);lt=min(lt,sTap(p,kn+vec3(0.0,-0.1,-0.02),B+vec3(0.27*sg,-0.38,0.08),0.075,0.07));lt=min(lt,sEll(p-B-vec3(0.27*sg,-0.4,0.13),vec3(0.07,0.05,0.1)));}   // 長靴
 r=U(r,vec2(lt,17.0));
 float mt=9.0;for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;vec3 sh=(s==0?sl:sr)+vec3(0.02*sg,0.1,-0.02);for(int k=0;k<2;k++){vec3 c=sh+vec3(0.05*sg,0.0,-0.04+0.08*float(k));mt=min(mt,sTap(p,c,c+vec3(0.04*sg,0.08,0.0),0.025,0.004));}
  vec3 st=B+vec3(0.3*sg,-0.44,0.1);mt=min(mt,max(abs(length((p-st).xy)-0.05)-0.012,abs(p.z-st.z)-0.04));mt=min(mt,sTap(p,S+vec3(0.24*sg,0.0,0.05),st+vec3(0.0,0.05,0.0),0.01,0.01));}   // 肩のとげ・あぶみ
 r=U(r,vec2(mt,20.0));
 vec3 N=B+vec3(0.0,0.35,0.11);float sc=max(abs(length((p-N).xz*vec2(1.0,1.1))-0.16)-0.05,abs(p.y-N.y)-0.05);sc=min(sc,sTap(p,N+vec3(0.06,0.0,-0.13),N+vec3(0.2,-0.08,-0.55),0.06,0.035));sc=min(sc,sTap(p,N+vec3(-0.04,0.0,-0.13),N+vec3(-0.12,-0.12,-0.48),0.05,0.03));r=U(r,vec2(sc,18.0));   // 赤い襟巻き（2本なびく）
 float rn=sTap(p,hl,J[1]+vec3(0.0,-0.02,0.2),0.016,0.016);rn=min(rn,sTap(p,hl,J[1]+vec3(0.1,-0.02,0.14),0.016,0.016));r=U(r,vec2(rn,17.0));   // 手綱
 vec3 a0=hr+vec3(-0.03,-0.42,-0.46),a1=hr+vec3(0.05,0.42,0.62);r=U(r,vec2(sTap(p,a0,a1,0.024,0.022),19.0));vec3 dv=normalize(a1-a0);r=U(r,vec2(sTap(p,a1,a1+dv*0.24,0.055,0.004),20.0));
 r=U(r,vec2(max(sTap(p,a1-dv*0.03,a1-dv*0.03+vec3(0.12,0.0,0.0),0.035,0.035),abs((p-a1).y)-0.04),20.0));   // 槍の穂先とつば
 vec3 fp=a1-dv*0.16;r=U(r,vec2(sTap(p,fp,fp+vec3(0.0,-0.18,-0.1),0.05,0.01),18.0));   // 槍の赤い房
 return r;}
vec4 xcol(vec3 p,vec3 n,float m){
 if(m>22.5){vec3 c=vec3(0.55,0.14,0.12)*(0.8+0.3*fbm(p*vec3(10.0,24.0,10.0)));float tr=step(0.85,fract(length(p.xz-J[0].xz)*6.0));c=mix(c,vec3(0.85,0.7,0.3),tr*0.7);return vec4(pow(c,vec3(2.2)),0.03);}   // 鞍の下の赤い布
 if(m>21.5){vec3 c=vec3(0.42,0.27,0.14)*(0.8+0.35*fbm(p*vec3(10.0,24.0,10.0)));return vec4(pow(c,vec3(2.2)),0.03);}
 if(m>20.5){vec3 c=vec3(0.52,0.6,0.22)*(0.82+0.32*fbm(p*5.0))*(0.93+0.12*fbm(p*13.0+7.0));c=mix(c,c*vec3(0.78,0.9,0.62),smoothstep(0.55,0.75,fbm(p*2.4+3.0))*0.6);return vec4(pow(c,vec3(2.2)),0.08);}   // ゴブリンの肌
 if(m>19.5)return vec4(pow(vec3(0.75,0.78,0.85),vec3(2.2)),0.6);   // 槍の穂先
 if(m>18.5)return vec4(pow(vec3(0.42,0.27,0.13)*(0.8+0.3*fbm(p*vec3(4.0,30.0,4.0))),vec3(2.2)),0.1);   // 槍の柄
 if(m>17.5){vec3 c=vec3(0.75,0.14,0.12)*(0.8+0.3*fbm(p*vec3(10.0,20.0,10.0)));return vec4(pow(c,vec3(2.2)),0.05);}   // 赤い襟巻き
 if(m>16.5){vec3 c=mix(vec3(0.24,0.14,0.08),vec3(0.42,0.27,0.15),smoothstep(-0.3,0.8,n.y))*(0.8+0.3*fbm(p*18.0));return vec4(pow(c,vec3(2.2)),0.25);}   // 革
 if(m>15.5)return vec4(vec3(0.015),0.4);

 float belly=smoothstep(0.1,-0.5,n.y)*smoothstep(0.62,0.4,p.y);vec3 sk=pow(vec3(0.56,0.56,0.6),vec3(2.2));vec3 c=mix(sk*0.75,sk*1.35+0.03,belly);c*=0.85+0.3*fbm(p*vec3(6.0,18.0,6.0));return vec4(c,0.05);}
