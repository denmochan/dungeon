// リッチ（11/28）：スケルトンの足し形（ローブで隠れる）。頭蓋骨はフードの影で暗く、目だけ緑に光る
const float XK=0.03;
vec2 U(vec2 a,vec2 b){return b.x<a.x?b:a;}
vec3 sockGlow(vec3 p,vec3 col,float k){vec3 h=p-J[2];vec3 e=vec3(abs(h.x),h.y,h.z);float d=length((e-vec3(0.14,0.0,0.26))*vec3(1.0,1.0,0.6));return col*k*(1.0-smoothstep(0.06,0.11,d));}
#define XSKIN 1
vec4 xskin(vec3 p,vec3 n,float m){vec3 c=vec3(0.32,0.3,0.26)*(0.75+0.3*fbm(p*12.0));float hd=1.0-smoothstep(0.3,0.5,length(p-J[2]));c*=mix(1.0,0.35,hd);c+=sockGlow(p,vec3(0.4,1.0,0.5),3.0);return vec4(pow(c,vec3(2.2)),0.05);}   // フードの中は暗く、目だけ緑に光る
vec2 xmod(vec2 b,vec3 p){if(b.y>2.5&&b.y<3.5)b.x=max(b.x,0.04);return b;}   // ゴムの輪のような腰布は消す
vec2 xbody(vec3 p){ vec3 H=J[2];float d=9.0;
 for(int k=0;k<7;k++){float f=float(k)/6.0;vec3 c=mix(J[0]+vec3(0.0,0.06,-0.12),J[1]+vec3(0.0,0.2,-0.2),f);d=min(d,sEll(p-c,vec3(0.045,0.03,0.04)));d=min(d,sTap(p,c+vec3(0.0,0.0,-0.03),c+vec3(0.0,-0.03,-0.09),0.022,0.008));}   // 背骨のとげ
 d=min(d,sEll(p-H-vec3(0.0,-0.06,-0.33),vec3(0.16,0.12,0.06)));for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;d=min(d,sEll(p-H-vec3(0.2*sg,-0.1,0.18),vec3(0.06,0.04,0.07)));}   // 後頭部のでっぱり・ほお骨
 d=min(d,sEll(p-H-vec3(0.0,0.12,0.27),vec3(0.24,0.05,0.07)));   // 眉の骨
 vec2 r=vec2(d,15.0);
 float bt=max(abs(length((p-J[0]-vec3(0.0,0.06,0.0)).xz*vec2(1.0,1.2))-0.17)-0.02,abs(p.y-J[0].y-0.06)-0.035);r=U(r,vec2(bt,17.0));   // 縄のベルト
 float cl=9.0;for(int k=0;k<6;k++){float a=float(k)*1.047+0.3;vec3 c=J[0]+vec3(sin(a)*0.17,0.03,cos(a)*0.15);float L=0.2+0.1*fract(float(k)*0.618);vec3 e=c+vec3(sin(a)*0.05,-L,cos(a)*0.04);cl=min(cl,max(sTap(p,c,e,0.065,0.045),abs(dot(p-c,normalize(vec3(sin(a),0.0,cos(a)))))-0.012));}r=U(r,vec2(cl,16.0));   // ぼろ布の腰巻き（たれた切れはし）
 return r;}
vec4 xcol(vec3 p,vec3 n,float m){
 if(m>16.5&&m<17.5)return vec4(pow(vec3(0.42,0.32,0.18)*(0.8+0.3*fbm(p*30.0)),vec3(2.2)),0.1);   // 縄
 if(m>15.5&&m<16.5){vec3 c=vec3(0.2,0.1,0.26)*(0.75+0.35*fbm(p*vec3(14.0,30.0,14.0)));return vec4(pow(c,vec3(2.2)),0.03);}   // ぼろ布
 if(m>14.5&&m<15.5){vec3 c=vec3(0.6,0.58,0.5)*(0.82+0.25*fbm(p*14.0));return vec4(pow(c,vec3(2.2)),0.1);}   // 骨
 return vec4(1.0);}
