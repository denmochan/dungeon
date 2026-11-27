// 目玉コウモリ：目玉の左右に、大きく広げたこうもりの翼（前からも両方見える）
const float XK=0.03;
float xTri(vec3 p,vec3 a,vec3 b,vec3 c){vec3 ba=b-a,pa=p-a,cb=c-b,pb=p-b,ac=a-c,pc=p-c,nor=cross(ba,ac);
 return sqrt((sign(dot(cross(ba,nor),pa))+sign(dot(cross(cb,nor),pb))+sign(dot(cross(ac,nor),pc))<2.0)?min(min(dot(ba*clamp(dot(ba,pa)/dot(ba,ba),0.0,1.0)-pa,ba*clamp(dot(ba,pa)/dot(ba,ba),0.0,1.0)-pa),dot(cb*clamp(dot(cb,pb)/dot(cb,cb),0.0,1.0)-pb,cb*clamp(dot(cb,pb)/dot(cb,cb),0.0,1.0)-pb)),dot(ac*clamp(dot(ac,pc)/dot(ac,ac),0.0,1.0)-pc,ac*clamp(dot(ac,pc)/dot(ac,ac),0.0,1.0)-pc)):dot(nor,pa)*dot(nor,pa)/dot(nor,nor));}
vec2 xmod(vec2 b,vec3 p){return b;}
vec2 xbody(vec3 p){vec3 q=vec3(abs(p.x),p.y,p.z),r=vec3(0.32,1.12,-0.12),t1=vec3(0.9,1.62,-0.2),t2=vec3(1.22,1.12,-0.22),t3=vec3(0.95,0.72,-0.18);
 float d=min(min(sTap(q,r,t1,0.04,0.012),sTap(q,r,t2,0.035,0.01)),sTap(q,r,t3,0.03,0.01));float dm=min(xTri(q,r,t1,t2),xTri(q,r,t2,t3))-0.014;
 dm=max(dm,-sEll(q-(t1+t2)*0.5-vec3(0.06,0.04,0.0),vec3(0.12,0.12,0.3)));dm=max(dm,-sEll(q-(t2+t3)*0.5-vec3(0.06,-0.02,0.0),vec3(0.12,0.11,0.3)));
 return d<dm?vec2(d,15.0):vec2(dm,16.0);}
vec4 xcol(vec3 p,vec3 n,float m){vec3 c=m<15.5?vec3(0.3,0.18,0.32):vec3(0.5,0.25,0.55);return vec4(pow(c,vec3(2.2))*(0.85+0.25*fbm(p*6.0)),0.05);}
