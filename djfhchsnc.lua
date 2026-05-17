local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local UIS=game:GetService("UserInputService")
local TweenService=game:GetService("TweenService")
local HttpService=game:GetService("HttpService")
local Lighting=game:GetService("Lighting")
local ReplicatedStorage=game:GetService("ReplicatedStorage")
local PlayerGui=Players.LocalPlayer:WaitForChild("PlayerGui")
local LP=Players.LocalPlayer

if getgenv and getgenv().LOOPRIX_RUNNING then return end
if getgenv then getgenv().LOOPRIX_RUNNING=true end

do
    local _game=game
    local _oGetService=_game.GetService
    local _oFindService=_game.FindService
    local __serviceCache={}
    local function _GetService(Name)
        local c=__serviceCache[Name]
        if c then return c end
        local s=_oFindService(_game,Name)or _oGetService(_game,Name)
        if s then __serviceCache[Name]=s end
        return s
    end
    local _Kicks={new=LP.Kick,old=LP.kick}
    local function _runKickChecks()
        local cases={
            function()for _,k in _Kicks do k(123)end end,
            function()for _,k in _Kicks do k(workspace)end end,
            function()for _,k in _Kicks do k("")end end,
            function()for _,k in _Kicks do k({})end end,
            function()for _,k in _Kicks do k(nil)end end,
            function()
                local obj=newproxy(true)
                local mt=getmetatable(obj)
                for _,mm in{"__eq","__lt","__le","__add","__sub","__mul","__div","__mod","__pow","__unm","__len","__call","__index","__concat","__tostring","__newindex"}do mt[mm]=error end
                for _,k in _Kicks do k(obj)end
            end,
            function()LP:kIcK()end,
        }
        for idx,fn in ipairs(cases)do
            local ok,err=xpcall(fn,function(e)return e end)
            if ok then
                warn("[LOOPRIX-AC] Anti-Kick 0x"..idx)
            elseif idx==6 then
                if err~="Expected ':' not '.' calling member function Kick"then
                    warn("[LOOPRIX-AC] Anti-Kick 0x6")
                end
            end
        end
    end
    task.spawn(function()
        while task.wait(0.5)do
            local lastTick,isDone=tick(),false
            local thread=coroutine.create(function()
                _runKickChecks()
                isDone=true
            end)
            coroutine.resume(thread)
            while not isDone do
                if tick()-lastTick>5 then
                    coroutine.close(thread)
                    warn("[LOOPRIX-AC] Anti-Kick watchdog 0x9")
                    break
                end
                task.wait(0.1)
            end
        end
    end)
    local __hmIndex,__hmNewindex,__hmNamecall
    xpcall(function()return game.__ end,function()__hmIndex=debug.info(2,"f")end)
    xpcall(function()game.__=10 end,function()__hmNewindex=debug.info(2,"f")end)
    xpcall(function()game.__()end,function()__hmNamecall=debug.info(2,"f")end)
    task.spawn(function()
        while task.wait(1)do
            local s,r
            s,r=pcall(__hmIndex,123)
            if r~="invalid argument #1 (Instance expected, got number)"then
                warn("[LOOPRIX-AC] hookmetamethod __index")
            end
            s,r=pcall(__hmNewindex,123)
            if r~="invalid argument #1 (Instance expected, got number)"then
                warn("[LOOPRIX-AC] hookmetamethod __newindex")
            end
            s,r=pcall(__hmNamecall,123)
            if r~="invalid argument #1 (Instance expected, got number)"then
                warn("[LOOPRIX-AC] hookmetamethod __namecall")
            end
        end
    end)
    local __grIndex,__grNewindex,__grNamecall
    xpcall(function()return game.______ end,function()__grIndex=debug.info(2,"f")end)
    xpcall(function()game.______=1 end,function()__grNewindex=debug.info(2,"f")end)
    xpcall(function()game:______()end,function()__grNamecall=debug.info(2,"f")end)
    task.spawn(function()
        while task.wait(1)do
            xpcall(function()return game.______ end,function()
                if debug.info(2,"f")~=__grIndex then warn("[LOOPRIX-AC] getrawmetatable __index")end
            end)
            xpcall(function()game.______=1 end,function()
                if debug.info(2,"f")~=__grNewindex then warn("[LOOPRIX-AC] getrawmetatable __newindex")end
            end)
            xpcall(function()game:______()end,function()
                if debug.info(2,"f")~=__grNamecall then warn("[LOOPRIX-AC] getrawmetatable __namecall")end
            end)
        end
    end)
    pcall(function()
        local st=script
        script=nil
        st.Parent=nil
        st=nil
        getfenv().script=nil
        for lvl=0,1 do
            pcall(function()getfenv(lvl).script=nil end)
        end
    end)
    task.spawn(function()
        while true do
            local done=false
            local elapsed=0
            local th=coroutine.create(function()
                task.wait(2)
                done=true
            end)
            coroutine.resume(th)
            local conn=RunService.Heartbeat:Connect(function(dt)
                elapsed=elapsed+dt
            end)
            while not done and elapsed<4 do
                task.wait(0.2)
            end
            conn:Disconnect()
            coroutine.close(th)
            if not done then
                warn("[LOOPRIX-AC] task.wait freeze detected")
                break
            end
            task.wait(5)
        end
    end)
end

CONFIG={
    LOCK_TARGET_PANEL_VISIBLE=false,
    DROP_BRAINROT_PANEL_VISIBLE=false,
    SPEED_GUI_VISIBLE=false,
    TP_DOWN_PANEL_VISIBLE=false,
    SPINBOT_PANEL_VISIBLE=false,
    TAUNT_PANEL_VISIBLE=false,
    ANTI_STEAL_PANEL_VISIBLE=false,
    AUTO_LOCK_PANEL_VISIBLE=false,
    TP_DOWN_PANEL_VISIBLE=false,
    AUTO_WALK_PANEL_VISIBLE=false,
    AUTO_PLAY_GUI_VISIBLE=false,
    LAGGER_GUI_VISIBLE=false,
    INSTANT_RESET_PANEL_VISIBLE=false,
    ACTIVE_HUD_VISIBLE=false,
    GRAB_BAR_VISIBLE=true,
    MAIN_GUI_VISIBLE=true,
    AUTO_BAT_ENABLED=false,
    COUNTER_BAT_ENABLED=false,
    SPINBOT_ENABLED=false,
    ANTIRAGDOLL_ENABLED=false,
    UNWALK_ENABLED=false,
    ESP_ENABLED=false,
    INF_JUMP_ENABLED=false,
    AUTO_MEDUSA_ENABLED=false,
    MEDUSA_COUNTER_ENABLED=false,
    AUTO_STEAL_ENABLED=false,
    ANTI_DIE_ENABLED=true,
    UI_LOCKED=false,
    SPEED_ENABLED=false,
    NO_COLLISION_ENABLED=false,
    HARDER_HIT_ENABLED=false,
    TP_DOWN_ENABLED=false,
    AUTO_TP_DOWN_ENABLED=false,
    AUTO_REACT_STEAL_ENABLED=false,
    NOTIFICATIONS_ENABLED=false,
    POST_DROP_HALT_ENABLED=false,
    SNAP_LOCK_ENABLED=false,
    SPEED_VALUE=60,
    STEAL_SPEED_VALUE=30,
    SPEED_PRESET="normal",
    PRESET_NORMAL_SPEED=60,
    PRESET_NORMAL_STEAL=30,
    PRESET_DESYNC_SPEED=40,
    PRESET_DESYNC_STEAL=20,
    PRESET_LAGGER_SPEED=15,
    PRESET_LAGGER_STEAL=8,
    SPINBOT_SPEED=30,
    LOCK_TARGET_SPEED=55,
    LOCK_TARGET_3D_DISTANCE=10,
    MIRROR_TP_DOWN_ENABLED=false,
    MIRROR_TP_DOWN_THRESHOLD=8,
    AUTO_MEDUSA_RANGE=5,
    AUTO_STEAL_ACTIVATION_DIST=25,
    FOV_VALUE=70,
    FOV_LOCK_ENABLED=false,
    GUI_COLOR_R=0,
    GUI_COLOR_G=217,
    GUI_COLOR_B=127,
    UI_SCALE=1.0,
    AUTO_PLAY_DELAY=0.03,
    LAGGER_SPAM=270,
    LAGGER_TRIES=1,
    LAGGER_DELAY=0.3,
    TOGGLE_GUI_KEYBIND=nil,
    AUTO_BAT_KEYBIND=nil,
    SPINBOT_KEYBIND=nil,
    LOCK_TARGET_KEYBIND=nil,
    AUTO_MEDUSA_KEYBIND=nil,
    AUTO_STEAL_KEYBIND=nil,
    DROP_BRAINROT_KEYBIND=nil,
    AUTO_PLAY_KEYBIND=nil,
    ANTI_STEAL_KEYBIND=nil,
    AUTO_LOCK_KEYBIND=nil,
    AUTO_WALK_KEYBIND=nil,
    TP_DOWN_KEYBIND=nil,
    AUTO_REACT_STEAL_KEYBIND=nil,
    SPEED_PRESET_KEYBIND=nil,
    INSTANT_RESET_KEYBIND=nil,
    AUTO_STEAL_DURATION=1.3,
    JUMP_BOOST_ENABLED=false,
    JUMP_BOOST_GRAVITY_PERCENT=70,
    JUMP_BOOST_HOP_POWER=35,
    JUMP_BOOST_HOP_COOLDOWN=0.08,
    _guiPositions=nil,
    _autoPlayOffsets=nil,
    _apBasePositions=nil,
}
getgenv().LOOPRIX_CONFIG=CONFIG

scaleMultiplier=1.0
_registeredScaleInstances={}
function registerScaleTarget(frame,baseScale)
    baseScale=baseScale or 1.0
    if not frame then return nil end
    local existing=frame:FindFirstChildOfClass("UIScale")
    if existing then
        existing.Scale=baseScale*scaleMultiplier
        table.insert(_registeredScaleInstances,{us=existing,base=baseScale})
        return existing
    else
        local us=Instance.new("UIScale")
        us.Scale=baseScale*scaleMultiplier
        us.Parent=frame
        table.insert(_registeredScaleInstances,{us=us,base=baseScale})
        return us
    end
end
function applyUIScale(scale)
    scale=math.clamp(scale,0.5,1.25)
    scaleMultiplier=scale
    CONFIG.UI_SCALE=scale
    for _,entry in ipairs(_registeredScaleInstances)do
        pcall(function()
            if entry.us and entry.us.Parent then
                entry.us.Scale=entry.base*scale
            end
        end)
    end
end

CONFIG_FILE="LooprixDuel.json"
_UIS=game:GetService("UserInputService")
_RS=game:GetService("RunService")
function _getViewport()
    local cam=workspace.CurrentCamera
    return cam and cam.ViewportSize or Vector2.new(1920,1080)
end
function clampToScreen(frame,padX,padY)
    padX=padX or 4
    padY=padY or 4
    local vp=_getViewport()
    local size=frame.AbsoluteSize
    local cx=math.clamp(frame.AbsolutePosition.X,padX,vp.X-size.X-padX)
    local cy=math.clamp(frame.AbsolutePosition.Y,padY,vp.Y-size.Y-padY)
    frame.Position=UDim2.fromOffset(cx,cy)
end
function makeDraggable(frame,handle,saveKey,lockedFn,onSaved)
    handle=handle or frame
    lockedFn=lockedFn or function()return false end
    local drag,ds,sp,dragConn=false,nil,nil,nil
    local lastDragUpdate=0
    local wasDrag=false
    handle.InputBegan:Connect(function(inp)
        if lockedFn()then return end
        if inp.UserInputType~=Enum.UserInputType.MouseButton1 and inp.UserInputType~=Enum.UserInputType.Touch then return end
        drag=true;ds=inp.Position;sp=frame.Position;wasDrag=false
        if dragConn then dragConn:Disconnect()end
        dragConn=inp.Changed:Connect(function()
            if inp.UserInputState==Enum.UserInputState.End then
                drag=false
                if dragConn then dragConn:Disconnect();dragConn=nil end
                if wasDrag and saveKey then
                    CONFIG._guiPositions=CONFIG._guiPositions or{}
                    CONFIG._guiPositions[saveKey]={
                        scaleX=0,scaleY=0,
                        offsetX=frame.Position.X.Offset,
                        offsetY=frame.Position.Y.Offset,
                    }
                    saveConfig()
                    if onSaved then onSaved()end
                end
            end
        end)
    end)
    _UIS.InputChanged:Connect(function(inp)
        if lockedFn()then return end
        if not drag then return end
        if inp.UserInputType~=Enum.UserInputType.MouseMovement and inp.UserInputType~=Enum.UserInputType.Touch then return end
        local now=tick()
        if now-lastDragUpdate<0.016 then return end
        lastDragUpdate=now
        local d=inp.Position-ds
        local vp=_getViewport()
        local size=frame.AbsoluteSize
        local nx=math.clamp(sp.X.Offset+d.X,4,vp.X-size.X-4)
        local ny=math.clamp(sp.Y.Offset+d.Y,4,vp.Y-size.Y-4)
        frame.Position=UDim2.fromOffset(nx,ny)
        wasDrag=true
    end)
    return function()return not wasDrag end
end
function loadAndClampPosition(frame,key,defaultPos)
    local pos=CONFIG._guiPositions and CONFIG._guiPositions[key]
    if pos then
        frame.Position=UDim2.new(pos.scaleX or 0,pos.offsetX or 0,pos.scaleY or 0,pos.offsetY or 0)
    elseif defaultPos then
        frame.Position=defaultPos
    end
    task.defer(function()
        if frame and frame.Parent then clampToScreen(frame)end
    end)
end

CONFIG_VERSION=5
_KEYBIND_SET={
    TOGGLE_GUI_KEYBIND=true,SPINBOT_KEYBIND=true,LOCK_TARGET_KEYBIND=true,AUTO_MEDUSA_KEYBIND=true,
    AUTO_STEAL_KEYBIND=true,DROP_BRAINROT_KEYBIND=true,
    AUTO_PLAY_KEYBIND=true,ANTI_STEAL_KEYBIND=true,
    AUTO_LOCK_KEYBIND=true,AUTO_WALK_KEYBIND=true,TP_DOWN_KEYBIND=true,
    AUTO_REACT_STEAL_KEYBIND=true,SPEED_PRESET_KEYBIND=true,INSTANT_RESET_KEYBIND=true,
}
_TABLE_KEYS={_guiPositions=true,_autoPlayOffsets=true,_apBasePositions=true}
_savePending=false
function _doWrite()
    pcall(function()
        if not writefile then return end
        local cfg={}
        for k,v in pairs(CONFIG)do
            if _KEYBIND_SET[k]then
                if v~=nil then
                    if type(v)=="table"and v.Type and v.Key then
                        cfg[k]={type=v.Type,key=v.Key.Name}
                    elseif type(v)~="table"then
                        cfg[k]={type="Keyboard",key=v.Name}
                    end
                end
            elseif _TABLE_KEYS[k]then
                if v~=nil then cfg[k]=v end
            elseif type(v)~="function"and v~=nil then
                cfg[k]=v
            end
        end
        cfg.MAIN_GUI_VISIBLE=guiVisible
        cfg._version=CONFIG_VERSION
        writefile(CONFIG_FILE,game:GetService("HttpService"):JSONEncode(cfg))
    end)
end
function saveConfig()
    if _savePending then return end
    _savePending=true
    task.delay(0.65,function()
        _savePending=false
        _doWrite()
    end)
end
function loadConfig()
    if not isfile or not isfile(CONFIG_FILE)then
        _doWrite()
        return
    end
    local raw
    local readOk=pcall(function()raw=readfile(CONFIG_FILE)end)
    if not readOk or type(raw)~="string"or raw==""then
        _doWrite()
        return
    end
    local decodeOk,decoded=pcall(function()
        return game:GetService("HttpService"):JSONDecode(raw)
    end)
    if not decodeOk or type(decoded)~="table"then
        _doWrite()
        return
    end
    for k,defaultVal in pairs(CONFIG)do
        if decoded[k]==nil and not _KEYBIND_SET[k]and not _TABLE_KEYS[k]then
            decoded[k]=defaultVal
        end
    end
    local savedVer=tonumber(decoded._version)or 0
    for k,v in pairs(decoded)do
        if k=="_version"then
        elseif _KEYBIND_SET[k]then
            if type(v)=="string"and v~=""then
                local ok2,kc=pcall(function()return Enum.KeyCode[v]end)
                if ok2 and kc then CONFIG[k]={Type="Keyboard",Key=kc}end
            elseif type(v)=="table"and type(v.type)=="string"and type(v.key)=="string"and v.key~=""then
                local ok2,kc=pcall(function()return Enum.KeyCode[v.key]end)
                if ok2 and kc then CONFIG[k]={Type=v.type,Key=kc}end
            end
        elseif k=="_guiPositions"then
            if type(v)=="table"then
                local safe={}
                for pk,pv in pairs(v)do
                    if type(pv)=="table"then safe[pk]=pv end
                end
                CONFIG._guiPositions=safe
            end
        elseif k=="_autoPlayOffsets"then
            if type(v)=="table"then CONFIG._autoPlayOffsets=v end
        elseif k=="_apBasePositions"then
            if type(v)=="table"then CONFIG._apBasePositions=v end
        elseif k=="MAIN_GUI_VISIBLE"then
            if type(v)=="boolean"then guiVisible=v
            elseif v==1 or v=="true"then guiVisible=true
            else guiVisible=false end
        elseif CONFIG[k]~=nil then
            local expected=type(CONFIG[k])
            if expected=="boolean"then
                if type(v)=="boolean"then CONFIG[k]=v
                elseif v==1 or v=="true"then CONFIG[k]=true
                elseif v==0 or v=="false"then CONFIG[k]=false end
            elseif expected=="number"then
                local n=tonumber(v)
                if n then CONFIG[k]=n end
            else
                CONFIG[k]=v
            end
        end
    end
    scaleMultiplier=math.clamp(CONFIG.UI_SCALE or 1.0,0.5,1.25)
    pcall(function()
        local cam=workspace.CurrentCamera
        if cam then cam.FieldOfView=CONFIG.FOV_VALUE or 70 end
    end)
    getgenv().LOOPRIX_CONFIG=CONFIG
    if savedVer~=CONFIG_VERSION then
        _doWrite()
    end
end
function saveGuiPosition(frame,pathParts)
    if not frame or not pathParts then return end
    CONFIG._guiPositions=CONFIG._guiPositions or{}
    CONFIG._guiPositions[pathParts]={
        scaleX=frame.Position.X.Scale,
        scaleY=frame.Position.Y.Scale,
        offsetX=frame.Position.X.Offset,
        offsetY=frame.Position.Y.Offset
    }
    saveConfig()
end
function loadGuiPosition(frame,pathParts)
    if not frame or not pathParts then return end
    CONFIG._guiPositions=CONFIG._guiPositions or{}
    local pos=CONFIG._guiPositions[pathParts]
    if pos then
        frame.Position=UDim2.new(pos.scaleX,pos.offsetX,pos.scaleY,pos.offsetY)
    end
end

COLORS={
    Background=Color3.fromRGB(12,14,20),
    BackgroundTransparency=0.1,
    Surface=Color3.fromRGB(20,24,34),
    SurfaceTransparency=0.10,
    Text=Color3.fromRGB(255,255,255),
    TextDim=Color3.fromRGB(180,190,200),
    Accent=Color3.new(0.000000,0.850980,0.498039),
    Purple=Color3.new(0.125490,0.898039,0.549020),
    Pink=Color3.fromRGB(150,255,180),
    Cyan=Color3.fromRGB(120,255,210),
    Yellow=Color3.fromRGB(255,235,120),
    Blue=Color3.fromRGB(140,200,255),
    Red=Color3.fromRGB(255,100,120),
}
_accentStrokes={}
_accentFrames={}
_accentLabels={}
_accentGradients={}
_accentDots={}
function _buildAccentGradient(r,g,b)
    local c=Color3.fromRGB(r,g,b)
    local bright=Color3.fromRGB(math.min(r+80,255),math.min(g+40,255),math.min(b+60,255))
    return ColorSequence.new({
        ColorSequenceKeypoint.new(0,c),
        ColorSequenceKeypoint.new(0.33,bright),
        ColorSequenceKeypoint.new(0.66,bright),
        ColorSequenceKeypoint.new(1,c)
    })
end
function applyAccentColor(r,g,b)
    local newColor=Color3.fromRGB(r,g,b)
    COLORS.Accent=newColor
    CONFIG.GUI_COLOR_R=r
    CONFIG.GUI_COLOR_G=g
    CONFIG.GUI_COLOR_B=b
    for _,s in ipairs(_accentStrokes)do
        pcall(function()if s and s.Parent then s.Color=newColor end end)
    end
    for _,f in ipairs(_accentFrames)do
        pcall(function()if f and f.Parent then f.BackgroundColor3=newColor end end)
    end
    for _,l in ipairs(_accentLabels)do
        pcall(function()if l and l.Parent then l.TextColor3=newColor end end)
    end
    for _,d in ipairs(_accentDots)do
        pcall(function()if d and d.Parent then d.BackgroundColor3=newColor end end)
    end
    local gradSeq=_buildAccentGradient(r,g,b)
    for _,g2 in ipairs(_accentGradients)do
        pcall(function()if g2 and g2.Parent then g2.Color=gradSeq end end)
    end
    pcall(updateEspAccentColor,r,g,b)
    pcall(function()
        if medusaCircle and medusaCircle.Parent then
            medusaCircle.Color3=newColor
        end
    end)
end
function trackStroke(s)table.insert(_accentStrokes,s)return s end
function trackFrame(f)table.insert(_accentFrames,f)return f end
function trackLabel(l)table.insert(_accentLabels,l)return l end
function trackGradient(g)table.insert(_accentGradients,g)return g end
function trackDot(d)table.insert(_accentDots,d)return d end

S={
    Players=Players,
    UserInputService=UIS,
    TweenService=TweenService,
    HttpService=HttpService,
    RunService=RunService,
    Lighting=Lighting,
    ReplicatedStorage=ReplicatedStorage
}
S.LocalPlayer=LP
S.PlayerGui=PlayerGui

screenGui,mainFrame,contentFrame,tabBar=nil,nil,nil,nil
lockTargetPanelGui,lockTargetPanelBtn=nil,nil
dropBrainrotPanelGui,dropBrainrotPanelBtn=nil,nil
spinbotPanelGui,spinbotPanelBtn=nil,nil
tauntPanelGui,tauntPanelBtn=nil,nil
tpDownPanelGui,tpDownPanelBtn=nil,nil
_spinbotBtn=nil
_instantResetPanelGui,_instantResetPanelBtn=nil,nil

guiVisible=true
isMinimized=false
currentTab="duel"

attacking=false
spinbotEnabled=false
unwalkEnabled=false
espEnabled=false
infJumpEnabled=false
lockTargetEnabled=false
isSwitching=false
_lockManuallyOn=false
autoMedusaEnabled=false
autoStealGrabEnabled=false

medusaCounterEnabled=false
medusaCounterConns={}
MEDUSA_COUNTER_COOLDOWN=25
medusaCounterLastUsed=0
medusaCounterDebounce=false
antiDieEnabled=false

speedGuiEnabled=false
speedGuiInstance=nil
laggerGuiInstance=nil

_laggerEnabled=false
_laggerLoopThread=nil

_speedValBox=nil
_stealValBox=nil
_lagSpamBox=nil
_lagTriesBox=nil
_lagDelayBox=nil

AP={
    enabled=false,
    loopConn=nil,
    currentStep=1,
    isWaiting=false,
    activeSide=nil,
    settingsOpen=false,
    settingsSide="L",
    btnL=nil,
    btnR=nil,
    guiInstance=nil,
    espFolder=nil,
    espParts={},
    BASE={
        L={
            P1=Vector3.new(-485.04,-4.90,26.11),
            P2=Vector3.new(-476.52,-6.42,28.10),
            P3=Vector3.new(-475.17,-6.93,92.61),
            P4=Vector3.new(-476.06,-6.64,94.73),
            P5=Vector3.new(-483.34,-5.10,97.76),
        },
        R={
            P1=Vector3.new(-484.70,-5.00,94.59),
            P2=Vector3.new(-476.28,-6.58,93.77),
            P3=Vector3.new(-474.70,-7.00,28.32),
            P4=Vector3.new(-476.26,-6.58,26.00),
            P5=Vector3.new(-483.50,-5.10,23.27),
        },
    },
    SEQUENCE={"P3","P4","P5","P4","P2","P1"},
    POINT_KEYS={"P1","P2","P3","P4","P5"},
    offsets={
        L={P1={x=0,z=0},P2={x=0,z=0},P3={x=0,z=0},P4={x=0,z=0},P5={x=0,z=0}},
        R={P1={x=0,z=0},P2={x=0,z=0},P3={x=0,z=0},P4={x=0,z=0},P5={x=0,z=0}},
    },
    sideBoxes={
        L={P1={x="0",z="0"},P2={x="0",z="0"},P3={x="0",z="0"},P4={x="0",z="0"},P5={x="0",z="0"}},
        R={P1={x="0",z="0"},P2={x="0",z="0"},P3={x="0",z="0"},P4={x="0",z="0"},P5={x="0",z="0"}},
    },
    _plotReady=false,
    _autoSide=nil,
    _sideLocked=false,
    _sideVotes={L=0,R=0},
    _stepStartTick=0,
}
apBtnL,apBtnR,apGuiInstance=nil,nil,nil

spinbotConnection=nil
espConnection=nil
infJumpConnection=nil
lockTargetConnection=nil
autoMedusaConnection=nil
medusaCharAddedConnection=nil
autoStealGrabConnection=nil
autoStealGrabProgressConnection=nil
antiDieConnection=nil
speedBoostConn=nil

local MOVE_KEYS={
    [Enum.KeyCode.W]=true,[Enum.KeyCode.A]=true,
    [Enum.KeyCode.S]=true,[Enum.KeyCode.D]=true,
    [Enum.KeyCode.Up]=true,[Enum.KeyCode.Down]=true,
    [Enum.KeyCode.Left]=true,[Enum.KeyCode.Right]=true,
}
local _lastMoveDir=Vector3.zero

spinBAV=nil
savedAnimations={}
originalTransparency={}
medusaCircle=nil

_espHitboxes={}
_draggableRegistry={}
function _regDraggable(frame,defaultPosFn)
    table.insert(_draggableRegistry,{frame=frame,defaultFn=defaultPosFn})
end
_duelToggleBtns={}
_discordBB=nil
_discordCharConn=nil

tweenInfoFast=TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
tweenInfoMedium=TweenInfo.new(0.35,Enum.EasingStyle.Quart,Enum.EasingDirection.Out)

character=LP.Character or LP.CharacterAdded:Wait()
HRP=character:WaitForChild("HumanoidRootPart")

connections={}
cleanupFunctions={}

_sideDetected=false
_currentSide=nil

_PLOT_POSITIONS={
    [3]=Vector3.new(-476.7524719238281,10.464664459228516,7.107429504394531),
    [7]=Vector3.new(-476.7524719238281,10.464664459228516,114.10742950439453),
}
_PLOT_TO_SIDE={[3]="L",[7]="R"}

antiDieConnections={}

_arV2Conn=nil
_arV2Enabled=false

_toastGui=nil
_toastContainer=nil
_toastCount=0

dropBrainrotActive=false
DROP_ASCEND_DURATION=0.2
DROP_ASCEND_SPEED=150

_harderHitAnims={
    idle1="rbxassetid://133806214992291",
    idle2="rbxassetid://94970088341563",
    walk="rbxassetid://707897309",
    run="rbxassetid://707861613",
    jump="rbxassetid://116936326516985",
    fall="rbxassetid://116936326516985",
    climb="rbxassetid://116936326516985",
    swim="rbxassetid://116936326516985",
    swimidle="rbxassetid://116936326516985",
}
_savedOrigAnims=nil
_animHeartbeatConn=nil

_autoBatGen=0

ESP_NAME="Looprix_Esp"
ESP_BEAM_NAME="Looprix_EspBeam"
espCache={}
_espHighlights={}
_espBeams={}
_espArcs={}

AW={
    enabled=false,
    loopConn=nil,
    currentStep=1,
    activeSide=nil,
    WALK_SEQ={"P3","P4","P5"},
    BASE={
        L={
            P3=Vector3.new(-475.17,-6.93,92.61),
            P4=Vector3.new(-476.06,-6.64,94.73),
            P5=Vector3.new(-483.34,-5.10,97.76),
        },
        R={
            P3=Vector3.new(-474.70,-7.00,28.32),
            P4=Vector3.new(-476.26,-6.58,26.00),
            P5=Vector3.new(-483.50,-5.10,23.27),
        },
    },
}
awGuiInstance=nil
awWalkBtnL=nil
awWalkBtnR=nil

jumpForce=50


noCollisionConnection=nil


getconnections=getconnections or get_signal_cons or getconnects or(syn and syn.get_signal_cons)

autoStealEnabled=false
isStealing=false
stealStartTime=nil
StealData={}
autoStealConn=nil
stealProgressConnection=nil
stealFillFrame=nil
_allAnimalsCache={}
_promptMemoryCache={}
_internalStealCache={}

jumpBoostEnabled=false
_galaxyVectorForce=nil
_galaxyAttachment=nil
_galaxyEnabled=false
_jumpBoostHopsEnabled=false
_jumpBoostLastHop=0
_jumpBoostSpaceHeld=false
_jumpBoostOriginalJumpPower=50
DEFAULT_GRAVITY=196.2

_autoStealCircleParts={}
AUTO_STEAL_PARTS_COUNT=64



autoReactStealEnabled=false
_autoReactStealConn=nil
_autoReactStealCooldown=false

antiStealEnabled=false
_antiStealConn=nil
startAntiStealWatcher,stopAntiStealWatcher=nil,nil

autoLockEnabled2=false
_autoLockConn=nil
startAutoLockWatcher,stopAutoLockWatcher=nil,nil

counterBatEnabled2=false
_counterBatConn=nil
startCounterBatWatcher,stopCounterBatWatcher=nil,nil

REACT_STEAL_KEYWORD="someone is stealing"


function addConnection(conn)
    table.insert(connections,conn)
end
_doSnapLock=nil
_doPostDropHalt=nil
function clearConnections()
    for _,conn in ipairs(connections)do
        pcall(function()conn:Disconnect()end)
    end
    connections={}
end
function registerCleanup(func)
    table.insert(cleanupFunctions,func)
end
function runCleanups()
    for _,f in ipairs(cleanupFunctions)do
        pcall(f)
    end
    cleanupFunctions={}
end

function _getBindDisplayText(bind)
    if not bind then return"None"end
    if type(bind)=="table"and bind.Type and bind.Key then
        if bind.Type=="Gamepad"then
            return"GP:"..bind.Key.Name
        else
            return bind.Key.Name
        end
    elseif type(bind)~="table"then
        return bind.Name
    end
    return"None"
end
function isKeybindPressed(bind,input)
    if not bind then return false end
    if input.KeyCode==Enum.KeyCode.Unknown then return false end
    local kc=input.KeyCode
    if type(bind)=="table"and bind.Type and bind.Key then
        if bind.Type=="Keyboard"then
            return input.UserInputType==Enum.UserInputType.Keyboard and kc==bind.Key
        elseif bind.Type=="Gamepad"then
            local isGP=input.UserInputType==Enum.UserInputType.Gamepad1
                or input.UserInputType==Enum.UserInputType.Gamepad2
                or input.UserInputType==Enum.UserInputType.Gamepad3
                or input.UserInputType==Enum.UserInputType.Gamepad4
            return isGP and kc==bind.Key
        end
    else
        return input.UserInputType==Enum.UserInputType.Keyboard and kc==bind
    end
    return false
end

function _getPlotOwnerText(plotSign)
    for _,child in ipairs(plotSign:GetDescendants())do
        if child:IsA("SurfaceGui")then
            for _,label in ipairs(child:GetDescendants())do
                if label:IsA("TextLabel")and label.Text~=""then
                    return label.Text
                end
            end
        end
    end
    return""
end
function _getMyPlot()
    local lp=LP
    for plotNum,pos in pairs(_PLOT_POSITIONS)do
        for _,obj in ipairs(workspace:GetDescendants())do
            if obj:IsA("BasePart")and obj.Name=="PlotSign"then
                if(obj.Position-pos).Magnitude<1 then
                    local ownerText=_getPlotOwnerText(obj)
                    if ownerText:find(lp.Name,1,true)or ownerText:find(lp.DisplayName,1,true)then
                        return plotNum
                    end
                end
            end
        end
    end
    return nil
end
function _waitMyPlot()
    repeat task.wait(0.5)until _getMyPlot()~=nil
end
function _detectSide()
    if _sideDetected then return _currentSide end
    local plotNum=_getMyPlot()
    if not plotNum then return nil end
    local side=_PLOT_TO_SIDE[plotNum]
    if side then
        _currentSide=side
        _sideDetected=true
        return side
    end
    return nil
end
function _detectSideNow()
    local plotNum=_getMyPlot()
    if not plotNum then return nil end
    local side=_PLOT_TO_SIDE[plotNum]or(plotNum==7 and"R"or"L")
    _currentSide=side
    _sideDetected=true
    AP._autoSide=side
    AP._sideLocked=true
    AP._plotReady=true
    return side
end
function GetSide()
    return _currentSide
end

function deactivateAntiDie()
    for _,conn in ipairs(antiDieConnections)do
        pcall(function()conn:Disconnect()end)
    end
    antiDieConnections={}
    local char=LP.Character
    if not char then return end
    local hum=char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    pcall(function()hum.BreakJointsOnDeath=true end)
    pcall(function()hum:SetStateEnabled(Enum.HumanoidStateType.Dead,true)end)
