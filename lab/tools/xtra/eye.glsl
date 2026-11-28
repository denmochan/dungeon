// 浮遊眼（11/28 2D案「まぶたのない目」）：血管の走る白目・金のふちの赤い虹彩・たての瞳孔・下の肉のえり・吸盤のつぶのある5本の触手・上の短い2本の角
const float XK=0.02;
vec2 U(vec2 a,vec2 b){return b.x<a.x?b:a;}
float hbx(vec3 p,vec3 b){vec3 q=abs(p)-b;return length(max(q,0.0))+min(max(q.x,max(q.y,q.z)),0.0);}
float seam(float x,float w){return 1.0-smoothstep(0.0,w,abs(x));}
// 目玉の色（中心 c・半径 R・前の向き +z）：白目に血管、金のふちの虹彩、たての瞳孔
vec3 eyeCol(vec3 p,vec3 n,vec3 c,float R,vec3 iris){vec3 d=normalize(p-c);float a=acos(clamp(d.z,-1.0,1.0));
 vec3 col=vec3(0.96,0.92,0.88);float an=atan(d.y,d.x);float vn=seam(sin(an*9.0+fbm(d*6.0)*5.0),0.12)*smoothstep(0.55,1.4,a);col=mix(col,vec3(0.8,0.15,0.2),vn*0.8);   // 血管
 float ir=smoothstep(0.47,0.45,a);float rim=seam(a-0.46,0.025);vec3 ic=mix(iris*0.5,iris*1.3,smoothstep(0.0,0.45,a))*(0.85+0.3*fbm(d*30.0));col=mix(col,ic,ir);col=mix(col,vec3(1.0,0.8,0.3),rim);
 float pu=step(abs(d.x)/0.07+abs(d.y)/0.3,1.0)*step(0.0,d.z);col=mix(col,vec3(0.06,0.02,0.02),pu);
 return col*(0.78+0.3*smoothstep(-0.4,0.9,n.y));}
vec2 eyeb(vec3 p){vec3 C=J[0];vec2 r=vec2(1e3,15.0);

 r=U(r,vec2(length(p-C)-0.42,15.0));   // 目玉
 {vec3 q=p-C-vec3(0.0,-0.36,-0.02);float cl=sEll(q,vec3(0.26,0.12,0.24));r=U(r,vec2(cl,16.0));}   // 下の肉のえり
 for(int k=0;k<5;k++){float a=1.2566*float(k)+0.3;vec3 b0=C+vec3(0.17*sin(a),-0.44,0.17*cos(a));vec3 m1=b0+vec3(0.12*sin(a),-0.3,0.12*cos(a))+vec3(0.06*sin(a*3.0),0.0,0.06*cos(a*2.0));vec3 e1=m1+vec3(0.05*sin(a+1.0),-0.3,0.05*cos(a+1.0));
  float t=smin(sTap(p,b0,m1,0.06,0.042),sTap(p,m1,e1,0.042,0.014),0.03);r=U(r,vec2(t,16.0));
  for(int j=0;j<3;j++){vec3 s=mix(b0,m1,0.3+0.3*float(j))+vec3(sin(a),0.0,cos(a))*0.045;r=U(r,vec2(length(p-s)-0.018,17.0));}}   // 触手と吸盤
 for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;r=U(r,vec2(sTap(p,C+vec3(0.22*sg,0.32,-0.08),C+vec3(0.3*sg,0.52,-0.12),0.035,0.012),16.0));}   // 上の短い角

 return r;}
vec2 xmod(vec2 b,vec3 p){return eyeb(p);}
vec2 xbody(vec3 p){return vec2(1e3,15.0);}
vec4 xcol(vec3 p,vec3 n,float m){float sh=smoothstep(-0.4,0.9,n.y);vec3 C=J[0];
 if(m>16.5)return vec4(pow(vec3(0.42,0.18,0.24)*(0.8+0.3*sh),vec3(2.2)),0.3);   // 吸盤
 if(m>15.5){vec3 c=mix(vec3(0.55,0.32,0.38),vec3(0.78,0.52,0.56),sh)*(0.88+0.2*fbm(p*14.0));return vec4(pow(c,vec3(2.2)),0.4);}   // 肉
 return vec4(pow(eyeCol(p,n,C,0.42,vec3(0.78,0.1,0.14)),vec3(2.2)),0.7);
}
