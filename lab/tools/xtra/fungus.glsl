// 菌糸の巣：足もとに根が広がり、かさの上に胞子の綿、まわりに小さなキノコ
const float XK=0.04;
vec2 xmod(vec2 b,vec3 p){return b;}
vec2 xbody(vec3 p){float d=9.0,c=9.0,w=9.0;
 for(int i=0;i<7;i++){float a=float(i)*0.9+0.2;vec3 s=vec3(cos(a)*0.22,0.12,sin(a)*0.22),m1=vec3(cos(a+0.3)*0.55,0.04,sin(a+0.3)*0.55),e=vec3(cos(a+0.15)*0.85,0.01,sin(a+0.15)*0.85);d=min(d,min(sTap(p,s,m1,0.06,0.04),sTap(p,m1,e,0.04,0.012)));}   // 根
 for(int i=0;i<4;i++){float a=float(i)*1.6+0.7;vec3 b=vec3(cos(a)*0.62,0.0,sin(a)*0.62);c=min(c,sTap(p,b,b+vec3(0.0,0.17,0.0),0.035,0.03));c=min(c,sEll(p-b-vec3(0.0,0.19,0.0),vec3(0.1,0.05,0.1)));}   // 小さなキノコ
 for(int i=0;i<8;i++){float a=float(i)*2.4;vec3 s=vec3(cos(a)*0.3*fract(float(i)*0.61+0.2),1.0+0.06*fract(float(i)*0.37),sin(a)*0.3*fract(float(i)*0.43+0.3));w=min(w,length(p-s)-0.09);}   // 胞子の綿
 if(w<d&&w<c)return vec2(w,17.0);return d<c?vec2(d,15.0):vec2(c,16.0);}
vec4 xcol(vec3 p,vec3 n,float m){vec3 c=m<15.5?vec3(0.82,0.76,0.62):m<16.5?(p.y>0.15?vec3(0.62,0.3,0.55):vec3(0.85,0.82,0.7)):vec3(0.95,0.95,0.85);return vec4(pow(c,vec3(2.2))*(0.85+0.25*fbm(p*14.0)),0.05);}
