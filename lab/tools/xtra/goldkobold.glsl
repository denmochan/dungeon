// 金掘りコボルト（11/28 コボルトと同じ足し方に、背中の重い袋・のぞく金貨と宝石）
#define XSKIN 1
vec4 xskin(vec3 p,vec3 n,float m){vec3 H=J[2];vec3 h=p-H;
 float st=fbm(p*vec3(9.0,34.0,9.0));vec3 c=mix(vec3(0.62,0.45,0.2),vec3(0.86,0.66,0.3),0.35+0.4*st);
 float lite=max(smoothstep(-0.08,-0.16,h.y)*step(0.15,h.z)*step(h.z,0.8)*smoothstep(-0.2,-0.6,n.y-0.0+0.0),smoothstep(0.4,0.8,n.z)*smoothstep(0.22,0.0,abs(p.x))*smoothstep(0.35,0.05,p.y-J[1].y)*smoothstep(-0.25,0.0,p.y-J[1].y));c=mix(c,vec3(0.93,0.86,0.72),lite*0.7);   // 鼻づらの下・胸・腹は明るい
 c=mix(c,vec3(0.36,0.24,0.1),smoothstep(-0.2,-0.6,n.z)*smoothstep(0.3,0.9,p.y)*0.4);   // 背中のくら（暗い）
 float ear=step(0.3,h.y)*step(0.18,abs(h.x))*step(h.z,0.12)*smoothstep(0.0,0.4,n.z);c=mix(c,vec3(0.78,0.5,0.48),ear*0.75*step(h.y,0.6));c=mix(c,vec3(0.36,0.24,0.1),step(0.62,h.y)*step(0.15,abs(h.x)));   // 耳の内は桃色、先は暗い
 float mo=abs(h.y+0.085+0.02*h.z)-0.008;if(h.z>0.25&&h.z<0.62&&abs(h.x)>0.06&&abs(n.x)>0.55)c=mix(c,vec3(0.1,0.06,0.05),1.0-smoothstep(0.0,0.006,mo));   // 口の線
 return vec4(pow(c,vec3(2.2)),0.05);}
