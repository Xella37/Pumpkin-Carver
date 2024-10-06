local a;local b;local c={}local d=true;c.scenes={}c.selectedScene=nil;function c.select(e)if type(e)=="string"then c.selectedScene=c.scenes[e]else c.selectedScene=e end end;local f=require("modules.util")local g=require("modules.hudManager")local h=require("modules.camera")function c.new(i)i=i or"scene_"..#c.scenes;local e={id=i,objects={},objectsEffects={},objectsPine={},envObjects={},envObjectsPine={},camera=h(a),autoLoDSettings=nil}function e:autoLoD(j)self.autoLoDSettings=j or{}end;function e:clearObjects()self.objects={}self.objectsEffects={}self.objectsPine={}end;function e:clearEnvironment()self.envObjects={}self.envObjectsPine={}end;function e:add(k,l,m,n,o,p,q)local r,s,t=0,0,0;local u;local v=false;if type(k)=="string"then local k=a.model(k)u,r,s,t=k:center()elseif k.initObject then u=k;v=true else u=k end;if not v and self.autoLoDSettings then u=u:toLoD(self.autoLoDSettings)end;local w=b:newObject(u,l-r,m-s,n-t,o,p,q)e.objectsPine[#e.objectsPine+1]=w;local x={pineObject=w,x=l,y=m,z=n,offsetX=r,offsetY=s,offsetZ=t,rotX=o,rotY=p,rotZ=q,eventHandlers={}}e.objects[#e.objects+1]=x;function x:setPos(l,m,n,o,p,q)self.x=l or self.x;self.y=m or self.y;self.z=n or self.z;self.rotX=o or self.rotX;self.rotY=p or self.rotY;self.rotZ=q or self.rotZ;w:setPos(self.x-self.offsetX,self.y-self.offsetY,self.z-self.offsetZ)w:setRot(o,p,q)end;x.collision={}function x.collision:withinXZ(y)local function z(A,B,C,D,E,F)return(A-E)*(D-F)-(C-E)*(B-F)end;local function G(H,I,A,B,C,D,E,F)local J=z(H,I,A,B,C,D)<0;local K=z(H,I,C,D,E,F)<0;local L=z(H,I,E,F,A,B)<0;return J==K and K==L end;local M=y.pineObject[7]for N=1,#M do local O=M[N]if G(x.x,x.z,O[1],O[3],O[4],O[6],O[7],O[9])then return true end end end;function x:on(P,Q)self.eventHandlers[P]=Q end;function x:distanceToPos(l,m,n)local R=l-self.x;local S=m-self.y;local T=n-self.z;local U=(R*R+S*S+T*T)^0.5;return U end;local function V()for N=1,#e.objects do local W=e.objects[N]if W==x then table.remove(e.objects,N)break end end end;local function X()for N=1,#e.objectsPine do local W=e.objectsPine[N]if W==x.pineObject then table.remove(e.objectsPine,N)break end end end;function x:remove(Y)if Y==nil then X()V()else local Z=0;self:on("update",function(_)Z=Z+_;for N=1,#Y do local a0=Y[N](x,_,Z)if a0 then X()V()return end end end)end end;return x end;function e:addEnv(k,l,m,n)if type(k)=="string"then k=a.model(k)end;local w=b:newObject(k,l,m,n)e.envObjectsPine[#e.envObjectsPine+1]=w;local x={pineObject=w,eventHandlers={}}e.envObjects[#e.envObjects+1]=x;function x:on(P,Q)self.eventHandlers[P]=Q end;function x:setPos(l,m,n,o,p,q)w:setPos(l,m,n)w:setRot(o,p,q)end;return x end;e.hud=g(b)e.eventHandlers={}function e:on(P,Q)e.eventHandlers[P]=Q end;e.eventHandlersOnce={}function e:onOnce(P,Q)e.eventHandlersOnce[#e.eventHandlersOnce+1]={event=P,callback=Q}end;c.scenes[i]=e;if d then c.select(i)d=false end;return e end;return function(a1,a2)a=a1;b=a2;return c end