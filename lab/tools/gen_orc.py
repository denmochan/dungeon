# オークの系統5種の足し形（xtra/*.glsl）をまとめて作る（11/28 本人「全員作り直して」）
import re
src=open('xtra/orc_helm.glsl').read()
i0=src.find('vec2 xmod');i1=src.find('vec2 xbody(vec3 p){')
XMOD_CUT=src[i0:i1]          # 頭を低く平らに（＋sBox3）
b0=src.find('vec2 xbody(vec3 p){');b1=src.find(' vec3 q=p-J[3]-vec3(-0.13,0.15,0.0);')
CORE=src[b0:b1]              # 体・顔・牙（肩当ては入れない）
HAIR=''' float hr=9.0;for(int i=0;i<5;i++){float f=float(i)/4.0;vec3 c=H+vec3(0.0,0.16-0.12*f,0.08-0.32*f);hr=min(hr,sTap(p,c,c+vec3(0.0,0.17-0.05*f,-0.07),0.07,0.015));}
 hr=smin(hr,sTap(p,H+vec3(0.0,0.03,-0.24),H+vec3(0.0,-0.18,-0.32),0.045,0.025),0.03);if(hr<r.x)r=vec2(hr,18.0);   // 黒いとさか髪
'''
PELT=''' {float pl=sEll(p-J[1]-vec3(0.0,0.2,-0.04),vec3(0.58,0.17,0.34));pl=smin(pl,sEll(p-J[1]-vec3(0.0,-0.02,-0.3),vec3(0.5,0.4,0.13)),0.08);   // 肩と背中にかぶった獣の毛皮
  for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;pl=smin(pl,sEll(p-(s==0?J[3]:J[6])-vec3(0.14*sg,0.14,0.0),vec3(0.28,0.17,0.28)),0.06);}
  pl+=0.035*(fbm(p*11.0)-0.5);pl=max(pl,-(p.y-(J[1].y-0.42+0.06*fbm(p*7.0))));if(pl<r.x)r=vec2(pl,24.0);
  float st=sTap(p,J[3]+vec3(0.02,0.08,0.24),J[0]+vec3(0.26,0.02,0.24),0.035,0.035);if(st<r.x)r=vec2(st,25.0);}   // ななめがけの革ひも
'''
WOLF=''' {vec3 q=p-H-vec3(0.0,0.17,-0.05);float wh=sEll(q,vec3(0.36,0.2,0.39));wh=max(wh,-max(q.z-0.1,q.y+0.04));   // 狼の頭の毛皮（頭を深くおおう。顔は出す）
  wh=smin(wh,sTap(p,H+vec3(0.0,0.27,0.16),H+vec3(0.0,0.2,0.58),0.13,0.06),0.05);   // 長い鼻づら
  for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;wh=smin(wh,sEll(p-H-vec3(0.11*sg,0.31,0.24),vec3(0.085,0.04,0.075)),0.03);   // 狼のけわしい眉
   wh=smin(wh,sTap(p,H+vec3(0.17*sg,0.29,-0.06),H+vec3(0.25*sg,0.4,-0.32),0.075,0.01),0.03);}   // 後ろに寝かせた耳
  for(int k=0;k<9;k++){float fk=float(k),a=(fk-4.0)*0.33;vec3 b=H+vec3(sin(a)*0.34,0.14+0.1*cos(a),-0.06-0.3*cos(a)*0.6);wh=smin(wh,sTap(p,b,b+vec3(sin(a)*0.12,-0.04,-0.16),0.06,0.008),0.03);}   // とげとげの毛
  float cp=sEll(p-J[1]-vec3(0.0,0.0,-0.31),vec3(0.52,0.54,0.17));cp=smin(cp,sEll(p-J[1]-vec3(0.0,0.2,-0.05),vec3(0.56,0.16,0.32)),0.08);cp=max(cp,-(p.y-(J[0].y-0.2+0.12*fbm(p*6.0))));   // 背中の毛皮マント
  wh=smin(wh,cp,0.06);wh+=0.035*(fbm(p*13.0)-0.5);if(wh<r.x)r=vec2(wh,28.0);
  float ns=length(p-H-vec3(0.0,0.24,0.62))-0.05;for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;ns=min(ns,sEll(p-H-vec3(0.1*sg,0.275,0.29),vec3(0.05,0.012,0.02)));}if(ns<r.x)r=vec2(ns,29.0);   // 黒い鼻と細い目
  float fg=9.0;for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;for(int k=0;k<4;k++){float z=0.26+0.1*float(k);float w=0.08-0.012*float(k);fg=min(fg,sTap(p,H+vec3(w*sg,0.17,z),H+vec3(w*sg,0.08+0.01*float(k),z+0.01),k==0?0.03:0.018,0.004));}}if(fg<r.x)r=vec2(fg,17.0);}   // 上あごの牙の列
'''
MUD=''' {float md=9.0;for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;vec3 sh=(s==0?J[3]:J[6])+vec3(0.08*sg,0.14,-0.02);md=min(md,sEll(p-sh,vec3(0.27,0.13,0.25)));}
  md+=0.025*(fbm(p*9.0)-0.5);if(md<r.x)r=vec2(md,19.0);   // 肩と頭の泥
  float pd=sEll(p-vec3(J[0].x,0.0,J[0].z+0.05),vec3(0.9,0.07,0.78))+0.02*(fbm(p*6.0)-0.5);for(int s=0;s<2;s++){vec3 f=s==0?J[15]:J[16];pd=smin(pd,sTap(p,vec3(f.x,0.0,f.z),f+vec3(0.0,0.2,-0.04),0.17,0.09),0.08);}
  if(pd<r.x)r=vec2(pd,20.0);   // 足もとの沼
  float bb=9.0;for(int k=0;k<6;k++){float a=float(k)*1.9+0.4,rr=0.5+0.25*fract(float(k)*0.618);bb=min(bb,length(p-vec3(J[0].x+cos(a)*rr,0.06,J[0].z+0.05+sin(a)*rr*0.85))-0.04-0.025*fract(float(k)*0.37));}if(bb<r.x)r=vec2(bb,30.0);   // 沼の泡
  float rd=9.0;for(int k=0;k<5;k++){float fk=float(k),sg=k<3?-1.0:1.0;vec3 b=(k<3?J[3]:J[6])+vec3(sg*(0.02+0.06*fk),0.24,0.05-0.05*fk);rd=min(rd,sTap(p,b,b+vec3(sg*0.04,0.24+0.06*fract(fk*0.7),-0.04),0.016,0.004));}if(rd<r.x)r=vec2(rd,21.0);   // 水草
  float dr=9.0;for(int k=0;k<9;k++){float fk=float(k);vec3 a=k<2?H+vec3((fk-0.5)*0.16,-0.24,0.2):(k<5?J[1]+vec3((fk-3.0)*0.18,-0.12,0.28):(k<7?J[4+3*(k-5)]+vec3(0.0,-0.06,0.05):J[0]+vec3((fk-7.5)*0.3,0.1,0.2)));float L=0.12+0.1*fract(fk*0.618);dr=min(dr,min(sTap(p,a,a-vec3(0.0,L,0.0),0.045,0.022),length(p-a+vec3(0.0,L+0.03,0.0))-0.035));}
  r.x=smin(r.x,dr,0.04);}   // ぬるぬるのしずく（肌と同じ）
'''
CLOTH=''' {float cl=sEll(p-J[1]-vec3(0.0,0.2,-0.02),vec3(0.58,0.15,0.33));cl=max(abs(cl)-0.03,-(p.y-J[1].y-0.08));   // 紫の肩布
  for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;vec3 a=J[1]+vec3(0.18*sg,0.2,0.24);cl=min(cl,sBox3(p-a-vec3(0.0,-0.14,0.0),vec3(0.07,0.15,0.015))-0.01);}
  cl+=0.01*sin(p.x*30.0);if(cl<r.x)r=vec2(cl,27.0);}
'''
OGRE=''' {float hn=9.0;for(int s=0;s<2;s++){float sg=s==0?-1.0:1.0;vec3 a=H+vec3(0.12*sg,0.12,0.02),b=a+vec3(0.08*sg,0.14,-0.04),c=b+vec3(0.0,0.1,-0.1);hn=min(hn,min(sTap(p,a,b,0.06,0.04),sTap(p,b,c,0.04,0.008)));}if(hn<r.x)r=vec2(hn,22.0);   // インプの角
  vec3 q=p-J[1]-vec3(0.0,0.2,0.0);float nk=max(abs(length(q.xz*vec2(1.0,1.15))-0.27)-0.018,abs(q.y+0.02*q.x*q.x)-0.018);nk=max(nk,-q.z-0.05);
  float sk=sEll(p-J[1]-vec3(0.0,0.08,0.33),vec3(0.06,0.065,0.05));nk=min(nk,sk);for(int k=0;k<4;k++){float a=(float(k)-1.5)*0.5;nk=min(nk,length(p-J[1]-vec3(sin(a)*0.27,0.15,cos(a)*0.27))-0.03);}if(nk<r.x)r=vec2(nk,22.0);   // 骨の首飾り
  vec3 t0=J[0]+vec3(0.0,-0.02,-0.22),t1=t0+vec3(0.12,-0.2,-0.2),t2=t1+vec3(0.18,-0.05,-0.12);float tl=min(sTap(p,t0,t1,0.05,0.035),sTap(p,t1,t2,0.035,0.02));tl=min(tl,sEll(p-t2-vec3(0.04,0.0,-0.02),vec3(0.06,0.03,0.07)));r.x=smin(r.x,tl,0.03);}   // とがった尾
'''
TATTOO='''float segD(vec2 p,vec2 a,vec2 b){vec2 pa=p-a,ba=b-a;float h=clamp(dot(pa,ba)/dot(ba,ba),0.0,1.0);return length(pa-ba*h);}
vec2 tattoo(vec2 b,vec3 p){vec3 c=p-J[1];if(b.y<1.5&&c.z>0.12&&abs(c.y)<0.35){vec2 u=vec2(abs(c.x),c.y);float d=min(segD(u,vec2(0.2,0.12),vec2(0.1,0.02)),segD(u,vec2(0.1,0.02),vec2(0.2,-0.08)));d=min(d,min(segD(c.xy,vec2(0.0,-0.06),vec2(0.0,-0.26)),segD(c.xy,vec2(-0.07,-0.16),vec2(0.07,-0.16))));if(d<0.026)b.y=23.0;}return b;}   // 胸の呪いの入れ墨
'''
SLIMY='#define XSKIN 1\nvec4 xskin(vec3 p,vec3 n,float m){float w=fbm(p*6.0);vec3 c=mix(vec3(0.24,0.36,0.14),vec3(0.42,0.58,0.24),w);c=mix(c,vec3(0.62,0.78,0.4),smoothstep(0.62,0.72,fbm(p*11.0+3.0))*0.6);c=mix(c,vec3(0.16,0.2,0.08),smoothstep(0.6,0.75,fbm(p*3.0+7.0))*0.6);return vec4(pow(c,vec3(2.2)),0.75);}   // 肌をぬるぬるのスライムに（材質は肌のまま＝骨について動く）\n'
COL='''vec4 xcol(vec3 p,vec3 n,float m){
 if(m>29.5)return vec4(pow(vec3(0.42,0.55,0.3),vec3(2.2)),0.8);   // 泡
 if(m>28.5)return vec4(pow(vec3(0.05,0.04,0.04),vec3(2.2)),0.5);   // 狼の鼻と目
 if(m>27.5){vec3 c=mix(vec3(0.22,0.22,0.25),vec3(0.5,0.5,0.54),smoothstep(-0.3,0.8,n.y))*(0.75+0.45*fbm(p*vec3(9.0,26.0,9.0)));c=mix(c,vec3(0.12,0.12,0.14),smoothstep(0.55,0.7,fbm(p*vec3(3.0,12.0,3.0)+5.0))*0.7);return vec4(pow(c,vec3(2.2)),0.04);}   // 狼の灰色の毛
 if(m>26.5){vec3 c=vec3(0.36,0.16,0.5)*(0.85+0.25*fbm(p*vec3(8.0,20.0,8.0)));return vec4(pow(c,vec3(2.2)),0.05);}   // 紫の布
 if(m>25.5){float w=fbm(p*6.0);vec3 c=mix(vec3(0.24,0.36,0.14),vec3(0.42,0.58,0.24),w);c=mix(c,vec3(0.62,0.78,0.4),smoothstep(0.62,0.72,fbm(p*11.0+3.0))*0.6);c=mix(c,vec3(0.16,0.2,0.08),smoothstep(0.6,0.75,fbm(p*3.0+7.0))*0.6);return vec4(pow(c,vec3(2.2)),0.75);}   // ぬるぬるの肌
 if(m>24.5)return vec4(pow(vec3(0.3,0.18,0.09)*(0.85+0.3*fbm(p*20.0)),vec3(2.2)),0.2);   // 革
 if(m>23.5){vec3 c=mix(vec3(0.3,0.19,0.1),vec3(0.52,0.36,0.2),smoothstep(-0.3,0.8,n.y))*(0.75+0.45*fbm(p*vec3(9.0,24.0,9.0)));return vec4(pow(c,vec3(2.2)),0.03);}   // 茶色い毛皮
 if(m>22.5)return vec4(pow(vec3(1.0,0.4,1.0),vec3(2.2))*2.6,0.0);   // 光る入れ墨
 if(m>21.5){float t=clamp((p.y-J[2].y-0.1)/0.3,0.0,1.0);return vec4(pow(mix(vec3(0.75,0.68,0.55),vec3(0.95,0.92,0.82),t),vec3(2.2)),0.2);}   // 骨・角
 if(m>20.5)return vec4(pow(vec3(0.45,0.6,0.22),vec3(2.2)),0.05);   // 水草
 if(m>19.5){float w=fbm(p*5.0);vec3 c=mix(vec3(0.07,0.09,0.05),vec3(0.16,0.19,0.09),w);c=mix(c,vec3(0.3,0.36,0.22),smoothstep(0.62,0.7,fbm(p*9.0))*0.5);return vec4(pow(c,vec3(2.2)),0.7);}   // 沼
 if(m>18.5){float w=fbm(p*7.0);vec3 c=mix(vec3(0.15,0.1,0.05),vec3(0.27,0.2,0.1),w);return vec4(pow(c,vec3(2.2)),0.45);}   // 泥
 if(m>17.5)return vec4(pow(vec3(0.07,0.06,0.06),vec3(2.2))*(0.8+0.4*fbm(p*30.0)),0.15);   // 黒い髪
 if(m>16.5){float t=clamp((p.y-J[2].y+0.14)/0.14,0.0,1.0);return vec4(pow(mix(vec3(0.78,0.7,0.5),vec3(0.96,0.93,0.84),t),vec3(2.2)),0.2);}   // 牙
 vec3 c=vec3(0.55,0.57,0.62)*(0.8+0.3*fbm(p*14.0));return vec4(pow(c,vec3(2.2)),0.5);}
'''
def build(name,head,parts,mods=()):
    xm=XMOD_CUT
    extra_fn=''.join(f for f,_ in mods)
    if mods:
        calls=''.join(c for _,c in mods)
        xm=xm.replace('vec2 xmod(vec2 b,vec3 p){','vec2 xmod0(vec2 b,vec3 p){',1)
        xm=xm+'vec2 xmod(vec2 b,vec3 p){b=xmod0(b,p);'+calls+'return b;}\n'
    body=CORE+''.join(parts)+' return r;}\n'
    open('xtra/%s.glsl'%name,'w').write('// '+head+'\nconst float XK=0.07;\n'+extra_fn+xm+body+COL)
build('orc','オーク（11/28 作り直し2回目：本人「沼トロルの見た目がふつうのオーク」）：獣の毛皮を肩と背中にかぶり、革ひも、とさか髪。武器はこん棒',[HAIR,PELT])
build('minerorc','坑道オーク（11/28）：かぶと・前かけ・つるはしはオークの式のまま。鉄の肩当ては無し',[' // （かぶとと前かけはオークの式の VAR.x=1）\n'])
build('berserker','牙のオーク（11/28）：狼の頭の毛皮をかぶり（鼻づら・耳・牙、顔は出す）、背中に灰色の毛皮マント',[WOLF])
build('bogtroll','沼トロル（11/28 作り直し2回目）：肌がぬるぬるのスライム（つや・明るい斑）、あご・胸・腕からしずく、肩と頭に泥と水草、足もとは泡の立つ沼。素手',[MUD],[(SLIMY,'')])
build('ogremage','鬼の術師（11/28 作り直し2回目）：インプの角と尾、骨の首飾り、強く光る胸の入れ墨、紫の肩布。武器は杖',[OGRE,CLOTH],[(TATTOO,'b=tattoo(b,p);')])
print('ok')
