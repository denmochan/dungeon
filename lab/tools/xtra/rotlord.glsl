// 腐海の主：体のまわりから太い触手が6本。先が上へまるまる。頭に骨の冠
const float XK=0.07;
vec2 xmod(vec2 b,vec3 p){return vec2(b.x-0.02*fbm(p*4.0),b.y);}
vec2 xbody(vec3 p){vec3 c=J[0],r=J[1];float d=9.0;
 for(int i=0;i<6;i++){float a=float(i)*1.047+0.52;vec3 dr=vec3(cos(a),0.0,sin(a));vec3 s0=c+vec3(dr.x*r.x*0.8,-r.y*0.5,dr.z*r.z*0.8),s1=s0+dr*0.35+vec3(0.0,-0.1,0.0),s2=s1+dr*0.3+vec3(0.0,0.12,0.0),s3=s2+dr*0.06+vec3(0.0,0.2,0.0);
  d=min(d,min(min(sTap(p,s0,s1,0.12,0.09),sTap(p,s1,s2,0.09,0.06)),sTap(p,s2,s3,0.06,0.02)));}
 float cr=9.0;for(int i=0;i<5;i++){float a=float(i)*1.256;vec3 s=c+vec3(cos(a)*r.x*0.35,r.y*0.92,sin(a)*r.z*0.35);cr=min(cr,sTap(p,s,s+vec3(cos(a)*0.06,0.22,sin(a)*0.06),0.05,0.008));}
 return cr<d?vec2(cr,16.0):vec2(d,15.0);}
vec4 xcol(vec3 p,vec3 n,float m){if(m>15.5)return vec4(pow(vec3(0.9,0.86,0.72),vec3(2.2)),0.2);return vec4(pow(vec3(0.46,0.3,0.52),vec3(2.2))*(0.75+0.4*fbm(p*6.0)),0.05);}
