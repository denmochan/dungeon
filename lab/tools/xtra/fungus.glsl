// 菌糸の巣（11/28 本人が2D案A「キノコ蜘蛛」を選んだ）：お腹がピンクの水玉キノコのかさ（裏にひだ）・菌糸の白い脚（ふしと根毛）・6つの緑に光る目・かさに生えた小さなキノコ・脚からたれる菌糸
const float XK=0.03;
vec2 U(vec2 a,vec2 b){return b.x<a.x?b:a;}

vec2 fung(vec3 p){vec3 A=J[0],C=J[1];vec2 r=vec2(1e3,15.0);
 {vec3 q=p-A-vec3(0.0,0.02,-0.06);float cap=sEll(q,vec3(0.5,0.38,0.54));cap=max(cap,-(q.y+0.06));cap+=0.008*sin(atan(q.x,q.z)*10.0)*smoothstep(0.35,0.54,length(q.xz));r=U(r,vec2(cap,20.0));   // お腹＝キノコのかさ
  float gl=max(sEll(q-vec3(0.0,-0.05,0.0),vec3(0.47,0.08,0.51)),q.y+0.05);r=U(r,vec2(gl,21.0));   // かさの裏のひだ
  float st=sEll(q-vec3(0.0,-0.1,0.0),vec3(0.22,0.14,0.24));r=U(r,vec2(st,17.0));}   // かさの下の体
 {float ce=sEll(p-C,vec3(0.22,0.15,0.22));ce=smin(ce,sEll(p-C-vec3(0.0,0.05,0.09),vec3(0.16,0.09,0.12)),0.05);ce=smin(ce,sTap(p,C,A-vec3(0.0,0.08,-0.1),0.12,0.14),0.06);r=U(r,vec2(ce,17.0));}   // 頭胸部
 float lg=9.0,jt=9.0;
 for(int i=0;i<8;i++){float sx=i<4?-1.0:1.0;float k=float(i<4?i:i-4);
  vec3 base=C+vec3(sx*0.17,0.0,0.12-k*0.09);vec3 foot=vec3(sx*(0.82+0.06*sin(k*1.3)),0.02,0.62-k*0.42);vec3 knee=mix(base,foot,0.4)+vec3(sx*0.04,0.46,0.0);vec3 ank=mix(knee,foot,0.55)+vec3(sx*0.06,0.02,0.0);
  lg=min(lg,min(sTap(p,base,knee,0.05,0.04),min(sTap(p,knee,ank,0.038,0.028),sTap(p,ank,foot,0.026,0.01))));
  jt=min(jt,min(length(p-knee)-0.05,length(p-ank)-0.036));
  for(int h=0;h<2;h++){vec3 a=mix(knee,ank,0.3+0.4*float(h));lg=min(lg,sTap(p,a,a+vec3(sx*0.01,-0.12-0.05*float(h),0.0),0.01,0.002));}}   // 脚からたれる菌糸
 r=U(r,vec2(lg,16.0));r=U(r,vec2(jt,22.0));
 vec3 e=p-C;e.x=abs(e.x);
 float ey=min(length(e-vec3(0.05,0.07,0.2))-0.042,length(e-vec3(0.12,0.08,0.17))-0.03);ey=min(ey,length(e-vec3(0.08,0.13,0.15))-0.024);r=U(r,vec2(ey,23.0));   // 6つの目
 float ch=sTap(e,vec3(0.05,-0.04,0.18),vec3(0.05,-0.11,0.24),0.045,0.032);r=U(r,vec2(ch,17.0));
 {vec3 P0[4];float R0[4];P0[0]=A+vec3(-0.12,0.36,0.08);R0[0]=0.11;P0[1]=A+vec3(0.18,0.3,-0.12);R0[1]=0.085;P0[2]=A+vec3(-0.05,0.3,-0.3);R0[2]=0.07;P0[3]=A+vec3(0.28,0.22,0.12);R0[3]=0.06;
  for(int k=0;k<4;k++){vec3 t=P0[k]+vec3(0.0,R0[k]*1.4,0.0);r=U(r,vec2(sTap(p,P0[k]-vec3(0.0,0.05,0.0),t,R0[k]*0.28,R0[k]*0.22),24.0));vec3 q=p-t;float cp=max(sEll(q,vec3(R0[k],R0[k]*0.55,R0[k])),-q.y);r=U(r,vec2(cp,k==1?26.0:25.0));}}   // かさに生えた小さなキノコ
 return r;}
vec2 xmod(vec2 b,vec3 p){return fung(p);}
vec2 xbody(vec3 p){return vec2(1e3,15.0);}
float spots(vec3 d){float v=0.0;for(int k=0;k<11;k++){float fk=float(k)+0.5;float y=1.0-fk/11.0*0.85;float rr=sqrt(1.0-y*y);float a=fk*2.39996;vec3 c=vec3(rr*cos(a),y,rr*sin(a));float sz=0.16+0.06*sin(fk*3.7);v=max(v,1.0-smoothstep(sz-0.02,sz,acos(clamp(dot(d,c),-1.0,1.0))));}return v;}
vec4 xcol(vec3 p,vec3 n,float m){float sh=smoothstep(-0.4,0.9,n.y);
 if(m>25.5)return vec4(pow(vec3(0.46,0.32,0.62)*(0.74+0.34*sh),vec3(2.2)),0.4);   // 紫の小さなかさ
 if(m>24.5)return vec4(pow(vec3(0.82,0.44,0.16)*(0.74+0.34*sh),vec3(2.2)),0.4);   // だいだいの小さなかさ
 if(m>23.5)return vec4(pow(vec3(0.92,0.88,0.78)*(0.76+0.3*sh),vec3(2.2)),0.2);   // 小さなキノコの柄
 if(m>22.5)return vec4(pow(vec3(0.75,1.0,0.35),vec3(2.2))*1.7,0.6);   // 緑に光る目
 if(m>21.5)return vec4(pow(vec3(0.82,0.78,0.7)*(0.72+0.3*sh),vec3(2.2)),0.2);   // 脚のふし
 if(m>20.5){vec3 c=vec3(0.86,0.72,0.66)*(0.7+0.3*sh);c*=0.82+0.18*step(0.5,fract(atan(p.x-J[0].x,p.z-J[0].z+0.06)*14.0));return vec4(pow(c,vec3(2.2)),0.2);}   // かさの裏のひだ
 if(m>19.5){vec3 q=p-J[0]-vec3(0.0,0.02,-0.06);vec3 c=mix(vec3(0.62,0.2,0.42),vec3(0.86,0.36,0.6),smoothstep(-0.2,0.9,n.y));float sp=spots(normalize(q/vec3(0.5,0.38,0.54)));c=mix(c,vec3(0.98,0.92,0.88),sp*step(0.0,q.y));return vec4(pow(c,vec3(2.2)),0.45);}   // ピンクの水玉のかさ
 if(m>16.5){vec3 c=vec3(0.32,0.25,0.4)*(0.74+0.34*sh)*(0.9+0.2*fbm(p*16.0));return vec4(pow(c,vec3(2.2)),0.25);}   // 体（紫）
 vec3 c=vec3(0.92,0.88,0.8)*(0.74+0.3*sh)*(0.9+0.15*fbm(p*20.0));return vec4(pow(c,vec3(2.2)),0.2);}   // 菌糸の白い脚
