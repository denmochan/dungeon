// 骨の番兵（11/28）：スケルトンの足し形に、石の肩当て・胸の石板・石のかぶと、光るルーン。盾は試し場の monTool で大きな石の盾
const float XK=0.03;
vec2 U(vec2 a,vec2 b){return b.x<a.x?b:a;}
vec2 xmod(vec2 b,vec3 p){if(b.y>2.5&&b.y<3.5)b.x=max(b.x,0.04);return b;}   // ゴムの輪のような腰布は消す
vec2 xbody(vec3 p){ vec3 H=J[2];float d=9.0;
 for(int k=0;k<7;k++){float f=float(k)/6.0;vec3 c=mix(J[0]+vec3(0.0,0.06,-0.12),J[1]+vec3(0.0,0.2,-0.2),f);d=min(d,sEll(p-c,vec3(0.045,0.03,0.04)));d=min(d,sTap(p,c+vec3(0.0,0.0,-0.03),c+vec3(0.0,-0.03,-0.09),0.022,0.008));}   // 背骨のとげ
 d=min(d,sEll(p-H-vec3(0.0,-0.06,-0.33),vec3(0.16,0.12,0.06)));for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;d=min(d,sEll(p-H-vec3(0.2*sg,-0.1,0.18),vec3(0.06,0.04,0.07)));}   // 後頭部のでっぱり・ほお骨
 d=min(d,sEll(p-H-vec3(0.0,0.12,0.27),vec3(0.24,0.05,0.07)));   // 眉の骨
 vec2 r=vec2(d,15.0);
 float bt=max(abs(length((p-J[0]-vec3(0.0,0.06,0.0)).xz*vec2(1.0,1.2))-0.17)-0.02,abs(p.y-J[0].y-0.06)-0.035);r=U(r,vec2(bt,17.0));   // 縄のベルト
 float cl=9.0;for(int k=0;k<6;k++){float a=float(k)*1.047+0.3;vec3 c=J[0]+vec3(sin(a)*0.17,0.03,cos(a)*0.15);float L=0.2+0.1*fract(float(k)*0.618);vec3 e=c+vec3(sin(a)*0.05,-L,cos(a)*0.04);cl=min(cl,max(sTap(p,c,e,0.065,0.045),abs(dot(p-c,normalize(vec3(sin(a),0.0,cos(a)))))-0.012));}r=U(r,vec2(cl,16.0));   // ぼろ布の腰巻き（たれた切れはし）
 {float st=9.0;for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;vec3 sh=(s==0?J[3]:J[6])+vec3(0.05*sg,0.08,0.0);vec3 q=p-sh;float b=9.0;for(int k=0;k<3;k++){vec3 qk=q-vec3(sg*0.05*float(k),-0.07*float(k),0.0);float pl=max(abs(sEll(qk,vec3(0.17-0.02*float(k),0.13,0.18-0.02*float(k))))-0.025,-(qk.y+0.02-0.4*sg*qk.x));b=min(b,pl);}st=min(st,b);}   // 石の肩当て
  vec3 q=p-J[1]-vec3(0.0,0.04,0.16);float cp=max(max(abs(q.x)*0.7+abs(q.y)*0.5,abs(q.y)*0.9),abs(q.z))-0.15;cp=max(cp,-(p.z-J[1].z-0.1));st=min(st,cp);   // 胸の石板
  vec3 hq=p-J[2]-vec3(0.0,0.04,0.0);float hm=abs(sEll(hq,vec3(0.4,0.42,0.38)))-0.03;hm=max(hm,-(hq.y-0.02+0.25*max(0.0,hq.z)));hm=min(hm,max(sEll(hq-vec3(0.0,0.0,0.36),vec3(0.035,0.2,0.04)),-(hq.y+0.08)));hm=min(hm,max(abs(hq.x)-0.045,max(abs(sEll(hq,vec3(0.43,0.47,0.41)))-0.02,-(hq.y-0.1))));st=min(st,hm);   // 頭にぴったりの石のかぶと（鼻あて・まん中のとさか）   // 石のかぶととたてがみ
  st+=0.012*(fbm(p*14.0)-0.5);r=U(r,vec2(st,19.0));
  float rn=9.0;for(int k=0;k<3;k++){vec3 c=J[1]+vec3(-0.06+0.06*float(k),0.06-0.05*float(k),0.31);rn=min(rn,length(p-c)-0.022);}r=U(r,vec2(rn,22.0));}   // 光るルーン
 return r;}
vec4 xcol(vec3 p,vec3 n,float m){
 if(m>21.5&&m<22.5)return vec4(pow(vec3(0.4,0.9,0.8),vec3(2.2))*2.2,0.2);   // ルーン
 if(m>18.5&&m<19.5){vec3 c=vec3(0.48,0.47,0.45)*(0.72+0.4*fbm(p*7.0));c=mix(c,vec3(0.28,0.28,0.28),smoothstep(0.62,0.7,fbm(p*16.0))*0.6);c=mix(c,vec3(0.3,0.42,0.22),smoothstep(0.68,0.75,fbm(p*5.0+3.0))*0.6);return vec4(pow(c,vec3(2.2)),0.1);}   // 石（苔）
 if(m>16.5&&m<17.5)return vec4(pow(vec3(0.42,0.32,0.18)*(0.8+0.3*fbm(p*30.0)),vec3(2.2)),0.1);   // 縄
 if(m>15.5&&m<16.5){vec3 c=vec3(0.3,0.32,0.3)*(0.75+0.35*fbm(p*vec3(14.0,30.0,14.0)));return vec4(pow(c,vec3(2.2)),0.03);}   // ぼろ布
 if(m>14.5&&m<15.5){vec3 c=vec3(0.8,0.8,0.74)*(0.82+0.25*fbm(p*14.0));return vec4(pow(c,vec3(2.2)),0.1);}   // 骨
 return vec4(1.0);}
