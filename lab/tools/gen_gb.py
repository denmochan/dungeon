# ゴーレム「ネズミ大工の石人形」と骨の竜「組み直された竜」（11/28 本人「一旦それで」）。もとの形に足して、色を付けなおす
GOLEM = '''// ゴーレム（11/28 2D案「ネズミ大工の石人形」）：石のブロックの継ぎ目・胸の光るルーン・ひじとひざを縛る縄・胸の木の板のつぎあてと釘・チョークの寸法の印・こけ
const float XK=0.01;
#define XSKIN 1
vec2 xmod(vec2 b,vec3 p){return b;}
float hbx(vec3 p,vec3 b){vec3 q=abs(p)-b;return length(max(q,0.0))+min(max(q.x,max(q.y,q.z)),0.0);}
float seam(float x,float w){return 1.0-smoothstep(0.0,w,abs(x));}
float ringAt(vec3 p,vec3 a,vec3 b,float t,float R,float r){vec3 ax=normalize(b-a);vec3 c=mix(a,b,t);vec3 q=p-c;float h=dot(q,ax);float rd=length(q-ax*h);return length(vec2(rd-R,h))-r;}
vec2 xbody(vec3 p){float rp=9.0;
 for(int s=0;s<2;s++){vec3 a=s==0?J[3]:J[6],b=s==0?J[4]:J[7],c=s==0?J[5]:J[8];rp=min(rp,ringAt(p,a,b,0.8,0.15,0.024));rp=min(rp,ringAt(p,a,b,0.88,0.15,0.024));rp=min(rp,ringAt(p,b,c,0.5,0.14,0.022));
  vec3 h=s==0?J[9]:J[12],k=s==0?J[10]:J[13],f=s==0?J[11]:J[14];rp=min(rp,ringAt(p,h,k,0.85,0.15,0.024));rp=min(rp,ringAt(p,k,f,0.2,0.14,0.022));}   // ひじ・手首・ひざを縛る縄
 float pl=hbx(p-vec3(0.2,0.7,0.29),vec3(0.07,0.1,0.014))-0.006;   // 胸の木の板のつぎあて
 float nl=9.0;for(int k=0;k<4;k++){vec3 c=vec3(0.2+0.1*(float(k/2)-0.5)*1.0,0.7+0.15*(mod(float(k),2.0)-0.5),0.305);nl=min(nl,length(p-c)-0.012);}   // 釘
 vec2 r=vec2(rp,8.0);if(pl<r.x)r=vec2(pl,9.0);if(nl<r.x)r=vec2(nl,10.0);return r;}
vec4 xskin(vec3 p,vec3 n,float m){vec3 an=abs(n);float u=an.y>0.6?p.x:(an.x>an.z?p.z:p.x);float row=floor(p.y*5.0);
 float sm=max(seam(fract(p.y*5.0)-0.5,0.05)*step(an.y,0.6),seam(fract(u*4.0+0.5*row)-0.5,0.035));   // ブロックの継ぎ目
 vec3 c=mix(vec3(0.45,0.41,0.36),vec3(0.62,0.58,0.5),smoothstep(-0.3,0.9,n.y))*(0.86+0.24*fbm(p*9.0));c*=0.9+0.12*fbm(vec3(row,floor(u*4.0+0.5*row),1.0)*3.1);c*=1.0-0.45*sm;
 c=mix(c,vec3(0.3,0.46,0.18)*(0.8+0.3*fbm(p*20.0)),smoothstep(0.62,0.7,fbm(p*5.0+3.0))*smoothstep(0.2,0.7,n.y));   // こけ（上を向いた面）
 vec2 q=vec2(p.x,p.y-0.84);float ru=0.0;if(n.z>0.5&&abs(q.x)<0.16&&abs(q.y)<0.14){float tri=max(abs(q.x)*1.6+q.y-0.05,-q.y-0.05);ru=seam(tri,0.012)+seam(length(q)-0.12,0.01);}   // 胸のルーン（三角と輪）
 c=mix(c,vec3(0.4,1.0,0.85)*1.6,min(1.0,ru));
 if(n.z>0.4&&p.y>0.25&&p.y<0.45){float tk=seam(fract(p.y*25.0)-0.5,0.08)*step(abs(abs(p.x)-0.3),0.03);c=mix(c,vec3(0.95,0.95,0.92),tk*0.85);}   // 太もものチョークの寸法の印
 return vec4(pow(c,vec3(2.2)),0.3);}
vec4 xcol(vec3 p,vec3 n,float m){float sh=smoothstep(-0.4,0.9,n.y);
 if(m>9.5)return vec4(pow(vec3(0.3,0.3,0.34)*(0.6+0.5*sh),vec3(2.2)),0.8);   // 釘
 if(m>8.5){vec3 c=vec3(0.55,0.36,0.18)*(0.74+0.34*sh)*(0.85+0.25*fbm(p*vec3(40.0,6.0,6.0)));return vec4(pow(c,vec3(2.2)),0.3);}   // 木の板
 vec3 c=vec3(0.72,0.58,0.36)*(0.74+0.34*sh)*(0.85+0.2*sin(dot(p,vec3(60.0,60.0,0.0))));return vec4(pow(c,vec3(2.2)),0.2);}   // 縄（よりの筋）
'''
open('xtra/golem.glsl', 'w').write(GOLEM)

