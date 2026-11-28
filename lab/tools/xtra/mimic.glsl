// ミミック（11/28 本人が2D案A「くいしんぼう」を選んだ）：鉄の帯とびょう・板目の木箱・金の錠前・口の奥の黄色い目・長い舌の先に金貨・足もとにこぼれた金貨
const float XK=0.006;
vec2 xmod(vec2 b,vec3 p){return b;}
float hbx(vec3 p,vec3 b){vec3 q=abs(p)-b;return length(max(q,0.0))+min(max(q.x,max(q.y,q.z)),0.0);}
vec2 U(vec2 a,vec2 b){return b.x<a.x?b:a;}
// ふたの座標（ちょうつがいを中心に0.15だけ開いた向き）
vec3 lidP(vec3 p){vec3 q=p-vec3(0.0,0.48,-0.36);float a=0.15,ca=cos(a),sa=sin(a);return vec3(q.x,ca*q.y-sa*q.z,sa*q.y+ca*q.z);}
float wood(vec3 p,vec3 n){float pl=abs(n.y)>0.6?p.z:p.y;float ln=smoothstep(0.0,0.012,abs(fract(pl*7.0)-0.5)-0.47);return 1.0-0.35*(1.0-ln);}   // 板のすき間

vec2 xbody(vec3 p){vec2 r=vec2(1e3,15.0);
 for(int s=0;s<2;s++){float sx=s==0?-0.33:0.33;
  float bb=max(hbx(p-vec3(sx,0.24,-0.01),vec3(0.045,0.245,0.385)),-hbx(p-vec3(sx,0.26,-0.01),vec3(0.06,0.22,0.36)));r=U(r,vec2(bb-0.004,15.0));   // 箱の鉄の帯（側面をぐるり）
  vec3 l=lidP(p);float lb=max(hbx(vec3(l.x-sx,l.y-0.095,l.z-0.36),vec3(0.045,0.112,0.375)),-hbx(vec3(l.x-sx,l.y-0.075,l.z-0.36),vec3(0.06,0.112,0.355)));lb=max(lb,-l.y);r=U(r,vec2(lb-0.004,15.0));   // ふたの鉄の帯
  for(int k=0;k<3;k++){r=U(r,vec2(length(p-vec3(sx,0.08+0.14*float(k),0.375))-0.018,16.0));}}   // びょう
 {vec3 l=lidP(p);r=U(r,vec2(hbx(vec3(l.x,l.y-0.07,l.z-0.735),vec3(0.07,0.075,0.014))-0.006,17.0));r=U(r,vec2(hbx(vec3(l.x,l.y-0.06,l.z-0.75),vec3(0.012,0.028,0.01)),18.0));}   // 金の錠前と鍵穴
 for(int k=0;k<6;k++){float fk=float(k);vec3 c=vec3(-0.45+0.18*fk+0.05*sin(fk*3.1),0.012+0.01*mod(fk,2.0),0.45+0.08*sin(fk*1.7));r=U(r,vec2(max(length(p.xz-c.xz)-0.055,abs(p.y-c.y)-0.01),17.0));}   // 足もとの金貨
 return r;}
vec4 xcol(vec3 p,vec3 n,float m){float sh=smoothstep(-0.4,0.9,n.y);
 if(m>17.5)return vec4(pow(vec3(0.08,0.05,0.04),vec3(2.2)),0.2);   // 鍵穴
 if(m>16.5){vec3 c=vec3(0.98,0.76,0.25)*(0.6+0.55*sh)+vec3(0.3)*pow(max(0.0,n.y*0.7+n.z*0.4),8.0);return vec4(pow(c,vec3(2.2)),0.9);}   // 金
 if(m>15.5){vec3 c=vec3(0.72,0.72,0.76)*(0.6+0.5*sh);return vec4(pow(c,vec3(2.2)),0.9);}   // びょう
 if(m>14.5){vec3 c=vec3(0.32,0.32,0.37)*(0.6+0.5*sh)*(0.9+0.2*fbm(p*30.0));return vec4(pow(c,vec3(2.2)),0.8);}   // 鉄の帯
 if(m>5.5)return vec4(pow(vec3(1.0,0.92,0.2),vec3(2.2))*1.8,0.6);   // 口の奥の黄色い目
 if(m>4.5){vec3 c=vec3(0.36,0.36,0.41)*(0.6+0.5*sh);return vec4(pow(c,vec3(2.2)),0.8);}   // 真ん中の帯も鉄に
 if(m>3.5){vec3 c=mix(vec3(0.5,0.29,0.13),vec3(0.68,0.42,0.2),smoothstep(-0.3,0.9,n.y))*wood(p,n)*(0.85+0.25*fbm(p*vec3(6.0,30.0,6.0)));return vec4(pow(c,vec3(2.2)),0.3);}   // 板目の木
 vec3 c=vec3(0.86,0.3,0.38)*(0.7+0.4*sh);return vec4(pow(c,vec3(2.2)),0.6);}   // 舌
