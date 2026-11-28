# ミミック（案A「くいしんぼう」）と呪いの宝箱（案A「すきまの霊」）（11/28 本人が2D案から選んだ）
# 箱の形はミミックの形をそのまま使い（ふたの開け閉めのため）、xbody で足す。XMIN=2.5 で木（4）・帯（5）・目（6）・舌（3）の色も xcol で付けなおす
# もとの形：箱 x±0.5・z-0.38〜0.36・y0〜0.78、ふたのちょうつがい y0.48・z-0.36。2 歯、3 舌、4 木、5 帯、6 奥の目
COMMON = '''const float XK=0.006;
vec2 xmod(vec2 b,vec3 p){return b;}
float hbx(vec3 p,vec3 b){vec3 q=abs(p)-b;return length(max(q,0.0))+min(max(q.x,max(q.y,q.z)),0.0);}
vec2 U(vec2 a,vec2 b){return b.x<a.x?b:a;}
// ふたの座標（ちょうつがいを中心に0.15だけ開いた向き）
vec3 lidP(vec3 p){vec3 q=p-vec3(0.0,0.48,-0.36);float a=0.15,ca=cos(a),sa=sin(a);return vec3(q.x,ca*q.y-sa*q.z,sa*q.y+ca*q.z);}
float wood(vec3 p,vec3 n){float pl=abs(n.y)>0.6?p.z:p.y;float ln=smoothstep(0.0,0.012,abs(fract(pl*7.0)-0.5)-0.47);return 1.0-0.35*(1.0-ln);}   // 板のすき間
'''

MIMIC = '''// ミミック（11/28 本人が2D案A「くいしんぼう」を選んだ）：鉄の帯とびょう・板目の木箱・金の錠前・口の奥の黄色い目・長い舌の先に金貨・足もとにこぼれた金貨
''' + COMMON + '''
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
'''
open('xtra/mimic.glsl', 'w').write(MIMIC)

HAUNT = '''// 呪いの宝箱（11/28 本人が2D案A「すきまの霊」を選んだ）：黒ずんだ木箱と真ちゅうの帯・鎖でしばる・お札（赤い字）・ふたのすきまから持ち主の霊が顔と両手を出す
''' + COMMON + '''
float xTor(vec3 p,float R,float r){vec2 q=vec2(length(p.xz)-R,p.y);return length(q)-r;}
vec2 xbody(vec3 p){vec2 r=vec2(1e3,15.0);
 {float d=9.0;for(int k=0;k<2;k++){float xs=k==0?-0.27:0.27;for(int i=0;i<15;i++){float a=float(i)/14.0*3.1416;vec3 c=vec3(xs,0.36+0.47*sin(a),0.05+0.52*cos(a));vec3 t=normalize(vec3(0.0,0.47*cos(a),-0.52*sin(a)));vec3 q=p-c;
   vec3 ax=mod(float(i),2.0)<0.5?vec3(1.0,0.0,0.0):normalize(cross(t,vec3(1.0,0.0,0.0)));vec3 b2=cross(t,ax);vec3 l=vec3(dot(q,t)*0.8,dot(q,ax),dot(q,b2));d=min(d,xTor(l,0.04,0.013));}}r=U(r,vec2(d,15.0));}   // 鎖
 for(int i=0;i<2;i++){float x=i==0?-0.15:0.14;float tl=i==0?-0.12:0.1;vec3 q=p-vec3(x,0.24,0.375);float ca=cos(tl),sa=sin(tl);q.xy=vec2(ca*q.x-sa*q.y,sa*q.x+ca*q.y);q.z-=0.25*q.y*q.y;r=U(r,vec2(hbx(q,vec3(0.06,0.14,0.004))-0.003,16.0));}   // 箱のお札（少し反る）
 {vec3 l=lidP(p);vec3 q=vec3(l.x-0.02,l.y-0.12,l.z-0.735);float ca=cos(0.2),sa=sin(0.2);q.xy=vec2(ca*q.x-sa*q.y,sa*q.x+ca*q.y);r=U(r,vec2(hbx(q,vec3(0.05,0.11,0.004))-0.003,16.0));}   // ふたのお札
 {vec3 c=vec3(0.0,0.5,0.2);float hd=sEll(p-c,vec3(0.17,0.11,0.13));for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;hd=max(hd,-sEll(p-c-vec3(0.06*sg,0.03,0.12),vec3(0.032,0.04,0.05)));}r=U(r,vec2(hd,17.0));   // すきまからのぞく霊の頭（うつろな目）
  for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;r=U(r,vec2(length(p-c-vec3(0.06*sg,0.03,0.09))-0.022,18.0));}
  for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;for(int k=0;k<4;k++){float x=sg*(0.2+0.04*float(k));float ar=smin(sTap(p,vec3(x,0.5,0.28),vec3(x,0.6,0.38),0.018,0.015),sTap(p,vec3(x,0.6,0.38),vec3(x+0.005*sg,0.55,0.42),0.015,0.01),0.01);r=U(r,vec2(ar,17.0));}}}   // ふたのふちをつかむ霊の指
 return r;}
vec4 xcol(vec3 p,vec3 n,float m){float sh=smoothstep(-0.4,0.9,n.y);
 if(m>17.5)return vec4(pow(vec3(0.4,1.0,1.0),vec3(2.2))*2.0,0.6);   // 霊の光る目
 if(m>16.5){vec3 c=mix(vec3(0.55,0.82,0.9),vec3(0.86,0.98,1.0),sh)*(0.92+0.1*fbm(p*12.0));return vec4(pow(c,vec3(2.2))*1.25,0.4);}   // 霊（青白く光る）
 if(m>15.5){float dx=min(abs(p.x+0.15+0.12*(p.y-0.24)),abs(p.x-0.14+0.1*(p.y-0.24)));if(p.y>0.48)dx=abs(p.x-0.02);float ln=step(dx,0.008)+step(dx,0.03)*step(abs(fract(p.y*16.0)-0.5),0.1);vec3 c=mix(vec3(0.94,0.9,0.76),vec3(0.75,0.06,0.06),min(1.0,ln));c*=0.85+0.15*fbm(p*20.0);return vec4(pow(c,vec3(2.2)),0.1);}   // お札（赤い字の列）
 if(m>14.5){vec3 c=vec3(0.36,0.36,0.4)*(0.6+0.5*sh)*(0.85+0.25*fbm(p*25.0));return vec4(pow(c,vec3(2.2)),0.7);}   // 鎖（さび）
 if(m>5.5)return vec4(pow(vec3(0.6,0.95,1.0),vec3(2.2))*1.6,0.6);   // 口の奥の目（青白い）
 if(m>4.5){vec3 c=vec3(0.55,0.45,0.22)*(0.6+0.5*sh)*(0.8+0.3*fbm(p*20.0));return vec4(pow(c,vec3(2.2)),0.8);}   // くすんだ真ちゅうの帯
 if(m>3.5){vec3 c=mix(vec3(0.17,0.15,0.22),vec3(0.3,0.27,0.36),smoothstep(-0.3,0.9,n.y))*wood(p,n)*(0.85+0.25*fbm(p*vec3(6.0,30.0,6.0)));return vec4(pow(c,vec3(2.2)),0.3);}   // 黒ずんだ木
 vec3 c=vec3(0.36,0.14,0.3)*(0.7+0.4*sh);return vec4(pow(c,vec3(2.2)),0.5);}   // 舌（くすんだ紫）
'''
open('xtra/hauntchest.glsl', 'w').write(HAUNT)
print('ok')
