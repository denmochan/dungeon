// 骨の竜（11/28 2D案「組み直された竜」）：胸の骨の中に緑の魂の火・目の緑の光・幽霊のような半透明の緑の翼の膜（すじ）・首と脚を縛る縄・大きな角・骨のひび
const float XK=0.01;
#define XSKIN 1
vec2 xmod(vec2 b,vec3 p){return b;}
float seam(float x,float w){return 1.0-smoothstep(0.0,w,abs(x));}
float ringAt(vec3 p,vec3 a,vec3 b,float t,float R,float r){vec3 ax=normalize(b-a);vec3 c=mix(a,b,t);vec3 q=p-c;float h=dot(q,ax);float rd=length(q-ax*h);return length(vec2(rd-R,h))-r;}
vec2 xbody(vec3 p){vec3 H=J[1],N=J[10],B=J[0];
 float sf=length(p-B-vec3(0.0,0.1,0.25))-0.22;sf=min(sf,length(p-B-vec3(0.0,0.18,0.4))-0.14);   // 胸の骨の中の魂の火
 float rp=9.0;rp=min(rp,ringAt(p,N,H,0.35,0.085,0.022));rp=min(rp,ringAt(p,N,H,0.42,0.085,0.022));rp=min(rp,ringAt(p,B,N,0.6,0.1,0.024));   // 首を縛る縄
 float hn=9.0;for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;hn=min(hn,sTap(p,H+vec3(0.1*sg,0.1,-0.1),H+vec3(0.22*sg,0.3,-0.32),0.05,0.03));hn=min(hn,sTap(p,H+vec3(0.22*sg,0.3,-0.32),H+vec3(0.26*sg,0.46,-0.52),0.03,0.006));}   // 大きな角
 vec2 r=vec2(sf,7.0);if(rp<r.x)r=vec2(rp,8.0);if(hn<r.x)r=vec2(hn,2.0);return r;}
vec4 xskin(vec3 p,vec3 n,float m){vec3 c=mix(vec3(0.62,0.58,0.5),vec3(0.9,0.86,0.76),smoothstep(-0.3,0.9,n.y))*(0.9+0.15*fbm(p*12.0));
 c*=1.0-0.55*seam(fbm(p*7.0)-0.5,0.015)*step(0.45,fbm(p*3.0+5.0));   // 骨のひび
 c=mix(c,vec3(0.4,1.0,0.6),0.35*smoothstep(0.55,0.15,length(p-J[0]-vec3(0.0,0.1,0.25))));   // 魂の火に照らされる胸
 return vec4(pow(c,vec3(2.2)),0.3);}
vec4 xcol(vec3 p,vec3 n,float m){float sh=smoothstep(-0.4,0.9,n.y);
 if(m>7.5){vec3 c=vec3(0.5,0.36,0.2)*(0.74+0.34*sh)*(0.85+0.2*sin(dot(p,vec3(60.0,60.0,0.0))));return vec4(pow(c,vec3(2.2)),0.2);}   // 縄
 if(m>6.5){vec3 c=mix(vec3(0.3,1.0,0.55),vec3(0.85,1.0,0.8),smoothstep(0.3,1.0,fbm(p*10.0)));return vec4(pow(c,vec3(2.2))*1.8,0.6);}   // 魂の火
 if(m>5.5)return vec4(pow(vec3(0.45,1.0,0.6),vec3(2.2))*2.0,0.6);   // 目の緑の光
 vec3 c=mix(vec3(0.12,0.3,0.24),vec3(0.3,0.6,0.46),smoothstep(-0.3,0.9,n.y));c*=0.8+0.3*fbm(p*6.0);c=mix(c,vec3(0.55,0.9,0.7),0.6*seam(fract(atan(p.x,p.z+1.0)*6.0)-0.5,0.04));return vec4(pow(c,vec3(2.2)),0.3);}   // 幽霊のような翼の膜（すじ）
