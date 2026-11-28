// オーク（かぶと付き：坑道オーク・牙のオーク。髪はかぶとからはみ出すので無し）（2D案A：肩の大きい重戦士 11/28）：首の後ろの盛り上がりで頭を低く、広い胸、大きな肩と前腕とこぶし、太い眉、下あごの突き出し、横にのびた耳、下の牙、左肩に鉄の肩当て
const float XK=0.07;
vec2 xmod(vec2 b,vec3 p){vec3 H=J[2];float cut=(p.y-(H.y+0.15))+0.45*(p.z-H.z-0.05);   // 頭のてっぺんを低く平らに、ひたいを後ろへ寝かせる
 float w=smoothstep(0.55,0.4,length((p-H).xz))*step(H.y-0.05,p.y);float k=0.06;float hb=max(b.x,cut);hb=mix(hb,b.x,0.0);
 if(b.y>1.5)return b;return vec2(mix(b.x,max(b.x,cut+0.0),w),b.y);}   // かぶとは削らない
float sBox3(vec3 p,vec3 b){vec3 q=abs(p)-b;return length(max(q,0.0))+min(max(q.x,max(q.y,q.z)),0.0);}
vec2 xbody(vec3 p){vec3 H=J[2];
 float d=sEll(p-vec3(0.0,1.03,-0.04),vec3(0.32,0.15,0.2));   // 首の後ろの盛り上がり
 d=smin(d,sEll(p-J[1]-vec3(0.0,0.06,0.05),vec3(0.46,0.3,0.27)),0.08);d=smin(d,sEll(p-J[1]-vec3(0.0,0.14,0.13),vec3(0.3,0.13,0.12)),0.06);   // 広い胸と胸板
 for(int s=0;s<2;s++){vec3 sh=s==0?J[3]:J[6],el=s==0?J[4]:J[7],ha=s==0?J[5]:J[8];float sg=s==0?-1.0:1.0;
  d=smin(d,sEll(p-sh-vec3(0.1*sg,0.07,0.0),vec3(0.21,0.19,0.19)),0.06);   // 肩
  d=smin(d,sTap(p,el,ha,0.135,0.11),0.05);d=smin(d,length(p-ha)-0.12,0.04);}   // 前腕・こぶし
 d=smin(d,sBox3(p-H-vec3(0.0,-0.15,0.1),vec3(0.19,0.08,0.13))-0.05,0.06);   // 四角く大きい下あご
 d=smin(d,sEll(p-H-vec3(0.0,-0.2,0.17),vec3(0.13,0.06,0.07)),0.04);   // あご先
 d=smin(d,sEll(p-H-vec3(0.0,0.07,0.17),vec3(0.24,0.065,0.09)),0.05);   // 重い眉（目にかぶさる）
 d=smin(d,sEll(p-H-vec3(0.0,-0.02,0.24),vec3(0.085,0.055,0.06)),0.04);   // 平たい広い鼻
 d=smin(d,sEll(p-H-vec3(0.0,0.0,-0.12),vec3(0.21,0.14,0.18)),0.08);   // 後ろに張った頭
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;d=smin(d,sTap(p,H+vec3(0.17*sg,0.02,-0.03),H+vec3(0.33*sg,0.08,-0.1),0.06,0.01),0.03);}   // 耳
 vec2 r=vec2(d,1.0);
 float tk=9.0;for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;vec3 a=H+vec3(0.13*sg,-0.14,0.2),m=H+vec3(0.16*sg,-0.06,0.22),t=H+vec3(0.13*sg,0.0,0.19);tk=min(tk,min(sTap(p,a,m,0.042,0.03),sTap(p,m,t,0.03,0.006)));}
 if(tk<r.x)r=vec2(tk,17.0);   // あごの両はしから上へ反る牙
 vec3 q=p-J[3]-vec3(-0.13,0.15,0.0);float pad=max(sEll(q,vec3(0.27,0.16,0.25)),-sEll(q+vec3(0.0,0.05,0.0),vec3(0.23,0.13,0.21)));pad=max(pad,-(q.y+0.06));
 if(pad<r.x)r=vec2(pad,16.0);   // 肩当て
 return r;}
vec4 xcol(vec3 p,vec3 n,float m){if(m>17.5)return vec4(pow(vec3(0.07,0.06,0.06),vec3(2.2))*(0.8+0.4*fbm(p*30.0)),0.15);if(m>16.5){float t=clamp((p.y-J[2].y+0.14)/0.14,0.0,1.0);return vec4(pow(mix(vec3(0.78,0.7,0.5),vec3(0.96,0.93,0.84),t),vec3(2.2)),0.2);}
 vec3 c=vec3(0.55,0.57,0.62)*(0.8+0.3*fbm(p*14.0));float rv=step(length(fract(vec2(atan(p.x-J[3].x,p.z-J[3].z)*1.2,p.y*8.0))-0.5),0.12);c=mix(c,vec3(0.85,0.86,0.9),rv*0.0);return vec4(pow(c,vec3(2.2)),0.5);}