end
function activateAntiDie()
    deactivateAntiDie()
    local char=LP.Character
    if not char then return end
    local hum=char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    pcall(function()hum.BreakJointsOnDeath=false end)
    pcall(function()hum:SetStateEnabled(Enum.HumanoidStateType.Dead,false)end)
    local _conn=hum:GetPropertyChangedSignal("Health"):Connect(function()
        if hum.Health<=0 then
            pcall(function()hum.Health=hum.MaxHealth end)
        end
    end)
    table.insert(antiDieConnections,_conn)
end

function startAntiRagdollV2()
    if _arV2Conn then return end
    _arV2Conn=RunService.Heartbeat:Connect(function()
        if not _arV2Enabled then return end
        local char=LP.Character
        if not char then return end
        local root=char:FindFirstChild("HumanoidRootPart")
        local hum=char:FindFirstChildOfClass("Humanoid")
        if hum then
            local humState=hum:GetState()
            if humState==Enum.HumanoidStateType.Physics
            or humState==Enum.HumanoidStateType.Ragdoll
            or humState==Enum.HumanoidStateType.FallingDown then
                hum:ChangeState(Enum.HumanoidStateType.Running)
                workspace.CurrentCamera.CameraSubject=hum
                pcall(function()
                    local PlayerModule=LP.PlayerScripts:FindFirstChild("PlayerModule")
                    if PlayerModule then
                        local Controls=require(PlayerModule:FindFirstChild("ControlModule"))
                        Controls:Enable()
                    end
                end)
                if root then
                    root.AssemblyLinearVelocity=Vector3.new(0,0,0)
                    root.AssemblyAngularVelocity=Vector3.new(0,0,0)
                end
            end
        end
        for _,obj in ipairs(char:GetDescendants())do
            if obj:IsA("Motor6D")and not obj.Enabled then
                obj.Enabled=true
            end
        end
    end)
    addConnection(_arV2Conn)
end
function stopAntiRagdollV2()
    if _arV2Conn then
        _arV2Conn:Disconnect()
        _arV2Conn=nil
    end
    _arV2Enabled=false
end
function toggleAntiRagdoll(state)
    _arV2Enabled=state
    CONFIG.ANTIRAGDOLL_ENABLED=state
    if state then
        startAntiRagdollV2()
    else
        stopAntiRagdollV2()
    end
end

function ensureToastGui()
    if _toastGui and _toastGui.Parent then return end
    _toastGui=Instance.new("ScreenGui")
    _toastGui.AutoLocalize=false
    _toastGui.Name="Looprix_Toasts"
    _toastGui.ResetOnSpawn=false
    _toastGui.DisplayOrder=9999999
    _toastGui.IgnoreGuiInset=true
    pcall(function()
        if gethui then _toastGui.Parent=gethui()
        elseif syn and syn.protect_gui then syn.protect_gui(_toastGui);_toastGui.Parent=LP.PlayerGui
        else _toastGui.Parent=LP.PlayerGui end
    end)
    if not _toastGui.Parent then _toastGui.Parent=LP.PlayerGui end
    _toastContainer=Instance.new("Frame",_toastGui)
    _toastContainer.Name="ToastContainer"
    _toastContainer.Size=UDim2.new(0,180,1,-8)
    _toastContainer.Position=UDim2.new(1,-188,0,8)
    _toastContainer.BackgroundTransparency=1
    _toastContainer.BorderSizePixel=0
    local layout=Instance.new("UIListLayout",_toastContainer)
    layout.FillDirection=Enum.FillDirection.Vertical
    layout.VerticalAlignment=Enum.VerticalAlignment.Bottom
    layout.HorizontalAlignment=Enum.HorizontalAlignment.Right
    layout.SortOrder=Enum.SortOrder.LayoutOrder
    layout.Padding=UDim.new(0,5)
