// コボルト（11/28 形はそのまま、毛並み・ほおと胸の毛・眉・つめ・ベルトと袋・口の線・耳の内の色を足した）
#define XSKIN 1
vec4 xskin(vec3 p,vec3 n,float m){vec3 H=J[2];vec3 h=p-H;
 float st=fbm(p*vec3(9.0,34.0,9.0));vec3 c=mix(vec3(0.42,0.3,0.2),vec3(0.62,0.47,0.32),0.35+0.4*st);
 float lite=max(smoothstep(-0.08,-0.16,h.y)*step(0.15,h.z)*step(h.z,0.8)*smoothstep(-0.2,-0.6,n.y-0.0+0.0),smoothstep(0.4,0.8,n.z)*smoothstep(0.22,0.0,abs(p.x))*smoothstep(0.35,0.05,p.y-J[1].y)*smoothstep(-0.25,0.0,p.y-J[1].y));c=mix(c,vec3(0.93,0.86,0.72),lite*0.7);   // 鼻づらの下・胸・腹は明るい
 c=mix(c,vec3(0.22,0.15,0.1),smoothstep(-0.2,-0.6,n.z)*smoothstep(0.3,0.9,p.y)*0.55);   // 背中のくら（暗い）
 float ear=step(0.3,h.y)*step(0.18,abs(h.x))*step(h.z,0.12)*smoothstep(0.0,0.4,n.z);c=mix(c,vec3(0.5,0.32,0.28),ear*0.6*step(h.y,0.6));c=mix(c,vec3(0.22,0.15,0.1),step(0.62,h.y)*step(0.15,abs(h.x)));   // 耳の内は桃色、先は暗い
 if(h.z>0.27&&h.z<0.63&&abs(h.y+0.088+0.01*h.z)<0.016&&abs(h.x)>0.015)c*=0.25;   // 口の切れこみの奥は暗く（形のみぞの中だけ）
 return vec4(pow(c,vec3(2.2)),0.05);}
const float XK=0.035;
float kBox(vec3 p,vec3 b){vec3 q=abs(p)-b;return length(max(q,0.0))+min(max(q.x,max(q.y,q.z)),0.0);}
vec2 xmod(vec2 b,vec3 p){if(b.y>1.5&&b.y<2.5&&p.y<J[2].y)b.x=max(b.x,0.03);   // 前歯2本（間がぬけて見えた）は消す
 vec3 h=p-J[2];if(b.y<1.5&&abs(h.x)<0.17&&h.y>0.0&&length(h.xz)<0.45){float cut=(h.y-0.24)+0.4*(h.z-0.05);b.x=-smin(-b.x,-cut,0.08);}   // 頭のてっぺんを低く、ひたいを鼻づらへ寝かせる（まるい頭が可愛く見えた）
 if(b.y>5.5&&b.y<6.5)b.y=24.0;   // 目玉を琥珀色に（形の目。絵は貼らない）
 if(b.y<1.5)b.x-=0.014*(fbm(p*vec3(16.0,30.0,16.0))-0.5);return b;}   // 毛のでこぼこ
