// 邪眼の亡霊（11/28）：死んだ勇者の最後の視線。目玉の上にへこんだ勇者のかぶと、下はぼろぼろの霊の布、ちぎれた鎖
const float XK=0.03;
vec2 U(vec2 a,vec2 b){return b.x<a.x?b:a;}
vec2 xmod(vec2 b,vec3 p){if(b.y>2.5&&b.y<3.5){float a=atan(p.x,p.z);float hem=smoothstep(0.8,0.3,p.y);b.x-=hem*0.04*sin(a*7.0+p.y*10.0);}return b;}   // すそを波うたせる
vec2 xbody(vec3 p){vec3 C=J[0];vec2 r=vec2(1e3,15.0);
 vec3 q=p-C-vec3(0.0,0.08,-0.02);float hm=abs(sEll(q,vec3(0.42,0.38,0.42)))-0.03;hm=max(hm,-(q.y-0.06+0.35*max(0.0,q.z)));hm=max(hm,-(length(q-vec3(0.22,0.3,0.12))-0.09));   // へこんだかぶと（顔の前はあく）
 hm=min(hm,max(abs(q.x)-0.03,max(abs(sEll(q,vec3(0.45,0.41,0.45)))-0.03,-(q.y-0.12))));   // かぶとのとさか
 r=U(r,vec2(hm,16.0));
 float pl=sTap(p,C+vec3(-0.1,0.4,-0.05),C+vec3(-0.18,0.64,-0.18),0.04,0.07);r=U(r,vec2(pl,17.0));   // 折れた羽かざり
 float ch=9.0;for(int k=0;k<4;k++){vec3 c=C+vec3(0.34,-0.12-0.09*float(k),-0.02+0.02*float(k));vec3 qq=p-c;bool o=fract(float(k)*0.5)>0.25;ch=min(ch,o?max(abs(length(qq.xy*vec2(1.0,0.7))-0.032)-0.011,abs(qq.z)-0.009):max(abs(length(qq.zy*vec2(1.0,0.7))-0.032)-0.011,abs(qq.x)-0.009));}r=U(r,vec2(ch,18.0));   // ちぎれた鎖
 return r;}
vec4 xcol(vec3 p,vec3 n,float m){
 if(m>17.5)return vec4(pow(vec3(0.4,0.42,0.44)*(0.8+0.3*fbm(p*30.0)),vec3(2.2)),0.7);
 if(m>16.5)return vec4(pow(vec3(0.6,0.12,0.1),vec3(2.2)),0.05);
 vec3 c=vec3(0.5,0.52,0.55)*(0.72+0.4*fbm(p*9.0));c=mix(c,vec3(0.45,0.28,0.18),smoothstep(0.6,0.7,fbm(p*14.0))*0.7);return vec4(pow(c,vec3(2.2)),0.6);}   // さびた鉄