BONE = '''// 骨の竜（11/28 2D案「組み直された竜」）：胸の骨の中に緑の魂の火・目の緑の光・幽霊のような半透明の緑の翼の膜（すじ）・首と脚を縛る縄・大きな角・骨のひび
const float XK=0.01;
#define XSKIN 1
vec2 xmod(vec2 b,vec3 p){return b;}
float seam(float x,float w){return 1.0-smoothstep(0.0,w,abs(x));}
float ringAt(vec3 p,vec3 a,vec3 b,float t,float R,float r){vec3 ax=normalize(b-a);vec3 c=mix(a,b,t);vec3 q=p-c;float h=dot(q,ax);float rd=length(q-ax*h);return length(vec2(rd-R,h))-r;}
vec2 xbody(vec3 p){vec3 H=J[1],N=J[10],B=J[0];
 float sf=length(p-B-vec3(0.0,0.1,0.25))-0.22;sf=min(sf,length(p-B-vec3(0.0,0.18,0.4))-0.14);   // 胸の骨の中の魂の火
 float rp=9.0;rp=min(rp,ringAt(p,N,H,0.35,0.085,0.022));rp=min(rp,ringAt(p,N,H,0.42,0.085,0.022));rp=min(rp,ringAt(p,B,N,0.6,0.1,0.024));   // 首を縛る縄
 float hn=9.0;for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;hn=min(hn,sTap(p,H+vec3(0.1*sg,0.1,-0.1),H+vec3(0.22*sg,0.3,-0.32),0.05,0.03));hn=min(hn,sTap(p,H+vec3(0.22*sg,0.3,-0.32),H+vec3(0.26*sg,0.46,-0.52),0.03,0.006));}   // 大きな角
 vec2 r=vec2(sf,7.0);if(rp<r.x)r=vec2(rp,8.0);if(hn<r.x)r=vec2(hn,2.0);return r;}
vec4 xskin(vec3 p,vec3 n,float m){vec3 c=mix(vec3(0.62,0.58,0.5),vec3(0.9,0.86,0.76),smoothstep(-0.3,0.9,n.y))*(0.9+0.15*fbm(p*12.0));
 c*=1.0-0.55*seam(fbm(p*7.0)-0.5,0.015)*step(0.45,fbm(p*3.0+5.0));   // 骨のひび
 c=mix(c,vec3(0.4,1.0,0.6),0.35*smoothstep(0.55,0.15,length(p-J[0]-vec3(0.0,0.1,0.25))));   // 魂の火に照らされる胸
 return vec4(pow(c,vec3(2.2)),0.3);}
vec4 xcol(vec3 p,vec3 n,float m){float sh=smoothstep(-0.4,0.9,n.y);
 if(m>7.5){vec3 c=vec3(0.5,0.36,0.2)*(0.74+0.34*sh)*(0.85+0.2*sin(dot(p,vec3(60.0,60.0,0.0))));return vec4(pow(c,vec3(2.2)),0.2);}   // 縄
 if(m>6.5){vec3 c=mix(vec3(0.3,1.0,0.55),vec3(0.85,1.0,0.8),smoothstep(0.3,1.0,fbm(p*10.0)));return vec4(pow(c,vec3(2.2))*1.8,0.6);}   // 魂の火
 if(m>5.5)return vec4(pow(vec3(0.45,1.0,0.6),vec3(2.2))*2.0,0.6);   // 目の緑の光
 vec3 c=mix(vec3(0.12,0.3,0.24),vec3(0.3,0.6,0.46),smoothstep(-0.3,0.9,n.y));c*=0.8+0.3*fbm(p*6.0);c=mix(c,vec3(0.55,0.9,0.7),0.6*seam(fract(atan(p.x,p.z+1.0)*6.0)-0.5,0.04));return vec4(pow(c,vec3(2.2)),0.3);}   // 幽霊のような翼の膜（すじ）
'''
open('xtra/bonedragon.glsl', 'w').write(BONE)
print('ok')
