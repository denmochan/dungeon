// グール：やせて、胸のあばら骨と背骨が浮き出た死体。腹に裂け目
const float XK=0.015;
vec2 xmod(vec2 b,vec3 p){vec3 tp=TR*(p-J[0]);float cut=sEll(tp-vec3(0.08,0.12,0.24),vec3(0.1,0.06,0.08));return vec2(max(b.x+0.012,-cut),b.y<1.5?16.0:b.y);}   // 肌は死体の色に   // 全体を少し細く、腹をえぐる
vec2 xbody(vec3 p){vec3 tp=TR*(p-J[0]);float d=9.0;
 for(int i=0;i<4;i++){float y=0.2+0.065*float(i);vec3 q=tp-vec3(0.0,y,0.0);float a=atan(q.x,q.z);float rr=length(q.xz);float ring=length(vec2(rr-(0.27-0.012*float(i)),q.y))-0.022;d=min(d,max(ring,-(q.z-0.04)));}   // あばら（前だけ）
 for(int i=0;i<5;i++){d=min(d,length(tp-vec3(0.0,0.12+0.07*float(i),-0.2+0.01*float(i)))-0.03);}   // 背骨
 return vec2(d,15.0);}
vec4 xcol(vec3 p,vec3 n,float m){if(m<15.5)return vec4(pow(vec3(0.86,0.82,0.68),vec3(2.2))*(0.85+0.2*fbm(p*15.0)),0.1);
 float f=fbm(p*6.0);vec3 c=mix(vec3(0.5,0.56,0.46),vec3(0.36,0.3,0.32),smoothstep(0.55,0.75,f));return vec4(pow(c,vec3(2.2))*(0.85+0.25*fbm(p*17.0)),0.03);}
