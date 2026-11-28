// 大ネズミ：前歯・ひげ・桃色の耳の内側・小さな手足
const float XK=0.02;
vec2 xmod(vec2 b,vec3 p){return vec2(b.x-0.006*fbm(p*20.0),b.y);}
vec2 xbody(vec3 p){vec3 h=J[1];float t=min(sTap(p,h+vec3(-0.025,-0.06,0.2),h+vec3(-0.025,-0.13,0.21),0.022,0.018),sTap(p,h+vec3(0.025,-0.06,0.2),h+vec3(0.025,-0.13,0.21),0.022,0.018));   // 前歯
 float w=9.0;for(int i=0;i<6;i++){float s=i<3?-1.0:1.0,k=float(i-(i<3?0:3));w=min(w,sTap(p,h+vec3(s*0.07,-0.02,0.15),h+vec3(s*0.3,0.02-0.05*k,0.12-0.03*k),0.006,0.003));}   // ひげ
 float e=9.0;for(int i=0;i<2;i++){float s=i==0?-1.0:1.0;e=min(e,sEll(p-h-vec3(s*0.12,0.12,-0.05),vec3(0.07,0.075,0.02)));}   // 耳の内側
 float d=min(t,w);if(e<d)return vec2(e,17.0);return t<w?vec2(t,15.0):vec2(w,16.0);}
vec4 xcol(vec3 p,vec3 n,float m){vec3 c=m<15.5?vec3(0.95,0.88,0.6):m<16.5?vec3(0.15,0.12,0.1):vec3(0.95,0.6,0.62);return vec4(pow(c,vec3(2.2)),0.1);}
