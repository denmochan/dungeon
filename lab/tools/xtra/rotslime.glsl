// 腐肉の沼：どろっと崩れて、足もとに広がる沼としずく、表面に泡
const float XK=0.09;
vec2 xmod(vec2 b,vec3 p){return vec2(b.x-0.03*fbm(p*4.0)+0.02,b.y);}
vec2 xbody(vec3 p){vec3 c=J[0],r=J[1];float d=sEll(p-vec3(c.x,0.03,c.z),vec3(r.x*1.45,0.07,r.z*1.4));
 for(int i=0;i<6;i++){float a=float(i)*1.05+0.3;vec3 s=c+vec3(cos(a)*r.x*0.85,r.y*0.15,sin(a)*r.z*0.85);d=min(d,sTap(p,s,vec3(s.x*1.25,0.03,s.z*1.25),0.09,0.06));}
 float bu=9.0;for(int i=0;i<6;i++){float a=float(i)*2.3+1.0;vec3 s=c+normalize(vec3(cos(a),0.9+0.3*sin(float(i)),sin(a)*0.8-0.3))*r*0.95;bu=min(bu,length(p-s)-0.045-0.02*fract(float(i)*0.7));}
 return bu<d-0.02?vec2(bu,16.0):vec2(d,15.0);}
vec4 xcol(vec3 p,vec3 n,float m){if(m>15.5)return vec4(pow(vec3(0.75,0.82,0.4),vec3(2.2)),0.3);return vec4(pow(vec3(0.42,0.4,0.18),vec3(2.2))*(0.75+0.4*fbm(p*6.0)),0.05);}
