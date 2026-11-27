// イフリート：下半身は足のかわりに、うずまく炎と煙。頭に燃える髪
const float XK=0.06;
vec2 xmod(vec2 b,vec3 p){float hip=J[0].y-0.05;return vec2(max(b.x,-(p.y-hip)),b.y);}   // 腰から下（足）を消す
vec2 xbody(vec3 p){float hip=J[0].y;float d=9.0;vec3 a=J[0]+vec3(0.0,-0.02,0.0);
 for(int i=0;i<5;i++){float t=float(i);vec3 b=a+vec3(0.1*sin(t*1.9+0.5),-0.095,-0.03-0.03*t);d=min(d,sTap(p,a,b,0.27-0.045*t,0.23-0.045*t));a=b;}   // うずまく炎の下半身
 float h=9.0;vec3 hp=HR*(p-J[2]);for(int i=0;i<7;i++){float a2=float(i)*0.9;vec3 s=vec3(cos(a2)*0.18,0.2+0.05*sin(a2*2.0),sin(a2)*0.14-0.04);h=min(h,sTap(hp,s,s+vec3(cos(a2)*0.06,0.42+0.1*fract(float(i)*0.6),sin(a2)*0.05-0.1),0.09,0.01));}
 return h<d?vec2(h,16.0):vec2(d,15.0);}
vec4 xcol(vec3 p,vec3 n,float m){float t=clamp((J[0].y-p.y)/0.65,0.0,1.0);vec3 c=m>15.5?mix(vec3(1.0,0.55,0.12),vec3(1.0,0.92,0.45),fbm(p*6.0)):mix(mix(vec3(1.0,0.5,0.12),vec3(0.9,0.25,0.08),t),vec3(0.35,0.3,0.3),smoothstep(0.55,1.0,t));return vec4(pow(c,vec3(2.2))*1.25,0.0);}
