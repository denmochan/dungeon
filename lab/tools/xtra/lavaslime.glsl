// 溶岩スライム（癒し系に寄せた版 11/28）：スライムと同じおまんじゅう型。あたたかい橙色、上に小さな炎のとさか、ところどころに冷えた溶岩の小さな斑点
const float XK=0.04;
vec2 xmod(vec2 b,vec3 p){vec3 q=p-vec3(0.0,0.02,0.0);float e=sEll(q,vec3(0.64,0.76,0.58));
 float foot=sEll(p-vec3(0.0,0.05,0.0),vec3(0.7,0.12,0.64));e=smin(e,foot,0.12);
 e=max(e,-p.y);return vec2(e,15.0);}
vec2 xbody(vec3 p){float f=sTap(p,vec3(0.0,0.66,-0.04),vec3(0.04,0.95,-0.12),0.17,0.045);
 f=smin(f,sTap(p,vec3(-0.14,0.64,-0.02),vec3(-0.22,0.82,-0.06),0.11,0.035),0.04);f=smin(f,sTap(p,vec3(0.15,0.63,-0.06),vec3(0.21,0.8,-0.12),0.1,0.035),0.04);
 return vec2(f,16.0);}
vec4 xcol(vec3 p,vec3 n,float m){if(m>15.5){float k=smoothstep(0.66,0.92,p.y);return vec4(pow(mix(vec3(1.0,0.42,0.08),vec3(1.0,0.85,0.3),k),vec3(2.2))*1.25,0.0);}
 float t=clamp(p.y/0.76,0.0,1.0);vec3 c=mix(vec3(0.95,0.32,0.10),vec3(1.0,0.66,0.25),t);
 float sp=smoothstep(0.66,0.7,fbm(p*4.5+2.0));c=mix(c,vec3(0.62,0.22,0.12),sp*0.7);   // 冷えた斑点
 vec3 d0=normalize(vec3(-0.42,0.78,0.46)),d1=normalize(vec3(-0.30,0.86,0.40));float a0=dot(n,d0),a1=dot(n,d1);
 float hl=smoothstep(0.93,0.945,a0)*(1.0-smoothstep(0.965,0.978,a1));c=mix(c,vec3(1.0,0.97,0.85),hl*0.9*smoothstep(0.38,0.48,p.y));
 return vec4(pow(c,vec3(2.2)),0.04);}
