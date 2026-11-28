// 狼：毛のボリューム（首まわりのたてがみ・胸の毛・ふさふさの尾）、太いもも、肉球のある足、黒い鼻。背は濃く、腹は明るく
const float XK=0.06;
vec2 xmod(vec2 b,vec3 p){return vec2(b.x-0.012*fbm(p*16.0),b.y<1.5?15.0:b.y);}   // 毛のでこぼこ、体の色を毛の色に
vec2 xbody(vec3 p){float d=sEll(p-J[0]-vec3(0.0,0.02,0.02),vec3(0.2,0.21,0.48));
 float ruff=sEll(p-vec3(0.0,J[0].y+0.08,0.34),vec3(0.25,0.26,0.2))-0.03*fbm(p*12.0);d=smin(d,ruff,0.08);   // 首のたてがみ
 d=smin(d,sEll(p-J[1]-vec3(0.0,-0.06,-0.1),vec3(0.17,0.15,0.17))-0.02*fbm(p*14.0),0.06);   // ほおの毛
 for(int i=0;i<4;i++){vec3 f=i==0?J[5]:i==1?J[6]:i==2?J[7]:J[8];float bk=f.z<J[0].z?1.0:-1.0;vec3 hip=vec3(f.x*0.9,J[0].y-0.02,f.z*0.95),kn=vec3(f.x,0.3,f.z+0.05*bk);
  d=smin(d,sTap(p,hip,kn,0.12,0.07),0.05);d=smin(d,sTap(p,kn,f+vec3(0.0,0.05,0.0),0.065,0.055),0.03);d=smin(d,sEll(p-f-vec3(0.0,0.02,0.04),vec3(0.075,0.05,0.09)),0.03);}   // もも・すね・足
 float tl=min(sTap(p,J[2],J[3],0.11,0.13),sTap(p,J[3],J[4],0.13,0.04))-0.025*fbm(p*12.0);d=smin(d,tl,0.06);   // ふさふさの尾
 float nose=length(p-(J[1]+vec3(0.0,0.0,0.3)))-0.045;
 return nose<d?vec2(nose,16.0):vec2(d,15.0);}
vec4 xcol(vec3 p,vec3 n,float m){if(m>15.5)return vec4(vec3(0.015),0.4);
 float belly=smoothstep(0.1,-0.5,n.y)*smoothstep(0.62,0.4,p.y);vec3 sk=pow(vec3(0.56,0.56,0.6),vec3(2.2));vec3 c=mix(sk*0.75,sk*1.35+0.03,belly);c*=0.85+0.3*fbm(p*vec3(6.0,18.0,6.0));return vec4(c,0.05);}
