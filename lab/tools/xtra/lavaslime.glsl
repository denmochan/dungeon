// 溶岩スライム：黒くひび割れた殻の下で、溶岩が光る。表面はでこぼこ、上に溶岩のしずく
const float XK=0.03;
vec2 xmod(vec2 b,vec3 p){float bump=fbm(p*5.0);return vec2(b.x-0.035*bump,b.y<1.5?15.0:b.y);}
vec2 xbody(vec3 p){vec3 c=J[0],r=J[1];float d=9.0;for(int i=0;i<4;i++){float a=float(i)*1.7+0.4;vec3 sp=c+vec3(cos(a)*r.x*0.45,r.y*0.92,sin(a)*r.z*0.35-0.1);d=min(d,sEll(p-sp,vec3(0.07,0.09,0.07)));}return vec2(d,16.0);}
vec4 xcol(vec3 p,vec3 n,float m){if(m>15.5)return vec4(pow(vec3(1.0,0.55,0.12),vec3(2.2))*1.6,0.0);
 float f=fbm(p*3.2),cr=1.0-smoothstep(0.012,0.032,abs(f-0.5));float hot=smoothstep(0.1,-0.25,p.y-J[0].y)*0.5;
 vec3 crust=vec3(0.22,0.12,0.09)*(0.75+0.5*fbm(p*11.0));vec3 lava=mix(vec3(1.0,0.35,0.05),vec3(1.0,0.8,0.25),fbm(p*7.0));
 float lw=smoothstep(0.25,-0.3,p.y-J[0].y)*0.35;return vec4(pow(mix(crust,lava*1.4,max(cr,lw*smoothstep(0.55,0.75,fbm(p*6.0)))),vec3(2.2)),0.05);}
