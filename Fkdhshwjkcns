-- ======================================
-- DUPLICATE RUN GUARD
-- ======================================
if getgenv and getgenv().LOOPRIX_RUNNING then
    return  -- script already loaded, do not run again
end
if getgenv then getgenv().LOOPRIX_RUNNING = true end

-- ======================================
-- LOOPRIX CONFIGURATION SYSTEM
-- ======================================

CONFIG = {
    -- gui panels
    LOCK_TARGET_PANEL_VISIBLE = false,
    DROP_BRAINROT_PANEL_VISIBLE = false,
    SPEED_GUI_VISIBLE = false,
    SPEED_LAGGER_GUI_VISIBLE = false,
    SPEED_LAGGER_ENABLED     = false,
    SPEED_LAGGER_LAG         = 50,   -- 0-100
    SPEED_LAGGER_SPEED       = 50,   -- 0-100
    SPEED_LAGGER_KEYBIND     = nil,
    FLING_PANEL_VISIBLE = false,
    FLOAT_PANEL_VISIBLE = false,
    FLOAT_ACTIVE = false,
    SPINBOT_PANEL_VISIBLE = false,
    TAUNT_PANEL_VISIBLE = false,
    ANTI_STEAL_PANEL_VISIBLE = false,
    AUTO_LOCK_PANEL_VISIBLE = false,
    TP_DOWN_PANEL_VISIBLE = false,
    AUTO_WALK_PANEL_VISIBLE = false,
    AUTO_PLAY_GUI_VISIBLE = false,
    DESYNC_PANEL_VISIBLE = false,
    LAGGER_GUI_VISIBLE = false,
    ACTIVE_HUD_VISIBLE = false,
    GRAB_BAR_VISIBLE = true,
    MAIN_GUI_VISIBLE = true,
    -- toggles
    AUTO_BAT_ENABLED = false,
    AIMBOT_ENABLED = false,
    SPINBOT_ENABLED = false,
    ANTIRAGDOLL_ENABLED = false,
    ANTIRAGDOLL_V2_ENABLED = false,
    UNWALK_ENABLED = false,
    ESP_ENABLED = false,
    INF_JUMP_ENABLED = false,
    OPTIMIZER_ENABLED = false,
    XRAY_ENABLED = false,
    LOCK_TARGET_ENABLED = false,
    AUTO_MEDUSA_ENABLED = false,
    MEDUSA_COUNTER_ENABLED = false,
    INSTANT_GRAB_ENABLED = false,
    ANTI_DIE_ENABLED = true,
    UI_LOCKED = false,
    SPEED_ENABLED = false,
    NO_COLLISION_ENABLED = false,
    NO_CAM_COLLISION_ENABLED = false,
    HARDER_HIT_ENABLED = false,
    TP_DOWN_ENABLED = false,
    AUTO_TP_DOWN_ENABLED = false,
    DESYNC_ENABLED = false,
    AUTO_REACT_STEAL_ENABLED = false,
    ANTI_LOCK_ENABLED = false,
    ANTI_LOCK_PANEL_VISIBLE = false,
    FAST_PANEL_ENABLED = false,
    SPEED_METER_ENABLED = false,
    NOTIFICATIONS_ENABLED = false,
    POST_DROP_HALT_ENABLED = false,   -- Auto Stop on Drop: stop AutoPlay on drop
    SNAP_LOCK_ENABLED = false,        -- Lock on Drop: 0.5s lock-on after drop
    AUTO_LOAD_ENABLED = false,        -- Auto Load on Kick
    -- values
    SPEED_VALUE = 60,
    STEAL_SPEED_VALUE = 30,
    SPEED_PRESET = "normal",
    -- per-preset stored values (each preset saves independently)
    PRESET_NORMAL_SPEED = 60,
    PRESET_NORMAL_STEAL = 30,
    PRESET_DESYNC_SPEED = 40,
    PRESET_DESYNC_STEAL = 20,
    PRESET_LAGGER_SPEED = 15,
    PRESET_LAGGER_STEAL = 8,
    AIMBOT_RANGE = 40,
    AIMBOT_DISABLE_RANGE = 45,
    AIMBOT_FLAT_REMOVE_DIST = 20,
    SPINBOT_SPEED = 30,
    LOCK_TARGET_SPEED = 55,
    LOCK_TARGET_3D_DISTANCE = 10,
    MIRROR_TP_DOWN_ENABLED = false,
    MIRROR_TP_DOWN_THRESHOLD = 8,
    AUTO_MEDUSA_RANGE = 5,
    INSTANT_GRAB_ACTIVATION_DIST = 8,
    FLOAT_HEIGHT = 10,
    FLOAT_SPEED = 50,
    FOV_VALUE = 70,
    GUI_COLOR_R = 0,
    GUI_COLOR_G = 217,
    GUI_COLOR_B = 127,
    UI_SCALE = 1.0,
    AUTO_PLAY_DELAY = 0.03,
    -- lagger settings
    LAGGER_SPAM = 270,
    LAGGER_TRIES = 1,
    LAGGER_DELAY = 0.3,
    -- keybinds
    TOGGLE_GUI_KEYBIND = nil,
    AUTO_BAT_KEYBIND = nil,
    AIMBOT_KEYBIND = nil,
    SPINBOT_KEYBIND = nil,
    LOCK_TARGET_KEYBIND = nil,
    AUTO_MEDUSA_KEYBIND = nil,
    INSTANT_GRAB_KEYBIND = nil,
    DROP_BRAINROT_KEYBIND = nil,
    FLOAT_KEYBIND = nil,
    AUTO_PLAY_KEYBIND = nil,
    FLING_KEYBIND = nil,
    ANTI_STEAL_KEYBIND = nil,
    AUTO_LOCK_KEYBIND = nil,
    AUTO_WALK_KEYBIND = nil,
    TP_DOWN_KEYBIND = nil,
    AUTO_REACT_STEAL_KEYBIND = nil,
    DESYNC_KEYBIND = nil,
    -- gui positions (populated at runtime)
    _guiPositions = nil,
    _autoPlayOffsets = nil,
    _apBasePositions = nil,
}
getgenv().LOOPRIX_CONFIG = CONFIG

-- ======================================
-- UI SCALE SYSTEM
-- ======================================

scaleMultiplier = 1.0

_registeredScaleInstances = {}  -- list of { us = UIScale, base = number }

-- Register a UIScale on `frame`. `baseScale` is the element's natural base (default 1.0).
-- At slider=100 (multiplier=1.0), the final Scale = base * 1.0 = base → original appearance.
function registerScaleTarget(frame, baseScale)
    baseScale = baseScale or 1.0
    if not frame then return nil end
    local existing = frame:FindFirstChildOfClass("UIScale")
    if existing then
        existing.Scale = baseScale * scaleMultiplier
        table.insert(_registeredScaleInstances, { us = existing, base = baseScale })
        return existing
    else
        local us = Instance.new("UIScale")
        us.Scale = baseScale * scaleMultiplier
        us.Parent = frame
        table.insert(_registeredScaleInstances, { us = us, base = baseScale })
        return us
    end
end

-- Push a new multiplier to all registered UIScale instances.
-- Each element's final Scale = its individual base * multiplier.
function applyUIScale(scale)
    scale = math.clamp(scale, 0.5, 1.25)
    scaleMultiplier = scale
    CONFIG.UI_SCALE = scale
    for _, entry in ipairs(_registeredScaleInstances) do
        pcall(function()
            if entry.us and entry.us.Parent then
                entry.us.Scale = entry.base * scale
            end
        end)
    end
end

-- ======================================
-- CONFIG SAVE / LOAD
-- ======================================

CONFIG_FILE = "LooprixDuel.json"

-- ======================================
-- DRAG / CLAMP UTILITY
-- ======================================

_UIS = game:GetService("UserInputService")
_RS  = game:GetService("RunService")

-- Returns the absolute pixel size of the current viewport.
function _getViewport()
    local cam = workspace.CurrentCamera
    return cam and cam.ViewportSize or Vector2.new(1920, 1080)
end

-- Clamps frame so it stays fully inside the viewport (pure pixel math, Scale=0 output).
function clampToScreen(frame, padX, padY)
    padX = padX or 4
    padY = padY or 4
    local vp   = _getViewport()
    local size = frame.AbsoluteSize
    local cx   = math.clamp(frame.AbsolutePosition.X, padX, vp.X - size.X - padX)
    local cy   = math.clamp(frame.AbsolutePosition.Y, padY, vp.Y - size.Y - padY)
    frame.Position = UDim2.fromOffset(cx, cy)
end

function makeDraggable(frame, handle, saveKey, lockedFn, onSaved)
    handle   = handle   or frame
    lockedFn = lockedFn or function() return false end

    local drag, ds, sp, dragConn = false, nil, nil, nil
    local lastDragUpdate = 0
    local wasDrag = false

    handle.InputBegan:Connect(function(inp)
        if lockedFn() then return end
        if inp.UserInputType ~= Enum.UserInputType.MouseButton1 and
           inp.UserInputType ~= Enum.UserInputType.Touch then return end
        drag = true; ds = inp.Position; sp = frame.Position; wasDrag = false
        if dragConn then dragConn:Disconnect() end
        dragConn = inp.Changed:Connect(function()
            if inp.UserInputState == Enum.UserInputState.End then
                drag = false
                if dragConn then dragConn:Disconnect(); dragConn = nil end
                if wasDrag and saveKey then
                    CONFIG._guiPositions = CONFIG._guiPositions or {}
                    CONFIG._guiPositions[saveKey] = {
                        scaleX=0, scaleY=0,
                        offsetX=frame.Position.X.Offset,
                        offsetY=frame.Position.Y.Offset,
                    }
                    saveConfig()
                    if onSaved then onSaved() end
                end
            end
        end)
    end)

    _UIS.InputChanged:Connect(function(inp)
        if lockedFn() then return end
        if not drag then return end
        if inp.UserInputType ~= Enum.UserInputType.MouseMovement and
           inp.UserInputType ~= Enum.UserInputType.Touch then return end
        local now = tick()
        if now - lastDragUpdate < 0.016 then return end
        lastDragUpdate = now
        local d = inp.Position - ds
        local vp = _getViewport()
        local size = frame.AbsoluteSize
        local nx = math.clamp(sp.X.Offset + d.X, 4, vp.X - size.X - 4)
        local ny = math.clamp(sp.Y.Offset + d.Y, 4, vp.Y - size.Y - 4)
        frame.Position = UDim2.fromOffset(nx, ny)
        wasDrag = true
    end)

    return function() return not wasDrag end
end

-- Safe position loader: reads CONFIG._guiPositions[key], applies it to frame,
-- then immediately clamps to screen.  Falls back to `defaultPos` if no saved data.
function loadAndClampPosition(frame, key, defaultPos)
    local pos = CONFIG._guiPositions and CONFIG._guiPositions[key]
    if pos then
        frame.Position = UDim2.new(pos.scaleX or 0, pos.offsetX or 0,
                                    pos.scaleY or 0, pos.offsetY or 0)
    elseif defaultPos then
        frame.Position = defaultPos
    end
    -- Wait one frame so AbsoluteSize is computed, then clamp
    task.defer(function()
        if frame and frame.Parent then clampToScreen(frame) end
    end)
end


-- ======================================
-- CONFIG SYSTEM  (versioned, auto-repair, debounced — fish2 style)
-- ======================================

CONFIG_VERSION = 4

_KEYBIND_SET = {
    TOGGLE_GUI_KEYBIND=true, AUTO_BAT_KEYBIND=true, AIMBOT_KEYBIND=true,
    SPINBOT_KEYBIND=true, LOCK_TARGET_KEYBIND=true, AUTO_MEDUSA_KEYBIND=true,
    INSTANT_GRAB_KEYBIND=true, DROP_BRAINROT_KEYBIND=true, FLOAT_KEYBIND=true,
    AUTO_PLAY_KEYBIND=true, FLING_KEYBIND=true, ANTI_STEAL_KEYBIND=true,
    AUTO_LOCK_KEYBIND=true, AUTO_WALK_KEYBIND=true, TP_DOWN_KEYBIND=true,
    AUTO_REACT_STEAL_KEYBIND=true, SPEED_LAGGER_KEYBIND=true,
    DESYNC_KEYBIND=true,
}

_TABLE_KEYS = { _guiPositions=true, _autoPlayOffsets=true, _apBasePositions=true }

_savePending = false

function _doWrite()
    pcall(function()
        if not writefile then return end
        local cfg = {}
        for k, v in pairs(CONFIG) do
            if _KEYBIND_SET[k] then
                if v ~= nil then
                    if type(v) == "table" and v.Type and v.Key then
                        -- new format: {Type="Keyboard"/"Gamepad", Key=KeyCode}
                        cfg[k] = {type = v.Type, key = v.Key.Name}
                    elseif type(v) ~= "table" then
                        -- legacy: raw KeyCode → upgrade to new format on save
                        cfg[k] = {type = "Keyboard", key = v.Name}
                    end
                end
            elseif _TABLE_KEYS[k] then
                if v ~= nil then cfg[k] = v end
            elseif type(v) ~= "function" and v ~= nil then
                cfg[k] = v
            end
        end
        cfg.MAIN_GUI_VISIBLE = guiVisible
        cfg._version = CONFIG_VERSION
        writefile(CONFIG_FILE, game:GetService("HttpService"):JSONEncode(cfg))
    end)
end

function saveConfig()
    if _savePending then return end
    _savePending = true
    task.delay(0.65, function()
        _savePending = false
        _doWrite()
    end)
end

function loadConfig()
    -- No file → write defaults and return
    if not isfile or not isfile(CONFIG_FILE) then
        _doWrite()
        return
    end
    -- Read file
    local raw
    local readOk = pcall(function() raw = readfile(CONFIG_FILE) end)
    if not readOk or type(raw) ~= "string" or raw == "" then
        _doWrite()
        return
    end
    -- Decode JSON
    local decodeOk, decoded = pcall(function()
        return game:GetService("HttpService"):JSONDecode(raw)
    end)
    if not decodeOk or type(decoded) ~= "table" then
        _doWrite()
        return
    end
    -- Auto-repair: fill missing keys with defaults
    for k, defaultVal in pairs(CONFIG) do
        if decoded[k] == nil and not _KEYBIND_SET[k] and not _TABLE_KEYS[k] then
            decoded[k] = defaultVal
        end
    end
    local savedVer = tonumber(decoded._version) or 0
    -- Apply decoded values to CONFIG
    for k, v in pairs(decoded) do
        if k == "_version" then
            -- skip
        elseif _KEYBIND_SET[k] then
            if type(v) == "string" and v ~= "" then
                -- very old format: bare key name string → treat as Keyboard
                local ok2, kc = pcall(function() return Enum.KeyCode[v] end)
                if ok2 and kc then CONFIG[k] = {Type = "Keyboard", Key = kc} end
            elseif type(v) == "table" and type(v.type) == "string"
                   and type(v.key) == "string" and v.key ~= "" then
                -- new format: {type="Keyboard"/"Gamepad", key="ButtonA"/"E"}
                local ok2, kc = pcall(function() return Enum.KeyCode[v.key] end)
                if ok2 and kc then CONFIG[k] = {Type = v.type, Key = kc} end
            end
        elseif k == "_guiPositions" then
            if type(v) == "table" then
                local safe = {}
                for pk, pv in pairs(v) do
                    if type(pv) == "table" then safe[pk] = pv end
                end
                CONFIG._guiPositions = safe
            end
        elseif k == "_autoPlayOffsets" then
            if type(v) == "table" then CONFIG._autoPlayOffsets = v end
        elseif k == "_apBasePositions" then
            -- AP offsets applied separately after AP is initialized (see init section)
            if type(v) == "table" then CONFIG._apBasePositions = v end
        elseif k == "MAIN_GUI_VISIBLE" then
            if type(v) == "boolean" then guiVisible = v
            elseif v == 1 or v == "true" then guiVisible = true
            else guiVisible = false end
        elseif CONFIG[k] ~= nil then
            local expected = type(CONFIG[k])
            if expected == "boolean" then
                if type(v) == "boolean" then CONFIG[k] = v
                elseif v == 1 or v == "true" then CONFIG[k] = true
                elseif v == 0 or v == "false" then CONFIG[k] = false end
            elseif expected == "number" then
                local n = tonumber(v)
                if n then CONFIG[k] = n end
            else
                CONFIG[k] = v
            end
        end
    end
    scaleMultiplier = math.clamp(CONFIG.UI_SCALE or 1.0, 0.5, 1.25)
    pcall(function()
        local cam = workspace.CurrentCamera
        if cam then cam.FieldOfView = CONFIG.FOV_VALUE or 70 end
    end)
    getgenv().LOOPRIX_CONFIG = CONFIG
    -- Write back if version changed (silent upgrade)
    if savedVer ~= CONFIG_VERSION then
        _doWrite()
    end
end

function saveGuiPosition(frame, pathParts)
    if not frame or not pathParts then return end
    CONFIG._guiPositions = CONFIG._guiPositions or {}
    CONFIG._guiPositions[pathParts] = {
        scaleX  = frame.Position.X.Scale,
        scaleY  = frame.Position.Y.Scale,
        offsetX = frame.Position.X.Offset,
        offsetY = frame.Position.Y.Offset
    }
    saveConfig()
end

function loadGuiPosition(frame, pathParts)
    if not frame or not pathParts then return end
    CONFIG._guiPositions = CONFIG._guiPositions or {}
    local pos = CONFIG._guiPositions[pathParts]
    if pos then
        frame.Position = UDim2.new(pos.scaleX, pos.offsetX, pos.scaleY, pos.offsetY)
    end
end


-- ======================================

COLORS = {
    Background             = Color3.fromRGB(12, 14, 20),
    BackgroundTransparency = 0.1,
    Surface                = Color3.fromRGB(20, 24, 34),
    SurfaceTransparency    = 0.10,
    Text    = Color3.fromRGB(255, 255, 255),
    TextDim = Color3.fromRGB(180, 190, 200),
    Accent  = Color3.new(0.000000, 0.850980, 0.498039),
    Purple = Color3.new(0.125490, 0.898039, 0.549020),
    Pink   = Color3.fromRGB(150, 255, 180),
    Cyan   = Color3.fromRGB(120, 255, 210),
    Yellow = Color3.fromRGB(255, 235, 120),
    Blue   = Color3.fromRGB(140, 200, 255),
    Red    = Color3.fromRGB(255, 100, 120),
}

-- Dynamic color tracking for live color updates
_accentStrokes   = {}  -- { UIStroke }
_accentFrames    = {}  -- { Frame / TextButton }
_accentLabels    = {}  -- { TextLabel / TextButton }
_accentGradients = {}  -- { UIGradient, colorSeqBuilder }
_accentDots      = {}  -- { Frame } small dot indicators

function _buildAccentGradient(r, g, b)
    local c = Color3.fromRGB(r, g, b)
    local bright = Color3.fromRGB(
        math.min(r + 80, 255),
        math.min(g + 40, 255),
        math.min(b + 60, 255)
    )
    return ColorSequence.new({
        ColorSequenceKeypoint.new(0,    c),
        ColorSequenceKeypoint.new(0.33, bright),
        ColorSequenceKeypoint.new(0.66, bright),
        ColorSequenceKeypoint.new(1,    c)
    })
end

function applyAccentColor(r, g, b)
    local newColor = Color3.fromRGB(r, g, b)
    COLORS.Accent = newColor
    CONFIG.GUI_COLOR_R = r
    CONFIG.GUI_COLOR_G = g
    CONFIG.GUI_COLOR_B = b

    for _, s in ipairs(_accentStrokes) do
        pcall(function() if s and s.Parent then s.Color = newColor end end)
    end
    for _, f in ipairs(_accentFrames) do
        pcall(function() if f and f.Parent then f.BackgroundColor3 = newColor end end)
    end
    for _, l in ipairs(_accentLabels) do
        pcall(function() if l and l.Parent then l.TextColor3 = newColor end end)
    end
    for _, d in ipairs(_accentDots) do
        pcall(function() if d and d.Parent then d.BackgroundColor3 = newColor end end)
    end
    local gradSeq = _buildAccentGradient(r, g, b)
    for _, g2 in ipairs(_accentGradients) do
        pcall(function() if g2 and g2.Parent then g2.Color = gradSeq end end)
    end
    -- Update live ESP colors
    pcall(updateEspAccentColor, r, g, b)
    -- Update medusa radius indicator color
    pcall(function()
        if medusaCircle and medusaCircle.Parent then
            medusaCircle.Color3 = newColor
        end
    end)
end

function trackStroke(s)   table.insert(_accentStrokes,   s)   return s   end
function trackFrame(f)    table.insert(_accentFrames,    f)   return f    end
function trackLabel(l)    table.insert(_accentLabels,    l)   return l    end
function trackGradient(g) table.insert(_accentGradients, g)   return g    end
function trackDot(d)      table.insert(_accentDots,      d)   return d    end

S = {
    Players           = game:GetService("Players"),
    UserInputService  = game:GetService("UserInputService"),
    TweenService      = game:GetService("TweenService"),
    HttpService       = game:GetService("HttpService"),
    RunService        = game:GetService("RunService"),
    Lighting          = game:GetService("Lighting"),
    ReplicatedStorage = game:GetService("ReplicatedStorage")
}

S.LocalPlayer = S.Players.LocalPlayer
S.PlayerGui   = S.LocalPlayer:WaitForChild("PlayerGui")

-- ======================================
-- GUI VARIABLES
-- ======================================

screenGui, mainFrame, contentFrame, tabBar = nil, nil, nil, nil
lockTargetPanelGui, lockTargetPanelBtn = nil, nil
dropBrainrotPanelGui, dropBrainrotPanelBtn = nil, nil
floatPanelGui, floatPanelBtn = nil, nil
spinbotPanelGui, spinbotPanelBtn = nil, nil
tauntPanelGui, tauntPanelBtn = nil, nil
flingPanelGui, flingPanelBtn = nil, nil
tpDownPanelGui, tpDownPanelBtn = nil, nil
antiLockPanelGui, antiLockPanelBtn = nil, nil
_aimbotBtn  = nil
_spinbotBtn = nil

guiVisible = true
isMinimized = false
currentTab = "duel"

attacking = false
aimbotEnabled = false
spinbotEnabled = false
unwalkEnabled = false
espEnabled = false
infJumpEnabled = false
optimizerEnabled = false
xrayEnabled = false
lockTargetEnabled = false
isSwitching = false
autoMedusaEnabled = false
instantGrabEnabled = false

-- Medusa Counter state (K7 logic)
medusaCounterEnabled = false
medusaCounterConns = {}
MEDUSA_COUNTER_COOLDOWN = 25
medusaCounterLastUsed = 0
medusaCounterDebounce = false
antiDieEnabled = false

speedGuiEnabled = false
speedGuiInstance = nil
laggerGuiInstance = nil
speedLaggerGuiInstance = nil

-- Speed Lagger runtime state
_slEnabled      = false
_slThread       = nil
_slRenderConn   = nil
_slWasSpeedOn   = false   -- remember speed state before SL turned on
_laggerEnabled = false
_laggerLoopThread = nil

-- Module-level input box refs (for Reset Config)
_speedValBox    = nil   -- Speed GUI: Speed
_stealValBox    = nil   -- Speed GUI: Steal Spd
_lagSpamBox     = nil   -- Lagger GUI: Spam
_lagTriesBox    = nil   -- Lagger GUI: Tries
_lagDelayBox    = nil   -- Lagger GUI: Delay
_slLagBox       = nil   -- SpeedLagger GUI: Lagger
_slSpeedBox     = nil   -- SpeedLagger GUI: Speed

-- ── Auto Play state (single table = 1 local instead of 17) ───────────────
AP = {
    enabled      = false,
    loopConn     = nil,
    currentStep  = 1,
    isWaiting    = false,
    activeSide   = nil,
    settingsOpen = false,
    settingsSide = "L",
    btnL         = nil,
    btnR         = nil,
    guiInstance  = nil,
    espFolder    = nil,
    espParts     = {},
    BASE = {
        L = {
            P1 = Vector3.new(-485.04, -4.90,  26.11),
            P2 = Vector3.new(-476.52, -6.42,  28.10),
            P3 = Vector3.new(-475.17, -6.93,  92.61),
            P4 = Vector3.new(-476.06, -6.64,  94.73),
            P5 = Vector3.new(-483.34, -5.10,  97.76),
        },
        R = {
            P1 = Vector3.new(-484.70, -5.00,  94.59),
            P2 = Vector3.new(-476.28, -6.58,  93.77),
            P3 = Vector3.new(-474.70, -7.00,  28.32),
            P4 = Vector3.new(-476.26, -6.58,  26.00),
            P5 = Vector3.new(-483.50, -5.10,  23.27),
        },
    },
    SEQUENCE   = {"P3","P4","P5","P4","P2","P1"},
    POINT_KEYS = {"P1","P2","P3","P4","P5"},
    offsets = {
        L = { P1={x=0,z=0}, P2={x=0,z=0}, P3={x=0,z=0}, P4={x=0,z=0}, P5={x=0,z=0} },
        R = { P1={x=0,z=0}, P2={x=0,z=0}, P3={x=0,z=0}, P4={x=0,z=0}, P5={x=0,z=0} },
    },
    sideBoxes = {
        L = { P1={x="0",z="0"}, P2={x="0",z="0"}, P3={x="0",z="0"}, P4={x="0",z="0"}, P5={x="0",z="0"} },
        R = { P1={x="0",z="0"}, P2={x="0",z="0"}, P3={x="0",z="0"}, P4={x="0",z="0"}, P5={x="0",z="0"} },
    },
    _plotReady    = false,  -- set true once base is found by background scan
    -- Auto side detection (background poll)
    _autoSide     = nil,    -- "L" or "R" once locked
    _sideLocked   = false,  -- true after 3 consistent detections
    _sideVotes    = {L=0, R=0},  -- vote counter per side
    _stepStartTick = 0,     -- used for step timeout anti-stuck
}
apBtnL, apBtnR, apGuiInstance = nil, nil, nil


aimbotConnection = nil
spinbotConnection = nil
espConnection = nil
infJumpConnection = nil
lockTargetConnection = nil
autoMedusaConnection = nil
medusaCharAddedConnection = nil
instantGrabConnection = nil
instantGrabProgressConnection = nil
antiDieConnection = nil
speedBoostConn = nil

alignOri = nil
attach0 = nil
spinBAV = nil
savedAnimations = {}
originalTransparency = {}
medusaCircle = nil

_ltLockedTarget        = nil    -- locked target for new lock target chase
_ltLastTargetY         = nil    -- previous Y of locked target HRP (tp-down detector)
_ltTpMirrorInProgress  = false  -- re-entry guard for mirror tp-down
_fastPanelBurgerFrame = nil
_espHitboxes = {}
-- Registry for resettable draggable frames: {frame, defaultPosFn}
_draggableRegistry = {}
function _regDraggable(frame, defaultPosFn)
    table.insert(_draggableRegistry, {frame=frame, defaultFn=defaultPosFn})
end
-- All duel-tab toggle buttons (filled during createDuelTab) for visual reset
_duelToggleBtns = {}   -- { {btn, defaultOn} }
-- speed meter (k7 style)
_speedMeterBB         = nil   -- BillboardGui on head
_speedMeterLabel      = nil   -- TextLabel inside BB
_speedMeterUpdateConn = nil   -- RenderStepped connection
_speedMeterCharConn   = nil   -- CharacterAdded reconnect
_discordBB            = nil   -- BillboardGui: discord label above head
_discordCharConn      = nil   -- CharacterAdded reconnect for discord BB


tweenInfoFast   = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
tweenInfoMedium = TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

antiRagdollEnabled = false

ANTI_RAGDOLL = {
    enabled = false,
    connections = {},
    cachedCharData = {}
}

character = S.LocalPlayer.Character or S.LocalPlayer.CharacterAdded:Wait()
HRP = character:WaitForChild("HumanoidRootPart")

connections = {}
cleanupFunctions = {}

-- ======================================
-- CONNECTION MANAGEMENT
-- ======================================


-- ======================================
-- STATE VARIABLES (moved from _main to fix register limit)
-- ======================================


_sideDetected = false
_currentSide  = nil

-- Known world-space positions of each PlotSign (plots 3 and 7)
_PLOT_POSITIONS = {
    [3] = Vector3.new(-476.7524719238281, 10.464664459228516,   7.107429504394531),
    [7] = Vector3.new(-476.7524719238281, 10.464664459228516, 114.10742950439453),
}
-- Plot number → gameplay side: plot 3 = L (Z≈7), plot 7 = R (Z≈114)
_PLOT_TO_SIDE = { [3] = "L", [7] = "R" }

antiDieConnections = {}

_arV2Conn    = nil
_arV2Enabled = false

_toastGui        = nil
_toastContainer  = nil
_toastCount      = 0

dropBrainrotActive = false
DROP_ASCEND_DURATION = 0.2
DROP_ASCEND_SPEED    = 150

_harderHitAnims = {
    idle1    = "rbxassetid://133806214992291",
    idle2    = "rbxassetid://94970088341563",
    walk     = "rbxassetid://707897309",
    run      = "rbxassetid://707861613",
    jump     = "rbxassetid://116936326516985",
    fall     = "rbxassetid://116936326516985",
    climb    = "rbxassetid://116936326516985",
    swim     = "rbxassetid://116936326516985",
    swimidle = "rbxassetid://116936326516985",
}
_savedOrigAnims = nil
_animHeartbeatConn = nil

_autoBatGen = 0

ESP_NAME      = "Looprix_Esp"
ESP_BEAM_NAME = "Looprix_EspBeam"
espCache      = {}   -- [player] = { highlight, beam, beamAtt0, charConn }
_espHighlights = {}  -- for accent color tracking
_espBeams      = {}  -- for accent color tracking

flingEnabled   = false
_flingLoopConn = nil
_flingMoveL    = 0.1
FLING_STRENGTH = 10000
FLING_UP_FORCE = 100

AW = {
    enabled     = false,
    loopConn    = nil,
    currentStep = 1,
    activeSide  = nil,
    WALK_SEQ    = {"P3","P4","P5"},
    BASE = {
        L = {
            P3 = Vector3.new(-475.17, -6.93,  92.61),
            P4 = Vector3.new(-476.06, -6.64,  94.73),
            P5 = Vector3.new(-483.34, -5.10,  97.76),
        },
        R = {
            P3 = Vector3.new(-474.70, -7.00,  28.32),
            P4 = Vector3.new(-476.26, -6.58,  26.00),
            P5 = Vector3.new(-483.50, -5.10,  23.27),
        },
    },
}
awGuiInstance = nil
awWalkBtnL    = nil
awWalkBtnR    = nil

_lockAlignOri = nil
_lockAttach   = nil

jumpForce = 50

_optThreads     = {}
_optConns       = {}
_optOriginal    = {}
_antiLagRunning = false
_antiLagConns   = {}
_cleanedChars   = {}  -- kept for compat, unused by new optimizer

PERF_FFLAGS = {
    ["DFIntTaskSchedulerTargetFps"]                      = 999,
    ["FFlagDebugGraphicsPreferVulkan"]                   = true,
    ["FFlagDebugGraphicsDisableDirect3D11"]              = true,
    ["FFlagDebugGraphicsPreferD3D11FL10"]                = false,
    ["DFFlagDebugRenderForceTechnologyVoxel"]            = true,
    ["FFlagDisablePostFx"]                               = true,
    ["FIntRenderShadowIntensity"]                        = 0,
    ["FIntRenderLocalLightUpdatesMax"]                   = 0,
    ["FIntRenderLocalLightUpdatesMin"]                   = 0,
    ["DFIntTextureCompositorActiveJobs"]                 = 1,
    ["DFIntDebugFRMQualityLevelOverride"]                = 1,
    ["FFlagFixPlayerCollisionWhenSwimming"]              = false,
    ["DFIntMaxInterpolationSubsteps"]                    = 0,
    ["DFIntS2PhysicsSenderRate"]                        = 15,
    ["DFIntConnectionMTUSize"]                          = 1492,
    ["DFIntCSGLevelOfDetailSwitchingDistance"]          = 0,
    ["DFIntCSGLevelOfDetailSwitchingDistanceL12"]       = 0,
    ["DFIntCSGLevelOfDetailSwitchingDistanceL23"]       = 0,
    ["DFIntCSGLevelOfDetailSwitchingDistanceL34"]       = 0,
    ["FFlagEnableInGameMenuChromeABTest3"]               = false,
    ["FFlagEnableInGameMenuModernization"]               = false,
    ["FFlagEnableReportAbuseMenuRoactABTest2"]           = false,
    ["FFlagDisableNewIGMinDUA"]                         = true,
    ["FFlagEnableAccessoryValidation"]                  = false,
    ["FFlagEnableV3MenuABTest3"]                        = false,
    ["FIntRobloxGuiBlurIntensity"]                      = 0,
    ["DFIntTimestepArbiterThresholdCFLThou"]            = 10,
    ["DFIntTextureQualityOverride"]                     = 1,
    ["DFIntPerformanceControlTextureQualityBestUtility"] = 1,
    ["DFIntTexturePoolSizeMB"]                          = 64,
    ["DFIntMaxFrameBufferSize"]                         = 1,
    ["DFIntParticleMaxCount"]                           = 100,
    ["FFlagEnableWaterReflections"]                     = false,
    ["DFIntWaterReflectionQuality"]                     = 0,
}

noCollisionConnection = nil

desyncEnabled = false
desyncLoopConn = nil
desyncPanelGui = nil
desyncPanelBtn = nil
-- Server position ESP (desync ghost)
_desyncEspCube        = nil
_desyncEspHB          = nil
desyncMode            = "mobile"
_desyncHooked         = false

_DESYNC_SPEED_FLAGS = {
    DisableDPIScale                                                              = true,
    S2PhysicsSenderRate                                                          = 15000,
    AngularVelocityLimit                                                         = 360,
    StreamJobNOUVolumeCap                                                        = 2147483647,
    GameNetDontSendRedundantDeltaPositionMillionth                               = 1,
    TimestepArbiterOmegaThou                                                     = 1073741823,
    MaxMissedWorldStepsRemembered                                                = -2147483648,
    GameNetPVHeaderRotationalVelocityZeroCutoffExponent                          = -5000,
    MaxAcceptableUpdateDelay                                                     = 1,
    GameNetDontSendRedundantNumTimes                                             = 1,
    StreamJobNOUVolumeLengthCap                                                  = 2147483647,
    CheckPVLinearVelocityIntegrateVsDeltaPositionThresholdPercent                = 1,
    TimestepArbiterHumanoidTurningVelThreshold                                   = 1,
    MaxTimestepMultiplierAcceleration                                            = 2147483647,
    SimOwnedNOUCountThresholdMillionth                                           = 2147483647,
    SimExplicitlyCappedTimestepMultiplier                                        = 2147483646,
    TimestepArbiterVelocityCriteriaThresholdTwoDt                                = 2147483646,
    CheckPVCachedVelThresholdPercent                                             = 10,
    ReplicationFocusNouExtentsSizeCutoffForPauseStuds                            = 2147483647,
    DebugSendDistInSteps                                                         = -2147483648,
    LargeReplicatorEnabled9                                                      = true,
    CheckPVDifferencesForInterpolationMinRotVelThresholdRadsPerSecHundredth      = 1,
    LargeReplicatorWrite5                                                        = true,
    MaxTimestepMultiplierContstraint                                             = 2147483647,
    MaxTimestepMultiplierBuoyancy                                                = 2147483647,
    CheckPVDifferencesForInterpolationMinVelThresholdStudsPerSecHundredth        = 1,
    TimestepArbiterHumanoidLinearVelThreshold                                    = 1,
    WorldStepMax                                                                 = 30,
    LargeReplicatorSerializeRead3                                                = true,
    GameNetPVHeaderLinearVelocityZeroCutoffExponent                              = -5000,
    CheckPVCachedRotVelThresholdPercent                                          = 10,
    DFIntCharacterMaxSpeed                                                       = "9999",
    DFIntMaxLinearVelocity                                                       = "9999",
    DFIntTaskSchedulerTargetFps                                                  = "240",
    DFIntPhysicsSenderRate                                                       = "240",
    PhysicsSenderMaxBandwidthBps                                                 = "20000",
    ServerMaxBandwith                                                            = "9999",
    MaxDataPacketPerSend                                                         = "2147483647",
    InterpolationFrameVelocityThresholdMillionth                                 = "1",
    InterpolationFramePositionThresholdMillionth                                 = "1",
}

_FLT = {conn=nil,enabled=false,curHip=0,tpInProgress=false,gen=0}

getconnections = getconnections or get_signal_cons or getconnects or (syn and syn.get_signal_cons)

STEAL_DURATION = 0.2
autoStealEnabled = false
isStealing = false
stealStartTime = nil
StealData = {}
autoStealConn = nil
stealProgressConnection = nil
stealFillFrame = nil

autoReactStealEnabled = false
_autoReactStealConn = nil
_autoReactStealCooldown = false

-- Anti Steal state (now a plain toggle, no floating panel)
antiStealEnabled = false
_antiStealConn   = nil
startAntiStealWatcher, stopAntiStealWatcher = nil, nil  -- forward decl

-- Auto Lock state (now a plain toggle, no floating panel)
autoLockEnabled2 = false
_autoLockConn    = nil
startAutoLockWatcher, stopAutoLockWatcher = nil, nil  -- forward decl

-- Anti Lock state (floating panel)
antiLockEnabled  = false
_antiLockConn    = nil
_antiLockHooked  = false

REACT_STEAL_KEYWORD = "someone is stealing"

_FP = {gui=nil,guiR=nil,visible=false}

_NCC = {enabled=false,conn=nil,parts={}}


function addConnection(conn)
    table.insert(connections, conn)
end

-- Forward declarations for post-drop features (assigned after lock/AP systems are ready)
_doSnapLock     = nil
_doPostDropHalt = nil

function clearConnections()
    for _, conn in ipairs(connections) do
        pcall(function() conn:Disconnect() end)
    end
    connections = {}
end

function registerCleanup(func)
    table.insert(cleanupFunctions, func)
end

function runCleanups()
    for _, f in ipairs(cleanupFunctions) do
        pcall(f)
    end
    cleanupFunctions = {}
end

-- ======================================
-- KEYBIND HELPERS  (keyboard + gamepad)
-- ======================================

-- Returns a human-readable display string for a bind value.
function _getBindDisplayText(bind)
    if not bind then return "None" end
    if type(bind) == "table" and bind.Type and bind.Key then
        if bind.Type == "Gamepad" then
            return "GP:" .. bind.Key.Name
        else
            return bind.Key.Name
        end
    elseif type(bind) ~= "table" then
        -- legacy: raw KeyCode object
        return bind.Name
    end
    return "None"
end

-- Returns true when `input` matches the stored bind (keyboard or gamepad).
function isKeybindPressed(bind, input)
    if not bind then return false end
    if input.KeyCode == Enum.KeyCode.Unknown then return false end
    local kc = input.KeyCode
    if type(bind) == "table" and bind.Type and bind.Key then
        if bind.Type == "Keyboard" then
            return input.UserInputType == Enum.UserInputType.Keyboard and kc == bind.Key
        elseif bind.Type == "Gamepad" then
            local isGP = input.UserInputType == Enum.UserInputType.Gamepad1
                      or input.UserInputType == Enum.UserInputType.Gamepad2
                      or input.UserInputType == Enum.UserInputType.Gamepad3
                      or input.UserInputType == Enum.UserInputType.Gamepad4
            return isGP and kc == bind.Key
        end
    else
        -- legacy: raw KeyCode (keyboard only)
        return input.UserInputType == Enum.UserInputType.Keyboard and kc == bind
    end
    return false
end


-- Read owner name from PlotSign's SurfaceGui TextLabels
function _getPlotOwnerText(plotSign)
    for _, child in ipairs(plotSign:GetDescendants()) do
        if child:IsA("SurfaceGui") then
            for _, label in ipairs(child:GetDescendants()) do
                if label:IsA("TextLabel") and label.Text ~= "" then
                    return label.Text
                end
            end
        end
    end
    return ""
end

-- Returns the plot number (3 or 7) owned by the local player, or nil.
function _getMyPlot()
    local lp = S.LocalPlayer
    for plotNum, pos in pairs(_PLOT_POSITIONS) do
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Name == "PlotSign" then
                if (obj.Position - pos).Magnitude < 1 then
                    local ownerText = _getPlotOwnerText(obj)
                    if ownerText:find(lp.Name, 1, true) or ownerText:find(lp.DisplayName, 1, true) then
                        return plotNum
                    end
                end
            end
        end
    end
    return nil
end

function _waitMyPlot()
    repeat task.wait(0.5) until _getMyPlot() ~= nil
end


function _detectSide()
    if _sideDetected then return _currentSide end
    local plotNum = _getMyPlot()
    if not plotNum then return nil end
    local side = _PLOT_TO_SIDE[plotNum]
    if side then
        _currentSide  = side
        _sideDetected = true
        return side
    end
    return nil
end

-- On-demand side detection: called only when Auto Play / Auto Walk is activated.
-- Returns "L", "R", or nil if plot not found.
function _detectSideNow()
    local plotNum = _getMyPlot()
    if not plotNum then return nil end
    local side = _PLOT_TO_SIDE[plotNum] or (plotNum == 7 and "R" or "L")
    _currentSide  = side
    _sideDetected = true
    AP._autoSide   = side
    AP._sideLocked = true
    AP._plotReady  = true
    return side
end

function GetSide()
    return _currentSide
end

-- Side detection is on-demand only (called by Auto Play / Auto Walk at launch)

-- ======================================
-- ANTI DIE SYSTEM
-- ======================================


function deactivateAntiDie()
    for _, conn in ipairs(antiDieConnections) do
        pcall(function() conn:Disconnect() end)
    end
    antiDieConnections = {}
    local char = S.LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    pcall(function() hum.BreakJointsOnDeath = true end)
    pcall(function() hum:SetStateEnabled(Enum.HumanoidStateType.Dead, true) end)
end

function activateAntiDie()
    deactivateAntiDie()
    local char = S.LocalPlayer.Character
    if not char then return end

    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end

    pcall(function() hum.BreakJointsOnDeath = false end)
    pcall(function() hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false) end)

    local _conn = hum:GetPropertyChangedSignal("Health"):Connect(function()
        if hum.Health <= 0 then
            pcall(function() hum.Health = hum.MaxHealth end)
        end
    end)
    table.insert(antiDieConnections, _conn)
end

-- ======================================
-- ANTI RAGDOLL SYSTEM
-- ======================================

function disconnectAllAntiRagdoll()
    for _, conn in ipairs(ANTI_RAGDOLL.connections) do
        pcall(function() conn:Disconnect() end)
    end
    ANTI_RAGDOLL.connections = {}
end

function cacheCharacterData()
    local char = S.LocalPlayer.Character
    if not char then return false end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    if not hum or not root then return false end
    ANTI_RAGDOLL.cachedCharData = {
        character = char,
        humanoid = hum,
        root = root,
    }
    return true
end

function isRagdolled()
    if not ANTI_RAGDOLL.cachedCharData.humanoid then return false end
    local hum = ANTI_RAGDOLL.cachedCharData.humanoid
    local state = hum:GetState()
    local ragdollStates = {
        [Enum.HumanoidStateType.Physics] = true,
        [Enum.HumanoidStateType.Ragdoll] = true,
        [Enum.HumanoidStateType.FallingDown] = true
    }
    if ragdollStates[state] then return true end
    local endTime = S.LocalPlayer:GetAttribute("RagdollEndTime")
    if endTime then
        local now = workspace:GetServerTimeNow()
        if (endTime - now) > 0 then return true end
    end
    return false
end

function removeRagdollConstraints()
    if not ANTI_RAGDOLL.cachedCharData.character then return end
    for _, descendant in ipairs(ANTI_RAGDOLL.cachedCharData.character:GetDescendants()) do
        if descendant:IsA("BallSocketConstraint") or
           (descendant:IsA("Attachment") and descendant.Name:find("RagdollAttachment")) then
            pcall(function() descendant:Destroy() end)
        end
    end
end

function forceExitRagdoll()
    if not ANTI_RAGDOLL.cachedCharData.humanoid or not ANTI_RAGDOLL.cachedCharData.root then return end
    local hum = ANTI_RAGDOLL.cachedCharData.humanoid
    local root = ANTI_RAGDOLL.cachedCharData.root
    pcall(function()
        S.LocalPlayer:SetAttribute("RagdollEndTime", workspace:GetServerTimeNow())
    end)
    if hum.Health > 0 then
        hum:ChangeState(Enum.HumanoidStateType.Running)
    end
    root.Anchored = false
    root.AssemblyLinearVelocity = Vector3.zero
    root.AssemblyAngularVelocity = Vector3.zero
end

function v1HeartbeatLoop()
    while ANTI_RAGDOLL.enabled and ANTI_RAGDOLL.cachedCharData.humanoid do
        task.wait(0.05)
        if isRagdolled() then
            removeRagdollConstraints()
            forceExitRagdoll()
        end
    end
end

function setupCameraBinding()
    if not ANTI_RAGDOLL.cachedCharData.humanoid then return end
    local lastCheck = 0
    local conn = S.RunService.RenderStepped:Connect(function()
        if not ANTI_RAGDOLL.enabled then return end
        local now = tick()
        if now - lastCheck < 0.1 then return end
        lastCheck = now
        local cam = workspace.CurrentCamera
        if cam and ANTI_RAGDOLL.cachedCharData.humanoid and cam.CameraSubject ~= ANTI_RAGDOLL.cachedCharData.humanoid then
            cam.CameraSubject = ANTI_RAGDOLL.cachedCharData.humanoid
        end
    end)
    table.insert(ANTI_RAGDOLL.connections, conn)
end

function onCharacterAddedAntiRagdoll()
    task.wait(0.5)
    if not ANTI_RAGDOLL.enabled then return end
    if cacheCharacterData() then
        setupCameraBinding()
        task.spawn(v1HeartbeatLoop)
    end
end

function toggleAntiRagdoll(state)
    antiRagdollEnabled = state
    if state then
        if not cacheCharacterData() then return end
        ANTI_RAGDOLL.enabled = true
        local charConn = S.LocalPlayer.CharacterAdded:Connect(onCharacterAddedAntiRagdoll)
        table.insert(ANTI_RAGDOLL.connections, charConn)
        setupCameraBinding()
        task.spawn(v1HeartbeatLoop)
    else
        ANTI_RAGDOLL.enabled = false
        disconnectAllAntiRagdoll()
        ANTI_RAGDOLL.cachedCharData = {}
    end
end


-- ======================================
-- ANTI RAGDOLL V2 SYSTEM  (from Zyphrot logic)
-- Heartbeat: force Running state + re-enable Motor6D joints + restore camera
-- ======================================


function startAntiRagdollV2()
    if _arV2Conn then return end
    _arV2Conn = S.RunService.Heartbeat:Connect(function()
        if not _arV2Enabled then return end
        local char = S.LocalPlayer.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        local hum  = char:FindFirstChildOfClass("Humanoid")
        if hum then
            local humState = hum:GetState()
            if humState == Enum.HumanoidStateType.Physics
            or humState == Enum.HumanoidStateType.Ragdoll
            or humState == Enum.HumanoidStateType.FallingDown then
                hum:ChangeState(Enum.HumanoidStateType.Running)
                workspace.CurrentCamera.CameraSubject = hum
                pcall(function()
                    local PlayerModule = S.LocalPlayer.PlayerScripts:FindFirstChild("PlayerModule")
                    if PlayerModule then
                        local Controls = require(PlayerModule:FindFirstChild("ControlModule"))
                        Controls:Enable()
                    end
                end)
                if root then
                    root.AssemblyLinearVelocity  = Vector3.new(0, 0, 0)
                    root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                end
            end
        end
        -- Re-enable all Motor6D joints that got disabled
        for _, obj in ipairs(char:GetDescendants()) do
            if obj:IsA("Motor6D") and not obj.Enabled then
                obj.Enabled = true
            end
        end
    end)
    addConnection(_arV2Conn)
end

function stopAntiRagdollV2()
    if _arV2Conn then
        _arV2Conn:Disconnect()
        _arV2Conn = nil
    end
    _arV2Enabled = false
end

function toggleAntiRagdollV2(state)
    _arV2Enabled = state
    CONFIG.ANTIRAGDOLL_V2_ENABLED = state
    if state then
        startAntiRagdollV2()
    else
        stopAntiRagdollV2()
    end
end

-- ======================================
-- NOTIFICATION TOAST SYSTEM
-- ======================================


function ensureToastGui()
    if _toastGui and _toastGui.Parent then return end
    _toastGui = Instance.new("ScreenGui")
    _toastGui.AutoLocalize = false
    _toastGui.Name = "Looprix_Toasts"
    _toastGui.ResetOnSpawn = false
    _toastGui.DisplayOrder = 9999999
    _toastGui.IgnoreGuiInset = true
    pcall(function()
        if gethui then _toastGui.Parent = gethui()
        elseif syn and syn.protect_gui then syn.protect_gui(_toastGui); _toastGui.Parent = S.PlayerGui
        else _toastGui.Parent = S.PlayerGui end
    end)
    if not _toastGui.Parent then _toastGui.Parent = S.PlayerGui end

    _toastContainer = Instance.new("Frame", _toastGui)
    _toastContainer.Name = "ToastContainer"
    _toastContainer.Size = UDim2.new(0, 180, 1, -8)
    _toastContainer.Position = UDim2.new(1, -188, 0, 8)
    _toastContainer.BackgroundTransparency = 1
    _toastContainer.BorderSizePixel = 0

    local layout = Instance.new("UIListLayout", _toastContainer)
    layout.FillDirection = Enum.FillDirection.Vertical
    layout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 5)
end

function showNotification(featureName, isOn)
    if not CONFIG.NOTIFICATIONS_ENABLED then return end
    task.spawn(function()
        ensureToastGui()

        _toastCount = _toastCount + 1
        local order = _toastCount

        -- Card
        local toast = Instance.new("Frame", _toastContainer)
        toast.Name = "Toast_" .. order
        toast.Size = UDim2.new(1, 0, 0, 38)
        toast.BackgroundColor3 = COLORS.Background
        toast.BackgroundTransparency = 0.05
        toast.BorderSizePixel = 0
        toast.LayoutOrder = order
        toast.ClipsDescendants = true
        Instance.new("UICorner", toast).CornerRadius = UDim.new(0, 8)

        -- Animated accent border
        local tStroke = Instance.new("UIStroke", toast)
        tStroke.Thickness = 1.2
        tStroke.Color = COLORS.Accent
        tStroke.Transparency = 0.15
        tStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        trackStroke(tStroke)

        -- Left accent bar
        local accentBar = Instance.new("Frame", toast)
        accentBar.Size = UDim2.new(0, 3, 1, 0)
        accentBar.Position = UDim2.new(0, 0, 0, 0)
        accentBar.BackgroundColor3 = isOn and COLORS.Accent or COLORS.Red
        accentBar.BorderSizePixel = 0
        if isOn then trackFrame(accentBar) end

        -- Feature name label
        local nameLabel = Instance.new("TextLabel", toast)
        nameLabel.AutoLocalize = false
        nameLabel.Size = UDim2.new(1, -52, 0.55, 0)
        nameLabel.Position = UDim2.new(0, 12, 0, 3)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = featureName
        nameLabel.TextColor3 = COLORS.Accent
        trackLabel(nameLabel)
        nameLabel.TextSize = 11
        nameLabel.Font = Enum.Font.GothamSemibold
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left
        nameLabel.TextTruncate = Enum.TextTruncate.AtEnd

        -- Sub-label "Feature changed"
        local subLabel = Instance.new("TextLabel", toast)
        subLabel.AutoLocalize = false
        subLabel.Size = UDim2.new(1, -52, 0.4, 0)
        subLabel.Position = UDim2.new(0, 12, 0.58, 0)
        subLabel.BackgroundTransparency = 1
        subLabel.Text = isOn and "Enabled" or "Disabled"
        subLabel.TextColor3 = isOn and COLORS.Accent or COLORS.TextDim
        subLabel.TextSize = 10
        subLabel.Font = Enum.Font.Gotham
        subLabel.TextXAlignment = Enum.TextXAlignment.Left
        if isOn then trackLabel(subLabel) end

        -- ON/OFF badge
        local badge = Instance.new("TextLabel", toast)
        badge.AutoLocalize = false
        badge.Size = UDim2.new(0, 34, 0, 18)
        badge.AnchorPoint = Vector2.new(1, 0.5)
        badge.Position = UDim2.new(1, -7, 0.5, 0)
        badge.BackgroundColor3 = isOn and COLORS.Accent or Color3.fromRGB(50, 20, 20)
        badge.BackgroundTransparency = isOn and 0.05 or 0.3
        badge.BorderSizePixel = 0
        badge.Text = isOn and "ON" or "OFF"
        badge.TextColor3 = COLORS.Accent
        trackLabel(badge)
        badge.TextSize = 10
        badge.Font = Enum.Font.GothamBold
        badge.TextXAlignment = Enum.TextXAlignment.Center
        Instance.new("UICorner", badge).CornerRadius = UDim.new(0, 4)
        if isOn then trackFrame(badge) end

        -- Slide in from right
        toast.Position = UDim2.new(0, 0, 0, 0)  -- container handles position via layout
        local slideIn = Instance.new("UIScale", toast)
        slideIn.Scale = 0.85
        S.TweenService:Create(toast, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            { BackgroundTransparency = 0.05 }):Play()
        S.TweenService:Create(slideIn, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            { Scale = 1 }):Play()

        -- Hold
        task.wait(2.8)

        -- Fade + shrink out
        S.TweenService:Create(toast, TweenInfo.new(0.28, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
            { BackgroundTransparency = 1 }):Play()
        S.TweenService:Create(slideIn, TweenInfo.new(0.28, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
            { Scale = 0.8 }):Play()
        S.TweenService:Create(tStroke, TweenInfo.new(0.28, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
            { Transparency = 1 }):Play()

        task.wait(0.3)
        if toast and toast.Parent then toast:Destroy() end
    end)
end

-- ======================================
-- UI HELPERS
-- ======================================

function applyLooprixTextStyle(el)
    if not el then return end
    if el:IsA("TextLabel") or el:IsA("TextButton") or el:IsA("TextBox") then
        el.AutoLocalize = false
        el.TextStrokeColor3 = COLORS.Background
        local size = el.TextSize
        if el.TextScaled then
            size = math.floor((el.AbsoluteSize.Y / 24) * 18)
        end
        if size <= 14 then
            el.TextStrokeTransparency = 0.5
        else
            el.TextStrokeTransparency = 0.3
        end
    end
end

function createElement(className, properties)
    local el = Instance.new(className)
    if className == "ScreenGui" then
        el.AutoLocalize = false
    end
    for k, v in pairs(properties) do el[k] = v end
    applyLooprixTextStyle(el)
    return el
end

function tween(el, info, props)
    S.TweenService:Create(el, info, props):Play()
end

function setToggleVisual(btn, state)
    if not btn then return end
    btn.Text = state and "ON" or "OFF"
    tween(btn, tweenInfoFast, { BackgroundColor3 = state and COLORS.Accent or COLORS.Background })
    if state then
        if not table.find(_accentFrames, btn) then table.insert(_accentFrames, btn) end
    else
        for i, f in ipairs(_accentFrames) do
            if f == btn then table.remove(_accentFrames, i); break end
        end
    end
end

-- ======================================
-- UI ELEMENTS CREATION
-- ======================================

function createKeybindButton(parent, text, currentKey, callback)
    local container = createElement("Frame", {
        Size = UDim2.new(1, 0, 0, 50),
        BackgroundColor3 = COLORS.Surface,
        BackgroundTransparency = COLORS.SurfaceTransparency,
        BorderSizePixel = 0,
        Parent = parent,
    })
    createElement("UICorner", { CornerRadius = UDim.new(0, 6), Parent = container })
    trackStroke(createElement("UIStroke", { Color = COLORS.Accent, Thickness = 1, Transparency = 0.5, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = container }))

    local label = createElement("TextLabel", {
        Size = UDim2.new(0.6, -10, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = COLORS.Accent,
        TextSize = 14,
        Font = Enum.Font.GothamSemibold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = container,
    })
    trackLabel(label)

    local keyButton = createElement("TextButton", {
        Size = UDim2.new(0.35, -5, 0.7, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -10, 0.5, 0),
        BackgroundColor3 = COLORS.Background,
        BackgroundTransparency = 0.2,
        Text = _getBindDisplayText(currentKey),
        TextColor3 = COLORS.Accent,
        TextSize = 12,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0,
        Parent = container,
    })
    trackLabel(keyButton)
    createElement("UICorner", { CornerRadius = UDim.new(0, 4), Parent = keyButton })
    trackStroke(createElement("UIStroke", { Color = COLORS.Accent, Thickness = 1, Transparency = 0.3, Parent = keyButton }))
    trackLabel(keyButton)

    local isListening = false
    keyButton.MouseButton1Click:Connect(function()
        if isListening then return end
        isListening = true
        keyButton.Text = "..."
        keyButton.TextColor3 = COLORS.Yellow
        local conn
        conn = S.UserInputService.InputBegan:Connect(function(input)
            local isKB = input.UserInputType == Enum.UserInputType.Keyboard
            local isGP = input.UserInputType == Enum.UserInputType.Gamepad1
                      or input.UserInputType == Enum.UserInputType.Gamepad2
                      or input.UserInputType == Enum.UserInputType.Gamepad3
                      or input.UserInputType == Enum.UserInputType.Gamepad4
            if isKB or isGP then
                local newKey = input.KeyCode
                if newKey == Enum.KeyCode.Unknown then return end  -- skip analog axes
                local bindType = isKB and "Keyboard" or "Gamepad"
                local newBind = {Type = bindType, Key = newKey}
                local dispText = (bindType == "Gamepad") and ("GP:" .. newKey.Name) or newKey.Name
                keyButton.Text = dispText
                keyButton.TextColor3 = COLORS.Accent
                trackLabel(keyButton)
                callback(newBind)
                saveConfig()
                isListening = false
                conn:Disconnect()
            end
        end)
    end)
    return container
end

function createToggle(parent, text, defaultValue, callback)
    local container = createElement("Frame", {
        Size = UDim2.new(1, 0, 0, 42),
        BackgroundColor3 = COLORS.Surface,
        BackgroundTransparency = COLORS.SurfaceTransparency,
        BorderSizePixel = 0,
        Parent = parent,
    })
    createElement("UICorner", { CornerRadius = UDim.new(0, 6), Parent = container })
    trackStroke(createElement("UIStroke", { Color = COLORS.Accent, Thickness = 1, Transparency = 0.5, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = container }))

    local label = createElement("TextLabel", {
        Size = UDim2.new(1, -78, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = COLORS.Accent,
        TextSize = 13,
        Font = Enum.Font.GothamSemibold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = container,
    })
    trackLabel(label)

    local toggleButton = createElement("TextButton", {
        Size = UDim2.new(0, 52, 0, 24),
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -8, 0.5, 0),
        BackgroundColor3 = defaultValue and COLORS.Accent or COLORS.Background,
        BackgroundTransparency = 0.2,
        Text = defaultValue and "ON" or "OFF",
        TextColor3 = COLORS.Accent,
        TextScaled = false,
        TextSize = 12,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0,
        AutoLocalize = false,
        ClipsDescendants = true,
        Parent = container,
    })
    trackLabel(toggleButton)
    createElement("UICorner", { CornerRadius = UDim.new(0, 4), Parent = toggleButton })
    trackStroke(createElement("UIStroke", { Color = COLORS.Accent, Thickness = 1, Transparency = 0.3, Parent = toggleButton }))
    trackLabel(toggleButton)

    -- Track ON-state background so color changes propagate
    if defaultValue then table.insert(_accentFrames, toggleButton) end

    local state = defaultValue

    toggleButton.MouseButton1Click:Connect(function()
        state = not state
        toggleButton.Text = state and "ON" or "OFF"
        tween(toggleButton, tweenInfoFast, { BackgroundColor3 = state and COLORS.Accent or COLORS.Background })
        if state then
            if not table.find(_accentFrames, toggleButton) then
                table.insert(_accentFrames, toggleButton)
            end
        else
            for i, f in ipairs(_accentFrames) do
                if f == toggleButton then table.remove(_accentFrames, i) break end
            end
        end
        showNotification(text, state)
        callback(state)
    end)

    return container, toggleButton
end

function createTextInput(parent, text, defaultValue, minVal, maxVal, callback)
    local container = createElement("Frame", {
        Size = UDim2.new(1, 0, 0, 50),
        BackgroundColor3 = COLORS.Surface,
        BackgroundTransparency = COLORS.SurfaceTransparency,
        BorderSizePixel = 0,
        Parent = parent,
    })
    createElement("UICorner", { CornerRadius = UDim.new(0, 6), Parent = container })
    createElement("UIStroke", { Color = COLORS.Accent, Thickness = 1, Transparency = 0.5, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = container })

    local label = createElement("TextLabel", {
        Size = UDim2.new(0.6, -10, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = COLORS.Accent,
        TextSize = 14,
        Font = Enum.Font.GothamSemibold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = container,
    })
    trackLabel(label)

    local input = createElement("TextBox", {
        Size = UDim2.new(0.25, 0, 0.6, 0),
        Position = UDim2.new(1, -10, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = COLORS.Background,
        BackgroundTransparency = 0.2,
        Text = tostring(defaultValue),
        TextColor3 = COLORS.Accent,
        TextSize = 12,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0,
        Parent = container,
    })
    trackLabel(input)
    createElement("UICorner", { CornerRadius = UDim.new(0, 4), Parent = input })
    createElement("UIStroke", { Color = COLORS.Accent, Thickness = 1, Transparency = 0.3, Parent = input })
    trackLabel(input)

    input.FocusLost:Connect(function()
        local num = tonumber(input.Text)
        if num then
            num = math.clamp(num, minVal or 1, maxVal or 100)
            callback(num)
            input.Text = tostring(num)
        else
            input.Text = tostring(defaultValue)
        end
    end)

    return container
end

-- Slider UI element (draggable progress bar style)
function createSlider(parent, labelText, defaultValue, minVal, maxVal, callback)
    minVal = minVal or 0
    maxVal = maxVal or 100
    local current = math.clamp(defaultValue, minVal, maxVal)

    local container = createElement("Frame", {
        Size = UDim2.new(1, 0, 0, 44),
        BackgroundColor3 = COLORS.Surface,
        BackgroundTransparency = COLORS.SurfaceTransparency,
        BorderSizePixel = 0,
        Parent = parent,
    })
    createElement("UICorner", { CornerRadius = UDim.new(0, 6), Parent = container })
    local cStroke = createElement("UIStroke", { Color = COLORS.Accent, Thickness = 1, Transparency = 0.5,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = container })
    trackStroke(cStroke)

    -- Left label: "Radius [8]"
    local lbl = createElement("TextLabel", {
        Size = UDim2.new(0.55, 0, 0, 18),
        Position = UDim2.new(0, 8, 0, 4),
        BackgroundTransparency = 1,
        Text = labelText .. " [" .. tostring(current) .. "]",
        TextColor3 = COLORS.Accent,
        TextSize = 12,
        Font = Enum.Font.GothamSemibold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = container,
    })
    trackLabel(lbl)

    -- Track background
    local track = createElement("Frame", {
        Size = UDim2.new(1, -16, 0, 8),
        Position = UDim2.new(0, 8, 1, -14),
        BackgroundColor3 = COLORS.Background,
        BackgroundTransparency = 0.3,
        BorderSizePixel = 0,
        Parent = container,
    })
    createElement("UICorner", { CornerRadius = UDim.new(1, 0), Parent = track })

    local fraction = (current - minVal) / (maxVal - minVal)
    -- Fill bar
    local fill = createElement("Frame", {
        Size = UDim2.new(fraction, 0, 1, 0),
        BackgroundColor3 = COLORS.Accent,
        BorderSizePixel = 0,
        Parent = track,
    })
    createElement("UICorner", { CornerRadius = UDim.new(1, 0), Parent = fill })
    trackFrame(fill)

    -- Thumb knob
    local thumb = createElement("Frame", {
        Size = UDim2.new(0, 12, 0, 12),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(fraction, 0, 0.5, 0),
        BackgroundColor3 = COLORS.Accent,
        BorderSizePixel = 0,
        ZIndex = 5,
        Parent = track,
    })
    createElement("UICorner", { CornerRadius = UDim.new(1, 0), Parent = thumb })
    trackFrame(thumb)

    local isDragging = false

    local function updateFromPos(absX)
        local trackAbs = track.AbsolutePosition.X
        local trackW   = track.AbsoluteSize.X
        local frac = math.clamp((absX - trackAbs) / trackW, 0, 1)
        current = math.round(minVal + frac * (maxVal - minVal))
        fill.Size = UDim2.new(frac, 0, 1, 0)
        thumb.Position = UDim2.new(frac, 0, 0.5, 0)
        lbl.Text = labelText .. " [" .. tostring(current) .. "]"
        callback(current)
    end

    -- Transparent hit zone over the track area — 28px tall so finger always lands on it.
    -- Does NOT set input.Handled so elements below are never blocked.
    local hitZone = Instance.new("Frame")
    hitZone.Size = UDim2.new(1, -16, 0, 28)
    hitZone.Position = UDim2.new(0, 8, 1, -26)
    hitZone.BackgroundTransparency = 1
    hitZone.BorderSizePixel = 0
    hitZone.ZIndex = 10
    hitZone.Parent = container

    hitZone.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            isDragging = true
            updateFromPos(input.Position.X)
        end
    end)

    S.UserInputService.InputChanged:Connect(function(input)
        if not isDragging then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement or
           input.UserInputType == Enum.UserInputType.Touch then
            updateFromPos(input.Position.X)
        end
    end)

    S.UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            if isDragging then
                isDragging = false
                saveConfig()
            end
        end
    end)

    return container
end

-- ======================================
-- NUMBER INPUT BOX  (replaces sliders in Settings)
-- ======================================

function createNumberInput(parent, labelText, defaultValue, minVal, maxVal, callback, allowFloat)
    minVal = minVal or 0
    maxVal = maxVal or 9999
    local current = math.clamp(defaultValue, minVal, maxVal)

    local container = createElement("Frame", {
        Size = UDim2.new(1, 0, 0, 44),
        BackgroundColor3 = COLORS.Surface,
        BackgroundTransparency = COLORS.SurfaceTransparency,
        BorderSizePixel = 0,
        Parent = parent,
    })
    createElement("UICorner", { CornerRadius = UDim.new(0, 6), Parent = container })
    local cStroke = createElement("UIStroke", { Color = COLORS.Accent, Thickness = 1, Transparency = 0.5,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = container })
    trackStroke(cStroke)

    -- Left label
    local lbl = createElement("TextLabel", {
        Size = UDim2.new(0.58, -6, 1, 0),
        Position = UDim2.new(0, 8, 0, 0),
        BackgroundTransparency = 1,
        Text = labelText,
        TextColor3 = COLORS.Accent,
        TextSize = 12,
        Font = Enum.Font.GothamSemibold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = container,
    })
    trackLabel(lbl)

    -- Input box on the right
    local inputBox = createElement("TextBox", {
        Size = UDim2.new(0.38, 0, 0, 26),
        Position = UDim2.new(0.60, 0, 0.5, -13),
        BackgroundColor3 = COLORS.Background,
        BackgroundTransparency = 0.3,
        Text = tostring(current),
        TextColor3 = COLORS.Accent,
        TextSize = 13,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0,
        ClearTextOnFocus = true,
        PlaceholderText = tostring(current),
        PlaceholderColor3 = COLORS.TextDim,
        Parent = container,
    })
    createElement("UICorner", { CornerRadius = UDim.new(0, 5), Parent = inputBox })
    trackStroke(createElement("UIStroke", { Color = COLORS.Accent, Thickness = 1, Transparency = 0.4, Parent = inputBox }))
    trackLabel(inputBox)

    local function applyValue(raw)
        local num = tonumber(raw)
        if not num then
            inputBox.Text = tostring(current)
            return
        end
        current = allowFloat and math.clamp(num, minVal, maxVal) or math.clamp(math.round(num), minVal, maxVal)
        inputBox.Text = tostring(current)
        callback(current)
        saveConfig()
    end

    inputBox.FocusLost:Connect(function(enterPressed)
        applyValue(inputBox.Text)
    end)

    -- Also apply immediately on Enter key (ReturnPressedFromOnScreenKeyboard)
    inputBox:GetPropertyChangedSignal("Text"):Connect(function()
        -- live preview: only update if text is a valid number
        local num = tonumber(inputBox.Text)
        if num then
            local clamped = allowFloat and math.clamp(num, minVal, maxVal) or math.clamp(math.round(num), minVal, maxVal)
            if clamped ~= current then
                current = clamped
                callback(current)
            end
        end
    end)

    return container
end

-- ======================================
-- COLLAPSIBLE CATEGORY  (animated)
-- ======================================

function createCategory(parent, title, defaultOpen)
    defaultOpen = (defaultOpen ~= false)

    -- Outer wrapper – AutomaticSize.Y stacks header + clipper
    local wrapper = createElement("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = false,
        AutomaticSize = Enum.AutomaticSize.Y,
        Parent = parent,
    })

    local wLayout = Instance.new("UIListLayout")
    wLayout.FillDirection  = Enum.FillDirection.Vertical
    wLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    wLayout.VerticalAlignment   = Enum.VerticalAlignment.Top
    wLayout.Padding    = UDim.new(0, 4)
    wLayout.SortOrder  = Enum.SortOrder.LayoutOrder
    wLayout.Parent     = wrapper

    -- ── Header ──────────────────────────────────────────────────────────────
    local header = createElement("TextButton", {
        Size = UDim2.new(1, 0, 0, 32),
        BackgroundColor3 = COLORS.Surface,
        BackgroundTransparency = 0.05,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        LayoutOrder = 1,
        Parent = wrapper,
    })
    createElement("UICorner", { CornerRadius = UDim.new(0, 7), Parent = header })
    local hStroke = createElement("UIStroke", { Color = COLORS.Accent, Thickness = 1.2, Transparency = 0.3,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = header })
    trackStroke(hStroke)

    local titleLbl = createElement("TextLabel", {
        Size = UDim2.new(1, -40, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = COLORS.Accent,
        TextSize = 13,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = header,
    })
    trackLabel(titleLbl)

    -- Arrow rotates: 0° = open (▼), -90° = closed (▶)
    local arrowLbl = createElement("TextLabel", {
        Size = UDim2.new(0, 24, 0, 24),
        Position = UDim2.new(1, -30, 0.5, -12),
        BackgroundTransparency = 1,
        Text = "v",
        TextColor3 = COLORS.Accent,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        Rotation = defaultOpen and 0 or -90,
        Parent = header,
    })
    trackLabel(arrowLbl)

    -- ── Clipper – masks the content during the slide animation ───────────────
    -- When open:   AutomaticSize.Y  → naturally matches content height
    -- When closed: AutomaticSize.None + tween Size.Y → 0
    local clipper = createElement("Frame", {
        Size            = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = true,   -- this is what creates the reveal effect
        AutomaticSize   = defaultOpen and Enum.AutomaticSize.Y or Enum.AutomaticSize.None,
        Visible         = defaultOpen,
        LayoutOrder     = 2,
        Parent          = wrapper,
    })

    -- ── Content – holds all items, always AutomaticSize.Y ───────────────────
    local content = createElement("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = false,
        AutomaticSize = Enum.AutomaticSize.Y,
        Parent = clipper,
    })

    local contentPad = Instance.new("UIPadding")
    contentPad.PaddingBottom = UDim.new(0, 6)
    contentPad.Parent = content

    local itemList = createElement("UIListLayout", {
        Padding    = UDim.new(0, 6),
        SortOrder  = Enum.SortOrder.LayoutOrder,
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        Parent = content,
    })

    -- ── Animation state ──────────────────────────────────────────────────────
    local isOpen    = defaultOpen
    local animating = false
    local catTween  = TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

    local function setOpen(open)
        if animating then return end
        isOpen = open

        -- Rotate arrow with tween
        S.TweenService:Create(arrowLbl, catTween, {
            Rotation = open and 0 or -90
        }):Play()

        if open then
            -- Show clipper at zero height, then expand to content height
            clipper.AutomaticSize = Enum.AutomaticSize.None
            clipper.Size          = UDim2.new(1, 0, 0, 0)
            clipper.Visible       = true
            animating = true
            -- Defer one frame so AbsoluteSize is valid after clipper becomes visible
            task.defer(function()
                if not (content and content.Parent) then animating = false return end
                local targetH = math.max(content.AbsoluteSize.Y, 8)
                local tw = S.TweenService:Create(clipper, catTween, { Size = UDim2.new(1, 0, 0, targetH) })
                tw.Completed:Connect(function()
                    -- Hand off to AutomaticSize so the clipper tracks future resizes
                    clipper.AutomaticSize = Enum.AutomaticSize.Y
                    animating = false
                end)
                tw:Play()
            end)
        else
            -- Collapse from current height to zero
            clipper.AutomaticSize = Enum.AutomaticSize.None
            animating = true
            local tw = S.TweenService:Create(clipper, catTween, { Size = UDim2.new(1, 0, 0, 0) })
            tw.Completed:Connect(function()
                clipper.Visible = false
                animating = false
            end)
            tw:Play()
        end
    end

    header.MouseButton1Click:Connect(function()
        setOpen(not isOpen)
    end)

    return content, wrapper
end

function createEmptyTab(parent, name)
    return createElement("Frame", {
        Name = name .. "Tab",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Visible = false,
        Parent = parent,
    })
end

-- ======================================
-- DROP BRAINROT FEATURE  (K7 logic)
-- ======================================


function runDropBrainrot()
    if dropBrainrotActive then return end
    local char = character; if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart"); if not root then return end
    dropBrainrotActive = true
    local t0 = tick()
    local dc
    dc = S.RunService.Heartbeat:Connect(function()
        local r = char and char:FindFirstChild("HumanoidRootPart")
        if not r then
            dc:Disconnect(); dropBrainrotActive = false; return
        end
        if tick() - t0 >= DROP_ASCEND_DURATION then
            dc:Disconnect()
            local rp = RaycastParams.new()
            rp.FilterDescendantsInstances = {char}
            rp.FilterType = Enum.RaycastFilterType.Exclude
            local rr = workspace:Raycast(r.Position, Vector3.new(0, -2000, 0), rp)
            if rr then
                local hum2 = char:FindFirstChildOfClass("Humanoid")
                local off = (hum2 and hum2.HipHeight or 2) + (r.Size.Y / 2)
                r.CFrame = CFrame.new(r.Position.X, rr.Position.Y + off, r.Position.Z)
                r.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            end
            dropBrainrotActive = false
            -- Auto Stop on Drop: stop AutoPlay on drop
            if CONFIG.POST_DROP_HALT_ENABLED and _doPostDropHalt then
                task.spawn(_doPostDropHalt)
            end
            -- Lock on Drop: lock on target for 0.5s after drop
            if CONFIG.SNAP_LOCK_ENABLED and _doSnapLock then
                task.spawn(_doSnapLock)
            end
            return
        end
        r.AssemblyLinearVelocity = Vector3.new(
            r.AssemblyLinearVelocity.X, DROP_ASCEND_SPEED, r.AssemblyLinearVelocity.Z)
    end)
end

function executeDrop() task.spawn(runDropBrainrot) end


-- ======================================
-- HARDER HIT ANIM SYSTEM  (K7 - auto apply)
-- ======================================


function _saveOriginalAnims(char)
    local animate = char:FindFirstChild("Animate"); if not animate then return end
    local function g(obj) return obj and obj.AnimationId or nil end
    _savedOrigAnims = {
        idle1    = g(animate.idle     and animate.idle.Animation1),
        idle2    = g(animate.idle     and animate.idle.Animation2),
        walk     = g(animate.walk     and animate.walk.WalkAnim),
        run      = g(animate.run      and animate.run.RunAnim),
        jump     = g(animate.jump     and animate.jump.JumpAnim),
        fall     = g(animate.fall     and animate.fall.FallAnim),
        climb    = g(animate.climb    and animate.climb.ClimbAnim),
        swim     = g(animate.swim     and animate.swim.Swim),
        swimidle = g(animate.swimidle and animate.swimidle.SwimIdle),
    }
end

function _applyHarderHitAnimPack(char)
    local animate = char:FindFirstChild("Animate"); if not animate then return end
    local function s(obj, id) if obj then obj.AnimationId = id end end
    s(animate.idle     and animate.idle.Animation1,     _harderHitAnims.idle1)
    s(animate.idle     and animate.idle.Animation2,     _harderHitAnims.idle2)
    s(animate.walk     and animate.walk.WalkAnim,       _harderHitAnims.walk)
    s(animate.run      and animate.run.RunAnim,         _harderHitAnims.run)
    s(animate.jump     and animate.jump.JumpAnim,       _harderHitAnims.jump)
    s(animate.fall     and animate.fall.FallAnim,       _harderHitAnims.fall)
    s(animate.climb    and animate.climb.ClimbAnim,     _harderHitAnims.climb)
    s(animate.swim     and animate.swim.Swim,           _harderHitAnims.swim)
    s(animate.swimidle and animate.swimidle.SwimIdle,   _harderHitAnims.swimidle)
end

function startHarderHitAnim()
    if _animHeartbeatConn then _animHeartbeatConn:Disconnect(); _animHeartbeatConn = nil end
    local char = S.LocalPlayer.Character
    if char then
        _saveOriginalAnims(char)
        _applyHarderHitAnimPack(char)
        local hum2 = char:FindFirstChildOfClass("Humanoid")
        if hum2 then for _, t in ipairs(hum2:GetPlayingAnimationTracks()) do t:Stop(0) end end
    end
    _animHeartbeatConn = S.RunService.Heartbeat:Connect(function()
        if not CONFIG.HARDER_HIT_ENABLED then return end
        local c = S.LocalPlayer.Character
        if c then _applyHarderHitAnimPack(c) end
    end)
end

function stopHarderHitAnim()
    if _animHeartbeatConn then _animHeartbeatConn:Disconnect(); _animHeartbeatConn = nil end
    local char = S.LocalPlayer.Character
    if not char then return end
    local animate = char:FindFirstChild("Animate"); if not animate then return end
    if not _savedOrigAnims then return end
    local function s(obj, id) if obj and id then obj.AnimationId = id end end
    s(animate.idle     and animate.idle.Animation1,     _savedOrigAnims.idle1)
    s(animate.idle     and animate.idle.Animation2,     _savedOrigAnims.idle2)
    s(animate.walk     and animate.walk.WalkAnim,       _savedOrigAnims.walk)
    s(animate.run      and animate.run.RunAnim,         _savedOrigAnims.run)
    s(animate.jump     and animate.jump.JumpAnim,       _savedOrigAnims.jump)
    s(animate.fall     and animate.fall.FallAnim,       _savedOrigAnims.fall)
    s(animate.climb    and animate.climb.ClimbAnim,     _savedOrigAnims.climb)
    s(animate.swim     and animate.swim.Swim,           _savedOrigAnims.swim)
    s(animate.swimidle and animate.swimidle.SwimIdle,   _savedOrigAnims.swimidle)
    local hum2 = char:FindFirstChildOfClass("Humanoid")
    if hum2 then for _, t in ipairs(hum2:GetPlayingAnimationTracks()) do t:Stop(0) end end
end

-- ======================================
-- AIMBOT SYSTEM
-- ======================================

function getClosestTarget()
    local char = character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end

    local hrp = char.HumanoidRootPart
    local closest = nil
    local shortestDistance = CONFIG.AIMBOT_RANGE

    for _, plr in ipairs(S.Players:GetPlayers()) do
        if plr ~= S.LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local targetHrp = plr.Character.HumanoidRootPart
            local dist = (targetHrp.Position - hrp.Position).Magnitude

            if dist <= shortestDistance then
                shortestDistance = dist
                closest = targetHrp
            end
        end
    end
    return closest
end

function startBodyAimbot()
    if aimbotConnection then return end

    local char = character
    if not char then return end

    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.AutoRotate = false
    end

    attach0 = Instance.new("Attachment", hrp)

    alignOri = Instance.new("AlignOrientation")
    alignOri.Attachment0 = attach0
    alignOri.Mode = Enum.OrientationAlignmentMode.OneAttachment
    alignOri.RigidityEnabled = true
    alignOri.MaxTorque = math.huge
    alignOri.Responsiveness = 200
    alignOri.Parent = hrp

    aimbotConnection = S.RunService.RenderStepped:Connect(function()
        if not CONFIG.AIMBOT_ENABLED then return end
        local target = getClosestTarget()
        if not target then return end

        local dist = (target.Position - hrp.Position).Magnitude
        if dist > CONFIG.AIMBOT_DISABLE_RANGE then return end



        if CONFIG.LOCK_TARGET_ENABLED and dist <= CONFIG.AIMBOT_FLAT_REMOVE_DIST then
            if (target.Position - hrp.Position).Magnitude > 0.01 then
                alignOri.CFrame = CFrame.lookAt(hrp.Position, target.Position)
            end
        else
            local flatTarget = Vector3.new(target.Position.X, hrp.Position.Y, target.Position.Z)
            local flatDelta  = flatTarget - hrp.Position
            if flatDelta.Magnitude > 0.01 then
                alignOri.CFrame = CFrame.lookAt(hrp.Position, flatTarget)
            end
        end
    end)
    addConnection(aimbotConnection)
end

function stopBodyAimbot()
    if aimbotConnection then
        aimbotConnection:Disconnect()
        aimbotConnection = nil
    end

    if alignOri then
        alignOri:Destroy()
        alignOri = nil
    end

    if attach0 then
        attach0:Destroy()
        attach0 = nil
    end

    local char = character
    if char then
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.AutoRotate = true
        end
    end
end

-- ======================================
-- AUTO BAT SYSTEM
-- ======================================

function autoAttack()
    _autoBatGen = _autoBatGen + 1
    local gen = _autoBatGen
    task.spawn(function()
        while CONFIG.AUTO_BAT_ENABLED and _autoBatGen == gen do
            local char = character
            if char then
                local bat = char:FindFirstChild("Bat")
                if bat then
                    pcall(function()
                        bat:Activate()
                    end)
                end
            end
            task.wait(0.15)
        end
    end)
end

-- ======================================
-- SPINBOT SYSTEM
-- ======================================

function startSpinBot()
    if spinbotConnection then return end
    
    local char = character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    if spinBAV then spinBAV:Destroy() spinBAV = nil end
    for _, v in pairs(hrp:GetChildren()) do
        if v.Name == "SpinBAV" then v:Destroy() end
    end
    
    spinBAV = Instance.new("BodyAngularVelocity")
    spinBAV.Name = "SpinBAV"
    spinBAV.MaxTorque = Vector3.new(0, math.huge, 0)
    spinBAV.AngularVelocity = Vector3.new(0, CONFIG.SPINBOT_SPEED, 0)
    spinBAV.Parent = hrp
    
    spinbotConnection = S.RunService.Heartbeat:Connect(function()
        if not CONFIG.SPINBOT_ENABLED or not spinBAV then return end
        if spinBAV and spinBAV.Parent then
            spinBAV.AngularVelocity = Vector3.new(0, CONFIG.SPINBOT_SPEED, 0)
        end
    end)
    addConnection(spinbotConnection)
end

function stopSpinBot()
    if spinbotConnection then
        spinbotConnection:Disconnect()
        spinbotConnection = nil
    end
    
    if spinBAV then 
        spinBAV:Destroy() 
        spinBAV = nil 
    end
    
    local char = character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            for _, v in pairs(hrp:GetChildren()) do
                if v.Name == "SpinBAV" then v:Destroy() end
            end
        end
    end
end

-- ======================================
-- UNWALK SYSTEM
-- ======================================

function startUnwalk()
    local c = character
    if not c then return end
    local hum = c:FindFirstChildOfClass("Humanoid")
    if hum then
        for _, t in ipairs(hum:GetPlayingAnimationTracks()) do
            t:Stop()
        end
    end
    local anim = c:FindFirstChild("Animate")
    if anim then
        savedAnimations.Animate = anim:Clone()
        anim:Destroy()
    end
end

function stopUnwalk()
    -- Always resolve to the *current* live character, not the potentially-stale closure var
    local c = S.LocalPlayer.Character or character
    if c and savedAnimations.Animate then
        savedAnimations.Animate:Clone().Parent = c
        savedAnimations.Animate = nil
    end
end

-- ======================================
-- ESP SYSTEM  (outline + beam, accent-tracked, no nickname)
-- ======================================


function espGetAccentColor()
    return Color3.fromRGB(CONFIG.GUI_COLOR_R or 0, CONFIG.GUI_COLOR_G or 217, CONFIG.GUI_COLOR_B or 127)
end

function espClearPlayer(player)
    local data = espCache[player]
    if not data then return end
    pcall(function()
        if data.highlight and data.highlight.Parent then data.highlight:Destroy() end
        if data.hitbox    and data.hitbox.Parent    then data.hitbox:Destroy()    end
        if data.beam      and data.beam.Parent      then data.beam:Destroy()      end
        if data.beamAtt0  and data.beamAtt0.Parent  then data.beamAtt0:Destroy()  end
        if data.beamAtt1  and data.beamAtt1.Parent  then data.beamAtt1:Destroy()  end
        if data.charConn  then data.charConn:Disconnect() end
    end)
    -- remove from tracking arrays
    for _, tbl in ipairs({_espHighlights, _espBeams, _espHitboxes}) do
        for i = #tbl, 1, -1 do
            if tbl[i] == data.highlight or tbl[i] == data.hitbox or tbl[i] == data.beam then
                table.remove(tbl, i)
            end
        end
    end
    espCache[player] = nil
end

function espSetupChar(player, char)
    espClearPlayer(player)
    local hrp = char:WaitForChild("HumanoidRootPart", 5)
    if not hrp then return end

    local accent = espGetAccentColor()

    -- Highlight (semi-fill + thick outline)
    local hl = Instance.new("Highlight")
    hl.Name            = ESP_NAME
    hl.Adornee         = char
    hl.FillColor          = accent
    hl.FillTransparency   = 0.82
    hl.OutlineColor       = accent
    hl.OutlineTransparency = 0
    hl.DepthMode          = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent = char
    table.insert(_espHighlights, hl)

    -- Hitbox adornment
    local hitbox = Instance.new("BoxHandleAdornment")
    hitbox.Name        = "LooprixHitbox"
    hitbox.Adornee     = hrp
    hitbox.Size        = Vector3.new(4, 6, 2)
    hitbox.Color3      = accent
    hitbox.Transparency = 0.6
    hitbox.ZIndex      = 10
    hitbox.AlwaysOnTop = true
    hitbox.Parent      = char
    table.insert(_espHitboxes, hitbox)

    -- Beam: att0 on local HRP, att1 on enemy HRP
    local myChar = S.LocalPlayer.Character
    local myHRP  = myChar and myChar:FindFirstChild("HumanoidRootPart")

    local att0, att1
    if myHRP then
        att0 = Instance.new("Attachment", myHRP)
        att0.Name = ESP_BEAM_NAME .. "_att0_" .. player.UserId
    end
    att1 = Instance.new("Attachment", hrp)
    att1.Name = ESP_BEAM_NAME .. "_att1"

    local beam = Instance.new("Beam")
    beam.Name         = ESP_BEAM_NAME
    beam.Attachment0  = att0 or att1
    beam.Attachment1  = att1
    beam.Color        = ColorSequence.new(accent)
    beam.Transparency = NumberSequence.new(0.25)
    beam.Width0       = 0.18
    beam.Width1       = 0.18
    beam.FaceCamera   = true
    beam.Segments     = 1
    beam.Parent       = hrp
    table.insert(_espBeams, beam)

    local charConn = player.CharacterRemoving:Connect(function()
        espClearPlayer(player)
    end)

    espCache[player] = {
        highlight = hl,
        hitbox    = hitbox,
        beam      = beam,
        beamAtt0  = att0,
        beamAtt1  = att1,
        hrp       = hrp,
        charConn  = charConn,
    }
end

function createESPForPlayer(player)
    if player == S.LocalPlayer then return end
    if player.Character then
        task.spawn(espSetupChar, player, player.Character)
    end
    player.CharacterAdded:Connect(function(char)
        task.wait(0.1)
        if CONFIG.ESP_ENABLED then
            espSetupChar(player, char)
        end
    end)
end

function startESP()
    if espConnection then return end
    for _, p in ipairs(S.Players:GetPlayers()) do
        createESPForPlayer(p)
    end
    S.Players.PlayerAdded:Connect(createESPForPlayer)
    espConnection = S.RunService.RenderStepped:Connect(function()
        if not CONFIG.ESP_ENABLED then return end
        -- keep beam att0 anchored to local HRP (character can respawn)
        local myChar = S.LocalPlayer.Character
        local myHRP  = myChar and myChar:FindFirstChild("HumanoidRootPart")
        for player, data in pairs(espCache) do
            if data.beam and data.beam.Parent then
                if myHRP and data.beamAtt0 then
                    if data.beamAtt0.Parent ~= myHRP then
                        data.beamAtt0.Parent = myHRP
                    end
                    data.beam.Attachment0 = data.beamAtt0
                end
            end
        end
    end)
    addConnection(espConnection)
end

function stopESP()
    if espConnection then
        espConnection:Disconnect()
        espConnection = nil
    end
    for player, _ in pairs(espCache) do
        espClearPlayer(player)
    end
    espCache = {}
end

-- Called by applyAccentColor to update live ESP colors
function updateEspAccentColor(r, g, b)
    local c = Color3.fromRGB(r, g, b)
    for _, hl in ipairs(_espHighlights) do
        pcall(function()
            if hl and hl.Parent then
                hl.OutlineColor = c
                hl.FillColor    = c
            end
        end)
    end
    for _, bm in ipairs(_espBeams) do
        pcall(function() if bm and bm.Parent then bm.Color = ColorSequence.new(c) end end)
    end
    for _, hb in ipairs(_espHitboxes) do
        pcall(function() if hb and hb.Parent then hb.Color3 = c end end)
    end
end


-- ======================================
-- FLING SYSTEM
-- ======================================


function startFling()
    flingEnabled = true
    _flingMoveL  = 0.1
    task.spawn(function()
        while flingEnabled do
            local char = character
            local hrp  = char and char:FindFirstChild("HumanoidRootPart")
            if not hrp then task.wait(0.1) continue end
            local originalVel = hrp.AssemblyLinearVelocity
            hrp.AssemblyLinearVelocity = originalVel * FLING_STRENGTH + Vector3.new(0, FLING_UP_FORCE, 0)
            S.RunService.RenderStepped:Wait()
            if hrp and hrp.Parent then hrp.AssemblyLinearVelocity = originalVel end
            S.RunService.Stepped:Wait()
            if hrp and hrp.Parent then
                hrp.AssemblyLinearVelocity = originalVel + Vector3.new(0, _flingMoveL, 0)
                _flingMoveL = -_flingMoveL
            end
            S.RunService.Heartbeat:Wait()
        end
    end)
end

function stopFling()
    flingEnabled = false
end


-- ======================================
-- AUTO WALK SYSTEM
-- ======================================


function awGetTarget(key)
    local b = AW.BASE[AW.activeSide][key]
    return b
end

function awSetBtnActive(side, active)
    local btn = (side == "L") and awWalkBtnL or awWalkBtnR
    if not btn then return end
    S.TweenService:Create(btn, tweenInfoFast, {
        BackgroundColor3       = active and COLORS.Accent or COLORS.Surface,
        BackgroundTransparency = active and 0.0 or COLORS.SurfaceTransparency,
    }):Play()
    btn.TextColor3 = active and Color3.fromRGB(10,10,10) or COLORS.TextDim
end

function awStopLoop()
    local prevSide = AW.activeSide
    AW.enabled     = false
    if AW.loopConn then AW.loopConn:Disconnect(); AW.loopConn = nil end
    AW.currentStep = 1
    if prevSide then awSetBtnActive(prevSide, false) end
end

function awStartLoop()
    if AW.loopConn then AW.loopConn:Disconnect() end
    AW.currentStep = 1

    AW.loopConn = S.RunService.Heartbeat:Connect(function()
        if not AW.enabled then return end
        local char = character
        local hrp  = char and char:FindFirstChild("HumanoidRootPart")
        local hum  = char and char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum then return end

        local key    = AW.WALK_SEQ[AW.currentStep]
        local target = awGetTarget(key)
        local flat   = Vector3.new(target.X, hrp.Position.Y, target.Z)
        local dist   = (flat - hrp.Position).Magnitude
        local spd    = CONFIG.SPEED_VALUE or 60

        if dist > 2.0 then
            local dir = (flat - hrp.Position).Unit
            hum:Move(dir, false)
            hrp.AssemblyLinearVelocity = Vector3.new(dir.X * spd, hrp.AssemblyLinearVelocity.Y, dir.Z * spd)
        else
            if AW.currentStep >= #AW.WALK_SEQ then
                hum:Move(Vector3.zero, false)
                hrp.AssemblyLinearVelocity = Vector3.new(0, hrp.AssemblyLinearVelocity.Y, 0)
                awStopLoop()
            else
                AW.currentStep = AW.currentStep + 1
            end
        end
    end)
    addConnection(AW.loopConn)
end

function awLaunch(side)
    if not side then return end
    -- Toggle off: если уже работает — останавливаем независимо от side
    if AW.enabled then
        awStopLoop()
        return
    end
    local detectedSide = _detectSideNow()
    if not detectedSide then return end
    AW.activeSide = detectedSide
    AW.enabled    = true
    awSetBtnActive(detectedSide, true)
    awStartLoop()
end

-- ======================================
-- AUTO WALK FLOATING GUI  (L / R buttons)
-- ======================================

function createAutoWalkGui()
    local W      = 140
    local HDR_H  = 22
    local BTN_H  = 26
    local GAP    = 5
    local PAD    = 5
    local FULL_H = HDR_H + PAD + BTN_H + PAD

    local sg = Instance.new("ScreenGui", S.PlayerGui)
    sg.AutoLocalize = false
    sg.Name = "Looprix_AutoWalkGui"
    sg.ResetOnSpawn = false
    sg.DisplayOrder = 999998
    sg.Enabled = CONFIG.AUTO_WALK_PANEL_VISIBLE

    local function makeAS(parent, thick, initT)
        local s = Instance.new("UIStroke", parent)
        s.Thickness = thick or 1.2; s.Color = COLORS.Accent
        s.Transparency = initT or 0; s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        trackStroke(s)
        local g = Instance.new("UIGradient", s)
        g.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0,    COLORS.Accent),
            ColorSequenceKeypoint.new(0.33, Color3.fromRGB(120,255,200)),
            ColorSequenceKeypoint.new(0.66, Color3.fromRGB(150,255,180)),
            ColorSequenceKeypoint.new(1,    COLORS.Accent),
        })
        trackGradient(g)
        return s
    end

    local main = Instance.new("Frame", sg)
    main.Size = UDim2.new(0, W, 0, FULL_H)
    main.BackgroundColor3 = COLORS.Background
    main.BackgroundTransparency = 0.08
    main.BorderSizePixel = 0
    main.ClipsDescendants = true
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)
    registerScaleTarget(main)
    makeAS(main, 1.2, 0)

    local savedAW = CONFIG._guiPositions and CONFIG._guiPositions.autoWalkPanel
    if savedAW then
        main.Position = UDim2.new(savedAW.scaleX, savedAW.offsetX, savedAW.scaleY, savedAW.offsetY)
    else
        main.Position = UDim2.new(0, 10, 0, 220)
    end
    _regDraggable(main, function() return UDim2.new(0,10,0,220) end)

    local hdr = Instance.new("Frame", main)
    hdr.Size = UDim2.new(1, 0, 0, HDR_H)
    hdr.BackgroundColor3 = COLORS.Surface; hdr.BackgroundTransparency = 0.05; hdr.BorderSizePixel = 0
    Instance.new("UICorner", hdr).CornerRadius = UDim.new(0, 10)
    local hdrFill = Instance.new("Frame", hdr)
    hdrFill.Size = UDim2.new(1,0,0,8); hdrFill.Position = UDim2.new(0,0,1,-8)
    hdrFill.BackgroundColor3 = COLORS.Surface; hdrFill.BackgroundTransparency = 0.05; hdrFill.BorderSizePixel = 0

    local dot = Instance.new("Frame", hdr)
    dot.Size = UDim2.new(0,6,0,6); dot.Position = UDim2.new(0,9,0.5,-3)
    dot.BackgroundColor3 = COLORS.Accent; dot.BorderSizePixel = 0
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1,0)
    trackDot(dot)

    local titleLbl = Instance.new("TextLabel", hdr)
    titleLbl.AutoLocalize = false
    titleLbl.Size = UDim2.new(1,-34,1,0); titleLbl.Position = UDim2.new(0,20,0,0)
    titleLbl.BackgroundTransparency = 1; titleLbl.Text = "Auto Walk"
    titleLbl.TextColor3 = COLORS.Accent; titleLbl.Font = Enum.Font.GothamSemibold
    trackLabel(titleLbl)
    titleLbl.TextSize = 11; titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    local tg = Instance.new("UIGradient", titleLbl)
    tg.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,    COLORS.Accent),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(120,255,200)),
        ColorSequenceKeypoint.new(0.66, Color3.fromRGB(150,255,180)),
        ColorSequenceKeypoint.new(1,    COLORS.Accent)})
    trackGradient(tg)

    local minBtn = Instance.new("TextButton", hdr)
    minBtn.AutoLocalize = false
    minBtn.Size = UDim2.new(0,20,0,18); minBtn.Position = UDim2.new(1,-24,0.5,-9)
    minBtn.BackgroundColor3 = COLORS.Background; minBtn.BackgroundTransparency = 0.2
    minBtn.Text = "-"; minBtn.TextColor3 = COLORS.Accent
    minBtn.Font = Enum.Font.GothamBold; minBtn.TextSize = 14; minBtn.BorderSizePixel = 0
    Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0,4)
    makeAS(minBtn, 1, 0.4); trackLabel(minBtn)

    local content = Instance.new("Frame", main)
    content.Size = UDim2.new(1,0,1,-HDR_H); content.Position = UDim2.new(0,0,0,HDR_H)
    content.BackgroundTransparency = 1; content.BorderSizePixel = 0
    local btnLayout = Instance.new("UIListLayout", content)
    btnLayout.FillDirection = Enum.FillDirection.Horizontal
    btnLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    btnLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    btnLayout.Padding = UDim.new(0, GAP)
    local cPad = Instance.new("UIPadding", content)
    cPad.PaddingLeft=UDim.new(0,PAD); cPad.PaddingRight=UDim.new(0,PAD)
    cPad.PaddingTop=UDim.new(0,PAD); cPad.PaddingBottom=UDim.new(0,PAD)

    local FULL_W_AW = W - PAD*2

    local awMainBtn = Instance.new("TextButton", content)
    awMainBtn.AutoLocalize = false
    awMainBtn.LayoutOrder = 1
    awMainBtn.Size = UDim2.new(0, FULL_W_AW, 0, BTN_H)
    awMainBtn.BackgroundColor3 = COLORS.Surface
    awMainBtn.BackgroundTransparency = COLORS.SurfaceTransparency
    awMainBtn.Text = "Auto Walk"
    awMainBtn.TextColor3 = COLORS.Accent
    trackLabel(awMainBtn)
    awMainBtn.Font = Enum.Font.GothamBold; awMainBtn.TextSize = 12; awMainBtn.BorderSizePixel = 0
    Instance.new("UICorner", awMainBtn).CornerRadius = UDim.new(0,7)
    makeAS(awMainBtn, 1, 0.45)

    local awBadge = Instance.new("TextLabel", awMainBtn)
    awBadge.AutoLocalize = false
    awBadge.Size = UDim2.new(0,40,0,12); awBadge.AnchorPoint = Vector2.new(1,0)
    awBadge.Position = UDim2.new(1,-2,1,-5)
    awBadge.BackgroundColor3 = COLORS.Background; awBadge.BackgroundTransparency = 0.15
    awBadge.BorderSizePixel = 0; awBadge.Font = Enum.Font.GothamBold; awBadge.TextSize = 7
    awBadge.TextColor3 = COLORS.Accent; awBadge.ZIndex = 5
    awBadge.Text = CONFIG.AUTO_WALK_KEYBIND and CONFIG.AUTO_WALK_KEYBIND.Name or "NONE"
    Instance.new("UICorner", awBadge).CornerRadius = UDim.new(0,3)
    makeAS(awBadge, 1, 0.35); trackLabel(awBadge)
    task.spawn(function()
        while awMainBtn and awMainBtn.Parent do
            task.wait(0.5)
            awBadge.Text = CONFIG.AUTO_WALK_KEYBIND and CONFIG.AUTO_WALK_KEYBIND.Name or "NONE"
        end
    end)
    awMainBtn.MouseButton1Click:Connect(function()
        awLaunch("auto")
    end)

    awWalkBtnL = awMainBtn
    awWalkBtnR = awMainBtn

    local awMin = false
    minBtn.MouseButton1Click:Connect(function()
        awMin = not awMin
        if awMin then
            hdrFill.Visible=false; content.Visible=false
            S.TweenService:Create(main, tweenInfoMedium, {Size=UDim2.new(0,W,0,HDR_H)}):Play()
            minBtn.Text="+"
        else
            hdrFill.Visible=true; content.Visible=true
            S.TweenService:Create(main, tweenInfoMedium, {Size=UDim2.new(0,W,0,FULL_H)}):Play()
            minBtn.Text="-"
        end
    end)

    makeDraggable(main, hdr, "autoWalkPanel", function() return CONFIG.UI_LOCKED end)

    awGuiInstance = sg
    pcall(function()
        applyAccentColor(CONFIG.GUI_COLOR_R or 0, CONFIG.GUI_COLOR_G or 217, CONFIG.GUI_COLOR_B or 127)
    end)
    return sg
end

-- ======================================
-- SIDE HELPER  (explicit, no auto-detect)
-- ======================================

function canRunAutoPlay()
    if not _getMyPlot() then return false, "no_plot" end
    return true, nil
end


-- ======================================
-- LOCK TARGET SYSTEM
-- ======================================






-- Validate a target character
function _ltIsValid(char)
    if not char then return false end
    if not char.Parent then return false end  -- character removed from workspace
    local hum = char:FindFirstChildOfClass("Humanoid")
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local ff  = char:FindFirstChildOfClass("ForceField")
    return hum and hrp and hum.Health > 0 and not ff
end

-- Get nearest enemy; once locked keep tracking same target
function _ltGetTarget(myHRP)
    if _ltLockedTarget and _ltIsValid(_ltLockedTarget) then
        return _ltLockedTarget:FindFirstChild("HumanoidRootPart"), _ltLockedTarget
    end
    -- Previous target is gone — clear immediately and scan for new one
    _ltLockedTarget = nil
    _ltLastTargetY  = nil
    local bestChar, bestHRP, closest = nil, nil, math.huge
    for _, p in ipairs(S.Players:GetPlayers()) do
        if p ~= S.LocalPlayer and _ltIsValid(p.Character) then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            local d   = (hrp.Position - myHRP.Position).Magnitude
            if d < closest then closest = d; bestChar = p.Character; bestHRP = hrp end
        end
    end
    _ltLockedTarget = bestChar
    return bestHRP, bestChar
end

function _stopLockLookAt()
    if _lockAlignOri then _lockAlignOri:Destroy(); _lockAlignOri = nil end
    if _lockAttach   then _lockAttach:Destroy();   _lockAttach   = nil end
    local char = character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.AutoRotate = true end
    end
end

function startLockTarget()
    if lockTargetConnection then return end

    local char = character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end

    -- Setup orientation (bat-aimbot style)
    _stopLockLookAt()

    _lockAttach = Instance.new("Attachment", hrp)
    _lockAttach.Name = "LTAttach"
    _lockAlignOri = Instance.new("AlignOrientation", hrp)
    _lockAlignOri.Name            = "LTAlign"
    _lockAlignOri.Mode            = Enum.OrientationAlignmentMode.OneAttachment
    _lockAlignOri.Attachment0     = _lockAttach
    _lockAlignOri.MaxTorque       = math.huge
    _lockAlignOri.Responsiveness  = 200
    _lockAlignOri.RigidityEnabled = true

    lockTargetConnection = S.RunService.Heartbeat:Connect(function()
        if not CONFIG.LOCK_TARGET_ENABLED then return end
        local c     = character
        local myHRP = c and c:FindFirstChild("HumanoidRootPart")
        local myHum = c and c:FindFirstChildOfClass("Humanoid")
        if not myHRP or not myHum then return end

        local targetHRP, targetChar = _ltGetTarget(myHRP)
        if targetHRP and targetChar then
            myHum.AutoRotate = false

            -- ── TP-DOWN MIRROR DETECTION (Mirror Tp Down) ──────────────────────
            -- Only active when Mirror Tp Down is enabled in settings.
            -- Fires when enemy Y drops >= MIRROR_TP_DOWN_THRESHOLD studs in one frame.
            local currentTargetY = targetHRP.Position.Y
            if CONFIG.MIRROR_TP_DOWN_ENABLED
               and _ltLastTargetY ~= nil
               and not _ltTpMirrorInProgress
               and (_ltLastTargetY - currentTargetY) >= (CONFIG.MIRROR_TP_DOWN_THRESHOLD or 8) then
                -- Enemy teleported down — mirror it
                _ltTpMirrorInProgress = true
                -- Execute tp-down (snap us to ground immediately, lock stays on)
                pcall(function()
                    local params = RaycastParams.new()
                    params.FilterDescendantsInstances = {character}
                    params.FilterType = Enum.RaycastFilterType.Exclude
                    local result = workspace:Raycast(
                        myHRP.Position, Vector3.new(0, -500, 0), params)
                    if result then
                        local rot = myHRP.CFrame - myHRP.CFrame.Position
                        myHRP.CFrame = CFrame.new(
                            result.Position + Vector3.new(0, 3, 0)) * rot
                        myHRP.AssemblyLinearVelocity  = Vector3.zero
                        myHRP.AssemblyAngularVelocity = Vector3.zero
                    else
                        myHRP.AssemblyLinearVelocity = Vector3.new(
                            myHRP.AssemblyLinearVelocity.X, -100,
                            myHRP.AssemblyLinearVelocity.Z)
                    end
                end)
                task.defer(function()
                    _ltTpMirrorInProgress = false
                end)
                _ltLastTargetY = currentTargetY
            end
            if _ltLastTargetY == nil then _ltLastTargetY = currentTargetY end
            _ltLastTargetY = currentTargetY
            -- ────────────────────────────────────────────────────────────────

            -- Dynamic velocity prediction
            local tVel    = targetHRP.AssemblyLinearVelocity
            local tSpeed  = tVel.Magnitude
            local pt      = math.clamp(tSpeed / 150, 0.05, 0.2)
            local predicted = targetHRP.Position + tVel * pt

            -- Aim at predicted pos
            if _lockAlignOri and _lockAlignOri.Parent then
                _lockAlignOri.CFrame = CFrame.lookAt(myHRP.Position, predicted)
            end

            -- Move to 3 studs behind predicted pos
            local dir3D    = predicted - myHRP.Position
            local standPos = (dir3D.Magnitude > 0)
                and (predicted - dir3D.Unit * 3)
                or  predicted
            local moveDir  = standPos - myHRP.Position
            local spd      = CONFIG.LOCK_TARGET_SPEED or 55
            if moveDir.Magnitude > 1 then
                myHRP.AssemblyLinearVelocity = moveDir.Unit * spd
            else
                myHRP.AssemblyLinearVelocity = tVel
            end
        else
            _ltLockedTarget      = nil
            _ltLastTargetY       = nil
            _ltTpMirrorInProgress = false
            myHum.AutoRotate = true
        end
    end)
    addConnection(lockTargetConnection)
end

function stopLockTarget()
    if lockTargetConnection then
        lockTargetConnection:Disconnect()
        lockTargetConnection = nil
    end
    _ltLockedTarget      = nil
    _ltLastTargetY       = nil
    _ltTpMirrorInProgress = false
    _stopLockLookAt()
end

-- ======================================
-- INFINITY JUMP SYSTEM
-- ======================================

function startInfJump()
    if infJumpConnection then return end
    infJumpConnection = S.UserInputService.JumpRequest:Connect(function()
        if not CONFIG.INF_JUMP_ENABLED then return end
        local char = character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local vel = hrp.AssemblyLinearVelocity
        hrp.AssemblyLinearVelocity = Vector3.new(vel.X, jumpForce, vel.Z)
    end)
    addConnection(infJumpConnection)
end

function stopInfJump()
    if infJumpConnection then
        infJumpConnection:Disconnect()
        infJumpConnection = nil
    end
end

-- ======================================
-- OPTIMIZER SYSTEM
-- ======================================

function _applyFFlags()
    if not setfflag then return end
    for flag, value in pairs(PERF_FFLAGS) do
        pcall(function() setfflag(flag, tostring(value)) end)
    end
end

local function _stripVisuals(obj)
    local model = obj:FindFirstAncestorOfClass("Model")
    local isPlayer = model and S.Players:GetPlayerFromCharacter(model) ~= nil

    if obj:IsA("Animator") then
        local m = obj:FindFirstAncestorOfClass("Model")
        if m then
            local lp = S.Players.LocalPlayer
            if S.Players:GetPlayerFromCharacter(m) == lp then return end
        end
        for _, track in pairs(obj:GetPlayingAnimationTracks()) do
            track:Stop(0)
        end
        obj.AnimationPlayed:Connect(function(track)
            local m2 = obj:FindFirstAncestorOfClass("Model")
            if m2 then
                local lp2 = S.Players.LocalPlayer
                if S.Players:GetPlayerFromCharacter(m2) == lp2 then return end
            end
            track:Stop(0)
        end)
    end

    if obj:IsA("Accessory") or obj:IsA("Clothing") then
        if obj:FindFirstAncestorOfClass("Model") then
            obj:Destroy()
            return
        end
    end

    if not isPlayer then
        if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") or
           obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") or
           obj:IsA("Highlight") then
            obj.Enabled = false
        end
        if obj:IsA("Explosion") then
            obj:Destroy()
            return
        end
        if obj:IsA("MeshPart") then
            obj.TextureID = ""
        end
    end

    if obj:IsA("BasePart") then
        obj.Material = Enum.Material.Plastic
        obj.Reflectance = 0
        obj.CastShadow = false
    end

    if obj:IsA("SurfaceAppearance") or obj:IsA("Texture") or obj:IsA("Decal") then
        obj:Destroy()
    end
end

function startOptimizer()
    if getgenv and getgenv().OPTIMIZER_ACTIVE then return end
    if getgenv then getgenv().OPTIMIZER_ACTIVE = true end

    pcall(function()
        _optOriginal = {
            qualityLevel        = settings().Rendering.QualityLevel,
            meshPartDetailLevel = settings().Rendering.MeshPartDetailLevel,
            globalShadows       = S.Lighting.GlobalShadows,
            brightness          = S.Lighting.Brightness,
            fogEnd              = S.Lighting.FogEnd,
            fogStart            = S.Lighting.FogStart,
            technology          = S.Lighting.Technology,
            envDiffuse          = S.Lighting.EnvironmentDiffuseScale,
            envSpecular         = S.Lighting.EnvironmentSpecularScale,
            waterWaveSize       = workspace.Terrain.WaterWaveSize,
            waterWaveSpeed      = workspace.Terrain.WaterWaveSpeed,
            waterReflectance    = workspace.Terrain.WaterReflectance,
            waterTransparency   = workspace.Terrain.WaterTransparency,
            decoration          = workspace.Terrain.Decoration,
        }
    end)

    _applyFFlags()

    pcall(function()
        local r = settings().Rendering
        r.QualityLevel        = Enum.QualityLevel.Level01
        r.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level01
        pcall(function() r.EditQualityLevel = Enum.QualityLevel.Level01 end)
    end)

    pcall(function()
        S.Lighting.GlobalShadows            = false
        S.Lighting.FogEnd                   = 1000000
        S.Lighting.FogStart                 = 0
        S.Lighting.EnvironmentDiffuseScale  = 0
        S.Lighting.EnvironmentSpecularScale = 0
        for _, v in pairs(S.Lighting:GetChildren()) do
            if v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("ColorCorrectionEffect") or
               v:IsA("SunRaysEffect") or v:IsA("DepthOfFieldEffect") or v:IsA("Atmosphere") then
                pcall(function() v:Destroy() end)
            end
        end
    end)

    pcall(function()
        local ph = settings().Physics
        ph.AllowSleep = true
        pcall(function() ph.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Skip end)
        ph.ThrottleAdjustTime = 0
    end)

    pcall(function()
        workspace.Terrain.WaterWaveSize     = 0
        workspace.Terrain.WaterWaveSpeed    = 0
        workspace.Terrain.WaterReflectance  = 0
        workspace.Terrain.WaterTransparency = 1
        workspace.Terrain.Decoration        = false
    end)

    pcall(function() if setfpscap then setfpscap(999) end end)

    table.insert(_optThreads, task.spawn(function()
        task.wait(0.5)
        for _, obj in pairs(workspace:GetDescendants()) do
            pcall(_stripVisuals, obj)
        end
    end))

    table.insert(_optConns, workspace.DescendantAdded:Connect(function(obj)
        if not (getgenv and getgenv().OPTIMIZER_ACTIVE) then return end
        pcall(_stripVisuals, obj)
    end))

    table.insert(_optThreads, task.spawn(function()
        while getgenv and getgenv().OPTIMIZER_ACTIVE do
            task.wait(15)
            pcall(function() collectgarbage("collect") end)
        end
    end))
end

function stopOptimizer()
    if getgenv then getgenv().OPTIMIZER_ACTIVE = false end

    for _, t in ipairs(_optThreads) do pcall(function() task.cancel(t) end) end
    _optThreads = {}
    for _, c in ipairs(_optConns) do pcall(function() c:Disconnect() end) end
    _optConns = {}

    pcall(function()
        settings().Rendering.QualityLevel       = _optOriginal.qualityLevel       or Enum.QualityLevel.Automatic
        settings().Rendering.MeshPartDetailLevel = _optOriginal.meshPartDetailLevel or Enum.MeshPartDetailLevel.DistanceBased
        S.Lighting.GlobalShadows                = _optOriginal.globalShadows ~= false
        S.Lighting.Brightness                   = _optOriginal.brightness    or 1
        S.Lighting.FogEnd                       = _optOriginal.fogEnd        or 100000
        S.Lighting.FogStart                     = _optOriginal.fogStart      or 0
        S.Lighting.Technology                   = _optOriginal.technology    or Enum.Technology.ShadowMap
        S.Lighting.EnvironmentDiffuseScale      = _optOriginal.envDiffuse    or 1
        S.Lighting.EnvironmentSpecularScale     = _optOriginal.envSpecular   or 1
        workspace.Terrain.WaterWaveSize         = _optOriginal.waterWaveSize    or 0.15
        workspace.Terrain.WaterWaveSpeed        = _optOriginal.waterWaveSpeed   or 10
        workspace.Terrain.WaterReflectance      = _optOriginal.waterReflectance or 1
        workspace.Terrain.WaterTransparency     = _optOriginal.waterTransparency or 0.3
        workspace.Terrain.Decoration            = _optOriginal.decoration ~= false
    end)
end

-- ======================================
-- XRAY SYSTEM
-- ======================================

function startXRay()
    pcall(function()
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Anchored and (obj.Name:lower():find("base") or (obj.Parent and obj.Parent.Name:lower():find("base"))) then
                originalTransparency[obj] = obj.LocalTransparencyModifier
                obj.LocalTransparencyModifier = 0.85
            end
        end
    end)
end

function stopXRay()
    for part, value in pairs(originalTransparency) do
        if part then 
            pcall(function() part.LocalTransparencyModifier = value end)
        end
    end
    originalTransparency = {}
end

-- ======================================
-- NO CAMERA COLLISION  (K7 — fully independent of XRay)
-- ======================================

function enableNoCameraCollision()
    _NCC.enabled = true
    if _NCC.conn then _NCC.conn:Disconnect() end
    _NCC.conn = S.RunService.RenderStepped:Connect(function()
        if not CONFIG.NO_CAM_COLLISION_ENABLED then return end
        local ch  = S.LocalPlayer.Character; if not ch then return end
        local cam = workspace.CurrentCamera;  if not cam then return end
        local hrp = ch:FindFirstChild("HumanoidRootPart"); if not hrp then return end
        local camPos  = cam.CFrame.Position
        local charPos = hrp.Position + Vector3.new(0, 1.5, 0)
        local toChar  = charPos - camPos
        local dist    = toChar.Magnitude
        if dist < 0.3 then return end
        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Exclude
        params.FilterDescendantsInstances = {ch}
        params.IgnoreWater = true
        local hit     = {}
        local origin    = camPos
        local remaining = toChar
        for _ = 1, 12 do
            if remaining.Magnitude < 0.2 then break end
            local res = workspace:Raycast(origin, remaining, params)
            if not res then break end
            local p = res.Instance
            if p and p:IsA("BasePart") and not p:IsDescendantOf(ch) then
                hit[p] = true
                if _NCC.parts[p] == nil then
                    -- save independently — never reads from originalTransparency (XRay)
                    _NCC.parts[p] = p.LocalTransparencyModifier
                end
                p.LocalTransparencyModifier = 1
            end
            origin    = res.Position + remaining.Unit * 0.02
            remaining = charPos - origin
        end
        -- collect then clear — never nil-during-pairs
        local toRestore = {}
        for p in pairs(_NCC.parts) do
            if not hit[p] then table.insert(toRestore, p) end
        end
        for _, p in ipairs(toRestore) do
            pcall(function()
                if p and p.Parent then p.LocalTransparencyModifier = _NCC.parts[p] end
            end)
            _NCC.parts[p] = nil
        end
    end)
end

function disableNoCameraCollision()
    _NCC.enabled = false
    if _NCC.conn then _NCC.conn:Disconnect(); _NCC.conn = nil end
    -- restore all saved transparencies cleanly
    for p, orig in pairs(_NCC.parts) do
        pcall(function() if p and p.Parent then p.LocalTransparencyModifier = orig end end)
    end
    _NCC.parts = {}
end

-- ======================================
-- NO PLAYER COLLISION SYSTEM
-- ======================================


function disableCollisionForPlayer(character)
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end

function startNoCollision()
    if noCollisionConnection then return end
    
    noCollisionConnection = S.RunService.Stepped:Connect(function()
        if not CONFIG.NO_COLLISION_ENABLED then return end
        for _, player in ipairs(S.Players:GetPlayers()) do
            if player ~= S.LocalPlayer then
                local char = player.Character
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
        noCollisionConnection = nil
    end
end

-- ======================================
-- DESYNC SYSTEM
-- ======================================

function _applyDesyncSpeedFlags()
    for key, value in pairs(_DESYNC_SPEED_FLAGS) do
        pcall(function() setfflag(key, value) end)
    end
end

function _rakhook(packet)
    if packet.PacketId == 0x1B then
        local data = packet.AsBuffer
        buffer.writeu32(data, 1, 0xFFFFFFFF)
        packet:SetData(data)
    end
end

function startDesync()
    _applyDesyncSpeedFlags()
    if desyncMode == "pc" then
        if not _desyncHooked then
            pcall(function() raknet.add_send_hook(_rakhook) end)
            _desyncHooked = true
        end
    else
        task.wait(0.4)
        pcall(function() raknet.desync(true) end)
    end
    desyncEnabled = true
end

function stopDesync()
    if desyncMode == "pc" then
        if _desyncHooked then
            pcall(function() raknet.remove_send_hook(_rakhook) end)
            _desyncHooked = false
        end
    else
        pcall(function() raknet.desync(false) end)
    end
    desyncEnabled = false
end

function toggleDesync(state)
    CONFIG.DESYNC_ENABLED = state
    if state then
        startDesync()
    else
        stopDesync()
    end
    saveConfig()
end

-- ── Desync Server-Position ESP ────────────────────────────────────────────────
function startServerPos(char)
    if _desyncEspCube then _desyncEspCube:Destroy(); _desyncEspCube = nil end
    if _desyncEspHB   then _desyncEspHB:Disconnect(); _desyncEspHB = nil end

    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local cube = Instance.new("Part")
    cube.Name        = "LooprixDesyncGhost"
    cube.Anchored    = true
    cube.CanCollide  = false
    cube.Size        = Vector3.new(4, 5, 1)
    cube.Color       = COLORS.Accent
    cube.Material    = Enum.Material.Neon
    cube.Transparency= 0.6
    cube.Position    = hrp.Position
    cube.Parent      = workspace
    _desyncEspCube   = cube
    table.insert(_accentFrames, cube)   -- tracked so accent color updates it

    local hl = Instance.new("Highlight", cube)
    hl.FillColor         = COLORS.Accent
    hl.FillTransparency  = 0.5
    hl.OutlineColor      = Color3.fromRGB(255,255,255)
    hl.OutlineTransparency = 0
    table.insert(_accentFrames, hl)

    local bill = Instance.new("BillboardGui", cube)
    bill.Size        = UDim2.new(0,100,0,26)
    bill.StudsOffset = Vector3.new(0,3.5,0)
    bill.AlwaysOnTop = true

    local lbl = Instance.new("TextLabel", bill)
    lbl.Size                   = UDim2.new(1,0,1,0)
    lbl.BackgroundTransparency = 1
    lbl.Text                   = "SERVER"
    lbl.Font                   = Enum.Font.GothamBlack
    lbl.TextColor3             = COLORS.Accent
    lbl.TextStrokeTransparency = 0
    lbl.TextStrokeColor3       = Color3.new(0,0,0)
    lbl.TextSize               = 10
    table.insert(_accentLabels, lbl)

    local lastPos            = hrp.Position
    local serverConfirmedPos = hrp.Position

    _desyncEspHB = S.RunService.Heartbeat:Connect(function()
        if not hrp or not hrp.Parent then
            if _desyncEspCube then _desyncEspCube:Destroy(); _desyncEspCube = nil end
            if _desyncEspHB   then _desyncEspHB:Disconnect(); _desyncEspHB = nil end
            return
        end
        local cur = hrp.Position
        if (cur - lastPos).Magnitude > 4 then serverConfirmedPos = cur end
        lastPos = cur
        cube.Position = serverConfirmedPos
        cube.Color    = COLORS.Accent
        hl.FillColor  = COLORS.Accent
        lbl.TextColor3= COLORS.Accent
    end)
end

function disableServerPos()
    if _desyncEspCube then _desyncEspCube:Destroy(); _desyncEspCube = nil end
    if _desyncEspHB   then _desyncEspHB:Disconnect(); _desyncEspHB  = nil end
end

-- ======================================
-- FLOAT SYSTEM  (velocity-based rise, speed slider)
-- ======================================


function tpDown()
    pcall(function()
        local char = character
        local hrp  = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local params = RaycastParams.new()
        params.FilterDescendantsInstances = {char}
        params.FilterType = Enum.RaycastFilterType.Exclude
        local result = workspace:Raycast(hrp.Position, Vector3.new(0, -500, 0), params)
        if result then
            -- snap to ground, preserve rotation (no CFrame.Rotation override)
            local rot = hrp.CFrame - hrp.CFrame.Position
            hrp.CFrame = CFrame.new(result.Position + Vector3.new(0, 3, 0)) * rot
            hrp.AssemblyLinearVelocity  = Vector3.zero
            hrp.AssemblyAngularVelocity = Vector3.zero
        else
            -- fallback: slam velocity
            hrp.AssemblyLinearVelocity = Vector3.new(
                hrp.AssemblyLinearVelocity.X, -100,
                hrp.AssemblyLinearVelocity.Z)
        end
    end)
end


function _syncFloatBtn(active)
    if not floatPanelBtn then return end
    floatPanelBtn.Text = active and "FLOAT: ON" or "FLOAT: OFF"
end

function startFloat()
    if not CONFIG.FLOAT_PANEL_VISIBLE then return end
    if _FLT.conn then return end
    _FLT.enabled        = true
    CONFIG.FLOAT_ACTIVE = true
    _FLT.curHip        = 0
    _FLT.tpInProgress  = false
    pcall(function()
        local hum = character and character:FindFirstChildOfClass("Humanoid")
        if hum then _FLT.curHip = hum.HipHeight end
    end)
    _syncFloatBtn(true)

    local myGen = _FLT.gen

    _FLT.conn = S.RunService.Heartbeat:Connect(function()
        if not _FLT.enabled then return end
        if _FLT.tpInProgress then return end
        pcall(function()
            local char = character
            local hum  = char and char:FindFirstChildOfClass("Humanoid")
            local hrp  = char and char:FindFirstChild("HumanoidRootPart")
            if not hum or not hrp then return end

            local target = CONFIG.FLOAT_HEIGHT or 10
            local speed  = math.clamp(CONFIG.FLOAT_SPEED or 50, 1, 100)
            local step   = (speed / 100) * 2.0

            if _FLT.curHip < target then
                _FLT.curHip = math.min(_FLT.curHip + step, target)
            elseif _FLT.curHip > target then
                _FLT.curHip = math.max(_FLT.curHip - step * 5, target)
            end

            if math.abs(hum.HipHeight - _FLT.curHip) > 0.01 then
                hum.HipHeight = _FLT.curHip
            end


            if CONFIG.AUTO_TP_DOWN_ENABLED
               and _FLT.curHip >= target - 0.05 then
                _FLT.tpInProgress = true
                hum.HipHeight = 2
                _FLT.curHip  = 0
                task.delay(0.05, function()

                    if not _FLT.enabled or _FLT.gen ~= myGen then
                        _FLT.tpInProgress = false
                        return
                    end
                    tpDown()
                    task.delay(0.08, function()

                        if _FLT.gen ~= myGen then
                            _FLT.tpInProgress = false
                            return
                        end
                        _FLT.tpInProgress = false
                    end)
                end)
            end
        end)
    end)
    addConnection(_FLT.conn)
end

function stopFloat()
    _FLT.enabled        = false
    CONFIG.FLOAT_ACTIVE = false
    _FLT.tpInProgress  = false
    _FLT.gen    = _FLT.gen + 1
    if _FLT.conn then
        _FLT.conn:Disconnect()
        _FLT.conn = nil
    end
    pcall(function()
        local char = character
        local hum  = char and char:FindFirstChildOfClass("Humanoid")
        if hum then hum.HipHeight = 2 end
    end)
    _FLT.curHip = 0
    _syncFloatBtn(false)
    task.delay(0.05, function()
        tpDown()
    end)
    saveConfig()
end

-- ======================================
-- AUTO PLAY SYSTEM
-- ======================================

function apGetTarget(key)
    local b   = AP.BASE[AP.activeSide][key]
    local off = AP.offsets[AP.activeSide][key]
    return b + Vector3.new(off.x, 0, off.z)
end

function apGetSpeed(step)
    if step <= 3 then
        return CONFIG.SPEED_VALUE or 60
    else
        return CONFIG.STEAL_SPEED_VALUE or 30
    end
end

function apGetRadius(key)
    return key == "P5" and 1.5 or 2.0
end

function apClearESP()
    if AP.espFolder then
        for _, p in pairs(AP.espParts) do pcall(function() if p and p.Parent then p:Destroy() end end) end
        AP.espParts = {}
    end
end

function apRefreshESP()
    apClearESP()
    if not AP.activeSide then return end
    if not AP.espFolder then
        AP.espFolder = Instance.new("Folder", workspace)
        AP.espFolder.Name = "Looprix_AutoPlay_ESP"
    end
    for k, v in pairs(AP.BASE[AP.activeSide]) do
        local off  = AP.offsets[AP.activeSide][k]
        local pos  = v + Vector3.new(off.x, 0, off.z)
        local part = Instance.new("Part", AP.espFolder)
        part.Size = Vector3.new(1.2, 1.2, 1.2)
        part.Position = pos
        part.Anchored = true
        part.CanCollide = false
        part.Material = Enum.Material.Neon
        part.Color = COLORS.Accent
        part.Transparency = 0.3
        local box = Instance.new("SelectionBox", part)
        box.Adornee = part
        box.Color3 = COLORS.Accent
        box.LineThickness = 0.03
        local bg = Instance.new("BillboardGui", part)
        bg.Size = UDim2.new(0, 50, 0, 14)
        bg.AlwaysOnTop = true
        bg.StudsOffset = Vector3.new(0, 2, 0)
        local tl = Instance.new("TextLabel", bg)
        tl.AutoLocalize = false
        tl.Size = UDim2.new(1, 0, 1, 0)
        tl.BackgroundTransparency = 1
        tl.Text = k
        tl.TextColor3 = COLORS.Accent
        trackLabel(tl)
        tl.Font = Enum.Font.GothamBold
        tl.TextSize = 9
        table.insert(AP.espParts, part)
    end
end

function apSetBtnActive(btn, active)
    if not btn then return end
    S.TweenService:Create(btn, tweenInfoFast, {
        BackgroundColor3       = active and COLORS.Accent or COLORS.Surface,
        BackgroundTransparency = active and 0.0 or COLORS.SurfaceTransparency,
    }):Play()
    btn.TextColor3 = active and Color3.fromRGB(10, 10, 10) or COLORS.TextDim
end

function apStopLoop()
    AP.enabled = false
    AP.isWaiting = false
    if AP.loopConn then AP.loopConn:Disconnect(); AP.loopConn = nil end
    AP.currentStep = 1
    if AP._speedWas ~= nil then
        CONFIG.SPEED_ENABLED = AP._speedWas
        AP._speedWas = nil
    end
    pcall(function()
        local char = character
        local hum  = char and char:FindFirstChildOfClass("Humanoid")
        local hrp  = char and char:FindFirstChild("HumanoidRootPart")
        if hum then hum:Move(Vector3.zero, false) end
        if hrp then hrp.AssemblyLinearVelocity = Vector3.new(0, hrp.AssemblyLinearVelocity.Y, 0) end
    end)
end

function apResetBtns()
    apSetBtnActive(apBtnL, false)
    apSetBtnActive(apBtnR, false)
end

function apStartLoop()
    if AP.loopConn then AP.loopConn:Disconnect() end
    AP.currentStep = 1
    AP.isWaiting   = false
    AP._speedWas   = nil
    AP._stepStartTick = tick()

    AP.loopConn = S.RunService.Heartbeat:Connect(function()
        if not AP.enabled or AP.isWaiting then return end
        local char = character
        local hrp  = char and char:FindFirstChild("HumanoidRootPart")
        local hum  = char and char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum then return end
        -- Anti-stuck: if same step is taking >6 seconds, abort the whole run
        if tick() - AP._stepStartTick > 6 then
            hum:Move(Vector3.zero, false)
            hrp.AssemblyLinearVelocity = Vector3.new(0, hrp.AssemblyLinearVelocity.Y, 0)
            apStopLoop()
            task.defer(apResetBtns)
            return
        end

        local key    = AP.SEQUENCE[AP.currentStep]
        local target = apGetTarget(key)
        local flat   = Vector3.new(target.X, hrp.Position.Y, target.Z)
        local dist   = (flat - hrp.Position).Magnitude

        if AP.currentStep == 4 and AP._speedWas == nil then
            AP._speedWas = CONFIG.SPEED_ENABLED
            CONFIG.SPEED_ENABLED = false
        end

        if dist > apGetRadius(key) then
            local dir = (flat - hrp.Position).Unit
            hum:Move(dir, false)
            if AP.currentStep <= 3 then
                -- Approach: let humanoid's own move handle it, small nudge only
                hrp.AssemblyLinearVelocity = Vector3.new(
                    dir.X * (CONFIG.SPEED_VALUE or 60),
                    hrp.AssemblyLinearVelocity.Y,
                    dir.Z * (CONFIG.SPEED_VALUE or 60)
                )
            else
                local spd = CONFIG.STEAL_SPEED_VALUE or 30
                hrp.AssemblyLinearVelocity = Vector3.new(
                    dir.X * spd,
                    hrp.AssemblyLinearVelocity.Y,
                    dir.Z * spd
                )
            end
        else
            -- Reached target
            AP._stepStartTick = tick()  -- reset timeout for next step
            if key == "P5" then
                hum:Move(Vector3.zero, false)
                hrp.AssemblyLinearVelocity = Vector3.new(0, hrp.AssemblyLinearVelocity.Y, 0)
                AP.isWaiting = true
                task.delay(CONFIG.AUTO_PLAY_DELAY or 0.03, function()
                    AP.isWaiting   = false
                    AP.currentStep = AP.currentStep + 1
                end)
            elseif AP.currentStep == #AP.SEQUENCE then
                hum:Move(Vector3.zero, false)
                hrp.AssemblyLinearVelocity = Vector3.new(0, hrp.AssemblyLinearVelocity.Y, 0)
                apStopLoop()
                task.defer(apResetBtns)
            else
                AP.currentStep = AP.currentStep + 1
            end
        end
    end)
    addConnection(AP.loopConn)
end

function apLaunchSide(side)
    if not side then return end
    -- Toggle off: если уже работает — останавливаем независимо от side
    if AP.enabled then
        apStopLoop()
        apResetBtns()
        return
    end
    if isSwitching then return end
    task.spawn(function()
        -- Detect side on-demand at launch
        local detectedSide = _detectSideNow()
        if not detectedSide then return end
        local ok = canRunAutoPlay()
        if not ok then return end
        -- Mutual exclusion: disable Lock Target if it is on
        if CONFIG.LOCK_TARGET_ENABLED then
            isSwitching = true
            CONFIG.LOCK_TARGET_ENABLED = false
            lockTargetEnabled = false
            stopLockTarget()
            if lockTargetPanelBtn then
                lockTargetPanelBtn.Text = "LOCK: OFF"
            end
            saveConfig()
            isSwitching = false
        end
        apStopLoop()
        AP.activeSide = detectedSide
        apRefreshESP()
        AP.enabled = true
        apStartLoop()
        apSetBtnActive(detectedSide == "L" and apBtnL or apBtnR, true)
    end)
end

-- ======================================
-- AUTO MEDUSA SYSTEM
-- ======================================

function setupMedusaIndicator(char)
    if not char then return end
    local root = char:WaitForChild("HumanoidRootPart", 5)
    if not root then return end
    
    if medusaCircle then medusaCircle:Destroy() end
    
    medusaCircle = Instance.new("CylinderHandleAdornment")
    medusaCircle.Name = "MedusaRadius"
    medusaCircle.Adornee = root
    medusaCircle.AlwaysOnTop = true
    medusaCircle.ZIndex = 5
    medusaCircle.Transparency = 0.6
    medusaCircle.Color3 = COLORS.Accent
    medusaCircle.Radius = CONFIG.AUTO_MEDUSA_RANGE
    medusaCircle.Height = 0.05
    medusaCircle.CFrame = CFrame.new(0, -3, 0) * CFrame.Angles(math.rad(90), 0, 0)
    medusaCircle.Parent = root
end

function startAutoMedusa()
    if autoMedusaConnection then return end
    
    if character then
        setupMedusaIndicator(character)
    end
    
    if not medusaCharAddedConnection then
        medusaCharAddedConnection = S.LocalPlayer.CharacterAdded:Connect(function(newChar)
            if CONFIG.AUTO_MEDUSA_ENABLED then
                setupMedusaIndicator(newChar)
            end
        end)
        addConnection(medusaCharAddedConnection)
    end

    autoMedusaConnection = S.RunService.Heartbeat:Connect(function()
        if not CONFIG.AUTO_MEDUSA_ENABLED then return end
        
        if medusaCircle then
            medusaCircle.Radius = CONFIG.AUTO_MEDUSA_RANGE
        end
        
        local char = character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        
        local equippedTool
        for _, v in ipairs(char:GetChildren()) do
            if v:IsA("Tool") and v.Name:lower():find("medusa") then
                equippedTool = v
                break
            end
        end
        
        if not equippedTool then return end
        
        for _, p in ipairs(S.Players:GetPlayers()) do
            if p ~= S.LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (p.Character.HumanoidRootPart.Position - root.Position).Magnitude
                if dist <= CONFIG.AUTO_MEDUSA_RANGE then
                    pcall(function() equippedTool:Activate() end)
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
        autoMedusaConnection = nil
    end
    if medusaCharAddedConnection then
        medusaCharAddedConnection:Disconnect()
        medusaCharAddedConnection = nil
    end
    if medusaCircle then
        medusaCircle:Destroy()
        medusaCircle = nil
    end
end

-- ======================================
-- MEDUSA COUNTER SYSTEM  (K7 logic)
-- Автоматически контрит медузу когда тебя окаменяют
-- ======================================

function findMedusaForCounter()
    local char = character; if not char then return nil end
    for _, tool in ipairs(char:GetChildren()) do
        if tool:IsA("Tool") then
            local tn = tool.Name:lower()
            if tn:find("medusa") or tn:find("head") or tn:find("stone") then return tool end
        end
    end
    local bp = S.LocalPlayer:FindFirstChild("Backpack")
    if bp then
        for _, tool in ipairs(bp:GetChildren()) do
            if tool:IsA("Tool") then
                local tn = tool.Name:lower()
                if tn:find("medusa") or tn:find("head") or tn:find("stone") then return tool end
            end
        end
    end
    return nil
end

function useMedusaCounter()
    if medusaCounterDebounce then return end
    if tick() - medusaCounterLastUsed < MEDUSA_COUNTER_COOLDOWN then return end
    local char = character; if not char then return end
    medusaCounterDebounce = true
    local med = findMedusaForCounter()
    if not med then medusaCounterDebounce = false; return end
    if med.Parent ~= char then
        local hum2 = char:FindFirstChildOfClass("Humanoid")
        if hum2 then hum2:EquipTool(med) end
    end
    pcall(function() med:Activate() end)
    medusaCounterLastUsed = tick()
    medusaCounterDebounce = false
end

function stopMedusaCounter()
    for _, c in pairs(medusaCounterConns) do pcall(function() c:Disconnect() end) end
    medusaCounterConns = {}
end

function setupMedusaCounter(char)
    stopMedusaCounter()
    if not char then return end
    local function onAnchorChanged(part)
        return part:GetPropertyChangedSignal("Anchored"):Connect(function()
            if CONFIG.MEDUSA_COUNTER_ENABLED and part.Anchored and part.Transparency == 1 then
                useMedusaCounter()
            end
        end)
    end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            table.insert(medusaCounterConns, onAnchorChanged(part))
        end
    end
    table.insert(medusaCounterConns, char.DescendantAdded:Connect(function(part)
        if part:IsA("BasePart") then
            table.insert(medusaCounterConns, onAnchorChanged(part))
        end
    end))
end

-- ======================================
-- INSTANT GRAB SYSTEM
-- ======================================



function ResetStealProgressBar()
    if stealFillFrame then
        stealFillFrame.Size = UDim2.new(0, 0, 1, 0)
        stealFillFrame.Visible = false
    end
end

function isMyPlotByName(pn)
    local plots = workspace:FindFirstChild("Plots")
    if not plots then return false end
    local plot = plots:FindFirstChild(pn)
    if not plot then return false end
    local sign = plot:FindFirstChild("PlotSign")
    if sign then
        local yb = sign:FindFirstChild("YourBase")
        if yb and yb:IsA("BillboardGui") then return yb.Enabled == true end
    end
    return false
end

function findNearestPrompt()
    if not HRP then return nil end
    local plots = workspace:FindFirstChild("Plots")
    if not plots then return nil end
    local np, nd, nn = nil, math.huge, nil
    for _, plot in ipairs(plots:GetChildren()) do
        if isMyPlotByName(plot.Name) then continue end
        local podiums = plot:FindFirstChild("AnimalPodiums")
        if not podiums then continue end
        for _, pod in ipairs(podiums:GetChildren()) do
            pcall(function()
                local base = pod:FindFirstChild("Base")
                local spawn = base and base:FindFirstChild("Spawn")
                if spawn then
                    local dist = (spawn.Position - HRP.Position).Magnitude
                    if dist < nd and dist <= CONFIG.INSTANT_GRAB_ACTIVATION_DIST then
                        local att = spawn:FindFirstChild("PromptAttachment")
                        if att then
                            for _, ch in ipairs(att:GetChildren()) do
                                if ch:IsA("ProximityPrompt") then np, nd, nn = ch, dist, pod.Name break end
                            end
                        end
                    end
                end
            end)
        end
    end
    return np, nd, nn
end

function executeSteal(prompt, name)
    if isStealing then return end
    if not StealData[prompt] then
        StealData[prompt] = {hold = {}, trigger = {}, ready = true}
        pcall(function()
            if getconnections then
                for _, c in ipairs(getconnections(prompt.PromptButtonHoldBegan)) do
                    if c.Function then table.insert(StealData[prompt].hold, c.Function) end
                end
                for _, c in ipairs(getconnections(prompt.Triggered)) do
                    if c.Function then table.insert(StealData[prompt].trigger, c.Function) end
                end
            end
        end)
    end
    
    local data = StealData[prompt]
    if not data.ready then return end
    
    data.ready = false
    isStealing = true
    stealStartTime = tick()
    
    if stealFillFrame then
        stealFillFrame.Size = UDim2.new(0, 0, 1, 0)
        stealFillFrame.Visible = true
    end
    
    -- Heartbeat-driven progress (k7 style) — guaranteed accurate fill
    if stealProgressConnection then stealProgressConnection:Disconnect() end
    stealProgressConnection = S.RunService.Heartbeat:Connect(function()
        if not isStealing then
            if stealProgressConnection then stealProgressConnection:Disconnect() stealProgressConnection = nil end
            return
        end
        local prog = math.clamp((tick() - stealStartTime) / STEAL_DURATION, 0, 1)
        if stealFillFrame then stealFillFrame.Size = UDim2.new(prog, 0, 1, 0) end
    end)
    
    task.spawn(function()
        for _, f in ipairs(data.hold) do task.spawn(f) end
        -- Elapsed loop from k7 — ticks until full duration passes precisely
        local elapsed = 0
        while elapsed < STEAL_DURATION do elapsed = elapsed + task.wait() end
        for _, f in ipairs(data.trigger) do task.spawn(f) end
        -- Force bar to 100% before reset so it visually completes
        if stealFillFrame then stealFillFrame.Size = UDim2.new(1, 0, 1, 0) end
        task.wait(0.05) -- brief hold at 100% so user sees full bar
        if stealProgressConnection then stealProgressConnection:Disconnect() stealProgressConnection = nil end
        ResetStealProgressBar()
        data.ready = true
        isStealing = false
    end)
end

function startInstantGrab()
    if autoStealConn then return end
    
    autoStealEnabled = true
    
    autoStealConn = S.RunService.Heartbeat:Connect(function()
        if not CONFIG.INSTANT_GRAB_ENABLED or isStealing then return end
        local p, _, n = findNearestPrompt()
        if p then executeSteal(p, n) end
    end)
    addConnection(autoStealConn)
end

function stopInstantGrab()
    autoStealEnabled = false
    if autoStealConn then
        autoStealConn:Disconnect()
        autoStealConn = nil
    end
    if stealProgressConnection then
        stealProgressConnection:Disconnect()
        stealProgressConnection = nil
    end
    ResetStealProgressBar()
end

-- ======================================
-- FLOATING PANELS
-- ======================================

function createFloatingPanel(name, configPath, configVisible, defaultText)
    local panelGui = Instance.new("ScreenGui")
    panelGui.AutoLocalize = false
    panelGui.Name = "Looprix_Floating_" .. name
    panelGui.ResetOnSpawn = false
    panelGui.DisplayOrder = 999998
    panelGui.Enabled = CONFIG[configVisible]
    pcall(function()
        if gethui then panelGui.Parent = gethui()
        elseif syn and syn.protect_gui then syn.protect_gui(panelGui); panelGui.Parent = S.PlayerGui
        else panelGui.Parent = S.PlayerGui end
    end)
    if not panelGui.Parent then panelGui.Parent = S.PlayerGui end

    local frame = Instance.new("TextButton", panelGui)
    frame.AutoLocalize = false
    frame.Size = UDim2.new(0, 100, 0, 33)
    frame.BackgroundColor3 = Color3.fromRGB(10, 12, 18)
    frame.BackgroundTransparency = 0.15
    frame.BorderSizePixel = 0
    frame.Text = defaultText
    frame.TextColor3 = COLORS.Accent
    frame.Font = Enum.Font.GothamBold
    frame.TextSize = 11
    frame.AutoButtonColor = false
    trackLabel(frame)

    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)
    registerScaleTarget(frame)

    local stroke = Instance.new("UIStroke", frame)
    stroke.Color = COLORS.Accent
    stroke.Thickness = 1
    stroke.Transparency = 0.1
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    trackStroke(stroke)

    local strokeGrad = Instance.new("UIGradient", stroke)
    strokeGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,    Color3.fromRGB(0, 217, 127)),
        ColorSequenceKeypoint.new(0.25, Color3.fromRGB(120, 255, 210)),
        ColorSequenceKeypoint.new(0.5,  Color3.fromRGB(150, 255, 180)),
        ColorSequenceKeypoint.new(0.75, Color3.fromRGB(120, 255, 210)),
        ColorSequenceKeypoint.new(1,    Color3.fromRGB(0, 217, 127))
    })
    trackGradient(strokeGrad)

    loadAndClampPosition(frame, configPath, UDim2.new(0, 10, 0.5, 0))
    _regDraggable(frame, function() return UDim2.new(0, 10, 0.5, 0) end)
    local _fpIsTap = makeDraggable(frame, frame, configPath, function() return CONFIG.UI_LOCKED end)

    pcall(function()
        applyAccentColor(CONFIG.GUI_COLOR_R or 0, CONFIG.GUI_COLOR_G or 217, CONFIG.GUI_COLOR_B or 127)
    end)

    -- Helper: connect a callback that fires only on tap (not drag), with no mobile delay
    local function onTap(cb)
        frame.InputEnded:Connect(function(inp)
            if inp.UserInputType ~= Enum.UserInputType.MouseButton1 and
               inp.UserInputType ~= Enum.UserInputType.Touch then return end
            if not _fpIsTap() then return end
            cb()
        end)
    end

    return panelGui, frame, onTap
end

-- ======================================
-- SPEED BOOST LOGIC
-- ======================================

function startSpeed()
    if speedBoostConn then return end
    speedBoostConn = S.RunService.Heartbeat:Connect(function()
        if not CONFIG.SPEED_ENABLED then return end
        local char = character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not hum or not root then return end
        if hum.MoveDirection.Magnitude > 0 then
            local _isStealing = S.LocalPlayer:GetAttribute("Stealing")
            local vel = _isStealing and CONFIG.STEAL_SPEED_VALUE or CONFIG.SPEED_VALUE
            root.AssemblyLinearVelocity = Vector3.new(
                hum.MoveDirection.X * vel,
                root.AssemblyLinearVelocity.Y,
                hum.MoveDirection.Z * vel
            )
        end
    end)
    addConnection(speedBoostConn)
end

function stopSpeed()
    if speedBoostConn then
        speedBoostConn:Disconnect()
        speedBoostConn = nil
    end
end

-- ======================================
-- SPEED METER  (K7 style — BillboardGui rebuilt on CharacterAdded, updated on RenderStepped)
-- ======================================

function _speedMeterSetupBB()
    -- destroy any previous BB
    if _speedMeterBB and _speedMeterBB.Parent then _speedMeterBB:Destroy() end
    _speedMeterBB    = nil
    _speedMeterLabel = nil

    local char = S.LocalPlayer.Character
    if not char then return end
    local head = char:FindFirstChild("Head")
    if not head then return end

    local bb = Instance.new("BillboardGui", head)
    bb.Name         = "LooprixSpeedMeter"
    bb.Size         = UDim2.new(0, 110, 0, 18)  -- smaller than before
    bb.StudsOffset  = Vector3.new(0, 2.6, 0)
    bb.AlwaysOnTop  = true
    bb.ResetOnSpawn = false

    local lbl = Instance.new("TextLabel", bb)
    lbl.Size                   = UDim2.new(1, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text                   = "Speed: 0.0"
    lbl.TextColor3             = COLORS.Accent
    lbl.TextStrokeTransparency = 0
    lbl.TextStrokeColor3       = COLORS.Background
    lbl.Font                   = Enum.Font.GothamBold
    lbl.TextSize               = 11   -- fixed small size

    _speedMeterBB    = bb
    _speedMeterLabel = lbl
end

function toggleSpeedMeter(state)
    -- tear down update loop
    if _speedMeterUpdateConn then _speedMeterUpdateConn:Disconnect(); _speedMeterUpdateConn = nil end
    if _speedMeterCharConn   then _speedMeterCharConn:Disconnect();   _speedMeterCharConn   = nil end
    -- destroy BB
    if _speedMeterBB and _speedMeterBB.Parent then _speedMeterBB:Destroy() end
    _speedMeterBB    = nil
    _speedMeterLabel = nil
    if not state then return end

    -- build BB for current character
    _speedMeterSetupBB()

    -- rebuild on every respawn
    _speedMeterCharConn = S.LocalPlayer.CharacterAdded:Connect(function()
        task.wait(0.5)
        if CONFIG.SPEED_METER_ENABLED then _speedMeterSetupBB() end
    end)

    -- K7-style: update label every RenderStepped (no extra heartbeat connection)
    _speedMeterUpdateConn = S.RunService.RenderStepped:Connect(function()
        if not CONFIG.SPEED_METER_ENABLED then return end
        if not (_speedMeterLabel and _speedMeterLabel.Parent) then return end
        local c   = S.LocalPlayer.Character
        local hrp = c and c:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local speed = Vector3.new(
            hrp.AssemblyLinearVelocity.X, 0, hrp.AssemblyLinearVelocity.Z
        ).Magnitude
        _speedMeterLabel.Text = "Speed: " .. string.format("%.1f", speed)
        if speed < 20 then
            _speedMeterLabel.TextColor3 = COLORS.Accent
        elseif speed < 50 then
            _speedMeterLabel.TextColor3 = COLORS.Yellow
        else
            _speedMeterLabel.TextColor3 = COLORS.Red
        end
    end)
end

-- ======================================
-- DISCORD BILLBOARD  (always-on, white, above speed meter)
-- ======================================

function _discordBBSetup()
    if _discordBB and _discordBB.Parent then _discordBB:Destroy() end
    _discordBB = nil
    local char = S.LocalPlayer.Character
    if not char then return end
    local head = char:FindFirstChild("Head")
    if not head then return end

    local bb = Instance.new("BillboardGui", head)
    bb.Name         = "LooprixDiscordBB"
    bb.Size         = UDim2.new(0, 180, 0, 20)
    bb.StudsOffset  = Vector3.new(0, 3.8, 0)   -- above speed meter (2.6)
    bb.AlwaysOnTop  = true
    bb.ResetOnSpawn = false

    local lbl = Instance.new("TextLabel", bb)
    lbl.Size                   = UDim2.new(1, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text                   = "discord.gg/looprixhub"
    lbl.TextColor3             = Color3.fromRGB(255, 255, 255)
    lbl.TextStrokeTransparency = 0
    lbl.TextStrokeColor3       = Color3.fromRGB(0, 0, 0)
    lbl.Font                   = Enum.Font.GothamBlack
    lbl.TextSize               = 13

    _discordBB = bb
end

function _startDiscordBB()
    _discordBBSetup()
    if _discordCharConn then _discordCharConn:Disconnect() end
    _discordCharConn = S.LocalPlayer.CharacterAdded:Connect(function()
        task.wait(0.5)
        _discordBBSetup()
    end)
end

-- ======================================
-- SPEED GUI
-- ======================================

-- Maps preset name -> CONFIG keys that store its speed/steal
local function _main()
local _setAutoLoad = function() end  -- fwd decl
local PRESET_CFG_KEYS = {
    normal = { speed = "PRESET_NORMAL_SPEED", steal = "PRESET_NORMAL_STEAL" },
    desync = { speed = "PRESET_DESYNC_SPEED", steal = "PRESET_DESYNC_STEAL" },
    lagger = { speed = "PRESET_LAGGER_SPEED", steal = "PRESET_LAGGER_STEAL" },
}

local function createSpeedGui()
    local W      = 148
    local HDR_H  = 20
    local PRE_H  = 22
    local ROW_H  = 26
    local GAP    = 3
    local PAD    = 5
    local CONTENT_H = ROW_H + GAP + ROW_H + GAP + ROW_H
    local FULL_H = HDR_H + PAD + PRE_H + GAP + CONTENT_H + PAD

    local sg = Instance.new("ScreenGui", S.PlayerGui)
    sg.AutoLocalize = false; sg.Name = "Looprix_SpeedGui"
    sg.ResetOnSpawn = false; sg.DisplayOrder = 999998
    sg.Enabled = CONFIG.SPEED_GUI_VISIBLE

    local main = Instance.new("Frame", sg)
    main.Size = UDim2.new(0,W,0,FULL_H)
    main.BackgroundColor3 = COLORS.Background; main.BackgroundTransparency = 0.1
    main.BorderSizePixel = 0; main.ClipsDescendants = false
    Instance.new("UICorner", main).CornerRadius = UDim.new(0,8)
    registerScaleTarget(main)
    loadAndClampPosition(main, "speedGui", UDim2.new(0,10,0,55))
    _regDraggable(main, function() return UDim2.new(0,10,0,55) end)

    local mainStroke = Instance.new("UIStroke", main)
    mainStroke.Thickness = 1.2; mainStroke.Color = COLORS.Accent
    mainStroke.Transparency = 0.0; mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    trackStroke(mainStroke)
    local sg_ = Instance.new("UIGradient", mainStroke)
    sg_.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,    COLORS.Accent),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(120,255,200)),
        ColorSequenceKeypoint.new(0.66, Color3.fromRGB(150,255,180)),
        ColorSequenceKeypoint.new(1,    COLORS.Accent),
    })
    trackGradient(sg_)

    -- ── Header ────────────────────────────────────────────────────────────────
    local hdr = Instance.new("Frame", main)
    hdr.Size = UDim2.new(1,0,0,HDR_H); hdr.BackgroundColor3 = COLORS.Surface
    hdr.BackgroundTransparency = 0.05; hdr.BorderSizePixel = 0
    Instance.new("UICorner", hdr).CornerRadius = UDim.new(0,8)
    local hdrFill = Instance.new("Frame", hdr)
    hdrFill.Size = UDim2.new(1,0,0,9); hdrFill.Position = UDim2.new(0,0,1,-9)
    hdrFill.BackgroundColor3 = COLORS.Surface; hdrFill.BackgroundTransparency = 0.05; hdrFill.BorderSizePixel = 0

    local dot = Instance.new("Frame", hdr)
    dot.Size = UDim2.new(0,5,0,5); dot.Position = UDim2.new(0,8,0.5,-2)
    dot.BackgroundColor3 = COLORS.Accent; dot.BorderSizePixel = 0
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1,0); trackDot(dot)

    local titleLbl = Instance.new("TextLabel", hdr)
    titleLbl.AutoLocalize = false
    titleLbl.Size = UDim2.new(1,-42,1,0); titleLbl.Position = UDim2.new(0,18,0,0)
    titleLbl.BackgroundTransparency = 1; titleLbl.Text = "Speed Booster"
    titleLbl.TextColor3 = COLORS.Accent; titleLbl.Font = Enum.Font.GothamSemibold
    titleLbl.TextSize = 10; titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    trackLabel(titleLbl)
    local tgH = Instance.new("UIGradient", titleLbl); tgH.Color = sg_.Color; trackGradient(tgH)

    local minBtn = Instance.new("TextButton", hdr)
    minBtn.AutoLocalize = false
    minBtn.Size = UDim2.new(0,18,0,14); minBtn.Position = UDim2.new(1,-22,0.5,-7)
    minBtn.BackgroundColor3 = COLORS.Background; minBtn.BackgroundTransparency = 0.15
    minBtn.Text = "-"; minBtn.TextColor3 = COLORS.Accent
    minBtn.Font = Enum.Font.GothamBold; minBtn.TextSize = 13; minBtn.BorderSizePixel = 0
    Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0,4); trackLabel(minBtn)
    local ms2 = Instance.new("UIStroke", minBtn)
    ms2.Color = COLORS.Accent; ms2.Thickness = 1; ms2.Transparency = 0.4; trackStroke(ms2)

    -- ── Preset bar (always visible even when minimized) ───────────────────────
    local presetBar = Instance.new("Frame", main)
    presetBar.Size = UDim2.new(1,-PAD*2,0,PRE_H)
    presetBar.Position = UDim2.new(0,PAD,0,HDR_H+PAD)
    presetBar.BackgroundTransparency = 1; presetBar.BorderSizePixel = 0

    local preLL = Instance.new("UIListLayout", presetBar)
    preLL.FillDirection = Enum.FillDirection.Horizontal
    preLL.HorizontalAlignment = Enum.HorizontalAlignment.Center
    preLL.VerticalAlignment = Enum.VerticalAlignment.Center
    preLL.Padding = UDim.new(0,2)   -- tight gap

    local presetBtns = {}
    local curPreset = CONFIG.SPEED_PRESET or "normal"
    _speedValBox, _stealValBox = nil, nil

    -- Save current preset's box values back to its own CONFIG keys
    local function saveCurrentPresetValues()
        local keys = PRESET_CFG_KEYS[curPreset]; if not keys then return end
        CONFIG[keys.speed] = CONFIG.SPEED_VALUE
        CONFIG[keys.steal] = CONFIG.STEAL_SPEED_VALUE
    end

    local function applyPreset(name)
        local keys = PRESET_CFG_KEYS[name]; if not keys then return end
        -- 1. Save what we had before switching
        saveCurrentPresetValues()
        -- 2. Switch preset
        curPreset = name
        CONFIG.SPEED_PRESET = name
        -- 3. Load this preset's own saved values
        CONFIG.SPEED_VALUE       = CONFIG[keys.speed]
        CONFIG.STEAL_SPEED_VALUE = CONFIG[keys.steal]
        saveConfig()
        -- 4. Update boxes
        if _speedValBox then _speedValBox.Text = tostring(CONFIG.SPEED_VALUE) end
        if _stealValBox then _stealValBox.Text = tostring(CONFIG.STEAL_SPEED_VALUE) end
        -- 5. Update button visuals
        for pname, pb in pairs(presetBtns) do
            local active = (pname == name)
            S.TweenService:Create(pb, TweenInfo.new(0.13,Enum.EasingStyle.Quad), {
                BackgroundColor3       = active and COLORS.Accent or COLORS.Surface,
                BackgroundTransparency = active and 0.0 or 0.08,
            }):Play()
            pb.TextColor3 = active and Color3.fromRGB(10,10,10) or COLORS.Accent
        end
    end

    for _, def in ipairs({"normal","desync","lagger"}) do
        local active = (curPreset == def)
        local pb = Instance.new("TextButton", presetBar)
        pb.AutoLocalize = false
        pb.Size = UDim2.new(0,42,1,0)
        pb.BackgroundColor3       = active and COLORS.Accent or COLORS.Surface
        pb.BackgroundTransparency = active and 0.0 or 0.08
        pb.Text = def:upper(); pb.TextColor3 = active and Color3.fromRGB(10,10,10) or COLORS.Accent
        pb.Font = Enum.Font.GothamBold; pb.TextSize = 8; pb.BorderSizePixel = 0
        Instance.new("UICorner", pb).CornerRadius = UDim.new(0,5)
        local pbs = Instance.new("UIStroke", pb)
        pbs.Color = COLORS.Accent; pbs.Thickness = 1; pbs.Transparency = 0.35; trackStroke(pbs)
        presetBtns[def] = pb
        local capName = def
        pb.MouseButton1Click:Connect(function() applyPreset(capName) end)
    end

    -- ── Content rows (hidden when minimized) ──────────────────────────────────
    local content = Instance.new("Frame", main)
    content.Size = UDim2.new(1,0,0,CONTENT_H)
    content.Position = UDim2.new(0,0,0,HDR_H+PAD+PRE_H+GAP)
    content.BackgroundTransparency = 1; content.BorderSizePixel = 0

    local ll2 = Instance.new("UIListLayout", content)
    ll2.FillDirection = Enum.FillDirection.Vertical
    ll2.HorizontalAlignment = Enum.HorizontalAlignment.Center
    ll2.VerticalAlignment = Enum.VerticalAlignment.Top
    ll2.Padding = UDim.new(0,GAP); ll2.SortOrder = Enum.SortOrder.LayoutOrder
    local uip2 = Instance.new("UIPadding", content)
    uip2.PaddingLeft = UDim.new(0,PAD); uip2.PaddingRight = UDim.new(0,PAD)

    local IW = W - PAD*2
    local BOX_W = 44
    local BOX_POS = IW - BOX_W - 2

    local function makeRow(lo, labelText)
        local f = Instance.new("Frame", content)
        f.LayoutOrder = lo; f.Size = UDim2.new(1,0,0,ROW_H)
        f.BackgroundColor3 = COLORS.Surface; f.BackgroundTransparency = 0.08; f.BorderSizePixel = 0
        Instance.new("UICorner", f).CornerRadius = UDim.new(0,5)
        local rs = Instance.new("UIStroke", f)
        rs.Color = COLORS.Accent; rs.Thickness = 1; rs.Transparency = 0.65
        rs.ApplyStrokeMode = Enum.ApplyStrokeMode.Border; trackStroke(rs)
        local lbl = Instance.new("TextLabel", f)
        lbl.AutoLocalize = false; lbl.Size = UDim2.new(0.55,0,0,14)
        lbl.Position = UDim2.new(0,6,0,6); lbl.BackgroundTransparency = 1
        lbl.Text = labelText; lbl.TextColor3 = COLORS.Accent; trackLabel(lbl)
        lbl.Font = Enum.Font.GothamSemibold; lbl.TextSize = 9
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        return f
    end

    local function makeBox(parent, xOff, defText)
        local box = Instance.new("TextBox", parent)
        box.AutoLocalize = false; box.Size = UDim2.new(0,BOX_W,0,16)
        box.Position = UDim2.new(0,xOff,0,5); box.BackgroundColor3 = COLORS.Background
        box.BackgroundTransparency = 0.0; box.Text = defText
        box.TextColor3 = COLORS.Accent; trackLabel(box)
        box.Font = Enum.Font.GothamBold; box.TextSize = 9
        box.ClearTextOnFocus = false; box.BorderSizePixel = 0
        Instance.new("UICorner", box).CornerRadius = UDim.new(0,4)
        local s = Instance.new("UIStroke", box)
        s.Color = COLORS.Accent; s.Thickness = 1; s.Transparency = 0.55; trackStroke(s)
        return box
    end

    -- Status row
    local r0 = makeRow(0, "Status:")
    local statusBtn = Instance.new("TextButton", r0)
    statusBtn.AutoLocalize = false; statusBtn.Size = UDim2.new(0,BOX_W,0,16)
    statusBtn.Position = UDim2.new(0,BOX_POS,0,5)
    statusBtn.BackgroundColor3 = CONFIG.SPEED_ENABLED and COLORS.Accent or COLORS.Background
    statusBtn.Text = CONFIG.SPEED_ENABLED and "ON" or "OFF"
    statusBtn.TextColor3 = CONFIG.SPEED_ENABLED and Color3.fromRGB(10,10,10) or COLORS.Accent
    statusBtn.Font = Enum.Font.GothamBold; statusBtn.TextSize = 9; statusBtn.BorderSizePixel = 0
    Instance.new("UICorner", statusBtn).CornerRadius = UDim.new(0,4); trackLabel(statusBtn)
    local statusStroke = Instance.new("UIStroke", statusBtn)
    statusStroke.Color = COLORS.Accent; statusStroke.Thickness = 1; statusStroke.Transparency = 0.55
    trackStroke(statusStroke)
    S.RunService.RenderStepped:Connect(function()
        if CONFIG.SPEED_ENABLED then statusBtn.BackgroundColor3 = COLORS.Accent; statusBtn.TextColor3 = Color3.fromRGB(10,10,10)
        else statusBtn.TextColor3 = COLORS.Accent; statusBtn.BackgroundColor3 = COLORS.Background end
    end)
    statusBtn.MouseButton1Click:Connect(function()
        CONFIG.SPEED_ENABLED = not CONFIG.SPEED_ENABLED
        statusBtn.BackgroundColor3 = CONFIG.SPEED_ENABLED and COLORS.Accent or COLORS.Background
        statusBtn.TextColor3 = CONFIG.SPEED_ENABLED and Color3.fromRGB(10,10,10) or COLORS.Accent
        statusBtn.Text = CONFIG.SPEED_ENABLED and "ON" or "OFF"; saveConfig()
    end)

    -- Speed row
    local r1 = makeRow(1, "Speed")
    local b1 = makeBox(r1, BOX_POS, tostring(CONFIG.SPEED_VALUE))
    _speedValBox = b1
    b1.FocusLost:Connect(function()
        local v = tonumber(b1.Text) or CONFIG.SPEED_VALUE
        CONFIG.SPEED_VALUE = math.clamp(v,0,999)
        b1.Text = tostring(CONFIG.SPEED_VALUE)
        -- save back to current preset's own key too
        local keys = PRESET_CFG_KEYS[curPreset]
        if keys then CONFIG[keys.speed] = CONFIG.SPEED_VALUE end
        saveConfig()
    end)

    -- Steal Spd row
    local r2 = makeRow(2, "Steal Spd")
    local b2 = makeBox(r2, BOX_POS, tostring(CONFIG.STEAL_SPEED_VALUE))
    _stealValBox = b2
    b2.FocusLost:Connect(function()
        local v = tonumber(b2.Text) or CONFIG.STEAL_SPEED_VALUE
        CONFIG.STEAL_SPEED_VALUE = math.clamp(v,0,999)
        b2.Text = tostring(CONFIG.STEAL_SPEED_VALUE)
        -- save back to current preset's own key too
        local keys = PRESET_CFG_KEYS[curPreset]
        if keys then CONFIG[keys.steal] = CONFIG.STEAL_SPEED_VALUE end
        saveConfig()
    end)

    -- Restore saved preset values on load (don't use hardcoded defaults)
    do
        local keys = PRESET_CFG_KEYS[curPreset]
        if keys then
            CONFIG.SPEED_VALUE       = CONFIG[keys.speed]
            CONFIG.STEAL_SPEED_VALUE = CONFIG[keys.steal]
            b1.Text = tostring(CONFIG.SPEED_VALUE)
            b2.Text = tostring(CONFIG.STEAL_SPEED_VALUE)
        end
    end

    -- ── Minimize (keeps preset bar visible) ───────────────────────────────────
    local speedMinimized = false
    local MINI_H = HDR_H + PAD + PRE_H + PAD
    minBtn.MouseButton1Click:Connect(function()
        speedMinimized = not speedMinimized
        if speedMinimized then
            hdrFill.Visible = false; content.Visible = false
            S.TweenService:Create(main, tweenInfoMedium, {Size=UDim2.new(0,W,0,MINI_H)}):Play()
            minBtn.Text = "+"
        else
            hdrFill.Visible = true; content.Visible = true
            S.TweenService:Create(main, tweenInfoMedium, {Size=UDim2.new(0,W,0,FULL_H)}):Play()
            minBtn.Text = "-"
        end
    end)

    makeDraggable(main, hdr, "speedGui", function() return CONFIG.UI_LOCKED end)
    startSpeed()
    return sg
end

-- ======================================
-- SPEED LAGGER GUI
-- ======================================

local function createSpeedLaggerGui()
    local W        = 148
    local HDR_H    = 20
    local TOGGLE_H = 28
    local ROW_H    = 26
    local GAP      = 3
    local PAD      = 5
    local CONTENT_H = ROW_H + GAP + ROW_H
    local FULL_H  = HDR_H + PAD + TOGGLE_H + PAD + CONTENT_H + PAD
    local MINI_H  = HDR_H + PAD + TOGGLE_H + PAD

    local sg = Instance.new("ScreenGui", S.PlayerGui)
    sg.AutoLocalize = false; sg.Name = "Looprix_SpeedLaggerGui"
    sg.ResetOnSpawn = false; sg.DisplayOrder = 999997
    sg.Enabled = CONFIG.SPEED_LAGGER_GUI_VISIBLE

    local main = Instance.new("Frame", sg)
    main.Size = UDim2.new(0, W, 0, FULL_H)
    main.BackgroundColor3 = COLORS.Background; main.BackgroundTransparency = 0.1
    main.BorderSizePixel = 0; main.ClipsDescendants = false
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 8)
    registerScaleTarget(main)
    loadAndClampPosition(main, "speedLaggerGui", UDim2.new(0, 10, 0, 270))
    _regDraggable(main, function() return UDim2.new(0, 10, 0, 270) end)

    local mainStroke = Instance.new("UIStroke", main)
    mainStroke.Thickness = 1.2; mainStroke.Color = COLORS.Accent
    mainStroke.Transparency = 0.0; mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    trackStroke(mainStroke)
    local slGrad = Instance.new("UIGradient", mainStroke)
    slGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,    COLORS.Accent),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(120, 255, 200)),
        ColorSequenceKeypoint.new(0.66, Color3.fromRGB(150, 255, 180)),
        ColorSequenceKeypoint.new(1,    COLORS.Accent),
    })
    trackGradient(slGrad)

    -- ── Header ────────────────────────────────────────────────────────────────
    local hdr = Instance.new("Frame", main)
    hdr.Size = UDim2.new(1, 0, 0, HDR_H)
    hdr.BackgroundColor3 = COLORS.Surface; hdr.BackgroundTransparency = 0.05; hdr.BorderSizePixel = 0
    Instance.new("UICorner", hdr).CornerRadius = UDim.new(0, 8)
    local hdrFill = Instance.new("Frame", hdr)
    hdrFill.Size = UDim2.new(1, 0, 0, 9); hdrFill.Position = UDim2.new(0, 0, 1, -9)
    hdrFill.BackgroundColor3 = COLORS.Surface; hdrFill.BackgroundTransparency = 0.05; hdrFill.BorderSizePixel = 0

    local dot = Instance.new("Frame", hdr)
    dot.Size = UDim2.new(0, 5, 0, 5); dot.Position = UDim2.new(0, 8, 0.5, -2)
    dot.BackgroundColor3 = COLORS.Accent; dot.BorderSizePixel = 0
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0); trackDot(dot)

    local titleLbl = Instance.new("TextLabel", hdr)
    titleLbl.AutoLocalize = false
    titleLbl.Size = UDim2.new(1, -30, 1, 0); titleLbl.Position = UDim2.new(0, 18, 0, 0)
    titleLbl.BackgroundTransparency = 1; titleLbl.Text = "Speed Lagger"
    titleLbl.TextColor3 = COLORS.Accent; titleLbl.Font = Enum.Font.GothamSemibold
    titleLbl.TextSize = 10; titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    trackLabel(titleLbl)
    local tgH = Instance.new("UIGradient", titleLbl); tgH.Color = slGrad.Color; trackGradient(tgH)

    local minBtn = Instance.new("TextButton", hdr)
    minBtn.AutoLocalize = false
    minBtn.Size = UDim2.new(0, 18, 0, 14); minBtn.Position = UDim2.new(1, -22, 0.5, -7)
    minBtn.BackgroundColor3 = COLORS.Background; minBtn.BackgroundTransparency = 0.15
    minBtn.Text = "-"; minBtn.TextColor3 = COLORS.Accent
    minBtn.Font = Enum.Font.GothamBold; minBtn.TextSize = 13; minBtn.BorderSizePixel = 0
    Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 4); trackLabel(minBtn)
    local ms2 = Instance.new("UIStroke", minBtn)
    ms2.Color = COLORS.Accent; ms2.Thickness = 1; ms2.Transparency = 0.4; trackStroke(ms2)

    -- ── Toggle ON/OFF (always visible) ───────────────────────────────────────
    local toggleRow = Instance.new("Frame", main)
    toggleRow.Size = UDim2.new(1, -PAD * 2, 0, TOGGLE_H)
    toggleRow.Position = UDim2.new(0, PAD, 0, HDR_H + PAD)
    toggleRow.BackgroundTransparency = 1; toggleRow.BorderSizePixel = 0

    local toggleBtn = Instance.new("TextButton", toggleRow)
    toggleBtn.AutoLocalize = false
    toggleBtn.Size = UDim2.new(1, 0, 1, 0)
    toggleBtn.BackgroundColor3 = _slEnabled and COLORS.Accent or COLORS.Surface
    toggleBtn.BackgroundTransparency = _slEnabled and 0.0 or 0.08
    toggleBtn.Text = _slEnabled and "SL ON" or "SL OFF"
    toggleBtn.TextColor3 = _slEnabled and Color3.fromRGB(10, 10, 10) or COLORS.Accent
    toggleBtn.Font = Enum.Font.GothamBold; toggleBtn.TextSize = 12; toggleBtn.BorderSizePixel = 0
    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 6); trackLabel(toggleBtn)
    local tgStroke = Instance.new("UIStroke", toggleBtn)
    tgStroke.Color = COLORS.Accent; tgStroke.Thickness = 1; tgStroke.Transparency = 0.35; trackStroke(tgStroke)

    -- ── Content rows ─────────────────────────────────────────────────────────
    local content = Instance.new("Frame", main)
    content.Size = UDim2.new(1, 0, 0, CONTENT_H)
    content.Position = UDim2.new(0, 0, 0, HDR_H + PAD + TOGGLE_H + PAD)
    content.BackgroundTransparency = 1; content.BorderSizePixel = 0

    local ll = Instance.new("UIListLayout", content)
    ll.FillDirection = Enum.FillDirection.Vertical
    ll.HorizontalAlignment = Enum.HorizontalAlignment.Center
    ll.VerticalAlignment = Enum.VerticalAlignment.Top
    ll.Padding = UDim.new(0, GAP); ll.SortOrder = Enum.SortOrder.LayoutOrder
    local uip = Instance.new("UIPadding", content)
    uip.PaddingLeft = UDim.new(0, PAD); uip.PaddingRight = UDim.new(0, PAD)

    local IW = W - PAD * 2
    local BOX_W = 50
    local BOX_POS = IW - BOX_W - 2

    local function makeSLRow(lo, labelText)
        local f = Instance.new("Frame", content)
        f.LayoutOrder = lo; f.Size = UDim2.new(1, 0, 0, ROW_H)
        f.BackgroundColor3 = COLORS.Surface; f.BackgroundTransparency = 0.08; f.BorderSizePixel = 0
        Instance.new("UICorner", f).CornerRadius = UDim.new(0, 5)
        local rs = Instance.new("UIStroke", f)
        rs.Color = COLORS.Accent; rs.Thickness = 1; rs.Transparency = 0.65
        rs.ApplyStrokeMode = Enum.ApplyStrokeMode.Border; trackStroke(rs)
        local lbl = Instance.new("TextLabel", f)
        lbl.AutoLocalize = false; lbl.Size = UDim2.new(0.55, 0, 0, 14)
        lbl.Position = UDim2.new(0, 6, 0, 6); lbl.BackgroundTransparency = 1
        lbl.Text = labelText; lbl.TextColor3 = COLORS.Accent; trackLabel(lbl)
        lbl.Font = Enum.Font.GothamSemibold; lbl.TextSize = 9
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        return f
    end

    local function makeSLBox(parent, xOff, defText)
        local box = Instance.new("TextBox", parent)
        box.AutoLocalize = false; box.Size = UDim2.new(0, BOX_W, 0, 16)
        box.Position = UDim2.new(0, xOff, 0, 5); box.BackgroundColor3 = COLORS.Background
        box.BackgroundTransparency = 0.0; box.Text = defText
        box.TextColor3 = COLORS.Accent; trackLabel(box)
        box.Font = Enum.Font.GothamBold; box.TextSize = 9
        box.ClearTextOnFocus = false; box.BorderSizePixel = 0
        Instance.new("UICorner", box).CornerRadius = UDim.new(0, 4)
        local s = Instance.new("UIStroke", box)
        s.Color = COLORS.Accent; s.Thickness = 1; s.Transparency = 0.55; trackStroke(s)
        return box
    end

    -- Row 1: Lagger [0-100]
    local r1 = makeSLRow(1, "Lagger [0-100]")
    local b1 = makeSLBox(r1, BOX_POS, tostring(CONFIG.SPEED_LAGGER_LAG))
    _slLagBox = b1
    b1.FocusLost:Connect(function()
        local v = tonumber(b1.Text) or CONFIG.SPEED_LAGGER_LAG
        CONFIG.SPEED_LAGGER_LAG = math.clamp(math.floor(v), 0, 100)
        b1.Text = tostring(CONFIG.SPEED_LAGGER_LAG); saveConfig()
    end)

    -- Row 2: Speed [0-100]
    local r2 = makeSLRow(2, "Speed [0-100]")
    local b2 = makeSLBox(r2, BOX_POS, tostring(CONFIG.SPEED_LAGGER_SPEED))
    _slSpeedBox = b2
    b2.FocusLost:Connect(function()
        local v = tonumber(b2.Text) or CONFIG.SPEED_LAGGER_SPEED
        CONFIG.SPEED_LAGGER_SPEED = math.clamp(math.floor(v), 0, 100)
        b2.Text = tostring(CONFIG.SPEED_LAGGER_SPEED); saveConfig()
    end)

    -- ── Logic ─────────────────────────────────────────────────────────────────
    local function _slLagAmount()
        -- 0-100 mapped to 0-0.2 seconds (same scale as IceHub)
        return CONFIG.SPEED_LAGGER_LAG / 100 * 0.2
    end

    local function _slSpeedAmount()
        -- 0-100 mapped to 16-70 walkspeed (same scale as IceHub)
        return 16 + (CONFIG.SPEED_LAGGER_SPEED / 100) * (70 - 16)
    end

    local function _syncToggleVisual()
        S.TweenService:Create(toggleBtn, tweenInfoFast, {
            BackgroundColor3       = _slEnabled and COLORS.Accent or COLORS.Surface,
            BackgroundTransparency = _slEnabled and 0.0 or 0.08,
        }):Play()
        toggleBtn.TextColor3 = _slEnabled and Color3.fromRGB(10, 10, 10) or COLORS.Accent
        toggleBtn.Text = _slEnabled and "SL ON" or "SL OFF"
    end

    local function _stopSL()
        if _slRenderConn then _slRenderConn:Disconnect(); _slRenderConn = nil end
        if _slThread then pcall(function() task.cancel(_slThread) end); _slThread = nil end
        -- restore Speed Booster if it was on before
        if _slWasSpeedOn then
            CONFIG.SPEED_ENABLED = true
            _slWasSpeedOn = false
        end
    end

    local function _startSL()
        -- remember and disable Speed Booster
        _slWasSpeedOn = CONFIG.SPEED_ENABLED
        CONFIG.SPEED_ENABLED = false

        -- Speed override each frame
        _slRenderConn = S.RunService.RenderStepped:Connect(function()
            if not _slEnabled then return end
            local char = S.LocalPlayer.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hrp or not hum then return end
            if hum.MoveDirection.Magnitude > 0 then
                local spd = _slSpeedAmount()
                local dir = hum.MoveDirection.Unit
                hrp.AssemblyLinearVelocity = Vector3.new(
                    dir.X * spd,
                    hrp.AssemblyLinearVelocity.Y,
                    dir.Z * spd
                )
            end
        end)

        -- Lag loop thread
        _slThread = task.spawn(function()
            while _slEnabled do
                local lagAmt = _slLagAmount()
                if lagAmt > 0 then
                    local t = tick()
                    while tick() - t < lagAmt do end
                end
                task.wait()
            end
        end)
    end

    toggleBtn.MouseButton1Click:Connect(function()
        _slEnabled = not _slEnabled
        CONFIG.SPEED_LAGGER_ENABLED = _slEnabled
        _syncToggleVisual()
        saveConfig()
        if _slEnabled then _startSL() else _stopSL() end
    end)

    -- ── Minimize ──────────────────────────────────────────────────────────────
    local slMinimized = false
    minBtn.MouseButton1Click:Connect(function()
        slMinimized = not slMinimized
        if slMinimized then
            hdrFill.Visible = false; content.Visible = false
            S.TweenService:Create(main, tweenInfoMedium, {Size = UDim2.new(0, W, 0, MINI_H)}):Play()
            minBtn.Text = "+"
        else
            hdrFill.Visible = true; content.Visible = true
            S.TweenService:Create(main, tweenInfoMedium, {Size = UDim2.new(0, W, 0, FULL_H)}):Play()
            minBtn.Text = "-"
        end
    end)

    makeDraggable(main, hdr, "speedLaggerGui", function() return CONFIG.UI_LOCKED end)

    pcall(function()
        applyAccentColor(CONFIG.GUI_COLOR_R or 0, CONFIG.GUI_COLOR_G or 217, CONFIG.GUI_COLOR_B or 127)
    end)

    speedLaggerGuiInstance = sg
    return sg
end

-- ======================================
-- LAGGER GUI  (same style as Speed GUI)
-- ======================================

local function createLaggerGui()
    local W        = 148
    local HDR_H    = 20
    local TOGGLE_H = 28    -- always-visible ON/OFF row (like PLAY button in photo)
    local ROW_H    = 26
    local GAP      = 3
    local PAD      = 5
    local CONTENT_H = ROW_H + GAP + ROW_H + GAP + ROW_H
    local FULL_H  = HDR_H + PAD + TOGGLE_H + PAD + CONTENT_H + PAD
    local MINI_H  = HDR_H + PAD + TOGGLE_H + PAD   -- header + toggle visible when minimized

    local sg = Instance.new("ScreenGui", S.PlayerGui)
    sg.AutoLocalize = false; sg.Name = "Looprix_LaggerGui"
    sg.ResetOnSpawn = false; sg.DisplayOrder = 999998
    sg.Enabled = CONFIG.LAGGER_GUI_VISIBLE

    local main = Instance.new("Frame", sg)
    main.Size = UDim2.new(0, W, 0, FULL_H)
    main.BackgroundColor3 = COLORS.Background; main.BackgroundTransparency = 0.1
    main.BorderSizePixel = 0; main.ClipsDescendants = false
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 8)
    registerScaleTarget(main)
    loadAndClampPosition(main, "laggerGui", UDim2.new(0, 10, 0, 160))
    _regDraggable(main, function() return UDim2.new(0, 10, 0, 160) end)

    local mainStroke = Instance.new("UIStroke", main)
    mainStroke.Thickness = 1.2; mainStroke.Color = COLORS.Accent
    mainStroke.Transparency = 0.0; mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    trackStroke(mainStroke)
    local lgGrad = Instance.new("UIGradient", mainStroke)
    lgGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,    COLORS.Accent),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(120, 255, 200)),
        ColorSequenceKeypoint.new(0.66, Color3.fromRGB(150, 255, 180)),
        ColorSequenceKeypoint.new(1,    COLORS.Accent),
    })
    trackGradient(lgGrad)

    -- ── Header (always visible) ───────────────────────────────────────────────
    local hdr = Instance.new("Frame", main)
    hdr.Size = UDim2.new(1, 0, 0, HDR_H)
    hdr.BackgroundColor3 = COLORS.Surface; hdr.BackgroundTransparency = 0.05; hdr.BorderSizePixel = 0
    Instance.new("UICorner", hdr).CornerRadius = UDim.new(0, 8)
    local hdrFill = Instance.new("Frame", hdr)
    hdrFill.Size = UDim2.new(1, 0, 0, 9); hdrFill.Position = UDim2.new(0, 0, 1, -9)
    hdrFill.BackgroundColor3 = COLORS.Surface; hdrFill.BackgroundTransparency = 0.05; hdrFill.BorderSizePixel = 0

    local dot = Instance.new("Frame", hdr)
    dot.Size = UDim2.new(0, 5, 0, 5); dot.Position = UDim2.new(0, 8, 0.5, -2)
    dot.BackgroundColor3 = COLORS.Accent; dot.BorderSizePixel = 0
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0); trackDot(dot)

    local titleLbl = Instance.new("TextLabel", hdr)
    titleLbl.AutoLocalize = false
    titleLbl.Size = UDim2.new(1, -30, 1, 0); titleLbl.Position = UDim2.new(0, 18, 0, 0)
    titleLbl.BackgroundTransparency = 1; titleLbl.Text = "Server Lagger"
    titleLbl.TextColor3 = COLORS.Accent; titleLbl.Font = Enum.Font.GothamSemibold
    titleLbl.TextSize = 10; titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    trackLabel(titleLbl)
    local tgH = Instance.new("UIGradient", titleLbl); tgH.Color = lgGrad.Color; trackGradient(tgH)

    local minBtn = Instance.new("TextButton", hdr)
    minBtn.AutoLocalize = false
    minBtn.Size = UDim2.new(0, 18, 0, 14); minBtn.Position = UDim2.new(1, -22, 0.5, -7)
    minBtn.BackgroundColor3 = COLORS.Background; minBtn.BackgroundTransparency = 0.15
    minBtn.Text = "-"; minBtn.TextColor3 = COLORS.Accent
    minBtn.Font = Enum.Font.GothamBold; minBtn.TextSize = 13; minBtn.BorderSizePixel = 0
    Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 4); trackLabel(minBtn)
    local ms2 = Instance.new("UIStroke", minBtn)
    ms2.Color = COLORS.Accent; ms2.Thickness = 1; ms2.Transparency = 0.4; trackStroke(ms2)

    -- ── Toggle ON/OFF row (ALWAYS visible, even when minimized) ──────────────
    -- Positioned directly below header — like the PLAY button in AutoPlay panel
    local toggleRow = Instance.new("Frame", main)
    toggleRow.Size = UDim2.new(1, -PAD * 2, 0, TOGGLE_H)
    toggleRow.Position = UDim2.new(0, PAD, 0, HDR_H + PAD)
    toggleRow.BackgroundTransparency = 1; toggleRow.BorderSizePixel = 0

    local toggleBtn = Instance.new("TextButton", toggleRow)
    toggleBtn.AutoLocalize = false
    toggleBtn.Size = UDim2.new(1, 0, 1, 0)
    toggleBtn.BackgroundColor3 = _laggerEnabled and COLORS.Accent or COLORS.Surface
    toggleBtn.BackgroundTransparency = _laggerEnabled and 0.0 or 0.08
    toggleBtn.Text = _laggerEnabled and "LAGGER ON" or "LAGGER OFF"
    toggleBtn.TextColor3 = _laggerEnabled and Color3.fromRGB(10, 10, 10) or COLORS.Accent
    toggleBtn.Font = Enum.Font.GothamBold; toggleBtn.TextSize = 12; toggleBtn.BorderSizePixel = 0
    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 6); trackLabel(toggleBtn)
    local tgStroke = Instance.new("UIStroke", toggleBtn)
    tgStroke.Color = COLORS.Accent; tgStroke.Thickness = 1; tgStroke.Transparency = 0.35; trackStroke(tgStroke)

    -- ── Settings content (hidden when minimized) ──────────────────────────────
    local content = Instance.new("Frame", main)
    content.Size = UDim2.new(1, 0, 0, CONTENT_H)
    content.Position = UDim2.new(0, 0, 0, HDR_H + PAD + TOGGLE_H + PAD)
    content.BackgroundTransparency = 1; content.BorderSizePixel = 0

    local ll = Instance.new("UIListLayout", content)
    ll.FillDirection = Enum.FillDirection.Vertical
    ll.HorizontalAlignment = Enum.HorizontalAlignment.Center
    ll.VerticalAlignment = Enum.VerticalAlignment.Top
    ll.Padding = UDim.new(0, GAP); ll.SortOrder = Enum.SortOrder.LayoutOrder
    local uip = Instance.new("UIPadding", content)
    uip.PaddingLeft = UDim.new(0, PAD); uip.PaddingRight = UDim.new(0, PAD)

    local IW = W - PAD * 2
    local BOX_W = 50
    local BOX_POS = IW - BOX_W - 2

    local function makeLRow(lo, labelText)
        local f = Instance.new("Frame", content)
        f.LayoutOrder = lo; f.Size = UDim2.new(1, 0, 0, ROW_H)
        f.BackgroundColor3 = COLORS.Surface; f.BackgroundTransparency = 0.08; f.BorderSizePixel = 0
        Instance.new("UICorner", f).CornerRadius = UDim.new(0, 5)
        local rs = Instance.new("UIStroke", f)
        rs.Color = COLORS.Accent; rs.Thickness = 1; rs.Transparency = 0.65
        rs.ApplyStrokeMode = Enum.ApplyStrokeMode.Border; trackStroke(rs)
        local lbl = Instance.new("TextLabel", f)
        lbl.AutoLocalize = false; lbl.Size = UDim2.new(0.55, 0, 0, 14)
        lbl.Position = UDim2.new(0, 6, 0, 6); lbl.BackgroundTransparency = 1
        lbl.Text = labelText; lbl.TextColor3 = COLORS.Accent; trackLabel(lbl)
        lbl.Font = Enum.Font.GothamSemibold; lbl.TextSize = 9
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        return f
    end

    local function makeLBox(parent, xOff, defText)
        local box = Instance.new("TextBox", parent)
        box.AutoLocalize = false; box.Size = UDim2.new(0, BOX_W, 0, 16)
        box.Position = UDim2.new(0, xOff, 0, 5); box.BackgroundColor3 = COLORS.Background
        box.BackgroundTransparency = 0.0; box.Text = defText
        box.TextColor3 = COLORS.Accent; trackLabel(box)
        box.Font = Enum.Font.GothamBold; box.TextSize = 9
        box.ClearTextOnFocus = false; box.BorderSizePixel = 0
        Instance.new("UICorner", box).CornerRadius = UDim.new(0, 4)
        local s = Instance.new("UIStroke", box)
        s.Color = COLORS.Accent; s.Thickness = 1; s.Transparency = 0.55; trackStroke(s)
        return box
    end

    -- Row: Spam (10–270)
    local r1 = makeLRow(1, "Spam")
    local b1 = makeLBox(r1, BOX_POS, tostring(CONFIG.LAGGER_SPAM))
    _lagSpamBox = b1
    b1.FocusLost:Connect(function()
        local v = tonumber(b1.Text) or CONFIG.LAGGER_SPAM
        CONFIG.LAGGER_SPAM = math.clamp(math.floor(v), 10, 270)
        b1.Text = tostring(CONFIG.LAGGER_SPAM); saveConfig()
    end)

    -- Row: Tries (0–10)
    local r2 = makeLRow(2, "Tries")
    local b2 = makeLBox(r2, BOX_POS, tostring(CONFIG.LAGGER_TRIES))
    _lagTriesBox = b2
    b2.FocusLost:Connect(function()
        local v = tonumber(b2.Text) or CONFIG.LAGGER_TRIES
        CONFIG.LAGGER_TRIES = math.clamp(math.floor(v), 0, 10)
        b2.Text = tostring(CONFIG.LAGGER_TRIES); saveConfig()
    end)

    -- Row: Delay (0.1–10)
    local r3 = makeLRow(3, "Delay")
    local b3 = makeLBox(r3, BOX_POS, string.format("%.1f", CONFIG.LAGGER_DELAY))
    _lagDelayBox = b3
    b3.FocusLost:Connect(function()
        local v = tonumber(b3.Text) or CONFIG.LAGGER_DELAY
        CONFIG.LAGGER_DELAY = math.clamp(v, 0.1, 10)
        b3.Text = string.format("%.1f", CONFIG.LAGGER_DELAY); saveConfig()
    end)

    -- ── Lagger logic ─────────────────────────────────────────────────────────
    local function _laggerGetMaxVal(val)
        if type(val) ~= "number" then return nil end
        return 499999 / (val + 2)
    end

    local function _laggerBomb()
        local maintable = {}
        local spammedtable = {}
        table.insert(spammedtable, {})
        local z = spammedtable[1]
        for i = 1, CONFIG.LAGGER_SPAM do
            local ti = {}; table.insert(z, ti); z = ti
        end
        local maximum = _laggerGetMaxVal(CONFIG.LAGGER_SPAM) or 9999999
        for i = 1, maximum do table.insert(maintable, spammedtable) end
        for i = 1, CONFIG.LAGGER_TRIES do
            pcall(function()
                game.RobloxReplicatedStorage.SetPlayerBlockList:FireServer(maintable)
            end)
        end
    end

    local function _syncToggleVisual()
        S.TweenService:Create(toggleBtn, tweenInfoFast, {
            BackgroundColor3       = _laggerEnabled and COLORS.Accent or COLORS.Surface,
            BackgroundTransparency = _laggerEnabled and 0.0 or 0.08,
        }):Play()
        toggleBtn.TextColor3 = _laggerEnabled and Color3.fromRGB(10, 10, 10) or COLORS.Accent
        toggleBtn.Text = _laggerEnabled and "LAGGER ON" or "LAGGER OFF"
    end

    local function _startLagger()
        if _laggerLoopThread then
            pcall(function() task.cancel(_laggerLoopThread) end)
            _laggerLoopThread = nil
        end
        _laggerLoopThread = task.spawn(function()
            while _laggerEnabled do
                pcall(function()
                    game:GetService("NetworkClient"):SetOutgoingKBPSLimit(math.huge)
                end)
                _laggerBomb()
                task.wait(math.max(0.1, CONFIG.LAGGER_DELAY))
            end
        end)
    end

    toggleBtn.MouseButton1Click:Connect(function()
        _laggerEnabled = not _laggerEnabled
        _syncToggleVisual()
        if _laggerEnabled then
            _startLagger()
        else
            if _laggerLoopThread then
                pcall(function() task.cancel(_laggerLoopThread) end)
                _laggerLoopThread = nil
            end
        end
    end)

    -- ── Minimize: hides settings, keeps header + toggle row ──────────────────
    local laggerMinimized = false
    minBtn.MouseButton1Click:Connect(function()
        laggerMinimized = not laggerMinimized
        if laggerMinimized then
            hdrFill.Visible = false
            content.Visible = false
            S.TweenService:Create(main, tweenInfoMedium, {Size = UDim2.new(0, W, 0, MINI_H)}):Play()
            minBtn.Text = "+"
        else
            hdrFill.Visible = true
            content.Visible = true
            S.TweenService:Create(main, tweenInfoMedium, {Size = UDim2.new(0, W, 0, FULL_H)}):Play()
            minBtn.Text = "-"
        end
    end)

    makeDraggable(main, hdr, "laggerGui", function() return CONFIG.UI_LOCKED end)

    pcall(function()
        applyAccentColor(CONFIG.GUI_COLOR_R or 0, CONFIG.GUI_COLOR_G or 217, CONFIG.GUI_COLOR_B or 127)
    end)

    laggerGuiInstance = sg
    return sg
end

-- ======================================
-- AUTO PLAY GUI
-- ======================================

local function createAutoPlayGui()
    local W      = 140
    local HDR_H  = 22
    local BTN_H  = 26
    local GAP    = 5
    local PAD    = 5
    local FULL_H = HDR_H + PAD + BTN_H + PAD

    local sg = Instance.new("ScreenGui", S.PlayerGui)
    sg.AutoLocalize = false
    sg.Name = "Looprix_AutoPlayGui"
    sg.ResetOnSpawn = false
    sg.DisplayOrder = 999998
    sg.Enabled = CONFIG.AUTO_PLAY_GUI_VISIBLE

    local function makeAccentStroke(parent, thick, initT)
        local s = Instance.new("UIStroke", parent)
        s.Thickness = thick or 1.2
        s.Color = COLORS.Accent
        s.Transparency = initT or 0
        s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        trackStroke(s)
        local g = Instance.new("UIGradient", s)
        g.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0,    COLORS.Accent),
            ColorSequenceKeypoint.new(0.33, Color3.fromRGB(120,255,200)),
            ColorSequenceKeypoint.new(0.66, Color3.fromRGB(150,255,180)),
            ColorSequenceKeypoint.new(1,    COLORS.Accent),
        })
        trackGradient(g)
        return s, g
    end

    -- MAIN WINDOW
    local main = Instance.new("Frame", sg)
    main.Size = UDim2.new(0, W, 0, FULL_H)
    main.BackgroundColor3 = COLORS.Background
    main.BackgroundTransparency = 0.08
    main.BorderSizePixel = 0
    main.ClipsDescendants = true
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)
    registerScaleTarget(main)

    loadAndClampPosition(main, "autoPlayMain", UDim2.new(0, 10, 0, 160))
    _regDraggable(main, function() return UDim2.new(0,10,0,160) end)
    makeAccentStroke(main, 1.2, 0)

    local hdr = Instance.new("Frame", main)
    hdr.Size = UDim2.new(1, 0, 0, HDR_H)
    hdr.BackgroundColor3 = COLORS.Surface
    hdr.BackgroundTransparency = 0.05
    hdr.BorderSizePixel = 0
    Instance.new("UICorner", hdr).CornerRadius = UDim.new(0, 10)
    local hdrFill = Instance.new("Frame", hdr)
    hdrFill.Size = UDim2.new(1,0,0,10); hdrFill.Position = UDim2.new(0,0,1,-10)
    hdrFill.BackgroundColor3 = COLORS.Surface; hdrFill.BackgroundTransparency = 0.05
    hdrFill.BorderSizePixel = 0

    local dot = Instance.new("Frame", hdr)
    dot.Size = UDim2.new(0,6,0,6); dot.Position = UDim2.new(0,9,0.5,-3)
    dot.BackgroundColor3 = COLORS.Accent; dot.BorderSizePixel = 0
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1,0)
    trackDot(dot)

    local titleLbl = Instance.new("TextLabel", hdr)
    titleLbl.AutoLocalize = false
    titleLbl.Size = UDim2.new(1,-34,1,0); titleLbl.Position = UDim2.new(0,20,0,0)
    titleLbl.BackgroundTransparency = 1; titleLbl.Text = "Auto Play"
    titleLbl.TextColor3 = COLORS.Accent; titleLbl.Font = Enum.Font.GothamSemibold
    trackLabel(titleLbl)
    titleLbl.TextSize = 11; titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    local titleGrad = Instance.new("UIGradient", titleLbl)
    titleGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,    COLORS.Accent),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(120,255,200)),
        ColorSequenceKeypoint.new(0.66, Color3.fromRGB(150,255,180)),
        ColorSequenceKeypoint.new(1,    COLORS.Accent),
    })
    trackGradient(titleGrad)

    local minBtn = Instance.new("TextButton", hdr)
    minBtn.AutoLocalize = false
    minBtn.Size = UDim2.new(0,20,0,18); minBtn.Position = UDim2.new(1,-24,0.5,-9)
    minBtn.BackgroundColor3 = COLORS.Background; minBtn.BackgroundTransparency = 0.2
    minBtn.Text = "-"; minBtn.TextColor3 = COLORS.Accent
    minBtn.Font = Enum.Font.GothamBold; minBtn.TextSize = 14; minBtn.BorderSizePixel = 0
    Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0,4)
    makeAccentStroke(minBtn, 1, 0.4); trackLabel(minBtn)

    local content = Instance.new("Frame", main)
    content.Size = UDim2.new(1,0,1,-HDR_H); content.Position = UDim2.new(0,0,0,HDR_H)
    content.BackgroundTransparency = 1; content.BorderSizePixel = 0
    local btnLayout = Instance.new("UIListLayout", content)
    btnLayout.FillDirection = Enum.FillDirection.Horizontal
    btnLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    btnLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    btnLayout.Padding = UDim.new(0, GAP)
    local btnPad = Instance.new("UIPadding", content)
    btnPad.PaddingLeft=UDim.new(0,PAD); btnPad.PaddingRight=UDim.new(0,PAD)
    btnPad.PaddingTop=UDim.new(0,PAD); btnPad.PaddingBottom=UDim.new(0,PAD)

    local FULL_W = W - PAD*2

    local apMainBtn = Instance.new("TextButton", content)
    apMainBtn.AutoLocalize = false
    apMainBtn.LayoutOrder = 1
    apMainBtn.Size = UDim2.new(0, FULL_W, 0, BTN_H)
    apMainBtn.BackgroundColor3 = COLORS.Surface
    apMainBtn.BackgroundTransparency = COLORS.SurfaceTransparency
    apMainBtn.Text = "Auto Play"
    apMainBtn.TextColor3 = COLORS.Accent
    trackLabel(apMainBtn)
    apMainBtn.Font = Enum.Font.GothamBold; apMainBtn.TextSize = 12; apMainBtn.BorderSizePixel = 0
    Instance.new("UICorner", apMainBtn).CornerRadius = UDim.new(0,7)
    makeAccentStroke(apMainBtn, 1, 0.45)

    local apBadge = Instance.new("TextLabel", apMainBtn)
    apBadge.AutoLocalize = false
    apBadge.Size = UDim2.new(0,40,0,12); apBadge.AnchorPoint = Vector2.new(1,0)
    apBadge.Position = UDim2.new(1,-2,1,-5)
    apBadge.BackgroundColor3 = COLORS.Background; apBadge.BackgroundTransparency = 0.15
    apBadge.BorderSizePixel = 0; apBadge.Font = Enum.Font.GothamBold; apBadge.TextSize = 7
    apBadge.TextColor3 = COLORS.Accent; apBadge.ZIndex = 5
    apBadge.Text = CONFIG.AUTO_PLAY_KEYBIND and CONFIG.AUTO_PLAY_KEYBIND.Name or "NONE"
    Instance.new("UICorner", apBadge).CornerRadius = UDim.new(0,3)
    makeAccentStroke(apBadge, 1, 0.35); trackLabel(apBadge)
    apMainBtn.MouseButton1Click:Connect(function()
        apLaunchSide("auto")
    end)

    -- Индикатор состояния
    local apStatusDot = Instance.new("Frame", apMainBtn)
    apStatusDot.Size = UDim2.new(0, 6, 0, 6)
    apStatusDot.AnchorPoint = Vector2.new(0, 0.5)
    apStatusDot.Position = UDim2.new(0, 8, 0.5, 0)
    apStatusDot.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    apStatusDot.BorderSizePixel = 0
    apStatusDot.ZIndex = 5
    Instance.new("UICorner", apStatusDot).CornerRadius = UDim.new(1, 0)

    local function syncApBtn(active)
        if not apMainBtn or not apMainBtn.Parent then return end
        apMainBtn.Text = active and "AUTO PLAY: ON" or "AUTO PLAY: OFF"
        apStatusDot.BackgroundColor3 = active and COLORS.Accent or Color3.fromRGB(80, 80, 80)
        S.TweenService:Create(apMainBtn, tweenInfoFast, {
            BackgroundColor3       = active and COLORS.Accent or COLORS.Surface,
            BackgroundTransparency = active and 0.0 or COLORS.SurfaceTransparency,
        }):Play()
        apMainBtn.TextColor3 = active and Color3.fromRGB(10, 10, 10) or COLORS.Accent
    end
    syncApBtn(false)

    task.spawn(function()
        local last = nil
        while apMainBtn and apMainBtn.Parent do
            task.wait(0.1)
            local cur  = AP.enabled
            if cur ~= last then
                syncApBtn(cur)
                last = cur
            end
            apBadge.Text = CONFIG.AUTO_PLAY_KEYBIND and CONFIG.AUTO_PLAY_KEYBIND.Name or "NONE"
        end
    end)

    -- reuse apBtnL/apBtnR aliases pointing to same button for apSetBtnActive compat
    apBtnL = apMainBtn
    apBtnR = apMainBtn

    local apMinimized = false
    minBtn.MouseButton1Click:Connect(function()
        apMinimized = not apMinimized
        if apMinimized then
            hdrFill.Visible=false; content.Visible=false
            S.TweenService:Create(main, tweenInfoMedium, {Size=UDim2.new(0,W,0,HDR_H)}):Play()
            minBtn.Text="+"
        else
            hdrFill.Visible=true; content.Visible=true
            S.TweenService:Create(main, tweenInfoMedium, {Size=UDim2.new(0,W,0,FULL_H)}):Play()
            minBtn.Text="-"
        end
    end)

    -- Drag main
    makeDraggable(main, hdr, "autoPlayMain", function() return CONFIG.UI_LOCKED end)

    -- Load saved offsets
    if CONFIG._autoPlayOffsets then
        for _, side in ipairs({"L","R"}) do
            for _, key in ipairs(AP.POINT_KEYS) do
                if CONFIG._autoPlayOffsets[side] and CONFIG._autoPlayOffsets[side][key] then
                    AP.offsets[side][key].x=CONFIG._autoPlayOffsets[side][key].x or 0
                    AP.offsets[side][key].z=CONFIG._autoPlayOffsets[side][key].z or 0
                end
            end
        end
    end

    apGuiInstance=sg
    pcall(function()
        applyAccentColor(CONFIG.GUI_COLOR_R or 0, CONFIG.GUI_COLOR_G or 217, CONFIG.GUI_COLOR_B or 127)
    end)
    return sg
end



    

local function triggerAutoReactSteal()
    if not autoReactStealEnabled then return end
    if _autoReactStealCooldown then return end
    _autoReactStealCooldown = true
    task.spawn(function()
        local char = S.LocalPlayer.Character
        if char then
            local tool = char:FindFirstChildOfClass("Tool")
            if tool then
                local toolName = string.lower(tool.Name)
                local isMedusa = string.find(toolName, "medusa") ~= nil
                local isBat = string.find(toolName, "bat") ~= nil
                if isMedusa or isBat then
                    for _ = 1, 3 do
                        pcall(function() tool:Activate() end)
                        task.wait(0.1)
                    end
                end
            end
        end
        task.wait(1.5)
        _autoReactStealCooldown = false
    end)
end


local function _reactWatchText(obj)
    local function check()
        if type(obj.Text) == "string" and string.find(string.lower(obj.Text), REACT_STEAL_KEYWORD, 1, true) then
            triggerAutoReactSteal()
        end
    end
    check()
    obj:GetPropertyChangedSignal("Text"):Connect(check)
end

local function _reactScanGui(parent)
    for _, desc in ipairs(parent:GetDescendants()) do
        if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
            _reactWatchText(desc)
        end
    end
    parent.DescendantAdded:Connect(function(desc)
        if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
            _reactWatchText(desc)
        end
    end)
end

local function startAutoReactStealWatcher()
    if _autoReactStealConn then return end
    local pg = S.LocalPlayer:WaitForChild("PlayerGui")
    for _, gui in ipairs(pg:GetChildren()) do
        _reactScanGui(gui)
    end
    _autoReactStealConn = pg.ChildAdded:Connect(function(gui)
        _reactScanGui(gui)
    end)
end

local function stopAutoReactStealWatcher()
    if _autoReactStealConn then
        _autoReactStealConn:Disconnect()
        _autoReactStealConn = nil
    end
end


-- ======================================
-- FAST PANEL  (split: Loop=BAT/DROP | Rix=FLOAT/LOCK)
-- ======================================


local function createFastPanel()
    local CELL_W  = 50
    local CELL_H  = 46
    local GAP     = 5
    local PAD     = 5
    local HDR_H   = 16
    local ROWS    = 2
    local W = CELL_W + PAD * 2
    local H = HDR_H + ROWS * CELL_H + (ROWS - 1) * GAP + PAD * 2 + 4

    local function makePanelFrame(parentGui, saveKey, defaultPos)
        local frm = Instance.new("Frame", parentGui)
        frm.Size = UDim2.new(0, W, 0, H)
        frm.BackgroundColor3 = COLORS.Background
        frm.BackgroundTransparency = 0.22
        frm.BorderSizePixel = 0
        frm.Active = true
        frm.ClipsDescendants = false
        frm.Visible = _FP.visible
        Instance.new("UICorner", frm).CornerRadius = UDim.new(0, 10)
        local fs = Instance.new("UIStroke", frm)
        fs.Color = COLORS.Accent
        fs.Thickness = 1.5
        fs.Transparency = 0.35
        fs.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        trackStroke(fs)
        loadAndClampPosition(frm, saveKey, defaultPos)
        _regDraggable(frm, function() return defaultPos end)
        local _drag, _ds, _sp, _dc = false, nil, nil, nil
        local _ldu = 0
        frm.InputBegan:Connect(function(inp)
            if CONFIG.UI_LOCKED then return end
            if inp.UserInputType ~= Enum.UserInputType.MouseButton1 and
               inp.UserInputType ~= Enum.UserInputType.Touch then return end
            _drag = true; _ds = inp.Position; _sp = frm.Position
            if _dc then _dc:Disconnect() end
            _dc = inp.Changed:Connect(function()
                if inp.UserInputState == Enum.UserInputState.End then
                    _drag = false
                    if _dc then _dc:Disconnect(); _dc = nil end
                    CONFIG._guiPositions = CONFIG._guiPositions or {}
                    CONFIG._guiPositions[saveKey] = {
                        scaleX=0, scaleY=0,
                        offsetX=frm.Position.X.Offset,
                        offsetY=frm.Position.Y.Offset,
                    }
                    saveConfig()
                end
            end)
        end)
        S.UserInputService.InputChanged:Connect(function(inp)
            if CONFIG.UI_LOCKED then return end
            if not _drag then return end
            if inp.UserInputType ~= Enum.UserInputType.MouseMovement and
               inp.UserInputType ~= Enum.UserInputType.Touch then return end
            local now = tick()
            if now - _ldu < 0.016 then return end
            _ldu = now
            local d = inp.Position - _ds
            local vp = _getViewport()
            local sz = frm.AbsoluteSize
            frm.Position = UDim2.fromOffset(
                math.clamp(_sp.X.Offset + d.X, 4, vp.X - sz.X - 4),
                math.clamp(_sp.Y.Offset + d.Y, 4, vp.Y - sz.Y - 4)
            )
        end)
        return frm
    end

    local sgL = Instance.new("ScreenGui", S.PlayerGui)
    sgL.AutoLocalize = false; sgL.Name = "Looprix_FastPanel"; sgL.ResetOnSpawn = false
    sgL.DisplayOrder = 999997; sgL.Enabled = true

    local sgR = Instance.new("ScreenGui", S.PlayerGui)
    sgR.AutoLocalize = false; sgR.Name = "Looprix_FastPanel"; sgR.ResetOnSpawn = false
    sgR.DisplayOrder = 999997; sgR.Enabled = true

    local mainL = makePanelFrame(sgL, "fastPanelL", UDim2.new(1, -(W*2 + 64), 0.5, -(H/2)))
    local mainR = makePanelFrame(sgR, "fastPanelR", UDim2.new(1, -(W   + 58), 0.5, -(H/2)))

    local function addHeader(parent, title)
        local hdr = Instance.new("TextLabel", parent)
        hdr.AutoLocalize = false
        hdr.Size = UDim2.new(1, -4, 0, HDR_H)
        hdr.Position = UDim2.new(0, 2, 0, 3)
        hdr.BackgroundTransparency = 1
        hdr.Text = title
        hdr.TextColor3 = COLORS.Accent
        hdr.Font = Enum.Font.GothamBlack
        hdr.TextSize = 9
        hdr.TextXAlignment = Enum.TextXAlignment.Center
        hdr.ZIndex = 100
        trackLabel(hdr)
    end
    addHeader(mainL, "Loop")
    addHeader(mainR, "Rix")

    local function addSep(parent)
        local sep = Instance.new("Frame", parent)
        sep.Size = UDim2.new(1, -PAD*2, 0, 1)
        sep.Position = UDim2.new(0, PAD, 0, HDR_H + 2)
        sep.BackgroundColor3 = COLORS.Accent
        sep.BackgroundTransparency = 0.75
        sep.BorderSizePixel = 0
        trackFrame(sep)
    end
    addSep(mainL); addSep(mainR)

    local function createCell(parentFrame, text, rowIdx, onToggle, isOneShot)
        local yOff = HDR_H + 5 + (rowIdx - 1) * (CELL_H + GAP)
        local btn = Instance.new("TextButton", parentFrame)
        btn.AutoLocalize = false
        btn.Size = UDim2.new(0, CELL_W, 0, CELL_H)
        btn.Position = UDim2.new(0, PAD, 0, yOff)
        btn.BackgroundColor3 = COLORS.Surface
        btn.BackgroundTransparency = 0.08
        btn.BorderSizePixel = 0
        btn.Text = ""
        btn.ZIndex = 101
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

        local bStroke = Instance.new("UIStroke", btn)
        bStroke.Color = COLORS.Accent
        bStroke.Thickness = 2
        bStroke.Transparency = 0.6
        bStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        trackStroke(bStroke)

        local lbl = Instance.new("TextLabel", btn)
        lbl.AutoLocalize = false
        lbl.Size = UDim2.new(1, 0, 0, 20)
        lbl.Position = UDim2.new(0, 0, 0, 6)
        lbl.BackgroundTransparency = 1
        lbl.Text = text
        lbl.TextColor3 = Color3.fromRGB(230, 240, 255)
        lbl.Font = Enum.Font.GothamBlack
        lbl.TextSize = 10
        lbl.ZIndex = 102
        lbl.TextXAlignment = Enum.TextXAlignment.Center

        -- Badge toggle (rounded rect, not circle)
        local badge = Instance.new("TextLabel", btn)
        badge.AutoLocalize = false
        badge.Size = UDim2.new(0, CELL_W - 14, 0, 14)
        badge.Position = UDim2.new(0, 7, 1, -18)
        badge.BackgroundColor3 = COLORS.Background
        badge.BackgroundTransparency = 0.1
        badge.BorderSizePixel = 0
        badge.Text = "OFF"
        badge.TextColor3 = COLORS.TextDim
        badge.Font = Enum.Font.GothamBold
        badge.TextSize = 8
        badge.ZIndex = 102
        badge.TextXAlignment = Enum.TextXAlignment.Center
        Instance.new("UICorner", badge).CornerRadius = UDim.new(0, 4)
        local badgeStroke = Instance.new("UIStroke", badge)
        badgeStroke.Color = COLORS.Accent
        badgeStroke.Thickness = 1
        badgeStroke.Transparency = 0.7
        trackStroke(badgeStroke)

        local isActive = false
        local function setVisual(state)
            isActive = state
            S.TweenService:Create(badge, TweenInfo.new(0.18, Enum.EasingStyle.Quad), {
                BackgroundColor3 = state and COLORS.Accent or COLORS.Background,
                BackgroundTransparency = state and 0.05 or 0.1,
            }):Play()
            badge.Text = state and "ON" or "OFF"
            badge.TextColor3 = state and Color3.fromRGB(10,10,10) or COLORS.TextDim
            S.TweenService:Create(bStroke, TweenInfo.new(0.18), {
                Transparency = state and 0.1 or 0.6
            }):Play()
            if state then
                if not table.find(_accentFrames, badge) then table.insert(_accentFrames, badge) end
            else
                for i, f in ipairs(_accentFrames) do
                    if f == badge then table.remove(_accentFrames, i); break end
                end
            end
        end

        btn.MouseButton1Click:Connect(function()
            if isOneShot then
                setVisual(true)
                if onToggle then onToggle(true) end
                task.delay(0.35, function() setVisual(false) end)
            else
                isActive = not isActive
                setVisual(isActive)
                if onToggle then onToggle(isActive) end
            end
        end)
        btn.MouseEnter:Connect(function()
            S.TweenService:Create(btn, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(20, 28, 40)}):Play()
        end)
        btn.MouseLeave:Connect(function()
            S.TweenService:Create(btn, TweenInfo.new(0.12), {BackgroundColor3 = COLORS.Surface}):Play()
        end)
        return setVisual
    end

    -- Left panel: BAT (row1), DROP (row2)
    local _fpBatSet = createCell(mainL, "BAT", 1, function(on)
        CONFIG.AUTO_BAT_ENABLED = on; attacking = on
        if on then autoAttack() end; saveConfig()
    end, false)

    local _fpDropSet = createCell(mainL, "DROP", 2, function(_)
        task.spawn(runDropBrainrot)
    end, true)

    -- Right panel: FLOAT (row1), LOCK (row2)
    local _fpFloatSet = createCell(mainR, "FLOAT", 1, function(on)
        if on then
            CONFIG.FLOAT_ACTIVE = true
            startFloat()
        else
            stopFloat()
        end
        saveConfig()
    end, false)

    local _fpLockSet = createCell(mainR, "LOCK", 2, function(on)
        if isSwitching then return end
        if on then
            isSwitching = true
            -- mutual exclusion: lock ON → force aimbot OFF
            if CONFIG.AIMBOT_ENABLED then
                CONFIG.AIMBOT_ENABLED = false
                aimbotEnabled = false
                stopBodyAimbot()
                if _aimbotBtn then setToggleVisual(_aimbotBtn, false) end
                showNotification("Aimbot", false)
            end
            if AP.enabled then
                apStopLoop()
                apResetBtns()
            end
            isSwitching = false
        end
        CONFIG.LOCK_TARGET_ENABLED = on; lockTargetEnabled = on
        if lockTargetPanelBtn then
            lockTargetPanelBtn.Text = "LOCK: " .. (on and "ON" or "OFF")
        end
        saveConfig()
        if on then startLockTarget() else stopLockTarget() end
    end, false)

    -- Sync float badge with _FLT.enabled state
    task.spawn(function()
        local last = nil
        while mainR and mainR.Parent do
            task.wait(0.15)
            local cur = _FLT.enabled
            if cur ~= last then _fpFloatSet(cur); last = cur end
        end
    end)

    -- ── Burger toggle button ──────────────────────────────────────────────
    local brgGui = Instance.new("ScreenGui")
    brgGui.AutoLocalize = false
    brgGui.Name = "Looprix_FastPanelBtn"
    brgGui.ResetOnSpawn = false
    brgGui.DisplayOrder = 999998
    brgGui.IgnoreGuiInset = true
    pcall(function()
        if gethui then brgGui.Parent = gethui()
        elseif syn and syn.protect_gui then syn.protect_gui(brgGui); brgGui.Parent = S.PlayerGui
        else brgGui.Parent = S.PlayerGui end
    end)
    if not brgGui.Parent then brgGui.Parent = S.PlayerGui end

    local brgFrame = Instance.new("Frame")
    brgFrame.Name = "FastPanelBurger"
    brgFrame.Size = UDim2.new(0, 38, 0, 38)
    brgFrame.BackgroundColor3 = Color3.fromRGB(10, 12, 18)
    brgFrame.BackgroundTransparency = 0.35
    brgFrame.BorderSizePixel = 0
    brgFrame.Parent = brgGui
    registerScaleTarget(brgFrame)
    loadAndClampPosition(brgFrame, "fastPanelBtn", UDim2.new(1, -50, 0.5, -19))
    _regDraggable(brgFrame, function() return UDim2.new(1,-50,0.5,-19) end)
    Instance.new("UICorner", brgFrame).CornerRadius = UDim.new(0, 10)

    local brgStroke = Instance.new("UIStroke", brgFrame)
    brgStroke.Thickness = 1.5
    brgStroke.Color = COLORS.Accent
    brgStroke.Transparency = 0.1
    brgStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    trackStroke(brgStroke)

    local brgGrad = Instance.new("UIGradient", brgStroke)
    brgGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,    Color3.fromRGB(0,217,127)),
        ColorSequenceKeypoint.new(0.25, Color3.fromRGB(120,255,210)),
        ColorSequenceKeypoint.new(0.5,  Color3.fromRGB(150,255,180)),
        ColorSequenceKeypoint.new(0.75, Color3.fromRGB(120,255,210)),
        ColorSequenceKeypoint.new(1,    Color3.fromRGB(0,217,127))
    })
    trackGradient(brgGrad)

    local lineH, lineW, lineGap = 2, 16, 4
    local totalLineH = lineH * 3 + lineGap * 2
    local startY = math.floor((38 - totalLineH) / 2)
    local startX = math.floor((38 - lineW) / 2)
    local brgLines = {}
    for i = 0, 2 do
        local ln = Instance.new("Frame", brgFrame)
        ln.Size = UDim2.new(0, lineW, 0, lineH)
        ln.Position = UDim2.new(0, startX, 0, startY + i * (lineH + lineGap))
        ln.BackgroundColor3 = COLORS.Accent
        ln.BorderSizePixel = 0
        Instance.new("UICorner", ln).CornerRadius = UDim.new(0, 1)
        trackFrame(ln)
        table.insert(brgLines, ln)
    end

    local getBrgIsTap = makeDraggable(brgFrame, brgFrame, "fastPanelBtn", function() return CONFIG.UI_LOCKED end)

    brgFrame.InputEnded:Connect(function(inp)
        if inp.UserInputType ~= Enum.UserInputType.MouseButton1 and
           inp.UserInputType ~= Enum.UserInputType.Touch then return end
        if not getBrgIsTap() then return end
        _FP.visible = not _FP.visible
        mainL.Visible = _FP.visible
        mainR.Visible = _FP.visible
        for _, ln in ipairs(brgLines) do
            S.TweenService:Create(ln, TweenInfo.new(0.08, Enum.EasingStyle.Quad), {BackgroundTransparency = 0.5}):Play()
        end
        task.delay(0.12, function()
            for _, ln in ipairs(brgLines) do
                S.TweenService:Create(ln, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {BackgroundTransparency = 0}):Play()
            end
        end)
    end)

    pcall(function()
        applyAccentColor(CONFIG.GUI_COLOR_R or 0, CONFIG.GUI_COLOR_G or 217, CONFIG.GUI_COLOR_B or 127)
    end)
    registerScaleTarget(mainL)
    registerScaleTarget(mainR)
    _FP.gui       = sgL
    _FP.guiR      = sgR
    _fastPanelBurgerFrame = brgFrame
    brgFrame.Visible    = CONFIG.FAST_PANEL_ENABLED  -- hidden by default
    return sgL
end

-- ======================================
-- FLOATING PANELS SETUP
-- ======================================

local function setupFloatingPanels()

    local _ltOnTap
    lockTargetPanelGui, lockTargetPanelBtn, _ltOnTap = createFloatingPanel("LockTarget", "lockPanel", "LOCK_TARGET_PANEL_VISIBLE", "LOCK: " .. (CONFIG.LOCK_TARGET_ENABLED and "ON" or "OFF"))
    trackLabel(lockTargetPanelBtn)

    local function _syncLockPanel(state)
        lockTargetPanelBtn.Text = "LOCK: " .. (state and "ON" or "OFF")
    end
    if CONFIG.LOCK_TARGET_ENABLED then _syncLockPanel(true) end

    _ltOnTap(function()
        if isSwitching then return end
        local newState = not CONFIG.LOCK_TARGET_ENABLED
        if newState then
            isSwitching = true
            if CONFIG.AIMBOT_ENABLED then
                CONFIG.AIMBOT_ENABLED = false
                aimbotEnabled = false
                stopBodyAimbot()
                if _aimbotBtn then setToggleVisual(_aimbotBtn, false) end
                showNotification("Aimbot", false)
            end
            if AP.enabled then apStopLoop(); apResetBtns() end
            isSwitching = false
        end
        CONFIG.LOCK_TARGET_ENABLED = newState
        lockTargetEnabled = newState
        _syncLockPanel(newState)
        saveConfig()
        if lockTargetEnabled then startLockTarget() else stopLockTarget() end
    end)

    local _dbOnTap
    dropBrainrotPanelGui, dropBrainrotPanelBtn, _dbOnTap = createFloatingPanel("DropBrainrot", "dropBrainrotPanel", "DROP_BRAINROT_PANEL_VISIBLE", "DROP BRAINROT")
    _dbOnTap(function() executeDrop() end)
    
    local _sbOnTap
    spinbotPanelGui, spinbotPanelBtn, _sbOnTap = createFloatingPanel("Spinbot", "spinbotPanel", "SPINBOT_PANEL_VISIBLE", "SPIN: " .. (CONFIG.SPINBOT_ENABLED and "ON" or "OFF"))
    trackLabel(spinbotPanelBtn)

    local function _syncSpinPanel(state)
        spinbotPanelBtn.Text = "SPIN: " .. (state and "ON" or "OFF")
    end
    if CONFIG.SPINBOT_ENABLED then _syncSpinPanel(true) end

    _sbOnTap(function()
        local newState = not CONFIG.SPINBOT_ENABLED
        if newState and CONFIG.AIMBOT_ENABLED then
            CONFIG.AIMBOT_ENABLED = false
            aimbotEnabled = false
            stopBodyAimbot()
            saveConfig()
            if _aimbotBtn then setToggleVisual(_aimbotBtn, false) end
            showNotification("Aimbot", false)
        end
        CONFIG.SPINBOT_ENABLED = newState
        spinbotEnabled = newState
        _syncSpinPanel(newState)
        if _spinbotBtn then setToggleVisual(_spinbotBtn, newState) end
        saveConfig()
        if spinbotEnabled then startSpinBot() else stopSpinBot() end
    end)

    local _flOnTap
    floatPanelGui, floatPanelBtn, _flOnTap = createFloatingPanel("Float", "floatPanel", "FLOAT_PANEL_VISIBLE", "FLOAT: " .. (CONFIG.FLOAT_ACTIVE and "ON" or "OFF"))

    _syncFloatBtn(CONFIG.FLOAT_ACTIVE)

    _flOnTap(function()
        if not CONFIG.FLOAT_PANEL_VISIBLE then return end
        if _FLT.enabled then
            stopFloat()
        else
            CONFIG.FLOAT_ACTIVE = true
            startFloat()
        end
        saveConfig()
    end)
    
    local _tauntOnTap
    tauntPanelGui, tauntPanelBtn, _tauntOnTap = createFloatingPanel("Taunt", "tauntPanel", "TAUNT_PANEL_VISIBLE", "TAUNT")
    _tauntOnTap(function()
        pcall(function()
            local TextChatService = game:GetService("TextChatService")
            TextChatService.TextChannels.RBXGeneral:SendAsync("/Looprix Is The Best")
        end)
    end)

    local _flingOnTap
    flingPanelGui, flingPanelBtn, _flingOnTap = createFloatingPanel("Fling", "flingPanel", "FLING_PANEL_VISIBLE", "FLING: OFF")
    _flingOnTap(function()
        flingEnabled = not flingEnabled
        flingPanelBtn.Text = "FLING: " .. (flingEnabled and "ON" or "OFF")
        if flingEnabled then startFling() else stopFling() end
        saveConfig()
    end)

    -- ── ANTI STEAL  (plain toggle — no floating panel) ───────────────────────

    local STEAL_KEYWORD = "someone is stealing"

    local function hasStealKeyword(text)
        if type(text) ~= "string" then return false end
        return string.find(string.lower(text), STEAL_KEYWORD, 1, true) ~= nil
    end

    local function triggerAntiSteal()
        if not antiStealEnabled then return end
        if isSwitching then return end
        if CONFIG.LOCK_TARGET_ENABLED then return end
        isSwitching = true
        if AP.enabled then apStopLoop(); apResetBtns() end
        CONFIG.LOCK_TARGET_ENABLED = true
        lockTargetEnabled = true
        startLockTarget()
        if lockTargetPanelBtn then
            lockTargetPanelBtn.Text = "LOCK: ON"
        end
        isSwitching = false
        showNotification("Anti Steal", true)
    end

    local function watchTextElement(obj)
        if hasStealKeyword(obj.Text) then triggerAntiSteal() end
        obj:GetPropertyChangedSignal("Text"):Connect(function()
            if hasStealKeyword(obj.Text) then triggerAntiSteal() end
        end)
    end

    local function scanGui(parent)
        for _, desc in ipairs(parent:GetDescendants()) do
            if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
                watchTextElement(desc)
            end
        end
        parent.DescendantAdded:Connect(function(desc)
            if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
                watchTextElement(desc)
            end
        end)
    end

    startAntiStealWatcher = function()
        if _antiStealConn then return end
        local pg = S.LocalPlayer:WaitForChild("PlayerGui")
        for _, gui in ipairs(pg:GetChildren()) do scanGui(gui) end
        _antiStealConn = pg.ChildAdded:Connect(function(gui) scanGui(gui) end)
    end

    stopAntiStealWatcher = function()
        if _antiStealConn then _antiStealConn:Disconnect(); _antiStealConn = nil end
    end

    antiStealEnabled = CONFIG.ANTI_STEAL_PANEL_VISIBLE or false
    if antiStealEnabled then startAntiStealWatcher() end

    -- ── TP DOWN PANEL ────────────────────────────────────────────────────────
    local _tpOnTap
    tpDownPanelGui, tpDownPanelBtn, _tpOnTap = createFloatingPanel("TpDown", "tpDownPanel", "TP_DOWN_PANEL_VISIBLE", "TP DOWN")
    _tpOnTap(function() tpDown() end)

    -- ── AUTO LOCK  (plain toggle — no floating panel) ────────────────────────

    local function triggerAutoLock()
        if not autoLockEnabled2 then return end
        if isSwitching then return end
        if CONFIG.LOCK_TARGET_ENABLED then return end
        isSwitching = true
        if AP.enabled then apStopLoop(); apResetBtns() end
        CONFIG.LOCK_TARGET_ENABLED = true
        lockTargetEnabled = true
        startLockTarget()
        pcall(function()
            if lockTargetPanelBtn then
                lockTargetPanelBtn.Text = "LOCK: ON"
            end
        end)
        isSwitching = false
        showNotification("Auto Lock", true)
        -- Auto-unlock after 2 seconds
        task.delay(2, function()
            if not CONFIG.LOCK_TARGET_ENABLED then return end
            CONFIG.LOCK_TARGET_ENABLED = false
            lockTargetEnabled = false
            stopLockTarget()
            pcall(function()
                if lockTargetPanelBtn then
                    lockTargetPanelBtn.Text = "LOCK: OFF"
                end
            end)
        end)
    end

    startAutoLockWatcher = function()
        if _autoLockConn then return end
        _autoLockConn = S.RunService.Heartbeat:Connect(function()
            if not autoLockEnabled2 then return end
            local char = S.LocalPlayer.Character
            if not char then return end
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hum then return end
            local state = hum:GetState()
            local ragdollStates = {
                [Enum.HumanoidStateType.Physics]     = true,
                [Enum.HumanoidStateType.Ragdoll]     = true,
                [Enum.HumanoidStateType.FallingDown] = true,
            }
            local endTime = S.LocalPlayer:GetAttribute("RagdollEndTime")
            local isRagdoll = ragdollStates[state] or
                (endTime and (endTime - workspace:GetServerTimeNow()) > 0)
            if isRagdoll then triggerAutoLock() end
        end)
    end

    stopAutoLockWatcher = function()
        if _autoLockConn then _autoLockConn:Disconnect(); _autoLockConn = nil end
    end

    autoLockEnabled2 = CONFIG.AUTO_LOCK_PANEL_VISIBLE or false
    if autoLockEnabled2 then startAutoLockWatcher() end

    -- ── ANTI LOCK PANEL  (floating toggle) ───────────────────────────────────

    if not _antiLockHooked then
        _antiLockHooked = true
        pcall(function()
            hookfunction(game.Players.LocalPlayer.IsInGroup, function() return true end)
        end)
    end

    local _alockOnTap
    antiLockPanelGui, antiLockPanelBtn, _alockOnTap = createFloatingPanel(
        "AntiLock", "antiLockPanel", "ANTI_LOCK_PANEL_VISIBLE",
        "ANTI LOCK: " .. (CONFIG.ANTI_LOCK_ENABLED and "ON" or "OFF")
    )
    trackLabel(antiLockPanelBtn)

    if CONFIG.ANTI_LOCK_ENABLED then
        antiLockEnabled = true
    end

    if not _antiLockConn then
        _antiLockConn = S.RunService.Heartbeat:Connect(function()
            if not antiLockEnabled then return end
            pcall(function()
                local char = S.LocalPlayer.Character
                if not char then return end
                local root = char:FindFirstChild("HumanoidRootPart")
                if not root then return end
                local vel = root.Velocity
                root.Velocity = Vector3.new(678, vel.Y, vel.Z)
                S.RunService.RenderStepped:Wait()
                root.Velocity = vel
            end)
        end)
    end

    _alockOnTap(function()
        antiLockEnabled = not antiLockEnabled
        CONFIG.ANTI_LOCK_ENABLED = antiLockEnabled
        antiLockPanelBtn.Text = "ANTI LOCK: " .. (antiLockEnabled and "ON" or "OFF")
        showNotification("Anti Lock", antiLockEnabled)
        saveConfig()
    end)

    -- ── DESYNC PANEL  (unified floating toggle — enables desync + ESP together) ──
    local _dsOnTap
    desyncPanelGui, desyncPanelBtn, _dsOnTap = createFloatingPanel(
        "Desync", "desyncPanel", "DESYNC_PANEL_VISIBLE",
        "DSYNC: " .. (CONFIG.DESYNC_ENABLED and "ON" or "OFF")
    )
    trackLabel(desyncPanelBtn)

    if CONFIG.DESYNC_ENABLED then
        task.spawn(function()
            task.wait(0.3)
            local char = S.LocalPlayer.Character
            if char and CONFIG.DESYNC_ENABLED then
                startDesync()
            end
        end)
    end

    _dsOnTap(function()
        local newState = not CONFIG.DESYNC_ENABLED
        toggleDesync(newState)
        if newState then
            if not CONFIG.ESP_ENABLED then startESP() end
        else
            if not CONFIG.ESP_ENABLED then stopESP() end
        end
        desyncPanelBtn.Text = "DSYNC: " .. (newState and "ON" or "OFF")
        trackLabel(desyncPanelBtn)
        showNotification("Desync", newState)
        saveConfig()
    end)

    -- ── Desync Mode Selector (PC ↔ Mobile arrows, anchored below panel btn) ──
    local modeBar = Instance.new("Frame", desyncPanelGui)
    modeBar.Size = UDim2.new(0, 100, 0, 18)
    modeBar.BackgroundColor3 = Color3.fromRGB(8, 10, 16)
    modeBar.BackgroundTransparency = 0.1
    modeBar.BorderSizePixel = 0
    Instance.new("UICorner", modeBar).CornerRadius = UDim.new(0, 5)

    local modeStroke = Instance.new("UIStroke", modeBar)
    modeStroke.Color = COLORS.Accent
    modeStroke.Thickness = 1
    modeStroke.Transparency = 0.3
    modeStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    trackStroke(modeStroke)

    local function _refreshModeBarPos()
        local btnPos = desyncPanelBtn.Position
        local btnSzY = desyncPanelBtn.AbsoluteSize.Y
        modeBar.Position = UDim2.new(
            btnPos.X.Scale, btnPos.X.Offset,
            btnPos.Y.Scale, btnPos.Y.Offset + btnSzY + 3
        )
    end

    local leftArrow = Instance.new("TextButton", modeBar)
    leftArrow.Size = UDim2.new(0, 18, 1, 0)
    leftArrow.Position = UDim2.new(0, 0, 0, 0)
    leftArrow.BackgroundTransparency = 1
    leftArrow.Text = "<"
    leftArrow.TextColor3 = COLORS.Accent
    leftArrow.Font = Enum.Font.GothamBold
    leftArrow.TextSize = 10
    trackLabel(leftArrow)

    local modeLabel = Instance.new("TextLabel", modeBar)
    modeLabel.Size = UDim2.new(1, -36, 1, 0)
    modeLabel.Position = UDim2.new(0, 18, 0, 0)
    modeLabel.BackgroundTransparency = 1
    modeLabel.TextColor3 = COLORS.Accent
    modeLabel.Font = Enum.Font.GothamBold
    modeLabel.TextSize = 9
    modeLabel.Text = string.upper(desyncMode)
    trackLabel(modeLabel)

    local rightArrow = Instance.new("TextButton", modeBar)
    rightArrow.Size = UDim2.new(0, 18, 1, 0)
    rightArrow.Position = UDim2.new(1, -18, 0, 0)
    rightArrow.BackgroundTransparency = 1
    rightArrow.Text = ">"
    rightArrow.TextColor3 = COLORS.Accent
    rightArrow.Font = Enum.Font.GothamBold
    rightArrow.TextSize = 10
    trackLabel(rightArrow)

    local _modes = {"mobile", "pc"}
    local function _switchMode(dir)
        local cur = 1
        for i, m in ipairs(_modes) do if m == desyncMode then cur = i break end end
        cur = ((cur - 1 + dir) % #_modes) + 1
        desyncMode = _modes[cur]
        modeLabel.Text = string.upper(desyncMode)
        if CONFIG.DESYNC_ENABLED then
            stopDesync()
            startDesync()
        end
    end

    leftArrow.Activated:Connect(function() _switchMode(-1) end)
    rightArrow.Activated:Connect(function() _switchMode(1) end)

    desyncPanelBtn:GetPropertyChangedSignal("Position"):Connect(_refreshModeBarPos)
    desyncPanelBtn:GetPropertyChangedSignal("AbsoluteSize"):Connect(_refreshModeBarPos)
    task.defer(_refreshModeBarPos)
end

-- ======================================
-- TABS CREATION
-- ======================================

local function createSettingsTab(parent)
    local tab = createEmptyTab(parent, "Settings")
    local scroll = createElement("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = COLORS.Accent,
        BorderSizePixel = 0,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        Parent = tab,
    })
    local scrollPad = Instance.new("UIPadding")
    scrollPad.PaddingLeft   = UDim.new(0, 6)
    scrollPad.PaddingRight  = UDim.new(0, 10)
    scrollPad.PaddingTop    = UDim.new(0, 6)
    scrollPad.PaddingBottom = UDim.new(0, 6)
    scrollPad.Parent = scroll
    local list = createElement("UIListLayout", {
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        Parent = scroll
    })  

    -- ── UI ───────────────────────────────────────────────────────────────────
    local uiContent, uiWrapper = createCategory(scroll, "[UI Settings]", true)
    uiWrapper.LayoutOrder = 1

    local lockUIToggle = createToggle(uiContent, "Lock UI", CONFIG.UI_LOCKED, function(state)
        CONFIG.UI_LOCKED = state; saveConfig()
    end)
    lockUIToggle.LayoutOrder = 1

    local activeHudToggle = createToggle(uiContent, "Active Functions HUD", CONFIG.ACTIVE_HUD_VISIBLE, function(state)
        CONFIG.ACTIVE_HUD_VISIBLE = state; saveConfig()
        local hud = S.PlayerGui:FindFirstChild("LooprixActiveHUD")
        if hud then hud.Enabled = state end
    end)
    activeHudToggle.LayoutOrder = 2

    local grabBarToggle = createToggle(uiContent, "Grab Bar", CONFIG.GRAB_BAR_VISIBLE, function(state)
        CONFIG.GRAB_BAR_VISIBLE = state; saveConfig()
        local statsGui = S.PlayerGui:FindFirstChild("LooprixStats")
        if statsGui then
            local pr = statsGui:FindFirstChild("ProgressRow", true)
            if pr then pr.Visible = state end
        end
    end)
    grabBarToggle.LayoutOrder = 3

    local notifToggle = createToggle(uiContent, "Notifications", CONFIG.NOTIFICATIONS_ENABLED, function(state)
        CONFIG.NOTIFICATIONS_ENABLED = state; saveConfig()
    end)
    notifToggle.LayoutOrder = 4

    local fastPanelToggle = createToggle(uiContent, "Fast Panel", CONFIG.FAST_PANEL_ENABLED, function(state)
        CONFIG.FAST_PANEL_ENABLED = state; saveConfig()
        if _fastPanelBurgerFrame then
            _fastPanelBurgerFrame.Visible = state
        end
        if not state then
            _FP.visible = false
            if _FP.gui  then _FP.gui.Enabled  = false end
            if _FP.guiR then _FP.guiR.Enabled = false end
        else
            if _FP.gui  then _FP.gui.Enabled  = true end
            if _FP.guiR then _FP.guiR.Enabled = true end
        end
    end)
    fastPanelToggle.LayoutOrder = 5

    local speedMeterToggleSettings = createToggle(uiContent, "Speed Meter", CONFIG.SPEED_METER_ENABLED, function(state)
        CONFIG.SPEED_METER_ENABLED = state; saveConfig()
        toggleSpeedMeter(state)
    end)
    speedMeterToggleSettings.LayoutOrder = 6

    -- ── Auto Stop on Drop toggle ─────────────────────────────────────────────────
    local postDropHaltToggle = createToggle(uiContent, "Auto Stop on Drop", CONFIG.POST_DROP_HALT_ENABLED, function(state)
        CONFIG.POST_DROP_HALT_ENABLED = state; saveConfig()
    end)
    postDropHaltToggle.LayoutOrder = 7

    -- ── Lock on Drop toggle ─────────────────────────────────────────────────────
    local snapLockSettingsToggle = createToggle(uiContent, "Lock on Drop", CONFIG.SNAP_LOCK_ENABLED, function(state)
        CONFIG.SNAP_LOCK_ENABLED = state; saveConfig()
    end)
    snapLockSettingsToggle.LayoutOrder = 8

    -- ── Auto Load on Kick ────────────────────────────────────────────────────
    local autoLoadToggle = createToggle(uiContent, "Auto Load on Kick", CONFIG.AUTO_LOAD_ENABLED, function(state)
        CONFIG.AUTO_LOAD_ENABLED = state; saveConfig()
        if getgenv then getgenv().LOOPRIX_AUTOLOAD = state end
        _setAutoLoad(state)
    end)
    autoLoadToggle.LayoutOrder = 9

    -- ── UI Scale slider ──────────────────────────────────────────────────────
    -- Range 0.5 → 1.25, displayed as integer % (50 → 125) for readability.
    -- Internally the slider works in integer steps (50–125) and we divide by 100.
    local scaleSlider = createSlider(
        uiContent,
        "UI Scale",
        math.floor((CONFIG.UI_SCALE or 1.0) * 100),  -- default shown as integer
        50,   -- min = 0.50
        125,  -- max = 1.25
        function(intVal)
            local realScale = intVal / 100
            CONFIG.UI_SCALE = realScale
            applyUIScale(realScale)
            saveConfig()
        end
    )
    scaleSlider.LayoutOrder = 4

    -- ── FOV CHANGER ──────────────────────────────────────────────────────────
    local fovRow = createElement("Frame", {
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = COLORS.Surface,
        BackgroundTransparency = COLORS.SurfaceTransparency,
        BorderSizePixel = 0,
        LayoutOrder = 5,
        Parent = uiContent,
    })
    createElement("UICorner", { CornerRadius = UDim.new(0, 6), Parent = fovRow })
    trackStroke(createElement("UIStroke", {
        Color = COLORS.Accent, Thickness = 1, Transparency = 0.5,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = fovRow
    }))
    createElement("TextLabel", {
        Size = UDim2.new(0.55, 0, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        Text = "FOV",
        TextColor3 = COLORS.Accent,
        TextSize = 13,
        Font = Enum.Font.GothamSemibold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = fovRow,
    })
    trackLabel(fovRow)
    local fovBox = createElement("TextBox", {
        Size = UDim2.new(0, 70, 0, 24),
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -8, 0.5, 0),
        BackgroundColor3 = COLORS.Background,
        BackgroundTransparency = 0.2,
        Text = tostring(CONFIG.FOV_VALUE or 70),
        TextColor3 = COLORS.Accent,
        PlaceholderText = "10–120",
        PlaceholderColor3 = COLORS.TextDim,
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        ClearTextOnFocus = false,
        BorderSizePixel = 0,
        Parent = fovRow,
    })
    trackLabel(fovBox)
    trackLabel(fovBox)
    createElement("UICorner", { CornerRadius = UDim.new(0, 5), Parent = fovBox })
    trackStroke(createElement("UIStroke", { Color = COLORS.Accent, Thickness = 1, Transparency = 0.4, Parent = fovBox }))
    trackLabel(fovBox)
    fovBox.FocusLost:Connect(function()
        local v = tonumber(fovBox.Text)
        if v then
            CONFIG.FOV_VALUE = math.clamp(math.floor(v), 10, 120)
        end
        fovBox.Text = tostring(CONFIG.FOV_VALUE or 70)
        pcall(function()
            local cam = workspace.CurrentCamera
            if cam then cam.FieldOfView = CONFIG.FOV_VALUE end
        end)
        saveConfig()
    end)

    -- ── FOV LOCK TOGGLE ──────────────────────────────────────────────────────
    local fovLockRow = createElement("Frame", {
        Size = UDim2.new(1, 0, 0, 34),
        BackgroundColor3 = COLORS.Surface,
        BackgroundTransparency = COLORS.SurfaceTransparency,
        BorderSizePixel = 0,
        LayoutOrder = 51,
        Parent = uiContent,
    })
    createElement("UICorner", { CornerRadius = UDim.new(0, 6), Parent = fovLockRow })
    trackStroke(createElement("UIStroke", {
        Color = COLORS.Accent, Thickness = 1, Transparency = 0.5,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = fovLockRow
    }))
    createElement("TextLabel", {
        Size = UDim2.new(0.7, 0, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        Text = "FOV Lock",
        TextColor3 = COLORS.Accent,
        TextSize = 13,
        Font = Enum.Font.GothamSemibold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = fovLockRow,
    })
    trackLabel(fovLockRow)
    local fovLockBtn = Instance.new("TextButton", fovLockRow)
    fovLockBtn.AutoLocalize = false
    fovLockBtn.Size = UDim2.new(0, 46, 0, 22)
    fovLockBtn.AnchorPoint = Vector2.new(1, 0.5)
    fovLockBtn.Position = UDim2.new(1, -8, 0.5, 0)
    fovLockBtn.BackgroundColor3 = CONFIG.FOV_LOCK_ENABLED and COLORS.Accent or COLORS.Background
    fovLockBtn.BorderSizePixel = 0
    fovLockBtn.Text = CONFIG.FOV_LOCK_ENABLED and "ON" or "OFF"
    fovLockBtn.TextColor3 = CONFIG.FOV_LOCK_ENABLED and Color3.fromRGB(10,10,10) or COLORS.TextDim
    fovLockBtn.Font = Enum.Font.GothamBold
    fovLockBtn.TextSize = 11
    Instance.new("UICorner", fovLockBtn).CornerRadius = UDim.new(0, 5)
    trackStroke(createElement("UIStroke", { Color = COLORS.Accent, Thickness = 1, Transparency = 0.35, Parent = fovLockBtn }))
    fovLockBtn.MouseButton1Click:Connect(function()
        CONFIG.FOV_LOCK_ENABLED = not CONFIG.FOV_LOCK_ENABLED
        local on = CONFIG.FOV_LOCK_ENABLED
        S.TweenService:Create(fovLockBtn, tweenInfoFast, {
            BackgroundColor3 = on and COLORS.Accent or COLORS.Background,
        }):Play()
        fovLockBtn.TextColor3 = on and Color3.fromRGB(10,10,10) or COLORS.TextDim
        fovLockBtn.Text = on and "ON" or "OFF"
        saveConfig()
    end)

    -- ── GUI Color — HEX input ────────────────────────────────────────────────
    local colorRow = createElement("Frame", {
        Size = UDim2.new(1, 0, 0, 50),
        BackgroundColor3 = COLORS.Surface,
        BackgroundTransparency = COLORS.SurfaceTransparency,
        BorderSizePixel = 0,
        LayoutOrder = 6,
        Parent = uiContent,
    })
    createElement("UICorner", { CornerRadius = UDim.new(0, 6), Parent = colorRow })
    local crStroke = createElement("UIStroke", { Color = COLORS.Accent, Thickness = 1, Transparency = 0.5,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = colorRow })
    trackStroke(crStroke)

    local crLabel = createElement("TextLabel", {
        Size = UDim2.new(1, -12, 0, 16),
        Position = UDim2.new(0, 8, 0, 4),
        BackgroundTransparency = 1,
        Text = "GUI Color  (#RRGGBB)",
        TextColor3 = COLORS.Accent,
        TextSize = 12,
        Font = Enum.Font.GothamSemibold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = colorRow,
    })
    trackLabel(crLabel)

    -- Preview swatch
    local crPreview = createElement("Frame", {
        Size = UDim2.new(0, 18, 0, 18),
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -8, 0, 4),
        BackgroundColor3 = COLORS.Accent,
        BorderSizePixel = 0,
        Parent = colorRow,
    })
    createElement("UICorner", { CornerRadius = UDim.new(0, 4), Parent = crPreview })
    trackFrame(crPreview)

    -- HEX text input
    local hexBox = createElement("TextBox", {
        Size = UDim2.new(1, -16, 0, 22),
        Position = UDim2.new(0, 8, 0, 24),
        BackgroundColor3 = COLORS.Background,
        BackgroundTransparency = 0.3,
        Text = string.format("#%02X%02X%02X", CONFIG.GUI_COLOR_R, CONFIG.GUI_COLOR_G, CONFIG.GUI_COLOR_B),
        TextColor3 = COLORS.Accent,
        PlaceholderText = "#00D97F",
        PlaceholderColor3 = COLORS.TextDim,
        TextSize = 12,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0,
        ClearTextOnFocus = false,
        Parent = colorRow,
    })
    trackLabel(hexBox)
    trackLabel(hexBox)
    createElement("UICorner", { CornerRadius = UDim.new(0, 5), Parent = hexBox })
    local hexStroke = createElement("UIStroke", { Color = COLORS.Accent, Thickness = 1, Transparency = 0.4, Parent = hexBox })
    trackStroke(hexStroke)
    trackLabel(hexBox)

    local function applyHex(raw)
        local hex = raw:gsub("^#", ""):upper()
        if #hex == 6 then
            local r = tonumber(hex:sub(1,2), 16)
            local g = tonumber(hex:sub(3,4), 16)
            local b = tonumber(hex:sub(5,6), 16)
            if r and g and b then
                applyAccentColor(r, g, b)
                crPreview.BackgroundColor3 = Color3.fromRGB(r, g, b)
                hexBox.Text = "#" .. hex
                saveConfig()
                return
            end
        end
        hexBox.Text = string.format("#%02X%02X%02X", CONFIG.GUI_COLOR_R, CONFIG.GUI_COLOR_G, CONFIG.GUI_COLOR_B)
    end

    hexBox.FocusLost:Connect(function()
        applyHex(hexBox.Text)
    end)

    -- ── COMBAT VALUES ────────────────────────────────────────────────────────
    local cvContent, cvWrapper = createCategory(scroll, "[Combat Values]", true)
    cvWrapper.LayoutOrder = 2

    local aimbotRangeInput = createNumberInput(cvContent, "Aimbot Range", CONFIG.AIMBOT_RANGE, 5, 200, function(value)
        CONFIG.AIMBOT_RANGE = value
    end)
    aimbotRangeInput.LayoutOrder = 1

    local aimbotDisableInput = createNumberInput(cvContent, "Aimbot Disable Range", CONFIG.AIMBOT_DISABLE_RANGE, 5, 250, function(value)
        CONFIG.AIMBOT_DISABLE_RANGE = value
    end)
    aimbotDisableInput.LayoutOrder = 2

    local spinbotSpeedInput = createNumberInput(cvContent, "Spinbot Speed", CONFIG.SPINBOT_SPEED, 1, 100, function(value)
        CONFIG.SPINBOT_SPEED = value
    end)
    spinbotSpeedInput.LayoutOrder = 4

    local lockSpeedInput = createNumberInput(cvContent, "Lock Target Speed", CONFIG.LOCK_TARGET_SPEED, 1, 200, function(value)
        CONFIG.LOCK_TARGET_SPEED = value
    end)
    lockSpeedInput.LayoutOrder = 5

    local mirrorTpDownThreshInput = createNumberInput(cvContent, "Mirror Tp Down Threshold", CONFIG.MIRROR_TP_DOWN_THRESHOLD, 5, 100, function(value)
        CONFIG.MIRROR_TP_DOWN_THRESHOLD = value
        saveConfig()
    end)
    mirrorTpDownThreshInput.LayoutOrder = 6

    -- ── TOOL VALUES ───────────────────────────────────────────────────────────
    local tvContent, tvWrapper = createCategory(scroll, "[Tool Values]", true)
    tvWrapper.LayoutOrder = 3

    local medusaRangeInput = createNumberInput(tvContent, "Medusa Range", CONFIG.AUTO_MEDUSA_RANGE, 1, 50, function(value)
        CONFIG.AUTO_MEDUSA_RANGE = value
        if medusaCircle then medusaCircle.Radius = value end
    end)
    medusaRangeInput.LayoutOrder = 1

    local igDistInput = createNumberInput(tvContent, "Grab Distance", CONFIG.INSTANT_GRAB_ACTIVATION_DIST, 1, 9999, function(value)
        CONFIG.INSTANT_GRAB_ACTIVATION_DIST = value
    end, true)
    igDistInput.LayoutOrder = 2

    local floatHeightInput = createNumberInput(tvContent, "Float Height", CONFIG.FLOAT_HEIGHT, 0, 50, function(value)
        CONFIG.FLOAT_HEIGHT = value
        saveConfig()
    end)
    floatHeightInput.LayoutOrder = 3

    local floatSpeedInput = createNumberInput(tvContent, "Float Speed (1-100)", CONFIG.FLOAT_SPEED, 1, 100, function(value)
        CONFIG.FLOAT_SPEED = math.clamp(value, 1, 100)
        saveConfig()
    end)
    floatSpeedInput.LayoutOrder = 4

    -- ── AUTO PLAY POINTS ──────────────────────────────────────────────────────
    local apContent, apWrapper = createCategory(scroll, "[Auto Play]", true)
    apWrapper.LayoutOrder = 4

    -- Which side we are currently setting points for
    local _apSide = "L"

    -- Clean point toast — no left color bar, pure text card
    local function showPointToast(msg)
        task.spawn(function()
            ensureToastGui()
            local toast = Instance.new("Frame", _toastContainer)
            toast.Size = UDim2.new(1, 0, 0, 38)
            toast.BackgroundColor3 = COLORS.Background
            toast.BackgroundTransparency = 1
            toast.BorderSizePixel = 0
            toast.LayoutOrder = _toastCount + 1
            _toastCount = _toastCount + 1
            toast.ClipsDescendants = true
            Instance.new("UICorner", toast).CornerRadius = UDim.new(0, 8)

            local tStroke = Instance.new("UIStroke", toast)
            tStroke.Thickness = 1.2
            tStroke.Color = COLORS.Accent
            tStroke.Transparency = 0.15
            tStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            trackStroke(tStroke)

            local tLbl = Instance.new("TextLabel", toast)
            tLbl.AutoLocalize = false
            tLbl.Size = UDim2.new(1, -16, 1, 0)
            tLbl.Position = UDim2.new(0, 8, 0, 0)
            tLbl.BackgroundTransparency = 1
            tLbl.Text = msg
            tLbl.TextColor3 = COLORS.Accent
            tLbl.TextSize = 12
            tLbl.Font = Enum.Font.GothamBold
            tLbl.TextXAlignment = Enum.TextXAlignment.Left
            tLbl.TextTransparency = 1
            trackLabel(tLbl)

            local sc = Instance.new("UIScale", toast)
            sc.Scale = 0.88

            -- slide in
            S.TweenService:Create(toast, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                { BackgroundTransparency = 0.08 }):Play()
            S.TweenService:Create(tLbl, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                { TextTransparency = 0 }):Play()
            S.TweenService:Create(sc, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                { Scale = 1 }):Play()

            task.wait(2.2)

            S.TweenService:Create(toast, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
                { BackgroundTransparency = 1 }):Play()
            S.TweenService:Create(tLbl, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
                { TextTransparency = 1 }):Play()
            S.TweenService:Create(tStroke, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
                { Transparency = 1 }):Play()
            S.TweenService:Create(sc, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
                { Scale = 0.85 }):Play()
            task.wait(0.28)
            if toast and toast.Parent then toast:Destroy() end
        end)
    end

    -- ── SIDE SWITCHER ROW ──────────────────────────────────────────────────────
    local sideRow = Instance.new("Frame")
    sideRow.Size = UDim2.new(1, 0, 0, 30)
    sideRow.BackgroundColor3 = COLORS.Surface
    sideRow.BackgroundTransparency = 0.1
    sideRow.BorderSizePixel = 0
    sideRow.LayoutOrder = 0
    sideRow.Parent = apContent
    local srCorner = Instance.new("UICorner", sideRow)
    srCorner.CornerRadius = UDim.new(0, 7)
    local srStroke = Instance.new("UIStroke", sideRow)
    srStroke.Color = COLORS.Accent
    srStroke.Thickness = 1
    srStroke.Transparency = 0.45
    srStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    trackStroke(srStroke)

    -- Arrow left
    local arL = Instance.new("TextButton", sideRow)
    arL.AutoLocalize = false
    arL.Size = UDim2.new(0, 26, 1, 0)
    arL.Position = UDim2.new(0, 0, 0, 0)
    arL.BackgroundTransparency = 1
    arL.Text = "←"
    arL.TextColor3 = COLORS.Accent
    arL.Font = Enum.Font.GothamBold
    arL.TextSize = 14
    arL.BorderSizePixel = 0
    trackLabel(arL)

    -- Side label (center)
    local sideLbl = Instance.new("TextLabel", sideRow)
    sideLbl.AutoLocalize = false
    sideLbl.Size = UDim2.new(1, -52, 1, 0)
    sideLbl.Position = UDim2.new(0, 26, 0, 0)
    sideLbl.BackgroundTransparency = 1
    sideLbl.Text = "Auto Left"
    sideLbl.TextColor3 = COLORS.Accent
    trackLabel(sideLbl)
    sideLbl.Font = Enum.Font.GothamSemibold
    sideLbl.TextSize = 11
    sideLbl.TextXAlignment = Enum.TextXAlignment.Center
    local sideLblGrad = Instance.new("UIGradient", sideLbl)
    sideLblGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,    COLORS.Accent),
        ColorSequenceKeypoint.new(0.5,  Color3.fromRGB(150,255,180)),
        ColorSequenceKeypoint.new(1,    COLORS.Accent),
    })
    trackGradient(sideLblGrad)

    -- Arrow right
    local arR = Instance.new("TextButton", sideRow)
    arR.AutoLocalize = false
    arR.Size = UDim2.new(0, 26, 1, 0)
    arR.Position = UDim2.new(1, -26, 0, 0)
    arR.BackgroundTransparency = 1
    arR.Text = "→"
    arR.TextColor3 = COLORS.Accent
    arR.Font = Enum.Font.GothamBold
    arR.TextSize = 14
    arR.BorderSizePixel = 0
    trackLabel(arR)

    local function apSetSide(side)
        _apSide = side
        AP.settingsSide = side
        sideLbl.Text = (side == "L") and "Auto Left" or "Auto Right"
    end

    arL.Activated:Connect(function() apSetSide("L") end)
    arR.Activated:Connect(function() apSetSide("R") end)

    -- ── POINT ROWS ────────────────────────────────────────────────────────────
    for i = 1, 5 do
        local row = Instance.new("Frame")
        row.Size = UDim2.new(1, 0, 0, 32)
        row.BackgroundColor3 = COLORS.Surface
        row.BackgroundTransparency = 0.08
        row.BorderSizePixel = 0
        row.LayoutOrder = i
        row.Parent = apContent
        local rCorner = Instance.new("UICorner", row)
        rCorner.CornerRadius = UDim.new(0, 6)
        local rStroke = Instance.new("UIStroke", row)
        rStroke.Color = COLORS.Accent
        rStroke.Thickness = 1
        rStroke.Transparency = 0.65
        rStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        trackStroke(rStroke)

        local ptLbl = Instance.new("TextLabel", row)
        ptLbl.AutoLocalize = false
        ptLbl.Size = UDim2.new(1, -72, 1, 0)
        ptLbl.Position = UDim2.new(0, 10, 0, 0)
        ptLbl.BackgroundTransparency = 1
        ptLbl.Text = "Point " .. i
        ptLbl.TextColor3 = COLORS.Accent
        trackLabel(ptLbl)
        ptLbl.Font = Enum.Font.GothamSemibold
        ptLbl.TextSize = 12
        ptLbl.TextXAlignment = Enum.TextXAlignment.Left

        local setBtn = Instance.new("TextButton", row)
        setBtn.AutoLocalize = false
        setBtn.Size = UDim2.new(0, 48, 0, 22)
        setBtn.AnchorPoint = Vector2.new(1, 0.5)
        setBtn.Position = UDim2.new(1, -8, 0.5, 0)
        setBtn.BackgroundColor3 = Color3.fromRGB(10, 40, 28)
        setBtn.BackgroundTransparency = 0
        setBtn.Text = "SET"
        setBtn.TextColor3 = COLORS.Accent
        trackLabel(setBtn)
        setBtn.Font = Enum.Font.GothamBold
        setBtn.TextSize = 11
        setBtn.BorderSizePixel = 0
        local sBtnCorner = Instance.new("UICorner", setBtn)
        sBtnCorner.CornerRadius = UDim.new(0, 5)
        local sBtnStroke = Instance.new("UIStroke", setBtn)
        sBtnStroke.Color = COLORS.Accent
        sBtnStroke.Thickness = 1
        sBtnStroke.Transparency = 0.3
        sBtnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        trackStroke(sBtnStroke)
        trackLabel(setBtn)

        local _idx = i
        setBtn.Activated:Connect(function()
            local character = S.LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local pos = character.HumanoidRootPart.Position
                local key = AP.POINT_KEYS[_idx]
                -- Save exact position to BASE
                AP.BASE[_apSide][key] = Vector3.new(pos.X, pos.Y, pos.Z)
                -- Zero out any saved offset so apGetTarget returns exactly pos
                AP.offsets[_apSide][key] = { x = 0, z = 0 }
                -- Save to config immediately
                CONFIG._autoPlayOffsets = CONFIG._autoPlayOffsets or {}
                CONFIG._autoPlayOffsets[_apSide] = CONFIG._autoPlayOffsets[_apSide] or {}
                CONFIG._autoPlayOffsets[_apSide][key] = { x = 0, z = 0 }
                -- Also persist BASE positions in config
                CONFIG._apBasePositions = CONFIG._apBasePositions or {}
                CONFIG._apBasePositions[_apSide] = CONFIG._apBasePositions[_apSide] or {}
                CONFIG._apBasePositions[_apSide][key] = { x = pos.X, y = pos.Y, z = pos.Z }
                saveConfig()
                -- Update label with new coords
                ptLbl.Text = "P" .. _idx .. " " .. math.floor(pos.X) .. ", " .. math.floor(pos.Z)
                ptLbl.TextColor3 = COLORS.Accent
                trackLabel(ptLbl)
                -- Flash button
                S.TweenService:Create(setBtn, tweenInfoFast, { BackgroundColor3 = COLORS.Accent }):Play()
                task.delay(0.3, function()
                    S.TweenService:Create(setBtn, tweenInfoFast, {
                        BackgroundColor3 = Color3.fromRGB(10, 40, 28)
                    }):Play()
                end)
                showPointToast("Point " .. _idx .. " set  ✅")
            end
        end)
    end

    -- ── DELAY ROW ─────────────────────────────────────────────────────────────
    local delayRow = Instance.new("Frame")
    delayRow.Size = UDim2.new(1, 0, 0, 32)
    delayRow.BackgroundColor3 = COLORS.Surface
    delayRow.BackgroundTransparency = 0.08
    delayRow.BorderSizePixel = 0
    delayRow.LayoutOrder = 6
    delayRow.Parent = apContent
    Instance.new("UICorner", delayRow).CornerRadius = UDim.new(0, 6)
    local drStroke = Instance.new("UIStroke", delayRow)
    drStroke.Color = COLORS.Accent
    drStroke.Thickness = 1
    drStroke.Transparency = 0.65
    drStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    trackStroke(drStroke)

    local delayLbl = Instance.new("TextLabel", delayRow)
    delayLbl.AutoLocalize = false
    delayLbl.Size = UDim2.new(1, -80, 1, 0)
    delayLbl.Position = UDim2.new(0, 10, 0, 0)
    delayLbl.BackgroundTransparency = 1
    delayLbl.Text = "Grab Delay"
    delayLbl.TextColor3 = COLORS.Accent
    trackLabel(delayLbl)
    delayLbl.Font = Enum.Font.GothamSemibold
    delayLbl.TextSize = 12
    delayLbl.TextXAlignment = Enum.TextXAlignment.Left

    local delayBox = Instance.new("TextBox", delayRow)
    delayBox.AutoLocalize = false
    delayBox.Size = UDim2.new(0, 60, 0, 22)
    delayBox.AnchorPoint = Vector2.new(1, 0.5)
    delayBox.Position = UDim2.new(1, -8, 0.5, 0)
    delayBox.BackgroundColor3 = COLORS.Background
    delayBox.BackgroundTransparency = 0.2
    delayBox.Text = tostring(CONFIG.AUTO_PLAY_DELAY or 0.03)
    delayBox.TextColor3 = COLORS.Accent
    trackLabel(delayBox)
    delayBox.Font = Enum.Font.GothamBold
    delayBox.TextSize = 11
    delayBox.ClearTextOnFocus = false
    delayBox.BorderSizePixel = 0
    delayBox.PlaceholderText = "0.01–0.1"
    delayBox.PlaceholderColor3 = COLORS.TextDim
    Instance.new("UICorner", delayBox).CornerRadius = UDim.new(0, 5)
    local dbStroke = Instance.new("UIStroke", delayBox)
    dbStroke.Color = COLORS.Accent
    dbStroke.Thickness = 1
    dbStroke.Transparency = 0.35
    dbStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    trackStroke(dbStroke)
    trackLabel(delayBox)

    delayBox.FocusLost:Connect(function()
        local v = tonumber(delayBox.Text)
        if v then
            CONFIG.AUTO_PLAY_DELAY = math.clamp(v, 0.01, 0.1)
        end
        delayBox.Text = tostring(CONFIG.AUTO_PLAY_DELAY)
        saveConfig()
    end)


    return tab
end

local function createBindsTab(parent)
    local tab = createEmptyTab(parent, "Binds")
    local scroll = createElement("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = COLORS.Accent,
        BorderSizePixel = 0,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        Parent = tab,
    })
    local scrollPad = Instance.new("UIPadding")
    scrollPad.PaddingLeft   = UDim.new(0, 6)
    scrollPad.PaddingRight  = UDim.new(0, 10)
    scrollPad.PaddingTop    = UDim.new(0, 6)
    scrollPad.PaddingBottom = UDim.new(0, 6)
    scrollPad.Parent = scroll
    local list = createElement("UIListLayout", {
        Padding = UDim.new(0, 10),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = scroll
    })

    local function kb(label, cfgKey, order)
        local w = createKeybindButton(scroll, label, CONFIG[cfgKey], function(key)
            CONFIG[cfgKey] = key; saveConfig()
        end)
        w.LayoutOrder = order
    end

    kb("Toggle GUI",    "TOGGLE_GUI_KEYBIND",   1)
    kb("Auto Bat",      "AUTO_BAT_KEYBIND",     2)
    kb("Aimbot",        "AIMBOT_KEYBIND",       3)
    kb("Spin Bot",      "SPINBOT_KEYBIND",      4)
    kb("Lock Target",   "LOCK_TARGET_KEYBIND",  5)
    kb("Drop Brainrot", "DROP_BRAINROT_KEYBIND", 6)
    kb("Float",         "FLOAT_KEYBIND",        7)
    kb("Auto Play",     "AUTO_PLAY_KEYBIND",    8)
    kb("Auto Walk",     "AUTO_WALK_KEYBIND",    9)
    kb("Fling",         "FLING_KEYBIND",        10)
    kb("Auto Lock",     "AUTO_LOCK_KEYBIND",    11)
    kb("Tp Down",       "TP_DOWN_KEYBIND",      12)
    kb("Speed Lagger",  "SPEED_LAGGER_KEYBIND", 13)
    kb("Desync",        "DESYNC_KEYBIND",       14)

    return tab
end

local function createPerformanceTab(parent)
    local tab = createEmptyTab(parent, "Performance")
    local scroll = createElement("ScrollingFrame", {  
        Size = UDim2.new(1, 0, 1, 0),  
        BackgroundTransparency = 1,  
        ScrollBarThickness = 4,  
        ScrollBarImageColor3 = COLORS.Accent,  
        BorderSizePixel = 0,  
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        Parent = tab,  
    })
    local scrollPad = Instance.new("UIPadding")
    scrollPad.PaddingLeft   = UDim.new(0, 6)
    scrollPad.PaddingRight  = UDim.new(0, 10)
    scrollPad.PaddingTop    = UDim.new(0, 6)
    scrollPad.PaddingBottom = UDim.new(0, 6)
    scrollPad.Parent = scroll
    local list = createElement("UIListLayout", { 
        Padding = UDim.new(0, 8), 
        SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        Parent = scroll 
    })

    -- ── VISUALS ───────────────────────────────────────────────────────────────
    local visContent, visWrapper = createCategory(scroll, "[Visuals]", true)
    visWrapper.LayoutOrder = 1

    local espToggle = createToggle(visContent, "Player ESP", CONFIG.ESP_ENABLED, function(state)
        CONFIG.ESP_ENABLED = state; espEnabled = state; saveConfig()
        if state then startESP() else stopESP() end
    end)
    espToggle.LayoutOrder = 1
    
    local xrayToggle = createToggle(visContent, "XRay", CONFIG.XRAY_ENABLED, function(state)
        CONFIG.XRAY_ENABLED = state; xrayEnabled = state; saveConfig()
        if state then startXRay() else stopXRay() end
    end)
    xrayToggle.LayoutOrder = 2

    local noCamCollisionToggle = createToggle(visContent, "No Cam Collision", CONFIG.NO_CAM_COLLISION_ENABLED, function(state)
        CONFIG.NO_CAM_COLLISION_ENABLED = state; saveConfig()
        if state then enableNoCameraCollision() else disableNoCameraCollision() end
    end)
    noCamCollisionToggle.LayoutOrder = 3

    local harderHitToggle = createToggle(visContent, "Harder Hit", CONFIG.HARDER_HIT_ENABLED, function(state)
        CONFIG.HARDER_HIT_ENABLED = state; saveConfig()
        if state then startHarderHitAnim() else stopHarderHitAnim() end
    end)
    harderHitToggle.LayoutOrder = 4

    -- ── PERFORMANCE ───────────────────────────────────────────────────────────
    local perfContent, perfWrapper = createCategory(scroll, "[Performance]", true)
    perfWrapper.LayoutOrder = 2
    
    local optimizerToggle = createToggle(perfContent, "Optimizer", CONFIG.OPTIMIZER_ENABLED, function(state)
        CONFIG.OPTIMIZER_ENABLED = state; optimizerEnabled = state; saveConfig()
        if state then startOptimizer() else stopOptimizer() end
    end)
    optimizerToggle.LayoutOrder = 1

    local noCollisionToggle = createToggle(perfContent, "No Player Collision", CONFIG.NO_COLLISION_ENABLED, function(state)
        CONFIG.NO_COLLISION_ENABLED = state; saveConfig()
        if state then startNoCollision() else stopNoCollision() end
    end)
    noCollisionToggle.LayoutOrder = 2

    local autoTpDownToggle = createToggle(perfContent, "Auto Tp Down (Float)", CONFIG.AUTO_TP_DOWN_ENABLED, function(state)
        CONFIG.AUTO_TP_DOWN_ENABLED = state; saveConfig()
        showNotification("Auto Tp Down", state)
    end)
    autoTpDownToggle.LayoutOrder = 3

    local mirrorTpDownToggle = createToggle(perfContent, "Mirror Tp Down", CONFIG.MIRROR_TP_DOWN_ENABLED, function(state)
        CONFIG.MIRROR_TP_DOWN_ENABLED = state
        saveConfig()
        showNotification("Mirror Tp Down", state)
    end)
    mirrorTpDownToggle.LayoutOrder = 4

    local laggerGuiToggle = createToggle(perfContent, "Server Lagger", CONFIG.LAGGER_GUI_VISIBLE, function(state)
        CONFIG.LAGGER_GUI_VISIBLE = state; saveConfig()
        if laggerGuiInstance then laggerGuiInstance.Enabled = state end
        if not state and _laggerEnabled then
            _laggerEnabled = false
            if _laggerLoopThread then
                pcall(function() task.cancel(_laggerLoopThread) end)
                _laggerLoopThread = nil
            end
        end
    end)
    laggerGuiToggle.LayoutOrder = 5

    local speedLaggerToggle = createToggle(perfContent, "Speed Lagger", CONFIG.SPEED_LAGGER_GUI_VISIBLE, function(state)
        CONFIG.SPEED_LAGGER_GUI_VISIBLE = state; saveConfig()
        if speedLaggerGuiInstance then speedLaggerGuiInstance.Enabled = state end
        if not state and _slEnabled then
            _slEnabled = false
            CONFIG.SPEED_LAGGER_ENABLED = false
            pcall(function()
                if _slRenderConn then _slRenderConn:Disconnect(); _slRenderConn = nil end
                if _slThread then task.cancel(_slThread); _slThread = nil end
            end)
            if _slWasSpeedOn then CONFIG.SPEED_ENABLED = true; _slWasSpeedOn = false end
        end
    end)
    speedLaggerToggle.LayoutOrder = 6

    return tab
end

local function createDuelTab(parent)
    local tab = createEmptyTab(parent, "Duel")
    local scroll = createElement("ScrollingFrame", {  
        Size = UDim2.new(1, 0, 1, 0),  
        BackgroundTransparency = 1,  
        ScrollBarThickness = 4,  
        ScrollBarImageColor3 = COLORS.Accent,  
        BorderSizePixel = 0,  
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        Parent = tab,  
    })
    -- Padding: right side keeps scrollbar from overlapping; top/bottom breathing room
    local scrollPad = Instance.new("UIPadding")
    scrollPad.PaddingLeft  = UDim.new(0, 6)
    scrollPad.PaddingRight = UDim.new(0, 10)
    scrollPad.PaddingTop   = UDim.new(0, 6)
    scrollPad.PaddingBottom = UDim.new(0, 6)
    scrollPad.Parent = scroll
    local list = createElement("UIListLayout", { 
        Padding = UDim.new(0, 8), 
        SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        Parent = scroll 
    })

    -- ── COMBAT ──────────────────────────────────────────────────────────────
    local combatContent, combatWrapper = createCategory(scroll, "[Combat]", true)
    combatWrapper.LayoutOrder = 1
    -- NOTE: createCategory already provides its own UIListLayout inside content
    
    local autoBatToggle, _autoBatBtn = createToggle(combatContent, "Auto Bat", CONFIG.AUTO_BAT_ENABLED, function(state)
        CONFIG.AUTO_BAT_ENABLED = state; attacking = state; saveConfig()
        if state then autoAttack() end
    end)
    autoBatToggle.LayoutOrder = 1
    table.insert(_duelToggleBtns, {btn=_autoBatBtn, default=false})
    
    -- Aimbot and Spinbot are mutually exclusive.
    -- We build them manually so each can reference the other's button.

    local function makeMutualToggle(parent, labelText, initState, lo)
        local container = createElement("Frame", {
            Size = UDim2.new(1, 0, 0, 34),
            BackgroundColor3 = COLORS.Surface,
            BackgroundTransparency = COLORS.SurfaceTransparency,
            BorderSizePixel = 0,
            LayoutOrder = lo,
            Parent = parent,
        })
        createElement("UICorner", { CornerRadius = UDim.new(0, 6), Parent = container })
        trackStroke(createElement("UIStroke", { Color = COLORS.Accent, Thickness = 1, Transparency = 0.5,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = container }))
        createElement("TextLabel", {
            Size = UDim2.new(1, -78, 1, 0),
            Position = UDim2.new(0, 10, 0, 0),
            BackgroundTransparency = 1,
            Text = labelText,
            TextColor3 = COLORS.Accent,
            TextSize = 13,
            Font = Enum.Font.GothamSemibold,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = container,
        })
        trackLabel(container)
        local btn = createElement("TextButton", {
            Size = UDim2.new(0, 52, 0, 24),
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -8, 0.5, 0),
            BackgroundColor3 = initState and COLORS.Accent or COLORS.Background,
            BackgroundTransparency = 0.2,
            Text = initState and "ON" or "OFF",
            TextColor3 = COLORS.Accent,
            TextSize = 12,
            Font = Enum.Font.GothamBold,
            BorderSizePixel = 0,
            Parent = container,
        })
        trackLabel(btn)
        createElement("UICorner", { CornerRadius = UDim.new(0, 4), Parent = btn })
        trackStroke(createElement("UIStroke", { Color = COLORS.Accent, Thickness = 1, Transparency = 0.3, Parent = btn }))
        if initState then table.insert(_accentFrames, btn) end
        return container, btn
    end


    local aimbotToggle,  _aimbotBtnLocal  = makeMutualToggle(combatContent, "Aimbot",   CONFIG.AIMBOT_ENABLED, 2)
    local spinbotToggle, _spinbotBtnLocal = makeMutualToggle(combatContent, "Spin Bot", CONFIG.SPINBOT_ENABLED, 3)
    _aimbotBtn  = _aimbotBtnLocal
    _spinbotBtn = _spinbotBtnLocal
    table.insert(_duelToggleBtns, {btn=_aimbotBtn,  default=false})
    table.insert(_duelToggleBtns, {btn=_spinbotBtn, default=false})
    -- Hide spinbot from Combat UI (keep internal ref for mutual exclusion logic)
    spinbotToggle.Visible = false
    spinbotToggle.Size    = UDim2.new(0, 0, 0, 0)

    _aimbotBtn.MouseButton1Click:Connect(function()
        local newState = not CONFIG.AIMBOT_ENABLED
        -- mutual exclusion: aimbot ON → force spinbot OFF
        if newState and CONFIG.SPINBOT_ENABLED then
            CONFIG.SPINBOT_ENABLED = false
            spinbotEnabled = false
            stopSpinBot()
            saveConfig()
            setToggleVisual(_spinbotBtn, false)
            showNotification("Spin Bot", false)
        end
        -- mutual exclusion: aimbot ON → force lock target OFF
        if newState and CONFIG.LOCK_TARGET_ENABLED then
            CONFIG.LOCK_TARGET_ENABLED = false
            lockTargetEnabled = false
            stopLockTarget()
            if lockTargetPanelBtn then
                lockTargetPanelBtn.Text = "LOCK: OFF"
            end
            showNotification("Lock Target", false)
        end
        CONFIG.AIMBOT_ENABLED = newState
        aimbotEnabled = newState
        saveConfig()
        setToggleVisual(_aimbotBtn, newState)
        showNotification("Aimbot", newState)
        if newState then startBodyAimbot() else stopBodyAimbot() end
    end)

    _spinbotBtn.MouseButton1Click:Connect(function()
        local newState = not CONFIG.SPINBOT_ENABLED
        -- If turning ON spinbot while aimbot is ON → force aimbot OFF first
        if newState and CONFIG.AIMBOT_ENABLED then
            CONFIG.AIMBOT_ENABLED = false
            aimbotEnabled = false
            stopBodyAimbot()
            saveConfig()
            setToggleVisual(_aimbotBtn, false)
            showNotification("Aimbot", false)
        end
        CONFIG.SPINBOT_ENABLED = newState
        spinbotEnabled = newState
        saveConfig()
        setToggleVisual(_spinbotBtn, newState)
        showNotification("Spin Bot", newState)
        if newState then startSpinBot() else stopSpinBot() end
    end)

    local antiRagdollToggle, _antiRagBtn = createToggle(combatContent, "Anti Ragdoll", CONFIG.ANTIRAGDOLL_ENABLED, function(state)
        CONFIG.ANTIRAGDOLL_ENABLED = state; saveConfig(); toggleAntiRagdoll(state)
    end)
    antiRagdollToggle.LayoutOrder = 4
    table.insert(_duelToggleBtns, {btn=_antiRagBtn, default=false})

    local antiRagdollV2Toggle, _antiRagV2Btn = createToggle(combatContent, "Anti Ragdoll V2", CONFIG.ANTIRAGDOLL_V2_ENABLED, function(state)
        CONFIG.ANTIRAGDOLL_V2_ENABLED = state; saveConfig(); toggleAntiRagdollV2(state)
    end)
    antiRagdollV2Toggle.LayoutOrder = 45
    table.insert(_duelToggleBtns, {btn=_antiRagV2Btn, default=false})

    local antiLockPanelToggle, _antiLockBtn2 = createToggle(combatContent, "Anti Lock", CONFIG.ANTI_LOCK_PANEL_VISIBLE, function(state)
        CONFIG.ANTI_LOCK_PANEL_VISIBLE = state; saveConfig()
        if antiLockPanelGui then antiLockPanelGui.Enabled = state end
        if not state and antiLockEnabled then
            antiLockEnabled = false
            CONFIG.ANTI_LOCK_ENABLED = false
            if antiLockPanelBtn then
                antiLockPanelBtn.Text = "ANTI LOCK: OFF"
            end
        end
    end)
    antiLockPanelToggle.LayoutOrder = 46
    table.insert(_duelToggleBtns, {btn=_antiLockBtn2, default=false})

    local antiDieToggle, _antiDieBtn = createToggle(combatContent, "Anti Die", CONFIG.ANTI_DIE_ENABLED, function(state)
        CONFIG.ANTI_DIE_ENABLED = state; antiDieEnabled = state; saveConfig()
        if state then activateAntiDie() else deactivateAntiDie() end
    end)
    antiDieToggle.LayoutOrder = 5
    table.insert(_duelToggleBtns, {btn=_antiDieBtn, default=true})  -- default ON

    -- ── MOBILITY ─────────────────────────────────────────────────────────────
    local mobContent, mobWrapper = createCategory(scroll, "[Mobility]", true)
    mobWrapper.LayoutOrder = 2

    local unwalkToggle, _unwalkBtn = createToggle(mobContent, "Unwalk", CONFIG.UNWALK_ENABLED, function(state)
        CONFIG.UNWALK_ENABLED = state; unwalkEnabled = state; saveConfig()
        if state then startUnwalk() else stopUnwalk() end
    end)
    unwalkToggle.LayoutOrder = 1
    table.insert(_duelToggleBtns, {btn=_unwalkBtn, default=false})

    local infJumpToggle, _infJumpBtn = createToggle(mobContent, "Infinity Jump", CONFIG.INF_JUMP_ENABLED, function(state)
        CONFIG.INF_JUMP_ENABLED = state; infJumpEnabled = state; saveConfig()
        if state then startInfJump() else stopInfJump() end
    end)
    infJumpToggle.LayoutOrder = 2
    table.insert(_duelToggleBtns, {btn=_infJumpBtn, default=false})

    local floatPanelToggle, _floatBtn = createToggle(mobContent, "Float", CONFIG.FLOAT_PANEL_VISIBLE, function(state)
        CONFIG.FLOAT_PANEL_VISIBLE = state
        saveConfig()
        if floatPanelGui then floatPanelGui.Enabled = state end
        if state then
            if CONFIG.FLOAT_ACTIVE then startFloat() end
        else
            if _FLT.enabled then stopFloat() end
        end
    end)
    floatPanelToggle.LayoutOrder = 3
    table.insert(_duelToggleBtns, {btn=_floatBtn, default=false})

    local flingPanelToggle, _flingBtn = createToggle(mobContent, "Fling", CONFIG.FLING_PANEL_VISIBLE, function(state)
        CONFIG.FLING_PANEL_VISIBLE = state; saveConfig()
        if flingPanelGui then flingPanelGui.Enabled = state end
    end)
    flingPanelToggle.LayoutOrder = 4
    table.insert(_duelToggleBtns, {btn=_flingBtn, default=false})

    local autoWalkPanelToggle, _autoWalkBtn = createToggle(mobContent, "Auto Walk", CONFIG.AUTO_WALK_PANEL_VISIBLE, function(state)
        CONFIG.AUTO_WALK_PANEL_VISIBLE = state; saveConfig()
        if awGuiInstance then awGuiInstance.Enabled = state end
        if not state then awStopLoop(); AW.enabled = false end
    end)
    autoWalkPanelToggle.LayoutOrder = 5
    table.insert(_duelToggleBtns, {btn=_autoWalkBtn, default=false})

    local tpDownToggle, _tpDownBtn = createToggle(mobContent, "Tp Down", CONFIG.TP_DOWN_PANEL_VISIBLE, function(state)
        CONFIG.TP_DOWN_PANEL_VISIBLE = state; saveConfig()
        if tpDownPanelGui then tpDownPanelGui.Enabled = state end
    end)
    tpDownToggle.LayoutOrder = 6
    table.insert(_duelToggleBtns, {btn=_tpDownBtn, default=false})

    -- ── TOOLS ────────────────────────────────────────────────────────────────
    local toolsContent, toolsWrapper = createCategory(scroll, "[Tools]", true)
    toolsWrapper.LayoutOrder = 3

    local autoMedusaToggle, _autoMedBtn = createToggle(toolsContent, "Auto Medusa", CONFIG.AUTO_MEDUSA_ENABLED, function(state)
        CONFIG.AUTO_MEDUSA_ENABLED = state; autoMedusaEnabled = state; saveConfig()
        if state then startAutoMedusa() else stopAutoMedusa() end
    end)
    autoMedusaToggle.LayoutOrder = 1
    table.insert(_duelToggleBtns, {btn=_autoMedBtn, default=false})

    local medusaCounterToggle, _medCtrBtn = createToggle(toolsContent, "Medusa Counter", CONFIG.MEDUSA_COUNTER_ENABLED, function(state)
        CONFIG.MEDUSA_COUNTER_ENABLED = state; medusaCounterEnabled = state; saveConfig()
        if state then setupMedusaCounter(character) else stopMedusaCounter() end
    end)
    medusaCounterToggle.LayoutOrder = 2
    table.insert(_duelToggleBtns, {btn=_medCtrBtn, default=false})

    local instantGrabToggle, _igBtn = createToggle(toolsContent, "Instant Grab", CONFIG.INSTANT_GRAB_ENABLED, function(state)
        CONFIG.INSTANT_GRAB_ENABLED = state; instantGrabEnabled = state; saveConfig()
        if state then startInstantGrab() else stopInstantGrab() end
    end)
    instantGrabToggle.LayoutOrder = 3
    table.insert(_duelToggleBtns, {btn=_igBtn, default=false})

    local dropBrainrotPanelToggle, _dropBtn = createToggle(toolsContent, "Drop Brainrot", CONFIG.DROP_BRAINROT_PANEL_VISIBLE, function(state)
        CONFIG.DROP_BRAINROT_PANEL_VISIBLE = state; saveConfig()
        if dropBrainrotPanelGui then dropBrainrotPanelGui.Enabled = state end
    end)
    dropBrainrotPanelToggle.LayoutOrder = 4
    table.insert(_duelToggleBtns, {btn=_dropBtn, default=false})

    local lockTargetPanelToggle, _ltBtn = createToggle(toolsContent, "Lock Target", CONFIG.LOCK_TARGET_PANEL_VISIBLE, function(state)
        CONFIG.LOCK_TARGET_PANEL_VISIBLE = state; saveConfig()
        if lockTargetPanelGui then lockTargetPanelGui.Enabled = state end
    end)
    lockTargetPanelToggle.LayoutOrder = 5
    table.insert(_duelToggleBtns, {btn=_ltBtn, default=false})

    local speedGuiToggle, _speedGuiBtn = createToggle(toolsContent, "Speed Booster", CONFIG.SPEED_GUI_VISIBLE, function(state)
        CONFIG.SPEED_GUI_VISIBLE = state; speedGuiEnabled = state; saveConfig()
        if speedGuiInstance then speedGuiInstance.Enabled = state end
    end)
    speedGuiToggle.LayoutOrder = 6

    local autoPlayGuiToggle, _apGuiBtn = createToggle(toolsContent, "Auto Play", CONFIG.AUTO_PLAY_GUI_VISIBLE, function(state)
        CONFIG.AUTO_PLAY_GUI_VISIBLE = state; saveConfig()
        if apGuiInstance then apGuiInstance.Enabled = state end
        if not state and AP.enabled then apStopLoop() end
    end)
    autoPlayGuiToggle.LayoutOrder = 7
    table.insert(_duelToggleBtns, {btn=_apGuiBtn, default=false})

    local spinbotPanelToggle, _sbPanelBtn = createToggle(toolsContent, "Spin Bot", CONFIG.SPINBOT_PANEL_VISIBLE, function(state)
        CONFIG.SPINBOT_PANEL_VISIBLE = state; saveConfig()
        if spinbotPanelGui then spinbotPanelGui.Enabled = state end
        if not state and CONFIG.SPINBOT_ENABLED then
            CONFIG.SPINBOT_ENABLED = false; spinbotEnabled = false
            stopSpinBot()
            if spinbotPanelBtn then
                spinbotPanelBtn.Text = "SPIN: OFF"
            end
        end
    end)
    spinbotPanelToggle.LayoutOrder = 8
    table.insert(_duelToggleBtns, {btn=_sbPanelBtn, default=false})

    local tauntPanelToggle, _tauntBtn = createToggle(toolsContent, "Taunt", CONFIG.TAUNT_PANEL_VISIBLE, function(state)
        CONFIG.TAUNT_PANEL_VISIBLE = state; saveConfig()
        if tauntPanelGui then tauntPanelGui.Enabled = state end
    end)
    tauntPanelToggle.LayoutOrder = 9
    table.insert(_duelToggleBtns, {btn=_tauntBtn, default=false})

    local antiStealToggle, _asBtn = createToggle(toolsContent, "Anti Steal", CONFIG.ANTI_STEAL_PANEL_VISIBLE, function(state)
        CONFIG.ANTI_STEAL_PANEL_VISIBLE = state
        antiStealEnabled = state
        saveConfig()
        if state then startAntiStealWatcher() else stopAntiStealWatcher() end
    end)
    antiStealToggle.LayoutOrder = 10
    table.insert(_duelToggleBtns, {btn=_asBtn, default=false})

    local autoLockToggle, _alBtn = createToggle(toolsContent, "Auto Lock", CONFIG.AUTO_LOCK_PANEL_VISIBLE, function(state)
        CONFIG.AUTO_LOCK_PANEL_VISIBLE = state
        autoLockEnabled2 = state
        saveConfig()
        if state then startAutoLockWatcher() else stopAutoLockWatcher() end
    end)
    autoLockToggle.LayoutOrder = 11
    table.insert(_duelToggleBtns, {btn=_alBtn, default=false})

    local desyncToggle, _dsTogBtn = createToggle(toolsContent, "Desync", CONFIG.DESYNC_PANEL_VISIBLE, function(state)
        CONFIG.DESYNC_PANEL_VISIBLE = state; saveConfig()
        if desyncPanelGui then desyncPanelGui.Enabled = state end
    end)
    desyncToggle.LayoutOrder = 12
    table.insert(_duelToggleBtns, {btn=_dsTogBtn, default=false})

    local autoReactToggle, _arBtn = createToggle(toolsContent, "Auto React Steal", CONFIG.AUTO_REACT_STEAL_ENABLED, function(state)
        CONFIG.AUTO_REACT_STEAL_ENABLED = state
        autoReactStealEnabled = state
        saveConfig()
        if state then startAutoReactStealWatcher() else stopAutoReactStealWatcher() end
    end)
    autoReactToggle.LayoutOrder = 13
    table.insert(_duelToggleBtns, {btn=_arBtn, default=false})



    -- ── RESET CONFIG ─────────────────────────────────────────────────────────
    local resetWrapper = createElement("Frame", {
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundTransparency = 1,
        LayoutOrder = 99,
        Parent = scroll,
    })
    local resetPad = Instance.new("UIPadding", resetWrapper)
    resetPad.PaddingLeft  = UDim.new(0, 6)
    resetPad.PaddingRight = UDim.new(0, 6)

    local resetBtn = Instance.new("TextButton", resetWrapper)
    resetBtn.AutoLocalize = false
    resetBtn.Size = UDim2.new(1, 0, 1, 0)
    resetBtn.BackgroundColor3 = COLORS.Surface
    resetBtn.BackgroundTransparency = 0.05
    resetBtn.BorderSizePixel = 0
    resetBtn.Text = "[ Reset Config ]"
    resetBtn.TextColor3 = COLORS.Red
    resetBtn.Font = Enum.Font.GothamBold
    resetBtn.TextSize = 12
    Instance.new("UICorner", resetBtn).CornerRadius = UDim.new(0, 6)
    local resetStroke = Instance.new("UIStroke", resetBtn)
    resetStroke.Color = COLORS.Red
    resetStroke.Thickness = 1
    resetStroke.Transparency = 0.4
    resetStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    resetBtn.MouseButton1Click:Connect(function()
        -- Visual flash
        S.TweenService:Create(resetBtn, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {
            BackgroundColor3 = COLORS.Red, BackgroundTransparency = 0.1
        }):Play()
        resetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        task.delay(0.25, function()
            S.TweenService:Create(resetBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                BackgroundColor3 = COLORS.Surface, BackgroundTransparency = 0.05
            }):Play()
            resetBtn.TextColor3 = COLORS.Red
        end)

        -- Stop all systems
        pcall(stopBodyAimbot)
        pcall(stopSpinBot)
        pcall(stopUnwalk)
        -- Only stop ESP if desync is not active (ESP is desync-owned when desync is on)
        if not CONFIG.DESYNC_ENABLED then
            pcall(stopESP)
        end
        pcall(stopLockTarget)
        pcall(stopInfJump)
        pcall(stopOptimizer)
        pcall(stopXRay)
        pcall(stopAutoMedusa)
        pcall(stopMedusaCounter)
        pcall(stopInstantGrab)
        pcall(stopNoCollision)
        pcall(disableNoCameraCollision)
        pcall(stopHarderHitAnim)
        pcall(deactivateAntiDie)
        pcall(stopAutoReactStealWatcher)
        pcall(stopAntiStealWatcher)
        pcall(stopAutoLockWatcher)
        pcall(function()
            _slEnabled = false; CONFIG.SPEED_LAGGER_ENABLED = false
            if _slRenderConn then _slRenderConn:Disconnect(); _slRenderConn = nil end
            if _slThread then task.cancel(_slThread); _slThread = nil end
            if _slWasSpeedOn then CONFIG.SPEED_ENABLED = true; _slWasSpeedOn = false end
        end)
        pcall(apStopLoop)
        pcall(awStopLoop)
        pcall(stopFling)
        pcall(toggleDesync, false)
        pcall(disableServerPos)
        pcall(stopAntiRagdollV2)
        pcall(disconnectAllAntiRagdoll)
        pcall(toggleSpeedMeter, false)

        -- Reset CONFIG to defaults (speed booster NOT touched)
        local defaults = {
            LOCK_TARGET_PANEL_VISIBLE=false, DROP_BRAINROT_PANEL_VISIBLE=false,
            FLING_PANEL_VISIBLE=false,
            FLOAT_PANEL_VISIBLE=false, FLOAT_ACTIVE=false,
            SPINBOT_PANEL_VISIBLE=false, TAUNT_PANEL_VISIBLE=false,
            ANTI_STEAL_PANEL_VISIBLE=false, AUTO_LOCK_PANEL_VISIBLE=false,
            TP_DOWN_PANEL_VISIBLE=false, AUTO_WALK_PANEL_VISIBLE=false,
            AUTO_PLAY_GUI_VISIBLE=false, DESYNC_PANEL_VISIBLE=false,
            LAGGER_GUI_VISIBLE=false,
            ACTIVE_HUD_VISIBLE=false, GRAB_BAR_VISIBLE=true,
            AUTO_BAT_ENABLED=false, AIMBOT_ENABLED=false, SPINBOT_ENABLED=false,
            ANTIRAGDOLL_ENABLED=false, ANTIRAGDOLL_V2_ENABLED=false,
            UNWALK_ENABLED=false, ESP_ENABLED=false, INF_JUMP_ENABLED=false,
            OPTIMIZER_ENABLED=false, XRAY_ENABLED=false, LOCK_TARGET_ENABLED=false,
            AUTO_MEDUSA_ENABLED=false, MEDUSA_COUNTER_ENABLED=false,
            INSTANT_GRAB_ENABLED=false, ANTI_DIE_ENABLED=true, UI_LOCKED=false,
            NO_COLLISION_ENABLED=false,
            NO_CAM_COLLISION_ENABLED=false, HARDER_HIT_ENABLED=false,
            TP_DOWN_ENABLED=false, AUTO_TP_DOWN_ENABLED=false,
            DESYNC_ENABLED=false, AUTO_REACT_STEAL_ENABLED=false,
            ANTI_STEAL_PANEL_VISIBLE=false, AUTO_LOCK_PANEL_VISIBLE=false,
            FAST_PANEL_ENABLED=false, SPEED_METER_ENABLED=false,
            NOTIFICATIONS_ENABLED=false, FOV_LOCK_ENABLED=false,
            POST_DROP_HALT_ENABLED=false, SNAP_LOCK_ENABLED=false,
            SPEED_LAGGER_GUI_VISIBLE=false, SPEED_LAGGER_ENABLED=false,
            AIMBOT_RANGE=40, AIMBOT_DISABLE_RANGE=45,
            SPINBOT_SPEED=30, LOCK_TARGET_SPEED=55,
            LOCK_TARGET_3D_DISTANCE=10, AUTO_MEDUSA_RANGE=5,
            INSTANT_GRAB_ACTIVATION_DIST=8, FLOAT_HEIGHT=10,
            FLOAT_SPEED=50, FOV_VALUE=70,
            _guiPositions=nil, _autoPlayOffsets=nil, _apBasePositions=nil,
        }
        for k, v in pairs(defaults) do CONFIG[k] = v end

        -- ── Reset Speed GUI preset back to "normal" and refresh boxes ────────
        CONFIG.SPEED_PRESET = "normal"
        CONFIG.SPEED_VALUE       = CONFIG.PRESET_NORMAL_SPEED
        CONFIG.STEAL_SPEED_VALUE = CONFIG.PRESET_NORMAL_STEAL
        if _speedValBox  then _speedValBox.Text  = tostring(CONFIG.SPEED_VALUE) end
        if _stealValBox  then _stealValBox.Text  = tostring(CONFIG.STEAL_SPEED_VALUE) end

        -- ── Reset Lagger GUI boxes ───────────────────────────────────────────
        CONFIG.LAGGER_SPAM  = 270
        CONFIG.LAGGER_TRIES = 1
        CONFIG.LAGGER_DELAY = 0.3
        if _lagSpamBox   then _lagSpamBox.Text  = tostring(CONFIG.LAGGER_SPAM) end
        if _lagTriesBox  then _lagTriesBox.Text = tostring(CONFIG.LAGGER_TRIES) end
        if _lagDelayBox  then _lagDelayBox.Text = string.format("%.1f", CONFIG.LAGGER_DELAY) end

        -- ── Reset Speed Lagger GUI boxes ─────────────────────────────────────
        CONFIG.SPEED_LAGGER_LAG   = 50
        CONFIG.SPEED_LAGGER_SPEED = 50
        if _slLagBox   then _slLagBox.Text   = tostring(CONFIG.SPEED_LAGGER_LAG) end
        if _slSpeedBox then _slSpeedBox.Text = tostring(CONFIG.SPEED_LAGGER_SPEED) end

        -- Restore default-on systems
        activateAntiDie(); antiDieEnabled = true
        antiStealEnabled = false
        autoLockEnabled2 = false
        antiLockEnabled  = false
        CONFIG.ANTI_LOCK_ENABLED = false
        pcall(function()
            if antiLockPanelBtn then
                antiLockPanelBtn.Text = "ANTI LOCK: OFF"
            end
        end)

        -- ── Visually reset ALL duel tab toggles ──────────────────────────────
        for _, entry in ipairs(_duelToggleBtns) do
            pcall(setToggleVisual, entry.btn, entry.default)
        end

        -- ── Hide all floating panels and buttons ─────────────────────────────
        pcall(function()
            if _fastPanelBurgerFrame then _fastPanelBurgerFrame.Visible = false end
            if _FP.gui  then _FP.gui.Enabled  = false end
            if _FP.guiR then _FP.guiR.Enabled = false end
            _FP.visible = false
        end)
        for _, gui in ipairs({
            lockTargetPanelGui, dropBrainrotPanelGui, floatPanelGui,
            spinbotPanelGui, tauntPanelGui, flingPanelGui,
            tpDownPanelGui, antiLockPanelGui, awGuiInstance, apGuiInstance,
            desyncPanelGui, laggerGuiInstance, speedLaggerGuiInstance,
        }) do
            pcall(function() if gui then gui.Enabled = false end end)
        end
        -- Stop lagger if running
        _laggerEnabled = false
        if _laggerLoopThread then
            pcall(function() task.cancel(_laggerLoopThread) end)
            _laggerLoopThread = nil
        end

        -- ── Reset ALL registered GUI positions to defaults ───────────────────
        task.defer(function()
            for _, reg in ipairs(_draggableRegistry) do
                pcall(function()
                    if reg.frame and reg.frame.Parent then
                        reg.frame.Position = reg.defaultFn()
                    end
                end)
            end
            -- Also reset mainFrame to center
            if mainFrame and mainFrame.Parent then
                local vp = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920,1080)
                local mw = mainFrame and mainFrame.AbsoluteSize.X or 450
                local mh = mainFrame and mainFrame.AbsoluteSize.Y or 500
                mainFrame.Position = UDim2.fromOffset(
                    math.floor((vp.X - mw) / 2),
                    math.floor((vp.Y - mh) / 2)
                )
                CONFIG._guiPositions = CONFIG._guiPositions or {}
                CONFIG._guiPositions["main"] = {
                    scaleX=0, scaleY=0,
                    offsetX=mainFrame.Position.X.Offset,
                    offsetY=mainFrame.Position.Y.Offset,
                }
            end
        end)

        saveConfig()
        showNotification("Config Reset", false)
    end)

    return tab
end

-- ======================================
-- MAIN GUI CREATION
-- ======================================

local function toggleGui()
    guiVisible = not guiVisible
    if mainFrame then mainFrame.Visible = guiVisible end
    CONFIG.MAIN_GUI_VISIBLE = guiVisible
    saveConfig()
end

local function createGui()
    screenGui = createElement("ScreenGui", {
        Name = "LooprixV2",
        ResetOnSpawn = false,
        DisplayOrder = 999999,
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        Parent = S.PlayerGui,
    })
    local isMobile = S.UserInputService.TouchEnabled and not S.UserInputService.KeyboardEnabled  
    local isTablet = S.UserInputService.TouchEnabled and workspace.CurrentCamera.ViewportSize.X >= 768  
    local screenSize = workspace.CurrentCamera.ViewportSize  
    local function getScaleFactor()  
        local baseWidth = 1920  
        local currentWidth = screenSize.X  
        local scaleFactor = math.clamp(currentWidth / baseWidth, 0.5, 1.2)  
        if isMobile and not isTablet then return math.clamp(scaleFactor * 0.85, 0.6, 0.9)  
        elseif isTablet then return math.clamp(scaleFactor * 1.0, 0.8, 1.1)  
        else return scaleFactor end  
    end  
    local globalScale = getScaleFactor()  

    local mainWidth = isMobile and 360 or (isTablet and 420 or 450)  
    local mainHeight = isMobile and 420 or (isTablet and 480 or 500)  
    local titleHeight = 50  
    
    mainFrame = createElement("Frame", {  
        Name = "MainFrame",  
        Size = UDim2.new(0, mainWidth, 0, mainHeight),  
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = COLORS.Background,  
        BackgroundTransparency = COLORS.BackgroundTransparency,  
        BorderSizePixel = 0,  
        ClipsDescendants = true,  
        Parent = screenGui,  
    })
    
    -- Load saved position; if none, default to true screen center
    mainFrame.AnchorPoint = Vector2.new(0, 0)
    loadAndClampPosition(mainFrame, "main", UDim2.new(0.5, -mainWidth/2, 0.5, -mainHeight/2))
    _regDraggable(mainFrame, function()
        local vp = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920,1080)
        return UDim2.fromOffset(math.floor((vp.X - mainWidth)/2), math.floor((vp.Y - mainHeight)/2))
    end)
    
    createElement("UICorner", { CornerRadius = UDim.new(0, 8), Parent = mainFrame })  
    trackStroke(createElement("UIStroke", { Color = COLORS.Accent, Thickness = 2, Transparency = 0.1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = mainFrame }))

    -- ── Unified UIScale — controlled by the UI Scale slider in Settings ───────
    -- base = getScaleFactor() on mobile/tablet (original behaviour), 1.0 on desktop.
    -- At slider=100 (multiplier 1.0) the frame looks exactly like the original.
    local _mainFrameBase = (isMobile or isTablet) and globalScale or 1.0
    registerScaleTarget(mainFrame, _mainFrameBase)
    -- For mobile: keep viewport-based rescaling on top of the user's chosen scale
    if isMobile or isTablet then
        workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
            applyUIScale(scaleMultiplier)  -- re-broadcast so mobile layout stays consistent
        end)
    end
    local titleBar = createElement("Frame", {  
        Size = UDim2.new(1, 0, 0, titleHeight),  
        BackgroundColor3 = COLORS.Surface,  
        BackgroundTransparency = 0.3,  
        BorderSizePixel = 0,  
        Parent = mainFrame,  
    })  
    createElement("UICorner", { CornerRadius = UDim.new(0, 8), Parent = titleBar })  
    local mainTitle = createElement("TextLabel", {
        Size = UDim2.new(1, -80, 1, 0),
        Position = UDim2.new(0, 15, 0, 0),
        BackgroundTransparency = 1,
        Text = "Looprix Hub",
        TextColor3 = COLORS.Accent,
        TextSize = 18,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = titleBar,
    })
    trackLabel(mainTitle)
    local minBtn = createElement("TextButton", {
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -45, 0.5, -15),
        BackgroundColor3 = COLORS.Background,
        BackgroundTransparency = 0.5,  
        Text = "-",  
        TextColor3 = COLORS.Accent,  
        TextSize = 20,  
        Font = Enum.Font.GothamBold,  
        BorderSizePixel = 0,  
        Parent = titleBar,  
    })  
    trackLabel(minBtn)
    createElement("UICorner", { CornerRadius = UDim.new(0, 6), Parent = minBtn })
    trackStroke(createElement("UIStroke", { Color = COLORS.Accent, Thickness = 1, Transparency = 0.5, Parent = minBtn }))
    trackLabel(minBtn)
    tabBar = createElement("Frame", {  
        Size = UDim2.new(1, -20, 0, 40),  
        Position = UDim2.new(0, 10, 0, titleHeight + 8),  
        BackgroundColor3 = COLORS.Surface,  
        BackgroundTransparency = 0.5,  
        BorderSizePixel = 0,  
        Parent = mainFrame,  
    })  
    createElement("UICorner", { CornerRadius = UDim.new(0, 6), Parent = tabBar })
    trackStroke(createElement("UIStroke", { Color = COLORS.Accent, Thickness = 1, Transparency = 0.5, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = tabBar }))

    local tabButtons = {}
    local tabNames = { "Duel", "Performance", "Settings", "Binds" }
    local tabIds = { "duel", "performance", "settings", "binds" }
    local numTabs = #tabNames
    local tabWidth = (1 / numTabs)
    for i, tabName in ipairs(tabNames) do
        local isActive = (currentTab == tabIds[i])
        local tabBtn = createElement("TextButton", {
            Size = UDim2.new(tabWidth, 0, 1, 0),
            Position = UDim2.new(tabWidth * (i - 1), 0, 0, 0),
            BackgroundTransparency = 1,
            Text = tabName,
            TextColor3 = isActive and COLORS.Accent or COLORS.TextDim,
            TextSize = 13,
            Font = Enum.Font.GothamBold,
            BorderSizePixel = 0,
            Parent = tabBar,
        })
        if isActive then trackLabel(tabBtn) end
        tabButtons[tabIds[i]] = tabBtn
    end  

    -- ── User Profile Bar (K7-style) ────────────────────────────────────────
    local userInfoBar = createElement("Frame", {
        Size = UDim2.new(1, -20, 0, 54),
        Position = UDim2.new(0, 10, 1, -64),
        BackgroundColor3 = COLORS.Surface,
        BackgroundTransparency = 0.05,
        BorderSizePixel = 0,
        Parent = mainFrame,
        ZIndex = 3,
    })
    createElement("UICorner", { CornerRadius = UDim.new(0, 8), Parent = userInfoBar })
    trackStroke(createElement("UIStroke", {
        Color = COLORS.Accent, Thickness = 1, Transparency = 0.6,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = userInfoBar
    }))
    local avatarImg = Instance.new("ImageLabel", userInfoBar)
    avatarImg.Size = UDim2.new(0, 40, 0, 40)
    avatarImg.Position = UDim2.new(0, 8, 0.5, -20)
    avatarImg.BackgroundColor3 = COLORS.Background
    avatarImg.BackgroundTransparency = 0.3
    avatarImg.BorderSizePixel = 0
    avatarImg.Image = "https://www.roblox.com/headshot-thumbnail/image?userId="..S.LocalPlayer.UserId.."&width=150&height=150&format=png"
    avatarImg.ZIndex = 4
    Instance.new("UICorner", avatarImg).CornerRadius = UDim.new(1, 0)
    trackStroke(createElement("UIStroke", { Color = COLORS.Accent, Thickness = 1.5, Parent = avatarImg }))
    local userNameLbl = Instance.new("TextLabel", userInfoBar)
    userNameLbl.AutoLocalize = false
    userNameLbl.Size = UDim2.new(1, -150, 0, 20)
    userNameLbl.Position = UDim2.new(0, 56, 0, 9)
    userNameLbl.BackgroundTransparency = 1
    userNameLbl.Text = S.LocalPlayer.Name
    userNameLbl.TextColor3 = COLORS.Text
    userNameLbl.Font = Enum.Font.GothamBlack
    userNameLbl.TextSize = 13
    userNameLbl.TextXAlignment = Enum.TextXAlignment.Left
    userNameLbl.TextTruncate = Enum.TextTruncate.AtEnd
    userNameLbl.ZIndex = 4
    local buyerBadge = Instance.new("Frame", userInfoBar)
    buyerBadge.Size = UDim2.new(0, 90, 0, 38)
    buyerBadge.Position = UDim2.new(1, -98, 0.5, -19)
    buyerBadge.BackgroundColor3 = COLORS.Background
    buyerBadge.BackgroundTransparency = 0.2
    buyerBadge.BorderSizePixel = 0
    buyerBadge.ZIndex = 4
    Instance.new("UICorner", buyerBadge).CornerRadius = UDim.new(0, 9)
    trackStroke(createElement("UIStroke", { Color = COLORS.Accent, Thickness = 1, Parent = buyerBadge }))
    local bbDot = Instance.new("Frame", buyerBadge)
    bbDot.Size = UDim2.new(0, 6, 0, 6)
    bbDot.Position = UDim2.new(0, 8, 0, 8)
    bbDot.BackgroundColor3 = COLORS.Accent
    bbDot.BorderSizePixel = 0
    bbDot.ZIndex = 5
    Instance.new("UICorner", bbDot).CornerRadius = UDim.new(1, 0)
    trackDot(bbDot)
    -- "Buyer" — main text, top
    local bbBuyer = Instance.new("TextLabel", buyerBadge)
    bbBuyer.AutoLocalize = false
    bbBuyer.Size = UDim2.new(1, -4, 0, 18)
    bbBuyer.Position = UDim2.new(0, 2, 0, 3)
    bbBuyer.BackgroundTransparency = 1
    bbBuyer.Text = "Buyer"
    bbBuyer.TextColor3 = COLORS.Accent
    bbBuyer.Font = Enum.Font.GothamBlack
    bbBuyer.TextSize = 11
    bbBuyer.TextXAlignment = Enum.TextXAlignment.Center
    bbBuyer.ZIndex = 5
    trackLabel(bbBuyer)
    -- "Looprix" — smaller sub-text, bottom
    local bbText = Instance.new("TextLabel", buyerBadge)
    bbText.AutoLocalize = false
    bbText.Size = UDim2.new(1, -4, 0, 13)
    bbText.Position = UDim2.new(0, 2, 0, 22)
    bbText.BackgroundTransparency = 1
    bbText.Text = "Looprix"
    bbText.TextColor3 = Color3.fromRGB(160, 200, 185)
    bbText.Font = Enum.Font.GothamBold
    bbText.TextSize = 8
    bbText.TextXAlignment = Enum.TextXAlignment.Center
    bbText.ZIndex = 5

    contentFrame = createElement("Frame", {  
        Name = "ContentFrame",  
        Size = UDim2.new(1, 0, 1, -(titleHeight + 60 + 64)),  
        Position = UDim2.new(0, 0, 0, titleHeight + 56),  
        BackgroundTransparency = 1,  
        Parent = mainFrame,  
    })  

    local tabs = {  
        duel = createDuelTab(contentFrame),
        performance = createPerformanceTab(contentFrame),
        settings = createSettingsTab(contentFrame),
        binds = createBindsTab(contentFrame),
    }  

    tabs[currentTab].Visible = true  

    local function switchTab(tabId)
        currentTab = tabId
        for id, t in pairs(tabs) do t.Visible = (id == tabId) end
        for id, btn in pairs(tabButtons) do
            local active = (id == tabId)
            tween(btn, tweenInfoFast, { TextColor3 = active and COLORS.Accent or COLORS.TextDim })
            if active then
                if not table.find(_accentLabels, btn) then table.insert(_accentLabels, btn) end
            else
                for i, l in ipairs(_accentLabels) do
                    if l == btn then table.remove(_accentLabels, i) break end
                end
            end
        end
    end

    for id, btn in pairs(tabButtons) do  
        btn.MouseButton1Click:Connect(function() switchTab(id) end)  
    end  

    minBtn.MouseButton1Click:Connect(function()  
        isMinimized = not isMinimized  
        minBtn.Text = isMinimized and "+" or "-"  
        if isMinimized then  
            tween(mainFrame, tweenInfoMedium, { Size = UDim2.new(0, mainWidth, 0, titleHeight) })  
            tabBar.Visible = false  
            contentFrame.Visible = false
            userInfoBar.Visible = false
        else  
            tween(mainFrame, tweenInfoMedium, { Size = UDim2.new(0, mainWidth, 0, mainHeight) })  
            task.delay(0.2, function()  
                if not isMinimized then  
                    tabBar.Visible = true  
                    contentFrame.Visible = true
                    userInfoBar.Visible = true
                end  
            end)  
        end  
    end)  

    makeDraggable(mainFrame, titleBar, "main", function() return CONFIG.UI_LOCKED end)

    S.UserInputService.InputBegan:Connect(function(input, gpe)
        if gpe then return end
        local isKeyboard = input.UserInputType == Enum.UserInputType.Keyboard
        local isGamepad  = input.UserInputType == Enum.UserInputType.Gamepad1
                        or input.UserInputType == Enum.UserInputType.Gamepad2
                        or input.UserInputType == Enum.UserInputType.Gamepad3
                        or input.UserInputType == Enum.UserInputType.Gamepad4
        if not isKeyboard and not isGamepad then return end
        if input.KeyCode == Enum.KeyCode.Unknown then return end
        if isKeybindPressed(CONFIG.TOGGLE_GUI_KEYBIND, input) then
            toggleGui()
        elseif isKeybindPressed(CONFIG.AUTO_BAT_KEYBIND, input) then
            CONFIG.AUTO_BAT_ENABLED = not CONFIG.AUTO_BAT_ENABLED
            attacking = CONFIG.AUTO_BAT_ENABLED; saveConfig()
            if CONFIG.AUTO_BAT_ENABLED then autoAttack() end
        elseif isKeybindPressed(CONFIG.AIMBOT_KEYBIND, input) then
            local newAimState = not CONFIG.AIMBOT_ENABLED
            if newAimState and CONFIG.SPINBOT_ENABLED then
                CONFIG.SPINBOT_ENABLED = false; spinbotEnabled = false; stopSpinBot()
                if _spinbotBtn then setToggleVisual(_spinbotBtn, false) end
                if spinbotPanelBtn then spinbotPanelBtn.Text = "SPIN: OFF" end
                showNotification("Spin Bot", false)
            end
            CONFIG.AIMBOT_ENABLED = newAimState; aimbotEnabled = newAimState; saveConfig()
            if newAimState then startBodyAimbot() else stopBodyAimbot() end
            if _aimbotBtn then setToggleVisual(_aimbotBtn, newAimState) end
        elseif isKeybindPressed(CONFIG.SPINBOT_KEYBIND, input) then
            local newSpinState = not CONFIG.SPINBOT_ENABLED
            if newSpinState and CONFIG.AIMBOT_ENABLED then
                CONFIG.AIMBOT_ENABLED = false; aimbotEnabled = false; stopBodyAimbot()
                if _aimbotBtn then setToggleVisual(_aimbotBtn, false) end
                showNotification("Aimbot", false)
            end
            CONFIG.SPINBOT_ENABLED = newSpinState; spinbotEnabled = newSpinState; saveConfig()
            if newSpinState then startSpinBot() else stopSpinBot() end
            if spinbotPanelBtn then
                spinbotPanelBtn.Text = "SPIN: " .. (newSpinState and "ON" or "OFF")
            end
            if _spinbotBtn then setToggleVisual(_spinbotBtn, newSpinState) end
        elseif isKeybindPressed(CONFIG.LOCK_TARGET_KEYBIND, input) then
            if isSwitching then return end
            local newKbState = not CONFIG.LOCK_TARGET_ENABLED
            if newKbState then
                isSwitching = true
                -- mutual exclusion: lock ON → force aimbot OFF
                if CONFIG.AIMBOT_ENABLED then
                    CONFIG.AIMBOT_ENABLED = false
                    aimbotEnabled = false
                    stopBodyAimbot()
                    if _aimbotBtn then setToggleVisual(_aimbotBtn, false) end
                    showNotification("Aimbot", false)
                end
                if AP.enabled then
                    apStopLoop()
                    apResetBtns()
                end
                isSwitching = false
            end
            CONFIG.LOCK_TARGET_ENABLED = newKbState
            lockTargetEnabled = newKbState; saveConfig()
            if lockTargetPanelBtn then
                lockTargetPanelBtn.Text = "LOCK: " .. (lockTargetEnabled and "ON" or "OFF")
            end
            if lockTargetEnabled then startLockTarget() else stopLockTarget() end
        elseif isKeybindPressed(CONFIG.AUTO_MEDUSA_KEYBIND, input) then
            CONFIG.AUTO_MEDUSA_ENABLED = not CONFIG.AUTO_MEDUSA_ENABLED
            autoMedusaEnabled = CONFIG.AUTO_MEDUSA_ENABLED; saveConfig()
            if CONFIG.AUTO_MEDUSA_ENABLED then startAutoMedusa() else stopAutoMedusa() end
        elseif isKeybindPressed(CONFIG.INSTANT_GRAB_KEYBIND, input) then
            local newState = not CONFIG.INSTANT_GRAB_ENABLED
            CONFIG.INSTANT_GRAB_ENABLED = newState; instantGrabEnabled = newState; saveConfig()
            if newState then startInstantGrab() else stopInstantGrab() end
        elseif isKeybindPressed(CONFIG.DROP_BRAINROT_KEYBIND, input) then
            executeDrop()
        elseif isKeybindPressed(CONFIG.FLOAT_KEYBIND, input) then
            if not CONFIG.FLOAT_PANEL_VISIBLE then return end
            if _FLT.enabled then stopFloat() else CONFIG.FLOAT_ACTIVE = true; startFloat() end
            saveConfig()
        elseif isKeybindPressed(CONFIG.AUTO_PLAY_KEYBIND, input) then
            if apGuiInstance and apGuiInstance.Enabled then
                apLaunchSide("auto")
            end
        elseif isKeybindPressed(CONFIG.AUTO_WALK_KEYBIND, input) then
            if awGuiInstance and awGuiInstance.Enabled then
                awLaunch("auto")
            end
        elseif isKeybindPressed(CONFIG.ANTI_STEAL_KEYBIND, input) then
            CONFIG.ANTI_STEAL_PANEL_VISIBLE = not CONFIG.ANTI_STEAL_PANEL_VISIBLE
            antiStealEnabled = CONFIG.ANTI_STEAL_PANEL_VISIBLE
            if antiStealEnabled then startAntiStealWatcher() else stopAntiStealWatcher() end
            saveConfig()
        elseif isKeybindPressed(CONFIG.FLING_KEYBIND, input) then
            flingEnabled = not flingEnabled
            if flingPanelBtn then
                flingPanelBtn.Text = "FLING: " .. (flingEnabled and "ON" or "OFF")
            end
            if flingEnabled then startFling() else stopFling() end; saveConfig()
        elseif isKeybindPressed(CONFIG.AUTO_LOCK_KEYBIND, input) then
            CONFIG.AUTO_LOCK_PANEL_VISIBLE = not CONFIG.AUTO_LOCK_PANEL_VISIBLE
            autoLockEnabled2 = CONFIG.AUTO_LOCK_PANEL_VISIBLE
            if autoLockEnabled2 then startAutoLockWatcher() else stopAutoLockWatcher() end
            saveConfig()
        elseif isKeybindPressed(CONFIG.TP_DOWN_KEYBIND, input) then
            tpDown()
        elseif isKeybindPressed(CONFIG.AUTO_REACT_STEAL_KEYBIND, input) then
            CONFIG.AUTO_REACT_STEAL_ENABLED = not CONFIG.AUTO_REACT_STEAL_ENABLED
            autoReactStealEnabled = CONFIG.AUTO_REACT_STEAL_ENABLED
            saveConfig()
            if CONFIG.AUTO_REACT_STEAL_ENABLED then startAutoReactStealWatcher() else stopAutoReactStealWatcher() end
        elseif isKeybindPressed(CONFIG.SPEED_LAGGER_KEYBIND, input) then
            _slEnabled = not _slEnabled
            CONFIG.SPEED_LAGGER_ENABLED = _slEnabled
            saveConfig()
            if speedLaggerGuiInstance then
                if _slEnabled then
                    _slWasSpeedOn = CONFIG.SPEED_ENABLED
                    CONFIG.SPEED_ENABLED = false
                    if not _slRenderConn then
                        _slRenderConn = S.RunService.RenderStepped:Connect(function()
                            if not _slEnabled then return end
                            local char = S.LocalPlayer.Character
                            if not char then return end
                            local hrp = char:FindFirstChild("HumanoidRootPart")
                            local hum = char:FindFirstChildOfClass("Humanoid")
                            if not hrp or not hum then return end
                            if hum.MoveDirection.Magnitude > 0 then
                                local spd = 16 + (CONFIG.SPEED_LAGGER_SPEED / 100) * 54
                                local dir = hum.MoveDirection.Unit
                                hrp.AssemblyLinearVelocity = Vector3.new(dir.X * spd, hrp.AssemblyLinearVelocity.Y, dir.Z * spd)
                            end
                        end)
                    end
                    if not _slThread then
                        _slThread = task.spawn(function()
                            while _slEnabled do
                                local lagAmt = CONFIG.SPEED_LAGGER_LAG / 100 * 0.2
                                if lagAmt > 0 then local t = tick(); while tick() - t < lagAmt do end end
                                task.wait()
                            end
                        end)
                    end
                else
                    if _slRenderConn then _slRenderConn:Disconnect(); _slRenderConn = nil end
                    if _slThread then pcall(function() task.cancel(_slThread) end); _slThread = nil end
                    if _slWasSpeedOn then CONFIG.SPEED_ENABLED = true; _slWasSpeedOn = false end
                end
            end
        elseif isKeybindPressed(CONFIG.DESYNC_KEYBIND, input) then
            local newState = not CONFIG.DESYNC_ENABLED
            toggleDesync(newState)
            if newState then
                if not CONFIG.ESP_ENABLED then startESP() end
            else
                if not CONFIG.ESP_ENABLED then stopESP() end
            end
            pcall(function()
                if desyncPanelBtn then
                    desyncPanelBtn.Text = "DSYNC: " .. (newState and "ON" or "OFF")
                end
            end)
            showNotification("Desync", newState)
        end
    end)
end

-- ======================================
-- HUD: ACTIVE FEATURES LIST
-- ======================================

local function createActiveHud()
    -- Remove old if exists
    pcall(function()
        if S.PlayerGui:FindFirstChild("LooprixActiveHUD") then
            S.PlayerGui.LooprixActiveHUD:Destroy()
        end
    end)

    local hudGui = Instance.new("ScreenGui")
    hudGui.AutoLocalize = false
    hudGui.Name = "LooprixActiveHUD"
    hudGui.ResetOnSpawn = false
    hudGui.DisplayOrder = 999990
    hudGui.Enabled = CONFIG.ACTIVE_HUD_VISIBLE
    hudGui.Parent = S.PlayerGui

    -- Primary column: bottom-right
    local primaryCol = Instance.new("Frame")
    primaryCol.Name = "PrimaryCol"
    primaryCol.Size = UDim2.new(0, 160, 0, 0)
    primaryCol.Position = UDim2.new(1, -168, 1, -8)
    primaryCol.AnchorPoint = Vector2.new(0, 1)
    primaryCol.BackgroundTransparency = 1
    primaryCol.BorderSizePixel = 0
    primaryCol.AutomaticSize = Enum.AutomaticSize.Y
    primaryCol.Parent = hudGui

    local primaryLayout = Instance.new("UIListLayout", primaryCol)
    primaryLayout.FillDirection = Enum.FillDirection.Vertical
    primaryLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    primaryLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    primaryLayout.SortOrder = Enum.SortOrder.LayoutOrder
    primaryLayout.Padding = UDim.new(0, 3)

    -- Secondary column: bottom-left (overflow 5+)
    local secondaryCol = Instance.new("Frame")
    secondaryCol.Name = "SecondaryCol"
    secondaryCol.Size = UDim2.new(0, 160, 0, 0)
    secondaryCol.Position = UDim2.new(0, 8, 1, -8)
    secondaryCol.AnchorPoint = Vector2.new(0, 1)
    secondaryCol.BackgroundTransparency = 1
    secondaryCol.BorderSizePixel = 0
    secondaryCol.AutomaticSize = Enum.AutomaticSize.Y
    secondaryCol.Parent = hudGui

    local secondaryLayout = Instance.new("UIListLayout", secondaryCol)
    secondaryLayout.FillDirection = Enum.FillDirection.Vertical
    secondaryLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    secondaryLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    secondaryLayout.SortOrder = Enum.SortOrder.LayoutOrder
    secondaryLayout.Padding = UDim.new(0, 3)

    -- Toggle definitions: { configKey, displayName }
    local TOGGLE_DEFS = {
        { k = "AUTO_BAT_ENABLED",         n = "Auto Bat"       },
        { k = "AIMBOT_ENABLED",            n = "Aimbot"         },
        { k = "SPINBOT_ENABLED",           n = "Spin Bot"       },
        { k = "ANTIRAGDOLL_ENABLED",       n = "Anti Ragdoll"   },
        { k = "UNWALK_ENABLED",            n = "Unwalk"         },
        { k = "ESP_ENABLED",               n = "ESP"            },
        { k = "INF_JUMP_ENABLED",          n = "Inf Jump"       },
        { k = "OPTIMIZER_ENABLED",         n = "Optimizer"      },
        { k = "XRAY_ENABLED",              n = "XRay"           },
        { k = "LOCK_TARGET_ENABLED",       n = "Lock Target"    },
        { k = "AUTO_MEDUSA_ENABLED",       n = "Auto Medusa"    },
        { k = "INSTANT_GRAB_ENABLED",      n = "Instant Grab"   },
        { k = "ANTI_DIE_ENABLED",          n = "Anti Die"       },
        { k = "NO_COLLISION_ENABLED",      n = "No Collision"   },
        { k = "SPEED_ENABLED",             n = "Speed Boost"    },
    }

    local hudPool = {}  -- cache of row frames
    local GRAD_COLORS = ColorSequence.new({
        ColorSequenceKeypoint.new(0,    Color3.fromRGB(CONFIG.GUI_COLOR_R, CONFIG.GUI_COLOR_G, CONFIG.GUI_COLOR_B)),
        ColorSequenceKeypoint.new(0.5,  Color3.fromRGB(
            math.min(CONFIG.GUI_COLOR_R+80,255),
            math.min(CONFIG.GUI_COLOR_G+40,255),
            math.min(CONFIG.GUI_COLOR_B+60,255))),
        ColorSequenceKeypoint.new(1,    Color3.fromRGB(CONFIG.GUI_COLOR_R, CONFIG.GUI_COLOR_G, CONFIG.GUI_COLOR_B)),
    })

    local function makeHudRow(name)
        local row = Instance.new("Frame")
        row.Size = UDim2.new(1, 0, 0, 22)
        row.BackgroundColor3 = COLORS.Background
        row.BackgroundTransparency = 0.25
        row.BorderSizePixel = 0
        Instance.new("UICorner", row).CornerRadius = UDim.new(0, 5)

        local rowStroke = Instance.new("UIStroke", row)
        rowStroke.Thickness = 1
        rowStroke.Color = COLORS.Accent
        rowStroke.Transparency = 0.4
        rowStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        trackStroke(rowStroke)

        -- Dot indicator
        local dot = Instance.new("Frame", row)
        dot.Size = UDim2.new(0, 7, 0, 7)
        dot.Position = UDim2.new(0, 6, 0.5, -3)
        dot.BackgroundColor3 = COLORS.Accent
        dot.BorderSizePixel = 0
        Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
        trackDot(dot)

        -- Pulse animation on dot
        task.spawn(function()
            while dot and dot.Parent do
                S.TweenService:Create(dot, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                    {BackgroundTransparency = 0.3}):Play()
                task.wait(0.6)
                if dot and dot.Parent then
                    S.TweenService:Create(dot, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                        {BackgroundTransparency = 0}):Play()
                    task.wait(0.6)
                end
            end
        end)

        local lbl = Instance.new("TextLabel", row)
        lbl.AutoLocalize = false
        lbl.Size = UDim2.new(1, -18, 1, 0)
        lbl.Position = UDim2.new(0, 17, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = name
        lbl.TextColor3 = Color3.new(1,1,1)
        lbl.TextSize = 11
        lbl.Font = Enum.Font.GothamSemibold
        lbl.TextXAlignment = Enum.TextXAlignment.Left

        local lblGrad = Instance.new("UIGradient", lbl)
        lblGrad.Color = GRAD_COLORS
        table.insert(_accentGradients, lblGrad)

        return row
    end

    local function refreshHud()
        -- Gather active toggles
        local active = {}
        for _, def in ipairs(TOGGLE_DEFS) do
            if CONFIG[def.k] then
                table.insert(active, def.n)
            end
        end

        -- Clear existing rows
        for _, r in ipairs(hudPool) do
            if r and r.Parent then r:Destroy() end
        end
        hudPool = {}

        -- Populate columns
        for i, name in ipairs(active) do
            local row = makeHudRow(name)
            if i <= 5 then
                row.LayoutOrder = i
                row.Parent = primaryCol
            else
                row.LayoutOrder = i
                row.Parent = secondaryCol
            end
            table.insert(hudPool, row)
        end
    end

    -- Refresh HUD every 0.5 seconds
    task.spawn(function()
        while hudGui and hudGui.Parent do
            refreshHud()
            task.wait(0.5)
        end
    end)

    -- HUD gradient anim removed

    return hudGui
end

-- ======================================
-- STATS ISLAND
-- ======================================

local function createStatsIsland()
    if S.PlayerGui:FindFirstChild("LooprixStats") then
        S.PlayerGui.LooprixStats:Destroy()
    end

    local TEXT_GRADIENT_COLORS = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 217, 127)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(120, 255, 210)),
        ColorSequenceKeypoint.new(0.66, Color3.fromRGB(150, 255, 180)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 217, 127))
    })

    local function makeGradBorder(parent)
        local s = Instance.new("UIStroke", parent)
        s.Thickness = 1
        s.Color = Color3.fromRGB(0, 217, 127)
        s.Transparency = 0.1
        s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        trackStroke(s)
        local g = Instance.new("UIGradient", s)
        g.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0,    Color3.fromRGB(0,   217, 127)),
            ColorSequenceKeypoint.new(0.25, Color3.fromRGB(120, 255, 210)),
            ColorSequenceKeypoint.new(0.5,  Color3.fromRGB(150, 255, 180)),
            ColorSequenceKeypoint.new(0.75, Color3.fromRGB(120, 255, 210)),
            ColorSequenceKeypoint.new(1,    Color3.fromRGB(0,   217, 127))
        })
        trackGradient(g)
        return s, g
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.AutoLocalize = false
    screenGui.Name = "LooprixStats"
    screenGui.ResetOnSpawn = false
    screenGui.DisplayOrder = 100
    screenGui.Parent = S.PlayerGui

    -- ── 1. Stats bar (topmost, Y=8) ─────────────────────────────────────────
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainContainer"
    mainFrame.Size = UDim2.new(0, 220, 0, 22)
    mainFrame.Position = UDim2.new(0.5, 0, 0, 8)
    mainFrame.AnchorPoint = Vector2.new(0.5, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(12, 14, 20)
    mainFrame.BackgroundTransparency = 0.15
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    registerScaleTarget(mainFrame)
    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 6)
    local _, borderGradient = makeGradBorder(mainFrame)

    local statsLabel = Instance.new("TextLabel")
    statsLabel.AutoLocalize = false
    statsLabel.Size = UDim2.new(1, -12, 1, 0)
    statsLabel.Position = UDim2.new(0, 6, 0, 0)
    statsLabel.BackgroundTransparency = 1
    statsLabel.Font = Enum.Font.GothamBold
    statsLabel.TextColor3 = Color3.new(1, 1, 1)
    statsLabel.TextScaled = false
    statsLabel.TextSize = 12
    statsLabel.RichText = true
    statsLabel.Text = "Looprix  |  FPS: --  |  PING: -- ms"
    statsLabel.Parent = mainFrame

    -- ── 2. Progress bar row (middle, Y=34) ──────────────────────────────────
    -- Layout: [status 42px] [track flex] [dist badge 28px]
    local pbFrame = Instance.new("Frame")
    pbFrame.Name = "ProgressRow"
    pbFrame.Size = UDim2.new(0, 190, 0, 16)
    pbFrame.Position = UDim2.new(0.5, 0, 0, 34)
    pbFrame.AnchorPoint = Vector2.new(0.5, 0)
    pbFrame.BackgroundColor3 = Color3.fromRGB(12, 14, 20)
    pbFrame.BackgroundTransparency = 0.15
    pbFrame.BorderSizePixel = 0
    pbFrame.Parent = screenGui
    registerScaleTarget(pbFrame)
    Instance.new("UICorner", pbFrame).CornerRadius = UDim.new(0, 5)
    local _, pbBorderGrad = makeGradBorder(pbFrame)

    -- Status label
    local pbStatus = Instance.new("TextLabel")
    pbStatus.AutoLocalize = false
    pbStatus.Size = UDim2.new(0, 42, 1, 0)
    pbStatus.Position = UDim2.new(0, 5, 0, 0)
    pbStatus.BackgroundTransparency = 1
    pbStatus.Text = "Ready"
    pbStatus.TextColor3 = COLORS.Accent
    pbStatus.TextScaled = false
    pbStatus.TextSize = 9
    pbStatus.Font = Enum.Font.GothamBold
    pbStatus.TextXAlignment = Enum.TextXAlignment.Left
    pbStatus.ZIndex = 4
    pbStatus.Parent = pbFrame
    trackLabel(pbStatus)

    -- Track background
    local pbTrack = Instance.new("Frame")
    pbTrack.Size = UDim2.new(1, -88, 0, 5)
    pbTrack.Position = UDim2.new(0, 50, 0.5, -2)
    pbTrack.BackgroundColor3 = Color3.fromRGB(20, 26, 38)
    pbTrack.BackgroundTransparency = 0.1
    pbTrack.BorderSizePixel = 0
    pbTrack.ClipsDescendants = true
    pbTrack.ZIndex = 3
    pbTrack.Parent = pbFrame
    Instance.new("UICorner", pbTrack).CornerRadius = UDim.new(1, 0)
    local tse = Instance.new("UIStroke", pbTrack)
    tse.Thickness = 1; tse.Transparency = 0.2
    tse.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    tse.Color = COLORS.Accent
    trackStroke(tse)

    -- Fill (reuses stealFillFrame slot — separate reference for stats island)
    local pbFill = Instance.new("Frame")
    pbFill.Name = "Fill"
    pbFill.Size = UDim2.new(0, 0, 1, 0)
    pbFill.BackgroundColor3 = COLORS.Accent
    pbFill.BackgroundTransparency = 0
    pbFill.BorderSizePixel = 0
    pbFill.Visible = false
    pbFill.ZIndex = 4
    pbFill.Parent = pbTrack
    trackFrame(pbFill)
    Instance.new("UICorner", pbFill).CornerRadius = UDim.new(1, 0)
    -- Route steal progress logic to this fill frame
    stealFillFrame = pbFill

    -- Distance badge (tappable → opens inline TextBox to edit distance)
    local distBadgeBtn = Instance.new("TextButton")
    distBadgeBtn.AutoLocalize = false
    distBadgeBtn.Size = UDim2.new(0, 30, 0, 12)
    distBadgeBtn.Position = UDim2.new(1, -34, 0.5, -6)
    distBadgeBtn.BackgroundColor3 = COLORS.Surface
    distBadgeBtn.BackgroundTransparency = 0.3
    distBadgeBtn.BorderSizePixel = 0
    distBadgeBtn.Text = tostring(CONFIG.INSTANT_GRAB_ACTIVATION_DIST)
    distBadgeBtn.TextColor3 = COLORS.Accent
    distBadgeBtn.TextScaled = false
    distBadgeBtn.TextSize = 8
    distBadgeBtn.Font = Enum.Font.GothamBold
    distBadgeBtn.TextXAlignment = Enum.TextXAlignment.Center
    distBadgeBtn.ZIndex = 5
    distBadgeBtn.Parent = pbFrame
    trackLabel(distBadgeBtn)
    Instance.new("UICorner", distBadgeBtn).CornerRadius = UDim.new(0, 3)
    local dbs = Instance.new("UIStroke", distBadgeBtn)
    dbs.Thickness = 1; dbs.Transparency = 0.2
    dbs.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    dbs.Color = COLORS.Accent
    trackStroke(dbs)

    -- Inline TextBox (hidden by default, shown on badge tap)
    local distBox = Instance.new("TextBox")
    distBox.AutoLocalize = false
    distBox.Size = UDim2.new(0, 30, 0, 12)
    distBox.Position = UDim2.new(1, -34, 0.5, -6)
    distBox.BackgroundColor3 = Color3.fromRGB(10, 12, 18)
    distBox.BackgroundTransparency = 0.1
    distBox.BorderSizePixel = 0
    distBox.Text = tostring(CONFIG.INSTANT_GRAB_ACTIVATION_DIST)
    distBox.TextColor3 = COLORS.Accent
    distBox.TextScaled = false
    distBox.TextSize = 8
    distBox.Font = Enum.Font.GothamBold
    distBox.TextXAlignment = Enum.TextXAlignment.Center
    distBox.ClearTextOnFocus = true
    distBox.ZIndex = 6
    distBox.Visible = false
    distBox.Parent = pbFrame
    Instance.new("UICorner", distBox).CornerRadius = UDim.new(0, 3)
    local dbxs = Instance.new("UIStroke", distBox)
    dbxs.Thickness = 1; dbxs.Transparency = 0; dbxs.Color = COLORS.Accent
    trackStroke(dbxs)

    local function commitDist()
        local v = tonumber(distBox.Text)
        if v then
            v = math.clamp(math.round(v), 1, 50)
            CONFIG.INSTANT_GRAB_ACTIVATION_DIST = v
            saveConfig()
            distBadgeBtn.Text = tostring(v)
        else
            distBadgeBtn.Text = tostring(CONFIG.INSTANT_GRAB_ACTIVATION_DIST)
        end
        distBox.Visible = false
        distBadgeBtn.Visible = true
    end

    distBadgeBtn.MouseButton1Click:Connect(function()
        distBox.Text = tostring(CONFIG.INSTANT_GRAB_ACTIVATION_DIST)
        distBadgeBtn.Visible = false
        distBox.Visible = true
        distBox:CaptureFocus()
    end)
    distBox.FocusLost:Connect(function() commitDist() end)
    distBox:GetPropertyChangedSignal("Text"):Connect(function()
        -- only allow digits
        distBox.Text = distBox.Text:gsub("[^%d]", "")
    end)

    -- Keep badge text synced when changed from elsewhere
    task.spawn(function()
        local last = CONFIG.INSTANT_GRAB_ACTIVATION_DIST
        while pbFrame and pbFrame.Parent do
            task.wait(0.25)
            local cur = CONFIG.INSTANT_GRAB_ACTIVATION_DIST
            if cur ~= last then last = cur; distBadgeBtn.Text = tostring(cur) end
        end
    end)

    -- Sync status text from steal state
    task.spawn(function()
        while pbFrame and pbFrame.Parent do
            task.wait(0.1)
            pbStatus.Text = (isStealing and "Grabbing") or "Ready"
        end
    end)

    -- discord link shown as BillboardGui above player head (see _startDiscordBB)

    -- Animations removed (caused lag)

    -- ── FPS / PING updater ───────────────────────────────────────────────────
    local lastTime = tick()
    local frames = 0
    S.RunService.RenderStepped:Connect(function()
        frames = frames + 1
        local currentTime = tick()
        if currentTime - lastTime >= 0.5 then
            local fps  = math.round(frames / (currentTime - lastTime))
            local ping = math.round(S.LocalPlayer:GetNetworkPing() * 1000)
            local pingHex = ping < 80 and "00D97F" or (ping < 150 and "FFEB78" or "FF6478")
            statsLabel.Text = string.format(
                "Looprix  |  FPS: %d  |  PING: <font color=\"#%s\">%d ms</font>",
                fps, pingHex, ping)
            frames = 0
            lastTime = currentTime
        end
    end)

    return screenGui
end

-- ======================================
-- REAPPLY SETTINGS ON CHARACTER RESPAWN
-- ======================================

local function reapplyAllSettings()
    -- Apply features sequentially with small delays so each system
    -- initialises cleanly before the next one starts.
    -- This prevents the "delete config to fix" bug when joining a new server.

    if CONFIG.ANTI_DIE_ENABLED then
        task.wait(0.2)
        activateAntiDie()
        antiDieEnabled = true
        task.wait(0.05)
    end

    if CONFIG.AUTO_BAT_ENABLED then
        attacking = true
        autoAttack()
        task.wait(0.05)
    end

    if CONFIG.AIMBOT_ENABLED then
        aimbotEnabled = true
        startBodyAimbot()
        task.wait(0.05)
    end

    if CONFIG.SPINBOT_ENABLED then
        spinbotEnabled = true
        startSpinBot()
        task.wait(0.05)
    end

    if CONFIG.ANTIRAGDOLL_ENABLED then
        toggleAntiRagdoll(true)
        task.wait(0.05)
    end

    if CONFIG.ANTIRAGDOLL_V2_ENABLED then
        toggleAntiRagdollV2(true)
        task.wait(0.05)
    end

    if CONFIG.UNWALK_ENABLED then
        unwalkEnabled = true
        startUnwalk()
        task.wait(0.05)
    end

    if CONFIG.ESP_ENABLED or CONFIG.DESYNC_ENABLED then
        espEnabled = true
        startESP()
        task.wait(0.05)
    end

    if CONFIG.DESYNC_ENABLED then
        startDesync()
        task.wait(0.05)
    end

    if CONFIG.LOCK_TARGET_ENABLED then
        lockTargetEnabled = true
        startLockTarget()
        task.wait(0.05)
    end

    if CONFIG.INF_JUMP_ENABLED then
        infJumpEnabled = true
        startInfJump()
        task.wait(0.05)
    end

    if CONFIG.OPTIMIZER_ENABLED then
        optimizerEnabled = true
        startOptimizer()
        task.wait(0.05)
    end

    if CONFIG.XRAY_ENABLED then
        xrayEnabled = true
        startXRay()
        task.wait(0.05)
    end

    if CONFIG.AUTO_MEDUSA_ENABLED then
        autoMedusaEnabled = true
        startAutoMedusa()
        task.wait(0.05)
    end

    if CONFIG.MEDUSA_COUNTER_ENABLED then
        medusaCounterEnabled = true
        setupMedusaCounter(character)
        task.wait(0.05)
    end

    if CONFIG.INSTANT_GRAB_ENABLED then
        instantGrabEnabled = true
        startInstantGrab()
        task.wait(0.05)
    end

    if CONFIG.NO_COLLISION_ENABLED then
        startNoCollision()
        task.wait(0.05)
    end

    startSpeed()
    task.wait(0.05)

    if CONFIG.FLOAT_PANEL_VISIBLE and CONFIG.FLOAT_ACTIVE then
        startFloat()
        task.wait(0.05)
    end
    if CONFIG.FLOAT_PANEL_VISIBLE and floatPanelGui then
        floatPanelGui.Enabled = true
    end

    if flingEnabled then
        startFling()
        if flingPanelBtn then
            flingPanelBtn.Text = "FLING: ON"
            trackLabel(flingPanelBtn)
        end
        task.wait(0.05)
    end

    if CONFIG.AUTO_REACT_STEAL_ENABLED then
        autoReactStealEnabled = true
        startAutoReactStealWatcher()
        task.wait(0.05)
    end

    if CONFIG.SPEED_METER_ENABLED then
        toggleSpeedMeter(true)
        task.wait(0.05)
    end

    if CONFIG.NO_CAM_COLLISION_ENABLED then
        enableNoCameraCollision()
        task.wait(0.05)
    end

    -- Auto-apply Harder Hit Anim only if enabled
    if CONFIG.HARDER_HIT_ENABLED then
        pcall(function()
            task.wait(0.3)
            startHarderHitAnim()
        end)
    end

    -- Restore panel visibility states
    if CONFIG.FLING_PANEL_VISIBLE and flingPanelGui then
        flingPanelGui.Enabled = true
    end
    if CONFIG.SPINBOT_PANEL_VISIBLE and spinbotPanelGui then
        spinbotPanelGui.Enabled = true
    end
    if CONFIG.TAUNT_PANEL_VISIBLE and tauntPanelGui then
        tauntPanelGui.Enabled = true
    end
    if CONFIG.AUTO_WALK_PANEL_VISIBLE and awGuiInstance then
        awGuiInstance.Enabled = true
    end
    if CONFIG.TP_DOWN_PANEL_VISIBLE and tpDownPanelGui then
        tpDownPanelGui.Enabled = true
    end
    if CONFIG.AUTO_LOCK_PANEL_VISIBLE and autoLockEnabled2 then
        startAutoLockWatcher()
    end

    if CONFIG.ANTI_LOCK_ENABLED then
        antiLockEnabled = true
        pcall(function()
            if antiLockPanelBtn then
                antiLockPanelBtn.Text = "ANTI LOCK: ON"
            end
        end)
    end

    pcall(function()
        if desyncPanelBtn then
            desyncPanelBtn.Text = "DSYNC: " .. (CONFIG.DESYNC_ENABLED and "ON" or "OFF")
        end
        if lockTargetPanelBtn then
            lockTargetPanelBtn.Text = "LOCK: " .. (CONFIG.LOCK_TARGET_ENABLED and "ON" or "OFF")
        end
        if spinbotPanelBtn then
            spinbotPanelBtn.Text = "SPIN: " .. (CONFIG.SPINBOT_ENABLED and "ON" or "OFF")
        end
    end)
end

-- ======================================
-- CHARACTER RESPAWN HANDLING
-- ======================================

local function stopAllSystems()
    -- aimbot
    stopBodyAimbot()
    aimbotEnabled = false
    -- spinbot
    stopSpinBot()
    spinbotEnabled = false
    -- unwalk
    stopUnwalk()
    unwalkEnabled = false
    -- esp (keep alive if desync or ESP toggle owns it)
    if not CONFIG.DESYNC_ENABLED and not CONFIG.ESP_ENABLED then
        stopESP()
        espEnabled = false
    end
    -- lock target
    stopLockTarget()
    lockTargetEnabled = false
    -- inf jump
    stopInfJump()
    infJumpEnabled = false
    -- optimizer
    stopOptimizer()
    optimizerEnabled = false
    -- xray
    stopXRay()
    xrayEnabled = false
    -- auto medusa
    stopAutoMedusa()
    autoMedusaEnabled = false
    -- medusa counter
    stopMedusaCounter()
    medusaCounterEnabled = false
    -- instant grab
    stopInstantGrab()
    instantGrabEnabled = false
    -- no cam collision
    disableNoCameraCollision()
    -- no collision
    stopNoCollision()
    -- speed
    stopSpeed()
    -- float + tp down: disconnect conn + reset gen but KEEP _FLT.enabled flag for reapply
    _FLT.gen = _FLT.gen + 1
    _FLT.tpInProgress = false
    if _FLT.conn then _FLT.conn:Disconnect(); _FLT.conn = nil end
    pcall(function()
        local c = S.LocalPlayer.Character
        local h = c and c:FindFirstChildOfClass("Humanoid")
        if h then h.HipHeight = 2 end
    end)
    _FLT.curHip = 0
    -- auto play
    apStopLoop()
    AP.enabled = false
    AP.activeSide = nil
    AP.currentStep = 1
    AP.isWaiting = false
    -- Reset auto-side detection so it re-polls after respawn
    AP._autoSide   = nil
    AP._sideLocked = false
    AP._sideVotes  = {L=0, R=0}
    -- auto walk
    awStopLoop()
    AW.enabled = false
    AW.activeSide = nil
    AW.currentStep = 1
    -- auto bat
    attacking = false
    _autoBatGen = _autoBatGen + 1  -- stop any running auto-bat loop without changing CONFIG
    -- anti ragdoll
    disconnectAllAntiRagdoll()
    stopAntiRagdollV2()
    -- anti die
    antiDieEnabled = false
    deactivateAntiDie()
    -- fling: preserve state so reapplyAllSettings can relaunch if it was active
    local _flingWas = flingEnabled
    flingEnabled = false  -- stop current loop iteration
    task.defer(function() flingEnabled = _flingWas end)  -- restore flag after loop exits
end

local function onCharacterAdded(c)
    stopAllSystems()
    clearConnections()
    runCleanups()

    character = c
    HRP = c:WaitForChild("HumanoidRootPart")

    -- Setup medusa counter immediately on new character
    if CONFIG.MEDUSA_COUNTER_ENABLED then
        task.spawn(function()
            task.wait(0.3)
            setupMedusaCounter(c)
        end)
    end

    task.spawn(function()
        task.wait(0.5)
        reapplyAllSettings()
        -- Re-enable NCC after respawn (connection survives, BB needs fresh char)
        if CONFIG.NO_CAM_COLLISION_ENABLED then
            enableNoCameraCollision()
        end
        -- Re-apply Harder Hit Anim after respawn only if enabled
        if CONFIG.HARDER_HIT_ENABLED then
            pcall(function()
                task.wait(0.3)
                startHarderHitAnim()
            end)
        end
    end)
end

S.LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

-- ======================================
-- INITIALIZATION
-- ======================================

-- Disable Roblox automatic translator
pcall(function()
    local ls = game:GetService("LocalizationService")
    ls.RobloxForcePlayLocale = "en-us"
end)

loadConfig()


if CONFIG._autoPlayOffsets then
    for _, side in ipairs({"L","R"}) do
        for _, key in ipairs({"P1","P2","P3","P4","P5"}) do
            local sd = CONFIG._autoPlayOffsets[side]
            if sd and sd[key] then
                AP.offsets[side][key].x = sd[key].x or 0
                AP.offsets[side][key].z = sd[key].z or 0
            end
        end
    end
end
if CONFIG._apBasePositions then
    for side, pts in pairs(CONFIG._apBasePositions) do
        if AP.BASE[side] then
            for key, pv in pairs(pts) do
                if type(pv) == "table" and AP.BASE[side][key] ~= nil then
                    AP.BASE[side][key] = Vector3.new(
                        tonumber(pv.x) or 0,
                        tonumber(pv.y) or 0,
                        tonumber(pv.z) or 0
                    )
                end
            end
        end
    end
end

-- Apply saved GUI color on startup
do
    local r = CONFIG.GUI_COLOR_R or 0
    local g = CONFIG.GUI_COLOR_G or 217
    local b = CONFIG.GUI_COLOR_B or 127
    COLORS.Accent = Color3.fromRGB(r, g, b)
end

-- ======================================
-- POST-DROP CALLBACKS  (assigned here — all deps are ready)
-- ======================================

-- Auto Stop on Drop: stops AutoPlay when drop fires
_doPostDropHalt = function()
    if AP.enabled then
        apStopLoop()
        apResetBtns()
    end
end

-- Lock on Drop: lock on nearest target for 2s then release
_doSnapLock = function()
    if isSwitching then return end
    local wasLocked = CONFIG.LOCK_TARGET_ENABLED
    if wasLocked then return end
    isSwitching = true
    if AP.enabled then apStopLoop(); apResetBtns() end
    CONFIG.LOCK_TARGET_ENABLED = true
    lockTargetEnabled = true
    startLockTarget()
    pcall(function()
        if lockTargetPanelBtn then
            lockTargetPanelBtn.Text = "LOCK: ON"
        end
    end)
    isSwitching = false
    task.delay(2, function()
        CONFIG.LOCK_TARGET_ENABLED = false
        lockTargetEnabled = false
        stopLockTarget()
        pcall(function()
            if lockTargetPanelBtn then
                lockTargetPanelBtn.Text = "LOCK: OFF"
            end
        end)
    end)
end


-- ======================================
-- AUTO LOAD ON KICK
-- ======================================
do
    local _genv   = getgenv and getgenv() or {}
    local _lp     = S.Players.LocalPlayer

    if _genv.LOOPRIX_AUTOLOAD == nil then
        _genv.LOOPRIX_AUTOLOAD = CONFIG.AUTO_LOAD_ENABLED or false
    else
        CONFIG.AUTO_LOAD_ENABLED = (_genv.LOOPRIX_AUTOLOAD == true)
    end
    if not _genv.LOOPRIX_LAST_RELOAD then _genv.LOOPRIX_LAST_RELOAD = 0 end

    local _kickConn = nil

    local function _doReload()
        local now = tick()
        if (now - (_genv.LOOPRIX_LAST_RELOAD or 0)) < 5 then return end
        _genv.LOOPRIX_LAST_RELOAD = now
        task.wait(0.8)
        local ok = false
        pcall(function()
            local url = _genv.SCRIPT_RELOAD_URL or ""
            if url ~= "" then loadstring(game:HttpGet(url, true))(); ok = true end
        end)
        if not ok then
            task.wait(0.4)
            pcall(function()
                local url = _genv.SCRIPT_RELOAD_URL or ""
                if url ~= "" then loadstring(game:HttpGet(url, true))() end
            end)
        end
    end

    _setAutoLoad = function(v)
        CONFIG.AUTO_LOAD_ENABLED = v
        _genv.LOOPRIX_AUTOLOAD = v
        if _kickConn then _kickConn:Disconnect(); _kickConn = nil end
        if v then
            _kickConn = S.Players.PlayerRemoving:Connect(function(player)
                if player ~= _lp then return end
                _doReload()
            end)
        end
    end

    if CONFIG.AUTO_LOAD_ENABLED then
        task.defer(function() _setAutoLoad(true) end)
    end
end

createGui()
-- Restore saved GUI visibility
guiVisible = (CONFIG.MAIN_GUI_VISIBLE ~= false)
if mainFrame then mainFrame.Visible = guiVisible end
setupFloatingPanels()
createFastPanel()
speedGuiInstance      = createSpeedGui()
laggerGuiInstance     = createLaggerGui()
speedLaggerGuiInstance = createSpeedLaggerGui()
apGuiInstance         = createAutoPlayGui()
awGuiInstance    = createAutoWalkGui()
createStatsIsland()
createActiveHud()
_startDiscordBB()

-- Propagate saved accent color to ALL tracked elements (stats island, discord, speed gui, etc.)
do
    local r = CONFIG.GUI_COLOR_R or 0
    local g = CONFIG.GUI_COLOR_G or 217
    local b = CONFIG.GUI_COLOR_B or 127
    applyAccentColor(r, g, b)
end

-- Apply saved UI scale to all registered scale targets
applyUIScale(scaleMultiplier)

-- ======================================
-- FLOATING TOGGLE BUTTON  (2×2 grid icon)
-- ======================================

local function createToggleButton()
    local tbGui = Instance.new("ScreenGui")
    tbGui.AutoLocalize = false
    tbGui.Name = "Looprix_ToggleBtn"
    tbGui.ResetOnSpawn = false
    tbGui.DisplayOrder = 9999998
    tbGui.IgnoreGuiInset = true

    pcall(function()
        if gethui then
            tbGui.Parent = gethui()
        elseif syn and syn.protect_gui then
            syn.protect_gui(tbGui)
            tbGui.Parent = S.PlayerGui
        else
            tbGui.Parent = S.PlayerGui
        end
    end)
    if not tbGui.Parent then tbGui.Parent = S.PlayerGui end

    -- Rounded square card
    local btn = Instance.new("Frame")
    btn.Name = "LooprixToggleBtn"
    btn.Size = UDim2.new(0, 42, 0, 42)
    btn.BackgroundColor3 = Color3.fromRGB(10, 12, 18)
    btn.BackgroundTransparency = 0.35
    btn.BorderSizePixel = 0
    btn.Parent = tbGui
    registerScaleTarget(btn)

    loadAndClampPosition(btn, "toggleBtn", UDim2.new(0, 12, 1, -56))
    _regDraggable(btn, function() return UDim2.new(0,12,1,-56) end)

    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

    -- Animated gradient border
    local outerStroke = Instance.new("UIStroke", btn)
    outerStroke.Thickness = 1.5
    outerStroke.Color = COLORS.Accent
    outerStroke.Transparency = 0.1
    outerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    trackStroke(outerStroke)

    local outerGrad = Instance.new("UIGradient", outerStroke)
    outerGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,    Color3.fromRGB(0,217,127)),
        ColorSequenceKeypoint.new(0.25, Color3.fromRGB(120,255,210)),
        ColorSequenceKeypoint.new(0.5,  Color3.fromRGB(150,255,180)),
        ColorSequenceKeypoint.new(0.75, Color3.fromRGB(120,255,210)),
        ColorSequenceKeypoint.new(1,    Color3.fromRGB(0,217,127))
    })
    trackGradient(outerGrad)

    -- 2×2 grid icon — four rounded squares
    local CELL = 10
    local GAP  = 4
    local TOTAL = CELL * 2 + GAP  -- 24
    local OX = math.floor((42 - TOTAL) / 2)  -- left offset to centre
    local OY = math.floor((42 - TOTAL) / 2)

    local positions = {
        { OX,          OY         },
        { OX + CELL + GAP, OY         },
        { OX,          OY + CELL + GAP },
        { OX + CELL + GAP, OY + CELL + GAP },
    }

    local cells = {}
    for _, pos in ipairs(positions) do
        local cell = Instance.new("Frame", btn)
        cell.Size = UDim2.new(0, CELL, 0, CELL)
        cell.Position = UDim2.new(0, pos[1], 0, pos[2])
        cell.BackgroundColor3 = COLORS.Accent
        cell.BackgroundTransparency = 0
        cell.BorderSizePixel = 0
        Instance.new("UICorner", cell).CornerRadius = UDim.new(0, 3)
        trackFrame(cell)
        table.insert(cells, cell)
    end

    -- ── Input ─────────────────────────────────────────────────────────────────
    local getTbIsTap = makeDraggable(btn, btn, "toggleBtn", function() return CONFIG.UI_LOCKED end,
        function()
            -- after save: clamp already done inside makeDraggable
        end
    )

    -- Tap = toggle main GUI
    btn.InputEnded:Connect(function(inp)
        if inp.UserInputType ~= Enum.UserInputType.MouseButton1 and
           inp.UserInputType ~= Enum.UserInputType.Touch then return end
        if not getTbIsTap() then return end  -- was a drag, not a tap
        guiVisible = not guiVisible
        if mainFrame then mainFrame.Visible = guiVisible end
        CONFIG.MAIN_GUI_VISIBLE = guiVisible
        saveConfig()
        for _, c in ipairs(cells) do
            S.TweenService:Create(c, TweenInfo.new(0.08, Enum.EasingStyle.Quad), {
                BackgroundTransparency = 0.5
            }):Play()
        end
        task.delay(0.12, function()
            for _, c in ipairs(cells) do
                S.TweenService:Create(c, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {
                    BackgroundTransparency = 0
                }):Play()
            end
        end)
    end)

    -- Re-apply saved accent color so toggle button elements get the right color
    pcall(function()
        applyAccentColor(CONFIG.GUI_COLOR_R or 0, CONFIG.GUI_COLOR_G or 217, CONFIG.GUI_COLOR_B or 127)
    end)

    return tbGui
end

createToggleButton()


task.spawn(function()
    task.wait(0.5)
    reapplyAllSettings()

    pcall(function()
        if CONFIG.HARDER_HIT_ENABLED then startHarderHitAnim() end
    end)
end)

-- ======================================
-- FOV LOCK HEARTBEAT
-- ======================================

S.RunService.Heartbeat:Connect(function()
    if not CONFIG.FOV_LOCK_ENABLED then return end
    pcall(function()
        local cam = workspace.CurrentCamera
        if cam and math.abs(cam.FieldOfView - (CONFIG.FOV_VALUE or 70)) > 0.1 then
            cam.FieldOfView = CONFIG.FOV_VALUE or 70
        end
    end)
end)

end -- _main
_main()
