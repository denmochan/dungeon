// 冥王：金の冠（とげ）と、背中の大きな赤い翼（骨と膜）
const float XK=0.03;
float xTri(vec3 p,vec3 a,vec3 b,vec3 c){vec3 ba=b-a,pa=p-a,cb=c-b,pb=p-b,ac=a-c,pc=p-c,nor=cross(ba,ac);
 return sqrt((sign(dot(cross(ba,nor),pa))+sign(dot(cross(cb,nor),pb))+sign(dot(cross(ac,nor),pc))<2.0)?min(min(dot(ba*clamp(dot(ba,pa)/dot(ba,ba),0.0,1.0)-pa,ba*clamp(dot(ba,pa)/dot(ba,ba),0.0,1.0)-pa),dot(cb*clamp(dot(cb,pb)/dot(cb,cb),0.0,1.0)-pb,cb*clamp(dot(cb,pb)/dot(cb,cb),0.0,1.0)-pb)),dot(ac*clamp(dot(ac,pc)/dot(ac,ac),0.0,1.0)-pc,ac*clamp(dot(ac,pc)/dot(ac,ac),0.0,1.0)-pc)):dot(nor,pa)*dot(nor,pa)/dot(nor,nor));}
vec2 xmod(vec2 b,vec3 p){return b;}
vec2 xbody(vec3 p){vec3 tp=TR*(p-J[0]);vec3 q=vec3(abs(tp.x),tp.y,tp.z),r=vec3(0.17,0.5,-0.2),t1=vec3(0.7,1.45,-0.5),t2=vec3(1.25,1.05,-0.55),t3=vec3(1.25,0.45,-0.52),t4=vec3(0.7,0.15,-0.42);
 float d=min(min(sTap(q,r,t1,0.065,0.016),sTap(q,r,t2,0.06,0.015)),min(sTap(q,r,t3,0.05,0.013),sTap(q,r,t4,0.045,0.012)));
 float dm=min(min(xTri(q,r,t1,t2),xTri(q,r,t2,t3)),xTri(q,r,t3,t4))-0.018;dm=max(dm,-sEll(q-(t2+t3)*0.5-vec3(0.08,0.0,0.0),vec3(0.16,0.2,0.3)));dm=max(dm,-sEll(q-(t3+t4)*0.5-vec3(0.03,-0.08,0.0),vec3(0.17,0.16,0.3)));
 vec3 hp=HR*(p-J[2]);float cr=sTap(hp,vec3(0.0,0.26,0.0),vec3(0.0,0.33,0.0),0.25,0.25);for(int i=0;i<7;i++){float a=float(i)*0.8976;cr=min(cr,sTap(hp,vec3(cos(a)*0.22,0.32,sin(a)*0.22),vec3(cos(a)*0.25,0.52,sin(a)*0.25),0.05,0.008));}
 cr=max(cr,-sTap(hp,vec3(0.0,0.2,0.0),vec3(0.0,0.6,0.0),0.2,0.2));
 if(cr<d&&cr<dm)return vec2(cr,17.0);return d<dm?vec2(d,15.0):vec2(dm,16.0);}
vec4 xcol(vec3 p,vec3 n,float m){vec3 c=m<15.5?vec3(0.22,0.16,0.2):m<16.5?vec3(0.6,0.1,0.12):vec3(0.95,0.75,0.25);return vec4(pow(c,vec3(2.2))*(0.85+0.25*fbm(p*7.0)),m>16.5?0.6:0.05);}
