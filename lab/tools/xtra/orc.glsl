// オーク（11/28 作り直し2回目：本人「沼トロルの見た目がふつうのオーク」）：獣の毛皮を肩と背中にかぶり、革ひも、とさか髪。武器はこん棒
const float XK=0.07;
vec2 xmod(vec2 b,vec3 p){vec3 H=J[2];float cut=(p.y-(H.y+0.15))+0.45*(p.z-H.z-0.05);   // 頭のてっぺんを低く平らに、ひたいを後ろへ寝かせる
 float w=smoothstep(0.55,0.4,length((p-H).xz))*step(H.y-0.05,p.y);float k=0.06;float hb=max(b.x,cut);hb=mix(hb,b.x,0.0);
 if(b.y>1.5)return b;return vec2(mix(b.x,max(b.x,cut+0.0),w),b.y);}   // かぶとは削らない
float sBox3(vec3 p,vec3 b){vec3 q=abs(p)-b;return length(max(q,0.0))+min(max(q.x,max(q.y,q.z)),0.0);}
vec2 xbody(vec3 p){vec3 H=J[2];
 float d=sEll(p-vec3(0.0,1.03,-0.04),vec3(0.32,0.15,0.2));   // 首の後ろの盛り上がり
 d=smin(d,sEll(p-J[1]-vec3(0.0,0.06,0.05),vec3(0.46,0.3,0.27)),0.08);d=smin(d,sEll(p-J[1]-vec3(0.0,0.14,0.13),vec3(0.3,0.13,0.12)),0.06);   // 広い胸と胸板
 for(int s=0;s<2;s++){vec3 sh=s==0?J[3]:J[6],el=s==0?J[4]:J[7],ha=s==0?J[5]:J[8];float sg=s==0?-1.0:1.0;
  d=smin(d,sEll(p-sh-vec3(0.1*sg,0.07,0.0),vec3(0.21,0.19,0.19)),0.06);   // 肩
  d=smin(d,sTap(p,el,ha,0.135,0.11),0.05);d=smin(d,length(p-ha)-0.12,0.04);}   // 前腕・こぶし
 d=smin(d,sBox3(p-H-vec3(0.0,-0.15,0.1),vec3(0.19,0.08,0.13))-0.05,0.06);   // 四角く大きい下あご
 d=smin(d,sEll(p-H-vec3(0.0,-0.2,0.17),vec3(0.13,0.06,0.07)),0.04);   // あご先
 d=smin(d,sEll(p-H-vec3(0.0,0.07,0.17),vec3(0.24,0.065,0.09)),0.05);   // 重い眉（目にかぶさる）
 d=smin(d,sEll(p-H-vec3(0.0,-0.02,0.24),vec3(0.085,0.055,0.06)),0.04);   // 平たい広い鼻
 d=smin(d,sEll(p-H-vec3(0.0,0.0,-0.12),vec3(0.21,0.14,0.18)),0.08);   // 後ろに張った頭
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;d=smin(d,sTap(p,H+vec3(0.17*sg,0.02,-0.03),H+vec3(0.33*sg,0.08,-0.1),0.06,0.01),0.03);}   // 耳
 vec2 r=vec2(d,1.0);
 float tk=9.0;for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;vec3 a=H+vec3(0.13*sg,-0.14,0.2),m=H+vec3(0.16*sg,-0.06,0.22),t=H+vec3(0.13*sg,0.0,0.19);tk=min(tk,min(sTap(p,a,m,0.042,0.03),sTap(p,m,t,0.03,0.006)));}
 if(tk<r.x)r=vec2(tk,17.0);   // あごの両はしから上へ反る牙
 float hr=9.0;for(int i=0;i<5;i++){float f=float(i)/4.0;vec3 c=H+vec3(0.0,0.16-0.12*f,0.08-0.32*f);hr=min(hr,sTap(p,c,c+vec3(0.0,0.17-0.05*f,-0.07),0.07,0.015));}
 hr=smin(hr,sTap(p,H+vec3(0.0,0.03,-0.24),H+vec3(0.0,-0.18,-0.32),0.045,0.025),0.03);if(hr<r.x)r=vec2(hr,18.0);   // 黒いとさか髪
 {float pl=sEll(p-J[1]-vec3(0.0,0.2,-0.04),vec3(0.58,0.17,0.34));pl=smin(pl,sEll(p-J[1]-vec3(0.0,-0.02,-0.3),vec3(0.5,0.4,0.13)),0.08);   // 肩と背中にかぶった獣の毛皮
  for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;pl=smin(pl,sEll(p-(s==0?J[3]:J[6])-vec3(0.14*sg,0.14,0.0),vec3(0.28,0.17,0.28)),0.06);}
  pl+=0.035*(fbm(p*11.0)-0.5);pl=max(pl,-(p.y-(J[1].y-0.42+0.06*fbm(p*7.0))));if(pl<r.x)r=vec2(pl,24.0);
  float st=sTap(p,J[3]+vec3(0.02,0.08,0.24),J[0]+vec3(0.26,0.02,0.24),0.035,0.035);if(st<r.x)r=vec2(st,25.0);}   // ななめがけの革ひも
 return r;}
