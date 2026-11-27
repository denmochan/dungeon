// 呪いの宝箱：箱を鎖でしばり、前にお札を3枚はる
const float XK=0.008;
vec2 xmod(vec2 b,vec3 p){return b;}
float xTor(vec3 p,float R,float r){vec2 q=vec2(length(p.xz)-R,p.y);return length(q)-r;}
vec2 xbody(vec3 p){float d=9.0,dm=9.0;
 for(int k=0;k<2;k++){float xs=k==0?-0.27:0.27;for(int i=0;i<15;i++){float a=float(i)/14.0*3.1416;vec3 c=vec3(xs,0.36+0.47*sin(a),0.05+0.52*cos(a));vec3 t=normalize(vec3(0.0,0.47*cos(a),-0.52*sin(a)));vec3 q=p-c;
   vec3 ax=mod(float(i),2.0)<0.5?vec3(1.0,0.0,0.0):normalize(cross(t,vec3(1.0,0.0,0.0)));vec3 b2=cross(t,ax);vec3 l=vec3(dot(q,t)*0.8,dot(q,ax),dot(q,b2));d=min(d,xTor(vec3(l.x,l.y,l.z),0.04,0.013));}}   // 鎖の輪（ひとつおきに向きを変える）
 for(int i=0;i<3;i++){float x=-0.3+0.3*float(i);vec3 q=p-vec3(x,0.33+0.04*float(i-1)*float(i-1),0.5);float ca=cos(0.15*float(i-1)),sa=sin(0.15*float(i-1));q.xy=vec2(ca*q.x-sa*q.y,sa*q.x+ca*q.y);vec3 e=abs(q)-vec3(0.065,0.13,0.004);dm=min(dm,length(max(e,0.0))+min(max(e.x,max(e.y,e.z)),0.0)-0.004);}   // お札
 return d<dm?vec2(d,15.0):vec2(dm,16.0);}
vec4 xcol(vec3 p,vec3 n,float m){if(m<15.5)return vec4(pow(vec3(0.42,0.42,0.46),vec3(2.2))*(0.8+0.3*fbm(p*20.0)),0.3);
 float st=step(0.02,abs(fract(p.y*14.0)-0.5));vec3 c=mix(vec3(0.75,0.1,0.08),vec3(0.95,0.92,0.82),st);return vec4(pow(c,vec3(2.2)),0.02);}
