// 吸血鬼（11/28）：立てた襟（外は黒・内は赤）、背中のマントはすそがコウモリの羽のぎざぎざ、胸に赤い宝石のメダル
const float XK=0.03;
vec2 U(vec2 a,vec2 b){return b.x<a.x?b:a;}
vec2 xmod(vec2 b,vec3 p){if(b.y>8.5&&b.y<9.5&&p.y<J[0].y-0.12){vec3 pa=p-J[9],ba=J[11]-J[9];float d1=length(pa-ba*clamp(dot(pa,ba)/dot(ba,ba),0.0,1.0));pa=p-J[12];ba=J[14]-J[12];float d2=length(pa-ba*clamp(dot(pa,ba)/dot(ba,ba),0.0,1.0));
  b=vec2(min(d1,d2)-0.085+0.02*smoothstep(J[0].y,0.1,p.y),26.0);}   // すそまでの円すいの服は腰で切る（脚を見せる）
  return b;}
vec2 xbody(vec3 p){vec3 N=J[1]+vec3(0.0,0.18,0.0);vec2 r=vec2(1e3,20.0);
 {vec3 q=p-J[2]-vec3(0.0,-0.23,-0.12);float rr=length(q.xz);float hgt=clamp(q.y/0.5,0.0,1.0);float cl=max(abs(rr-0.44-0.14*hgt)-0.025,max(-q.y,q.y-0.42-0.12*abs(q.x)-0.06*abs(sin(atan(q.x,-q.z)*3.0))));cl=max(cl,q.z-0.05+0.25*max(0.0,q.y));r=U(r,vec2(cl,20.0));}   // 頭の後ろに高く立つ襟
 {float top=J[1].y+0.12;vec3 q=p-vec3(0.0,0.0,J[1].z-0.02);float t=clamp((top-p.y)/top,0.0,1.0);float rad=0.34+0.34*t*t+0.06*t;float rr=length(q.xz*vec2(1.0,1.25));float wave=0.03*sin(atan(q.x,-q.z)*7.0)*t;
  float cp=max(abs(rr-rad-wave)-0.024,max(p.y-top,-(p.y-0.04-0.1*abs(sin(atan(q.x,-q.z)*5.0)))));cp=max(cp,q.z-0.02+0.3*t);r=U(r,vec2(cp,21.0));}   // 背中から床まで広がるマント（すそはぎざぎざ）
 // メダルは服に隠れるので無し
 {for(int s=0;s<2;s++){vec3 f=s==0?J[15]:J[16];vec3 a=s==0?J[11]:J[14];float bt=sTap(p,vec3(a.x,0.25,a.z),vec3(a.x,0.07,a.z+0.02),0.095,0.09);bt=smin(bt,sEll(p-vec3(f.x,0.05,f.z+0.04),vec3(0.09,0.06,0.17)),0.03);r=U(r,vec2(bt,27.0));}}   // 長靴
 return r;}
vec4 xcol(vec3 p,vec3 n,float m){
 if(m>26.5&&m<27.5)return vec4(pow(mix(vec3(0.04,0.03,0.03),vec3(0.2,0.18,0.2),smoothstep(-0.2,0.9,n.y)),vec3(2.2)),0.6);   // 黒い長靴
 if(m>25.5&&m<26.5)return vec4(pow(vec3(0.1,0.08,0.1)*(0.85+0.2*fbm(p*vec3(6.0,30.0,6.0))),vec3(2.2)),0.1);   // 細いズボン
 if(m>23.5&&m<24.5)return vec4(pow(vec3(0.95,0.94,0.9),vec3(2.2)),0.1);   // ナプキン
 if(m>24.5&&m<25.5)return vec4(pow(vec3(0.9,0.72,0.3),vec3(2.2)),0.8);   // 金
 if(m>21.5&&m<22.5){float g=length(p.xy-J[1].xy-vec2(0.0,0.08));return vec4(pow(g<0.032?vec3(0.85,0.05,0.1):vec3(0.9,0.72,0.3),vec3(2.2))*(g<0.032?1.6:1.0),0.8);}
 if(m>20.5&&m<21.5){float in_=smoothstep(0.1,-0.3,dot(n,normalize(p-J[1]-vec3(0.0,-0.3,-0.3))));vec3 c=mix(vec3(0.07,0.06,0.08),vec3(0.5,0.05,0.08),in_);return vec4(pow(c*(0.85+0.25*fbm(p*vec3(6.0,20.0,6.0))),vec3(2.2)),0.15);}   // マント（外は黒、内は赤）
 if(m>19.5&&m<20.5){vec3 q=p-J[2]-vec3(0.0,-0.23,-0.12);float in_=smoothstep(0.1,-0.2,dot(n,normalize(vec3(q.x,0.0,q.z))));vec3 c=mix(vec3(0.07,0.06,0.08),vec3(0.6,0.06,0.1),in_);return vec4(pow(c,vec3(2.2)),0.2);}   // 襟（外は黒、内は赤）
 return vec4(1.0);}
