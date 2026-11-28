// ゴースト：くりぬいた目と口（中は暗い）、すその波うつ切れはし、頭の小さなとんがり。色は青白く、下ほど透ける色
vec2 U(vec2 a,vec2 b){return b.x<a.x?b:a;}
const float XK=0.05;
float gEye(vec3 p){vec3 q=vec3(abs(p.x)-0.14,p.y-1.13,p.z-0.36);return length(q*vec3(1.0,0.78,1.0))-0.085;}
float gMou(vec3 p){vec3 q=vec3(p.x,p.y-0.93,p.z-0.38);return length(q*vec3(0.9,1.5,1.0))-0.075;}
vec2 xmod(vec2 b,vec3 p){float a=atan(p.x,p.z);float hem=smoothstep(0.85,0.45,p.y);
 b.x-=hem*0.035*sin(a*7.0+p.y*9.0);   // すその波
 float cav=min(gEye(p),gMou(p));b.x=max(b.x,-cav);
 return vec2(b.x,cav<0.03?16.0:(b.y<1.5?15.0:b.y));}
vec2 xbody(vec3 p){vec3 t=p-vec3(0.0,1.38,-0.08);float tip=sTap(p,vec3(0.0,1.3,-0.02),vec3(0.03,1.5,-0.16),0.11,0.02);
 for(int i=0;i<5;i++){float fi=float(i)-2.0;vec3 a=vec3(fi*0.17,0.62,0.12-abs(fi)*0.05);vec3 c=a+vec3(fi*0.05,-0.26+abs(fi)*0.04,-0.06);tip=min(tip,sTap(p,a,c,0.11,0.025));}   // すその切れはし
 vec2 r=vec2(tip,15.0);
 {vec3 a=vec3(0.0,0.72,-0.28),b=vec3(0.05,0.55,-0.5),c=vec3(0.16,0.5,-0.66),d=vec3(0.24,0.6,-0.74);float w=min(min(sTap(p,a,b,0.14,0.09),sTap(p,b,c,0.09,0.05)),sTap(p,c,d,0.05,0.015));r.x=smin(r.x,w,0.06);   // 後ろへなびくしっぽ
  vec3 q=p-vec3(-0.5,0.92,0.06);float sh=max(abs(length(q.yz)-0.06)-0.018,abs(q.x)-0.03);r=U(r,vec2(sh,17.0));float ch=9.0;for(int k=0;k<3;k++){vec3 c2=vec3(-0.5,0.82-0.08*float(k),0.06+0.02*float(k));vec3 qq=p-c2;ch=min(ch,max(abs(length(qq.xy*vec2(1.0,0.7))-0.03)-0.01,abs(qq.z)-0.008));}r=U(r,vec2(ch,17.0));}   // 左手にちぎれた鎖のかせ（スケルトンの昔の相棒）
 return r;}
vec4 xcol(vec3 p,vec3 n,float m){
 if(m>16.5)return vec4(pow(vec3(0.42,0.4,0.44)*(0.8+0.3*fbm(p*30.0)),vec3(2.2)),0.7);   // 鎖
if(m>15.5)return vec4(pow(vec3(0.05,0.06,0.16),vec3(2.2)),0.3);
 float lo=smoothstep(1.0,0.4,p.y);vec3 c=mix(vec3(0.86,0.93,1.0),vec3(0.55,0.72,0.95),lo);c=pow(c,vec3(2.2));c*=0.93+0.12*fbm(p*7.0);return vec4(c,0.25);}
