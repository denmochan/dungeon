// スライム騎兵（11/28）：ゴブリンが青いスライム（おまんじゅう型・にっこり顔）に乗る。ゴブリンには羽つきの騎士かぶと（顔は出す）
const float XK=0.03;
vec2 xmod(vec2 b,vec3 p){return b;}
vec2 xbody(vec3 p){
 float e=sEll(p-vec3(0.0,0.02,0.0),vec3(0.92,0.97,0.82));float foot=sEll(p-vec3(0.0,0.06,0.0),vec3(1.0,0.15,0.9));e=smin(e,foot,0.15);e=max(e,-p.y);
 vec2 r=vec2(e,15.0);   // 乗り物のスライム
 vec3 H=J[2];vec3 q=p-H-vec3(0.0,0.2,-0.04);float sh=sEll(q,vec3(0.46,0.44,0.45));sh=max(sh,-sEll(q,vec3(0.41,0.39,0.4)));
 float op=max(q.z-0.05,q.y-0.17);sh=max(sh,-op);sh=max(sh,-(q.y+0.12));   // 顔の前をあけたかぶと
 float rim=max(abs(sEll(q,vec3(0.47,0.45,0.46)))-0.012,abs(q.y-0.17)-0.035);rim=max(rim,-(0.12-q.z)*1.0);sh=min(sh,max(rim,q.z-0.5));
 if(sh<r.x)r=vec2(sh,16.0);
 float pl=sTap(p,H+vec3(0.0,0.6,-0.04),H+vec3(0.0,0.78,-0.18),0.05,0.07);pl=smin(pl,sTap(p,H+vec3(0.0,0.78,-0.18),H+vec3(0.0,0.62,-0.52),0.07,0.025),0.05);
 if(pl<r.x)r=vec2(pl,17.0);   // 青い羽かざり
 return r;}
float arcU(vec2 u,vec2 c,float rr,float w){vec2 d=u-c;return d.y>-0.01?abs(length(d)-rr)-w:1.0;}
float arcD(vec2 u,vec2 c,float rr,float w){vec2 d=u-c;return d.y<0.01?abs(length(d)-rr)-w:1.0;}
vec4 xcol(vec3 p,vec3 n,float m){
 if(m>16.5)return vec4(pow(vec3(0.25,0.62,1.0),vec3(2.2)),0.1);
 if(m>15.5){vec3 c=mix(vec3(0.62,0.66,0.74),vec3(0.9,0.93,0.97),smoothstep(-0.2,0.8,n.y))*(0.95+0.06*fbm(p*10.0));return vec4(pow(c,vec3(2.2)),0.6);}
 float t=clamp(p.y/0.97,0.0,1.0);vec3 c=mix(vec3(0.2,0.5,0.86),vec3(0.5,0.78,0.95),t*t);   // ゴブリンの肌と同じ質感に：色を少し落ち着かせ、まだらの濃淡と、うすい筋を入れる
 float f1=fbm(p*5.0),f2=fbm(p*13.0+7.0);c*=(0.84+0.3*f1)*(0.93+0.12*f2);c=mix(c,c*vec3(0.8,0.88,1.05),smoothstep(0.55,0.75,fbm(p*2.4+3.0))*0.6);
 // 顔は形に焼かず、試し場で絵を貼る（顔の表の10番目のマス。焼くとギザギザになった）
 vec3 d0=normalize(vec3(-0.42,0.78,0.46)),d1=normalize(vec3(-0.30,0.86,0.40));float a0=dot(n,d0),a1=dot(n,d1);
 float hl=smoothstep(0.93,0.945,a0)*(1.0-smoothstep(0.965,0.978,a1));c=mix(c,vec3(0.85,0.95,1.0),hl*0.45*smoothstep(0.45,0.55,p.y));   // つやは弱く
 return vec4(pow(c,vec3(2.2)),0.06);}
