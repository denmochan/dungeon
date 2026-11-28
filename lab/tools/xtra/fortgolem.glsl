// 城塞ゴーレム（11/28 2D案「動く城壁」）：石積みの体・肩の胸壁・胸の鉄格子の門・明かりのついた窓・肩の旗・背中の飾りの石の翼・関節を縛る縄・光る目
const float XK=0.01;
#define XSKIN 1
vec2 xmod(vec2 b,vec3 p){return b;}
float hbx(vec3 p,vec3 b){vec3 q=abs(p)-b;return length(max(q,0.0))+min(max(q.x,max(q.y,q.z)),0.0);}
vec2 U(vec2 a,vec2 b){return b.x<a.x?b:a;}
float ringAt(vec3 p,vec3 a,vec3 b,float t,float R,float r){vec3 ax=normalize(b-a);vec3 c=mix(a,b,t);vec3 q=p-c;float h=dot(q,ax);float rd=length(q-ax*h);return length(vec2(rd-R,h))-r;}
float seam(float x,float w){return 1.0-smoothstep(0.0,w,abs(x));}
vec3 stoneC(vec3 p,vec3 n,vec3 base){vec3 c=base*(0.72+0.36*smoothstep(-0.4,0.9,n.y))*(0.84+0.3*fbm(p*10.0));
 c*=1.0-0.55*seam(fbm(p*6.0)-0.5,0.012)*step(0.5,fbm(p*2.5+4.0));   // ひび
 c=mix(c,vec3(0.3,0.42,0.2)*(0.8+0.3*fbm(p*20.0)),0.75*smoothstep(0.66,0.72,fbm(p*5.0+1.0))*smoothstep(0.3,0.8,n.y));   // こけ
 return c;}

vec2 xbody(vec3 p){vec2 r=vec2(1e3,15.0);float rp=9.0;
 for(int s=0;s<2;s++){vec3 a=s==0?J[3]:J[6],b=s==0?J[4]:J[7],c=s==0?J[5]:J[8];rp=min(rp,ringAt(p,a,b,0.85,0.15,0.024));vec3 h=s==0?J[9]:J[12],k=s==0?J[10]:J[13];rp=min(rp,ringAt(p,h,k,0.85,0.15,0.024));}r=U(r,vec2(rp,8.0));   // 縄
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;for(int k=0;k<2;k++){for(int j=0;j<2;j++){vec3 c=vec3(sg*(0.3+0.2*float(k)),1.22,-0.06+0.2*float(j));r=U(r,vec2(hbx(p-c,vec3(0.045,0.05,0.045))-0.008,16.0));}}}   // 肩の胸壁
 {vec3 q=p-vec3(0.0,0.62,0.3);float gate=min(hbx(q-vec3(0.0,-0.04,0.0),vec3(0.1,0.1,0.02)),max(length(q.xy-vec2(0.0,0.06))-0.1,abs(q.z)-0.02));r=U(r,vec2(gate,17.0));   // 門の暗い口
  for(int k=0;k<4;k++){float x=-0.06+0.04*float(k);r=U(r,vec2(sTap(p,vec3(x,0.5,0.33),vec3(x,0.74,0.33),0.01,0.01),18.0));}r=U(r,vec2(sTap(p,vec3(-0.1,0.64,0.33),vec3(0.1,0.64,0.33),0.01,0.01),18.0));
  float ar=max(abs(length(q.xy-vec2(0.0,0.06))-0.125)-0.025,max(abs(q.z-0.01)-0.025,-(q.y-0.06)));ar=min(ar,max(abs(abs(q.x)-0.125)-0.025,max(abs(q.z-0.01)-0.025,abs(q.y+0.03)-0.09)));r=U(r,vec2(ar,16.0));}   // 門と石のアーチ
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;r=U(r,vec2(hbx(p-vec3(0.24*sg,0.9,0.32),vec3(0.03,0.045,0.02)),19.0));}   // 明かりのついた窓
 r=U(r,vec2(sTap(p,vec3(-0.45,1.2,-0.06),vec3(-0.45,1.75,-0.06),0.012,0.012),20.0));r=U(r,vec2(hbx(p-vec3(-0.38,1.68,-0.06)-vec3(0.0,0.0,0.0),vec3(0.07,0.05,0.006)),21.0));   // 旗
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;vec3 q=p-vec3(0.2*sg,1.0,-0.22);q.x*=sg;float wg=max(abs(q.z+0.25*q.x)-0.03,max(-q.x,max(q.x-0.55,max(q.y-0.15-0.5*q.x+0.6*max(0.0,q.x-0.35),-(q.y+0.3-0.3*q.x)))));wg=max(wg,-(q.y+0.25-0.3*q.x-0.06*sin(q.x*25.0)));r=U(r,vec2(wg,16.0));}   // 背中の飾りの石の翼
 return r;}
vec4 xskin(vec3 p,vec3 n,float m){vec3 an=abs(n);float u=an.y>0.6?p.x:(an.x>an.z?p.z:p.x);float row=floor(p.y*5.0);
 float sm=max(seam(fract(p.y*5.0)-0.5,0.05)*step(an.y,0.6),seam(fract(u*4.0+0.5*row)-0.5,0.035));vec3 c=stoneC(p,n,vec3(0.55,0.52,0.47))*(1.0-0.45*sm);return vec4(pow(c,vec3(2.2)),0.3);}
vec4 xcol(vec3 p,vec3 n,float m){float sh=smoothstep(-0.4,0.9,n.y);
 if(m>20.5)return vec4(pow(vec3(0.78,0.12,0.14)*(0.8+0.3*sh),vec3(2.2)),0.3);   // 旗の布
 if(m>19.5)return vec4(pow(vec3(0.4,0.28,0.16)*(0.8+0.3*sh),vec3(2.2)),0.3);   // 旗ざお
 if(m>18.5)return vec4(pow(vec3(1.0,0.8,0.35),vec3(2.2))*1.8,0.6);   // 窓の明かり
 if(m>17.5)return vec4(pow(vec3(0.3,0.3,0.34)*(0.6+0.5*sh),vec3(2.2)),0.8);   // 鉄格子
 if(m>16.5)return vec4(pow(vec3(0.05,0.03,0.03),vec3(2.2)),0.1);   // 門の奥
 if(m>15.5)return vec4(pow(stoneC(p,n,vec3(0.6,0.57,0.52)),vec3(2.2)),0.3);   // 胸壁・アーチ・翼
 vec3 c=vec3(0.72,0.58,0.36)*(0.74+0.34*sh)*(0.85+0.2*sin(dot(p,vec3(60.0,60.0,0.0))));return vec4(pow(c,vec3(2.2)),0.2);}   // 縄
