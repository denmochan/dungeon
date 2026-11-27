// 火トカゲ：体を丸く太く持ち上げ、ひざを曲げた太い足・炎のたてがみを足す（平たくて何か分からなかった）
const float XK=0.06;
vec2 xmod(vec2 b,vec3 p){return vec2(b.x-0.012,b.y);}
vec2 xbody(vec3 p){float d=sEll(p-J[0]-vec3(0.0,0.13,0.02),vec3(0.28,0.22,0.46));
 d=smin(d,sEll(p-J[1]-vec3(0.0,0.12,-0.02),vec3(0.21,0.16,0.27)),0.08);d=smin(d,sTap(p,J[0]+vec3(0.0,0.08,-0.3),J[2]+vec3(0.0,0.02,0.0),0.19,0.12),0.08);
 for(int i=0;i<4;i++){vec3 f=i==0?J[5]:i==1?J[6]:i==2?J[7]:J[8];float sx=sign(f.x);vec3 hip=vec3(sx*0.18,J[0].y+0.12,f.z*0.85),kn=vec3(f.x*1.08,0.42,f.z);   // 腰→ひざ（上へ）→足
  d=smin(d,min(sTap(p,hip,kn,0.1,0.08),sTap(p,kn,f+vec3(0.0,0.03,0.0),0.08,0.065)),0.05);d=smin(d,sEll(p-f-vec3(0.0,0.0,0.06),vec3(0.1,0.04,0.12)),0.03);}
 float fl=9.0;for(int i=0;i<7;i++){float t=float(i)/6.0;vec3 a=mix(J[1]+vec3(0.0,0.22,-0.14),J[2]+vec3(0.0,0.1,0.0),t);fl=min(fl,sTap(p,a,a+vec3(0.0,0.3-0.12*t,-0.12),0.075-0.025*t,0.01));}   // 炎のたてがみ
 return fl<d?vec2(fl,16.0):vec2(d,15.0);}
vec4 xcol(vec3 p,vec3 n,float m){if(m>15.5){float t=clamp((p.y-0.45)/0.3,0.0,1.0);return vec4(pow(mix(vec3(1.0,0.45,0.1),vec3(1.0,0.9,0.35),t),vec3(2.2))*1.3,0.0);}
 float bl=smoothstep(-0.2,0.2,-dot(normalize(n),vec3(0.0,1.0,0.0)));vec3 c=mix(vec3(0.72,0.32,0.12),vec3(0.95,0.72,0.4),bl*0.7);return vec4(pow(c,vec3(2.2))*(0.82+0.3*fbm(p*8.0)),0.05);}
