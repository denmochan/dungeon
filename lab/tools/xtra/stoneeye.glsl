// 石の邪眼（11/28 2D案「目を閉じこめた像」）：ガーゴイルの石像の顔に目玉が埋まる・角・たたんだ翼・寄せた石の眉・牙の口・ひび・二段の台座
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

 r=U(r,vec2(hbx(p-vec3(0.0,0.07,0.0),vec3(0.42,0.07,0.36))-0.015,15.0));r=U(r,vec2(hbx(p-vec3(0.0,0.2,0.0),vec3(0.34,0.07,0.29))-0.015,15.0));   // 台座
 {float bd=sEll(p-vec3(0.0,0.62,0.0),vec3(0.32,0.38,0.27));bd=smin(bd,sEll(p-vec3(0.0,0.98,0.04),vec3(0.36,0.34,0.3)),0.12);
  for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;bd=smin(bd,sEll(p-vec3(0.27*sg,0.45,0.18),vec3(0.1,0.17,0.12)),0.05);bd=smin(bd,sEll(p-vec3(0.22*sg,0.3,0.22),vec3(0.1,0.05,0.12)),0.04);}   // うずくまった前脚
  bd=max(bd,-sEll(p-vec3(0.0,0.98,0.34),vec3(0.21,0.2,0.14)));   // 目のはまるくぼみ
  bd=max(bd,-hbx(p-vec3(0.0,0.72,0.3),vec3(0.17,0.035,0.1)));   // 口
  r=U(r,vec2(bd,16.0));
  for(int k=0;k<6;k++){float x=-0.135+0.054*float(k);r=U(r,vec2(sTap(p,vec3(x,0.755,0.3),vec3(x,0.715,0.31),0.016,0.004),17.0));r=U(r,vec2(sTap(p,vec3(x+0.027,0.685,0.3),vec3(x+0.027,0.72,0.31),0.014,0.004),17.0));}   // 牙
  for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;r=U(r,vec2(sTap(p,vec3(0.06*sg,1.2,0.25),vec3(0.24*sg,1.14,0.28),0.04,0.035),16.0));   // 寄せた石の眉
   r=U(r,vec2(smin(sTap(p,vec3(0.2*sg,1.24,0.0),vec3(0.3*sg,1.42,-0.06),0.07,0.03),sTap(p,vec3(0.3*sg,1.42,-0.06),vec3(0.28*sg,1.56,-0.14),0.03,0.006),0.02),16.0));   // 角
   vec3 q=p-vec3(0.36*sg,0.82,-0.12);q.x*=sg;float wg=max(hbx(q,vec3(0.05,0.32,0.18))-0.01,dot(q-vec3(0.0,0.32,-0.18),normalize(vec3(0.0,1.0,0.5))));wg=max(wg,-(q.y+0.3-0.25*sin((q.z+0.2)*14.0)*0.3));r=U(r,vec2(wg,18.0));}}   // たたんだ翼
 r=U(r,vec2(length(p-vec3(0.0,0.98,0.32))-0.2,20.0));   // 目玉

 return r;}
vec2 xmod(vec2 b,vec3 p){return eyeb(p);}
vec2 xbody(vec3 p){return vec2(1e3,15.0);}
vec4 xcol(vec3 p,vec3 n,float m){float sh=smoothstep(-0.4,0.9,n.y);vec3 C=J[0];
 if(m>19.5)return vec4(pow(eyeCol(p,n,vec3(0.0,0.98,0.32),0.2,vec3(0.78,0.1,0.14)),vec3(2.2)),0.7);
 vec3 c=mix(vec3(0.42,0.41,0.4),vec3(0.66,0.64,0.6),sh)*(0.82+0.3*fbm(p*10.0));if(m>17.5)c*=0.85;if(m>16.5&&m<17.5)c=vec3(0.78,0.76,0.7)*(0.8+0.25*sh);
 c*=1.0-0.6*seam(fbm(p*6.0)-0.5,0.012)*step(0.5,fbm(p*2.5+4.0));   // ひび
 c=mix(c,vec3(0.3,0.42,0.2),0.7*smoothstep(0.66,0.72,fbm(p*6.0+1.0))*smoothstep(0.3,0.8,n.y));   // こけ
 return vec4(pow(c,vec3(2.2)),0.3);
}
