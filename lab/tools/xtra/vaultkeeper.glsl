// 宝物庫の番人（11/28 2D案「石の宝箱」）：石の箱に金の帯・ふたの正面にガーゴイルの顔（赤い目）・ふたの角・箱の横の石の翼・口の中に金貨・石の歯・奥の赤い目
const float XK=0.006;
vec2 xmod(vec2 b,vec3 p){if(b.y>2.5&&b.y<3.5)b.x+=0.08;return b;}   // 舌をしまう（口には金貨）
float hbx(vec3 p,vec3 b){vec3 q=abs(p)-b;return length(max(q,0.0))+min(max(q.x,max(q.y,q.z)),0.0);}
vec2 U(vec2 a,vec2 b){return b.x<a.x?b:a;}
vec3 lidP(vec3 p){vec3 q=p-vec3(0.0,0.48,-0.36);float a=0.15,ca=cos(a),sa=sin(a);return vec3(q.x,ca*q.y-sa*q.z,sa*q.y+ca*q.z);}
float seam(float x,float w){return 1.0-smoothstep(0.0,w,abs(x));}
vec3 stoneC(vec3 p,vec3 n,vec3 base){vec3 c=base*(0.72+0.36*smoothstep(-0.4,0.9,n.y))*(0.84+0.3*fbm(p*10.0));
 c*=1.0-0.55*seam(fbm(p*6.0)-0.5,0.012)*step(0.5,fbm(p*2.5+4.0));   // ひび
 c=mix(c,vec3(0.3,0.42,0.2)*(0.8+0.3*fbm(p*20.0)),0.75*smoothstep(0.66,0.72,fbm(p*5.0+1.0))*smoothstep(0.3,0.8,n.y));   // こけ
 return c;}

vec2 xbody(vec3 p){vec2 r=vec2(1e3,15.0);vec3 l=lidP(p);
 for(int s=0;s<2;s++){float sx=s==0?-0.33:0.33;float bb=max(hbx(p-vec3(sx,0.24,-0.01),vec3(0.05,0.245,0.385)),-hbx(p-vec3(sx,0.26,-0.01),vec3(0.07,0.22,0.36)));r=U(r,vec2(bb-0.004,15.0));
  float lb=max(hbx(vec3(l.x-sx,l.y-0.095,l.z-0.36),vec3(0.05,0.112,0.375)),-hbx(vec3(l.x-sx,l.y-0.075,l.z-0.36),vec3(0.07,0.112,0.355)));lb=max(lb,-l.y);r=U(r,vec2(lb-0.004,15.0));}   // 金の帯
 {vec3 q=vec3(l.x,l.y-0.1,l.z-0.72);float fc=sEll(q,vec3(0.15,0.1,0.06));for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;fc=smin(fc,sTap(q,vec3(0.02*sg,0.05,0.04),vec3(0.13*sg,0.08,0.03),0.026,0.02),0.02);}r=U(r,vec2(fc,16.0));   // ふたのガーゴイルの顔と眉
  for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;r=U(r,vec2(length(q-vec3(0.06*sg,0.01,0.05))-0.022,17.0));}}   // 顔の赤い目
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;r=U(r,vec2(smin(sTap(l,vec3(0.4*sg,0.18,0.6),vec3(0.5*sg,0.32,0.52),0.06,0.035),sTap(l,vec3(0.5*sg,0.32,0.52),vec3(0.46*sg,0.44,0.4),0.035,0.006),0.02),16.0));   // ふたの角
  vec3 q=p-vec3(0.5*sg,0.3,-0.05);q.x*=sg;float wg=max(abs(q.z+0.1*q.x)-0.03,max(-q.x,max(q.x-0.3,max(q.y-0.25+0.4*q.x,-(q.y+0.15-0.2*q.x)))));wg=max(wg,-(q.y+0.08-0.06*sin(q.x*30.0)));r=U(r,vec2(wg,16.0));}   // 箱の横の石の翼
 for(int k=0;k<7;k++){float fk=float(k);vec3 c=vec3(-0.3+0.1*fk,0.45+0.02*sin(fk*2.0),0.05+0.1*sin(fk*1.7+0.5));r=U(r,vec2(max(length(vec2(c.x,c.z)-vec2(p.x,p.z))-0.05,abs(p.y-c.y)-0.012),18.0));}   // 口の中の金貨
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;r=U(r,vec2(length(p-vec3(0.2*sg,0.47,-0.12))-0.04,17.0));}   // 奥の赤い目
 return r;}
vec4 xcol(vec3 p,vec3 n,float m){float sh=smoothstep(-0.4,0.9,n.y);
 if(m>17.5){vec3 c=vec3(0.98,0.76,0.25)*(0.6+0.55*sh);return vec4(pow(c,vec3(2.2)),0.9);}   // 金貨
 if(m>16.5)return vec4(pow(vec3(1.0,0.2,0.1),vec3(2.2))*2.0,0.6);   // 赤い目
 if(m>15.5)return vec4(pow(stoneC(p,n,vec3(0.56,0.55,0.53)),vec3(2.2)),0.3);   // 顔・角・翼
 if(m>14.5){vec3 c=vec3(0.86,0.66,0.26)*(0.6+0.55*sh)+vec3(0.25)*pow(max(0.0,n.y*0.7+n.z*0.4),8.0);return vec4(pow(c,vec3(2.2)),0.9);}   // 金の帯
 if(m>5.5)return vec4(pow(vec3(1.0,0.2,0.1),vec3(2.2))*2.0,0.6);
 if(m>4.5){vec3 c=vec3(0.86,0.66,0.26)*(0.6+0.55*sh);return vec4(pow(c,vec3(2.2)),0.9);}
 if(m>3.5){vec3 an=abs(n);float u=an.y>0.6?p.x:(an.x>an.z?p.z:p.x);float row=floor(p.y*6.0);float sm=max(seam(fract(p.y*6.0)-0.5,0.05)*step(an.y,0.6),seam(fract(u*4.0+0.5*row)-0.5,0.035));vec3 c=stoneC(p,n,vec3(0.62,0.6,0.56))*(1.0-0.4*sm);return vec4(pow(c,vec3(2.2)),0.3);}   // 石積みの箱
 if(m>2.5)return vec4(pow(vec3(0.3,0.08,0.1),vec3(2.2)),0.3);
 return vec4(pow(vec3(0.78,0.76,0.7)*(0.75+0.3*sh),vec3(2.2)),0.3);}   // 石の歯
