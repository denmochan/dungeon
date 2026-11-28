// キマイラ：太いもも・すねと、大きな肉球の足（棒の足だった）
const float XK=0.05;
vec2 xmod(vec2 b,vec3 p){return b;}
vec2 xbody(vec3 p){float d=9.0;for(int i=0;i<4;i++){vec3 f=i==0?J[5]:i==1?J[6]:i==2?J[7]:J[8];float bk=f.z<J[0].z?1.0:-1.0;vec3 hip=vec3(f.x*0.9,J[0].y-0.02,f.z*0.95),kn=vec3(f.x,0.3,f.z+0.05*bk);
  d=min(d,smin(smin(sTap(p,hip,kn,0.13,0.08),sTap(p,kn,f+vec3(0.0,0.05,0.0),0.075,0.065),0.04),sEll(p-f-vec3(0.0,0.02,0.05),vec3(0.09,0.055,0.1)),0.03));}
 return vec2(d,15.0);}
vec4 xcol(vec3 p,vec3 n,float m){return vec4(pow(vec3(0.8,0.6,0.34),vec3(2.2))*(0.85+0.25*fbm(p*10.0)),0.05);}
