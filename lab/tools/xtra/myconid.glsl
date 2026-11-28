// キノコ（11/28 本人が2D案A「ねむりキノコ」を選んだ）：赤い水玉のかさ・ひだ・眠り顔（とじた目・ほおの赤み・小さな口）・ずんぐりした柄の体・小さな手足
const float XK=0.02;
vec2 U(vec2 a,vec2 b){return b.x<a.x?b:a;}

vec2 myco(vec3 p){vec2 r=vec2(1e3,15.0);
 float bd=sEll(p-vec3(0.0,0.3,0.0),vec3(0.2,0.26,0.19));bd=smin(bd,sEll(p-vec3(0.0,0.14,0.0),vec3(0.22,0.15,0.21)),0.08);r=U(r,vec2(bd,15.0));   // ずんぐりした柄の体
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;vec3 hd=s==0?J[2]:J[3];r=U(r,vec2(smin(sTap(p,vec3(0.16*sg,0.33,0.03),hd,0.05,0.04),length(p-hd)-0.05,0.03),15.0));   // 小さな手
  r=U(r,vec2(smin(sTap(p,vec3(0.09*sg,0.08,0.02),vec3(0.1*sg,0.02,0.06),0.06,0.055),sEll(p-vec3(0.1*sg,0.025,0.07),vec3(0.06,0.03,0.08)),0.03),15.0));}   // 短い足
 {vec3 q=p-vec3(0.0,0.56,0.0);float cap=sEll(q,vec3(0.47,0.38,0.45));cap=max(cap,-(q.y+0.02-0.05*smoothstep(0.2,0.46,length(q.xz))));cap+=0.006*sin(atan(q.x,q.z)*9.0)*smoothstep(0.3,0.46,length(q.xz));r=U(r,vec2(cap,16.0));   // 赤いかさ（ふちがゆるく波うつ）
  float gl=max(sEll(q-vec3(0.0,-0.02,0.0),vec3(0.42,0.08,0.4)),-sEll(q-vec3(0.0,-0.1,0.0),vec3(0.24,0.12,0.23)));gl=max(gl,q.y+0.02);r=U(r,vec2(gl,17.0));}   // かさの裏のひだ
 return r;}
vec2 xmod(vec2 b,vec3 p){return myco(p);}
vec2 xbody(vec3 p){return vec2(1e3,15.0);}
float spots(vec3 d){float v=0.0;for(int k=0;k<11;k++){float fk=float(k)+0.5;float y=1.0-fk/11.0*0.85;float rr=sqrt(1.0-y*y);float a=fk*2.39996;vec3 c=vec3(rr*cos(a),y,rr*sin(a));float sz=0.16+0.06*sin(fk*3.7);v=max(v,1.0-smoothstep(sz-0.02,sz,acos(clamp(dot(d,c),-1.0,1.0))));}return v;}
vec4 xcol(vec3 p,vec3 n,float m){float sh=smoothstep(-0.4,0.9,n.y);
 if(m>18.5)return vec4(pow(vec3(0.98,0.6,0.58),vec3(2.2)),0.2);   // ほおの赤み
 if(m>17.5)return vec4(pow(vec3(0.25,0.14,0.1),vec3(2.2)),0.2);   // 目と口
 if(m>16.5){vec3 c=vec3(0.86,0.76,0.6)*(0.7+0.3*sh);c*=0.85+0.15*step(0.5,fract(atan(p.x,p.z)*12.0));return vec4(pow(c,vec3(2.2)),0.2);}   // ひだ
 if(m>15.5){vec3 q=p-vec3(0.0,0.56,0.0);vec3 c=mix(vec3(0.7,0.12,0.12),vec3(0.95,0.3,0.25),smoothstep(-0.2,0.9,n.y));float sp=spots(normalize(q/vec3(0.47,0.38,0.45)));c=mix(c,vec3(1.0,0.96,0.88),sp*step(0.0,q.y));return vec4(pow(c,vec3(2.2)),0.45);}   // かさ（白い水玉）
 vec3 c=vec3(0.96,0.9,0.76)*(0.76+0.3*sh)*(0.95+0.1*fbm(p*14.0));return vec4(pow(c,vec3(2.2)),0.2);}   // 柄の体
