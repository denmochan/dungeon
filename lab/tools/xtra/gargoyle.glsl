// ガーゴイル：インプの形を石にして、大きなこうもりの翼（骨と、骨のあいだの膜）・太い角・先がとがった尾を足す
const float XK=0.04;
float xTri(vec3 p,vec3 a,vec3 b,vec3 c){vec3 ba=b-a,pa=p-a,cb=c-b,pb=p-b,ac=a-c,pc=p-c,nor=cross(ba,ac);
 return sqrt((sign(dot(cross(ba,nor),pa))+sign(dot(cross(cb,nor),pb))+sign(dot(cross(ac,nor),pc))<2.0)?min(min(dot(ba*clamp(dot(ba,pa)/dot(ba,ba),0.0,1.0)-pa,ba*clamp(dot(ba,pa)/dot(ba,ba),0.0,1.0)-pa),dot(cb*clamp(dot(cb,pb)/dot(cb,cb),0.0,1.0)-pb,cb*clamp(dot(cb,pb)/dot(cb,cb),0.0,1.0)-pb)),dot(ac*clamp(dot(ac,pc)/dot(ac,ac),0.0,1.0)-pc,ac*clamp(dot(ac,pc)/dot(ac,ac),0.0,1.0)-pc)):dot(nor,pa)*dot(nor,pa)/dot(nor,nor));}
vec2 xmod(vec2 b,vec3 p){return b;}
vec2 xbody(vec3 p){vec3 tp=TR*(p-J[0]);float d=9.0,dm=9.0;
 vec3 q=vec3(abs(tp.x),tp.y,tp.z),r=vec3(0.15,0.42,-0.17),t1=vec3(0.62,1.12,-0.46),t2=vec3(1.02,0.82,-0.5),t3=vec3(1.0,0.36,-0.48),t4=vec3(0.58,0.12,-0.4);
 d=min(d,sTap(q,r,t1,0.055,0.014));d=min(d,sTap(q,r,t2,0.05,0.013));d=min(d,sTap(q,r,t3,0.045,0.012));d=min(d,sTap(q,r,t4,0.04,0.011));
 dm=min(min(xTri(q,r,t1,t2),xTri(q,r,t2,t3)),xTri(q,r,t3,t4))-0.016;   // 骨と骨のあいだの膜
 dm=max(dm,-sEll(q-(t2+t3)*0.5-vec3(0.06,0.0,0.0),vec3(0.13,0.16,0.3)));dm=max(dm,-sEll(q-(t3+t4)*0.5-vec3(0.02,-0.06,0.0),vec3(0.14,0.13,0.3)));   // 膜のふちを切りこむ
 vec3 hp=HR*(p-J[2]);vec3 hq=vec3(abs(hp.x),hp.y,hp.z);float hn=min(sTap(hq,vec3(0.17,0.22,-0.02),vec3(0.30,0.46,-0.14),0.075,0.035),sTap(hq,vec3(0.30,0.46,-0.14),vec3(0.27,0.62,-0.32),0.035,0.008));
 float tl=min(sTap(tp,vec3(0.0,0.06,-0.2),vec3(0.0,-0.06,-0.58),0.065,0.035),sTap(tp,vec3(0.0,-0.06,-0.58),vec3(0.0,0.02,-0.86),0.035,0.014));tl=min(tl,sEll(tp-vec3(0.0,0.04,-0.9),vec3(0.09,0.03,0.07)));
 d=min(d,min(hn,tl));return d<dm?vec2(d,15.0):vec2(dm,16.0);}
vec4 xcol(vec3 p,vec3 n,float m){vec3 c=m<15.5?pow(vec3(0.46,0.46,0.5),vec3(2.2))*(0.78+0.4*fbm(p*9.0)):pow(vec3(0.34,0.33,0.4),vec3(2.2))*(0.85+0.25*fbm(p*5.0));return vec4(c,0.05);}