end
function showNotification(featureName,isOn)
    if not CONFIG.NOTIFICATIONS_ENABLED then return end
    task.spawn(function()
        ensureToastGui()
        _toastCount=_toastCount+1
        local order=_toastCount
        local toast=Instance.new("Frame",_toastContainer)
        toast.Name="Toast_"..order
        toast.Size=UDim2.new(1,0,0,38)
        toast.BackgroundColor3=COLORS.Background
        toast.BackgroundTransparency=0.05
        toast.BorderSizePixel=0
        toast.LayoutOrder=order
        toast.ClipsDescendants=true
        Instance.new("UICorner",toast).CornerRadius=UDim.new(0,8)
        local tStroke=Instance.new("UIStroke",toast)
        tStroke.Thickness=1.2
        tStroke.Color=COLORS.Accent
        tStroke.Transparency=0.15
        tStroke.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
        trackStroke(tStroke)
        local accentBar=Instance.new("Frame",toast)
        accentBar.Size=UDim2.new(0,3,1,0)
        accentBar.Position=UDim2.new(0,0,0,0)
        accentBar.BackgroundColor3=isOn and COLORS.Accent or COLORS.Red
        accentBar.BorderSizePixel=0
        if isOn then trackFrame(accentBar)end
        local nameLabel=Instance.new("TextLabel",toast)
        nameLabel.AutoLocalize=false
        nameLabel.Size=UDim2.new(1,-52,0.55,0)
        nameLabel.Position=UDim2.new(0,12,0,3)
        nameLabel.BackgroundTransparency=1
        nameLabel.Text=featureName
        nameLabel.TextColor3=COLORS.Accent
        trackLabel(nameLabel)
        nameLabel.TextSize=11
        nameLabel.Font=Enum.Font.GothamSemibold
        nameLabel.TextXAlignment=Enum.TextXAlignment.Left
        nameLabel.TextTruncate=Enum.TextTruncate.AtEnd
        local subLabel=Instance.new("TextLabel",toast)
        subLabel.AutoLocalize=false
        subLabel.Size=UDim2.new(1,-52,0.4,0)
        subLabel.Position=UDim2.new(0,12,0.58,0)
        subLabel.BackgroundTransparency=1
        subLabel.Text=isOn and"Enabled"or"Disabled"
        subLabel.TextColor3=isOn and COLORS.Accent or COLORS.TextDim
        subLabel.TextSize=10
        subLabel.Font=Enum.Font.Gotham
        subLabel.TextXAlignment=Enum.TextXAlignment.Left
        if isOn then trackLabel(subLabel)end
        local badge=Instance.new("TextLabel",toast)
        badge.AutoLocalize=false
        badge.Size=UDim2.new(0,34,0,18)
        badge.AnchorPoint=Vector2.new(1,0.5)
        badge.Position=UDim2.new(1,-7,0.5,0)
        badge.BackgroundColor3=isOn and COLORS.Accent or Color3.fromRGB(50,20,20)
        badge.BackgroundTransparency=isOn and 0.05 or 0.3
        badge.BorderSizePixel=0
        badge.Text=isOn and"ON"or"OFF"
        badge.TextColor3=COLORS.Accent
        trackLabel(badge)
        badge.TextSize=10
        badge.Font=Enum.Font.GothamBold
        badge.TextXAlignment=Enum.TextXAlignment.Center
        Instance.new("UICorner",badge).CornerRadius=UDim.new(0,4)
        if isOn then trackFrame(badge)end
        toast.Position=UDim2.new(0,0,0,0)
        local slideIn=Instance.new("UIScale",toast)
        slideIn.Scale=0.85
        TweenService:Create(toast,TweenInfo.new(0.22,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
            {BackgroundTransparency=0.05}):Play()
        TweenService:Create(slideIn,TweenInfo.new(0.22,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
            {Scale=1}):Play()
        task.wait(2.8)
        TweenService:Create(toast,TweenInfo.new(0.28,Enum.EasingStyle.Quart,Enum.EasingDirection.In),
            {BackgroundTransparency=1}):Play()
        TweenService:Create(slideIn,TweenInfo.new(0.28,Enum.EasingStyle.Quart,Enum.EasingDirection.In),
            {Scale=0.8}):Play()
        TweenService:Create(tStroke,TweenInfo.new(0.28,Enum.EasingStyle.Quart,Enum.EasingDirection.In),
            {Transparency=1}):Play()
        task.wait(0.3)
        if toast and toast.Parent then toast:Destroy()end
    end)
end

function applyLooprixTextStyle(el)
    if not el then return end
    if el:IsA("TextLabel")or el:IsA("TextButton")or el:IsA("TextBox")then
        el.AutoLocalize=false
        el.TextStrokeColor3=COLORS.Background
        local size=el.TextSize
        if el.TextScaled then
            size=math.floor((el.AbsoluteSize.Y/24)*18)
        end
        if size<=14 then
            el.TextStrokeTransparency=0.5
        else
            el.TextStrokeTransparency=0.3
        end
    end
end
function createElement(className,properties)
    local el=Instance.new(className)
    if className=="ScreenGui"then
        el.AutoLocalize=false
    end
    for k,v in pairs(properties)do el[k]=v end
    applyLooprixTextStyle(el)
    return el
end
function tween(el,info,props)
    TweenService:Create(el,info,props):Play()
end
function setToggleVisual(btn,state)
    if not btn then return end
    btn.Text=state and"ON"or"OFF"
    tween(btn,tweenInfoFast,{BackgroundColor3=state and COLORS.Accent or COLORS.Background})
    if state then
        if not table.find(_accentFrames,btn)then table.insert(_accentFrames,btn)end
    else
        for i,f in ipairs(_accentFrames)do
            if f==btn then table.remove(_accentFrames,i);break end
        end
    end
end

function createKeybindButton(parent,text,currentKey,callback)
    local container=createElement("Frame",{
        Size=UDim2.new(1,0,0,50),
        BackgroundColor3=COLORS.Surface,
        BackgroundTransparency=COLORS.SurfaceTransparency,
        BorderSizePixel=0,
        Parent=parent,
    })
    createElement("UICorner",{CornerRadius=UDim.new(0,6),Parent=container})
    trackStroke(createElement("UIStroke",{Color=COLORS.Accent,Thickness=1,Transparency=0.5,ApplyStrokeMode=Enum.ApplyStrokeMode.Border,Parent=container}))
    local label=createElement("TextLabel",{
        Size=UDim2.new(0.6,-10,1,0),
        Position=UDim2.new(0,10,0,0),
        BackgroundTransparency=1,
        Text=text,
        TextColor3=COLORS.Accent,
        TextSize=14,
        Font=Enum.Font.GothamSemibold,
        TextXAlignment=Enum.TextXAlignment.Left,
        Parent=container,
    })
    trackLabel(label)
    local keyButton=createElement("TextButton",{
        Size=UDim2.new(0.35,-5,0.7,0),
        AnchorPoint=Vector2.new(1,0.5),
        Position=UDim2.new(1,-10,0.5,0),
        BackgroundColor3=COLORS.Background,
        BackgroundTransparency=0.2,
        Text=_getBindDisplayText(currentKey),
        TextColor3=COLORS.Accent,
        TextSize=12,
        Font=Enum.Font.GothamBold,
        BorderSizePixel=0,
        Parent=container,
    })
    trackLabel(keyButton)
    createElement("UICorner",{CornerRadius=UDim.new(0,4),Parent=keyButton})
    trackStroke(createElement("UIStroke",{Color=COLORS.Accent,Thickness=1,Transparency=0.3,Parent=keyButton}))
    trackLabel(keyButton)
    local isListening=false
    keyButton.MouseButton1Click:Connect(function()
        if isListening then return end
        isListening=true
        keyButton.Text="..."
        keyButton.TextColor3=COLORS.Yellow
        local conn
        conn=UIS.InputBegan:Connect(function(input)
            local isKB=input.UserInputType==Enum.UserInputType.Keyboard
            local isGP=input.UserInputType==Enum.UserInputType.Gamepad1
                or input.UserInputType==Enum.UserInputType.Gamepad2
                or input.UserInputType==Enum.UserInputType.Gamepad3
                or input.UserInputType==Enum.UserInputType.Gamepad4
            if isKB or isGP then
                local newKey=input.KeyCode
                if newKey==Enum.KeyCode.Unknown then return end
                local bindType=isKB and"Keyboard"or"Gamepad"
                local newBind={Type=bindType,Key=newKey}
                local dispText=(bindType=="Gamepad")and("GP:"..newKey.Name)or newKey.Name
                keyButton.Text=dispText
                keyButton.TextColor3=COLORS.Accent
                trackLabel(keyButton)
                callback(newBind)
                saveConfig()
                isListening=false
                conn:Disconnect()
            end
        end)
    end)
    return container
end
function createToggle(parent,text,defaultValue,callback)
    local container=createElement("Frame",{
        Size=UDim2.new(1,0,0,42),
        BackgroundColor3=COLORS.Surface,
        BackgroundTransparency=COLORS.SurfaceTransparency,
        BorderSizePixel=0,
        Parent=parent,
    })
    createElement("UICorner",{CornerRadius=UDim.new(0,6),Parent=container})
    trackStroke(createElement("UIStroke",{Color=COLORS.Accent,Thickness=1,Transparency=0.5,ApplyStrokeMode=Enum.ApplyStrokeMode.Border,Parent=container}))
    local label=createElement("TextLabel",{
        Size=UDim2.new(1,-78,1,0),
        Position=UDim2.new(0,10,0,0),
        BackgroundTransparency=1,
        Text=text,
        TextColor3=COLORS.Accent,
        TextSize=13,
        Font=Enum.Font.GothamSemibold,
        TextXAlignment=Enum.TextXAlignment.Left,
        Parent=container,
    })
    trackLabel(label)
    local toggleButton=createElement("TextButton",{
        Size=UDim2.new(0,52,0,24),
        AnchorPoint=Vector2.new(1,0.5),
        Position=UDim2.new(1,-8,0.5,0),
        BackgroundColor3=defaultValue and COLORS.Accent or COLORS.Background,
        BackgroundTransparency=0.2,
        Text=defaultValue and"ON"or"OFF",
        TextColor3=COLORS.Accent,
        TextScaled=false,
        TextSize=12,
        Font=Enum.Font.GothamBold,
        BorderSizePixel=0,
        AutoLocalize=false,
        ClipsDescendants=true,
        Parent=container,
    })
    trackLabel(toggleButton)
    createElement("UICorner",{CornerRadius=UDim.new(0,4),Parent=toggleButton})
    trackStroke(createElement("UIStroke",{Color=COLORS.Accent,Thickness=1,Transparency=0.3,Parent=toggleButton}))
    trackLabel(toggleButton)
    if defaultValue then table.insert(_accentFrames,toggleButton)end
    local state=defaultValue
    toggleButton.MouseButton1Click:Connect(function()
        state=not state
        toggleButton.Text=state and"ON"or"OFF"
        tween(toggleButton,tweenInfoFast,{BackgroundColor3=state and COLORS.Accent or COLORS.Background})
        if state then
            if not table.find(_accentFrames,toggleButton)then
                table.insert(_accentFrames,toggleButton)
            end
        else
            for i,f in ipairs(_accentFrames)do
                if f==toggleButton then table.remove(_accentFrames,i)break end
            end
        end
        showNotification(text,state)
        callback(state)
    end)
    return container,toggleButton
end
function createTextInput(parent,text,defaultValue,minVal,maxVal,callback)
    local container=createElement("Frame",{
        Size=UDim2.new(1,0,0,50),
        BackgroundColor3=COLORS.Surface,
        BackgroundTransparency=COLORS.SurfaceTransparency,
        BorderSizePixel=0,
        Parent=parent,
    })
    createElement("UICorner",{CornerRadius=UDim.new(0,6),Parent=container})
    createElement("UIStroke",{Color=COLORS.Accent,Thickness=1,Transparency=0.5,ApplyStrokeMode=Enum.ApplyStrokeMode.Border,Parent=container})
    local label=createElement("TextLabel",{
        Size=UDim2.new(0.6,-10,1,0),
        Position=UDim2.new(0,10,0,0),
        BackgroundTransparency=1,
        Text=text,
        TextColor3=COLORS.Accent,
        TextSize=14,
        Font=Enum.Font.GothamSemibold,
        TextXAlignment=Enum.TextXAlignment.Left,
        Parent=container,
    })
    trackLabel(label)
    local input=createElement("TextBox",{
        Size=UDim2.new(0.25,0,0.6,0),
        Position=UDim2.new(1,-10,0.5,0),
        AnchorPoint=Vector2.new(1,0.5),
        BackgroundColor3=COLORS.Background,
        BackgroundTransparency=0.2,
        Text=tostring(defaultValue),
        TextColor3=COLORS.Accent,
        TextSize=12,
        Font=Enum.Font.GothamBold,
        BorderSizePixel=0,
        Parent=container,
    })
    trackLabel(input)
    createElement("UICorner",{CornerRadius=UDim.new(0,4),Parent=input})
    createElement("UIStroke",{Color=COLORS.Accent,Thickness=1,Transparency=0.3,Parent=input})
    trackLabel(input)
    input.FocusLost:Connect(function()
        local num=tonumber(input.Text)
        if num then
            num=math.clamp(num,minVal or 1,maxVal or 100)
            callback(num)
            input.Text=tostring(num)
        else
            input.Text=tostring(defaultValue)
        end
    end)
    return container
end
function createSlider(parent,labelText,defaultValue,minVal,maxVal,callback)
    minVal=minVal or 0
    maxVal=maxVal or 100
    local current=math.clamp(defaultValue,minVal,maxVal)
    local container=createElement("Frame",{
        Size=UDim2.new(1,0,0,44),
        BackgroundColor3=COLORS.Surface,
        BackgroundTransparency=COLORS.SurfaceTransparency,
        BorderSizePixel=0,
        Parent=parent,
    })
    createElement("UICorner",{CornerRadius=UDim.new(0,6),Parent=container})
    local cStroke=createElement("UIStroke",{Color=COLORS.Accent,Thickness=1,Transparency=0.5,
        ApplyStrokeMode=Enum.ApplyStrokeMode.Border,Parent=container})
    trackStroke(cStroke)
    local lbl=createElement("TextLabel",{
        Size=UDim2.new(0.55,0,0,18),
        Position=UDim2.new(0,8,0,4),
        BackgroundTransparency=1,
        Text=labelText.." ["..tostring(current).."]",
        TextColor3=COLORS.Accent,
        TextSize=12,
        Font=Enum.Font.GothamSemibold,
        TextXAlignment=Enum.TextXAlignment.Left,
        Parent=container,
    })
    trackLabel(lbl)
    local track=createElement("Frame",{
        Size=UDim2.new(1,-16,0,8),
        Position=UDim2.new(0,8,1,-14),
        BackgroundColor3=COLORS.Background,
        BackgroundTransparency=0.3,
        BorderSizePixel=0,
        Parent=container,
    })
    createElement("UICorner",{CornerRadius=UDim.new(1,0),Parent=track})
    local fraction=(current-minVal)/(maxVal-minVal)
    local fill=createElement("Frame",{
        Size=UDim2.new(fraction,0,1,0),
        BackgroundColor3=COLORS.Accent,
        BorderSizePixel=0,
        Parent=track,
    })
    createElement("UICorner",{CornerRadius=UDim.new(1,0),Parent=fill})
    trackFrame(fill)
    local thumb=createElement("Frame",{
        Size=UDim2.new(0,12,0,12),
        AnchorPoint=Vector2.new(0.5,0.5),
        Position=UDim2.new(fraction,0,0.5,0),
        BackgroundColor3=COLORS.Accent,
        BorderSizePixel=0,
        ZIndex=5,
        Parent=track,
    })
    createElement("UICorner",{CornerRadius=UDim.new(1,0),Parent=thumb})
    trackFrame(thumb)
    local isDragging=false
    local function updateFromPos(absX)
        local trackAbs=track.AbsolutePosition.X
        local trackW=track.AbsoluteSize.X
        local frac=math.clamp((absX-trackAbs)/trackW,0,1)
        current=math.round(minVal+frac*(maxVal-minVal))
        fill.Size=UDim2.new(frac,0,1,0)
        thumb.Position=UDim2.new(frac,0,0.5,0)
        lbl.Text=labelText.." ["..tostring(current).."]"
        callback(current)
    end
    local hitZone=Instance.new("Frame")
    hitZone.Size=UDim2.new(1,-16,0,28)
    hitZone.Position=UDim2.new(0,8,1,-26)
    hitZone.BackgroundTransparency=1
    hitZone.BorderSizePixel=0
    hitZone.ZIndex=10
    hitZone.Parent=container
    hitZone.InputBegan:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.MouseButton1 or
           input.UserInputType==Enum.UserInputType.Touch then
            isDragging=true
            updateFromPos(input.Position.X)
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if not isDragging then return end
        if input.UserInputType==Enum.UserInputType.MouseMovement or
           input.UserInputType==Enum.UserInputType.Touch then
            updateFromPos(input.Position.X)
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.MouseButton1 or
           input.UserInputType==Enum.UserInputType.Touch then
            if isDragging then
                isDragging=false
                saveConfig()
            end
        end
    end)
    return container
end
function createNumberInput(parent,labelText,defaultValue,minVal,maxVal,callback,allowFloat)
    minVal=minVal or 0
    maxVal=maxVal or 9999
    local current=math.clamp(defaultValue,minVal,maxVal)
    local container=createElement("Frame",{
        Size=UDim2.new(1,0,0,44),
        BackgroundColor3=COLORS.Surface,
        BackgroundTransparency=COLORS.SurfaceTransparency,
        BorderSizePixel=0,
        Parent=parent,
    })
    createElement("UICorner",{CornerRadius=UDim.new(0,6),Parent=container})
    local cStroke=createElement("UIStroke",{Color=COLORS.Accent,Thickness=1,Transparency=0.5,
        ApplyStrokeMode=Enum.ApplyStrokeMode.Border,Parent=container})
    trackStroke(cStroke)
    local lbl=createElement("TextLabel",{
        Size=UDim2.new(0.58,-6,1,0),
        Position=UDim2.new(0,8,0,0),
        BackgroundTransparency=1,
        Text=labelText,
        TextColor3=COLORS.Accent,
        TextSize=12,
        Font=Enum.Font.GothamSemibold,
        TextXAlignment=Enum.TextXAlignment.Left,
        Parent=container,
    })
    trackLabel(lbl)
    local inputBox=createElement("TextBox",{
        Size=UDim2.new(0.38,0,0,26),
        Position=UDim2.new(0.60,0,0.5,-13),
        BackgroundColor3=COLORS.Background,
        BackgroundTransparency=0.3,
        Text=tostring(current),
        TextColor3=COLORS.Accent,
        TextSize=13,
        Font=Enum.Font.GothamBold,
        BorderSizePixel=0,
        ClearTextOnFocus=true,
        PlaceholderText=tostring(current),
        PlaceholderColor3=COLORS.TextDim,
        Parent=container,
    })
    createElement("UICorner",{CornerRadius=UDim.new(0,5),Parent=inputBox})
    trackStroke(createElement("UIStroke",{Color=COLORS.Accent,Thickness=1,Transparency=0.4,Parent=inputBox}))
    trackLabel(inputBox)
    local function applyValue(raw)
        local num=tonumber(raw)
        if not num then
            inputBox.Text=tostring(current)
            return
        end
        current=allowFloat and math.clamp(num,minVal,maxVal)or math.clamp(math.round(num),minVal,maxVal)
        inputBox.Text=tostring(current)
        callback(current)
        saveConfig()
    end
    inputBox.FocusLost:Connect(function(enterPressed)
        applyValue(inputBox.Text)
    end)
    inputBox:GetPropertyChangedSignal("Text"):Connect(function()
        local num=tonumber(inputBox.Text)
        if num then
            local clamped=allowFloat and math.clamp(num,minVal,maxVal)or math.clamp(math.round(num),minVal,maxVal)
            if clamped~=current then
                current=clamped
                callback(current)
            end
        end
    end)
    return container
end
function createCategory(parent,title,defaultOpen)
    defaultOpen=(defaultOpen~=false)
    local wrapper=createElement("Frame",{
        Size=UDim2.new(1,0,0,0),
        BackgroundTransparency=1,
        BorderSizePixel=0,
        ClipsDescendants=false,
        AutomaticSize=Enum.AutomaticSize.Y,
        Parent=parent,
    })
    local wLayout=Instance.new("UIListLayout")
    wLayout.FillDirection=Enum.FillDirection.Vertical
    wLayout.HorizontalAlignment=Enum.HorizontalAlignment.Left
    wLayout.VerticalAlignment=Enum.VerticalAlignment.Top
    wLayout.Padding=UDim.new(0,4)
    wLayout.SortOrder=Enum.SortOrder.LayoutOrder
    wLayout.Parent=wrapper
    local header=createElement("TextButton",{
        Size=UDim2.new(1,0,0,32),
        BackgroundColor3=COLORS.Surface,
        BackgroundTransparency=0.05,
        BorderSizePixel=0,
        Text="",
        AutoButtonColor=false,
        LayoutOrder=1,
        Parent=wrapper,
    })
    createElement("UICorner",{CornerRadius=UDim.new(0,7),Parent=header})
    local hStroke=createElement("UIStroke",{Color=COLORS.Accent,Thickness=1.2,Transparency=0.3,
        ApplyStrokeMode=Enum.ApplyStrokeMode.Border,Parent=header})
    trackStroke(hStroke)
    local titleLbl=createElement("TextLabel",{
        Size=UDim2.new(1,-40,1,0),
        Position=UDim2.new(0,10,0,0),
        BackgroundTransparency=1,
        Text=title,
        TextColor3=COLORS.Accent,
        TextSize=13,
        Font=Enum.Font.GothamBold,
        TextXAlignment=Enum.TextXAlignment.Left,
        Parent=header,
    })
    trackLabel(titleLbl)
    local arrowLbl=createElement("TextLabel",{
        Size=UDim2.new(0,24,0,24),
        Position=UDim2.new(1,-30,0.5,-12),
        BackgroundTransparency=1,
        Text="v",
        TextColor3=COLORS.Accent,
        TextSize=14,
        Font=Enum.Font.GothamBold,
        Rotation=defaultOpen and 0 or-90,
        Parent=header,
    })
    trackLabel(arrowLbl)
    local clipper=createElement("Frame",{
        Size=UDim2.new(1,0,0,0),
        BackgroundTransparency=1,
        BorderSizePixel=0,
        ClipsDescendants=true,
        AutomaticSize=defaultOpen and Enum.AutomaticSize.Y or Enum.AutomaticSize.None,
        Visible=defaultOpen,
        LayoutOrder=2,
        Parent=wrapper,
    })
    local content=createElement("Frame",{
        Size=UDim2.new(1,0,0,0),
        BackgroundTransparency=1,
        BorderSizePixel=0,
        ClipsDescendants=false,
        AutomaticSize=Enum.AutomaticSize.Y,
        Parent=clipper,
    })
    local contentPad=Instance.new("UIPadding")
    contentPad.PaddingBottom=UDim.new(0,6)
    contentPad.Parent=content
    local itemList=createElement("UIListLayout",{
        Padding=UDim.new(0,6),
        SortOrder=Enum.SortOrder.LayoutOrder,
        FillDirection=Enum.FillDirection.Vertical,
        HorizontalAlignment=Enum.HorizontalAlignment.Center,
        Parent=content,
    })
    local isOpen=defaultOpen
    local animating=false
    local catTween=TweenInfo.new(0.18,Enum.EasingStyle.Quart,Enum.EasingDirection.Out)
    local function setOpen(open)
        if animating then return end
        isOpen=open
        TweenService:Create(arrowLbl,catTween,{
            Rotation=open and 0 or-90
        }):Play()
        if open then
            clipper.AutomaticSize=Enum.AutomaticSize.None
            clipper.Size=UDim2.new(1,0,0,0)
            clipper.Visible=true
            animating=true
            task.defer(function()
                if not(content and content.Parent)then animating=false return end
                local targetH=math.max(content.AbsoluteSize.Y,8)
                local tw=TweenService:Create(clipper,catTween,{Size=UDim2.new(1,0,0,targetH)})
                tw.Completed:Connect(function()
                    clipper.AutomaticSize=Enum.AutomaticSize.Y
                    animating=false
                end)
                tw:Play()
            end)
        else
            clipper.AutomaticSize=Enum.AutomaticSize.None
            animating=true
            local tw=TweenService:Create(clipper,catTween,{Size=UDim2.new(1,0,0,0)})
            tw.Completed:Connect(function()
                clipper.Visible=false
                animating=false
            end)
            tw:Play()
        end
    end
    header.MouseButton1Click:Connect(function()
        setOpen(not isOpen)
    end)
    return content,wrapper
end
function createEmptyTab(parent,name)
    return createElement("Frame",{
        Name=name.."Tab",
        Size=UDim2.new(1,0,1,0),
        BackgroundTransparency=1,
        Visible=false,
        Parent=parent,
    })
end

local _dropConns={}
function runDropBrainrot()
    if dropBrainrotActive then return end
    dropBrainrotActive=true
    if dropBrainrotPanelBtn then dropBrainrotPanelBtn.Text="DROP: ON"end
    task.spawn(function()
        local colConn=RunService.Stepped:Connect(function()
            if not dropBrainrotActive then return end
            for _,p in ipairs(Players:GetPlayers())do
                if p~=LP and p.Character then
                    for _,part in ipairs(p.Character:GetChildren())do if part:IsA("BasePart")then part.CanCollide=false end end
                end
            end
        end)
        table.insert(_dropConns,colConn)
        task.spawn(function()
            while dropBrainrotActive do
                RunService.Heartbeat:Wait()
                local c=character
                local root=c and c:FindFirstChild("HumanoidRootPart")
                if root then
                local vel=root.Velocity
                root.Velocity=vel*10000+Vector3.new(0,10000,0)
                RunService.RenderStepped:Wait()
                if root and root.Parent then root.Velocity=vel end
                RunService.Stepped:Wait()
                if root and root.Parent then root.Velocity=vel+Vector3.new(0,0.1,0)end
                end
            end
        end)
        task.wait(DROP_ASCEND_DURATION)
        for _,cn in ipairs(_dropConns)do pcall(function()cn:Disconnect()end)end
        _dropConns={}
        dropBrainrotActive=false
        if dropBrainrotPanelBtn then dropBrainrotPanelBtn.Text="DROP BRAINROT"end
        if CONFIG.POST_DROP_HALT_ENABLED and _doPostDropHalt then
            task.spawn(_doPostDropHalt)
        end
        if CONFIG.SNAP_LOCK_ENABLED and _doSnapLock then
            task.spawn(_doSnapLock)
        end
    end)
end
function executeDrop()task.spawn(runDropBrainrot)end

function _saveOriginalAnims(char)
    local animate=char:FindFirstChild("Animate");if not animate then return end
    local function g(obj)return obj and obj.AnimationId or nil end
    _savedOrigAnims={
        idle1=g(animate.idle and animate.idle.Animation1),
        idle2=g(animate.idle and animate.idle.Animation2),
        walk=g(animate.walk and animate.walk.WalkAnim),
        run=g(animate.run and animate.run.RunAnim),
        jump=g(animate.jump and animate.jump.JumpAnim),
        fall=g(animate.fall and animate.fall.FallAnim),
        climb=g(animate.climb and animate.climb.ClimbAnim),
        swim=g(animate.swim and animate.swim.Swim),
        swimidle=g(animate.swimidle and animate.swimidle.SwimIdle),
    }
end
function _applyHarderHitAnimPack(char)
    local animate=char:FindFirstChild("Animate");if not animate then return end
    local function s(obj,id)if obj then obj.AnimationId=id end end
    s(animate.idle and animate.idle.Animation1,_harderHitAnims.idle1)
    s(animate.idle and animate.idle.Animation2,_harderHitAnims.idle2)
    s(animate.walk and animate.walk.WalkAnim,_harderHitAnims.walk)
    s(animate.run and animate.run.RunAnim,_harderHitAnims.run)
    s(animate.jump and animate.jump.JumpAnim,_harderHitAnims.jump)
    s(animate.fall and animate.fall.FallAnim,_harderHitAnims.fall)
    s(animate.climb and animate.climb.ClimbAnim,_harderHitAnims.climb)
    s(animate.swim and animate.swim.Swim,_harderHitAnims.swim)
    s(animate.swimidle and animate.swimidle.SwimIdle,_harderHitAnims.swimidle)
end
function startHarderHitAnim()
    if _animHeartbeatConn then _animHeartbeatConn:Disconnect();_animHeartbeatConn=nil end
    local char=LP.Character
    if char then
        _saveOriginalAnims(char)
        _applyHarderHitAnimPack(char)
        local hum2=char:FindFirstChildOfClass("Humanoid")
        if hum2 then for _,t in ipairs(hum2:GetPlayingAnimationTracks())do t:Stop(0)end end
    end
    _animHeartbeatConn=RunService.Heartbeat:Connect(function()
        if not CONFIG.HARDER_HIT_ENABLED then return end
        local c=LP.Character
        if c then _applyHarderHitAnimPack(c)end
    end)
end
function stopHarderHitAnim()
    if _animHeartbeatConn then _animHeartbeatConn:Disconnect();_animHeartbeatConn=nil end
    local char=LP.Character
    if not char then return end
    local animate=char:FindFirstChild("Animate");if not animate then return end
    if not _savedOrigAnims then return end
    local function s(obj,id)if obj and id then obj.AnimationId=id end end
    s(animate.idle and animate.idle.Animation1,_savedOrigAnims.idle1)
    s(animate.idle and animate.idle.Animation2,_savedOrigAnims.idle2)
    s(animate.walk and animate.walk.WalkAnim,_savedOrigAnims.walk)
    s(animate.run and animate.run.RunAnim,_savedOrigAnims.run)
    s(animate.jump and animate.jump.JumpAnim,_savedOrigAnims.jump)
    s(animate.fall and animate.fall.FallAnim,_savedOrigAnims.fall)
    s(animate.climb and animate.climb.ClimbAnim,_savedOrigAnims.climb)
    s(animate.swim and animate.swim.Swim,_savedOrigAnims.swim)
    s(animate.swimidle and animate.swimidle.SwimIdle,_savedOrigAnims.swimidle)
    local hum2=char:FindFirstChildOfClass("Humanoid")
    if hum2 then for _,t in ipairs(hum2:GetPlayingAnimationTracks())do t:Stop(0)end end
end

local function findActiveBat()
    local c=character
    if c then for _,v in ipairs(c:GetChildren())do if v:IsA("Tool")and v.Name:lower():find("bat")then return v end end end
    return nil
end
local SWING_COOLDOWN=0.08
local _batCooldown=false
local function tryHitBat()
    if _batCooldown then return end
    _batCooldown=true
    pcall(function()
        local tool=findActiveBat()
        if tool then
            local remote=tool:FindFirstChildOfClass("RemoteEvent")
            if remote then pcall(function()remote:FireServer()end)
            else pcall(function()tool:Activate()end)end
        end
    end)
    task.delay(SWING_COOLDOWN,function()_batCooldown=false end)
end
function autoAttack()
    _autoBatGen=_autoBatGen+1
    local gen=_autoBatGen
    task.spawn(function()
        while CONFIG.AUTO_BAT_ENABLED and _autoBatGen==gen do
            tryHitBat()
            task.wait(0.08)
        end
    end)
end

function startSpinBot()
    if spinbotConnection then return end
    local char=character
    if not char then return end
    local hrp=char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    if spinBAV then spinBAV:Destroy()spinBAV=nil end
    for _,v in pairs(hrp:GetChildren())do
        if v.Name=="SpinBAV"then v:Destroy()end
    end
    spinBAV=Instance.new("BodyAngularVelocity")
    spinBAV.Name="SpinBAV"
    spinBAV.MaxTorque=Vector3.new(0,math.huge,0)
    spinBAV.AngularVelocity=Vector3.new(0,CONFIG.SPINBOT_SPEED,0)
    spinBAV.Parent=hrp
    spinbotConnection=RunService.Heartbeat:Connect(function()
        if not CONFIG.SPINBOT_ENABLED or not spinBAV then return end
        if spinBAV and spinBAV.Parent then
            spinBAV.AngularVelocity=Vector3.new(0,CONFIG.SPINBOT_SPEED,0)
        end
    end)
    addConnection(spinbotConnection)
end
function stopSpinBot()
    if spinbotConnection then
        spinbotConnection:Disconnect()
        spinbotConnection=nil
    end
    if spinBAV then
        spinBAV:Destroy()
        spinBAV=nil
    end
    local char=character
    if char then
        local hrp=char:FindFirstChild("HumanoidRootPart")
        if hrp then
            for _,v in pairs(hrp:GetChildren())do
                if v.Name=="SpinBAV"then v:Destroy()end
            end
        end
    end
end

function startUnwalk()
    local c=character
    if not c then return end
    local anim=c:FindFirstChild("Animate")
    if not anim then
        task.spawn(function()
            anim=c:WaitForChild("Animate",5)
            if not anim or not CONFIG.UNWALK_ENABLED then return end
            local hum=c:FindFirstChildOfClass("Humanoid")
            if hum then
                for _,t in ipairs(hum:GetPlayingAnimationTracks())do t:Stop()end
            end
            savedAnimations.Animate=anim:Clone()
            anim:Destroy()
        end)
        return
    end
    local hum=c:FindFirstChildOfClass("Humanoid")
    if hum then
        for _,t in ipairs(hum:GetPlayingAnimationTracks())do
            t:Stop()
        end
    end
    savedAnimations.Animate=anim:Clone()
    anim:Destroy()
end
function stopUnwalk()
    local c=LP.Character or character
    if c and savedAnimations.Animate then
        savedAnimations.Animate:Clone().Parent=c
        savedAnimations.Animate=nil
    end
end

function espGetAccentColor()
    return Color3.fromRGB(CONFIG.GUI_COLOR_R or 0,CONFIG.GUI_COLOR_G or 217,CONFIG.GUI_COLOR_B or 127)
end
function espClearPlayer(player)
    local data=espCache[player]
    if not data then return end
    pcall(function()
        if data.highlight and data.highlight.Parent then data.highlight:Destroy()end
        if data.hitbox and data.hitbox.Parent then data.hitbox:Destroy()end
        if data.beam and data.beam.Parent then data.beam:Destroy()end
        if data.beamAtt0 and data.beamAtt0.Parent then data.beamAtt0:Destroy()end
        if data.beamAtt1 and data.beamAtt1.Parent then data.beamAtt1:Destroy()end
        if data.charConn then data.charConn:Disconnect()end
    end)
    for _,tbl in ipairs({_espHighlights,_espBeams,_espHitboxes})do
        for i=#tbl,1,-1 do
            if tbl[i]==data.highlight or tbl[i]==data.hitbox or tbl[i]==data.beam then
                table.remove(tbl,i)
            end
        end
    end
    espCache[player]=nil
end
function espSetupChar(player,char)
    espClearPlayer(player)
    local hrp=char:WaitForChild("HumanoidRootPart",5)
    if not hrp then return end
    local accent=espGetAccentColor()
    local hl=Instance.new("Highlight")
    hl.Name=ESP_NAME
    hl.Adornee=char
    hl.FillColor=accent
    hl.FillTransparency=0.82
    hl.OutlineColor=accent
    hl.OutlineTransparency=0
    hl.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent=char
    table.insert(_espHighlights,hl)
    local hitbox=Instance.new("BoxHandleAdornment")
    hitbox.Name="LooprixHitbox"
    hitbox.Adornee=hrp
    hitbox.Size=Vector3.new(4,6,2)
    hitbox.Color3=accent
    hitbox.Transparency=0.6
    hitbox.ZIndex=10
    hitbox.AlwaysOnTop=true
    hitbox.Parent=char
    table.insert(_espHitboxes,hitbox)
    local myChar=LP.Character
    local myHRP=myChar and myChar:FindFirstChild("HumanoidRootPart")
    local att0,att1
    if myHRP then
        att0=Instance.new("Attachment",myHRP)
        att0.Name=ESP_BEAM_NAME.."_att0_"..player.UserId
    end
    att1=Instance.new("Attachment",hrp)
    att1.Name=ESP_BEAM_NAME.."_att1"
    local beam=Instance.new("Beam")
    beam.Name=ESP_BEAM_NAME
    beam.Attachment0=att0 or att1
    beam.Attachment1=att1
    beam.Color=ColorSequence.new(accent)
    beam.Transparency=NumberSequence.new(0.25)
    beam.Width0=0.18
    beam.Width1=0.18
    beam.FaceCamera=true
    beam.Segments=1
    beam.Parent=hrp
    table.insert(_espBeams,beam)
    local charConn=player.CharacterRemoving:Connect(function()
        espClearPlayer(player)
    end)
    espCache[player]={
        highlight=hl,
        hitbox=hitbox,
        beam=beam,
        beamAtt0=att0,
        beamAtt1=att1,
        hrp=hrp,
        charConn=charConn,
    }
end
function createESPForPlayer(player)
    if player==LP then return end
    if player.Character then
        task.spawn(espSetupChar,player,player.Character)
    end
    player.CharacterAdded:Connect(function(char)
        task.wait(0.1)
        if CONFIG.ESP_ENABLED then
            espSetupChar(player,char)
        end
    end)
end
function startESP()
    if espConnection then return end
    for _,p in ipairs(Players:GetPlayers())do
        createESPForPlayer(p)
    end
    Players.PlayerAdded:Connect(createESPForPlayer)
    espConnection=RunService.RenderStepped:Connect(function()
        if not CONFIG.ESP_ENABLED then return end
        local myChar=LP.Character
        local myHRP=myChar and myChar:FindFirstChild("HumanoidRootPart")
        for player,data in pairs(espCache)do
            if data.beam and data.beam.Parent then
                if myHRP and data.beamAtt0 then
                    if data.beamAtt0.Parent~=myHRP then
                        data.beamAtt0.Parent=myHRP
                    end
                    data.beam.Attachment0=data.beamAtt0
                end
            end
        end
    end)
    addConnection(espConnection)
end
function stopESP()
    if espConnection then
        espConnection:Disconnect()
        espConnection=nil
    end
    for player,_ in pairs(espCache)do
        espClearPlayer(player)
    end
    espCache={}
end
function updateEspAccentColor(r,g,b)
    local c=Color3.fromRGB(r,g,b)
    for _,hl in ipairs(_espHighlights)do
        pcall(function()
            if hl and hl.Parent then
                hl.OutlineColor=c
                hl.FillColor=c
            end
        end)
    end
    for _,bm in ipairs(_espBeams)do
        pcall(function()if bm and bm.Parent then bm.Color=ColorSequence.new(c)end end)
    end
    for _,hb in ipairs(_espHitboxes)do
        pcall(function()if hb and hb.Parent then hb.Color3=c end end)
    end
end

function awGetTarget(key)
    local b=AW.BASE[AW.activeSide][key]
    return b
end
function awSetBtnActive(side,active)
    local btn=(side=="L")and awWalkBtnL or awWalkBtnR
    if not btn then return end
    TweenService:Create(btn,tweenInfoFast,{
        BackgroundColor3=active and COLORS.Accent or COLORS.Surface,
        BackgroundTransparency=active and 0.0 or COLORS.SurfaceTransparency,
    }):Play()
    btn.TextColor3=active and Color3.fromRGB(10,10,10)or COLORS.TextDim
end
function awStopLoop()
    local prevSide=AW.activeSide
    AW.enabled=false
    if AW.loopConn then AW.loopConn:Disconnect();AW.loopConn=nil end
    AW.currentStep=1
    if prevSide then awSetBtnActive(prevSide,false)end
end
function awStartLoop()
    if AW.loopConn then AW.loopConn:Disconnect()end
    AW.currentStep=1
    AW.loopConn=RunService.Heartbeat:Connect(function()
        if not AW.enabled then return end
        local char=character
        local hrp=char and char:FindFirstChild("HumanoidRootPart")
        local hum=char and char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum then return end
        local key=AW.WALK_SEQ[AW.currentStep]
        local target=awGetTarget(key)
        local flat=Vector3.new(target.X,hrp.Position.Y,target.Z)
        local dist=(flat-hrp.Position).Magnitude
        local spd=CONFIG.SPEED_VALUE or 60
        if dist>2.0 then
            local dir=(flat-hrp.Position).Unit
            hum:Move(dir,false)
            hrp.Velocity=Vector3.new(dir.X*spd,hrp.Velocity.Y,dir.Z*spd)
        else
            if AW.currentStep>=#AW.WALK_SEQ then
                hum:Move(Vector3.zero,false)
                hrp.Velocity=Vector3.new(0,hrp.Velocity.Y,0)
                awStopLoop()
            else
                AW.currentStep=AW.currentStep+1
            end
        end
    end)
    addConnection(AW.loopConn)
end
function awLaunch(side)
    if not side then return end
    if AW.enabled then
        awStopLoop()
        return
    end
    local detectedSide=_detectSideNow()
    if not detectedSide then return end
    AW.activeSide=detectedSide
    AW.enabled=true
    awSetBtnActive(detectedSide,true)
    awStartLoop()
end

function createAutoWalkGui()
    local W=140
    local HDR_H=22
    local BTN_H=26
    local GAP=5
    local PAD=5
    local FULL_H=HDR_H+PAD+BTN_H+PAD
    local sg=Instance.new("ScreenGui",LP.PlayerGui)
    sg.AutoLocalize=false
    sg.Name="Looprix_AutoWalkGui"
    sg.ResetOnSpawn=false
    sg.DisplayOrder=999998
    sg.Enabled=CONFIG.AUTO_WALK_PANEL_VISIBLE
    local function makeAS(parent,thick,initT)
        local s=Instance.new("UIStroke",parent)
        s.Thickness=thick or 1.2;s.Color=COLORS.Accent
        s.Transparency=initT or 0;s.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
        trackStroke(s)
        local g=Instance.new("UIGradient",s)
        g.Color=ColorSequence.new({
            ColorSequenceKeypoint.new(0,COLORS.Accent),
            ColorSequenceKeypoint.new(0.33,Color3.fromRGB(120,255,200)),
            ColorSequenceKeypoint.new(0.66,Color3.fromRGB(150,255,180)),
            ColorSequenceKeypoint.new(1,COLORS.Accent),
        })
        trackGradient(g)
        return s
    end
    local main=Instance.new("Frame",sg)
    main.Size=UDim2.new(0,W,0,FULL_H)
    main.BackgroundColor3=COLORS.Background
    main.BackgroundTransparency=0.08
    main.BorderSizePixel=0
    main.ClipsDescendants=true
    Instance.new("UICorner",main).CornerRadius=UDim.new(0,10)
    registerScaleTarget(main)
    makeAS(main,1.2,0)
    local savedAW=CONFIG._guiPositions and CONFIG._guiPositions.autoWalkPanel
    if savedAW then
        main.Position=UDim2.new(savedAW.scaleX,savedAW.offsetX,savedAW.scaleY,savedAW.offsetY)
    else
        main.Position=UDim2.new(0,10,0,220)
    end
    _regDraggable(main,function()return UDim2.new(0,10,0,220)end)
    local hdr=Instance.new("Frame",main)
    hdr.Size=UDim2.new(1,0,0,HDR_H)
    hdr.BackgroundColor3=COLORS.Surface;hdr.BackgroundTransparency=0.05;hdr.BorderSizePixel=0
    Instance.new("UICorner",hdr).CornerRadius=UDim.new(0,10)
    local hdrFill=Instance.new("Frame",hdr)
    hdrFill.Size=UDim2.new(1,0,0,8);hdrFill.Position=UDim2.new(0,0,1,-8)
    hdrFill.BackgroundColor3=COLORS.Surface;hdrFill.BackgroundTransparency=0.05;hdrFill.BorderSizePixel=0
    local dot=Instance.new("Frame",hdr)
    dot.Size=UDim2.new(0,6,0,6);dot.Position=UDim2.new(0,9,0.5,-3)
    dot.BackgroundColor3=COLORS.Accent;dot.BorderSizePixel=0
    Instance.new("UICorner",dot).CornerRadius=UDim.new(1,0)
    trackDot(dot)
    local titleLbl=Instance.new("TextLabel",hdr)
    titleLbl.AutoLocalize=false
    titleLbl.Size=UDim2.new(1,-34,1,0);titleLbl.Position=UDim2.new(0,20,0,0)
    titleLbl.BackgroundTransparency=1;titleLbl.Text="Auto Walk"
    titleLbl.TextColor3=COLORS.Accent;titleLbl.Font=Enum.Font.GothamSemibold
    trackLabel(titleLbl)
    titleLbl.TextSize=11;titleLbl.TextXAlignment=Enum.TextXAlignment.Left
    local tg=Instance.new("UIGradient",titleLbl)
    tg.Color=ColorSequence.new({
        ColorSequenceKeypoint.new(0,COLORS.Accent),
        ColorSequenceKeypoint.new(0.33,Color3.fromRGB(120,255,200)),
        ColorSequenceKeypoint.new(0.66,Color3.fromRGB(150,255,180)),
        ColorSequenceKeypoint.new(1,COLORS.Accent)})
    trackGradient(tg)
    local minBtn=Instance.new("TextButton",hdr)
    minBtn.AutoLocalize=false
    minBtn.Size=UDim2.new(0,20,0,18);minBtn.Position=UDim2.new(1,-24,0.5,-9)
    minBtn.BackgroundColor3=COLORS.Background;minBtn.BackgroundTransparency=0.2
    minBtn.Text="-";minBtn.TextColor3=COLORS.Accent
    minBtn.Font=Enum.Font.GothamBold;minBtn.TextSize=14;minBtn.BorderSizePixel=0
    Instance.new("UICorner",minBtn).CornerRadius=UDim.new(0,4)
    makeAS(minBtn,1,0.4);trackLabel(minBtn)
    local content=Instance.new("Frame",main)
    content.Size=UDim2.new(1,0,1,-HDR_H);content.Position=UDim2.new(0,0,0,HDR_H)
    content.BackgroundTransparency=1;content.BorderSizePixel=0
    local btnLayout=Instance.new("UIListLayout",content)
    btnLayout.FillDirection=Enum.FillDirection.Horizontal
    btnLayout.HorizontalAlignment=Enum.HorizontalAlignment.Center
    btnLayout.VerticalAlignment=Enum.VerticalAlignment.Center
    btnLayout.Padding=UDim.new(0,GAP)
    local cPad=Instance.new("UIPadding",content)
    cPad.PaddingLeft=UDim.new(0,PAD);cPad.PaddingRight=UDim.new(0,PAD)
    cPad.PaddingTop=UDim.new(0,PAD);cPad.PaddingBottom=UDim.new(0,PAD)
    local FULL_W_AW=W-PAD*2
    local awMainBtn=Instance.new("TextButton",content)
    awMainBtn.AutoLocalize=false
    awMainBtn.LayoutOrder=1
    awMainBtn.Size=UDim2.new(0,FULL_W_AW,0,BTN_H)
    awMainBtn.BackgroundColor3=COLORS.Surface
    awMainBtn.BackgroundTransparency=COLORS.SurfaceTransparency
    awMainBtn.Text="Auto Walk"
    awMainBtn.TextColor3=COLORS.Accent
    trackLabel(awMainBtn)
    awMainBtn.Font=Enum.Font.GothamBold;awMainBtn.TextSize=12;awMainBtn.BorderSizePixel=0
    Instance.new("UICorner",awMainBtn).CornerRadius=UDim.new(0,7)
    makeAS(awMainBtn,1,0.45)
    awMainBtn.MouseButton1Click:Connect(function()
        awLaunch("auto")
    end)
    awWalkBtnL=awMainBtn
    awWalkBtnR=awMainBtn
    local awMin=false
    minBtn.MouseButton1Click:Connect(function()
        awMin=not awMin
        if awMin then
            hdrFill.Visible=false;content.Visible=false
            TweenService:Create(main,tweenInfoMedium,{Size=UDim2.new(0,W,0,HDR_H)}):Play()
            minBtn.Text="+"
        else
            hdrFill.Visible=true;content.Visible=true
            TweenService:Create(main,tweenInfoMedium,{Size=UDim2.new(0,W,0,FULL_H)}):Play()
            minBtn.Text="-"
        end
    end)
    makeDraggable(main,hdr,"autoWalkPanel",function()return CONFIG.UI_LOCKED end)
    awGuiInstance=sg
    pcall(function()
        applyAccentColor(CONFIG.GUI_COLOR_R or 0,CONFIG.GUI_COLOR_G or 217,CONFIG.GUI_COLOR_B or 127)
    end)
    return sg
end

function canRunAutoPlay()
    if not _getMyPlot()then return false,"no_plot"end
    return true,nil
end

local _LT_AIMBOT_SPEED=59
local _LT_MELEE_OFFSET=3
local _ltLockedTarget=nil
local _ltAntiDieConns={}
local _ltCharAddedConn=nil

local function _ltIsTargetValid(char)
    if not char or not char.Parent then return false end
    local hum=char:FindFirstChildOfClass("Humanoid")
    local hrp=char:FindFirstChild("HumanoidRootPart")
    local ff=char:FindFirstChildOfClass("ForceField")
    return hum and hrp and hum.Health>0 and not ff
end

local function _ltGetBestTarget(myHRP)
    if _ltLockedTarget and _ltIsTargetValid(_ltLockedTarget) then
        return _ltLockedTarget:FindFirstChild("HumanoidRootPart"),_ltLockedTarget
    end
    _ltLockedTarget=nil
    local shortestDist=math.huge
    local newTargetChar,newTargetHRP=nil,nil
    for _,p in ipairs(Players:GetPlayers()) do
        if p~=LP and _ltIsTargetValid(p.Character) then
            local tHRP=p.Character:FindFirstChild("HumanoidRootPart")
            local d=(tHRP.Position-myHRP.Position).Magnitude
            if d<shortestDist then
                shortestDist=d
                newTargetHRP=tHRP
                newTargetChar=p.Character
            end
        end
    end
    _ltLockedTarget=newTargetChar
    return newTargetHRP,newTargetChar
end

local function _ltEnableAntiDie()
    for _,c in ipairs(_ltAntiDieConns) do pcall(function()c:Disconnect()end) end
    _ltAntiDieConns={}
    local ch=LP.Character
    if not ch then return end
    local hum=ch:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    pcall(function()hum.BreakJointsOnDeath=false end)
    pcall(function()hum:SetStateEnabled(Enum.HumanoidStateType.Dead,false)end)
    local c1=hum:GetPropertyChangedSignal("Health"):Connect(function()
        if hum.Health<=0 then pcall(function()hum.Health=hum.MaxHealth end)end
    end)
    local c2=hum.Died:Connect(function()
        task.wait()
        local nc=LP.Character
        if nc then
            local nh=Instance.new("Humanoid")
            nh.Name=hum.Name
            nh.Parent=nc
            workspace.CurrentCamera.CameraSubject=nh
            pcall(function()hum:Destroy()end)
            if CONFIG.LOCK_TARGET_ENABLED then _ltEnableAntiDie()end
        end
    end)
    table.insert(_ltAntiDieConns,c1)
    table.insert(_ltAntiDieConns,c2)
end

local function _ltDisableAntiDie()
    for _,c in ipairs(_ltAntiDieConns) do pcall(function()c:Disconnect()end) end
    _ltAntiDieConns={}
    local ch=LP.Character
    if not ch then return end
    local hum=ch:FindFirstChildOfClass("Humanoid")
    if hum then
        pcall(function()hum.BreakJointsOnDeath=true end)
        pcall(function()hum:SetStateEnabled(Enum.HumanoidStateType.Dead,true)end)
    end
end

function startLockTarget()
    if lockTargetConnection then
        if lockTargetConnection.Connected then return end
        lockTargetConnection=nil
    end
    local myC=character
    local myH=myC and myC:FindFirstChild("HumanoidRootPart")
    local myHum=myC and myC:FindFirstChildOfClass("Humanoid")
    if not myH or not myHum then return end
    myHum.AutoRotate=false
    _ltEnableAntiDie()
    if _ltCharAddedConn then _ltCharAddedConn:Disconnect() end
    _ltCharAddedConn=LP.CharacterAdded:Connect(function(ch)
        if not CONFIG.LOCK_TARGET_ENABLED then return end
        ch:WaitForChild("HumanoidRootPart",5)
        ch:WaitForChild("Humanoid",5)
        task.wait(0.15)
        if not CONFIG.LOCK_TARGET_ENABLED then return end
        local hum=ch:FindFirstChildOfClass("Humanoid")
        if hum then hum.AutoRotate=false end
        _ltEnableAntiDie()
        if lockTargetConnection then
            lockTargetConnection:Disconnect()
            lockTargetConnection=nil
        end
        lockTargetConnection=RunService.RenderStepped:Connect(function()
            if not CONFIG.LOCK_TARGET_ENABLED then return end
            local currentC=character;if not currentC then return end
            local currentH=currentC:FindFirstChild("HumanoidRootPart");if not currentH then return end
            local currentHum=currentC:FindFirstChildOfClass("Humanoid");if not currentHum then return end
            local spd=CONFIG.LOCK_TARGET_SPEED or 60
            local targetHRP,targetChar=_ltGetBestTarget(currentH)
            if targetHRP and targetChar then
                local targetVel=targetHRP.Velocity
                local speed=targetVel.Magnitude
                local predictTime=math.clamp(speed/150,0.05,0.2)
                local predictedPos=targetHRP.Position+(targetVel*predictTime)
                local dirToTarget=predictedPos-currentH.Position
                local dist3D=dirToTarget.Magnitude
                local targetStandPos=dist3D>0 and(predictedPos-dirToTarget.Unit*_LT_MELEE_OFFSET)or predictedPos
                currentH.CFrame=CFrame.lookAt(currentH.Position,predictedPos)
                local moveDir=targetStandPos-currentH.Position
                local distToStand=moveDir.Magnitude
                if distToStand>1.5 then
                    currentH.Velocity=moveDir.Unit*spd
                else
                    currentH.Velocity=targetVel
                end
            else
                _ltLockedTarget=nil
                currentH.Velocity=Vector3.new(0,0,0)
            end
        end)
        addConnection(lockTargetConnection)
    end)
    lockTargetConnection=RunService.RenderStepped:Connect(function()
        if not CONFIG.LOCK_TARGET_ENABLED then return end
        local currentC=character;if not currentC then return end
        local currentH=currentC:FindFirstChild("HumanoidRootPart");if not currentH then return end
        local currentHum=currentC:FindFirstChildOfClass("Humanoid");if not currentHum then return end
        local spd=CONFIG.LOCK_TARGET_SPEED or 60
        local targetHRP,targetChar=_ltGetBestTarget(currentH)
        if targetHRP and targetChar then
            local targetVel=targetHRP.Velocity
            local speed=targetVel.Magnitude
            local predictTime=math.clamp(speed/150,0.05,0.2)
            local predictedPos=targetHRP.Position+(targetVel*predictTime)
            local dirToTarget=predictedPos-currentH.Position
            local dist3D=dirToTarget.Magnitude
            local targetStandPos=dist3D>0 and(predictedPos-dirToTarget.Unit*_LT_MELEE_OFFSET)or predictedPos
            currentH.CFrame=CFrame.lookAt(currentH.Position,predictedPos)
            local moveDir=targetStandPos-currentH.Position
            local distToStand=moveDir.Magnitude
            if distToStand>1.5 then
                currentH.Velocity=moveDir.Unit*spd
            else
                currentH.Velocity=targetVel
            end
        else
            _ltLockedTarget=nil
            currentH.Velocity=Vector3.new(0,0,0)
        end
    end)
    addConnection(lockTargetConnection)
end

function stopLockTarget()
    if lockTargetConnection then
        lockTargetConnection:Disconnect()
        lockTargetConnection=nil
    end
    if _ltCharAddedConn then
        _ltCharAddedConn:Disconnect()
        _ltCharAddedConn=nil
    end
    _ltLockedTarget=nil
    _ltDisableAntiDie()
    pcall(function()
        local myC=character
        if not myC then return end
        local myH=myC:FindFirstChild("HumanoidRootPart")
        local myHum=myC:FindFirstChildOfClass("Humanoid")
        if myH then myH.Velocity=Vector3.zero end
        if myHum then myHum.AutoRotate=true end
    end)
end

local _deathCoords=CFrame.new(1000003.56,999999.69,8.17)
local function _equipCarpet()
    local char=LP.Character
    if not char then return end
    local backpack=LP:FindFirstChild("Backpack")
    if backpack then
        for _,tool in ipairs(backpack:GetChildren())do
            if tool:IsA("Tool")and tool.Name:lower():find("carpet")then
                char:FindFirstChildOfClass("Humanoid"):EquipTool(tool)
                return
            end
        end
    end
end
function doInstantReset()
    local char=LP.Character
    if not char then return end
    local hrp=char:FindFirstChild("HumanoidRootPart")
    local hum=char:FindFirstChild("Humanoid")
    if not hrp or not hum then return end
    _equipCarpet()
    task.wait()
    hrp.CFrame=_deathCoords
    local conn
    conn=RunService.Heartbeat:Connect(function()
        if not char or not char.Parent then conn:Disconnect()return end
        local h=char:FindFirstChild("Humanoid")
        local r=char:FindFirstChild("HumanoidRootPart")
        if not h or not r then conn:Disconnect()return end
        if h.Health<=0 then conn:Disconnect()return end
        r.CFrame=_deathCoords
    end)
end

function startInfJump()
    if infJumpConnection then return end
    infJumpConnection=UIS.JumpRequest:Connect(function()
        if not CONFIG.INF_JUMP_ENABLED then return end
        local char=character
        if not char then return end
        local hrp=char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local vel=hrp.AssemblyLinearVelocity
        hrp.AssemblyLinearVelocity=Vector3.new(vel.X,jumpForce,vel.Z)
    end)
    addConnection(infJumpConnection)
end
function stopInfJump()
    if infJumpConnection then
        infJumpConnection:Disconnect()
        infJumpConnection=nil
    end
end





function disableCollisionForPlayer(character)
    for _,part in ipairs(character:GetDescendants())do
        if part:IsA("BasePart")then
            part.CanCollide=false
        end
    end
end
function startNoCollision()
    if noCollisionConnection then return end
    noCollisionConnection=RunService.Stepped:Connect(function()
        if not CONFIG.NO_COLLISION_ENABLED then return end
        for _,player in ipairs(Players:GetPlayers())do
            if player~=LP then
                local char=player.Character
                if char then
                    disableCollisionForPlayer(char)
                end
            end
        end
    end)
    addConnection(noCollisionConnection)
end
function stopNoCollision()
    if noCollisionConnection then
        noCollisionConnection:Disconnect()
        noCollisionConnection=nil
    end
end

function tpDown()
    pcall(function()
        local char=character
        local root=char and char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        local rp=RaycastParams.new()
        rp.FilterDescendantsInstances={char}
        rp.FilterType=Enum.RaycastFilterType.Exclude
        local res=workspace:Raycast(root.Position,Vector3.new(0,-1000,0),rp)
        if res then
            root.CFrame=CFrame.new(res.Position+Vector3.new(0,root.Size.Y/2+0.5,0))
            root.AssemblyLinearVelocity=Vector3.zero
        end
    end)
end
function _syncFloatBtn() end
function startFloat() end
function stopFloat() end

do
    local _atdJump=false
    UIS.JumpRequest:Connect(function()
        if not CONFIG.AUTO_TP_DOWN_ENABLED then return end
        if _atdJump then return end
        _atdJump=true
        task.wait(0.35)
        tpDown()
        task.wait(0.35)
        _atdJump=false
    end)
end

local AutoPlayState={
    enabled=false,
    activeSide=nil,
}
local POS={
    L1=Vector3.new(-485.04,-4.90,26.11),
    L2=Vector3.new(-476.52,-6.42,28.10),
    L3=Vector3.new(-475.17,-6.93,92.61),
    L4=Vector3.new(-476.06,-6.64,94.73),
    L5=Vector3.new(-483.34,-5.10,97.76),
    R1=Vector3.new(-484.70,-5.00,94.59),
    R2=Vector3.new(-476.28,-6.58,93.77),
    R3=Vector3.new(-474.70,-7.00,28.32),
    R4=Vector3.new(-476.26,-6.58,26.00),
    R5=Vector3.new(-483.50,-5.10,23.27),
}
local LEFT_ROUTE={
    POS.L3,
    POS.L4,
    POS.L5,
    POS.L4,
    POS.L2,
    POS.L1
}
local RIGHT_ROUTE={
    POS.R3,
    POS.R4,
    POS.R5,
    POS.R4,
    POS.R2,
    POS.R1
}

function startSpeed()
    if speedBoostConn then return end
    speedBoostConn=RunService.RenderStepped:Connect(function()
        if not CONFIG.SPEED_ENABLED then return end
        local char=character
        local hum=char and char:FindFirstChildOfClass("Humanoid")
        local root=char and char:FindFirstChild("HumanoidRootPart")
        if not hum or not root then return end
        if CONFIG.LOCK_TARGET_ENABLED and lockTargetConnection then return end
        if AutoPlayState.enabled then return end
        local vel=LP:GetAttribute("Stealing")and CONFIG.STEAL_SPEED_VALUE or CONFIG.SPEED_VALUE
        if hum.MoveDirection.Magnitude>0 then
            _lastMoveDir=hum.MoveDirection
            root.Velocity=Vector3.new(hum.MoveDirection.X*vel,root.Velocity.Y,hum.MoveDirection.Z*vel)
        elseif CONFIG.ANTIRAGDOLL_ENABLED and _lastMoveDir.Magnitude>0 then
            local anyHeld=false
            for key in pairs(MOVE_KEYS)do
                if UIS:IsKeyDown(key)then anyHeld=true;break end
            end
            if anyHeld then
                root.Velocity=Vector3.new(_lastMoveDir.X*vel,root.Velocity.Y,_lastMoveDir.Z*vel)
            end
        end
    end)
    addConnection(speedBoostConn)
end
function stopSpeed()
    if speedBoostConn then
        speedBoostConn:Disconnect()
        speedBoostConn=nil
    end
end

local apMainBtn=nil
local updateAutoPlayVisual=nil

local function stopMovement(hrp,hum)
    hum:Move(Vector3.zero,false)
    hrp.Velocity=Vector3.zero
end
local function moveTo(hrp,hum,target,speed,checkEnabled)
    repeat
        RunService.Heartbeat:Wait()
        if not checkEnabled()then
            return false
        end
        local dir=target-hrp.Position
        local flat=Vector3.new(dir.X,0,dir.Z)
        if flat.Magnitude>0 then
            flat=flat.Unit
        end
        hum:Move(flat,false)
        hrp.Velocity=Vector3.new(flat.X*speed,hrp.Velocity.Y,flat.Z*speed)
    until(Vector3.new(target.X,hrp.Position.Y,target.Z)-hrp.Position).Magnitude<=1.5
    return true
end
local function runRoute(route,side)
    local char=LP.Character
    if not char then return end
    local hrp=char:FindFirstChild("HumanoidRootPart")
    local hum=char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end
    for i,point in ipairs(route)do
        local speed=(i>=4)and CONFIG.STEAL_SPEED_VALUE or CONFIG.SPEED_VALUE
        local success=moveTo(hrp,hum,point,speed,function()
            return AutoPlayState.enabled and AutoPlayState.activeSide==side
        end)
        if not success then
            stopMovement(hrp,hum)
            return
        end
        if i==3 then
            task.wait(0.03)
        end
    end
    stopMovement(hrp,hum)
    AutoPlayState.enabled=false
    AutoPlayState.activeSide=nil
    if updateAutoPlayVisual then updateAutoPlayVisual(false)end
end
local function startRoute(side)
    if not side then return end
    if AutoPlayState.enabled and AutoPlayState.activeSide~=side then
        AutoPlayState.enabled=false
    end
    if AutoPlayState.enabled then
        AutoPlayState.enabled=false
        AutoPlayState.activeSide=nil
        if updateAutoPlayVisual then updateAutoPlayVisual(false)end
        return
    end
    AutoPlayState.enabled=true
    AutoPlayState.activeSide=side
    if CONFIG.LOCK_TARGET_ENABLED then
        CONFIG.LOCK_TARGET_ENABLED=false
        lockTargetEnabled=false
        stopLockTarget()
        if lockTargetPanelBtn then lockTargetPanelBtn.Text="LOCK: OFF" end
    end
    if updateAutoPlayVisual then updateAutoPlayVisual(true)end
    local route=(side=="L")and LEFT_ROUTE or RIGHT_ROUTE
    task.spawn(function()
        runRoute(route,side)
    end)
end

function createAutoPlayGui()
    local W=140
    local HDR_H=22
    local BTN_H=26
    local GAP=5
    local PAD=5
    local FULL_H=HDR_H+PAD+BTN_H+PAD
    local sg=Instance.new("ScreenGui",LP.PlayerGui)
    sg.AutoLocalize=false
    sg.Name="Looprix_AutoPlayGui"
    sg.ResetOnSpawn=false
    sg.DisplayOrder=999998
    sg.Enabled=CONFIG.AUTO_PLAY_GUI_VISIBLE
    local function makeAS(parent,thick,initT)
        local s=Instance.new("UIStroke",parent)
        s.Thickness=thick or 1.2;s.Color=COLORS.Accent
        s.Transparency=initT or 0;s.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
        trackStroke(s)
        local g=Instance.new("UIGradient",s)
        g.Color=ColorSequence.new({
            ColorSequenceKeypoint.new(0,COLORS.Accent),
            ColorSequenceKeypoint.new(0.33,Color3.fromRGB(120,255,200)),
            ColorSequenceKeypoint.new(0.66,Color3.fromRGB(150,255,180)),
            ColorSequenceKeypoint.new(1,COLORS.Accent),
        })
        trackGradient(g)
        return s
    end
    local main=Instance.new("Frame",sg)
    main.Size=UDim2.new(0,W,0,FULL_H)
    main.BackgroundColor3=COLORS.Background
    main.BackgroundTransparency=0.08
    main.BorderSizePixel=0
    main.ClipsDescendants=true
    Instance.new("UICorner",main).CornerRadius=UDim.new(0,10)
    registerScaleTarget(main)
    makeAS(main,1.2,0)
    local savedAP=CONFIG._guiPositions and CONFIG._guiPositions.autoPlayMain
    if savedAP then
        main.Position=UDim2.new(savedAP.scaleX,savedAP.offsetX,savedAP.scaleY,savedAP.offsetY)
    else
        main.Position=UDim2.new(0,10,0,220)
    end
    _regDraggable(main,function()return UDim2.new(0,10,0,220)end)
    local hdr=Instance.new("Frame",main)
    hdr.Size=UDim2.new(1,0,0,HDR_H)
    hdr.BackgroundColor3=COLORS.Surface;hdr.BackgroundTransparency=0.05;hdr.BorderSizePixel=0
    Instance.new("UICorner",hdr).CornerRadius=UDim.new(0,10)
    local hdrFill=Instance.new("Frame",hdr)
    hdrFill.Size=UDim2.new(1,0,0,8);hdrFill.Position=UDim2.new(0,0,1,-8)
    hdrFill.BackgroundColor3=COLORS.Surface;hdrFill.BackgroundTransparency=0.05;hdrFill.BorderSizePixel=0
    local dot=Instance.new("Frame",hdr)
    dot.Size=UDim2.new(0,6,0,6);dot.Position=UDim2.new(0,9,0.5,-3)
    dot.BackgroundColor3=COLORS.Accent;dot.BorderSizePixel=0
    Instance.new("UICorner",dot).CornerRadius=UDim.new(1,0)
    trackDot(dot)
    local titleLbl=Instance.new("TextLabel",hdr)
    titleLbl.AutoLocalize=false
    titleLbl.Size=UDim2.new(1,-34,1,0);titleLbl.Position=UDim2.new(0,20,0,0)
    titleLbl.BackgroundTransparency=1;titleLbl.Text="Auto Play"
    titleLbl.TextColor3=COLORS.Accent;titleLbl.Font=Enum.Font.GothamSemibold
    trackLabel(titleLbl)
    titleLbl.TextSize=11;titleLbl.TextXAlignment=Enum.TextXAlignment.Left
    local tg=Instance.new("UIGradient",titleLbl)
    tg.Color=ColorSequence.new({
        ColorSequenceKeypoint.new(0,COLORS.Accent),
        ColorSequenceKeypoint.new(0.33,Color3.fromRGB(120,255,200)),
        ColorSequenceKeypoint.new(0.66,Color3.fromRGB(150,255,180)),
        ColorSequenceKeypoint.new(1,COLORS.Accent)})
    trackGradient(tg)
    local minBtn=Instance.new("TextButton",hdr)
    minBtn.AutoLocalize=false
    minBtn.Size=UDim2.new(0,20,0,18);minBtn.Position=UDim2.new(1,-24,0.5,-9)
    minBtn.BackgroundColor3=COLORS.Background;minBtn.BackgroundTransparency=0.2
    minBtn.Text="-";minBtn.TextColor3=COLORS.Accent
    minBtn.Font=Enum.Font.GothamBold;minBtn.TextSize=14;minBtn.BorderSizePixel=0
    Instance.new("UICorner",minBtn).CornerRadius=UDim.new(0,4)
    makeAS(minBtn,1,0.4);trackLabel(minBtn)
    local content=Instance.new("Frame",main)
    content.Size=UDim2.new(1,0,1,-HDR_H);content.Position=UDim2.new(0,0,0,HDR_H)
    content.BackgroundTransparency=1;content.BorderSizePixel=0
    local btnLayout=Instance.new("UIListLayout",content)
    btnLayout.FillDirection=Enum.FillDirection.Horizontal
    btnLayout.HorizontalAlignment=Enum.HorizontalAlignment.Center
    btnLayout.VerticalAlignment=Enum.VerticalAlignment.Center
    btnLayout.Padding=UDim.new(0,GAP)
    local cPad=Instance.new("UIPadding",content)
    cPad.PaddingLeft=UDim.new(0,PAD);cPad.PaddingRight=UDim.new(0,PAD)
    cPad.PaddingTop=UDim.new(0,PAD);cPad.PaddingBottom=UDim.new(0,PAD)
    local FULL_W_AP=W-PAD*2
    apMainBtn=Instance.new("TextButton",content)
    apMainBtn.AutoLocalize=false
    apMainBtn.LayoutOrder=1
    apMainBtn.Size=UDim2.new(0,FULL_W_AP,0,BTN_H)
    apMainBtn.BackgroundColor3=COLORS.Surface
    apMainBtn.BackgroundTransparency=COLORS.SurfaceTransparency
    apMainBtn.Text="AUTO PLAY: OFF"
    apMainBtn.TextColor3=COLORS.Accent
    trackLabel(apMainBtn)
    apMainBtn.Font=Enum.Font.GothamBold;apMainBtn.TextSize=12;apMainBtn.BorderSizePixel=0
    Instance.new("UICorner",apMainBtn).CornerRadius=UDim.new(0,7)
    makeAS(apMainBtn,1,0.45)
    local function syncApVisual(state)
        if not apMainBtn or not apMainBtn.Parent then return end
        apMainBtn.Text=state and"AUTO PLAY: ON"or"AUTO PLAY: OFF"
        S.TweenService:Create(apMainBtn,tweenInfoFast,{
            BackgroundColor3=state and COLORS.Accent or COLORS.Surface,
            BackgroundTransparency=state and 0.0 or COLORS.SurfaceTransparency,
        }):Play()
        apMainBtn.TextColor3=state and Color3.fromRGB(10,10,10)or COLORS.Accent
    end
    updateAutoPlayVisual=syncApVisual
    apMainBtn.MouseButton1Click:Connect(function()
        if AutoPlayState.enabled then
            apStopLoop()
            syncApVisual(false)
        else
            local side=_detectSideNow()
            if side then
                startRoute(side)
            end
        end
    end)
    local apMinimized=false
    minBtn.MouseButton1Click:Connect(function()
        apMinimized=not apMinimized
        if apMinimized then
            hdrFill.Visible=false;content.Visible=false
            S.TweenService:Create(main,tweenInfoMedium,{Size=UDim2.new(0,W,0,HDR_H)}):Play()
            minBtn.Text="+"
        else
            hdrFill.Visible=true;content.Visible=true
            S.TweenService:Create(main,tweenInfoMedium,{Size=UDim2.new(0,W,0,FULL_H)}):Play()
            minBtn.Text="-"
        end
    end)
    makeDraggable(main,hdr,"autoPlayMain",function()return CONFIG.UI_LOCKED end)
    apGuiInstance=sg
    pcall(function()
        applyAccentColor(CONFIG.GUI_COLOR_R or 0,CONFIG.GUI_COLOR_G or 217,CONFIG.GUI_COLOR_B or 127)
    end)
    return sg
end

function apStopLoop()
    AutoPlayState.enabled=false
    AutoPlayState.activeSide=nil
    if updateAutoPlayVisual then updateAutoPlayVisual(false)end
end
function apResetBtns()end
function apLaunchSide(side)
    if side=="L"or side=="R"then
        startRoute(side)
    else
        local detected=_detectSideNow()
        if detected then
            startRoute(detected)
        end
    end
end

function setupMedusaIndicator(char)
    if not char then return end
    local root=char:WaitForChild("HumanoidRootPart",5)
    if not root then return end
    if medusaCircle then medusaCircle:Destroy()end
    medusaCircle=Instance.new("CylinderHandleAdornment")
    medusaCircle.Name="MedusaRadius"
    medusaCircle.Adornee=root
    medusaCircle.AlwaysOnTop=true
    medusaCircle.ZIndex=5
    medusaCircle.Transparency=0.6
    medusaCircle.Color3=COLORS.Accent
    medusaCircle.Radius=CONFIG.AUTO_MEDUSA_RANGE
    medusaCircle.Height=0.05
    medusaCircle.CFrame=CFrame.new(0,-3,0)*CFrame.Angles(math.rad(90),0,0)
    medusaCircle.Parent=root
end
function startAutoMedusa()
    if autoMedusaConnection then return end
    if character then
        setupMedusaIndicator(character)
    end
    if not medusaCharAddedConnection then
        medusaCharAddedConnection=LP.CharacterAdded:Connect(function(newChar)
            if CONFIG.AUTO_MEDUSA_ENABLED then
                setupMedusaIndicator(newChar)
            end
        end)
        addConnection(medusaCharAddedConnection)
    end
    autoMedusaConnection=RunService.Heartbeat:Connect(function()
        if not CONFIG.AUTO_MEDUSA_ENABLED then return end
        if medusaCircle then
            medusaCircle.Radius=CONFIG.AUTO_MEDUSA_RANGE
        end
        local char=character
        if not char then return end
        local root=char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        local equippedTool
        for _,v in ipairs(char:GetChildren())do
            if v:IsA("Tool")and v.Name:lower():find("medusa")then
                equippedTool=v
                break
            end
        end
        if not equippedTool then return end
        for _,p in ipairs(Players:GetPlayers())do
            if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart")then
                local dist=(p.Character.HumanoidRootPart.Position-root.Position).Magnitude
                if dist<=CONFIG.AUTO_MEDUSA_RANGE then
                    pcall(function()equippedTool:Activate()end)
                    break
                end
            end
        end
    end)
    addConnection(autoMedusaConnection)
end
function stopAutoMedusa()
    if autoMedusaConnection then
        autoMedusaConnection:Disconnect()
        autoMedusaConnection=nil
    end
    if medusaCharAddedConnection then
        medusaCharAddedConnection:Disconnect()
        medusaCharAddedConnection=nil
    end
    if medusaCircle then
        medusaCircle:Destroy()
        medusaCircle=nil
    end
end

function findMedusaForCounter()
    local char=character;if not char then return nil end
    for _,tool in ipairs(char:GetChildren())do
        if tool:IsA("Tool")then
            local tn=tool.Name:lower()
            if tn:find("medusa")or tn:find("head")or tn:find("stone")then return tool end
        end
    end
    local bp=LP:FindFirstChild("Backpack")
    if bp then
        for _,tool in ipairs(bp:GetChildren())do
            if tool:IsA("Tool")then
                local tn=tool.Name:lower()
                if tn:find("medusa")or tn:find("head")or tn:find("stone")then return tool end
            end
        end
    end
    return nil
end
function useMedusaCounter()
    if medusaCounterDebounce then return end
    if tick()-medusaCounterLastUsed<MEDUSA_COUNTER_COOLDOWN then return end
    local char=character;if not char then return end
    medusaCounterDebounce=true
    local med=findMedusaForCounter()
    if not med then medusaCounterDebounce=false;return end
    if med.Parent~=char then
        local hum2=char:FindFirstChildOfClass("Humanoid")
        if hum2 then hum2:EquipTool(med)end
    end
    pcall(function()med:Activate()end)
    medusaCounterLastUsed=tick()
    medusaCounterDebounce=false
end
function stopMedusaCounter()
    for _,c in pairs(medusaCounterConns)do pcall(function()c:Disconnect()end)end
    medusaCounterConns={}
end
function setupMedusaCounter(char)
    stopMedusaCounter()
    if not char then return end
    local function onAnchorChanged(part)
        return part:GetPropertyChangedSignal("Anchored"):Connect(function()
            if CONFIG.MEDUSA_COUNTER_ENABLED and part.Anchored and part.Transparency==1 then
                useMedusaCounter()
            end
        end)
    end
    for _,part in ipairs(char:GetDescendants())do
        if part:IsA("BasePart")then
            table.insert(medusaCounterConns,onAnchorChanged(part))
        end
    end
    table.insert(medusaCounterConns,char.DescendantAdded:Connect(function(part)
        if part:IsA("BasePart")then
            table.insert(medusaCounterConns,onAnchorChanged(part))
        end
    end))
end

function ResetStealProgressBar()
    if stealFillFrame then
        stealFillFrame.Size=UDim2.new(0,0,1,0)
        stealFillFrame.Visible=false
    end
end

task.spawn(function()
    task.wait(2)
    while task.wait(5) do
        if CONFIG.AUTO_STEAL_ENABLED then
            table.clear(_allAnimalsCache)
            local plots=workspace:FindFirstChild("Plots")
            if plots then
                for _,plot in ipairs(plots:GetChildren())do
                    if plot:IsA("Model") then
                        local sign=plot:FindFirstChild("PlotSign")
                        local yourBase=sign and sign:FindFirstChild("YourBase")
                        if not (yourBase and yourBase.Enabled) then
                            local podiums=plot:FindFirstChild("AnimalPodiums")
                            if podiums then
                                for _,podium in ipairs(podiums:GetChildren())do
                                    if podium:IsA("Model") and podium:FindFirstChild("Base") then
                                        table.insert(_allAnimalsCache,{
                                            plot=plot.Name,
                                            slot=podium.Name,
                                            worldPosition=podium:GetPivot().Position,
                                            uid=plot.Name.."_"..podium.Name
                                        })
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

local function _findPromptCached(a)
    local c=_promptMemoryCache[a.uid]
    if c and c.Parent then return c end
    local plots=workspace:FindFirstChild("Plots")
    local plot=plots and plots:FindFirstChild(a.plot)
    local podiums=plot and plot:FindFirstChild("AnimalPodiums")
    local podium=podiums and podiums:FindFirstChild(a.slot)
    if not podium then return nil end
    local base=podium:FindFirstChild("Base")
    local spawn=base and base:FindFirstChild("Spawn")
    if not spawn then return nil end
    local attach=spawn:FindFirstChild("PromptAttachment")
    if not attach then return nil end
    for _,p in ipairs(attach:GetChildren())do
        if p:IsA("ProximityPrompt") then
            _promptMemoryCache[a.uid]=p
            return p
        end
    end
end

local function _buildStealCache(prompt)
    if _internalStealCache[prompt] then return end
    local d={h={},t={},r=true}
    local ok1,c1=pcall(function()return getconnections(prompt.PromptButtonHoldBegan)end)
    if ok1 and c1 then
        for _,c in ipairs(c1)do
            if c and type(c.Function)=="function" then table.insert(d.h,c.Function)end
        end
    end
    local ok2,c2=pcall(function()return getconnections(prompt.Triggered)end)
    if ok2 and c2 then
        for _,c in ipairs(c2)do
            if c and type(c.Function)=="function" then table.insert(d.t,c.Function)end
        end
    end
    _internalStealCache[prompt]=d
end

local function _executeAutoSteal(prompt)
    local d=_internalStealCache[prompt]
    if not d or not d.r then return end
    d.r=false
    isStealing=true
    stealStartTime=tick()
    if stealFillFrame then
        stealFillFrame.Size=UDim2.new(0,0,1,0)
        stealFillFrame.Visible=true
    end
    if stealProgressConnection then stealProgressConnection:Disconnect()end
    local dur=CONFIG.AUTO_STEAL_DURATION
    stealProgressConnection=RunService.Heartbeat:Connect(function()
        if not isStealing then
            if stealProgressConnection then stealProgressConnection:Disconnect();stealProgressConnection=nil end
            return
        end
        local prog=math.clamp((tick()-stealStartTime)/dur,0,1)
        if stealFillFrame then stealFillFrame.Size=UDim2.new(prog,0,1,0)end
    end)
    task.spawn(function()
        if #d.h>0 or #d.t>0 then
            for _,f in ipairs(d.h)do task.spawn(function()pcall(f)end)end
            local elapsed=0
            while elapsed<dur do elapsed=elapsed+task.wait()end
            for _,f in ipairs(d.t)do task.spawn(function()pcall(f)end)end
        else
            if fireproximityprompt then
                fireproximityprompt(prompt)
            else
                pcall(function()prompt:InputHoldBegan()end)
            end
            local elapsed=0
            while elapsed<dur do elapsed=elapsed+task.wait()end
            pcall(function()prompt:InputHoldEnded()end)
        end
        if stealFillFrame then stealFillFrame.Size=UDim2.new(1,0,1,0)end
        task.wait(0.05)
        if stealProgressConnection then stealProgressConnection:Disconnect();stealProgressConnection=nil end
        ResetStealProgressBar()
        d.r=true
        isStealing=false
    end)
end

local function _createAutoStealCircle()
    for _,p in ipairs(_autoStealCircleParts)do pcall(function()p:Destroy()end)end
    table.clear(_autoStealCircleParts)
    for i=1,AUTO_STEAL_PARTS_COUNT do
        local part=Instance.new("Part")
        part.Anchored=true
        part.CanCollide=false
        part.Material=Enum.Material.Neon
        part.Color=COLORS.Accent
        part.Transparency=0.35
        part.Size=Vector3.new(1,0.2,0.3)
        part.Parent=workspace
        table.insert(_autoStealCircleParts,part)
    end
end

RunService.RenderStepped:Connect(function()
    if not CONFIG.AUTO_STEAL_ENABLED then
        if #_autoStealCircleParts>0 then
            for _,p in ipairs(_autoStealCircleParts)do pcall(function()p:Destroy()end)end
            table.clear(_autoStealCircleParts)
        end
        return
    end
    if not HRP then return end
    if #_autoStealCircleParts==0 then _createAutoStealCircle()end
    local R=CONFIG.AUTO_STEAL_ACTIVATION_DIST
    local N=AUTO_STEAL_PARTS_COUNT
    for i,p in ipairs(_autoStealCircleParts)do
        local a1=math.rad((i-1)/N*360)
        local a2=math.rad(i/N*360)
        local p1=Vector3.new(math.cos(a1),0,math.sin(a1))*R
        local p2=Vector3.new(math.cos(a2),0,math.sin(a2))*R
        local center=(p1+p2)/2+HRP.Position
        p.Size=Vector3.new((p2-p1).Magnitude,0.2,0.3)
        p.CFrame=CFrame.new(center,center+Vector3.new(p2.X-p1.X,0,p2.Z-p1.Z))*CFrame.Angles(0,math.pi/2,0)
    end
end)

function startAutoSteal()
    if autoStealConn then return end
    _createAutoStealCircle()
    autoStealConn=RunService.Heartbeat:Connect(function()
        if not CONFIG.AUTO_STEAL_ENABLED or isStealing then return end
        if not HRP then return end
        local best,dist=nil,math.huge
        for _,a in ipairs(_allAnimalsCache)do
            local d=(HRP.Position-a.worldPosition).Magnitude
            if d<dist then dist=d;best=a end
        end
        if not best or dist>CONFIG.AUTO_STEAL_ACTIVATION_DIST then return end
        local p=_findPromptCached(best)
        if not p then return end
        _buildStealCache(p)
        _executeAutoSteal(p)
    end)
    addConnection(autoStealConn)
end
function stopAutoSteal()
    autoStealGrabEnabled=false
    if autoStealConn then
        autoStealConn:Disconnect()
        autoStealConn=nil
    end
    if stealProgressConnection then
        stealProgressConnection:Disconnect()
        stealProgressConnection=nil
    end
    table.clear(_allAnimalsCache)
    table.clear(_promptMemoryCache)
    table.clear(_internalStealCache)
    for _,p in ipairs(_autoStealCircleParts)do pcall(function()p:Destroy()end)end
    table.clear(_autoStealCircleParts)
    ResetStealProgressBar()
end

local function _captureOriginalJumpPower()
    pcall(function()
        local c=character
        if not c then return end
        local hum=c:FindFirstChildOfClass("Humanoid")
        if hum and hum.JumpPower>0 then
            _jumpBoostOriginalJumpPower=hum.JumpPower
        end
    end)
end

local function _setupGalaxyForce()
    pcall(function()
        local c=character
        if not c then return end
        local h=c:FindFirstChild("HumanoidRootPart")
        if not h then return end
        if _galaxyVectorForce then _galaxyVectorForce:Destroy()end
        if _galaxyAttachment then _galaxyAttachment:Destroy()end
        _galaxyAttachment=Instance.new("Attachment")
        _galaxyAttachment.Parent=h
        _galaxyVectorForce=Instance.new("VectorForce")
        _galaxyVectorForce.Attachment0=_galaxyAttachment
        _galaxyVectorForce.ApplyAtCenterOfMass=true
        _galaxyVectorForce.RelativeTo=Enum.ActuatorRelativeTo.World
        _galaxyVectorForce.Force=Vector3.new(0,0,0)
        _galaxyVectorForce.Parent=h
    end)
end

local function _updateGalaxyForce()
    if not _galaxyEnabled or not _galaxyVectorForce then return end
    local c=character
    if not c then return end
    local mass=0
    for _,p in ipairs(c:GetDescendants())do
        if p:IsA("BasePart") then mass=mass+p:GetMass()end
    end
    local tg=DEFAULT_GRAVITY*(CONFIG.JUMP_BOOST_GRAVITY_PERCENT/100)
    _galaxyVectorForce.Force=Vector3.new(0,mass*(DEFAULT_GRAVITY-tg)*0.95,0)
end

local function _adjustGalaxyJump()
    pcall(function()
        local c=character
        if not c then return end
        local hum=c:FindFirstChildOfClass("Humanoid")
        if not hum then return end
        if not _galaxyEnabled then
            hum.JumpPower=_jumpBoostOriginalJumpPower
            return
        end
        local ratio=math.sqrt((DEFAULT_GRAVITY*(CONFIG.JUMP_BOOST_GRAVITY_PERCENT/100))/DEFAULT_GRAVITY)
        hum.JumpPower=_jumpBoostOriginalJumpPower*ratio
    end)
end

local function _doJumpBoostHop()
    if not _jumpBoostHopsEnabled then return end
    pcall(function()
        local c=character
        if not c then return end
        local h=c:FindFirstChild("HumanoidRootPart")
        local hum=c:FindFirstChildOfClass("Humanoid")
        if not h or not hum then return end
        if tick()-_jumpBoostLastHop<CONFIG.JUMP_BOOST_HOP_COOLDOWN then return end
        _jumpBoostLastHop=tick()
        if hum.FloorMaterial==Enum.Material.Air then
            h.AssemblyLinearVelocity=Vector3.new(h.AssemblyLinearVelocity.X,CONFIG.JUMP_BOOST_HOP_POWER,h.AssemblyLinearVelocity.Z)
        end
    end)
end

RunService.Heartbeat:Connect(function()
    if _jumpBoostHopsEnabled and _jumpBoostSpaceHeld then
        _doJumpBoostHop()
    end
    if _galaxyEnabled then
        _updateGalaxyForce()
    end
end)

task.spawn(function()
    task.wait(1)
    _captureOriginalJumpPower()
end)

function startJumpBoost()
    _galaxyEnabled=true
    _jumpBoostHopsEnabled=true
    _captureOriginalJumpPower()
    _setupGalaxyForce()
    _adjustGalaxyJump()
end
function stopJumpBoost()
    _galaxyEnabled=false
    _jumpBoostHopsEnabled=false
    if _galaxyVectorForce then _galaxyVectorForce:Destroy();_galaxyVectorForce=nil end
    if _galaxyAttachment then _galaxyAttachment:Destroy();_galaxyAttachment=nil end
    _adjustGalaxyJump()
end

function createFloatingPanel(name,configPath,configVisible,defaultText)
    local panelGui=Instance.new("ScreenGui")
    panelGui.AutoLocalize=false
    panelGui.Name="Looprix_Floating_"..name
    panelGui.ResetOnSpawn=false
    panelGui.DisplayOrder=999998
    panelGui.Enabled=CONFIG[configVisible]
    pcall(function()
        if gethui then panelGui.Parent=gethui()
        elseif syn and syn.protect_gui then syn.protect_gui(panelGui);panelGui.Parent=LP.PlayerGui
        else panelGui.Parent=LP.PlayerGui end
    end)
    if not panelGui.Parent then panelGui.Parent=LP.PlayerGui end
    local frame=Instance.new("TextButton",panelGui)
    frame.AutoLocalize=false
    frame.Size=UDim2.new(0,100,0,33)
    frame.BackgroundColor3=Color3.fromRGB(10,12,18)
    frame.BackgroundTransparency=0.15
    frame.BorderSizePixel=0
    frame.Text=defaultText
    frame.TextColor3=COLORS.Accent
    frame.Font=Enum.Font.GothamBold
    frame.TextSize=11
    frame.AutoButtonColor=false
    trackLabel(frame)
    Instance.new("UICorner",frame).CornerRadius=UDim.new(0,6)
    registerScaleTarget(frame)
    local stroke=Instance.new("UIStroke",frame)
    stroke.Color=COLORS.Accent
    stroke.Thickness=1
    stroke.Transparency=0.1
    stroke.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
    trackStroke(stroke)
    local strokeGrad=Instance.new("UIGradient",stroke)
    strokeGrad.Color=ColorSequence.new({
        ColorSequenceKeypoint.new(0,Color3.fromRGB(0,217,127)),
        ColorSequenceKeypoint.new(0.25,Color3.fromRGB(120,255,210)),
        ColorSequenceKeypoint.new(0.5,Color3.fromRGB(150,255,180)),
        ColorSequenceKeypoint.new(0.75,Color3.fromRGB(120,255,210)),
        ColorSequenceKeypoint.new(1,Color3.fromRGB(0,217,127))
    })
    trackGradient(strokeGrad)
    loadAndClampPosition(frame,configPath,UDim2.new(0,10,0.5,0))
    _regDraggable(frame,function()return UDim2.new(0,10,0.5,0)end)
    local _fpIsTap=makeDraggable(frame,frame,configPath,function()return CONFIG.UI_LOCKED end)
    pcall(function()
        applyAccentColor(CONFIG.GUI_COLOR_R or 0,CONFIG.GUI_COLOR_G or 217,CONFIG.GUI_COLOR_B or 127)
    end)
    local function onTap(cb)
        frame.InputEnded:Connect(function(inp)
            if inp.UserInputType~=Enum.UserInputType.MouseButton1 and
               inp.UserInputType~=Enum.UserInputType.Touch then return end
            if not _fpIsTap()then return end
            cb()
        end)
    end
    return panelGui,frame,onTap
end

local function _main()
    local PRESET_CFG_KEYS={
        normal={speed="PRESET_NORMAL_SPEED",steal="PRESET_NORMAL_STEAL"},
        desync={speed="PRESET_DESYNC_SPEED",steal="PRESET_DESYNC_STEAL"},
        lagger={speed="PRESET_LAGGER_SPEED",steal="PRESET_LAGGER_STEAL"},
    }
    local function createSpeedGui()
        local W=148
        local HDR_H=20
        local PRE_H=22
        local ROW_H=26
        local GAP=3
        local PAD=5
        local CONTENT_H=ROW_H+GAP+ROW_H+GAP+ROW_H
        local FULL_H=HDR_H+PAD+PRE_H+GAP+CONTENT_H+PAD
        local sg=Instance.new("ScreenGui",LP.PlayerGui)
        sg.AutoLocalize=false;sg.Name="Looprix_SpeedGui"
        sg.ResetOnSpawn=false;sg.DisplayOrder=999998
        sg.Enabled=CONFIG.SPEED_GUI_VISIBLE
        local main=Instance.new("Frame",sg)
        main.Size=UDim2.new(0,W,0,FULL_H)
        main.BackgroundColor3=COLORS.Background;main.BackgroundTransparency=0.1
        main.BorderSizePixel=0;main.ClipsDescendants=false
        Instance.new("UICorner",main).CornerRadius=UDim.new(0,8)
        registerScaleTarget(main)
        loadAndClampPosition(main,"speedGui",UDim2.new(0,10,0,55))
        _regDraggable(main,function()return UDim2.new(0,10,0,55)end)
        local mainStroke=Instance.new("UIStroke",main)
        mainStroke.Thickness=1.2;mainStroke.Color=COLORS.Accent
        mainStroke.Transparency=0.0;mainStroke.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
        trackStroke(mainStroke)
        local sg_=Instance.new("UIGradient",mainStroke)
        sg_.Color=ColorSequence.new({
            ColorSequenceKeypoint.new(0,COLORS.Accent),
            ColorSequenceKeypoint.new(0.33,Color3.fromRGB(120,255,200)),
            ColorSequenceKeypoint.new(0.66,Color3.fromRGB(150,255,180)),
            ColorSequenceKeypoint.new(1,COLORS.Accent),
        })
        trackGradient(sg_)
        local hdr=Instance.new("Frame",main)
        hdr.Size=UDim2.new(1,0,0,HDR_H);hdr.BackgroundColor3=COLORS.Surface
        hdr.BackgroundTransparency=0.05;hdr.BorderSizePixel=0
        Instance.new("UICorner",hdr).CornerRadius=UDim.new(0,8)
        local hdrFill=Instance.new("Frame",hdr)
        hdrFill.Size=UDim2.new(1,0,0,9);hdrFill.Position=UDim2.new(0,0,1,-9)
        hdrFill.BackgroundColor3=COLORS.Surface;hdrFill.BackgroundTransparency=0.05;hdrFill.BorderSizePixel=0
        local dot=Instance.new("Frame",hdr)
        dot.Size=UDim2.new(0,5,0,5);dot.Position=UDim2.new(0,8,0.5,-2)
        dot.BackgroundColor3=COLORS.Accent;dot.BorderSizePixel=0
        Instance.new("UICorner",dot).CornerRadius=UDim.new(1,0);trackDot(dot)
        local titleLbl=Instance.new("TextLabel",hdr)
        titleLbl.AutoLocalize=false
        titleLbl.Size=UDim2.new(1,-42,1,0);titleLbl.Position=UDim2.new(0,18,0,0)
        titleLbl.BackgroundTransparency=1;titleLbl.Text="Speed Booster"
        titleLbl.TextColor3=COLORS.Accent;titleLbl.Font=Enum.Font.GothamSemibold
        titleLbl.TextSize=10;titleLbl.TextXAlignment=Enum.TextXAlignment.Left
        trackLabel(titleLbl)
        local tgH=Instance.new("UIGradient",titleLbl);tgH.Color=sg_.Color;trackGradient(tgH)
        local minBtn=Instance.new("TextButton",hdr)
        minBtn.AutoLocalize=false
        minBtn.Size=UDim2.new(0,18,0,14);minBtn.Position=UDim2.new(1,-22,0.5,-7)
        minBtn.BackgroundColor3=COLORS.Background;minBtn.BackgroundTransparency=0.15
        minBtn.Text="-";minBtn.TextColor3=COLORS.Accent
        minBtn.Font=Enum.Font.GothamBold;minBtn.TextSize=13;minBtn.BorderSizePixel=0
        Instance.new("UICorner",minBtn).CornerRadius=UDim.new(0,4);trackLabel(minBtn)
        local ms2=Instance.new("UIStroke",minBtn)
        ms2.Color=COLORS.Accent;ms2.Thickness=1;ms2.Transparency=0.4;trackStroke(ms2)
        local presetBar=Instance.new("Frame",main)
        presetBar.Size=UDim2.new(1,-PAD*2,0,PRE_H)
        presetBar.Position=UDim2.new(0,PAD,0,HDR_H+PAD)
        presetBar.BackgroundTransparency=1;presetBar.BorderSizePixel=0
        local preLL=Instance.new("UIListLayout",presetBar)
        preLL.FillDirection=Enum.FillDirection.Horizontal
        preLL.HorizontalAlignment=Enum.HorizontalAlignment.Center
        preLL.VerticalAlignment=Enum.VerticalAlignment.Center
        preLL.Padding=UDim.new(0,2)
        local presetBtns={}
        local curPreset=CONFIG.SPEED_PRESET or"normal"
        _speedValBox,_stealValBox=nil,nil
        local function saveCurrentPresetValues()
            local keys=PRESET_CFG_KEYS[curPreset];if not keys then return end
            CONFIG[keys.speed]=CONFIG.SPEED_VALUE
            CONFIG[keys.steal]=CONFIG.STEAL_SPEED_VALUE
        end
        local function applyPreset(name)
            local keys=PRESET_CFG_KEYS[name];if not keys then return end
            saveCurrentPresetValues()
            curPreset=name
            CONFIG.SPEED_PRESET=name
            CONFIG.SPEED_VALUE=CONFIG[keys.speed]
            CONFIG.STEAL_SPEED_VALUE=CONFIG[keys.steal]
            saveConfig()
            if _speedValBox then _speedValBox.Text=tostring(CONFIG.SPEED_VALUE)end
            if _stealValBox then _stealValBox.Text=tostring(CONFIG.STEAL_SPEED_VALUE)end
            for pname,pb in pairs(presetBtns)do
                local active=(pname==name)
                TweenService:Create(pb,TweenInfo.new(0.13,Enum.EasingStyle.Quad),{
                    BackgroundColor3=active and COLORS.Accent or COLORS.Surface,
                    BackgroundTransparency=active and 0.0 or 0.08,
                }):Play()
                pb.TextColor3=active and Color3.fromRGB(10,10,10)or COLORS.Accent
            end
        end
        for _,def in ipairs({"normal","lagger"})do
            local active=(curPreset==def)
            local pb=Instance.new("TextButton",presetBar)
            pb.AutoLocalize=false
            pb.Size=UDim2.new(0,62,1,0)
            pb.BackgroundColor3=active and COLORS.Accent or COLORS.Surface
            pb.BackgroundTransparency=active and 0.0 or 0.08
            pb.Text=def:upper();pb.TextColor3=active and Color3.fromRGB(10,10,10)or COLORS.Accent
            pb.Font=Enum.Font.GothamBold;pb.TextSize=8;pb.BorderSizePixel=0
            Instance.new("UICorner",pb).CornerRadius=UDim.new(0,5)
            local pbs=Instance.new("UIStroke",pb)
            pbs.Color=COLORS.Accent;pbs.Thickness=1;pbs.Transparency=0.35;trackStroke(pbs)
            presetBtns[def]=pb
            local capName=def
            pb.MouseButton1Click:Connect(function()applyPreset(capName)end)
        end
        local content=Instance.new("Frame",main)
        content.Size=UDim2.new(1,0,0,CONTENT_H)
        content.Position=UDim2.new(0,0,0,HDR_H+PAD+PRE_H+GAP)
        content.BackgroundTransparency=1;content.BorderSizePixel=0
        local ll2=Instance.new("UIListLayout",content)
        ll2.FillDirection=Enum.FillDirection.Vertical
        ll2.HorizontalAlignment=Enum.HorizontalAlignment.Center
        ll2.VerticalAlignment=Enum.VerticalAlignment.Top
        ll2.Padding=UDim.new(0,GAP);ll2.SortOrder=Enum.SortOrder.LayoutOrder
        local uip2=Instance.new("UIPadding",content)
        uip2.PaddingLeft=UDim.new(0,PAD);uip2.PaddingRight=UDim.new(0,PAD)
        local IW=W-PAD*2
        local BOX_W=44
        local BOX_POS=IW-BOX_W-2
        local function makeRow(lo,labelText)
            local f=Instance.new("Frame",content)
            f.LayoutOrder=lo;f.Size=UDim2.new(1,0,0,ROW_H)
            f.BackgroundColor3=COLORS.Surface;f.BackgroundTransparency=0.08;f.BorderSizePixel=0
            Instance.new("UICorner",f).CornerRadius=UDim.new(0,5)
            local rs=Instance.new("UIStroke",f)
            rs.Color=COLORS.Accent;rs.Thickness=1;rs.Transparency=0.65
            rs.ApplyStrokeMode=Enum.ApplyStrokeMode.Border;trackStroke(rs)
            local lbl=Instance.new("TextLabel",f)
            lbl.AutoLocalize=false;lbl.Size=UDim2.new(0.55,0,0,14)
            lbl.Position=UDim2.new(0,6,0,6);lbl.BackgroundTransparency=1
            lbl.Text=labelText;lbl.TextColor3=COLORS.Accent;trackLabel(lbl)
            lbl.Font=Enum.Font.GothamSemibold;lbl.TextSize=9
            lbl.TextXAlignment=Enum.TextXAlignment.Left
            return f
        end
        local function makeBox(parent,xOff,defText)
            local box=Instance.new("TextBox",parent)
            box.AutoLocalize=false;box.Size=UDim2.new(0,BOX_W,0,16)
            box.Position=UDim2.new(0,xOff,0,5);box.BackgroundColor3=COLORS.Background
            box.BackgroundTransparency=0.0;box.Text=defText
            box.TextColor3=COLORS.Accent;trackLabel(box)
            box.Font=Enum.Font.GothamBold;box.TextSize=9
            box.ClearTextOnFocus=false;box.BorderSizePixel=0
            Instance.new("UICorner",box).CornerRadius=UDim.new(0,4)
            local s=Instance.new("UIStroke",box)
            s.Color=COLORS.Accent;s.Thickness=1;s.Transparency=0.55;trackStroke(s)
            return box
        end
        local r0=makeRow(0,"Status:")
        local statusBtn=Instance.new("TextButton",r0)
        statusBtn.AutoLocalize=false;statusBtn.Size=UDim2.new(0,BOX_W,0,16)
        statusBtn.Position=UDim2.new(0,BOX_POS,0,5)
        statusBtn.BackgroundColor3=CONFIG.SPEED_ENABLED and COLORS.Accent or COLORS.Background
        statusBtn.Text=CONFIG.SPEED_ENABLED and"ON"or"OFF"
        statusBtn.TextColor3=CONFIG.SPEED_ENABLED and Color3.fromRGB(10,10,10)or COLORS.Accent
        statusBtn.Font=Enum.Font.GothamBold;statusBtn.TextSize=9;statusBtn.BorderSizePixel=0
        Instance.new("UICorner",statusBtn).CornerRadius=UDim.new(0,4);trackLabel(statusBtn)
        local statusStroke=Instance.new("UIStroke",statusBtn)
        statusStroke.Color=COLORS.Accent;statusStroke.Thickness=1;statusStroke.Transparency=0.55
        trackStroke(statusStroke)
        RunService.RenderStepped:Connect(function()
            if CONFIG.SPEED_ENABLED then statusBtn.BackgroundColor3=COLORS.Accent;statusBtn.TextColor3=Color3.fromRGB(10,10,10)
            else statusBtn.TextColor3=COLORS.Accent;statusBtn.BackgroundColor3=COLORS.Background end
        end)
        statusBtn.MouseButton1Click:Connect(function()
            CONFIG.SPEED_ENABLED=not CONFIG.SPEED_ENABLED
            statusBtn.BackgroundColor3=CONFIG.SPEED_ENABLED and COLORS.Accent or COLORS.Background
            statusBtn.TextColor3=CONFIG.SPEED_ENABLED and Color3.fromRGB(10,10,10)or COLORS.Accent
            statusBtn.Text=CONFIG.SPEED_ENABLED and"ON"or"OFF";saveConfig()
        end)
        local r1=makeRow(1,"Speed")
        local b1=makeBox(r1,BOX_POS,tostring(CONFIG.SPEED_VALUE))
        _speedValBox=b1
        b1.FocusLost:Connect(function()
            local v=tonumber(b1.Text)or CONFIG.SPEED_VALUE
            CONFIG.SPEED_VALUE=math.clamp(v,0,999)
            b1.Text=tostring(CONFIG.SPEED_VALUE)
            local keys=PRESET_CFG_KEYS[curPreset]
            if keys then CONFIG[keys.speed]=CONFIG.SPEED_VALUE end
            saveConfig()
        end)
        local r2=makeRow(2,"Steal Spd")
        local b2=makeBox(r2,BOX_POS,tostring(CONFIG.STEAL_SPEED_VALUE))
        _stealValBox=b2
        b2.FocusLost:Connect(function()
            local v=tonumber(b2.Text)or CONFIG.STEAL_SPEED_VALUE
            CONFIG.STEAL_SPEED_VALUE=math.clamp(v,0,999)
            b2.Text=tostring(CONFIG.STEAL_SPEED_VALUE)
            local keys=PRESET_CFG_KEYS[curPreset]
            if keys then CONFIG[keys.steal]=CONFIG.STEAL_SPEED_VALUE end
            saveConfig()
        end)
        do
            local keys=PRESET_CFG_KEYS[curPreset]
            if keys then
                CONFIG.SPEED_VALUE=CONFIG[keys.speed]
                CONFIG.STEAL_SPEED_VALUE=CONFIG[keys.steal]
                b1.Text=tostring(CONFIG.SPEED_VALUE)
                b2.Text=tostring(CONFIG.STEAL_SPEED_VALUE)
            end
        end
        local speedMinimized=false
        local MINI_H=HDR_H+PAD+PRE_H+PAD
        minBtn.MouseButton1Click:Connect(function()
            speedMinimized=not speedMinimized
            if speedMinimized then
                hdrFill.Visible=false;content.Visible=false
                TweenService:Create(main,tweenInfoMedium,{Size=UDim2.new(0,W,0,MINI_H)}):Play()
                minBtn.Text="+"
            else
                hdrFill.Visible=true;content.Visible=true
                TweenService:Create(main,tweenInfoMedium,{Size=UDim2.new(0,W,0,FULL_H)}):Play()
                minBtn.Text="-"
            end
        end)
        makeDraggable(main,hdr,"speedGui",function()return CONFIG.UI_LOCKED end)
        startSpeed()
        return sg
    end

    local function createLaggerGui()
        local W=148
        local HDR_H=20
        local TOGGLE_H=28
        local ROW_H=26
        local GAP=3
        local PAD=5
        local CONTENT_H=ROW_H+GAP+ROW_H+GAP+ROW_H
        local FULL_H=HDR_H+PAD+TOGGLE_H+PAD+CONTENT_H+PAD
        local MINI_H=HDR_H+PAD+TOGGLE_H+PAD
        local sg=Instance.new("ScreenGui",LP.PlayerGui)
        sg.AutoLocalize=false;sg.Name="Looprix_LaggerGui"
        sg.ResetOnSpawn=false;sg.DisplayOrder=999998
        sg.Enabled=CONFIG.LAGGER_GUI_VISIBLE
        local main=Instance.new("Frame",sg)
        main.Size=UDim2.new(0,W,0,FULL_H)
        main.BackgroundColor3=COLORS.Background;main.BackgroundTransparency=0.1
        main.BorderSizePixel=0;main.ClipsDescendants=false
        Instance.new("UICorner",main).CornerRadius=UDim.new(0,8)
        registerScaleTarget(main)
        loadAndClampPosition(main,"laggerGui",UDim2.new(0,10,0,160))
        _regDraggable(main,function()return UDim2.new(0,10,0,160)end)
        local mainStroke=Instance.new("UIStroke",main)
        mainStroke.Thickness=1.2;mainStroke.Color=COLORS.Accent
        mainStroke.Transparency=0.0;mainStroke.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
        trackStroke(mainStroke)
        local lgGrad=Instance.new("UIGradient",mainStroke)
        lgGrad.Color=ColorSequence.new({
            ColorSequenceKeypoint.new(0,COLORS.Accent),
            ColorSequenceKeypoint.new(0.33,Color3.fromRGB(120,255,200)),
            ColorSequenceKeypoint.new(0.66,Color3.fromRGB(150,255,180)),
            ColorSequenceKeypoint.new(1,COLORS.Accent),
        })
        trackGradient(lgGrad)
        local hdr=Instance.new("Frame",main)
        hdr.Size=UDim2.new(1,0,0,HDR_H)
        hdr.BackgroundColor3=COLORS.Surface;hdr.BackgroundTransparency=0.05;hdr.BorderSizePixel=0
        Instance.new("UICorner",hdr).CornerRadius=UDim.new(0,8)
        local hdrFill=Instance.new("Frame",hdr)
        hdrFill.Size=UDim2.new(1,0,0,9);hdrFill.Position=UDim2.new(0,0,1,-9)
        hdrFill.BackgroundColor3=COLORS.Surface;hdrFill.BackgroundTransparency=0.05;hdrFill.BorderSizePixel=0
        local dot=Instance.new("Frame",hdr)
        dot.Size=UDim2.new(0,5,0,5);dot.Position=UDim2.new(0,8,0.5,-2)
        dot.BackgroundColor3=COLORS.Accent;dot.BorderSizePixel=0
        Instance.new("UICorner",dot).CornerRadius=UDim.new(1,0);trackDot(dot)
        local titleLbl=Instance.new("TextLabel",hdr)
        titleLbl.AutoLocalize=false
        titleLbl.Size=UDim2.new(1,-30,1,0);titleLbl.Position=UDim2.new(0,18,0,0)
        titleLbl.BackgroundTransparency=1;titleLbl.Text="Server Lagger"
        titleLbl.TextColor3=COLORS.Accent;titleLbl.Font=Enum.Font.GothamSemibold
        titleLbl.TextSize=10;titleLbl.TextXAlignment=Enum.TextXAlignment.Left
        trackLabel(titleLbl)
        local tgH=Instance.new("UIGradient",titleLbl);tgH.Color=lgGrad.Color;trackGradient(tgH)
        local minBtn=Instance.new("TextButton",hdr)
        minBtn.AutoLocalize=false
        minBtn.Size=UDim2.new(0,18,0,14);minBtn.Position=UDim2.new(1,-22,0.5,-7)
        minBtn.BackgroundColor3=COLORS.Background;minBtn.BackgroundTransparency=0.15
        minBtn.Text="-";minBtn.TextColor3=COLORS.Accent
        minBtn.Font=Enum.Font.GothamBold;minBtn.TextSize=13;minBtn.BorderSizePixel=0
        Instance.new("UICorner",minBtn).CornerRadius=UDim.new(0,4);trackLabel(minBtn)
        local ms2=Instance.new("UIStroke",minBtn)
        ms2.Color=COLORS.Accent;ms2.Thickness=1;ms2.Transparency=0.4;trackStroke(ms2)
        local toggleRow=Instance.new("Frame",main)
        toggleRow.Size=UDim2.new(1,-PAD*2,0,TOGGLE_H)
        toggleRow.Position=UDim2.new(0,PAD,0,HDR_H+PAD)
        toggleRow.BackgroundTransparency=1;toggleRow.BorderSizePixel=0
        local toggleBtn=Instance.new("TextButton",toggleRow)
        toggleBtn.AutoLocalize=false
        toggleBtn.Size=UDim2.new(1,0,1,0)
        toggleBtn.BackgroundColor3=_laggerEnabled and COLORS.Accent or COLORS.Surface
        toggleBtn.BackgroundTransparency=_laggerEnabled and 0.0 or 0.08
        toggleBtn.Text=_laggerEnabled and"LAGGER ON"or"LAGGER OFF"
        toggleBtn.TextColor3=_laggerEnabled and Color3.fromRGB(10,10,10)or COLORS.Accent
        toggleBtn.Font=Enum.Font.GothamBold;toggleBtn.TextSize=12;toggleBtn.BorderSizePixel=0
        Instance.new("UICorner",toggleBtn).CornerRadius=UDim.new(0,6);trackLabel(toggleBtn)
        local tgStroke=Instance.new("UIStroke",toggleBtn)
        tgStroke.Color=COLORS.Accent;tgStroke.Thickness=1;tgStroke.Transparency=0.35;trackStroke(tgStroke)
        local content=Instance.new("Frame",main)
        content.Size=UDim2.new(1,0,0,CONTENT_H)
        content.Position=UDim2.new(0,0,0,HDR_H+PAD+TOGGLE_H+PAD)
        content.BackgroundTransparency=1;content.BorderSizePixel=0
        local ll=Instance.new("UIListLayout",content)
        ll.FillDirection=Enum.FillDirection.Vertical
        ll.HorizontalAlignment=Enum.HorizontalAlignment.Center
        ll.VerticalAlignment=Enum.VerticalAlignment.Top
        ll.Padding=UDim.new(0,GAP);ll.SortOrder=Enum.SortOrder.LayoutOrder
        local uip=Instance.new("UIPadding",content)
        uip.PaddingLeft=UDim.new(0,PAD);uip.PaddingRight=UDim.new(0,PAD)
        local IW=W-PAD*2
        local BOX_W=50
        local BOX_POS=IW-BOX_W-2
        local function makeLRow(lo,labelText)
            local f=Instance.new("Frame",content)
            f.LayoutOrder=lo;f.Size=UDim2.new(1,0,0,ROW_H)
            f.BackgroundColor3=COLORS.Surface;f.BackgroundTransparency=0.08;f.BorderSizePixel=0
            Instance.new("UICorner",f).CornerRadius=UDim.new(0,5)
            local rs=Instance.new("UIStroke",f)
            rs.Color=COLORS.Accent;rs.Thickness=1;rs.Transparency=0.65
            rs.ApplyStrokeMode=Enum.ApplyStrokeMode.Border;trackStroke(rs)
            local lbl=Instance.new("TextLabel",f)
            lbl.AutoLocalize=false;lbl.Size=UDim2.new(0.55,0,0,14)
            lbl.Position=UDim2.new(0,6,0,6);lbl.BackgroundTransparency=1
            lbl.Text=labelText;lbl.TextColor3=COLORS.Accent;trackLabel(lbl)
            lbl.Font=Enum.Font.GothamSemibold;lbl.TextSize=9
            lbl.TextXAlignment=Enum.TextXAlignment.Left
            return f
        end
        local function makeLBox(parent,xOff,defText)
            local box=Instance.new("TextBox",parent)
            box.AutoLocalize=false;box.Size=UDim2.new(0,BOX_W,0,16)
            box.Position=UDim2.new(0,xOff,0,5);box.BackgroundColor3=COLORS.Background
            box.BackgroundTransparency=0.0;box.Text=defText
            box.TextColor3=COLORS.Accent;trackLabel(box)
            box.Font=Enum.Font.GothamBold;box.TextSize=9
            box.ClearTextOnFocus=false;box.BorderSizePixel=0
            Instance.new("UICorner",box).CornerRadius=UDim.new(0,4)
            local s=Instance.new("UIStroke",box)
            s.Color=COLORS.Accent;s.Thickness=1;s.Transparency=0.55;trackStroke(s)
            return box
        end
        local r1=makeLRow(1,"Spam")
        local b1=makeLBox(r1,BOX_POS,tostring(CONFIG.LAGGER_SPAM))
        _lagSpamBox=b1
        b1.FocusLost:Connect(function()
            local v=tonumber(b1.Text)or CONFIG.LAGGER_SPAM
            CONFIG.LAGGER_SPAM=math.clamp(math.floor(v),10,270)
            b1.Text=tostring(CONFIG.LAGGER_SPAM);saveConfig()
        end)
        local r2=makeLRow(2,"Tries")
        local b2=makeLBox(r2,BOX_POS,tostring(CONFIG.LAGGER_TRIES))
        _lagTriesBox=b2
        b2.FocusLost:Connect(function()
            local v=tonumber(b2.Text)or CONFIG.LAGGER_TRIES
            CONFIG.LAGGER_TRIES=math.clamp(math.floor(v),0,10)
            b2.Text=tostring(CONFIG.LAGGER_TRIES);saveConfig()
        end)
        local r3=makeLRow(3,"Delay")
        local b3=makeLBox(r3,BOX_POS,string.format("%.1f",CONFIG.LAGGER_DELAY))
        _lagDelayBox=b3
        b3.FocusLost:Connect(function()
            local v=tonumber(b3.Text)or CONFIG.LAGGER_DELAY
            CONFIG.LAGGER_DELAY=math.clamp(v,0.1,10)
            b3.Text=string.format("%.1f",CONFIG.LAGGER_DELAY);saveConfig()
        end)
        local function _laggerGetMaxVal(val)
            if type(val)~="number"then return nil end
            return 499999/(val+2)
        end
        local function _laggerBomb()
            local maintable={}
            local spammedtable={}
            table.insert(spammedtable,{})
            local z=spammedtable[1]
            for i=1,CONFIG.LAGGER_SPAM do
                local ti={};table.insert(z,ti);z=ti
            end
            local maximum=_laggerGetMaxVal(CONFIG.LAGGER_SPAM)or 9999999
            for i=1,maximum do table.insert(maintable,spammedtable)end
            for i=1,CONFIG.LAGGER_TRIES do
                pcall(function()
                    game.RobloxReplicatedStorage.SetPlayerBlockList:FireServer(maintable)
                end)
            end
        end
        local function _syncToggleVisual()
            TweenService:Create(toggleBtn,tweenInfoFast,{
                BackgroundColor3=_laggerEnabled and COLORS.Accent or COLORS.Surface,
                BackgroundTransparency=_laggerEnabled and 0.0 or 0.08,
            }):Play()
            toggleBtn.TextColor3=_laggerEnabled and Color3.fromRGB(10,10,10)or COLORS.Accent
            toggleBtn.Text=_laggerEnabled and"LAGGER ON"or"LAGGER OFF"
        end
        local function _startLagger()
            if _laggerLoopThread then
                pcall(function()task.cancel(_laggerLoopThread)end)
                _laggerLoopThread=nil
            end
            _laggerLoopThread=task.spawn(function()
                while _laggerEnabled do
                    pcall(function()
                        game:GetService("NetworkClient"):SetOutgoingKBPSLimit(math.huge)
                    end)
                    _laggerBomb()
                    task.wait(math.max(0.1,CONFIG.LAGGER_DELAY))
                end
            end)
        end
        toggleBtn.MouseButton1Click:Connect(function()
            _laggerEnabled=not _laggerEnabled
            _syncToggleVisual()
            if _laggerEnabled then
                _startLagger()
            else
                if _laggerLoopThread then
                    pcall(function()task.cancel(_laggerLoopThread)end)
                    _laggerLoopThread=nil
                end
            end
        end)
        local laggerMinimized=false
        minBtn.MouseButton1Click:Connect(function()
            laggerMinimized=not laggerMinimized
            if laggerMinimized then
                hdrFill.Visible=false
                content.Visible=false
                TweenService:Create(main,tweenInfoMedium,{Size=UDim2.new(0,W,0,MINI_H)}):Play()
                minBtn.Text="+"
            else
                hdrFill.Visible=true
                content.Visible=true
                TweenService:Create(main,tweenInfoMedium,{Size=UDim2.new(0,W,0,FULL_H)}):Play()
                minBtn.Text="-"
            end
        end)
        makeDraggable(main,hdr,"laggerGui",function()return CONFIG.UI_LOCKED end)
        pcall(function()
            applyAccentColor(CONFIG.GUI_COLOR_R or 0,CONFIG.GUI_COLOR_G or 217,CONFIG.GUI_COLOR_B or 127)
        end)
        laggerGuiInstance=sg
        return sg
    end

    local function triggerAutoReactSteal()
        if not autoReactStealEnabled then return end
        if _autoReactStealCooldown then return end
        _autoReactStealCooldown=true
        task.spawn(function()
            local char=LP.Character
            if char then
                local tool=char:FindFirstChildOfClass("Tool")
                if tool then
                    local toolName=string.lower(tool.Name)
                    local isMedusa=string.find(toolName,"medusa")~=nil
                    local isBat=string.find(toolName,"bat")~=nil
                    if isMedusa or isBat then
                        for _=1,3 do
                            pcall(function()tool:Activate()end)
                            task.wait(0.1)
                        end
                    end
                end
            end
            task.wait(1.5)
            _autoReactStealCooldown=false
        end)
    end
    local function _reactWatchText(obj)
        local function check()
            if type(obj.Text)=="string"and string.find(string.lower(obj.Text),REACT_STEAL_KEYWORD,1,true)then
                triggerAutoReactSteal()
            end
        end
        check()
        obj:GetPropertyChangedSignal("Text"):Connect(check)
    end
    local function _reactScanGui(parent)
        for _,desc in ipairs(parent:GetDescendants())do
            if desc:IsA("TextLabel")or desc:IsA("TextButton")or desc:IsA("TextBox")then
                _reactWatchText(desc)
            end
        end
        parent.DescendantAdded:Connect(function(desc)
            if desc:IsA("TextLabel")or desc:IsA("TextButton")or desc:IsA("TextBox")then
                _reactWatchText(desc)
            end
        end)
    end
    local function startAutoReactStealWatcher()
        if _autoReactStealConn then return end
        local pg=LP:WaitForChild("PlayerGui")
        for _,gui in ipairs(pg:GetChildren())do
            _reactScanGui(gui)
        end
        _autoReactStealConn=pg.ChildAdded:Connect(function(gui)
            _reactScanGui(gui)
        end)
    end
    local function stopAutoReactStealWatcher()
        if _autoReactStealConn then
            _autoReactStealConn:Disconnect()
            _autoReactStealConn=nil
        end
    end

    local function setupFloatingPanels()
        local _ltOnTap
        lockTargetPanelGui,lockTargetPanelBtn,_ltOnTap=createFloatingPanel("LockTarget","lockPanel","LOCK_TARGET_PANEL_VISIBLE","LOCK: "..(CONFIG.LOCK_TARGET_ENABLED and"ON"or"OFF"))
        trackLabel(lockTargetPanelBtn)
        local function _syncLockPanel(state)
            lockTargetPanelBtn.Text="LOCK: "..(state and"ON"or"OFF")
        end
        if CONFIG.LOCK_TARGET_ENABLED then _syncLockPanel(true)end
        _ltOnTap(function()
            if isSwitching then return end
            local newState=not CONFIG.LOCK_TARGET_ENABLED
            if newState then
                isSwitching=true
                if AutoPlayState.enabled then apStopLoop()end
                isSwitching=false
            end
            CONFIG.LOCK_TARGET_ENABLED=newState
            lockTargetEnabled=newState
            _lockManuallyOn=newState
            _syncLockPanel(newState)
            saveConfig()
            if lockTargetEnabled then startLockTarget()else stopLockTarget()end
        end)
        local _dbOnTap
        dropBrainrotPanelGui,dropBrainrotPanelBtn,_dbOnTap=createFloatingPanel("DropBrainrot","dropBrainrotPanel","DROP_BRAINROT_PANEL_VISIBLE","DROP BRAINROT")
        _dbOnTap(function()executeDrop()end)
        local _sbOnTap
        spinbotPanelGui,spinbotPanelBtn,_sbOnTap=createFloatingPanel("Spinbot","spinbotPanel","SPINBOT_PANEL_VISIBLE","SPIN: "..(CONFIG.SPINBOT_ENABLED and"ON"or"OFF"))
        trackLabel(spinbotPanelBtn)
        local function _syncSpinPanel(state)
            spinbotPanelBtn.Text="SPIN: "..(state and"ON"or"OFF")
        end
        if CONFIG.SPINBOT_ENABLED then _syncSpinPanel(true)end
        _sbOnTap(function()
            local newState=not CONFIG.SPINBOT_ENABLED
            CONFIG.SPINBOT_ENABLED=newState
            spinbotEnabled=newState
            _syncSpinPanel(newState)
            if _spinbotBtn then setToggleVisual(_spinbotBtn,newState)end
            saveConfig()
            if spinbotEnabled then startSpinBot()else stopSpinBot()end
        end)
        local _tauntOnTap
        tauntPanelGui,tauntPanelBtn,_tauntOnTap=createFloatingPanel("Taunt","tauntPanel","TAUNT_PANEL_VISIBLE","TAUNT")
        _tauntOnTap(function()
            pcall(function()
                local TextChatService=game:GetService("TextChatService")
                TextChatService.TextChannels.RBXGeneral:SendAsync("/Looprix Is The Best")
            end)
        end)
        local STEAL_KEYWORD="someone is stealing"
        local function hasStealKeyword(text)
            if type(text)~="string"then return false end
            return string.find(string.lower(text),STEAL_KEYWORD,1,true)~=nil
        end
        local function triggerAntiSteal()
            if not antiStealEnabled then return end
            if isSwitching then return end
            if CONFIG.LOCK_TARGET_ENABLED then return end
            isSwitching=true
            if AutoPlayState.enabled then apStopLoop()end
            CONFIG.LOCK_TARGET_ENABLED=true
            lockTargetEnabled=true
            startLockTarget()
            if lockTargetPanelBtn then
                lockTargetPanelBtn.Text="LOCK: ON"
            end
            isSwitching=false
            showNotification("Anti Steal",true)
        end
        local function watchTextElement(obj)
            if hasStealKeyword(obj.Text)then triggerAntiSteal()end
            obj:GetPropertyChangedSignal("Text"):Connect(function()
                if hasStealKeyword(obj.Text)then triggerAntiSteal()end
            end)
        end
        local function scanGui(parent)
            for _,desc in ipairs(parent:GetDescendants())do
                if desc:IsA("TextLabel")or desc:IsA("TextButton")or desc:IsA("TextBox")then
                    watchTextElement(desc)
                end
            end
            parent.DescendantAdded:Connect(function(desc)
                if desc:IsA("TextLabel")or desc:IsA("TextButton")or desc:IsA("TextBox")then
                    watchTextElement(desc)
                end
            end)
        end
        startAntiStealWatcher=function()
            if _antiStealConn then return end
            local pg=LP:WaitForChild("PlayerGui")
            for _,gui in ipairs(pg:GetChildren())do scanGui(gui)end
            _antiStealConn=pg.ChildAdded:Connect(function(gui)scanGui(gui)end)
        end
        stopAntiStealWatcher=function()
            if _antiStealConn then _antiStealConn:Disconnect();_antiStealConn=nil end
        end
        antiStealEnabled=CONFIG.ANTI_STEAL_PANEL_VISIBLE or false
        if antiStealEnabled then startAntiStealWatcher()end
        local _tpOnTap
        tpDownPanelGui,tpDownPanelBtn,_tpOnTap=createFloatingPanel("TpDown","tpDownPanel","TP_DOWN_PANEL_VISIBLE","TP DOWN")
        _tpOnTap(function()tpDown()end)
        local _irOnTap
        _instantResetPanelGui,_instantResetPanelBtn,_irOnTap=createFloatingPanel("InstantReset","instantResetPanel","INSTANT_RESET_PANEL_VISIBLE","RESET")
        _irOnTap(function()doInstantReset()end)

        do
            local _mirrorConn=nil
            local _prevY={}
            local function _startMirrorWatcher()
                if _mirrorConn then return end
                _mirrorConn=RunService.Heartbeat:Connect(function()
                    if not CONFIG.MIRROR_TP_DOWN_ENABLED then return end
                    if not CONFIG.LOCK_TARGET_ENABLED then _prevY={} return end
                    local myC=LP.Character
                    local myH=myC and myC:FindFirstChild("HumanoidRootPart")
                    if not myH then return end
                    for _,p in ipairs(Players:GetPlayers()) do
                        if p~=LP and p.Character then
                            local hrp=p.Character:FindFirstChild("HumanoidRootPart")
                            if hrp then
                                local uid=p.UserId
                                local curY=hrp.Position.Y
                                local lastY=_prevY[uid]
                                if lastY then
                                    local drop=lastY-curY
                                    if drop>=(CONFIG.MIRROR_TP_DOWN_THRESHOLD or 8) then
                                        tpDown()
                                        _prevY={}
                                        return
                                    end
                                end
                                _prevY[uid]=curY
                            end
                        end
                    end
                end)
            end
            local function _stopMirrorWatcher()
                if _mirrorConn then _mirrorConn:Disconnect();_mirrorConn=nil end
                _prevY={}
            end
            _startMirrorWatcher()
            RunService.Heartbeat:Connect(function()
                if CONFIG.MIRROR_TP_DOWN_ENABLED and not _mirrorConn then
                    _startMirrorWatcher()
                elseif not CONFIG.MIRROR_TP_DOWN_ENABLED and _mirrorConn then
                    _stopMirrorWatcher()
                end
            end)
        end
        local function triggerAutoLock()
            if not autoLockEnabled2 then return end
            if isSwitching then return end
            if CONFIG.LOCK_TARGET_ENABLED then return end
            isSwitching=true
            if AutoPlayState.enabled then apStopLoop()end
            CONFIG.LOCK_TARGET_ENABLED=true
            lockTargetEnabled=true
            startLockTarget()
            pcall(function()
                if lockTargetPanelBtn then
                    lockTargetPanelBtn.Text="LOCK: ON"
                end
            end)
            isSwitching=false
            showNotification("Auto Lock",true)
            task.delay(2,function()
                if _lockManuallyOn then return end
                if not CONFIG.LOCK_TARGET_ENABLED then return end
                CONFIG.LOCK_TARGET_ENABLED=false
                lockTargetEnabled=false
                stopLockTarget()
                pcall(function()
                    if lockTargetPanelBtn then
                        lockTargetPanelBtn.Text="LOCK: OFF"
                    end
                end)
            end)
        end
        startAutoLockWatcher=function()
            if _autoLockConn then
                if _autoLockConn.Connected then return end
                _autoLockConn=nil
            end
            local _alTriggered=false
            _autoLockConn=RunService.Heartbeat:Connect(function()
                if not autoLockEnabled2 then return end
                local char=LP.Character
                if not char then _alTriggered=false return end
                local hum=char:FindFirstChildOfClass("Humanoid")
                if not hum then _alTriggered=false return end
                local state=hum:GetState()
                local ragdollStates={
                    [Enum.HumanoidStateType.Physics]=true,
                    [Enum.HumanoidStateType.Ragdoll]=true,
                    [Enum.HumanoidStateType.FallingDown]=true,
                }
                local endTime=LP:GetAttribute("RagdollEndTime")
                local isRagdoll=ragdollStates[state]or
                    (endTime and(endTime-workspace:GetServerTimeNow())>0)
                if isRagdoll then
                    if not _alTriggered then
                        _alTriggered=true
                        triggerAutoLock()
                    end
                else
                    _alTriggered=false
                end
            end)
        end
        stopAutoLockWatcher=function()
            if _autoLockConn then _autoLockConn:Disconnect();_autoLockConn=nil end
        end
        autoLockEnabled2=CONFIG.AUTO_LOCK_PANEL_VISIBLE or false
        if autoLockEnabled2 then startAutoLockWatcher()end

        do
            local _cbCooldown=false
            local _cbGen=0
            local function triggerCounterBat()
                if not CONFIG.COUNTER_BAT_ENABLED then return end
                if _cbCooldown then return end
                if isSwitching then return end
                _cbCooldown=true
                _cbGen=_cbGen+1
                task.spawn(function()
                    local char=LP.Character
                    if char then
                        local bat=nil
                        for _,v in ipairs(char:GetChildren())do
                            if v:IsA("Tool")and v.Name:lower():find("bat")then bat=v break end
                        end
                        if not bat then
                            local bp=LP:FindFirstChild("Backpack")
                            if bp then
                                for _,v in ipairs(bp:GetChildren())do
                                    if v:IsA("Tool")and v.Name:lower():find("bat")then bat=v break end
                                end
                            end
                        end
                        if bat then
                            local hum=char:FindFirstChildOfClass("Humanoid")
                            if hum and bat.Parent~=char then
                                pcall(function()hum:EquipTool(bat)end)
                            end
                        end
                    end
                    local _cbAutoEnabled=false
                    if not CONFIG.LOCK_TARGET_ENABLED and not _lockManuallyOn then
                        _cbAutoEnabled=true
                        isSwitching=true
                        if AutoPlayState.enabled then apStopLoop()end
                        CONFIG.LOCK_TARGET_ENABLED=true
                        lockTargetEnabled=true
                        startLockTarget()
                        pcall(function()
                            if lockTargetPanelBtn then lockTargetPanelBtn.Text="LOCK: ON"end
                        end)
                        isSwitching=false
                        showNotification("Counter Bat",true)
                    end
                    task.delay(0.5,function()
                        _cbCooldown=false
                        if _cbAutoEnabled and not _lockManuallyOn and CONFIG.LOCK_TARGET_ENABLED then
                            CONFIG.LOCK_TARGET_ENABLED=false
                            lockTargetEnabled=false
                            stopLockTarget()
                            pcall(function()
                                if lockTargetPanelBtn then lockTargetPanelBtn.Text="LOCK: OFF"end
                            end)
                        end
                    end)
                end)
            end
            startCounterBatWatcher=function()
                if _counterBatConn then
                    if _counterBatConn.Connected then return end
                    _counterBatConn=nil
                end
                local _cbTriggered=false
                _counterBatConn=RunService.Heartbeat:Connect(function()
                    if not CONFIG.COUNTER_BAT_ENABLED then return end
                    local char=LP.Character
                    if not char then _cbTriggered=false return end
                    local hum=char:FindFirstChildOfClass("Humanoid")
                    if not hum then _cbTriggered=false return end
                    local state=hum:GetState()
                    local ragdollStates={
                        [Enum.HumanoidStateType.Physics]=true,
                        [Enum.HumanoidStateType.Ragdoll]=true,
                        [Enum.HumanoidStateType.FallingDown]=true,
                    }
                    local endTime=LP:GetAttribute("RagdollEndTime")
                    local isRagdoll=ragdollStates[state]or
                        (endTime and(endTime-workspace:GetServerTimeNow())>0)
                    if isRagdoll then
                        if not _cbTriggered then
                            _cbTriggered=true
                            triggerCounterBat()
                        end
                    else
                        _cbTriggered=false
                    end
                end)
            end
            stopCounterBatWatcher=function()
                if _counterBatConn then _counterBatConn:Disconnect();_counterBatConn=nil end
            end
            counterBatEnabled2=CONFIG.COUNTER_BAT_ENABLED or false
            if counterBatEnabled2 then startCounterBatWatcher()end
        end
    end

    local function createSettingsTab(parent)
        local tab=createEmptyTab(parent,"Settings")
        local scroll=createElement("ScrollingFrame",{
            Size=UDim2.new(1,0,1,0),
            BackgroundTransparency=1,
            ScrollBarThickness=4,
            ScrollBarImageColor3=COLORS.Accent,
            BorderSizePixel=0,
            CanvasSize=UDim2.new(0,0,0,0),
            AutomaticCanvasSize=Enum.AutomaticSize.Y,
            ScrollingDirection=Enum.ScrollingDirection.Y,
            Parent=tab,
        })
        local scrollPad=Instance.new("UIPadding")
        scrollPad.PaddingLeft=UDim.new(0,6)
        scrollPad.PaddingRight=UDim.new(0,10)
        scrollPad.PaddingTop=UDim.new(0,6)
        scrollPad.PaddingBottom=UDim.new(0,6)
        scrollPad.Parent=scroll
        local list=createElement("UIListLayout",{
            Padding=UDim.new(0,8),
            SortOrder=Enum.SortOrder.LayoutOrder,
            HorizontalAlignment=Enum.HorizontalAlignment.Center,
            Parent=scroll
        })
        local uiContent,uiWrapper=createCategory(scroll,"[UI Settings]",true)
        uiWrapper.LayoutOrder=1
        local lockUIToggle=createToggle(uiContent,"Lock UI",CONFIG.UI_LOCKED,function(state)
            CONFIG.UI_LOCKED=state;saveConfig()
        end)
        lockUIToggle.LayoutOrder=1
        local activeHudToggle=createToggle(uiContent,"Active Functions HUD",CONFIG.ACTIVE_HUD_VISIBLE,function(state)
            CONFIG.ACTIVE_HUD_VISIBLE=state;saveConfig()
            local hud=LP.PlayerGui:FindFirstChild("LooprixActiveHUD")
            if hud then hud.Enabled=state end
        end)
        activeHudToggle.LayoutOrder=2
        local grabBarToggle=createToggle(uiContent,"Grab Bar",CONFIG.GRAB_BAR_VISIBLE,function(state)
            CONFIG.GRAB_BAR_VISIBLE=state;saveConfig()
            local statsGui=LP.PlayerGui:FindFirstChild("LooprixStats")
            if statsGui then
                local pr=statsGui:FindFirstChild("ProgressRow",true)
                if pr then pr.Visible=state end
            end
        end)
        grabBarToggle.LayoutOrder=3
        local notifToggle=createToggle(uiContent,"Notifications",CONFIG.NOTIFICATIONS_ENABLED,function(state)
            CONFIG.NOTIFICATIONS_ENABLED=state;saveConfig()
        end)
        notifToggle.LayoutOrder=4
        local postDropHaltToggle=createToggle(uiContent,"Auto Stop on Drop",CONFIG.POST_DROP_HALT_ENABLED,function(state)
            CONFIG.POST_DROP_HALT_ENABLED=state;saveConfig()
        end)
        postDropHaltToggle.LayoutOrder=7
        local snapLockSettingsToggle=createToggle(uiContent,"Lock on Drop",CONFIG.SNAP_LOCK_ENABLED,function(state)
            CONFIG.SNAP_LOCK_ENABLED=state;saveConfig()
        end)
        snapLockSettingsToggle.LayoutOrder=8
        local scaleSlider=createSlider(
            uiContent,
            "UI Scale",
            math.floor((CONFIG.UI_SCALE or 1.0)*100),
            50,
            125,
            function(intVal)
                local realScale=intVal/100
                CONFIG.UI_SCALE=realScale
                applyUIScale(realScale)
                saveConfig()
            end
        )
        scaleSlider.LayoutOrder=4
        local fovRow=createElement("Frame",{
            Size=UDim2.new(1,0,0,42),
            BackgroundColor3=COLORS.Surface,
            BackgroundTransparency=COLORS.SurfaceTransparency,
            BorderSizePixel=0,
            LayoutOrder=5,
            Parent=uiContent,
        })
        createElement("UICorner",{CornerRadius=UDim.new(0,6),Parent=fovRow})
        trackStroke(createElement("UIStroke",{
            Color=COLORS.Accent,Thickness=1,Transparency=0.5,
            ApplyStrokeMode=Enum.ApplyStrokeMode.Border,Parent=fovRow
        }))
        local fovLabel=createElement("TextLabel",{
            Size=UDim2.new(0.38,0,1,0),
            Position=UDim2.new(0,10,0,0),
            BackgroundTransparency=1,
            Text="FOV",
            TextColor3=COLORS.Accent,
            TextSize=13,
            Font=Enum.Font.GothamSemibold,
            TextXAlignment=Enum.TextXAlignment.Left,
            Parent=fovRow,
        })
        trackLabel(fovLabel)
        local fovLockBtn=Instance.new("TextButton",fovRow)
        fovLockBtn.AutoLocalize=false
        fovLockBtn.Size=UDim2.new(0,52,0,24)
        fovLockBtn.AnchorPoint=Vector2.new(1,0.5)
        fovLockBtn.Position=UDim2.new(1,-86,0.5,0)
        fovLockBtn.BackgroundColor3=CONFIG.FOV_LOCK_ENABLED and COLORS.Accent or COLORS.Background
        fovLockBtn.BackgroundTransparency=0.2
        fovLockBtn.BorderSizePixel=0
        fovLockBtn.Text=CONFIG.FOV_LOCK_ENABLED and"ON"or"OFF"
        fovLockBtn.TextColor3=COLORS.Accent
        fovLockBtn.Font=Enum.Font.GothamBold
        fovLockBtn.TextSize=12
        Instance.new("UICorner",fovLockBtn).CornerRadius=UDim.new(0,4)
        trackStroke(createElement("UIStroke",{Color=COLORS.Accent,Thickness=1,Transparency=0.3,Parent=fovLockBtn}))
        trackLabel(fovLockBtn)
        if CONFIG.FOV_LOCK_ENABLED then table.insert(_accentFrames,fovLockBtn) end
        fovLockBtn.MouseButton1Click:Connect(function()
            CONFIG.FOV_LOCK_ENABLED=not CONFIG.FOV_LOCK_ENABLED
            local on=CONFIG.FOV_LOCK_ENABLED
            fovLockBtn.Text=on and"ON"or"OFF"
            tween(fovLockBtn,tweenInfoFast,{BackgroundColor3=on and COLORS.Accent or COLORS.Background})
            if on then
                if not table.find(_accentFrames,fovLockBtn) then table.insert(_accentFrames,fovLockBtn) end
            else
                for i,f in ipairs(_accentFrames) do if f==fovLockBtn then table.remove(_accentFrames,i) break end end
            end
            saveConfig()
        end)
        local fovBox=createElement("TextBox",{
            Size=UDim2.new(0,70,0,24),
            AnchorPoint=Vector2.new(1,0.5),
            Position=UDim2.new(1,-8,0.5,0),
            BackgroundColor3=COLORS.Background,
            BackgroundTransparency=0.2,
            Text=tostring(CONFIG.FOV_VALUE or 70),
            TextColor3=COLORS.Accent,
            PlaceholderText="10–120",
            PlaceholderColor3=COLORS.TextDim,
            Font=Enum.Font.GothamBold,
            TextSize=12,
            ClearTextOnFocus=false,
            BorderSizePixel=0,
            Parent=fovRow,
        })
        trackLabel(fovBox)
        createElement("UICorner",{CornerRadius=UDim.new(0,5),Parent=fovBox})
        trackStroke(createElement("UIStroke",{Color=COLORS.Accent,Thickness=1,Transparency=0.4,Parent=fovBox}))
        fovBox.FocusLost:Connect(function()
            local v=tonumber(fovBox.Text)
            if v then
                CONFIG.FOV_VALUE=math.clamp(math.floor(v),10,120)
            end
            fovBox.Text=tostring(CONFIG.FOV_VALUE or 70)
            pcall(function()
                local cam=workspace.CurrentCamera
                if cam then cam.FieldOfView=CONFIG.FOV_VALUE end
            end)
            saveConfig()
        end)
        local colorRow=createElement("Frame",{
            Size=UDim2.new(1,0,0,50),
            BackgroundColor3=COLORS.Surface,
            BackgroundTransparency=COLORS.SurfaceTransparency,
            BorderSizePixel=0,
            LayoutOrder=6,
            Parent=uiContent,
        })
        createElement("UICorner",{CornerRadius=UDim.new(0,6),Parent=colorRow})
        local crStroke=createElement("UIStroke",{Color=COLORS.Accent,Thickness=1,Transparency=0.5,
            ApplyStrokeMode=Enum.ApplyStrokeMode.Border,Parent=colorRow})
        trackStroke(crStroke)
        local crLabel=createElement("TextLabel",{
            Size=UDim2.new(1,-12,0,16),
            Position=UDim2.new(0,8,0,4),
            BackgroundTransparency=1,
            Text="GUI Color  (#RRGGBB)",
            TextColor3=COLORS.Accent,
            TextSize=12,
            Font=Enum.Font.GothamSemibold,
            TextXAlignment=Enum.TextXAlignment.Left,
            Parent=colorRow,
        })
        trackLabel(crLabel)
        local crPreview=createElement("Frame",{
            Size=UDim2.new(0,18,0,18),
            AnchorPoint=Vector2.new(1,0),
            Position=UDim2.new(1,-8,0,4),
            BackgroundColor3=COLORS.Accent,
            BorderSizePixel=0,
            Parent=colorRow,
        })
        createElement("UICorner",{CornerRadius=UDim.new(0,4),Parent=crPreview})
        trackFrame(crPreview)
        local hexBox=createElement("TextBox",{
            Size=UDim2.new(1,-16,0,22),
            Position=UDim2.new(0,8,0,24),
            BackgroundColor3=COLORS.Background,
            BackgroundTransparency=0.3,
            Text=string.format("#%02X%02X%02X",CONFIG.GUI_COLOR_R,CONFIG.GUI_COLOR_G,CONFIG.GUI_COLOR_B),
            TextColor3=COLORS.Accent,
            PlaceholderText="#00D97F",
            PlaceholderColor3=COLORS.TextDim,
            TextSize=12,
            Font=Enum.Font.GothamBold,
            BorderSizePixel=0,
            ClearTextOnFocus=false,
            Parent=colorRow,
        })
        trackLabel(hexBox)
        trackLabel(hexBox)
        createElement("UICorner",{CornerRadius=UDim.new(0,5),Parent=hexBox})
        local hexStroke=createElement("UIStroke",{Color=COLORS.Accent,Thickness=1,Transparency=0.4,Parent=hexBox})
        trackStroke(hexStroke)
        trackLabel(hexBox)
        local function applyHex(raw)
            local hex=raw:gsub("^#",""):upper()
            if#hex==6 then
                local r=tonumber(hex:sub(1,2),16)
                local g=tonumber(hex:sub(3,4),16)
                local b=tonumber(hex:sub(5,6),16)
                if r and g and b then
                    applyAccentColor(r,g,b)
                    crPreview.BackgroundColor3=Color3.fromRGB(r,g,b)
                    hexBox.Text="#"..hex
                    saveConfig()
                    return
                end
            end
            hexBox.Text=string.format("#%02X%02X%02X",CONFIG.GUI_COLOR_R,CONFIG.GUI_COLOR_G,CONFIG.GUI_COLOR_B)
        end
        hexBox.FocusLost:Connect(function()
            applyHex(hexBox.Text)
        end)
        local cvContent,cvWrapper=createCategory(scroll,"[Combat Values]",true)
        cvWrapper.LayoutOrder=2
        local spinbotSpeedInput=createNumberInput(cvContent,"Spinbot Speed",CONFIG.SPINBOT_SPEED,1,100,function(value)
            CONFIG.SPINBOT_SPEED=value
        end)
        spinbotSpeedInput.LayoutOrder=4
        local lockSpeedInput=createNumberInput(cvContent,"Lock Target Speed",CONFIG.LOCK_TARGET_SPEED,1,200,function(value)
            CONFIG.LOCK_TARGET_SPEED=value
        end)
        lockSpeedInput.LayoutOrder=5
        local mirrorTpDownThreshInput=createNumberInput(cvContent,"Mirror Tp Down Threshold",CONFIG.MIRROR_TP_DOWN_THRESHOLD,5,100,function(value)
            CONFIG.MIRROR_TP_DOWN_THRESHOLD=value
            saveConfig()
        end)
        mirrorTpDownThreshInput.LayoutOrder=6
        local tvContent,tvWrapper=createCategory(scroll,"[Tool Values]",true)
        tvWrapper.LayoutOrder=3
        local medusaRangeInput=createNumberInput(tvContent,"Medusa Range",CONFIG.AUTO_MEDUSA_RANGE,1,50,function(value)
            CONFIG.AUTO_MEDUSA_RANGE=value
            if medusaCircle then medusaCircle.Radius=value end
        end)
        medusaRangeInput.LayoutOrder=1
        local igDistInput=createNumberInput(tvContent,"Steal Distance",CONFIG.AUTO_STEAL_ACTIVATION_DIST,1,9999,function(value)
            CONFIG.AUTO_STEAL_ACTIVATION_DIST=value
        end,true)
        igDistInput.LayoutOrder=2
        local jbGravityInput=createNumberInput(tvContent,"Jump Gravity %",CONFIG.JUMP_BOOST_GRAVITY_PERCENT,1,130,function(value)
            CONFIG.JUMP_BOOST_GRAVITY_PERCENT=value
            saveConfig()
            if _galaxyEnabled then _setupGalaxyForce();_adjustGalaxyJump()end
        end)
        jbGravityInput.LayoutOrder=3
        local jbHopPowerInput=createNumberInput(tvContent,"Hop Power",CONFIG.JUMP_BOOST_HOP_POWER,1,100,function(value)
            CONFIG.JUMP_BOOST_HOP_POWER=value
            saveConfig()
        end)
        jbHopPowerInput.LayoutOrder=4
        local stealDurInput=createNumberInput(tvContent,"Steal Duration",CONFIG.AUTO_STEAL_DURATION,0.1,10,function(value)
            CONFIG.AUTO_STEAL_DURATION=value
            saveConfig()
        end,true)
        stealDurInput.LayoutOrder=5
        return tab
    end

    local function createBindsTab(parent)
        local tab=createEmptyTab(parent,"Binds")
        local scroll=createElement("ScrollingFrame",{
            Size=UDim2.new(1,0,1,0),
            BackgroundTransparency=1,
            ScrollBarThickness=4,
            ScrollBarImageColor3=COLORS.Accent,
            BorderSizePixel=0,
            CanvasSize=UDim2.new(0,0,0,0),
            AutomaticCanvasSize=Enum.AutomaticSize.Y,
            ScrollingDirection=Enum.ScrollingDirection.Y,
            Parent=tab,
        })
        local scrollPad=Instance.new("UIPadding")
        scrollPad.PaddingLeft=UDim.new(0,6)
        scrollPad.PaddingRight=UDim.new(0,10)
        scrollPad.PaddingTop=UDim.new(0,6)
        scrollPad.PaddingBottom=UDim.new(0,6)
        scrollPad.Parent=scroll
        local list=createElement("UIListLayout",{
            Padding=UDim.new(0,10),
            SortOrder=Enum.SortOrder.LayoutOrder,
            Parent=scroll
        })
        local function kb(label,cfgKey,order)
            local w=createKeybindButton(scroll,label,CONFIG[cfgKey],function(key)
                CONFIG[cfgKey]=key;saveConfig()
            end)
            w.LayoutOrder=order
        end
        kb("Toggle GUI","TOGGLE_GUI_KEYBIND",1)
        kb("Auto Bat","AUTO_BAT_KEYBIND",2)
        kb("Spin Bot","SPINBOT_KEYBIND",4)
        kb("Lock Target","LOCK_TARGET_KEYBIND",5)
        kb("Drop Brainrot","DROP_BRAINROT_KEYBIND",6)
        kb("Auto Play","AUTO_PLAY_KEYBIND",8)
        kb("Auto Walk","AUTO_WALK_KEYBIND",9)
        kb("Auto Lock","AUTO_LOCK_KEYBIND",11)
        kb("Tp Down","TP_DOWN_KEYBIND",12)
        kb("Speed Preset","SPEED_PRESET_KEYBIND",13)
        kb("Instant Reset","INSTANT_RESET_KEYBIND",14)
        return tab
    end

    local function createPerformanceTab(parent)
        local tab=createEmptyTab(parent,"Performance")
        local scroll=createElement("ScrollingFrame",{
            Size=UDim2.new(1,0,1,0),
            BackgroundTransparency=1,
            ScrollBarThickness=4,
            ScrollBarImageColor3=COLORS.Accent,
            BorderSizePixel=0,
            CanvasSize=UDim2.new(0,0,0,0),
            AutomaticCanvasSize=Enum.AutomaticSize.Y,
            ScrollingDirection=Enum.ScrollingDirection.Y,
            Parent=tab,
        })
        local scrollPad=Instance.new("UIPadding")
        scrollPad.PaddingLeft=UDim.new(0,6)
        scrollPad.PaddingRight=UDim.new(0,10)
        scrollPad.PaddingTop=UDim.new(0,6)
        scrollPad.PaddingBottom=UDim.new(0,6)
        scrollPad.Parent=scroll
        local list=createElement("UIListLayout",{
            Padding=UDim.new(0,8),
            SortOrder=Enum.SortOrder.LayoutOrder,
            HorizontalAlignment=Enum.HorizontalAlignment.Center,
            Parent=scroll
        })
        local visContent,visWrapper=createCategory(scroll,"[Visuals]",true)
        visWrapper.LayoutOrder=1
        local espToggle=createToggle(visContent,"Player ESP",CONFIG.ESP_ENABLED,function(state)
            CONFIG.ESP_ENABLED=state;espEnabled=state;saveConfig()
            if state then startESP()else stopESP()end
        end)
        espToggle.LayoutOrder=1
        local harderHitToggle=createToggle(visContent,"Harder Hit",CONFIG.HARDER_HIT_ENABLED,function(state)
            CONFIG.HARDER_HIT_ENABLED=state;saveConfig()
            if state then startHarderHitAnim()else stopHarderHitAnim()end
        end)
        harderHitToggle.LayoutOrder=4
        local perfContent,perfWrapper=createCategory(scroll,"[Performance]",true)
        perfWrapper.LayoutOrder=2
        local noCollisionToggle=createToggle(perfContent,"No Player Collision",CONFIG.NO_COLLISION_ENABLED,function(state)
            CONFIG.NO_COLLISION_ENABLED=state;saveConfig()
            if state then startNoCollision()else stopNoCollision()end
        end)
        noCollisionToggle.LayoutOrder=2
        local autoTpDownToggle=createToggle(perfContent,"Auto Tp Down",CONFIG.AUTO_TP_DOWN_ENABLED,function(state)
            CONFIG.AUTO_TP_DOWN_ENABLED=state;saveConfig()
            showNotification("Auto Tp Down",state)
        end)
        autoTpDownToggle.LayoutOrder=3
        local mirrorTpDownToggle=createToggle(perfContent,"Mirror Tp Down",CONFIG.MIRROR_TP_DOWN_ENABLED,function(state)
            CONFIG.MIRROR_TP_DOWN_ENABLED=state
            saveConfig()
            showNotification("Mirror Tp Down",state)
        end)
        mirrorTpDownToggle.LayoutOrder=4
        local laggerGuiToggle=createToggle(perfContent,"Server Lagger",CONFIG.LAGGER_GUI_VISIBLE,function(state)
            CONFIG.LAGGER_GUI_VISIBLE=state;saveConfig()
            if laggerGuiInstance then laggerGuiInstance.Enabled=state end
            if not state and _laggerEnabled then
                _laggerEnabled=false
                if _laggerLoopThread then
                    pcall(function()task.cancel(_laggerLoopThread)end)
                    _laggerLoopThread=nil
                end
            end
        end)
        laggerGuiToggle.LayoutOrder=5
        return tab
    end

    local function createDuelTab(parent)
        local tab=createEmptyTab(parent,"Duel")
        local scroll=createElement("ScrollingFrame",{
            Size=UDim2.new(1,0,1,0),
            BackgroundTransparency=1,
            ScrollBarThickness=4,
            ScrollBarImageColor3=COLORS.Accent,
            BorderSizePixel=0,
            CanvasSize=UDim2.new(0,0,0,0),
            AutomaticCanvasSize=Enum.AutomaticSize.Y,
            ScrollingDirection=Enum.ScrollingDirection.Y,
            Parent=tab,
        })
        local scrollPad=Instance.new("UIPadding")
        scrollPad.PaddingLeft=UDim.new(0,6)
        scrollPad.PaddingRight=UDim.new(0,10)
        scrollPad.PaddingTop=UDim.new(0,6)
        scrollPad.PaddingBottom=UDim.new(0,6)
        scrollPad.Parent=scroll
        local list=createElement("UIListLayout",{
            Padding=UDim.new(0,8),
            SortOrder=Enum.SortOrder.LayoutOrder,
            HorizontalAlignment=Enum.HorizontalAlignment.Center,
            Parent=scroll
        })
        local combatContent,combatWrapper=createCategory(scroll,"[Combat]",true)
        combatWrapper.LayoutOrder=1
        local autoBatToggle,_autoBatBtn=createToggle(combatContent,"Auto Bat",CONFIG.AUTO_BAT_ENABLED,function(state)
            CONFIG.AUTO_BAT_ENABLED=state;attacking=state;saveConfig()
            if state then autoAttack()end
        end)
        autoBatToggle.LayoutOrder=1
        table.insert(_duelToggleBtns,{btn=_autoBatBtn,default=false})
        local function makeMutualToggle(parent,labelText,initState,lo)
            local container=createElement("Frame",{
                Size=UDim2.new(1,0,0,34),
                BackgroundColor3=COLORS.Surface,
                BackgroundTransparency=COLORS.SurfaceTransparency,
                BorderSizePixel=0,
                LayoutOrder=lo,
                Parent=parent,
            })
            createElement("UICorner",{CornerRadius=UDim.new(0,6),Parent=container})
            trackStroke(createElement("UIStroke",{Color=COLORS.Accent,Thickness=1,Transparency=0.5,
                ApplyStrokeMode=Enum.ApplyStrokeMode.Border,Parent=container}))
            createElement("TextLabel",{
                Size=UDim2.new(1,-78,1,0),
                Position=UDim2.new(0,10,0,0),
                BackgroundTransparency=1,
                Text=labelText,
                TextColor3=COLORS.Accent,
                TextSize=13,
                Font=Enum.Font.GothamSemibold,
                TextXAlignment=Enum.TextXAlignment.Left,
                Parent=container,
            })
            trackLabel(container)
            local btn=createElement("TextButton",{
                Size=UDim2.new(0,52,0,24),
                AnchorPoint=Vector2.new(1,0.5),
                Position=UDim2.new(1,-8,0.5,0),
                BackgroundColor3=initState and COLORS.Accent or COLORS.Background,
                BackgroundTransparency=0.2,
                Text=initState and"ON"or"OFF",
                TextColor3=COLORS.Accent,
                TextSize=12,
                Font=Enum.Font.GothamBold,
                BorderSizePixel=0,
                Parent=container,
            })
            trackLabel(btn)
            createElement("UICorner",{CornerRadius=UDim.new(0,4),Parent=btn})
            trackStroke(createElement("UIStroke",{Color=COLORS.Accent,Thickness=1,Transparency=0.3,Parent=btn}))
            if initState then table.insert(_accentFrames,btn)end
            return container,btn
        end
        local spinbotToggle,_spinbotBtnLocal=createToggle(combatContent,"Spin Bot",CONFIG.SPINBOT_ENABLED,function(state)
            CONFIG.SPINBOT_ENABLED=state
            spinbotEnabled=state
            saveConfig()
            if _spinbotBtn then setToggleVisual(_spinbotBtn,state)end
            showNotification("Spin Bot",state)
            if state then startSpinBot()else stopSpinBot()end
        end)
        spinbotToggle.LayoutOrder=3
        _spinbotBtn=_spinbotBtnLocal
        table.insert(_duelToggleBtns,{btn=_spinbotBtn,default=false})
        local antiRagdollToggle,_antiRagBtn=createToggle(combatContent,"Anti Ragdoll",CONFIG.ANTIRAGDOLL_ENABLED,function(state)
            CONFIG.ANTIRAGDOLL_ENABLED=state;saveConfig();toggleAntiRagdoll(state)
        end)
        antiRagdollToggle.LayoutOrder=4
        table.insert(_duelToggleBtns,{btn=_antiRagBtn,default=false})
        local antiDieToggle,_antiDieBtn=createToggle(combatContent,"Anti Die",CONFIG.ANTI_DIE_ENABLED,function(state)
            CONFIG.ANTI_DIE_ENABLED=state;antiDieEnabled=state;saveConfig()
            if state then activateAntiDie()else deactivateAntiDie()end
        end)
        antiDieToggle.LayoutOrder=5
        table.insert(_duelToggleBtns,{btn=_antiDieBtn,default=true})
        local counterBatToggle,_ctrBatBtn=createToggle(combatContent,"Counter Bat",CONFIG.COUNTER_BAT_ENABLED,function(state)
            CONFIG.COUNTER_BAT_ENABLED=state;counterBatEnabled2=state;saveConfig()
            if state then
                if startCounterBatWatcher then startCounterBatWatcher()end
            else
                if stopCounterBatWatcher then stopCounterBatWatcher()end
            end
        end)
        counterBatToggle.LayoutOrder=6
        table.insert(_duelToggleBtns,{btn=_ctrBatBtn,default=false})
        local mobContent,mobWrapper=createCategory(scroll,"[Mobility]",true)
        mobWrapper.LayoutOrder=2
        local unwalkToggle,_unwalkBtn=createToggle(mobContent,"Unwalk",CONFIG.UNWALK_ENABLED,function(state)
            CONFIG.UNWALK_ENABLED=state;unwalkEnabled=state;saveConfig()
            if state then startUnwalk()else stopUnwalk()end
        end)
        unwalkToggle.LayoutOrder=1
        table.insert(_duelToggleBtns,{btn=_unwalkBtn,default=false})
        local infJumpToggle,_infJumpBtn=createToggle(mobContent,"Infinity Jump",CONFIG.INF_JUMP_ENABLED,function(state)
            CONFIG.INF_JUMP_ENABLED=state;infJumpEnabled=state;saveConfig()
            if state then startInfJump()else stopInfJump()end
        end)
        infJumpToggle.LayoutOrder=2
        table.insert(_duelToggleBtns,{btn=_infJumpBtn,default=false})
        local jumpBoostToggle,_jbBtn=createToggle(mobContent,"Jump Boost",CONFIG.JUMP_BOOST_ENABLED,function(state)
            CONFIG.JUMP_BOOST_ENABLED=state;jumpBoostEnabled=state;saveConfig()
            if state then startJumpBoost()else stopJumpBoost()end
        end)
        jumpBoostToggle.LayoutOrder=3
        table.insert(_duelToggleBtns,{btn=_jbBtn,default=false})
        local autoWalkPanelToggle,_autoWalkBtn=createToggle(mobContent,"Auto Walk",CONFIG.AUTO_WALK_PANEL_VISIBLE,function(state)
            CONFIG.AUTO_WALK_PANEL_VISIBLE=state;saveConfig()
            if awGuiInstance then awGuiInstance.Enabled=state end
            if not state then awStopLoop();AW.enabled=false end
        end)
        autoWalkPanelToggle.LayoutOrder=5
        table.insert(_duelToggleBtns,{btn=_autoWalkBtn,default=false})
        local tpDownToggle,_tpDownBtn=createToggle(mobContent,"Tp Down",CONFIG.TP_DOWN_PANEL_VISIBLE,function(state)
            CONFIG.TP_DOWN_PANEL_VISIBLE=state;saveConfig()
            if tpDownPanelGui then tpDownPanelGui.Enabled=state end
        end)
        tpDownToggle.LayoutOrder=6
        table.insert(_duelToggleBtns,{btn=_tpDownBtn,default=false})
        local instantResetToggle,_irBtn=createToggle(mobContent,"Instant Reset",CONFIG.INSTANT_RESET_PANEL_VISIBLE,function(state)
            CONFIG.INSTANT_RESET_PANEL_VISIBLE=state;saveConfig()
            if _instantResetPanelGui then _instantResetPanelGui.Enabled=state end
        end)
        instantResetToggle.LayoutOrder=7
        table.insert(_duelToggleBtns,{btn=_irBtn,default=false})
        local toolsContent,toolsWrapper=createCategory(scroll,"[Tools]",true)
        toolsWrapper.LayoutOrder=3
        local autoMedusaToggle,_autoMedBtn=createToggle(toolsContent,"Auto Medusa",CONFIG.AUTO_MEDUSA_ENABLED,function(state)
            CONFIG.AUTO_MEDUSA_ENABLED=state;autoMedusaEnabled=state;saveConfig()
            if state then startAutoMedusa()else stopAutoMedusa()end
        end)
        autoMedusaToggle.LayoutOrder=1
        table.insert(_duelToggleBtns,{btn=_autoMedBtn,default=false})
        local medusaCounterToggle,_medCtrBtn=createToggle(toolsContent,"Medusa Counter",CONFIG.MEDUSA_COUNTER_ENABLED,function(state)
            CONFIG.MEDUSA_COUNTER_ENABLED=state;medusaCounterEnabled=state;saveConfig()
            if state then setupMedusaCounter(character)else stopMedusaCounter()end
        end)
        medusaCounterToggle.LayoutOrder=2
        table.insert(_duelToggleBtns,{btn=_medCtrBtn,default=false})
        local autoStealToggle,_igBtn=createToggle(toolsContent,"Auto Steal",CONFIG.AUTO_STEAL_ENABLED,function(state)
            CONFIG.AUTO_STEAL_ENABLED=state;autoStealGrabEnabled=state;saveConfig()
            if state then startAutoSteal()else stopAutoSteal()end
        end)
        autoStealToggle.LayoutOrder=3
        table.insert(_duelToggleBtns,{btn=_igBtn,default=false})
        local dropBrainrotPanelToggle,_dropBtn=createToggle(toolsContent,"Drop Brainrot",CONFIG.DROP_BRAINROT_PANEL_VISIBLE,function(state)
            CONFIG.DROP_BRAINROT_PANEL_VISIBLE=state;saveConfig()
            if dropBrainrotPanelGui then dropBrainrotPanelGui.Enabled=state end
        end)
        dropBrainrotPanelToggle.LayoutOrder=4
        table.insert(_duelToggleBtns,{btn=_dropBtn,default=false})
        local lockTargetPanelToggle,_ltBtn=createToggle(toolsContent,"Lock Target",CONFIG.LOCK_TARGET_PANEL_VISIBLE,function(state)
            CONFIG.LOCK_TARGET_PANEL_VISIBLE=state;saveConfig()
            if lockTargetPanelGui then lockTargetPanelGui.Enabled=state end
        end)
        lockTargetPanelToggle.LayoutOrder=5
        table.insert(_duelToggleBtns,{btn=_ltBtn,default=false})
        local speedGuiToggle,_speedGuiBtn=createToggle(toolsContent,"Speed Booster",CONFIG.SPEED_GUI_VISIBLE,function(state)
            CONFIG.SPEED_GUI_VISIBLE=state;speedGuiEnabled=state;saveConfig()
            if speedGuiInstance then speedGuiInstance.Enabled=state end
        end)
        speedGuiToggle.LayoutOrder=6
        local autoPlayGuiToggle,_apGuiBtn=createToggle(toolsContent,"Auto Play",CONFIG.AUTO_PLAY_GUI_VISIBLE,function(state)
            CONFIG.AUTO_PLAY_GUI_VISIBLE=state;saveConfig()
            if apGuiInstance then apGuiInstance.Enabled=state end
            if not state and AutoPlayState.enabled then
                apStopLoop()
            end
        end)
        autoPlayGuiToggle.LayoutOrder=7
        table.insert(_duelToggleBtns,{btn=_apGuiBtn,default=false})
        local spinbotPanelToggle,_sbPanelBtn=createToggle(toolsContent,"Spin Bot",CONFIG.SPINBOT_PANEL_VISIBLE,function(state)
            CONFIG.SPINBOT_PANEL_VISIBLE=state;saveConfig()
            if spinbotPanelGui then spinbotPanelGui.Enabled=state end
            if not state and CONFIG.SPINBOT_ENABLED then
                CONFIG.SPINBOT_ENABLED=false;spinbotEnabled=false
                stopSpinBot()
                if spinbotPanelBtn then
                    spinbotPanelBtn.Text="SPIN: OFF"
                end
            end
        end)
        spinbotPanelToggle.LayoutOrder=8
        table.insert(_duelToggleBtns,{btn=_sbPanelBtn,default=false})
        local tauntPanelToggle,_tauntBtn=createToggle(toolsContent,"Taunt",CONFIG.TAUNT_PANEL_VISIBLE,function(state)
            CONFIG.TAUNT_PANEL_VISIBLE=state;saveConfig()
            if tauntPanelGui then tauntPanelGui.Enabled=state end
        end)
        tauntPanelToggle.LayoutOrder=9
        table.insert(_duelToggleBtns,{btn=_tauntBtn,default=false})
        local antiStealToggle,_asBtn=createToggle(toolsContent,"Anti Steal",CONFIG.ANTI_STEAL_PANEL_VISIBLE,function(state)
            CONFIG.ANTI_STEAL_PANEL_VISIBLE=state
            antiStealEnabled=state
            saveConfig()
            if state then startAntiStealWatcher()else stopAntiStealWatcher()end
        end)
        antiStealToggle.LayoutOrder=10
        table.insert(_duelToggleBtns,{btn=_asBtn,default=false})
        local autoLockToggle,_alBtn=createToggle(toolsContent,"Auto Lock",CONFIG.AUTO_LOCK_PANEL_VISIBLE,function(state)
            CONFIG.AUTO_LOCK_PANEL_VISIBLE=state
            autoLockEnabled2=state
            saveConfig()
            if state then startAutoLockWatcher()else stopAutoLockWatcher()end
        end)
        autoLockToggle.LayoutOrder=11
        table.insert(_duelToggleBtns,{btn=_alBtn,default=false})
        local autoReactToggle,_arBtn=createToggle(toolsContent,"Auto React Steal",CONFIG.AUTO_REACT_STEAL_ENABLED,function(state)
            CONFIG.AUTO_REACT_STEAL_ENABLED=state
            autoReactStealEnabled=state
            saveConfig()
            if state then startAutoReactStealWatcher()else stopAutoReactStealWatcher()end
        end)
        autoReactToggle.LayoutOrder=13
        table.insert(_duelToggleBtns,{btn=_arBtn,default=false})
        local resetWrapper=createElement("Frame",{
            Size=UDim2.new(1,0,0,36),
            BackgroundTransparency=1,
            LayoutOrder=99,
            Parent=scroll,
        })
        local resetPad=Instance.new("UIPadding",resetWrapper)
        resetPad.PaddingLeft=UDim.new(0,6)
        resetPad.PaddingRight=UDim.new(0,6)
        local resetBtn=Instance.new("TextButton",resetWrapper)
        resetBtn.AutoLocalize=false
        resetBtn.Size=UDim2.new(1,0,1,0)
        resetBtn.BackgroundColor3=COLORS.Surface
        resetBtn.BackgroundTransparency=0.05
        resetBtn.BorderSizePixel=0
        resetBtn.Text="[ Reset Config ]"
        resetBtn.TextColor3=COLORS.Red
        resetBtn.Font=Enum.Font.GothamBold
        resetBtn.TextSize=12
        Instance.new("UICorner",resetBtn).CornerRadius=UDim.new(0,6)
        local resetStroke=Instance.new("UIStroke",resetBtn)
        resetStroke.Color=COLORS.Red
        resetStroke.Thickness=1
        resetStroke.Transparency=0.4
        resetStroke.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
        resetBtn.MouseButton1Click:Connect(function()
            TweenService:Create(resetBtn,TweenInfo.new(0.1,Enum.EasingStyle.Quad),{
                BackgroundColor3=COLORS.Red,BackgroundTransparency=0.1
            }):Play()
            resetBtn.TextColor3=Color3.fromRGB(255,255,255)
            task.delay(0.25,function()
                TweenService:Create(resetBtn,TweenInfo.new(0.2,Enum.EasingStyle.Quad),{
                    BackgroundColor3=COLORS.Surface,BackgroundTransparency=0.05
                }):Play()
                resetBtn.TextColor3=COLORS.Red
            end)
            pcall(stopSpinBot)
            pcall(stopUnwalk)
            pcall(stopESP)
            pcall(stopLockTarget)
            pcall(stopInfJump)
            pcall(stopAutoMedusa)
            pcall(stopMedusaCounter)
            pcall(stopAutoSteal)
            pcall(stopNoCollision)
            pcall(stopHarderHitAnim)
            pcall(deactivateAntiDie)
            pcall(stopAutoReactStealWatcher)
            pcall(stopAntiStealWatcher)
            pcall(stopAutoLockWatcher)
            pcall(apStopLoop)
            pcall(awStopLoop)
            pcall(stopAntiRagdollV2)
            local defaults={
                LOCK_TARGET_PANEL_VISIBLE=false,DROP_BRAINROT_PANEL_VISIBLE=false,
                SPINBOT_PANEL_VISIBLE=false,TAUNT_PANEL_VISIBLE=false,
                ANTI_STEAL_PANEL_VISIBLE=false,AUTO_LOCK_PANEL_VISIBLE=false,
                TP_DOWN_PANEL_VISIBLE=false,AUTO_WALK_PANEL_VISIBLE=false,
                AUTO_PLAY_GUI_VISIBLE=false,
                LAGGER_GUI_VISIBLE=false,
                INSTANT_RESET_PANEL_VISIBLE=false,
                ACTIVE_HUD_VISIBLE=false,GRAB_BAR_VISIBLE=true,
                AUTO_BAT_ENABLED=false,SPINBOT_ENABLED=false,
                ANTIRAGDOLL_ENABLED=false,
                UNWALK_ENABLED=false,ESP_ENABLED=false,INF_JUMP_ENABLED=false,
                LOCK_TARGET_ENABLED=false,
                AUTO_MEDUSA_ENABLED=false,MEDUSA_COUNTER_ENABLED=false,
                AUTO_STEAL_ENABLED=false,ANTI_DIE_ENABLED=true,UI_LOCKED=false,
                JUMP_BOOST_ENABLED=false,JUMP_BOOST_GRAVITY_PERCENT=70,JUMP_BOOST_HOP_POWER=35,JUMP_BOOST_HOP_COOLDOWN=0.08,
                NO_COLLISION_ENABLED=false,COUNTER_BAT_ENABLED=false,
                HARDER_HIT_ENABLED=false,
                TP_DOWN_ENABLED=false,AUTO_TP_DOWN_ENABLED=false,
                AUTO_REACT_STEAL_ENABLED=false,
                NOTIFICATIONS_ENABLED=false,FOV_LOCK_ENABLED=false,
                POST_DROP_HALT_ENABLED=false,SNAP_LOCK_ENABLED=false,SPINBOT_SPEED=30,LOCK_TARGET_SPEED=55,
                LOCK_TARGET_3D_DISTANCE=10,AUTO_MEDUSA_RANGE=5,
                AUTO_STEAL_ACTIVATION_DIST=25,FOV_VALUE=70,
                _guiPositions=nil,_autoPlayOffsets=nil,_apBasePositions=nil,
            }
            for k,v in pairs(defaults)do CONFIG[k]=v end
            CONFIG.SPEED_PRESET="normal"
            CONFIG.SPEED_VALUE=CONFIG.PRESET_NORMAL_SPEED
            CONFIG.STEAL_SPEED_VALUE=CONFIG.PRESET_NORMAL_STEAL
            if _speedValBox then _speedValBox.Text=tostring(CONFIG.SPEED_VALUE)end
            if _stealValBox then _stealValBox.Text=tostring(CONFIG.STEAL_SPEED_VALUE)end
            CONFIG.LAGGER_SPAM=270
            CONFIG.LAGGER_TRIES=1
            CONFIG.LAGGER_DELAY=0.3
            if _lagSpamBox then _lagSpamBox.Text=tostring(CONFIG.LAGGER_SPAM)end
            if _lagTriesBox then _lagTriesBox.Text=tostring(CONFIG.LAGGER_TRIES)end
            if _lagDelayBox then _lagDelayBox.Text=string.format("%.1f",CONFIG.LAGGER_DELAY)end
            activateAntiDie();antiDieEnabled=true
            antiStealEnabled=false
            autoLockEnabled2=false
            for _,entry in ipairs(_duelToggleBtns)do
                pcall(setToggleVisual,entry.btn,entry.default)
            end
            for _,gui in ipairs({
                lockTargetPanelGui,dropBrainrotPanelGui,
                spinbotPanelGui,tauntPanelGui,
                tpDownPanelGui,awGuiInstance,apGuiInstance,
                laggerGuiInstance,
                _instantResetPanelGui,
            })do
                pcall(function()if gui then gui.Enabled=false end end)
            end
            _laggerEnabled=false
            if _laggerLoopThread then
                pcall(function()task.cancel(_laggerLoopThread)end)
                _laggerLoopThread=nil
            end
            task.defer(function()
                for _,reg in ipairs(_draggableRegistry)do
                    pcall(function()
                        if reg.frame and reg.frame.Parent then
                            reg.frame.Position=reg.defaultFn()
                        end
                    end)
                end
                if mainFrame and mainFrame.Parent then
                    local vp=workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920,1080)
                    local mw=mainFrame and mainFrame.AbsoluteSize.X or 450
                    local mh=mainFrame and mainFrame.AbsoluteSize.Y or 500
                    mainFrame.Position=UDim2.fromOffset(
                        math.floor((vp.X-mw)/2),
                        math.floor((vp.Y-mh)/2)
                    )
                    CONFIG._guiPositions=CONFIG._guiPositions or{}
                    CONFIG._guiPositions["main"]={
                        scaleX=0,scaleY=0,
                        offsetX=mainFrame.Position.X.Offset,
                        offsetY=mainFrame.Position.Y.Offset,
                    }
                end
            end)
            saveConfig()
            showNotification("Config Reset",false)
        end)
        return tab
    end

    local function toggleGui()
        guiVisible=not guiVisible
        if mainFrame then mainFrame.Visible=guiVisible end
        CONFIG.MAIN_GUI_VISIBLE=guiVisible
        saveConfig()
    end

    local function createGui()
        screenGui=createElement("ScreenGui",{
            Name="LooprixV2",
            ResetOnSpawn=false,
            DisplayOrder=999999,
            ZIndexBehavior=Enum.ZIndexBehavior.Global,
            Parent=LP.PlayerGui,
        })
        local isMobile=UIS.TouchEnabled and not UIS.KeyboardEnabled
        local isTablet=UIS.TouchEnabled and workspace.CurrentCamera.ViewportSize.X>=768
        local screenSize=workspace.CurrentCamera.ViewportSize
        local function getScaleFactor()
            local baseWidth=1920
            local currentWidth=screenSize.X
            local scaleFactor=math.clamp(currentWidth/baseWidth,0.5,1.2)
            if isMobile and not isTablet then return math.clamp(scaleFactor*0.85,0.6,0.9)
            elseif isTablet then return math.clamp(scaleFactor*1.0,0.8,1.1)
            else return scaleFactor end
        end
        local globalScale=getScaleFactor()
        local mainWidth=isMobile and 360 or(isTablet and 420 or 450)
        local mainHeight=isMobile and 420 or(isTablet and 480 or 500)
        local titleHeight=50
        mainFrame=createElement("Frame",{
            Name="MainFrame",
            Size=UDim2.new(0,mainWidth,0,mainHeight),
            AnchorPoint=Vector2.new(0.5,0.5),
            BackgroundColor3=COLORS.Background,
            BackgroundTransparency=COLORS.BackgroundTransparency,
            BorderSizePixel=0,
            ClipsDescendants=true,
            Parent=screenGui,
        })
        mainFrame.AnchorPoint=Vector2.new(0,0)
        loadAndClampPosition(mainFrame,"main",UDim2.new(0.5,-mainWidth/2,0.5,-mainHeight/2))
        _regDraggable(mainFrame,function()
            local vp=workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920,1080)
            return UDim2.fromOffset(math.floor((vp.X-mainWidth)/2),math.floor((vp.Y-mainHeight)/2))
        end)
        createElement("UICorner",{CornerRadius=UDim.new(0,8),Parent=mainFrame})
        trackStroke(createElement("UIStroke",{Color=COLORS.Accent,Thickness=2,Transparency=0.1,ApplyStrokeMode=Enum.ApplyStrokeMode.Border,Parent=mainFrame}))
        local _mainFrameBase=(isMobile or isTablet)and globalScale or 1.0
        registerScaleTarget(mainFrame,_mainFrameBase)
        if isMobile or isTablet then
            workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
                applyUIScale(scaleMultiplier)
            end)
        end
        local titleBar=createElement("Frame",{
            Size=UDim2.new(1,0,0,titleHeight),
            BackgroundColor3=COLORS.Surface,
            BackgroundTransparency=0.3,
            BorderSizePixel=0,
            Parent=mainFrame,
        })
        createElement("UICorner",{CornerRadius=UDim.new(0,8),Parent=titleBar})
        local mainTitle=createElement("TextLabel",{
            Size=UDim2.new(1,-80,1,0),
            Position=UDim2.new(0,15,0,0),
            BackgroundTransparency=1,
            Text="Looprix Hub",
            TextColor3=COLORS.Accent,
            TextSize=18,
            Font=Enum.Font.GothamBold,
            TextXAlignment=Enum.TextXAlignment.Left,
            Parent=titleBar,
        })
        trackLabel(mainTitle)
        local minBtn=createElement("TextButton",{
            Size=UDim2.new(0,30,0,30),
            Position=UDim2.new(1,-45,0.5,-15),
            BackgroundColor3=COLORS.Background,
            BackgroundTransparency=0.5,
            Text="-",
            TextColor3=COLORS.Accent,
            TextSize=20,
            Font=Enum.Font.GothamBold,
            BorderSizePixel=0,
            Parent=titleBar,
        })
        trackLabel(minBtn)
        createElement("UICorner",{CornerRadius=UDim.new(0,6),Parent=minBtn})
        trackStroke(createElement("UIStroke",{Color=COLORS.Accent,Thickness=1,Transparency=0.5,Parent=minBtn}))
        trackLabel(minBtn)
        tabBar=createElement("Frame",{
            Size=UDim2.new(1,-20,0,40),
            Position=UDim2.new(0,10,0,titleHeight+8),
            BackgroundColor3=COLORS.Surface,
            BackgroundTransparency=0.5,
            BorderSizePixel=0,
            Parent=mainFrame,
        })
        createElement("UICorner",{CornerRadius=UDim.new(0,6),Parent=tabBar})
        trackStroke(createElement("UIStroke",{Color=COLORS.Accent,Thickness=1,Transparency=0.5,ApplyStrokeMode=Enum.ApplyStrokeMode.Border,Parent=tabBar}))
        local tabButtons={}
        local tabNames={"Duel","Performance","Settings","Binds"}
        local tabIds={"duel","performance","settings","binds"}
        local numTabs=#tabNames
        local tabWidth=(1/numTabs)
        for i,tabName in ipairs(tabNames)do
            local isActive=(currentTab==tabIds[i])
            local tabBtn=createElement("TextButton",{
                Size=UDim2.new(tabWidth,0,1,0),
                Position=UDim2.new(tabWidth*(i-1),0,0,0),
                BackgroundTransparency=1,
                Text=tabName,
                TextColor3=isActive and COLORS.Accent or COLORS.TextDim,
                TextSize=13,
                Font=Enum.Font.GothamBold,
                BorderSizePixel=0,
                Parent=tabBar,
            })
            if isActive then trackLabel(tabBtn)end
            tabButtons[tabIds[i]]=tabBtn
        end
        local userInfoBar=createElement("Frame",{
            Size=UDim2.new(1,-20,0,54),
            Position=UDim2.new(0,10,1,-64),
            BackgroundColor3=COLORS.Surface,
            BackgroundTransparency=0.05,
            BorderSizePixel=0,
            Parent=mainFrame,
            ZIndex=3,
        })
        createElement("UICorner",{CornerRadius=UDim.new(0,8),Parent=userInfoBar})
        trackStroke(createElement("UIStroke",{
            Color=COLORS.Accent,Thickness=1,Transparency=0.6,
            ApplyStrokeMode=Enum.ApplyStrokeMode.Border,Parent=userInfoBar
        }))
        local avatarImg=Instance.new("ImageLabel",userInfoBar)
        avatarImg.Size=UDim2.new(0,40,0,40)
        avatarImg.Position=UDim2.new(0,8,0.5,-20)
        avatarImg.BackgroundColor3=COLORS.Background
        avatarImg.BackgroundTransparency=0.3
        avatarImg.BorderSizePixel=0
        avatarImg.Image="https://www.roblox.com/headshot-thumbnail/image?userId="..LP.UserId.."&width=150&height=150&format=png"
        avatarImg.ZIndex=4
        Instance.new("UICorner",avatarImg).CornerRadius=UDim.new(1,0)
        trackStroke(createElement("UIStroke",{Color=COLORS.Accent,Thickness=1.5,Parent=avatarImg}))
        local userNameLbl=Instance.new("TextLabel",userInfoBar)
        userNameLbl.AutoLocalize=false
        userNameLbl.Size=UDim2.new(1,-150,0,20)
        userNameLbl.Position=UDim2.new(0,56,0,9)
        userNameLbl.BackgroundTransparency=1
        userNameLbl.Text=LP.Name
        userNameLbl.TextColor3=COLORS.Text
        userNameLbl.Font=Enum.Font.GothamBlack
        userNameLbl.TextSize=13
        userNameLbl.TextXAlignment=Enum.TextXAlignment.Left
        userNameLbl.TextTruncate=Enum.TextTruncate.AtEnd
        userNameLbl.ZIndex=4
        local buyerBadge=Instance.new("Frame",userInfoBar)
        buyerBadge.Size=UDim2.new(0,90,0,38)
        buyerBadge.Position=UDim2.new(1,-98,0.5,-19)
        buyerBadge.BackgroundColor3=COLORS.Background
        buyerBadge.BackgroundTransparency=0.2
        buyerBadge.BorderSizePixel=0
        buyerBadge.ZIndex=4
        Instance.new("UICorner",buyerBadge).CornerRadius=UDim.new(0,9)
        trackStroke(createElement("UIStroke",{Color=COLORS.Accent,Thickness=1,Parent=buyerBadge}))
        local bbDot=Instance.new("Frame",buyerBadge)
        bbDot.Size=UDim2.new(0,6,0,6)
        bbDot.Position=UDim2.new(0,8,0,8)
        bbDot.BackgroundColor3=COLORS.Accent
        bbDot.BorderSizePixel=0
        bbDot.ZIndex=5
        Instance.new("UICorner",bbDot).CornerRadius=UDim.new(1,0)
        trackDot(bbDot)
        local bbBuyer=Instance.new("TextLabel",buyerBadge)
        bbBuyer.AutoLocalize=false
        bbBuyer.Size=UDim2.new(1,-4,0,18)
        bbBuyer.Position=UDim2.new(0,2,0,3)
        bbBuyer.BackgroundTransparency=1
        bbBuyer.Text="Buyer"
        bbBuyer.TextColor3=COLORS.Accent
        bbBuyer.Font=Enum.Font.GothamBlack
        bbBuyer.TextSize=11
        bbBuyer.TextXAlignment=Enum.TextXAlignment.Center
        bbBuyer.ZIndex=5
        trackLabel(bbBuyer)
        local bbText=Instance.new("TextLabel",buyerBadge)
        bbText.AutoLocalize=false
        bbText.Size=UDim2.new(1,-4,0,13)
        bbText.Position=UDim2.new(0,2,0,22)
        bbText.BackgroundTransparency=1
        bbText.Text="Looprix"
        bbText.TextColor3=Color3.fromRGB(160,200,185)
        bbText.Font=Enum.Font.GothamBold
        bbText.TextSize=8
        bbText.TextXAlignment=Enum.TextXAlignment.Center
        bbText.ZIndex=5
        contentFrame=createElement("Frame",{
            Name="ContentFrame",
            Size=UDim2.new(1,0,1,-(titleHeight+60+64)),
            Position=UDim2.new(0,0,0,titleHeight+56),
            BackgroundTransparency=1,
            Parent=mainFrame,
        })
        local tabs={
            duel=createDuelTab(contentFrame),
            performance=createPerformanceTab(contentFrame),
            settings=createSettingsTab(contentFrame),
            binds=createBindsTab(contentFrame),
        }
        tabs[currentTab].Visible=true
        local function switchTab(tabId)
            currentTab=tabId
            for id,t in pairs(tabs)do t.Visible=(id==tabId)end
            for id,btn in pairs(tabButtons)do
                local active=(id==tabId)
                tween(btn,tweenInfoFast,{TextColor3=active and COLORS.Accent or COLORS.TextDim})
                if active then
                    if not table.find(_accentLabels,btn)then table.insert(_accentLabels,btn)end
                else
                    for i,l in ipairs(_accentLabels)do
                        if l==btn then table.remove(_accentLabels,i)break end
                    end
                end
            end
        end
        for id,btn in pairs(tabButtons)do
            btn.MouseButton1Click:Connect(function()switchTab(id)end)
        end
        minBtn.MouseButton1Click:Connect(function()
            isMinimized=not isMinimized
            minBtn.Text=isMinimized and"+"or"-"
            if isMinimized then
                tween(mainFrame,tweenInfoMedium,{Size=UDim2.new(0,mainWidth,0,titleHeight)})
                tabBar.Visible=false
                contentFrame.Visible=false
                userInfoBar.Visible=false
            else
                tween(mainFrame,tweenInfoMedium,{Size=UDim2.new(0,mainWidth,0,mainHeight)})
                task.delay(0.2,function()
                    if not isMinimized then
                        tabBar.Visible=true
                        contentFrame.Visible=true
                        userInfoBar.Visible=true
                    end
                end)
            end
        end)
        makeDraggable(mainFrame,titleBar,"main",function()return CONFIG.UI_LOCKED end)
        UIS.InputBegan:Connect(function(input,gpe)
            if gpe then return end
            local isKeyboard=input.UserInputType==Enum.UserInputType.Keyboard
            local isGamepad=input.UserInputType==Enum.UserInputType.Gamepad1
                or input.UserInputType==Enum.UserInputType.Gamepad2
                or input.UserInputType==Enum.UserInputType.Gamepad3
                or input.UserInputType==Enum.UserInputType.Gamepad4
            if not isKeyboard and not isGamepad then return end
            if input.KeyCode==Enum.KeyCode.Unknown then return end
            if input.KeyCode==Enum.KeyCode.Space then _jumpBoostSpaceHeld=true end
            if isKeybindPressed(CONFIG.TOGGLE_GUI_KEYBIND,input)then
                toggleGui()
            elseif isKeybindPressed(CONFIG.AUTO_BAT_KEYBIND,input)then
                CONFIG.AUTO_BAT_ENABLED=not CONFIG.AUTO_BAT_ENABLED
                attacking=CONFIG.AUTO_BAT_ENABLED;saveConfig()
                if CONFIG.AUTO_BAT_ENABLED then autoAttack()end
            elseif isKeybindPressed(CONFIG.SPINBOT_KEYBIND,input)then
                local newSpinState=not CONFIG.SPINBOT_ENABLED
                CONFIG.SPINBOT_ENABLED=newSpinState;spinbotEnabled=newSpinState;saveConfig()
                if newSpinState then startSpinBot()else stopSpinBot()end
                if spinbotPanelBtn then
                    spinbotPanelBtn.Text="SPIN: "..(newSpinState and"ON"or"OFF")
                end
                if _spinbotBtn then setToggleVisual(_spinbotBtn,newSpinState)end
            elseif isKeybindPressed(CONFIG.LOCK_TARGET_KEYBIND,input)then
                if isSwitching then return end
                local newKbState=not CONFIG.LOCK_TARGET_ENABLED
                if newKbState then
                    isSwitching=true
                    if AutoPlayState.enabled then apStopLoop()end
                    isSwitching=false
                end
                CONFIG.LOCK_TARGET_ENABLED=newKbState
                lockTargetEnabled=newKbState
                _lockManuallyOn=newKbState
                saveConfig()
                if lockTargetPanelBtn then
                    lockTargetPanelBtn.Text="LOCK: "..(lockTargetEnabled and"ON"or"OFF")
                end
                if lockTargetEnabled then startLockTarget()else stopLockTarget()end
            elseif isKeybindPressed(CONFIG.AUTO_MEDUSA_KEYBIND,input)then
                CONFIG.AUTO_MEDUSA_ENABLED=not CONFIG.AUTO_MEDUSA_ENABLED
                autoMedusaEnabled=CONFIG.AUTO_MEDUSA_ENABLED;saveConfig()
                if CONFIG.AUTO_MEDUSA_ENABLED then startAutoMedusa()else stopAutoMedusa()end
            elseif isKeybindPressed(CONFIG.AUTO_STEAL_KEYBIND,input)then
                local newState=not CONFIG.AUTO_STEAL_ENABLED
                CONFIG.AUTO_STEAL_ENABLED=newState;autoStealGrabEnabled=newState;saveConfig()
                if newState then startAutoSteal()else stopAutoSteal()end
            elseif isKeybindPressed(CONFIG.DROP_BRAINROT_KEYBIND,input)then
                executeDrop()
            elseif isKeybindPressed(CONFIG.AUTO_PLAY_KEYBIND,input)then
                if apGuiInstance and apGuiInstance.Enabled then
                    local d=_detectSideNow()
                    if d then startRoute(d)end
                end
            elseif isKeybindPressed(CONFIG.AUTO_WALK_KEYBIND,input)then
                if awGuiInstance and awGuiInstance.Enabled then
                    awLaunch("auto")
                end
            elseif isKeybindPressed(CONFIG.ANTI_STEAL_KEYBIND,input)then
                CONFIG.ANTI_STEAL_PANEL_VISIBLE=not CONFIG.ANTI_STEAL_PANEL_VISIBLE
                antiStealEnabled=CONFIG.ANTI_STEAL_PANEL_VISIBLE
                if antiStealEnabled then startAntiStealWatcher()else stopAntiStealWatcher()end
                saveConfig()
            elseif isKeybindPressed(CONFIG.AUTO_LOCK_KEYBIND,input)then
                CONFIG.AUTO_LOCK_PANEL_VISIBLE=not CONFIG.AUTO_LOCK_PANEL_VISIBLE
                autoLockEnabled2=CONFIG.AUTO_LOCK_PANEL_VISIBLE
                if autoLockEnabled2 then startAutoLockWatcher()else stopAutoLockWatcher()end
                saveConfig()
            elseif isKeybindPressed(CONFIG.TP_DOWN_KEYBIND,input)then
                tpDown()
            elseif isKeybindPressed(CONFIG.INSTANT_RESET_KEYBIND,input)then
                doInstantReset()
            elseif isKeybindPressed(CONFIG.AUTO_REACT_STEAL_KEYBIND,input)then
                CONFIG.AUTO_REACT_STEAL_ENABLED=not CONFIG.AUTO_REACT_STEAL_ENABLED
                autoReactStealEnabled=CONFIG.AUTO_REACT_STEAL_ENABLED
                saveConfig()
                if CONFIG.AUTO_REACT_STEAL_ENABLED then startAutoReactStealWatcher()else stopAutoReactStealWatcher()end
            elseif isKeybindPressed(CONFIG.SPEED_PRESET_KEYBIND,input)then
                local next=CONFIG.SPEED_PRESET=="normal"and"lagger"or"normal"
                CONFIG.SPEED_PRESET=next
                local keys={normal={speed="PRESET_NORMAL_SPEED",steal="PRESET_NORMAL_STEAL"},lagger={speed="PRESET_LAGGER_SPEED",steal="PRESET_LAGGER_STEAL"}}
                local k=keys[next]
                if k then
                    CONFIG.SPEED_VALUE=CONFIG[k.speed]
                    CONFIG.STEAL_SPEED_VALUE=CONFIG[k.steal]
                    if _speedValBox then _speedValBox.Text=tostring(CONFIG.SPEED_VALUE)end
                    if _stealValBox then _stealValBox.Text=tostring(CONFIG.STEAL_SPEED_VALUE)end
                end
                saveConfig()
            end
        end)
    end

    local function createActiveHud()
        pcall(function()
            if LP.PlayerGui:FindFirstChild("LooprixActiveHUD")then
                LP.PlayerGui.LooprixActiveHUD:Destroy()
            end
        end)
        local hudGui=Instance.new("ScreenGui")
        hudGui.AutoLocalize=false
        hudGui.Name="LooprixActiveHUD"
        hudGui.ResetOnSpawn=false
        hudGui.DisplayOrder=999990
        hudGui.Enabled=CONFIG.ACTIVE_HUD_VISIBLE
        hudGui.Parent=LP.PlayerGui
        local primaryCol=Instance.new("Frame")
        primaryCol.Name="PrimaryCol"
        primaryCol.Size=UDim2.new(0,160,0,0)
        primaryCol.Position=UDim2.new(1,-168,1,-8)
        primaryCol.AnchorPoint=Vector2.new(0,1)
        primaryCol.BackgroundTransparency=1
        primaryCol.BorderSizePixel=0
        primaryCol.AutomaticSize=Enum.AutomaticSize.Y
        primaryCol.Parent=hudGui
        local primaryLayout=Instance.new("UIListLayout",primaryCol)
        primaryLayout.FillDirection=Enum.FillDirection.Vertical
        primaryLayout.VerticalAlignment=Enum.VerticalAlignment.Bottom
        primaryLayout.HorizontalAlignment=Enum.HorizontalAlignment.Right
        primaryLayout.SortOrder=Enum.SortOrder.LayoutOrder
        primaryLayout.Padding=UDim.new(0,3)
        local secondaryCol=Instance.new("Frame")
        secondaryCol.Name="SecondaryCol"
        secondaryCol.Size=UDim2.new(0,160,0,0)
        secondaryCol.Position=UDim2.new(0,8,1,-8)
        secondaryCol.AnchorPoint=Vector2.new(0,1)
        secondaryCol.BackgroundTransparency=1
        secondaryCol.BorderSizePixel=0
        secondaryCol.AutomaticSize=Enum.AutomaticSize.Y
        secondaryCol.Parent=hudGui
        local secondaryLayout=Instance.new("UIListLayout",secondaryCol)
        secondaryLayout.FillDirection=Enum.FillDirection.Vertical
        secondaryLayout.VerticalAlignment=Enum.VerticalAlignment.Bottom
        secondaryLayout.HorizontalAlignment=Enum.HorizontalAlignment.Left
        secondaryLayout.SortOrder=Enum.SortOrder.LayoutOrder
        secondaryLayout.Padding=UDim.new(0,3)
        local TOGGLE_DEFS={
            {k="AUTO_BAT_ENABLED",n="Auto Bat"},
            {k="COUNTER_BAT_ENABLED",n="Counter Bat"},
            {k="SPINBOT_ENABLED",n="Spin Bot"},
            {k="ANTIRAGDOLL_ENABLED",n="Anti Ragdoll"},
            {k="UNWALK_ENABLED",n="Unwalk"},
            {k="ESP_ENABLED",n="ESP"},
            {k="INF_JUMP_ENABLED",n="Inf Jump"},
            {k="LOCK_TARGET_ENABLED",n="Lock Target"},
            {k="AUTO_MEDUSA_ENABLED",n="Auto Medusa"},
            {k="AUTO_STEAL_ENABLED",n="Auto Steal"},
            {k="ANTI_DIE_ENABLED",n="Anti Die"},
            {k="NO_COLLISION_ENABLED",n="No Collision"},
            {k="SPEED_ENABLED",n="Speed Boost"},
        }
        local hudPool={}
        local GRAD_COLORS=ColorSequence.new({
            ColorSequenceKeypoint.new(0,Color3.fromRGB(CONFIG.GUI_COLOR_R,CONFIG.GUI_COLOR_G,CONFIG.GUI_COLOR_B)),
            ColorSequenceKeypoint.new(0.5,Color3.fromRGB(
                math.min(CONFIG.GUI_COLOR_R+80,255),
                math.min(CONFIG.GUI_COLOR_G+40,255),
                math.min(CONFIG.GUI_COLOR_B+60,255))),
            ColorSequenceKeypoint.new(1,Color3.fromRGB(CONFIG.GUI_COLOR_R,CONFIG.GUI_COLOR_G,CONFIG.GUI_COLOR_B)),
        })
        local function makeHudRow(name)
            local row=Instance.new("Frame")
            row.Size=UDim2.new(1,0,0,22)
            row.BackgroundColor3=COLORS.Background
            row.BackgroundTransparency=0.25
            row.BorderSizePixel=0
            Instance.new("UICorner",row).CornerRadius=UDim.new(0,5)
            local rowStroke=Instance.new("UIStroke",row)
            rowStroke.Thickness=1
            rowStroke.Color=COLORS.Accent
            rowStroke.Transparency=0.4
            rowStroke.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
            trackStroke(rowStroke)
            local dot=Instance.new("Frame",row)
            dot.Size=UDim2.new(0,7,0,7)
            dot.Position=UDim2.new(0,6,0.5,-3)
            dot.BackgroundColor3=COLORS.Accent
            dot.BorderSizePixel=0
            Instance.new("UICorner",dot).CornerRadius=UDim.new(1,0)
            trackDot(dot)
            task.spawn(function()
                while dot and dot.Parent do
                    TweenService:Create(dot,TweenInfo.new(0.6,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),
                        {BackgroundTransparency=0.3}):Play()
                    task.wait(0.6)
                    if dot and dot.Parent then
                        TweenService:Create(dot,TweenInfo.new(0.6,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),
                            {BackgroundTransparency=0}):Play()
                        task.wait(0.6)
                    end
                end
            end)
            local lbl=Instance.new("TextLabel",row)
            lbl.AutoLocalize=false
            lbl.Size=UDim2.new(1,-18,1,0)
            lbl.Position=UDim2.new(0,17,0,0)
            lbl.BackgroundTransparency=1
            lbl.Text=name
            lbl.TextColor3=Color3.new(1,1,1)
            lbl.TextSize=11
            lbl.Font=Enum.Font.GothamSemibold
            lbl.TextXAlignment=Enum.TextXAlignment.Left
            local lblGrad=Instance.new("UIGradient",lbl)
            lblGrad.Color=GRAD_COLORS
            table.insert(_accentGradients,lblGrad)
            return row
        end
        local function refreshHud()
            local active={}
            for _,def in ipairs(TOGGLE_DEFS)do
                if CONFIG[def.k]then
                    table.insert(active,def.n)
                end
            end
            for _,r in ipairs(hudPool)do
                if r and r.Parent then r:Destroy()end
            end
            hudPool={}
            for i,name in ipairs(active)do
                local row=makeHudRow(name)
                if i<=5 then
                    row.LayoutOrder=i
                    row.Parent=primaryCol
                else
                    row.LayoutOrder=i
                    row.Parent=secondaryCol
                end
                table.insert(hudPool,row)
            end
        end
        task.spawn(function()
            while hudGui and hudGui.Parent do
                refreshHud()
                task.wait(0.5)
            end
        end)
        return hudGui
    end

    local function createStatsIsland()
        if LP.PlayerGui:FindFirstChild("LooprixStats")then
            LP.PlayerGui.LooprixStats:Destroy()
        end
        local TEXT_GRADIENT_COLORS=ColorSequence.new({
            ColorSequenceKeypoint.new(0.00,Color3.fromRGB(0,217,127)),
            ColorSequenceKeypoint.new(0.33,Color3.fromRGB(120,255,210)),
            ColorSequenceKeypoint.new(0.66,Color3.fromRGB(150,255,180)),
            ColorSequenceKeypoint.new(1.00,Color3.fromRGB(0,217,127))
        })
        local function makeGradBorder(parent)
            local s=Instance.new("UIStroke",parent)
            s.Thickness=1
            s.Color=Color3.fromRGB(0,217,127)
            s.Transparency=0.1
            s.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
            trackStroke(s)
            local g=Instance.new("UIGradient",s)
            g.Color=ColorSequence.new({
                ColorSequenceKeypoint.new(0,Color3.fromRGB(0,217,127)),
                ColorSequenceKeypoint.new(0.25,Color3.fromRGB(120,255,210)),
                ColorSequenceKeypoint.new(0.5,Color3.fromRGB(150,255,180)),
                ColorSequenceKeypoint.new(0.75,Color3.fromRGB(120,255,210)),
                ColorSequenceKeypoint.new(1,Color3.fromRGB(0,217,127))
            })
            trackGradient(g)
            return s,g
        end
        local screenGui=Instance.new("ScreenGui")
        screenGui.AutoLocalize=false
        screenGui.Name="LooprixStats"
        screenGui.ResetOnSpawn=false
        screenGui.DisplayOrder=100
        screenGui.Parent=LP.PlayerGui
        local mainFrame=Instance.new("Frame")
        mainFrame.Name="MainContainer"
        mainFrame.Size=UDim2.new(0,220,0,22)
        mainFrame.Position=UDim2.new(0.5,0,0,8)
        mainFrame.AnchorPoint=Vector2.new(0.5,0)
        mainFrame.BackgroundColor3=Color3.fromRGB(12,14,20)
        mainFrame.BackgroundTransparency=0.15
        mainFrame.BorderSizePixel=0
        mainFrame.Parent=screenGui
        registerScaleTarget(mainFrame)
        Instance.new("UICorner",mainFrame).CornerRadius=UDim.new(0,6)
        local _,borderGradient=makeGradBorder(mainFrame)
        local statsLabel=Instance.new("TextLabel")
        statsLabel.AutoLocalize=false
        statsLabel.Size=UDim2.new(1,-12,1,0)
        statsLabel.Position=UDim2.new(0,6,0,0)
        statsLabel.BackgroundTransparency=1
        statsLabel.Font=Enum.Font.GothamBold
        statsLabel.TextColor3=Color3.new(1,1,1)
        statsLabel.TextScaled=false
        statsLabel.TextSize=12
        statsLabel.RichText=true
        statsLabel.Text="Looprix  |  FPS: --  |  PING: -- ms"
        statsLabel.Parent=mainFrame
        local pbFrame=Instance.new("Frame")
        pbFrame.Name="ProgressRow"
        pbFrame.Size=UDim2.new(0,190,0,16)
        pbFrame.Position=UDim2.new(0.5,0,0,34)
        pbFrame.AnchorPoint=Vector2.new(0.5,0)
        pbFrame.BackgroundColor3=Color3.fromRGB(12,14,20)
        pbFrame.BackgroundTransparency=0.15
        pbFrame.BorderSizePixel=0
        pbFrame.Parent=screenGui
        registerScaleTarget(pbFrame)
        Instance.new("UICorner",pbFrame).CornerRadius=UDim.new(0,5)
        local _,pbBorderGrad=makeGradBorder(pbFrame)
        local pbStatus=Instance.new("TextLabel")
        pbStatus.AutoLocalize=false
        pbStatus.Size=UDim2.new(0,42,1,0)
        pbStatus.Position=UDim2.new(0,5,0,0)
        pbStatus.BackgroundTransparency=1
        pbStatus.Text="Ready"
        pbStatus.TextColor3=COLORS.Accent
        pbStatus.TextScaled=false
        pbStatus.TextSize=9
        pbStatus.Font=Enum.Font.GothamBold
        pbStatus.TextXAlignment=Enum.TextXAlignment.Left
        pbStatus.ZIndex=4
        pbStatus.Parent=pbFrame
        trackLabel(pbStatus)
        local pbTrack=Instance.new("Frame")
        pbTrack.Size=UDim2.new(1,-88,0,5)
        pbTrack.Position=UDim2.new(0,50,0.5,-2)
        pbTrack.BackgroundColor3=Color3.fromRGB(20,26,38)
        pbTrack.BackgroundTransparency=0.1
        pbTrack.BorderSizePixel=0
        pbTrack.ClipsDescendants=true
        pbTrack.ZIndex=3
        pbTrack.Parent=pbFrame
        Instance.new("UICorner",pbTrack).CornerRadius=UDim.new(1,0)
        local tse=Instance.new("UIStroke",pbTrack)
        tse.Thickness=1;tse.Transparency=0.2
        tse.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
        tse.Color=COLORS.Accent
        trackStroke(tse)
        local pbFill=Instance.new("Frame")
        pbFill.Name="Fill"
        pbFill.Size=UDim2.new(0,0,1,0)
        pbFill.BackgroundColor3=COLORS.Accent
        pbFill.BackgroundTransparency=0
        pbFill.BorderSizePixel=0
        pbFill.Visible=false
        pbFill.ZIndex=4
        pbFill.Parent=pbTrack
        trackFrame(pbFill)
        Instance.new("UICorner",pbFill).CornerRadius=UDim.new(1,0)
        stealFillFrame=pbFill
        local distBadgeBtn=Instance.new("TextButton")
        distBadgeBtn.AutoLocalize=false
        distBadgeBtn.Size=UDim2.new(0,30,0,12)
        distBadgeBtn.Position=UDim2.new(1,-34,0.5,-6)
        distBadgeBtn.BackgroundColor3=COLORS.Surface
        distBadgeBtn.BackgroundTransparency=0.3
        distBadgeBtn.BorderSizePixel=0
        distBadgeBtn.Text=tostring(CONFIG.AUTO_STEAL_ACTIVATION_DIST)
        distBadgeBtn.TextColor3=COLORS.Accent
        distBadgeBtn.TextScaled=false
        distBadgeBtn.TextSize=8
        distBadgeBtn.Font=Enum.Font.GothamBold
        distBadgeBtn.TextXAlignment=Enum.TextXAlignment.Center
        distBadgeBtn.ZIndex=5
        distBadgeBtn.Parent=pbFrame
        trackLabel(distBadgeBtn)
        Instance.new("UICorner",distBadgeBtn).CornerRadius=UDim.new(0,3)
        local dbs=Instance.new("UIStroke",distBadgeBtn)
        dbs.Thickness=1;dbs.Transparency=0.2
        dbs.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
        dbs.Color=COLORS.Accent
        trackStroke(dbs)
        local distBox=Instance.new("TextBox")
        distBox.AutoLocalize=false
        distBox.Size=UDim2.new(0,30,0,12)
        distBox.Position=UDim2.new(1,-34,0.5,-6)
        distBox.BackgroundColor3=Color3.fromRGB(10,12,18)
        distBox.BackgroundTransparency=0.1
        distBox.BorderSizePixel=0
        distBox.Text=tostring(CONFIG.AUTO_STEAL_ACTIVATION_DIST)
        distBox.TextColor3=COLORS.Accent
        distBox.TextScaled=false
        distBox.TextSize=8
        distBox.Font=Enum.Font.GothamBold
        distBox.TextXAlignment=Enum.TextXAlignment.Center
        distBox.ClearTextOnFocus=true
        distBox.ZIndex=6
        distBox.Visible=false
        distBox.Parent=pbFrame
        Instance.new("UICorner",distBox).CornerRadius=UDim.new(0,3)
        local dbxs=Instance.new("UIStroke",distBox)
        dbxs.Thickness=1;dbxs.Transparency=0;dbxs.Color=COLORS.Accent
        trackStroke(dbxs)
        local function commitDist()
            local v=tonumber(distBox.Text)
            if v then
                v=math.clamp(math.round(v),1,9999)
                CONFIG.AUTO_STEAL_ACTIVATION_DIST=v
                saveConfig()
                distBadgeBtn.Text=tostring(v)
            else
                distBadgeBtn.Text=tostring(CONFIG.AUTO_STEAL_ACTIVATION_DIST)
            end
            distBox.Visible=false
            distBadgeBtn.Visible=true
        end
        distBadgeBtn.MouseButton1Click:Connect(function()
            distBox.Text=tostring(CONFIG.AUTO_STEAL_ACTIVATION_DIST)
            distBadgeBtn.Visible=false
            distBox.Visible=true
            distBox:CaptureFocus()
        end)
        distBox.FocusLost:Connect(function()commitDist()end)
        distBox:GetPropertyChangedSignal("Text"):Connect(function()
            distBox.Text=distBox.Text:gsub("[^%d]","")
        end)
        task.spawn(function()
            local last=CONFIG.AUTO_STEAL_ACTIVATION_DIST
            while pbFrame and pbFrame.Parent do
                task.wait(0.25)
                local cur=CONFIG.AUTO_STEAL_ACTIVATION_DIST
                if cur~=last then last=cur;distBadgeBtn.Text=tostring(cur)end
            end
        end)
        task.spawn(function()
            while pbFrame and pbFrame.Parent do
                task.wait(0.1)
                pbStatus.Text=(isStealing and"Stealing")or"Ready"
            end
        end)
        local lastTime=tick()
        local frames=0
        RunService.RenderStepped:Connect(function()
            frames=frames+1
            local currentTime=tick()
            if currentTime-lastTime>=0.5 then
                local fps=math.round(frames/(currentTime-lastTime))
                local ping=math.round(LP:GetNetworkPing()*1000)
                local pingHex=ping<80 and"00D97F"or(ping<150 and"FFEB78"or"FF6478")
                statsLabel.Text=string.format(
                    "Looprix  |  FPS: %d  |  PING: <font color=\"#%s\">%d ms</font>",
                    fps,pingHex,ping)
                frames=0
                lastTime=currentTime
            end
        end)
        return screenGui
    end

    _discordBBSetup=function()
        if _discordBB and _discordBB.Parent then _discordBB:Destroy()end
        _discordBB=nil
        local char=LP.Character
        if not char then return end
        local head=char:FindFirstChild("Head")
        if not head then return end
        local bb=Instance.new("BillboardGui",head)
        bb.Name="LooprixDiscordBB"
        bb.Size=UDim2.new(0,180,0,20)
        bb.StudsOffset=Vector3.new(0,2.4,0)
        bb.AlwaysOnTop=true
        bb.ResetOnSpawn=false
        local lbl=Instance.new("TextLabel",bb)
        lbl.Size=UDim2.new(1,0,1,0)
        lbl.BackgroundTransparency=1
        lbl.Text="discord.gg/looprixhub"
        lbl.TextColor3=Color3.fromRGB(255,255,255)
        lbl.TextStrokeTransparency=0
        lbl.TextStrokeColor3=Color3.fromRGB(0,0,0)
        lbl.Font=Enum.Font.GothamBlack
        lbl.TextSize=13
        _discordBB=bb
    end
    _startDiscordBB=function()
        _discordBBSetup()
        if _discordCharConn then _discordCharConn:Disconnect()end
        _discordCharConn=LP.CharacterAdded:Connect(function()
            task.wait(0.5)
            _discordBBSetup()
        end)
    end

    local function reapplyAllSettings()
        if CONFIG.ANTI_DIE_ENABLED then
            task.wait(0.2)
            activateAntiDie()
            antiDieEnabled=true
            task.wait(0.05)
        end
        if CONFIG.AUTO_BAT_ENABLED then
            attacking=true
            autoAttack()
            task.wait(0.05)
        end
        if CONFIG.SPINBOT_ENABLED then
            spinbotEnabled=true
            startSpinBot()
            task.wait(0.05)
        end
        if CONFIG.ANTIRAGDOLL_ENABLED then
            toggleAntiRagdoll(true)
            task.wait(0.05)
        end
        if CONFIG.UNWALK_ENABLED then
            unwalkEnabled=true
            startUnwalk()
            task.wait(0.05)
        end
        if CONFIG.ESP_ENABLED then
            espEnabled=true
            startESP()
            task.wait(0.05)
        end
        if CONFIG.LOCK_TARGET_ENABLED then
            lockTargetEnabled=true
            startLockTarget()
            task.wait(0.05)
        end
        if CONFIG.INF_JUMP_ENABLED then
            infJumpEnabled=true
            startInfJump()
            task.wait(0.05)
        end
        if CONFIG.AUTO_MEDUSA_ENABLED then
            autoMedusaEnabled=true
            startAutoMedusa()
            task.wait(0.05)
        end
        if CONFIG.MEDUSA_COUNTER_ENABLED then
            medusaCounterEnabled=true
            setupMedusaCounter(character)
            task.wait(0.05)
        end
        if CONFIG.AUTO_STEAL_ENABLED then
            autoStealGrabEnabled=true
            startAutoSteal()
            task.wait(0.05)
        end
        if CONFIG.JUMP_BOOST_ENABLED then
            jumpBoostEnabled=true
            startJumpBoost()
            task.wait(0.05)
        end
        if CONFIG.NO_COLLISION_ENABLED then
            startNoCollision()
            task.wait(0.05)
        end
        startSpeed()
        task.wait(0.05)
        if CONFIG.AUTO_REACT_STEAL_ENABLED then
            autoReactStealEnabled=true
            startAutoReactStealWatcher()
            task.wait(0.05)
        end
        if CONFIG.HARDER_HIT_ENABLED then
            pcall(function()
                task.wait(0.3)
                startHarderHitAnim()
            end)
        end
        if CONFIG.SPINBOT_PANEL_VISIBLE and spinbotPanelGui then
            spinbotPanelGui.Enabled=true
        end
        if CONFIG.TAUNT_PANEL_VISIBLE and tauntPanelGui then
            tauntPanelGui.Enabled=true
        end
        if CONFIG.AUTO_WALK_PANEL_VISIBLE and awGuiInstance then
            awGuiInstance.Enabled=true
        end
        if CONFIG.TP_DOWN_PANEL_VISIBLE and tpDownPanelGui then
            tpDownPanelGui.Enabled=true
        end
        if CONFIG.INSTANT_RESET_PANEL_VISIBLE and _instantResetPanelGui then
            _instantResetPanelGui.Enabled=true
        end
        if CONFIG.AUTO_LOCK_PANEL_VISIBLE and autoLockEnabled2 then
            startAutoLockWatcher()
        end
        if CONFIG.COUNTER_BAT_ENABLED then
            counterBatEnabled2=true
            if startCounterBatWatcher then startCounterBatWatcher()end
        end
        pcall(function()
            if lockTargetPanelBtn then
                lockTargetPanelBtn.Text="LOCK: "..(CONFIG.LOCK_TARGET_ENABLED and"ON"or"OFF")
            end
            if spinbotPanelBtn then
                spinbotPanelBtn.Text="SPIN: "..(CONFIG.SPINBOT_ENABLED and"ON"or"OFF")
            end
        end)
    end

    local function stopAllSystems()
        stopSpinBot()
        spinbotEnabled=false
        stopUnwalk()
        unwalkEnabled=false
        stopESP()
        espEnabled=false
        stopLockTarget()
        lockTargetEnabled=false
        stopInfJump()
        infJumpEnabled=false
        stopAutoMedusa()
        autoMedusaEnabled=false
        stopMedusaCounter()
        medusaCounterEnabled=false
        stopAutoSteal()
        autoStealGrabEnabled=false
        stopJumpBoost()
        jumpBoostEnabled=false
        stopNoCollision()
        stopSpeed()
        apStopLoop()
        AutoPlayState.enabled=false
        AutoPlayState.activeSide=nil
        awStopLoop()
        AW.enabled=false
        AW.activeSide=nil
        AW.currentStep=1
        attacking=false
        _autoBatGen=_autoBatGen+1
        stopAntiRagdollV2()
        antiDieEnabled=false
        deactivateAntiDie()
    end

    local function onCharacterAdded(c)
        stopAllSystems()
        clearConnections()
        runCleanups()
        character=c
        HRP=c:WaitForChild("HumanoidRootPart")
        if CONFIG.MEDUSA_COUNTER_ENABLED then
            task.spawn(function()
                task.wait(0.3)
                setupMedusaCounter(c)
            end)
        end
        _captureOriginalJumpPower()
        if _galaxyEnabled then
            task.spawn(function()
                task.wait(0.5)
                _setupGalaxyForce()
                _adjustGalaxyJump()
            end)
        end
        task.spawn(function()
            task.wait(0.5)
            reapplyAllSettings()
            if CONFIG.HARDER_HIT_ENABLED then
                pcall(function()
                    task.wait(0.3)
                    startHarderHitAnim()
                end)
            end
        end)
    end

    UIS.InputEnded:Connect(function(input)
        if input.KeyCode==Enum.KeyCode.Space then
            _jumpBoostSpaceHeld=false
        end
    end)
        LP.CharacterAdded:Connect(onCharacterAdded)

    pcall(function()
        local ls=game:GetService("LocalizationService")
        ls.RobloxForcePlayLocale="en-us"
    end)

    loadConfig()

    if CONFIG._autoPlayOffsets then
        for _,side in ipairs({"L","R"})do
            for _,key in ipairs({"P1","P2","P3","P4","P5"})do
                local sd=CONFIG._autoPlayOffsets[side]
                if sd and sd[key]then
                    AP.offsets[side][key].x=sd[key].x or 0
                    AP.offsets[side][key].z=sd[key].z or 0
                end
            end
        end
    end
    if CONFIG._apBasePositions then
        for side,pts in pairs(CONFIG._apBasePositions)do
            if AP.BASE[side]then
                for key,pv in pairs(pts)do
                    if type(pv)=="table"and AP.BASE[side][key]~=nil then
                        AP.BASE[side][key]=Vector3.new(
                            tonumber(pv.x)or 0,
                            tonumber(pv.y)or 0,
                            tonumber(pv.z)or 0
                        )
                    end
                end
            end
        end
    end

    do
        local r=CONFIG.GUI_COLOR_R or 0
        local g=CONFIG.GUI_COLOR_G or 217
        local b=CONFIG.GUI_COLOR_B or 127
        COLORS.Accent=Color3.fromRGB(r,g,b)
    end

    _doPostDropHalt=function()
        if AutoPlayState.enabled then
            apStopLoop()
        end
    end

    _doSnapLock=function()
        if isSwitching then return end
        local wasLocked=CONFIG.LOCK_TARGET_ENABLED
        if wasLocked then return end
        isSwitching=true
        if AutoPlayState.enabled then
            apStopLoop()
        end
        CONFIG.LOCK_TARGET_ENABLED=true
        lockTargetEnabled=true
        startLockTarget()
        pcall(function()
            if lockTargetPanelBtn then
                lockTargetPanelBtn.Text="LOCK: ON"
            end
        end)
        isSwitching=false
        task.delay(2,function()
            if _lockManuallyOn then return end
            if not CONFIG.LOCK_TARGET_ENABLED then return end
            CONFIG.LOCK_TARGET_ENABLED=false
            lockTargetEnabled=false
            stopLockTarget()
            pcall(function()
                if lockTargetPanelBtn then
                    lockTargetPanelBtn.Text="LOCK: OFF"
                end
            end)
        end)
    end

    _setAutoLoad=function(v) end

    createGui()
    guiVisible=(CONFIG.MAIN_GUI_VISIBLE~=false)
    if mainFrame then mainFrame.Visible=guiVisible end
    setupFloatingPanels()
    speedGuiInstance=createSpeedGui()
    laggerGuiInstance=createLaggerGui()
    apGuiInstance=createAutoPlayGui()
    awGuiInstance=createAutoWalkGui()
    createStatsIsland()
    createActiveHud()
    _startDiscordBB()

    do
        local r=CONFIG.GUI_COLOR_R or 0
        local g=CONFIG.GUI_COLOR_G or 217
        local b=CONFIG.GUI_COLOR_B or 127
        applyAccentColor(r,g,b)
    end

    applyUIScale(scaleMultiplier)

    local function createToggleButton()
        local tbGui=Instance.new("ScreenGui")
        tbGui.AutoLocalize=false
        tbGui.Name="Looprix_ToggleBtn"
        tbGui.ResetOnSpawn=false
        tbGui.DisplayOrder=9999998
        tbGui.IgnoreGuiInset=true
        pcall(function()
            if gethui then
                tbGui.Parent=gethui()
            elseif syn and syn.protect_gui then
                syn.protect_gui(tbGui)
                tbGui.Parent=LP.PlayerGui
            else
                tbGui.Parent=LP.PlayerGui
            end
        end)
        if not tbGui.Parent then tbGui.Parent=LP.PlayerGui end
        local btn=Instance.new("Frame")
        btn.Name="LooprixToggleBtn"
        btn.Size=UDim2.new(0,42,0,42)
        btn.BackgroundColor3=Color3.fromRGB(10,12,18)
        btn.BackgroundTransparency=0.35
        btn.BorderSizePixel=0
        btn.Parent=tbGui
        registerScaleTarget(btn)
        loadAndClampPosition(btn,"toggleBtn",UDim2.new(0,12,1,-56))
        _regDraggable(btn,function()return UDim2.new(0,12,1,-56)end)
        Instance.new("UICorner",btn).CornerRadius=UDim.new(0,10)
        local outerStroke=Instance.new("UIStroke",btn)
        outerStroke.Thickness=1.5
        outerStroke.Color=COLORS.Accent
        outerStroke.Transparency=0.1
        outerStroke.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
        trackStroke(outerStroke)
        local outerGrad=Instance.new("UIGradient",outerStroke)
        outerGrad.Color=ColorSequence.new({
            ColorSequenceKeypoint.new(0,Color3.fromRGB(0,217,127)),
            ColorSequenceKeypoint.new(0.25,Color3.fromRGB(120,255,210)),
            ColorSequenceKeypoint.new(0.5,Color3.fromRGB(150,255,180)),
            ColorSequenceKeypoint.new(0.75,Color3.fromRGB(120,255,210)),
            ColorSequenceKeypoint.new(1,Color3.fromRGB(0,217,127))
        })
        trackGradient(outerGrad)
        local CELL=10
        local GAP=4
        local TOTAL=CELL*2+GAP
        local OX=math.floor((42-TOTAL)/2)
        local OY=math.floor((42-TOTAL)/2)
        local positions={
            {OX,OY},
            {OX+CELL+GAP,OY},
            {OX,OY+CELL+GAP},
            {OX+CELL+GAP,OY+CELL+GAP},
        }
        local cells={}
        for _,pos in ipairs(positions)do
            local cell=Instance.new("Frame",btn)
            cell.Size=UDim2.new(0,CELL,0,CELL)
            cell.Position=UDim2.new(0,pos[1],0,pos[2])
            cell.BackgroundColor3=COLORS.Accent
            cell.BackgroundTransparency=0
            cell.BorderSizePixel=0
            Instance.new("UICorner",cell).CornerRadius=UDim.new(0,3)
            trackFrame(cell)
            table.insert(cells,cell)
        end
        local getTbIsTap=makeDraggable(btn,btn,"toggleBtn",function()return CONFIG.UI_LOCKED end,
            function()
            end
        )
        btn.InputEnded:Connect(function(inp)
            if inp.UserInputType~=Enum.UserInputType.MouseButton1 and
               inp.UserInputType~=Enum.UserInputType.Touch then return end
            if not getTbIsTap()then return end
            guiVisible=not guiVisible
            if mainFrame then mainFrame.Visible=guiVisible end
            CONFIG.MAIN_GUI_VISIBLE=guiVisible
            saveConfig()
            for _,c in ipairs(cells)do
                TweenService:Create(c,TweenInfo.new(0.08,Enum.EasingStyle.Quad),{
                    BackgroundTransparency=0.5
                }):Play()
            end
            task.delay(0.12,function()
                for _,c in ipairs(cells)do
                    TweenService:Create(c,TweenInfo.new(0.1,Enum.EasingStyle.Quad),{
                        BackgroundTransparency=0
                    }):Play()
                end
            end)
        end)
        pcall(function()
            applyAccentColor(CONFIG.GUI_COLOR_R or 0,CONFIG.GUI_COLOR_G or 217,CONFIG.GUI_COLOR_B or 127)
        end)
        return tbGui
    end

    createToggleButton()

    task.spawn(function()
        task.wait(0.5)
        reapplyAllSettings()
        pcall(function()
            if CONFIG.HARDER_HIT_ENABLED then startHarderHitAnim()end
        end)
    end)

    RunService.Heartbeat:Connect(function()
        if not CONFIG.FOV_LOCK_ENABLED then return end
        pcall(function()
            local cam=workspace.CurrentCamera
            if cam and math.abs(cam.FieldOfView-(CONFIG.FOV_VALUE or 70))>0.1 then
                cam.FieldOfView=CONFIG.FOV_VALUE or 70
            end
        end)
    end)

