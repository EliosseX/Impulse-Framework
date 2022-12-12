--[[
Server Name: vanilla: Half-Life 2 Roleplay | Semi-Serious RP
Server IP:   185.38.148.133:27015
File Path:   gamemodes/impulse/gamemode/libs/rq_medialib.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

-- this is minified, take a look at https://github.com/wyozi/gmod-medialib/releases/download/1.0.2/medialib.lua for readable code
local a;do local b="git@871fb36d"local c=true;a={}a.VERSION=b;a.DISTRIBUTABLE=c;a.INSTANCE=a.VERSION.."_"..tostring(10000+math.random(90000))a.Modules={}local d=CreateConVar("medialib_debug","0",FCVAR_ARCHIVE)cvars.AddChangeCallback(d:GetName(),function(e,e,f)a.DEBUG=f=="1"end)a.DEBUG=d:GetBool()function a.modulePlaceholder(g)a.Modules[g]={}end;function a.module(g,h)if a.DEBUG then print("[MediaLib] Creating module "..g)end;local i=a.Modules[g]or{name=g,options=h}a.Modules[g]=i;return i end;if SERVER then for e,j in pairs(file.Find("medialib/*","LUA"))do AddCSLuaFile("medialib/"..j)end end;local k=file.Exists;function a.tryInclude(file)if k(file,"LUA")then include(file)return true end;if a.DEBUG then print("[MediaLib] Attempted to include nonexistent file "..file)end;return false end;function a.load(g)local i=a.Modules[g]if i then return i end;if a.DEBUG then print("[MediaLib] Loading unreferenced module "..g)end;local file="medialib/"..g..".lua"if not a.tryInclude(file)then return nil end;return a.Modules[g]end;local l=setmetatable({medialib=a},{__index=_G})local m={read=function(self)return file.Read(self.lua_path,"LUA")end,load=function(self)return include(self.lua_path)end,addcs=function(self)AddCSLuaFile(self.lua_path)end}m.__index=m;local n={read=function(self)return self.source end,load=function(self)local o=CompileString(self:read(),"MediaLib_DynFile_"..self.name)setfenv(o,l)return o()end,addcs=function()end}n.__index=n;a.FolderItems={}function a.folderIterator(p)local q={}for e,j in pairs(file.Find("medialib/"..p.."/*.lua","LUA"))do table.insert(q,setmetatable({name=j,lua_path="medialib/"..p.."/"..j},m))end;for r,s in pairs(a.FolderItems)do local t=r:match("^([^/]*).+")if t==p then table.insert(q,setmetatable({name=r:match("^[^/]*/(.+)"),source=s},n))end end;return pairs(q)end;if CLIENT then local function u()for v=1,30 do MsgC(HSVToColor(30*v,0.5,0.9)," "..string.rep("SEE BELOW FOR INSTRUCTIONS  ",3).."\n")end end;concommand.Add("medialib_noflash",function(e,e,w)if w[1]=="rainbow"then u()end;SetClipboardText("http://get.adobe.com/flashplayer/otherversions/")MsgN("[ MediaLib: How to get Flash Player ]")MsgN("1. Open this website in your browser (not the ingame Steam browser): ".."http://get.adobe.com/flashplayer/otherversions/")MsgN("   (the link has been automatically copied to your clipboard)")MsgN("2. Download and install the NSAPI (for Firefox) version")MsgN("3. Restart your Garry's Mod and rejoin this server")MsgN("[ ======================= ]")end)concommand.Add("medialib_lowaudio",function(e,e,w)if w[1]=="rainbow"then u()end;SetClipboardText("http://windows.microsoft.com/en-us/windows7/adjust-the-sound-level-on-your-computer")MsgN("[ MediaLib: How to fix muted sound ]")MsgN("1. Follow instructions here: ".."http://windows.microsoft.com/en-us/windows7/adjust-the-sound-level-on-your-computer")MsgN("   (the link has been automatically copied to your clipboard, you can open it in the steam ingame browser)")MsgN("2. Increase the volume of a process called 'Awesomium Core'")MsgN("3. You should immediately start hearing sound if a mediaclip is playing")MsgN("[ ======================= ]")end)hook.Add("OnPlayerChat","MediaLib.ShowInstructions",function(e,x)if x:match("!ml_noflash")then RunConsoleCommand("medialib_noflash","rainbow")RunConsoleCommand("showconsole")elseif x:match("!ml_lowvolume")then RunConsoleCommand("medialib_lowaudio","rainbow")RunConsoleCommand("showconsole")end end)end end;a.modulePlaceholder("oop")do local b=a.module("oop")b.Classes=b.Classes or{}function b.class(c,d)local e=b.Classes[c]if not e then e=b.createClass(c,d)b.Classes[c]=e;if a.DEBUG then print("[MediaLib] Registering oopclass "..c)end end;return e end;function b.resolveClass(f)if f==nil then return b.Object end;local g=type(f)if g=="string"then local h=b.Classes[f]if h then return h end;error("Resolving class from inexistent class string '"..tostring(f).."'")end;if g=="table"then return f end;error("Resolving class from invalid object '"..tostring(f).."'")end;local i={}local j={'__add','__call','__concat','__div','__ipairs','__le','__len','__lt','__mod','__mul','__pairs','__pow','__sub','__tostring','__unm'}function b.createClass(c,d)local e={}local k;if d~=i then k=b.resolveClass(d)end;e.name=c;e.super=k;e.members=setmetatable({},{__index=e.super})e.members.class=e;e.members.super=e.super;local l={}do l.__index=e.members;for m,n in pairs(j)do l[n]=function(...)local o=e.members[n]if o then return o(...)end end end end;local p={}do p.__index=e.members;p.__newindex=e.members;p.__tostring=function(self)return"class "..self.name end;function p:__call(...)local q={}setmetatable(q,l)local r=q.initialize;if r then r(q,...)end;return q end end;setmetatable(e,p)return e end;b.Object=b.createClass("Object",i)function b.Object:hashCode()local s=getmetatable(self)local t=s.__tostring;s.__tostring=nil;local u=tostring(self):match("table: 0x(.*)")s.__tostring=t;return u end;function b.Object:__tostring()return string.format("%s@%s",self.class.name,self:hashCode())end end;a.modulePlaceholder("mediabase")do local b=a.load("oop")local c=b.class("Media")function c:on(d,e)self._events=self._events or{}self._events[d]=self._events[d]or{}self._events[d][e]=true end;function c:emit(d,...)if not self._events then return end;local f=self._events[d]if not f then return end;for g,h in pairs(f)do g(...)end end;function c:getServiceBase()error("Media:getServiceBase() not implemented!")end;function c:getService()return self._service end;function c:getUrl()return self._unresolvedUrl end;function c:lookupMetadata()local i=self._metadata;if type(i)=="table"then return i end;if i==true or type(i)=="string"then return nil end;self._metadata=true;self:getService():query(self:getUrl(),function(j,k)if j then self._metadata=j else self._metadata=k end end)return nil end;function c:isValid()return false end;function c:IsValid()return self:isValid()end;function c:setVolume(l)end;function c:getVolume()end;function c:setQuality(m)end;function c:seek(n)end;function c:getTime()return 0 end;function c:sync(o,p)if self._lastSync and self._lastSync>CurTime()-5 then return end;local q=self:shouldSync(o,p)if not q then return end;self:seek(o+0.1)self._lastSync=CurTime()end;function c:shouldSync(o,p)if not self:isValid()or not self:isPlaying()then return false end;p=p or 2;local r=self:getTime()local s=math.abs(r-o)return s>p end;function c:getState()end;function c:isPlaying()return self:getState()=="playing"end;function c:play()end;function c:pause()end;function c:stop()end;function c:runCommand(t)end;function c:draw(u,v,w,x)end;function c:getTag()return self._tag end;function c:setTag(y)self._tag=y end;function c:guessDefaultTag()for z=1,10 do local A=debug.getinfo(z,"S")if not A then break end;local B=A.short_src;local C=B:match("addons/(.-)/")if C and C~="medialib"then return string.format("addon:%s",C)end end;return"addon:medialib"end;function c:setDefaultTag()self:setTag(self:guessDefaultTag())end;function c:getDebugInfo()return string.format("[%s] Media [%s] valid:%s state:%s url:%s time:%d",self:getTag(),self.class.name,tostring(self:isValid()),self:getState(),self:getUrl(),self:getTime())end end;a.modulePlaceholder("media")do local b=a.module("media")b.Services={}function b.registerService(c,d)b.Services[c]=d()end;b.RegisterService=b.registerService;function b.service(c)return b.Services[c]end;b.Service=b.service;function b.guessService(e,f)for c,g in pairs(b.Services)do local h=true;if f and f.whitelist then h=h and table.HasValue(f.whitelist,c)end;if f and f.blacklist then h=h and not table.HasValue(f.blacklist,c)end;if h and g:isValidUrl(e)then return g end end end;b.GuessService=b.guessService end;a.modulePlaceholder("mediaregistry")do local b=a.module("mediaregistry")local c=setmetatable({},{__mode="v"})function b.add(d)table.insert(c,d)end;function b.get()return c end;concommand.Add("medialib_listall",function()hook.Run("MediaLib_ListAll")end)hook.Add("MediaLib_ListAll","MediaLib_"..a.INSTANCE,function()print("Media for medialib version "..a.INSTANCE..":")for e,f in pairs(c)do print(f:getDebugInfo())end end)concommand.Add("medialib_stopall",function()hook.Run("MediaLib_StopAll")end)hook.Add("MediaLib_StopAll","MediaLib_"..a.INSTANCE,function()for e,f in pairs(c)do f:stop()end;table.Empty(c)end)local g=CreateConVar("medialib_debugmedia","0")hook.Add("HUDPaint","MediaLib_G_DebugMedia",function()if not g:GetBool()then return end;local h={0}hook.Run("MediaLib_DebugPaint",h)end)hook.Add("MediaLib_DebugPaint","MediaLib_"..a.INSTANCE,function(h)local i=h[1]for e,d in pairs(c)do local j=string.format("#%d %s",i,d:getDebugInfo())draw.SimpleText(j,"DermaDefault",10,10+i*15)i=i+1 end;h[1]=i end)end;a.modulePlaceholder("servicebase")do local b=a.load("oop")local c=a.load("mediaregistry")local d=b.class("Service")function d:on(e,f)self._events={}self._events[e]=self._events[e]or{}self._events[e][f]=true end;function d:emit(e,...)for g,h in pairs(self._events[e]or{})do g(...)end;if e=="error"then MsgN("[MediaLib] Video error: "..table.ToString{...})end end;function d:load()end;function d:loadMediaObject(i,j,k)i._unresolvedUrl=j;i._service=self;i:setDefaultTag()hook.Run("Medialib_ProcessOpts",i,k or{})c.add(i)self:resolveUrl(j,function(l,m)i:openUrl(l)if m and m.start and(not k or not k.dontSeek)then i:seek(m.start)end end)end;function d:isValidUrl()end;function d:directQuery()end;local n={}n.__index=n;function n:addCallback(o)table.insert(self._callbacks,o)end;function n:run(p,q)local r=table.remove(self._callbacks,1)if not r then return end;r(p,q,function(s,t)self:run(s,t)end)end;function d:query(j,f)local u=setmetatable({_callbacks={}},n)u:addCallback(function(h,h,o)return self:directQuery(j,o)end)hook.Run("Medialib_ExtendQuery",j,u)u:addCallback(function(p,q)f(p,q)end)u:run(j)end;function d:parseUrl()end;function d:resolveUrl(j,o)o(j,self:parseUrl(j))end end;a.modulePlaceholder("timekeeper")do local b=a.load("oop")local c=b.class("TimeKeeper")function c:initialize()self:reset()end;function c:reset()self.cachedTime=0;self.running=false;self.runningTimeStart=0 end;function c:getTime()local d=self.cachedTime;if self.running then d=d+RealTime()-self.runningTimeStart end;return d end;function c:isRunning()return self.running end;function c:play()if self.running then return end;self.runningTimeStart=RealTime()self.running=true end;function c:pause()if not self.running then return end;local e=RealTime()-self.runningTimeStart;self.cachedTime=self.cachedTime+e;self.running=false end;function c:seek(d)self.cachedTime=d;if self.running then self.runningTimeStart=RealTime()end end end;a.modulePlaceholder("service_html")do local b=a.load("oop")a.load("timekeeper")local c=b.class("HTMLService","Service")function c:load(d,e)local f=b.class("HTMLMedia")()self:loadMediaObject(f,d,e)return f end;function c:hasReliablePlaybackEvents(g)return false end;local h={instances={}}local function i()return a.MAX_HTMLPOOL_INSTANCES or 0 end;hook.Add("MediaLib_HTMLPoolInfo",a.INSTANCE,function()print(a.INSTANCE.."> Free HTMLPool instance count: "..#h.instances.."/"..i())end)concommand.Add("medialib_htmlpoolinfo",function()hook.Run("MediaLib_HTMLPoolInfo")end)timer.Create("MediaLib."..a.INSTANCE..".HTMLPoolCleaner",60,0,function()if#h.instances==0 then return end;local j=table.remove(h.instances,1)if IsValid(j)then j:Remove()end end)function h.newInstance()return vgui.Create("DHTML")end;function h.get()if#h.instances==0 then if a.DEBUG then MsgN("[MediaLib] Returning new instance; htmlpool empty")end;return h.newInstance()end;local j=table.remove(h.instances,1)if not IsValid(j)then if a.DEBUG then MsgN("[MediaLib] Returning new instance; instance was invalid")end;return h.newInstance()end;if a.DEBUG then MsgN("[MediaLib] Returning an instance from the HTML pool")end;return j end;function h.free(j)if not IsValid(j)then return end;if#h.instances>=i()then if a.DEBUG then MsgN("[MediaLib] HTMLPool full; removing the freed instance")end;j:Remove()else if a.DEBUG then MsgN("[MediaLib] Freeing an instance to the HTMLPool")end;j:SetHTML("")table.insert(h.instances,j)end end;local k=CreateConVar("medialib_showallmessages","0")local l=b.class("HTMLMedia","Media")local m,n=1280,720;function l:initialize()self.timeKeeper=b.class("TimeKeeper")()self.panel=h.get()local o=self.panel;o:SetPos(0,0)o:SetSize(m,n)local p="MediaLib.HTMLMedia.FakeThink-"..self:hashCode()hook.Add("Think",p,function()if not IsValid(self.panel)then hook.Remove("Think",p)return end;self.panel:Think()end)local q=o._OldCM or o.ConsoleMessage;o._OldCM=q;o.ConsoleMessage=function(r,s)if s and not k:GetBool()then if string.find(s,"XMLHttpRequest",nil,true)then return end;if string.find(s,"Unsafe JavaScript attempt to access",nil,true)then return end;if string.find(s,"Unable to post message to",nil,true)then return end;if string.find(s,"ran insecure content from",nil,true)then return end;if string.find(s,"Mixed Content:",nil,true)then return end end;return q(r,s)end;o:AddFunction("console","warn",function(t)if not k:GetBool()then return end;o:ConsoleMessage(t)end)o:SetPaintedManually(true)o:SetVisible(false)o:AddFunction("medialiblua","Event",function(u,v)self:handleHTMLEvent(u,util.JSONToTable(v))end)end;function l:getBaseService()return"html"end;function l:openUrl(d)self.panel:OpenURL(d)self.URLChanged=CurTime()end;function l:runJS(w,...)local x=string.format(w,...)self.panel:QueueJavascript(x)end;function l:handleHTMLEvent(u,y)if a.DEBUG then MsgN("[MediaLib] HTML Event: "..u.." ("..table.ToString(y)..")")end;if u=="stateChange"then local z=y.state;local A;if y.time then self.timeKeeper:seek(y.time)end;if z=="playing"then A="playing"self.timeKeeper:play()elseif z=="ended"or z=="paused"or z=="buffering"then A=z;self.timeKeeper:pause()end;if A then self.state=A;self:emit(A)end elseif u=="playerLoaded"then for B,C in pairs(self.commandQueue or{})do C()end elseif u=="error"then self:emit("error",{errorId="service_error",errorName="Error from service: "..tostring(y.message)})else MsgN("[MediaLib] Unhandled HTML event "..tostring(u))end end;function l:getState()return self.state end;local D=CreateConVar("medialib_html_updatestride","1",FCVAR_ARCHIVE)function l:setUpdateStrideOverride(E)self._updateStrideOverride=E end;function l:updateTexture()local F=FrameNumber()local G=self._nextTextureUpdateFrame or 0;local H=self._updateStrideOverride or D:GetInt()if G<=F then self.panel:UpdateHTMLTexture()self._nextTextureUpdateFrame=F+H end end;function l:getHTMLMaterial()if self._htmlMat then return self._htmlMat end;local I=self.panel:GetHTMLMaterial()self._htmlMat=I;return I end;function l:draw(J,K,L,M)self:updateTexture()local I=self:getHTMLMaterial()if not I then return end;surface.SetMaterial(I)surface.SetDrawColor(255,255,255)local N,O=m/I:Width(),n/I:Height()surface.DrawTexturedRectUV(J or 0,K or 0,L or m,M or n,0,0,N,O)end;function l:getTime()return self.timeKeeper:getTime()end;function l:setQuality(P)if self.lastSetQuality and self.lastSetQuality==P then return end;self.lastSetQuality=P;self:runJS("medialibDelegate.run('setQuality', {quality: %q})",P)end;function l:applyVolume()local Q=self.internalVolume or 1;local R=self.volume or 1;local S=Q*R;if self.lastSetVolume and self.lastSetVolume==S then return end;self.lastSetVolume=S;self:runJS("medialibDelegate.run('setVolume', {vol: %f})",S)end;function l:setVolume(S)self.volume=S;self:applyVolume()end;function l:getVolume()return self.volume or 1 end;local T=0.2;function l:seek(U)self.timeKeeper:seek(U-T)self:runJS("medialibDelegate.run('seek', {time: %.1f})",U)end;function l:hasReliablePlaybackEvents()local V=self:getService()return V and V:hasReliablePlaybackEvents(self)end;function l:play()if not self:hasReliablePlaybackEvents()then self.timeKeeper:play()end;self:runJS("medialibDelegate.run('play')")end;function l:pause()if not self:hasReliablePlaybackEvents()then self.timeKeeper:pause()end;self:runJS("medialibDelegate.run('pause')")end;function l:stop()h.free(self.panel)self.panel=nil;self.timeKeeper:pause()self:emit("ended",{stopped=true})self:emit("destroyed")end;function l:runCommand(C)if self._playerLoaded then C()else self.commandQueue=self.commandQueue or{}self.commandQueue[#self.commandQueue+1]=C end end;function l:isValid()return IsValid(self.panel)end end;a.modulePlaceholder("service_bass")do local b=a.load("oop")local c=b.class("BASSService","Service")function c:load(d,e)local f=b.class("BASSMedia")()self:loadMediaObject(f,d,e)return f end;local g=b.class("BASSMedia","Media")function g:initialize()self.bassPlayOptions={"noplay","noblock"}self.commandQueue={}end;function g:getBaseService()return"bass"end;function g:updateFFT()local h=FrameNumber()if self._lastFFTUpdate and self._lastFFTUpdate==h then return end;self._lastFFTUpdate=h;local i=self.chan;if not IsValid(i)then return end;self.fftValues=self.fftValues or{}i:FFT(self.fftValues,FFT_512)end;function g:getFFT()return self.fftValues end;function g:draw(j,k,l,m)surface.SetDrawColor(0,0,0)surface.DrawRect(j,k,l,m)self:updateFFT()local n=self:getFFT()if not n then return end;local o=#n;local p=l/o;for q=1,o do surface.SetDrawColor(HSVToColor(q,0.9,0.5))local r=n[q]*m;surface.DrawRect(j+q*p,k+m-r,p,r)end end;function g:openUrl(d)self._openingInfo={"url",d}local s=table.concat(self.bassPlayOptions," ")sound.PlayURL(d,s,function(i,t,u)self:bassCallback(i,t,u)end)end;function g:openFile(v)self._openingInfo={"file",v}local s=table.concat(self.bassPlayOptions," ")sound.PlayFile(v,s,function(i,t,u)self:bassCallback(i,t,u)end)end;function g:reload()local w,x=unpack(self._openingInfo or{})if not w then MsgN("[Medialib] Attempting to reload BASS stream that was never started the first time!")return end;if IsValid(self.chan)then self.chan:Stop()self.chan=nil end;self._stopped=false;self:stopStateChecker()self.commandQueue={}MsgN("[Medialib] Attempting to reload BASS stream ",w,x)if w=="url"then self:openUrl(x)elseif w=="file"then self:openFile(x)elseif w then MsgN("[Medialib] Failed to reload audio resource ",w,x)return end;self:applyVolume(true)if self._commandState=="play"then self:play()end end;function g:bassCallback(i,t,u)if not IsValid(i)then ErrorNoHalt("[MediaLib] BassMedia play failed: ",u)self._stopped=true;self:emit("error","loading_failed",string.format("BASS error id: %s; name: %s",t,u))return end;if self._stopped then MsgN("[MediaLib] Loading BASS media aborted; stop flag was enabled")i:Stop()return end;self.chan=i;for y,z in pairs(self.commandQueue)do z(i)end;self.commandQueue={}self:startStateChecker()end;function g:startStateChecker()timer.Create("MediaLib_BASS_EndChecker_"..self:hashCode(),1,0,function()if IsValid(self.chan)and self.chan:GetState()==GMOD_CHANNEL_STOPPED then self:emit("ended")self:stopStateChecker()end end)end;function g:stopStateChecker()timer.Remove("MediaLib_BASS_EndChecker_"..self:hashCode())end;function g:runCommand(A)if IsValid(self.chan)then A(self.chan)else self.commandQueue[#self.commandQueue+1]=A end end;function g:applyVolume(B)local C=self.internalVolume or 1;local D=self.volume or 1;local E=C*D;if not B and self.lastSetVolume and self.lastSetVolume==E then return end;self.lastSetVolume=E;self:runCommand(function(i)i:SetVolume(E)end)end;function g:setVolume(E)self.volume=E;self:applyVolume()end;function g:getVolume()return self.volume or 1 end;function g:seek(F)self:runCommand(function(i)if i:IsBlockStreamed()then return end;self._seekingTo=F;local G="MediaLib_BASSMedia_Seeker_"..self:hashCode()local function H()if self._seekingTo~=F or not IsValid(i)then timer.Destroy(G)return end;i:SetTime(F)if math.abs(i:GetTime()-F)<0.25 then timer.Destroy(G)end end;timer.Create(G,0.2,0,H)H()end)end;function g:getTime()if self:isValid()and IsValid(self.chan)then return self.chan:GetTime()end;return 0 end;function g:getState()if not self:isValid()then return"error"end;if not IsValid(self.chan)then return"loading"end;local I=self.chan:GetState()if I==GMOD_CHANNEL_PLAYING then return"playing"end;if I==GMOD_CHANNEL_PAUSED then return"paused"end;if I==GMOD_CHANNEL_STALLED then return"buffering"end;if I==GMOD_CHANNEL_STOPPED then return"paused"end;return end;function g:play()self:runCommand(function(i)i:Play()self:emit("playing")self._commandState="play"end)end;function g:pause()self:runCommand(function(i)i:Pause()self:emit("paused")self._commandState="pause"end)end;function g:stop()self._stopped=true;self:runCommand(function(i)i:Stop()self:emit("ended",{stopped=true})self:emit("destroyed")self:stopStateChecker()end)end;function g:isValid()return not self._stopped end;local J=a.load("mediaregistry")local K="ML_MapCleanHack_"..a.INSTANCE;if CLIENT then net.Receive(K,function()for y,L in pairs(J.get())do if L:getBaseService()=="bass"and L:isValid()and IsValid(L.chan)and L.chan:GetState()==GMOD_CHANNEL_STOPPED then L:reload()end end end)end;if SERVER then util.AddNetworkString(K)hook.Add("PostCleanupMap","MediaLib_BassReload"..a.INSTANCE,function()net.Start(K)net.Broadcast()end)end end;a.FolderItems["services/gdrive.lua"]="local a=medialib.load(\"oop\")local b=a.class(\"GDriveService\",\"HTMLService\")b.identifier=\"GDrive\"local c={\"^https?://drive.google.com/file/d/([^/]*)/edit\"}function b:parseUrl(d)for e,f in pairs(c)do local g=string.match(d,f)if g then return{id=g}end end end;function b:isValidUrl(d)return self:parseUrl(d)~=nil end;local function h(i)if i then i=string.gsub(i,\"\\n\",\"\\r\\n\")i=string.gsub(i,\"([^%w ])\",function(j)return string.format(\"%%%02X\",string.byte(j))end)i=string.gsub(i,\" \",\"+\")end;return i end;local k=\"https://wyozi.github.io/gmod-medialib/mp4.html?id=%s\"local l=\"https://drive.google.com/uc?export=download&confirm=yTib&id=%s\"function b:resolveUrl(d,m)local n=self:parseUrl(d)local o=string.format(k,h(string.format(l,n.id)))m(o,{start=n.start})end;function b:directQuery(d,m)m(nil,{title=d:match(\"([^/]+)$\")})end;function b:hasReliablePlaybackEvents()return true end;return b"a.FolderItems["services/mp4.lua"]="local a=medialib.load(\"oop\")local b=a.class(\"Mp4Service\",\"HTMLService\")b.identifier=\"mp4\"local c={\"^https?://.*%.mp4\"}function b:parseUrl(d)for e,f in pairs(c)do local g=string.match(d,f)if g then return{id=g}end end end;function b:isValidUrl(d)return self:parseUrl(d)~=nil end;local h=\"https://wyozi.github.io/gmod-medialib/mp4.html?id=%s\"function b:resolveUrl(d,i)local j=self:parseUrl(d)local k=string.format(h,j.id)i(k,{start=j.start})end;function b:directQuery(d,i)i(nil,{title=d:match(\"([^/]+)$\")})end;function b:hasReliablePlaybackEvents()return true end;return b"a.FolderItems["services/soundcloud.lua"]="local a=medialib.load(\"oop\")local b=a.class(\"SoundcloudService\",\"BASSService\")b.identifier=\"soundcloud\"local c={\"^https?://www.soundcloud.com/([A-Za-z0-9_%-]+/[A-Za-z0-9_%-]+)/?.*$\",\"^https?://soundcloud.com/([A-Za-z0-9_%-]+/[A-Za-z0-9_%-]+)/?.*$\"}local d=\"^https?://api.soundcloud.com/tracks/(%d+)\"function b:parseUrl(e)for f,g in pairs(c)do local h=string.match(e,g)if h then return{path=h}end end;local i=string.match(e,d)if i then return{id=i}end end;function b:isValidUrl(e)return self:parseUrl(e)~=nil end;function b:resolveUrl(e,j)local k=medialib.SOUNDCLOUD_API_KEY;if not k then ErrorNoHalt(\"SoundCloud error: Missing SoundCloud API key\")return end;if type(k)==\"table\"then k=table.Random(k)end;local l=self:parseUrl(e)if l.id then j(string.format(\"https://api.soundcloud.com/tracks/%s/stream?client_id=%s\",l.id,k),{})else http.Fetch(string.format(\"https://api.soundcloud.com/resolve.json?url=http://soundcloud.com/%s&client_id=%s\",l.path,k),function(m)local n=util.JSONToTable(m)if not n then ErrorNoHalt(\"Failed to retrieve SC track id for \"..l.path..\": empty JSON\")return end;local i=n.id;j(string.format(\"https://api.soundcloud.com/tracks/%s/stream?client_id=%s\",i,k),{})end)end end;function b:directQuery(e,j)local k=medialib.SOUNDCLOUD_API_KEY;if not k then j(\"Missing SoundCloud API key\")return end;if type(k)==\"table\"then k=table.Random(k)end;local l=self:parseUrl(e)local o;if l.path then o=string.format(\"https://api.soundcloud.com/resolve.json?url=http://soundcloud.com/%s&client_id=%s\",l.path,k)else o=string.format(\"https://api.soundcloud.com/tracks/%s?client_id=%s\",l.id,k)end;http.Fetch(o,function(p,q)if q==0 then j(\"http body size = 0\")return end;local r=util.JSONToTable(p)if r.errors then local s=r.errors[1].error_message or\"error\"local t=s;if string.StartWith(s,\"404\")then t=\"Invalid id\"end;j(t)return end;j(nil,{title=r.title,duration=tonumber(r.duration)/1000})end,function(u)j(\"HTTP: \"..u)end)end;return b"a.FolderItems["services/twitch.lua"]="local a=medialib.load(\"oop\")local b=a.class(\"TwitchService\",\"HTMLService\")b.identifier=\"twitch\"local c={\"https?://www.twitch.tv/([A-Za-z0-9_%-]+)\",\"https?://twitch.tv/([A-Za-z0-9_%-]+)\"}function b:parseUrl(d)for e,f in pairs(c)do local g=string.match(d,f)if g then return{id=g}end end end;function b:isValidUrl(d)return self:parseUrl(d)~=nil end;local h=\"https://wyozi.github.io/gmod-medialib/twitch.html?channel=%s\"function b:resolveUrl(d,i)local j=self:parseUrl(d)local k=string.format(h,j.id)i(k,{start=j.start})end;local l=\"4cryixome326gh0x0j0fkulahsbdvx\"local function m(n,i)http.Fetch(\"https://api.twitch.tv/kraken/users?login=\"..n,function(o)local p=util.JSONToTable(o)if not p then i(\"malformed response JSON\")return end;i(nil,p.users[1]._id)end,function()i(\"failed HTTP request\")end,{Accept=\"application/vnd.twitchtv.v5+json\",[\"Client-ID\"]=l})end;local function q(g,i)http.Fetch(\"https://api.twitch.tv/kraken/channels/\"..g,function(o)local p=util.JSONToTable(o)if not p then i(\"malformed response JSON\")return end;i(nil,p)end,function()i(\"failed HTTP request\")end,{Accept=\"application/vnd.twitchtv.v5+json\",[\"Client-ID\"]=l})end;function b:directQuery(d,i)local j=self:parseUrl(d)m(j.id,function(r,g)if r then i(r)return end;q(g,function(s,t)if s then i(s)return end;local u={}u.id=j.id;if t.error then i(t.message)return else u.title=t.display_name..\": \"..t.status end;i(nil,u)end)end)end;return b"a.FolderItems["services/vimeo.lua"]="local a=medialib.load(\"oop\")local b=a.class(\"VimeoService\",\"HTMLService\")b.identifier=\"vimeo\"local c={\"https?://www.vimeo.com/([0-9]+)\",\"https?://vimeo.com/([0-9]+)\",\"https?://www.vimeo.com/channels/staffpicks/([0-9]+)\",\"https?://vimeo.com/channels/staffpicks/([0-9]+)\"}function b:parseUrl(d)for e,f in pairs(c)do local g=string.match(d,f)if g then return{id=g}end end end;function b:isValidUrl(d)return self:parseUrl(d)~=nil end;local h=\"http://wyozi.github.io/gmod-medialib/vimeo.html?id=%s\"function b:resolveUrl(d,i)local j=self:parseUrl(d)local k=string.format(h,j.id)i(k,{start=j.start})end;function b:directQuery(d,i)local j=self:parseUrl(d)local l=string.format(\"http://vimeo.com/api/v2/video/%s.json\",j.id)http.Fetch(l,function(m,n,o,p)if n==0 then i(\"http body size = 0\")return end;if p==404 then i(\"Invalid id\")return end;local q={}q.id=j.id;local r=util.JSONToTable(m)if r then q.title=r[1].title;q.duration=r[1].duration else q.title=\"ERROR\"end;i(nil,q)end,function(s)i(\"HTTP: \"..s)end)end;function b:hasReliablePlaybackEvents()return true end;return b"a.FolderItems["services/webaudio.lua"]="local a=medialib.load(\"oop\")local b=a.class(\"WebAudioService\",\"BASSService\")b.identifier=\"webaudio\"local c={\"^https?://(.*)%.mp3\",\"^https?://(.*)%.ogg\"}function b:parseUrl(d)for e,f in pairs(c)do local g=string.match(d,f)if g then return{id=g}end end end;function b:isValidUrl(d)return self:parseUrl(d)~=nil end;function b:resolveUrl(d,h)h(d,{})end;function b:directQuery(d,h)h(nil,{title=d:match(\"([^/]+)$\")})end;return b"a.FolderItems["services/webm.lua"]="local a=medialib.load(\"oop\")local b=a.class(\"WebmService\",\"HTMLService\")b.identifier=\"webm\"local c={\"^https?://.*%.webm\"}function b:parseUrl(d)for e,f in pairs(c)do local g=string.match(d,f)if g then return{id=g}end end end;function b:isValidUrl(d)return self:parseUrl(d)~=nil end;local h=\"http://wyozi.github.io/gmod-medialib/webm.html?id=%s\"function b:resolveUrl(d,i)local j=self:parseUrl(d)local k=string.format(h,j.id)i(k,{start=j.start})end;function b:directQuery(d,i)i(nil,{title=d:match(\"([^/]+)$\")})end;return b"a.FolderItems["services/webradio.lua"]="local a=medialib.load(\"oop\")local b=a.class(\"WebRadioService\",\"BASSService\")b.identifier=\"webradio\"local c={\"^https?://(.*)%.pls\",\"^https?://(.*)%.m3u\"}function b:parseUrl(d)for e,f in pairs(c)do local g=string.match(d,f)if g then return{id=g}end end end;function b:isValidUrl(d)return self:parseUrl(d)~=nil end;function b:resolveUrl(d,h)h(d,{})end;function b:directQuery(d,h)h(nil,{title=d:match(\"([^/]+)$\")})end;return b"a.FolderItems["services/youtube.lua"]="local a=medialib.load(\"oop\")local b=a.class(\"YoutubeService\",\"HTMLService\")b.identifier=\"youtube\"local c={\"^https?://[A-Za-z0-9%.%-]*%.?youtu%.be/([A-Za-z0-9_%-]+)\",\"^https?://[A-Za-z0-9%.%-]*%.?youtube%.com/watch%?.*v=([A-Za-z0-9_%-]+)\",\"^https?://[A-Za-z0-9%.%-]*%.?youtube%.com/v/([A-Za-z0-9_%-]+)\"}local d={}for e,f in pairs(c)do local function g(h)table.insert(d,f..h..\"t=(%d+)m(%d+)s\")table.insert(d,f..h..\"t=(%d+)s?\")end;g(\"#\")g(\"&\")g(\"?\")table.insert(d,f)end;function b:parseUrl(i)for e,j in pairs(d)do local k,l,m=string.match(i,j)if k then local n;if l and m then n=tonumber(l)*60+tonumber(m)else n=tonumber(l)end;return{id=k,start=n}end end end;function b:isValidUrl(i)return self:parseUrl(i)~=nil end;local o=\"http://wyozi.github.io/gmod-medialib/youtube.html?id=%s\"function b:resolveUrl(i,p)local q=self:parseUrl(i)local r=string.format(o,q.id)p(r,{start=q.start})end;local function s(t)local u=t:match(\"(%d+)H\")or 0;local v=t:match(\"(%d+)M\")or 0;local w=t:match(\"(%d+)S\")or 0;return u*60*60+v*60+w end;local x=\"AIzaSyBmQHvMSiOTrmBKJ0FFJ2LmNtc4YHyUJaQ\"function b:directQuery(i,p)local y=medialib.YOUTUBE_API_KEY or x;local q=self:parseUrl(i)local z=string.format(\"https://www.googleapis.com/youtube/v3/videos?part=snippet%%2CcontentDetails&id=%s&key=%s\",q.id,y)http.Fetch(z,function(A,B)if B==0 then p(\"http body size = 0\")return end;local C={}C.id=q.id;local D=util.JSONToTable(A)if D and D.items then local E=D.items[1]if not E then p(\"No video id found\")return end;C.title=E.snippet.title;local F=E.snippet.liveBroadcastContent==\"live\"if F then C.live=true else C.duration=tonumber(s(E.contentDetails.duration))end;C.raw=E else p(A)return end;p(nil,C)end,function(G)p(\"HTTP: \"..G)end)end;function b:hasReliablePlaybackEvents()return true end;return b"a.modulePlaceholder("serviceloader")do a.load("servicebase")a.load("service_html")a.load("service_bass")local b=a.load("media")for c,d in a.folderIterator("services")do if a.DEBUG then print("[MediaLib] Registering service "..d.name)end;if SERVER then d:addcs()end;local e,f=pcall(function()return d:load()end)if e then b.registerService(f.identifier,f)else print("[MediaLib] Failed to load service ",d,": ",f)end end end;a.modulePlaceholder("__loader")do a.load("mediabase")a.load("media")a.load("serviceloader")end;return a