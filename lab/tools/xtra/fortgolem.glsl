// 城塞ゴーレム：背中に石積みの城壁（ぎざぎざの胸壁）と、小さな塔。屋根に旗
const float XK=0.03;
vec2 xmod(vec2 b,vec3 p){return b;}
float xRB(vec3 p,vec3 b,float r){vec3 q=abs(p)-b;return length(max(q,0.0))+min(max(q.x,max(q.y,q.z)),0.0)-r;}
vec2 xbody(vec3 p){vec3 tp=TR*(p-J[0]);float w=xRB(tp-vec3(0.0,0.62,-0.36),vec3(0.46,0.3,0.12),0.02);
 for(int i=0;i<5;i++){float x=-0.4+0.2*float(i);w=min(w,xRB(tp-vec3(x,0.98,-0.36),vec3(0.06,0.07,0.11),0.015));}
 float t=sTap(tp,vec3(0.3,0.6,-0.44),vec3(0.3,1.28,-0.44),0.15,0.13);t=min(t,sTap(tp,vec3(0.3,1.3,-0.44),vec3(0.3,1.55,-0.44),0.17,0.0));
 float f=min(sTap(tp,vec3(0.3,1.5,-0.44),vec3(0.3,1.82,-0.44),0.012,0.012),xRB(tp-vec3(0.39,1.74,-0.44),vec3(0.08,0.05,0.005),0.004));
 if(f<w&&f<t)return vec2(f,17.0);return t<w?vec2(t,16.0):vec2(w,15.0);}
vec4 xcol(vec3 p,vec3 n,float m){vec3 tp=TR*(p-J[0]);if(m>16.5)return vec4(pow(p.y>1.9?vec3(0.85,0.15,0.12):vec3(0.4,0.3,0.2),vec3(2.2)),0.05);
 if(m>15.5&&tp.y>1.3)return vec4(pow(vec3(0.6,0.22,0.16),vec3(2.2))*(0.85+0.3*fbm(p*10.0)),0.05);
 vec2 bk=vec2(tp.x*7.0+floor(tp.y*9.0)*0.5,tp.y*9.0);float ln=min(abs(fract(bk.x)-0.5),abs(fract(bk.y)-0.5));vec3 c=vec3(0.62,0.6,0.55)*(0.82+0.3*fbm(p*9.0))*mix(0.55,1.0,smoothstep(0.03,0.08,ln));return vec4(pow(c,vec3(2.2)),0.05);}