vec4 xcol(vec3 p,vec3 n,float m){
 if(m>29.5)return vec4(pow(vec3(0.42,0.55,0.3),vec3(2.2)),0.8);   // 泡
 if(m>28.5)return vec4(pow(vec3(0.05,0.04,0.04),vec3(2.2)),0.5);   // 狼の鼻と目
 if(m>27.5){vec3 c=mix(vec3(0.34,0.34,0.37),vec3(0.62,0.62,0.66),smoothstep(-0.3,0.8,n.y))*(0.8+0.35*fbm(p*vec3(9.0,22.0,9.0)));return vec4(pow(c,vec3(2.2)),0.04);}   // 狼の灰色の毛
 if(m>26.5){vec3 c=vec3(0.36,0.16,0.5)*(0.85+0.25*fbm(p*vec3(8.0,20.0,8.0)));return vec4(pow(c,vec3(2.2)),0.05);}   // 紫の布
 if(m>25.5){float w=fbm(p*6.0);vec3 c=mix(vec3(0.24,0.36,0.14),vec3(0.42,0.58,0.24),w);c=mix(c,vec3(0.62,0.78,0.4),smoothstep(0.62,0.72,fbm(p*11.0+3.0))*0.6);c=mix(c,vec3(0.16,0.2,0.08),smoothstep(0.6,0.75,fbm(p*3.0+7.0))*0.6);return vec4(pow(c,vec3(2.2)),0.75);}   // ぬるぬるの肌
 if(m>24.5)return vec4(pow(vec3(0.3,0.18,0.09)*(0.85+0.3*fbm(p*20.0)),vec3(2.2)),0.2);   // 革
 if(m>23.5){vec3 c=mix(vec3(0.3,0.19,0.1),vec3(0.52,0.36,0.2),smoothstep(-0.3,0.8,n.y))*(0.75+0.45*fbm(p*vec3(9.0,24.0,9.0)));return vec4(pow(c,vec3(2.2)),0.03);}   // 茶色い毛皮
 if(m>22.5)return vec4(pow(vec3(1.0,0.4,1.0),vec3(2.2))*2.6,0.0);   // 光る入れ墨
 if(m>21.5){float t=clamp((p.y-J[2].y-0.1)/0.3,0.0,1.0);return vec4(pow(mix(vec3(0.75,0.68,0.55),vec3(0.95,0.92,0.82),t),vec3(2.2)),0.2);}   // 骨・角
 if(m>20.5)return vec4(pow(vec3(0.45,0.6,0.22),vec3(2.2)),0.05);   // 水草
 if(m>19.5){float w=fbm(p*5.0);vec3 c=mix(vec3(0.07,0.09,0.05),vec3(0.16,0.19,0.09),w);c=mix(c,vec3(0.3,0.36,0.22),smoothstep(0.62,0.7,fbm(p*9.0))*0.5);return vec4(pow(c,vec3(2.2)),0.7);}   // 沼
 if(m>18.5){float w=fbm(p*7.0);vec3 c=mix(vec3(0.15,0.1,0.05),vec3(0.27,0.2,0.1),w);return vec4(pow(c,vec3(2.2)),0.45);}   // 泥
 if(m>17.5)return vec4(pow(vec3(0.07,0.06,0.06),vec3(2.2))*(0.8+0.4*fbm(p*30.0)),0.15);   // 黒い髪
 if(m>16.5){float t=clamp((p.y-J[2].y+0.14)/0.14,0.0,1.0);return vec4(pow(mix(vec3(0.78,0.7,0.5),vec3(0.96,0.93,0.84),t),vec3(2.2)),0.2);}   // 牙
 vec3 c=vec3(0.55,0.57,0.62)*(0.8+0.3*fbm(p*14.0));return vec4(pow(c,vec3(2.2)),0.5);}