vec2 xbody(vec3 p){vec3 H=J[2];vec3 h=p-H;vec3 e=vec3(abs(h.x),h.y,h.z);
 float d=9.0;
 for(int k=0;k<3;k++){float fk=float(k);d=smin(d,sTap(e,vec3(0.22,-0.04-0.08*fk,-0.02-0.04*fk),vec3(0.36+0.03*fk,-0.12-0.09*fk,-0.14-0.04*fk),0.06,0.012),0.04);}   // ほおの毛のふさ（鼻づらから離して、後ろへ）
 d=smin(d,sTap(e,vec3(0.05,0.13,0.36),vec3(0.24,0.21,0.27),0.045,0.03),0.03);   // けわしい眉（内が低いＶ字）

 for(int k=0;k<7;k++){float a=(float(k)-3.0)*0.38;vec3 c=J[1]+vec3(sin(a)*0.24,0.16-0.05*abs(float(k)-3.0),0.16+cos(a)*0.08);d=min(d,sTap(p,c,c+vec3(sin(a)*0.05,-0.16,0.05),0.075,0.012));}   // 胸の毛のふさ
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;vec3 sh=(s==0?J[3]:J[6]);for(int k=0;k<3;k++){vec3 c=sh+vec3(sg*(0.04+0.06*float(k)),0.08,0.06-0.08*float(k));d=min(d,sTap(p,c,c+vec3(sg*0.08,-0.08,-0.02),0.06,0.01));}}   // 肩の毛
 vec2 r=vec2(d,1.0);
 {vec3 c=vec3(0.16,0.08,0.32);float eb=length(e-c)-0.06;if(eb<r.x)r=vec2(eb,24.0);float lid=length(e-c)-0.07;lid=max(lid,-((e.y-c.y)-0.016-0.45*(e.x-c.x)));r.x=smin(r.x,lid,0.012);   // 目にかぶさる斜めのまぶた（内が低く、けわしい目）
  float pu=sEll(e-c-vec3(-0.006,-0.008,0.052),vec3(0.022,0.026,0.014));if(pu<r.x)r=vec2(pu,23.0);}   // 黒目
 float np=sEll(h-vec3(0.0,0.015,0.7),vec3(0.05,0.032,0.04));if(np<r.x)r=vec2(np,23.0);   // 平たく広い犬の鼻
 float fg=9.0;for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;fg=min(fg,sTap(p,H+vec3(0.075*sg,-0.12,0.5),H+vec3(0.08*sg,-0.045,0.52),0.024,0.004));}if(fg<r.x)r=vec2(fg,17.0);   // 上下の牙（犬歯）
 float cl=9.0;for(int s=0;s<2;s++){vec3 ha=s==0?J[5]:J[8];float sg=s==0?-1.0:1.0;for(int k=0;k<3;k++){vec3 c=ha+vec3(sg*0.02+0.04*(float(k)-1.0),-0.06,0.08);cl=min(cl,sTap(p,c,c+vec3(0.0,-0.06,0.05),0.022,0.004));}
  vec3 f=s==0?J[15]:J[16];for(int k=0;k<3;k++){vec3 c=f+vec3(0.05*(float(k)-1.0),0.02,0.1);cl=min(cl,sTap(p,c,c+vec3(0.0,-0.03,0.06),0.022,0.004));}}
 if(cl<r.x)r=vec2(cl,17.0);   // 手と足のつめ
 float bt=max(abs(length((p-J[0]-vec3(0.0,0.14,0.0)).xz*vec2(1.0,1.12))-0.3)-0.025,abs(p.y-J[0].y-0.14)-0.04);float bk=kBox(p-J[0]-vec3(0.0,0.14,0.3),vec3(0.05,0.045,0.02))-0.008;
 float po=sEll(p-J[0]-vec3(-0.22,0.06,0.2),vec3(0.08,0.09,0.06));bt=min(bt,po);if(bt<r.x)r=vec2(bt,18.0);if(bk<r.x)r=vec2(bk,19.0);   // 革のベルト・金具・小さな袋
 return r;}
vec4 xcol(vec3 p,vec3 n,float m){
 if(m>23.5)return vec4(pow(vec3(1.0,0.5,0.08),vec3(2.2))*1.7,0.6);   // 琥珀色の目
 if(m>22.5)return vec4(pow(vec3(0.16,0.1,0.08),vec3(2.2)),0.9);   // 鼻
 if(m>21.5)return vec4(pow(vec3(0.3,0.85,1.0),vec3(2.2))*1.6,0.6);   // 宝石
 if(m>20.5)return vec4(pow(vec3(1.0,0.78,0.25),vec3(2.2))*1.2,0.8);   // 金貨
 if(m>19.5){vec3 c=vec3(0.66,0.56,0.4)*(0.8+0.35*fbm(p*vec3(10.0,24.0,10.0)));return vec4(pow(c,vec3(2.2)),0.03);}   // 麻の袋
 if(m>18.5)return vec4(pow(vec3(0.8,0.72,0.45),vec3(2.2)),0.7);   // 金具
 if(m>17.5){vec3 c=vec3(0.32,0.2,0.11)*(0.8+0.35*fbm(p*20.0));return vec4(pow(c,vec3(2.2)),0.2);}   // 革
 if(m>16.5)return vec4(pow(vec3(0.9,0.86,0.76),vec3(2.2)),0.2);   // つめ
 return vec4(1.0);}
