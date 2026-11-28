// 千眼蜘蛛（11/28）：蜘蛛の形に、背中に大小9つの目玉（白目・赤い虹彩・黒いひとみ）
const float XK=0.03;
vec2 U(vec2 a,vec2 b){return b.x<a.x?b:a;}
float sTri2(vec2 p,vec2 a,vec2 b,vec2 c){vec2 e0=b-a,e1=c-b,e2=a-c,v0=p-a,v1=p-b,v2=p-c;
 vec2 pq0=v0-e0*clamp(dot(v0,e0)/dot(e0,e0),0.0,1.0),pq1=v1-e1*clamp(dot(v1,e1)/dot(e1,e1),0.0,1.0),pq2=v2-e2*clamp(dot(v2,e2)/dot(e2,e2),0.0,1.0);
 float s=sign(e0.x*e2.y-e0.y*e2.x);vec2 d=min(min(vec2(dot(pq0,pq0),s*(v0.x*e0.y-v0.y*e0.x)),vec2(dot(pq1,pq1),s*(v1.x*e1.y-v1.y*e1.x))),vec2(dot(pq2,pq2),s*(v2.x*e2.y-v2.y*e2.x)));return -sqrt(d.x)*sign(d.y);}
vec2 spid(vec3 p){vec3 A=J[0],C=J[1];
 float ab=sEll(p-A-vec3(0.0,0.02,-0.04),vec3(0.4,0.33,0.46));ab-=0.012*(fbm(p*22.0)-0.5);   // お腹（毛のでこぼこ）
 float ce=sEll(p-C,vec3(0.25,0.17,0.25));ce=smin(ce,sEll(p-C-vec3(0.0,0.06,0.1),vec3(0.18,0.1,0.14)),0.05);   // 頭胸部
 float bd=smin(ab,ce,0.06);vec2 r=vec2(bd,15.0);
 float lg=9.0,jt=9.0;
 for(int i=0;i<8;i++){float sx=i<4?-1.0:1.0;float k=float(i<4?i:i-4);
  vec3 base=C+vec3(sx*0.19,0.0,0.14-k*0.1);vec3 foot=vec3(sx*(0.82+0.06*sin(k*1.3)),0.02,0.62-k*0.42);vec3 knee=mix(base,foot,0.4)+vec3(sx*0.04,0.44,0.0);vec3 ank=mix(knee,foot,0.55)+vec3(sx*0.06,0.02,0.0);
  lg=min(lg,min(sTap(p,base,knee,0.065,0.05),min(sTap(p,knee,ank,0.048,0.036),sTap(p,ank,foot,0.034,0.014))));
  jt=min(jt,min(length(p-knee)-0.06,length(p-ank)-0.044));   // ふしのふくらみ
  for(int h=0;h<3;h++){vec3 a=mix(base,knee,0.3+0.25*float(h));lg=min(lg,sTap(p,a+vec3(0.0,0.03,0.0),a+vec3(sx*0.04,0.09,0.02*float(h-1)),0.014,0.003));}}   // 脚の毛
 r=U(r,vec2(min(lg,jt),16.0));
 vec3 e=p-C;e.x=abs(e.x);
 float ey=min(length(e-vec3(0.055,0.08,0.23))-0.045,length(e-vec3(0.13,0.09,0.19))-0.032);ey=min(ey,min(length(e-vec3(0.08,0.15,0.17))-0.026,length(e-vec3(0.15,0.14,0.11))-0.022));r=U(r,vec2(ey,22.0));   // 8つの目
 float ch=sTap(e,vec3(0.06,-0.04,0.2),vec3(0.06,-0.12,0.27),0.055,0.04);r=U(r,vec2(ch,17.0));float fg=sTap(e,vec3(0.06,-0.13,0.27),vec3(0.035,-0.22,0.25),0.03,0.004);r=U(r,vec2(fg,26.0));   // あごと牙
 float pp=sTap(e,vec3(0.12,-0.05,0.2),vec3(0.17,-0.1,0.36),0.03,0.02);r=U(r,vec2(pp,16.0));   // しょくし
 for(int k=0;k<10;k++){float fk=float(k);float a=fk*2.4,el=0.45+0.8*fract(fk*0.618);vec3 dir=normalize(vec3(cos(a)*cos(el),sin(el),sin(a)*cos(el)*1.1));vec3 c=J[0]+vec3(0.0,0.02,-0.04)+dir*vec3(0.38,0.32,0.44);float s=0.075+0.05*fract(fk*0.37);r=U(r,vec2(length(p-c)-s,23.0));}   // 背中じゅうに並ぶ目玉
 return r;}
vec2 xmod(vec2 b,vec3 p){return spid(p);}
vec2 xbody(vec3 p){return vec2(1e3,15.0);}
vec4 xcol(vec3 p,vec3 n,float m){
 if(m>25.5)return vec4(pow(vec3(0.92,0.88,0.8),vec3(2.2)),0.3);   // 牙
 if(m>22.5&&m<23.5){float best=9.0;vec3 cc=vec3(0.0);float ss=0.06;for(int k=0;k<10;k++){float fk=float(k);float a=fk*2.4,el=0.45+0.8*fract(fk*0.618);vec3 dir=normalize(vec3(cos(a)*cos(el),sin(el),sin(a)*cos(el)*1.1));vec3 c=J[0]+vec3(0.0,0.02,-0.04)+dir*vec3(0.38,0.32,0.44);float s=0.075+0.05*fract(fk*0.37);float dd=abs(length(p-c)-s);if(dd<best){best=dd;cc=c;ss=s;}}
  vec3 q=normalize(p-cc);vec3 look=normalize(normalize(cc-J[0])+0.25*vec3(sin(cc.x*40.0),0.0,cos(cc.z*40.0)));float a=acos(clamp(dot(q,look),-1.0,1.0));vec3 c=vec3(0.93,0.9,0.84);c=mix(c,vec3(0.8,0.12,0.1),1.0-smoothstep(0.5,0.56,a));c=mix(c,vec3(0.03),1.0-smoothstep(0.24,0.28,a));return vec4(pow(c,vec3(2.2)),0.5);}   // 目玉
 if(m>21.5)return vec4(pow(vec3(1.0,0.12,0.08),vec3(2.2))*2.2,0.6);   // 赤く光る目
 if(m>16.5)return vec4(pow(vec3(0.1,0.07,0.08),vec3(2.2)),0.4);   // あご
 if(m>15.5){vec3 c=vec3(0.18,0.14,0.16)*(0.8+0.3*fbm(p*20.0));float band=0.0;return vec4(pow(c,vec3(2.2)),0.15);}   // 脚
 vec3 lp=p-J[0];vec3 c=mix(vec3(0.2,0.16,0.18),vec3(0.36,0.28,0.32),smoothstep(-0.3,0.8,n.y))*(0.8+0.3*fbm(p*vec3(12.0,12.0,20.0)));
 float mk=0.0;c=mix(c,vec3(0,0,0),mk);return vec4(pow(c,vec3(2.2)),0.2);}
