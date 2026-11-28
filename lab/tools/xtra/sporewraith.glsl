// ゴースト：くりぬいた目と口（中は暗い）、すその波うつ切れはし、頭の小さなとんがり。色は青白く、下ほど透ける色
vec2 U(vec2 a,vec2 b){return b.x<a.x?b:a;}
const float XK=0.05;
float gEye(vec3 p){vec3 q=vec3(abs(p.x)-0.12,p.y-1.02,p.z-0.42);return length(q*vec3(1.0,0.78,1.0))-0.075;}
float gMou(vec3 p){vec3 q=vec3(p.x,p.y-0.85,p.z-0.44);return length(q*vec3(0.9,1.5,1.0))-0.06;}
vec2 xmod(vec2 b,vec3 p){float a=atan(p.x,p.z);float hem=smoothstep(0.85,0.45,p.y);
 b.x-=hem*0.035*sin(a*7.0+p.y*9.0);   // すその波
 float cav=min(gEye(p),gMou(p));b.x=max(b.x,-cav);
 return vec2(b.x,cav<0.03?16.0:(b.y<1.5?15.0:b.y));}
vec2 xbody(vec3 p){vec3 t=p-vec3(0.0,1.38,-0.08);float tip=sTap(p,vec3(0.0,1.3,-0.02),vec3(0.03,1.5,-0.16),0.11,0.02);
 for(int i=0;i<5;i++){float fi=float(i)-2.0;vec3 a=vec3(fi*0.17,0.62,0.12-abs(fi)*0.05);vec3 c=a+vec3(fi*0.05,-0.26+abs(fi)*0.04,-0.06);tip=min(tip,sTap(p,a,c,0.11,0.025));}   // すその切れはし
 vec2 r=vec2(tip,15.0);
 {  float th=9.0;for(int k=0;k<7;k++){float a=float(k)*0.9+0.3;vec3 c=vec3(cos(a)*0.42,1.42,sin(a)*0.36-0.02);th=min(th,sTap(p,c,c+vec3(0.0,-0.22-0.1*fract(float(k)*0.618),0.0),0.014,0.006));}r=U(r,vec2(th,19.0));   // かさからたれる菌糸
  float bl=9.0;for(int k=0;k<8;k++){float fk=float(k);float a=fk*1.7;vec3 c=vec3(cos(a)*(0.55+0.15*fract(fk*0.37)),0.6+0.9*fract(fk*0.618),sin(a)*0.45);bl=min(bl,length(p-c)-0.018-0.01*fract(fk*0.71));}r=U(r,vec2(bl,18.0));}   // 漂う胞子
 return r;}
vec4 xcol(vec3 p,vec3 n,float m){
 if(m>18.5&&m<19.5)return vec4(pow(vec3(0.85,0.82,0.7),vec3(2.2)),0.1);
 if(m>17.5&&m<18.5)return vec4(pow(vec3(0.75,1.0,0.5),vec3(2.2))*1.8,0.0);   // 光る胞子
if(m>15.5)return vec4(pow(vec3(0.05,0.06,0.16),vec3(2.2)),0.3);
 float lo=smoothstep(1.0,0.4,p.y);vec3 c=mix(vec3(0.84,0.88,0.78),vec3(0.55,0.62,0.5),lo);c=pow(c,vec3(2.2));c*=0.93+0.12*fbm(p*7.0);return vec4(c,0.25);}
