// 宝石喰らい：背中と横に、宝石の結晶がささっている（赤・青・緑）
const float XK=0.012;
vec2 xmod(vec2 b,vec3 p){return b;}
float xOct(vec3 p,float s){p=abs(p);return (p.x+p.y+p.z-s)*0.57735;}
vec2 xbody(vec3 p){vec3 c=J[0],r=J[1];float d=9.0,m=16.0;
 for(int i=0;i<9;i++){float fi=float(i),a=fi*0.72+2.1,e=0.15+0.5*fract(fi*0.618);vec3 dir=normalize(vec3(cos(a)*cos(e),sin(e)+0.25,sin(a)*cos(e)));vec3 q=p-(c+dir*r*0.9);
  float al=dot(q,dir);q=q-dir*al+dir*al*0.5;float g=xOct(q,0.1+0.05*fract(fi*0.37));if(g<d){d=g;m=16.0+mod(fi,3.0);}}
 return vec2(d,m);}
vec4 xcol(vec3 p,vec3 n,float m){vec3 c=m<16.5?vec3(0.95,0.18,0.3):m<17.5?vec3(0.25,0.55,1.0):vec3(0.3,0.95,0.5);return vec4(pow(c,vec3(2.2))*(0.85+0.4*max(0.0,n.y)),0.4);}
