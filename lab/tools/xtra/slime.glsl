// スライム（2D案B：おまんじゅう型）：なめらかな半球、すそが少し広がる。色は上が明るい水色、下が青。左上につやの帯
const float XK=0.04;
vec2 xmod(vec2 b,vec3 p){vec3 q=p-vec3(0.0,0.02,0.0);float e=sEll(q,vec3(0.64,0.74,0.58));
 float foot=sEll(p-vec3(0.0,0.05,0.0),vec3(0.7,0.12,0.64));e=smin(e,foot,0.12);
 e=max(e,-p.y);return vec2(e,15.0);}
vec2 xbody(vec3 p){return vec2(1e3,15.0);}
vec4 xcol(vec3 p,vec3 n,float m){float t=clamp(p.y/0.74,0.0,1.0);vec3 c=mix(vec3(0.16,0.55,1.0),vec3(0.55,0.86,1.0),t*t);
 vec3 d0=normalize(vec3(-0.42,0.78,0.46)),d1=normalize(vec3(-0.30,0.86,0.40));float a0=dot(n,d0),a1=dot(n,d1);
 float hl=smoothstep(0.93,0.945,a0)*(1.0-smoothstep(0.965,0.978,a1));c=mix(c,vec3(0.97,1.0,1.0),hl*0.9*smoothstep(0.38,0.48,p.y));   // 左上のつや（三日月）
 return vec4(pow(c,vec3(2.2)),0.04);}
