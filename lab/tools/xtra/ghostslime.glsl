// 霊スライム：上へのびる、ゆらめくしっぽ。まわりに小さな火の玉（試し場では体をすかして描く）
const float XK=0.07;
vec2 xmod(vec2 b,vec3 p){return vec2(b.x,b.y<1.5?15.0:b.y);}   // 体の色も白っぽく
vec2 xbody(vec3 p){vec3 c=J[0],r=J[1];float d=9.0;vec3 a=c+vec3(0.0,r.y*0.75,-r.z*0.2);for(int i=0;i<4;i++){float t=float(i);vec3 b=a+vec3(0.12*sin(t*1.7),0.16,-0.08-0.02*t);d=min(d,sTap(p,a,b,0.17-0.035*t,0.13-0.035*t));a=b;}
 float o=9.0;for(int i=0;i<3;i++){float an=float(i)*2.1+0.5;o=min(o,length(p-(c+vec3(cos(an)*r.x*1.45,r.y*(0.6+0.25*float(i)),sin(an)*r.z*1.3)))-0.06);}
 return o<d?vec2(o,16.0):vec2(d,15.0);}
vec4 xcol(vec3 p,vec3 n,float m){if(m>15.5)return vec4(pow(vec3(0.6,0.95,1.0),vec3(2.2))*1.5,0.0);return vec4(pow(vec3(0.82,0.95,1.0),vec3(2.2))*(0.9+0.2*fbm(p*5.0)),0.05);}
