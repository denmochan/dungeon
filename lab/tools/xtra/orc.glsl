// オーク（2D案A：肩の大きい重戦士 11/28）：首の後ろの盛り上がりで頭を低く、広い胸、大きな肩と前腕とこぶし、太い眉、下あごの突き出し、横にのびた耳、下の牙、左肩に鉄の肩当て
const float XK=0.07;
vec2 xmod(vec2 b,vec3 p){return b;}
vec2 xbody(vec3 p){vec3 H=J[2];
 float d=sEll(p-vec3(0.0,1.03,-0.04),vec3(0.32,0.15,0.2));   // 首の後ろの盛り上がり
 d=smin(d,sEll(p-J[1]-vec3(0.0,0.06,0.05),vec3(0.46,0.3,0.27)),0.08);d=smin(d,sEll(p-J[1]-vec3(0.0,0.14,0.13),vec3(0.3,0.13,0.12)),0.06);   // 広い胸と胸板
 for(int s=0;s<2;s++){vec3 sh=s==0?J[3]:J[6],el=s==0?J[4]:J[7],ha=s==0?J[5]:J[8];float sg=s==0?-1.0:1.0;
  d=smin(d,sEll(p-sh-vec3(0.1*sg,0.07,0.0),vec3(0.21,0.19,0.19)),0.06);   // 肩
  d=smin(d,sTap(p,el,ha,0.135,0.11),0.05);d=smin(d,length(p-ha)-0.12,0.04);}   // 前腕・こぶし
 d=smin(d,sEll(p-H-vec3(0.0,-0.13,0.11),vec3(0.2,0.1,0.15)),0.06);   // 下あご
 d=smin(d,sEll(p-H-vec3(0.0,0.08,0.16),vec3(0.2,0.05,0.07)),0.04);   // 眉
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;d=smin(d,sTap(p,H+vec3(0.17*sg,0.03,-0.02),H+vec3(0.36*sg,0.12,-0.08),0.065,0.01),0.03);}   // 耳
 vec2 r=vec2(d,1.0);
 float tk=9.0;for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;tk=min(tk,sTap(p,H+vec3(0.085*sg,-0.12,0.22),H+vec3(0.1*sg,-0.01,0.25),0.03,0.008));}
 if(tk<r.x)r=vec2(tk,17.0);   // 下の牙
 vec3 q=p-J[3]-vec3(-0.13,0.15,0.0);float pad=max(sEll(q,vec3(0.27,0.16,0.25)),-sEll(q+vec3(0.0,0.05,0.0),vec3(0.23,0.13,0.21)));pad=max(pad,-(q.y+0.06));
 if(pad<r.x)r=vec2(pad,16.0);   // 肩当て
 return r;}
vec4 xcol(vec3 p,vec3 n,float m){if(m>16.5)return vec4(pow(vec3(0.95,0.91,0.8),vec3(2.2)),0.2);
 vec3 c=vec3(0.55,0.57,0.62)*(0.8+0.3*fbm(p*14.0));float rv=step(length(fract(vec2(atan(p.x-J[3].x,p.z-J[3].z)*1.2,p.y*8.0))-0.5),0.12);c=mix(c,vec3(0.85,0.86,0.9),rv*0.0);return vec4(pow(c,vec3(2.2)),0.5);}