end


local function _showLooprixIntro(onDone)
	local snd = Instance.new("Sound")
	snd.SoundId = "rbxassetid://99614198228986"
	snd.Volume = 0.5
	snd.RollOffMaxDistance = 10000
	snd.Parent = workspace
	pcall(function() snd:Play(); snd.TimePosition = 24 end)
	task.spawn(function()
		task.wait(10)
		local fadeOut = TweenService:Create(snd, TweenInfo.new(2.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Volume = 0})
		fadeOut:Play()
		fadeOut.Completed:Wait()
		pcall(function() snd:Stop(); snd:Destroy() end)
	end)

	local introScreenGui = Instance.new("ScreenGui")
	introScreenGui.Name = "LooprixHub"
	introScreenGui.ResetOnSpawn = false
	introScreenGui.IgnoreGuiInset = true
	introScreenGui.DisplayOrder = 999999999
	introScreenGui.Parent = PlayerGui

	local holder = Instance.new("Frame")
	holder.Size = UDim2.new(0, 400, 0, 50)
	holder.Position = UDim2.new(0.5, -200, 0.5, -25)
	holder.BackgroundTransparency = 1
	holder.Parent = introScreenGui

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -20, 1, 0)
	label.Position = UDim2.new(0, 0, 0, 0)
	label.BackgroundTransparency = 1
	label.Text = ""
	label.TextColor3 = COLORS.Accent
	label.TextSize = 26
	label.Font = Enum.Font.GothamBold
	label.TextXAlignment = Enum.TextXAlignment.Center
	label.TextTransparency = 0
	label.Parent = holder
	trackLabel(label)

	local textStroke = Instance.new("UIStroke")
	textStroke.Color = COLORS.Accent
	textStroke.Thickness = 1.5
	textStroke.Transparency = 0.5
	textStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
	textStroke.Parent = label
	trackStroke(textStroke)

	local cursor = Instance.new("Frame")
	cursor.Size = UDim2.new(0, 2, 0.55, 0)
	cursor.BackgroundColor3 = COLORS.Accent
	cursor.BackgroundTransparency = 1
	cursor.BorderSizePixel = 0
	cursor.Parent = holder
	trackFrame(cursor)

	local cursorCorner = Instance.new("UICorner")
	cursorCorner.CornerRadius = UDim.new(0, 2)
	cursorCorner.Parent = cursor

	local cursorStroke = Instance.new("UIStroke")
	cursorStroke.Color = COLORS.Accent
	cursorStroke.Thickness = 1.2
	cursorStroke.Transparency = 0.2
	cursorStroke.Parent = cursor
	trackStroke(cursorStroke)

	local soundFolder = Instance.new("Folder")
	soundFolder.Parent = workspace

	local soundIds = {
		"rbxassetid://9119713951",
		"rbxassetid://9119713951",
		"rbxassetid://9119713951",
	}

	local sounds = {}
	for _, id in ipairs(soundIds) do
		local s = Instance.new("Sound")
		s.SoundId = id
		s.Volume = 0.35
		s.Parent = soundFolder
		table.insert(sounds, s)
	end

	local function playClick()
		local s = sounds[math.random(1, #sounds)]
		s.PlaybackSpeed = 0.92 + math.random(0, 16) / 100
		s:Play()
	end

	local cursorConn = nil

	local function startBlink()
		if cursorConn then cursorConn:Disconnect() end
		cursorConn = RunService.Heartbeat:Connect(function()
			cursor.BackgroundTransparency = (tick() % 1 < 0.5) and 0 or 1
			cursorStroke.Transparency = (tick() % 1 < 0.5) and 0.2 or 1
		end)
	end

	local function stopBlink()
		if cursorConn then cursorConn:Disconnect() end
		cursor.BackgroundTransparency = 1
		cursorStroke.Transparency = 1
	end

	local function moveCursor()
		local textWidth = label.TextBounds.X
		local centerOffset = -textWidth / 2
		cursor.Position = UDim2.new(0.5, centerOffset + textWidth + 5, 0.22, 0)
	end

	local fullText = "Looprix Hub"

	task.spawn(function()
		startBlink()

		for i = 1, #fullText do
			label.Text = string.sub(fullText, 1, i)
			moveCursor()
			playClick()
			task.wait(0.08)
		end

		task.wait(2.5)
		stopBlink()

		local steps = 40
		for i = 0, steps do
			local a = i / steps
			label.TextTransparency = a
			textStroke.Transparency = 0.2 + a * 0.8
			task.wait(0.6 / steps)
		end

		label.Text = ""
		introScreenGui:Destroy()
		if onDone then onDone() end
	end)
end

_showLooprixIntro(function()
	_main()
end)