const float XK=0.035;
float kBox(vec3 p,vec3 b){vec3 q=abs(p)-b;return length(max(q,0.0))+min(max(q.x,max(q.y,q.z)),0.0);}
vec2 xmod(vec2 b,vec3 p){if(b.y<1.5)b.x-=0.014*(fbm(p*vec3(16.0,30.0,16.0))-0.5);return b;}   // 毛のでこぼこ
vec2 xbody(vec3 p){vec3 H=J[2];vec3 h=p-H;vec3 e=vec3(abs(h.x),h.y,h.z);
 float d=9.0;
 for(int k=0;k<4;k++){float fk=float(k);d=min(d,sTap(e,vec3(0.2,-0.02-0.07*fk,0.1-0.04*fk),vec3(0.34+0.03*fk,-0.1-0.09*fk,-0.06-0.04*fk),0.055,0.008));}   // ほおの毛のふさ
 d=smin(d,sEll(e-vec3(0.15,0.15,0.3),vec3(0.1,0.035,0.07)),0.03);   // 眉の毛
 for(int k=0;k<7;k++){float a=(float(k)-3.0)*0.38;vec3 c=J[1]+vec3(sin(a)*0.24,0.16-0.05*abs(float(k)-3.0),0.16+cos(a)*0.08);d=min(d,sTap(p,c,c+vec3(sin(a)*0.05,-0.16,0.05),0.075,0.012));}   // 胸の毛のふさ
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;vec3 sh=(s==0?J[3]:J[6]);for(int k=0;k<3;k++){vec3 c=sh+vec3(sg*(0.04+0.06*float(k)),0.08,0.06-0.08*float(k));d=min(d,sTap(p,c,c+vec3(sg*0.08,-0.08,-0.02),0.06,0.01));}}   // 肩の毛
 vec2 r=vec2(d,1.0);
 float cl=9.0;for(int s=0;s<2;s++){vec3 ha=s==0?J[5]:J[8];float sg=s==0?-1.0:1.0;for(int k=0;k<3;k++){vec3 c=ha+vec3(sg*0.02+0.04*(float(k)-1.0),-0.06,0.08);cl=min(cl,sTap(p,c,c+vec3(0.0,-0.06,0.05),0.022,0.004));}
  vec3 f=s==0?J[15]:J[16];for(int k=0;k<3;k++){vec3 c=f+vec3(0.05*(float(k)-1.0),0.02,0.1);cl=min(cl,sTap(p,c,c+vec3(0.0,-0.03,0.06),0.022,0.004));}}
 if(cl<r.x)r=vec2(cl,17.0);   // 手と足のつめ
 float bt=max(abs(length((p-J[0]-vec3(0.0,0.14,0.0)).xz*vec2(1.0,1.12))-0.3)-0.025,abs(p.y-J[0].y-0.14)-0.04);float bk=kBox(p-J[0]-vec3(0.0,0.14,0.3),vec3(0.05,0.045,0.02))-0.008;
 float po=sEll(p-J[0]-vec3(-0.22,0.06,0.2),vec3(0.08,0.09,0.06));bt=min(bt,po);if(bt<r.x)r=vec2(bt,18.0);if(bk<r.x)r=vec2(bk,19.0);   // 革のベルト・金具・小さな袋
 {float sk=sEll(p-J[1]-vec3(0.06,0.06,-0.36),vec3(0.3,0.34,0.26));sk=smin(sk,sTap(p,J[1]+vec3(0.06,0.36,-0.36),J[1]+vec3(0.06,0.46,-0.34),0.09,0.06),0.06);sk+=0.015*(fbm(p*12.0)-0.5);if(sk<r.x)r=vec2(sk,20.0);   // 背中の重い袋
  float sp=sTap(p,J[3]+vec3(0.0,0.08,0.18),J[0]+vec3(0.24,0.1,0.2),0.03,0.03);if(sp<r.x)r=vec2(sp,18.0);   // 袋のひも
  float gc=9.0;for(int k=0;k<5;k++){float a=float(k)*1.3;gc=min(gc,max(length((p-J[1]-vec3(0.06+0.12*cos(a),0.38+0.02*float(k),-0.36+0.1*sin(a))).xz)-0.055,abs(p.y-J[1].y-0.38-0.02*float(k))-0.012));}if(gc<r.x)r=vec2(gc,21.0);   // 袋からのぞく金貨
  float gm=9.0;for(int k=0;k<2;k++){vec3 c=J[1]+vec3(-0.08+0.2*float(k),0.42,-0.3);vec3 q=abs(p-c);gm=min(gm,(q.x+q.y+q.z-0.06)*0.577);}if(gm<r.x)r=vec2(gm,22.0);}   // 宝石
 return r;}
vec4 xcol(vec3 p,vec3 n,float m){
 if(m>21.5)return vec4(pow(vec3(0.3,0.85,1.0),vec3(2.2))*1.6,0.6);   // 宝石
 if(m>20.5)return vec4(pow(vec3(1.0,0.78,0.25),vec3(2.2))*1.2,0.8);   // 金貨
 if(m>19.5){vec3 c=vec3(0.66,0.56,0.4)*(0.8+0.35*fbm(p*vec3(10.0,24.0,10.0)));return vec4(pow(c,vec3(2.2)),0.03);}   // 麻の袋
 if(m>18.5)return vec4(pow(vec3(0.8,0.72,0.45),vec3(2.2)),0.7);   // 金具
 if(m>17.5){vec3 c=vec3(0.32,0.2,0.11)*(0.8+0.35*fbm(p*20.0));return vec4(pow(c,vec3(2.2)),0.2);}   // 革
 if(m>16.5)return vec4(pow(vec3(0.9,0.86,0.76),vec3(2.2)),0.2);   // つめ
 return vec4(1.0);}
