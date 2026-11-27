// 宝物庫の番人：石の箱に金の角かざり・金の帯・大きな金の錠と宝石、ふたに金のとげ
const float XK=0.01;
vec2 xmod(vec2 b,vec3 p){return b;}
float xRB(vec3 p,vec3 b,float r){vec3 q=abs(p)-b;return length(max(q,0.0))+min(max(q.x,max(q.y,q.z)),0.0)-r;}
vec2 xbody(vec3 p){float g=9.0,gm=9.0;
 for(int i=0;i<4;i++){float sx=mod(float(i),2.0)<0.5?-1.0:1.0,sz=i<2?-1.0:1.0;g=min(g,xRB(p-vec3(sx*0.5,0.05,sz*0.42+0.03),vec3(0.05,0.07,0.05),0.02));g=min(g,xRB(p-vec3(sx*0.5,0.44,sz*0.42+0.03),vec3(0.05,0.05,0.05),0.02));}
 g=min(g,xRB(p-vec3(0.0,0.43,0.05),vec3(0.54,0.025,0.47),0.01));g=min(g,xRB(p-vec3(-0.25,0.25,0.05),vec3(0.03,0.26,0.48),0.01));g=min(g,xRB(p-vec3(0.25,0.25,0.05),vec3(0.03,0.26,0.48),0.01));
 g=min(g,xRB(p-vec3(0.0,0.4,0.5),vec3(0.09,0.11,0.03),0.02));for(int i=0;i<5;i++){float x=-0.36+0.18*float(i);g=min(g,sTap(p,vec3(x,0.72,0.08),vec3(x,0.9,0.08),0.045,0.008));}
 gm=length(p-vec3(0.0,0.42,0.54))-0.045;
 return g<gm?vec2(g,15.0):vec2(gm,16.0);}
vec4 xcol(vec3 p,vec3 n,float m){if(m<15.5)return vec4(pow(vec3(0.95,0.75,0.3),vec3(2.2))*(0.85+0.3*fbm(p*12.0)),0.6);return vec4(pow(vec3(0.3,0.95,0.6),vec3(2.2)),0.6);}
