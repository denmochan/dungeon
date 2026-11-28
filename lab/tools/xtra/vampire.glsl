// 吸血鬼（11/28）：立てた襟（外は黒・内は赤）、背中のマントはすそがコウモリの羽のぎざぎざ、胸に赤い宝石のメダル
const float XK=0.03;
vec2 U(vec2 a,vec2 b){return b.x<a.x?b:a;}
vec2 xmod(vec2 b,vec3 p){ return b;}
vec2 xbody(vec3 p){vec3 N=J[1]+vec3(0.0,0.18,0.0);vec2 r=vec2(1e3,20.0);
 {vec3 q=p-vec3(0.0,1.0,0.05);float rr=length(q.xz);float hgt=clamp(q.y/0.5,0.0,1.0);float cl=max(abs(rr-0.44-0.14*hgt)-0.025,max(-q.y,q.y-0.42-0.12*abs(q.x)-0.06*abs(sin(atan(q.x,-q.z)*3.0))));cl=max(cl,q.z-0.05+0.25*max(0.0,q.y));r=U(r,vec2(cl,20.0));}   // 頭の後ろに高く立つ襟
 {float cp=9.0;for(int k=0;k<5;k++){float fk=float(k)/4.0;float x=mix(-0.46,0.46,fk);vec3 top=N+vec3(x*0.7,-0.02,-0.2),bot=vec3(x,0.04+0.08*abs(sin(fk*9.0)),-0.42-0.04*sin(fk*3.14));cp=min(cp,sTap(p,top,bot,0.1,0.06));}cp=smin(cp,sEll(p-N-vec3(0.0,-0.25,-0.24),vec3(0.42,0.36,0.1)),0.08);
  float hem=0.0;cp=max(cp,-(p.y-0.06-0.08*abs(sin(p.x*14.0))));r=U(r,vec2(cp,21.0));}   // 背中のマント（すそはコウモリの羽のぎざぎざ）
 // メダルは服に隠れるので無し
 return r;}
vec4 xcol(vec3 p,vec3 n,float m){
 if(m>23.5&&m<24.5)return vec4(pow(vec3(0.95,0.94,0.9),vec3(2.2)),0.1);   // ナプキン
 if(m>24.5&&m<25.5)return vec4(pow(vec3(0.9,0.72,0.3),vec3(2.2)),0.8);   // 金
 if(m>21.5&&m<22.5){float g=length(p.xy-J[1].xy-vec2(0.0,0.08));return vec4(pow(g<0.032?vec3(0.85,0.05,0.1):vec3(0.9,0.72,0.3),vec3(2.2))*(g<0.032?1.6:1.0),0.8);}
 if(m>20.5&&m<21.5){float in_=smoothstep(0.1,-0.3,dot(n,normalize(p-J[1]-vec3(0.0,-0.3,-0.3))));vec3 c=mix(vec3(0.07,0.06,0.08),vec3(0.5,0.05,0.08),in_);return vec4(pow(c*(0.85+0.25*fbm(p*vec3(6.0,20.0,6.0))),vec3(2.2)),0.15);}   // マント（外は黒、内は赤）
 if(m>19.5&&m<20.5){vec3 q=p-vec3(0.0,1.0,0.05);float in_=smoothstep(0.1,-0.2,dot(n,normalize(vec3(q.x,0.0,q.z))));vec3 c=mix(vec3(0.07,0.06,0.08),vec3(0.6,0.06,0.1),in_);return vec4(pow(c,vec3(2.2)),0.2);}   // 襟（外は黒、内は赤）
 return vec4(1.0);}
