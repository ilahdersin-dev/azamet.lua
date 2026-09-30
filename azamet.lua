--========================================================
--                    AZAMET HUB
--                  By Zeth😮‍💨
--========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera

local KEY = "raiderzethvoid"

--========================================================
-- SERVICES / CHARACTER
--========================================================

local Character
local Humanoid
local Root

local function UpdateCharacter()
    Character = Player.Character or Player.CharacterAdded:Wait()
    Humanoid = Character:WaitForChild("Humanoid")
    Root = Character:WaitForChild("HumanoidRootPart")
end

UpdateCharacter()

--========================================================
-- STATE
--========================================================

local State = {
    Fly = false,
    Freeze = false,
    ESP = false,
    Invisible = false,
    Noclip = false,
    Fullbright = false,
    InfiniteJump = false,
    Teleport = false,

    AntiAFK = false,
    NoFog = false,
    NoShadows = false,
    NightVision = false,
    ThirdPerson = false,
    AutoSprint = false
}

local FlySpeed = 60

local OldGravity = workspace.Gravity
local OldFOV = Camera.FieldOfView

local OldLighting = {
    Brightness = Lighting.Brightness,
    ClockTime = Lighting.ClockTime,
    FogEnd = Lighting.FogEnd,
    GlobalShadows = Lighting.GlobalShadows
}

local FlyConnection
local NoclipConnection
local InfiniteJumpConnection
local AntiAFKConnection
local AutoSprintConnection

local ESPObjects = {}

local UIClosed = false
local Destroyed = false
local ConfirmOpen = false

--========================================================
-- COLORS
--========================================================

local C = {
    Background = Color3.fromRGB(5,8,13),
    Panel = Color3.fromRGB(8,12,18),
    Button = Color3.fromRGB(15,20,28),
    ButtonHover = Color3.fromRGB(24,32,42),
    Text = Color3.fromRGB(225,230,235),
    Muted = Color3.fromRGB(100,115,125),
    Accent = Color3.fromRGB(0,255,200),
    AccentDark = Color3.fromRGB(0,170,135),
    Danger = Color3.fromRGB(230,65,75),
    DangerHover = Color3.fromRGB(255,80,90)
}

--========================================================
-- SOUND SYSTEM
--========================================================

local CLICK_SOUND_ID = "rbxassetid://113397864512278"

local function MakeSound(name, volume)
    local Sound = Instance.new("Sound")
    Sound.Name = name
    Sound.SoundId = CLICK_SOUND_ID
    Sound.Volume = volume or 0.35
    Sound.Parent = SoundService
    return Sound
end

local ClickSound = MakeSound("AZAMET_Click", .28)
local HoverSound = MakeSound("AZAMET_Hover", .10)
local OpenSound = MakeSound("AZAMET_Open", .35)
local CloseSound = MakeSound("AZAMET_Close", .35)

local function PlaySound(Sound)
    if not Sound then return end

    Sound:Stop()
    Sound.TimePosition = 0
    Sound:Play()
end

--========================================================
-- GUI
--========================================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "AZAMET_HUB"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.DisplayOrder = 999
Gui.Parent = PlayerGui

--========================================================
-- LOADING SCREEN
--========================================================

local Loading = Instance.new("Frame")
Loading.Size = UDim2.fromScale(1,1)
Loading.BackgroundColor3 = C.Background
Loading.BorderSizePixel = 0
Loading.Parent = Gui

local LoadScale = Instance.new("UIScale")
LoadScale.Scale = .92
LoadScale.Parent = Loading

local LoadTitle = Instance.new("TextLabel")
LoadTitle.AnchorPoint = Vector2.new(.5,.5)
LoadTitle.Position = UDim2.fromScale(.5,.42)
LoadTitle.Size = UDim2.fromOffset(600,80)
LoadTitle.BackgroundTransparency = 1
LoadTitle.Text = "AZAMET"
LoadTitle.TextColor3 = C.Accent
LoadTitle.TextTransparency = 1
LoadTitle.TextSize = 58
LoadTitle.Font = Enum.Font.GothamBlack
LoadTitle.Parent = Loading

local LoadSub = Instance.new("TextLabel")
LoadSub.AnchorPoint = Vector2.new(.5,.5)
LoadSub.Position = UDim2.fromScale(.5,.51)
LoadSub.Size = UDim2.fromOffset(500,30)
LoadSub.BackgroundTransparency = 1
LoadSub.Text = "STUDIO CONTROL SYSTEM"
LoadSub.TextColor3 = C.Muted
LoadSub.TextTransparency = 1
LoadSub.TextSize = 14
LoadSub.Font = Enum.Font.GothamBold
LoadSub.Parent = Loading

local LoadBack = Instance.new("Frame")
LoadBack.AnchorPoint = Vector2.new(.5,.5)
LoadBack.Position = UDim2.fromScale(.5,.63)
LoadBack.Size = UDim2.fromOffset(320,5)
LoadBack.BackgroundColor3 = Color3.fromRGB(25,30,35)
LoadBack.BorderSizePixel = 0
LoadBack.Parent = Loading

Instance.new("UICorner",LoadBack).CornerRadius = UDim.new(1,0)

local LoadBar = Instance.new("Frame")
LoadBar.Size = UDim2.new(0,0,1,0)
LoadBar.BackgroundColor3 = C.Accent
LoadBar.BorderSizePixel = 0
LoadBar.Parent = LoadBack

Instance.new("UICorner",LoadBar).CornerRadius = UDim.new(1,0)

local LoadText = Instance.new("TextLabel")
LoadText.AnchorPoint = Vector2.new(.5,.5)
LoadText.Position = UDim2.fromScale(.5,.69)
LoadText.Size = UDim2.fromOffset(400,25)
LoadText.BackgroundTransparency = 1
LoadText.Text = "Başlatılıyor..."
LoadText.TextColor3 = C.Muted
LoadText.TextSize = 12
LoadText.Font = Enum.Font.Gotham
LoadText.Parent = Loading

TweenService:Create(
    LoadScale,
    TweenInfo.new(.7,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),
    {Scale = 1}
):Play()

TweenService:Create(
    LoadTitle,
    TweenInfo.new(.7,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),
    {TextTransparency = 0}
):Play()

TweenService:Create(
    LoadSub,
    TweenInfo.new(.8,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),
    {TextTransparency = 0}
):Play()

TweenService:Create(
    LoadBar,
    TweenInfo.new(2,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),
    {Size = UDim2.fromScale(1,1)}
):Play()

task.wait(.65)
LoadText.Text = "Modüller hazırlanıyor..."

task.wait(.65)
LoadText.Text = "AZAMET yükleniyor..."

task.wait(.65)

TweenService:Create(
    Loading,
    TweenInfo.new(.55,Enum.EasingStyle.Quart,Enum.EasingDirection.In),
    {BackgroundTransparency = 1}
):Play()

TweenService:Create(
    LoadTitle,
    TweenInfo.new(.45),
    {TextTransparency = 1}
):Play()

TweenService:Create(
    LoadSub,
    TweenInfo.new(.45),
    {TextTransparency = 1}
):Play()

task.wait(.6)

Loading:Destroy()

--========================================================
-- KEY SCREEN
--========================================================

local KeyFrame = Instance.new("Frame")
KeyFrame.AnchorPoint = Vector2.new(.5,.5)
KeyFrame.Position = UDim2.fromScale(.5,.5)
KeyFrame.Size = UDim2.fromOffset(370,245)
KeyFrame.BackgroundColor3 = C.Panel
KeyFrame.BorderSizePixel = 0
KeyFrame.Parent = Gui

Instance.new("UICorner",KeyFrame).CornerRadius = UDim.new(0,18)

local KeyScale = Instance.new("UIScale")
KeyScale.Scale = .85
KeyScale.Parent = KeyFrame

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Color = C.Accent
KeyStroke.Transparency = .3
KeyStroke.Thickness = 1.5
KeyStroke.Parent = KeyFrame

TweenService:Create(
    KeyScale,
    TweenInfo.new(.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
    {Scale = 1}
):Play()

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Position = UDim2.fromOffset(22,18)
KeyTitle.Size = UDim2.new(1,-44,0,35)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "AZAMET"
KeyTitle.TextColor3 = C.Accent
KeyTitle.TextSize = 28
KeyTitle.Font = Enum.Font.GothamBlack
KeyTitle.TextXAlignment = Enum.TextXAlignment.Left
KeyTitle.Parent = KeyFrame

local KeySub = Instance.new("TextLabel")
KeySub.Position = UDim2.fromOffset(22,52)
KeySub.Size = UDim2.new(1,-44,0,25)
KeySub.BackgroundTransparency = 1
KeySub.Text = "Güvenli erişim anahtarını gir"
KeySub.TextColor3 = C.Muted
KeySub.TextSize = 13
KeySub.Font = Enum.Font.Gotham
KeySub.TextXAlignment = Enum.TextXAlignment.Left
KeySub.Parent = KeyFrame

local KeyBox = Instance.new("TextBox")
KeyBox.Position = UDim2.fromOffset(22,92)
KeyBox.Size = UDim2.new(1,-44,0,44)
KeyBox.BackgroundColor3 = Color3.fromRGB(17,21,28)
KeyBox.BorderSizePixel = 0
KeyBox.PlaceholderText = "KEY"
KeyBox.PlaceholderColor3 = Color3.fromRGB(85,95,105)
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(240,245,250)
KeyBox.TextSize = 14
KeyBox.Font = Enum.Font.Gotham
KeyBox.ClearTextOnFocus = false
KeyBox.Parent = KeyFrame

Instance.new("UICorner",KeyBox).CornerRadius = UDim.new(0,9)

local Enter = Instance.new("TextButton")
Enter.Position = UDim2.fromOffset(22,148)
Enter.Size = UDim2.new(1,-44,0,42)
Enter.BackgroundColor3 = C.AccentDark
Enter.BorderSizePixel = 0
Enter.Text = "GİRİŞ YAP"
Enter.TextColor3 = Color3.new(1,1,1)
Enter.TextSize = 14
Enter.Font = Enum.Font.GothamBold
Enter.AutoButtonColor = false
Enter.Parent = KeyFrame

Instance.new("UICorner",Enter).CornerRadius = UDim.new(0,9)

local KeyStatus = Instance.new("TextLabel")
KeyStatus.Position = UDim2.fromOffset(22,198)
KeyStatus.Size = UDim2.new(1,-44,0,25)
KeyStatus.BackgroundTransparency = 1
KeyStatus.Text = ""
KeyStatus.TextSize = 12
KeyStatus.Font = Enum.Font.Gotham
KeyStatus.Parent = KeyFrame

--========================================================
-- MAIN
--========================================================

local Main = Instance.new("Frame")
Main.AnchorPoint = Vector2.new(.5,.5)
Main.Position = UDim2.fromScale(.5,.5)
Main.Size = UDim2.fromOffset(650,470)
Main.BackgroundColor3 = C.Panel
Main.BorderSizePixel = 0
Main.Visible = false
Main.Parent = Gui

Instance.new("UICorner",Main).CornerRadius = UDim.new(0,18)

local MainScale = Instance.new("UIScale")
MainScale.Scale = .9
MainScale.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = C.Accent
MainStroke.Transparency = .42
MainStroke.Thickness = 1.5
MainStroke.Parent = Main

--========================================================
-- DRAG
--========================================================

local Dragging = false
local DragStart
local StartPosition

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1,0,0,68)
Header.BackgroundTransparency = 1
Header.Parent = Main

Header.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then

        Dragging = true
        DragStart = input.Position
        StartPosition = Main.Position

        input.Changed:Connect(function()

            if input.UserInputState == Enum.UserInputState.End then
                Dragging = false
            end

        end)

    end

end)

UserInputService.InputChanged:Connect(function(input)

    if Dragging and
        (input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then

        local Delta = input.Position - DragStart

        Main.Position = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )

    end

end)

--========================================================
-- HEADER
--========================================================

local HeaderTitle = Instance.new("TextLabel")
HeaderTitle.Position = UDim2.fromOffset(22,10)
HeaderTitle.Size = UDim2.fromOffset(300,32)
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.Text = "AZAMET"
HeaderTitle.TextColor3 = C.Accent
HeaderTitle.TextSize = 25
HeaderTitle.Font = Enum.Font.GothamBlack
HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
HeaderTitle.Parent = Header

local HeaderSub = Instance.new("TextLabel")
HeaderSub.Position = UDim2.fromOffset(23,39)
HeaderSub.Size = UDim2.fromOffset(350,18)
HeaderSub.BackgroundTransparency = 1
HeaderSub.Text = "STUDIO CONTROL PANEL  •  ZETH"
HeaderSub.TextColor3 = C.Muted
HeaderSub.TextSize = 10
HeaderSub.Font = Enum.Font.GothamBold
HeaderSub.TextXAlignment = Enum.TextXAlignment.Left
HeaderSub.Parent = Header

--========================================================
-- HEADER BUTTONS
--========================================================

local MinButton = Instance.new("TextButton")
MinButton.Position = UDim2.new(1,-78,0,16)
MinButton.Size = UDim2.fromOffset(28,28)
MinButton.BackgroundColor3 = C.Button
MinButton.BorderSizePixel = 0
MinButton.Text = "−"
MinButton.TextColor3 = C.Text
MinButton.TextSize = 20
MinButton.Font = Enum.Font.GothamBold
MinButton.AutoButtonColor = false
MinButton.Parent = Header

Instance.new("UICorner",MinButton).CornerRadius = UDim.new(0,8)

local CloseButton = Instance.new("TextButton")
CloseButton.Position = UDim2.new(1,-42,0,16)
CloseButton.Size = UDim2.fromOffset(28,28)
CloseButton.BackgroundColor3 = Color3.fromRGB(35,20,24)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255,100,110)
CloseButton.TextSize = 20
CloseButton.Font = Enum.Font.GothamBold
CloseButton.AutoButtonColor = false
CloseButton.Parent = Header

Instance.new("UICorner",CloseButton).CornerRadius = UDim.new(0,8)

--========================================================
-- MINI BAR
--========================================================

local Mini = Instance.new("TextButton")
Mini.AnchorPoint = Vector2.new(.5,0)
Mini.Position = UDim2.fromScale(.5,0)
Mini.Size = UDim2.fromOffset(230,36)
Mini.BackgroundColor3 = C.Panel
Mini.BorderSizePixel = 0
Mini.Text = "────  AZAMET  ────"
Mini.TextColor3 = C.Accent
Mini.TextSize = 13
Mini.Font = Enum.Font.GothamBlack
Mini.AutoButtonColor = false
Mini.Visible = false
Mini.Parent = Gui

Instance.new("UICorner",Mini).CornerRadius = UDim.new(0,10)

local MiniStroke = Instance.new("UIStroke")
MiniStroke.Color = C.Accent
MiniStroke.Transparency = .35
MiniStroke.Parent = Mini

--========================================================
-- BUTTON FACTORY
--========================================================

local function Button(text,x,y,w,h,parent)

    local B = Instance.new("TextButton")

    B.Position = UDim2.fromOffset(x,y)
    B.Size = UDim2.fromOffset(w,h)
    B.BackgroundColor3 = C.Button
    B.BorderSizePixel = 0
    B.Text = text
    B.TextColor3 = C.Text
    B.TextSize = 12
    B.Font = Enum.Font.GothamBold
    B.AutoButtonColor = false
    B.Parent = parent or Main

    Instance.new("UICorner",B).CornerRadius = UDim.new(0,10)

    local S = Instance.new("UIStroke")
    S.Color = Color3.fromRGB(30,38,48)
    S.Transparency = .2
    S.Parent = B

    B.MouseEnter:Connect(function()

        TweenService:Create(
            B,
            TweenInfo.new(.12,Enum.EasingStyle.Quart),
            {BackgroundColor3 = C.ButtonHover}
        ):Play()

        PlaySound(HoverSound)

    end)

    B.MouseLeave:Connect(function()

        TweenService:Create(
            B,
            TweenInfo.new(.12),
            {BackgroundColor3 = C.Button}
        ):Play()

    end)

    B.MouseButton1Click:Connect(function()
        PlaySound(ClickSound)
    end)

    return B
end

--========================================================
-- TAB SYSTEM
--========================================================

local Tabs = Instance.new("Frame")
Tabs.Position = UDim2.fromOffset(18,72)
Tabs.Size = UDim2.new(1,-36,0,40)
Tabs.BackgroundTransparency = 1
Tabs.Parent = Main

local Content = Instance.new("Frame")
Content.Position = UDim2.fromOffset(18,120)
Content.Size = UDim2.new(1,-36,1,-138)
Content.BackgroundTransparency = 1
Content.Parent = Main

local Pages = {}

local function NewPage(Name)
    local Page = Instance.new("Frame")
    Page.Name = Name
    Page.Size = UDim2.fromScale(1,1)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.Parent = Content
    Pages[Name] = Page
    return Page
end

local MovementPage = NewPage("Movement")
local VisualPage = NewPage("Visual")
local ToolsPage = NewPage("Tools")
local WorldPage = NewPage("World")

local CurrentPage

local function OpenPage(Name)

    for PageName,Page in pairs(Pages) do
        Page.Visible = PageName == Name
    end

    CurrentPage = Name

end

local TabNames = {
    {"MOVEMENT",MovementPage},
    {"VISUAL",VisualPage},
    {"TOOLS",ToolsPage},
    {"WORLD",WorldPage}
}

for i,Data in ipairs(TabNames) do

    local Name = Data[1]

    local Tab = Button(
        Name,
        (i-1)*153,
        0,
        145,
        38,
        Tabs
    )

    Tab.MouseButton1Click:Connect(function()
        OpenPage(Name:sub(1,1)..Name:sub(2):lower())
    end)

end

-- Fix page names manually
local TabButtons = {}

for _,Child in ipairs(Tabs:GetChildren()) do
    if Child:IsA("TextButton") then
        TabButtons[Child.Text] = Child
    end
end

local function ShowPage(Name)

    for N,Page in pairs(Pages) do
        Page.Visible = N == Name
    end

    for _,Tab in pairs(TabButtons) do
        Tab.TextColor3 = C.Text
        Tab.BackgroundColor3 = C.Button
    end

    if TabButtons[string.upper(Name)] then
        TabButtons[string.upper(Name)].TextColor3 = C.Accent
        TabButtons[string.upper(Name)].BackgroundColor3 = Color3.fromRGB(18,38,38)
    end

end

--========================================================
-- MOVEMENT PAGE
--========================================================

local FlyButton = Button("✈  FLY   OFF",0,0,285,42,MovementPage)

local FlySpeedBox = Instance.new("TextBox")
FlySpeedBox.Position = UDim2.fromOffset(295,0)
FlySpeedBox.Size = UDim2.fromOffset(125,42)
FlySpeedBox.BackgroundColor3 = C.Button
FlySpeedBox.BorderSizePixel = 0
FlySpeedBox.PlaceholderText = "Fly Speed"
FlySpeedBox.PlaceholderColor3 = C.Muted
FlySpeedBox.TextColor3 = C.Text
FlySpeedBox.TextSize = 12
FlySpeedBox.Font = Enum.Font.Gotham
FlySpeedBox.Parent = MovementPage

Instance.new("UICorner",FlySpeedBox).CornerRadius = UDim.new(0,10)

local FreezeButton = Button("❄  FREEZE   OFF",0,52,205,42,MovementPage)
local InfiniteButton = Button("♾  INFINITE JUMP   OFF",215,52,205,42,MovementPage)

local SpeedBox = Instance.new("TextBox")
SpeedBox.Position = UDim2.fromOffset(0,104)
SpeedBox.Size = UDim2.fromOffset(140,42)
SpeedBox.BackgroundColor3 = C.Button
SpeedBox.BorderSizePixel = 0
SpeedBox.PlaceholderText = "Walk Speed"
SpeedBox.PlaceholderColor3 = C.Muted
SpeedBox.TextColor3 = C.Text
SpeedBox.TextSize = 12
SpeedBox.Font = Enum.Font.Gotham
SpeedBox.Parent = MovementPage

Instance.new("UICorner",SpeedBox).CornerRadius = UDim.new(0,10)

local SpeedApply = Button("UYGULA",150,104,100,42,MovementPage)

local JumpBox = Instance.new("TextBox")
JumpBox.Position = UDim2.fromOffset(260,104)
JumpBox.Size = UDim2.fromOffset(160,42)
JumpBox.BackgroundColor3 = C.Button
JumpBox.BorderSizePixel = 0
JumpBox.PlaceholderText = "Jump Power"
JumpBox.PlaceholderColor3 = C.Muted
JumpBox.TextColor3 = C.Text
JumpBox.TextSize = 12
JumpBox.Font = Enum.Font.Gotham
JumpBox.Parent = MovementPage

Instance.new("UICorner",JumpBox).CornerRadius = UDim.new(0,10)

local JumpApply = Button("UYGULA",0,156,120,42,MovementPage)

local AutoSprintButton = Button("🏃  AUTO SPRINT   OFF",130,156,290,42,MovementPage)

--========================================================
-- FLY
--========================================================

FlyButton.MouseButton1Click:Connect(function()

    UpdateCharacter()

    State.Fly = not State.Fly

    if State.Fly then

        FlyButton.Text = "✈  FLY   ON"
        FlyButton.TextColor3 = C.Accent

        FlySpeed = tonumber(FlySpeedBox.Text) or 60

        Humanoid.PlatformStand = true

        if FlyConnection then
            FlyConnection:Disconnect()
        end

        FlyConnection = RunService.RenderStepped:Connect(function()

            if State.Fly and Root then

                Root.AssemblyLinearVelocity =
                    Camera.CFrame.LookVector * FlySpeed

                Root.AssemblyAngularVelocity = Vector3.zero

            end

        end)

    else

        FlyButton.Text = "✈  FLY   OFF"
        FlyButton.TextColor3 = C.Text

        if FlyConnection then
            FlyConnection:Disconnect()
            FlyConnection = nil
        end

        if Humanoid then
            Humanoid.PlatformStand = false
        end

        if Root then
            Root.AssemblyLinearVelocity = Vector3.zero
        end

    end

end)

--========================================================
-- FREEZE
--========================================================

FreezeButton.MouseButton1Click:Connect(function()

    UpdateCharacter()

    State.Freeze = not State.Freeze

    if Root then
        Root.Anchored = State.Freeze
    end

    if State.Freeze then
        FreezeButton.Text = "❄  FREEZE   ON"
        FreezeButton.TextColor3 = C.Accent
    else
        FreezeButton.Text = "❄  FREEZE   OFF"
        FreezeButton.TextColor3 = C.Text
    end

end)

--========================================================
-- SPEED
--========================================================

SpeedApply.MouseButton1Click:Connect(function()

    local Value = tonumber(SpeedBox.Text)

    if Value then
        UpdateCharacter()
        Humanoid.WalkSpeed = Value
    end

end)

JumpApply.MouseButton1Click:Connect(function()

    local Value = tonumber(JumpBox.Text)

    if Value then
        UpdateCharacter()
        Humanoid.UseJumpPower = true
        Humanoid.JumpPower = Value
    end

end)

--========================================================
-- INFINITE JUMP
--========================================================

InfiniteJumpConnection = UserInputService.JumpRequest:Connect(function()

    if State.InfiniteJump then

        UpdateCharacter()

        if Humanoid then
            Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end

    end

end)

InfiniteButton.MouseButton1Click:Connect(function()

    State.InfiniteJump = not State.InfiniteJump

    if State.InfiniteJump then
        InfiniteButton.Text = "♾  INFINITE JUMP   ON"
        InfiniteButton.TextColor3 = C.Accent
    else
        InfiniteButton.Text = "♾  INFINITE JUMP   OFF"
        InfiniteButton.TextColor3 = C.Text
    end

end)

--========================================================
-- AUTO SPRINT
--========================================================

AutoSprintButton.MouseButton1Click:Connect(function()

    State.AutoSprint = not State.AutoSprint

    if State.AutoSprint then

        AutoSprintButton.Text = "🏃  AUTO SPRINT   ON"
        AutoSprintButton.TextColor3 = C.Accent

        if AutoSprintConnection then
            AutoSprintConnection:Disconnect()
        end

        AutoSprintConnection = RunService.Heartbeat:Connect(function()

            if State.AutoSprint and Humanoid then

                if Humanoid.MoveDirection.Magnitude > .05 then
                    Humanoid.WalkSpeed = math.max(Humanoid.WalkSpeed,24)
                end

            end

        end)

    else

        AutoSprintButton.Text = "🏃  AUTO SPRINT   OFF"
        AutoSprintButton.TextColor3 = C.Text

        if AutoSprintConnection then
            AutoSprintConnection:Disconnect()
            AutoSprintConnection = nil
        end

    end

end)

--========================================================
-- VISUAL PAGE
--========================================================

local ESPButton = Button("👁  ESP   OFF",0,0,205,42,VisualPage)
local InvisibleButton = Button("👻  INVISIBLE   OFF",215,0,205,42,VisualPage)
local NoclipButton = Button("🚫  NOCLIP   OFF",0,52,205,42,VisualPage)
local FullbrightButton = Button("☀  FULLBRIGHT   OFF",215,52,205,42,VisualPage)
local NightVisionButton = Button("🌙  NIGHT VISION   OFF",0,104,205,42,VisualPage)
local NoFogButton = Button("🌫  NO FOG   OFF",215,104,205,42,VisualPage)
local NoShadowButton = Button("◐  NO SHADOWS   OFF",0,156,205,42,VisualPage)
local ThirdPersonButton = Button("🎥  THIRD PERSON   OFF",215,156,205,42,VisualPage)

local FOVBox = Instance.new("TextBox")
FOVBox.Position = UDim2.fromOffset(0,208)
FOVBox.Size = UDim2.fromOffset(150,42)
FOVBox.BackgroundColor3 = C.Button
FOVBox.BorderSizePixel = 0
FOVBox.PlaceholderText = "FOV"
FOVBox.PlaceholderColor3 = C.Muted
FOVBox.TextColor3 = C.Text
FOVBox.TextSize = 12
FOVBox.Font = Enum.Font.Gotham
FOVBox.Parent = VisualPage

Instance.new("UICorner",FOVBox).CornerRadius = UDim.new(0,10)

local FOVApply = Button("FOV UYGULA",160,208,125,42,VisualPage)

--========================================================
-- ESP
--========================================================

local function RemoveESP(PlayerObject)

    if ESPObjects[PlayerObject] then
        ESPObjects[PlayerObject]:Destroy()
        ESPObjects[PlayerObject] = nil
    end

end

local function AddESP(PlayerObject)

    if PlayerObject == Player then return end
    if not State.ESP then return end

    local Char = PlayerObject.Character
    if not Char then return end

    RemoveESP(PlayerObject)

    local Highlight = Instance.new("Highlight")

    Highlight.Name = "AZAMET_ESP"
    Highlight.Adornee = Char
    Highlight.FillColor = C.Accent
    Highlight.OutlineColor = Color3.new(1,1,1)
    Highlight.FillTransparency = .65
    Highlight.OutlineTransparency = .05
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

    Highlight.Parent = Char

    ESPObjects[PlayerObject] = Highlight

end

local function RefreshESP()

    for _,P in ipairs(Players:GetPlayers()) do

        if P ~= Player then

            if State.ESP then
                AddESP(P)
            else
                RemoveESP(P)
            end

        end

    end

end

ESPButton.MouseButton1Click:Connect(function()

    State.ESP = not State.ESP

    if State.ESP then
        ESPButton.Text = "👁  ESP   ON"
        ESPButton.TextColor3 = C.Accent
    else
        ESPButton.Text = "👁  ESP   OFF"
        ESPButton.TextColor3 = C.Text
    end

    RefreshESP()

end)

Players.PlayerAdded:Connect(function(P)

    P.CharacterAdded:Connect(function()

        task.wait(.4)

        if State.ESP then
            AddESP(P)
        end

    end)

end)

Players.PlayerRemoving:Connect(RemoveESP)

--========================================================
-- INVISIBLE
--========================================================

local function SetInvisible(Value)

    if not Character then return end

    for _,Obj in ipairs(Character:GetDescendants()) do

        if Obj:IsA("BasePart") then
            Obj.LocalTransparencyModifier = Value and 1 or 0

        elseif Obj:IsA("Decal") then
            Obj.Transparency = Value and 1 or 0

        end

    end

end

InvisibleButton.MouseButton1Click:Connect(function()

    State.Invisible = not State.Invisible

    SetInvisible(State.Invisible)

    if State.Invisible then
        InvisibleButton.Text = "👻  INVISIBLE   ON"
        InvisibleButton.TextColor3 = C.Accent
    else
        InvisibleButton.Text = "👻  INVISIBLE   OFF"
        InvisibleButton.TextColor3 = C.Text
    end

end)

--========================================================
-- NOCLIP
--========================================================

NoclipButton.MouseButton1Click:Connect(function()

    State.Noclip = not State.Noclip

    if State.Noclip then

        NoclipButton.Text = "🚫  NOCLIP   ON"
        NoclipButton.TextColor3 = C.Accent

        if NoclipConnection then
            NoclipConnection:Disconnect()
        end

        NoclipConnection = RunService.Stepped:Connect(function()

            if Character then

                for _,Part in ipairs(Character:GetDescendants()) do

                    if Part:IsA("BasePart") then
                        Part.CanCollide = false
                    end

                end

            end

        end)

    else

        NoclipButton.Text = "🚫  NOCLIP   OFF"
        NoclipButton.TextColor3 = C.Text

        if NoclipConnection then
            NoclipConnection:Disconnect()
            NoclipConnection = nil
        end

        if Character then

            for _,Part in ipairs(Character:GetDescendants()) do

                if Part:IsA("BasePart") then
                    Part.CanCollide = true
                end

            end

        end

    end

end)

--========================================================
-- FULLBRIGHT
--========================================================

FullbrightButton.MouseButton1Click:Connect(function()

    State.Fullbright = not State.Fullbright

    if State.Fullbright then

        FullbrightButton.Text = "☀  FULLBRIGHT   ON"
        FullbrightButton.TextColor3 = C.Accent

        Lighting.Brightness = 3
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false

    else

        FullbrightButton.Text = "☀  FULLBRIGHT   OFF"
        FullbrightButton.TextColor3 = C.Text

        Lighting.Brightness = OldLighting.Brightness
        Lighting.ClockTime = OldLighting.ClockTime
        Lighting.FogEnd = OldLighting.FogEnd
        Lighting.GlobalShadows = OldLighting.GlobalShadows

    end

end)

--========================================================
-- NIGHT VISION
--========================================================

local NightEffect

NightVisionButton.MouseButton1Click:Connect(function()

    State.NightVision = not State.NightVision

    if State.NightVision then

        NightVisionButton.Text = "🌙  NIGHT VISION   ON"
        NightVisionButton.TextColor3 = C.Accent

        NightEffect = Instance.new("ColorCorrectionEffect")
        NightEffect.Name = "AZAMET_NightVision"
        NightEffect.Brightness = .15
        NightEffect.Contrast = .35
        NightEffect.Saturation = -.15
        NightEffect.Parent = Lighting

    else

        NightVisionButton.Text = "🌙  NIGHT VISION   OFF"
        NightVisionButton.TextColor3 = C.Text

        if NightEffect then
            NightEffect:Destroy()
            NightEffect = nil
        end

    end

end)

--========================================================
-- NO FOG
--========================================================

NoFogButton.MouseButton1Click:Connect(function()

    State.NoFog = not State.NoFog

    if State.NoFog then

        NoFogButton.Text = "🌫  NO FOG   ON"
        NoFogButton.TextColor3 = C.Accent
        Lighting.FogEnd = 100000

    else

        NoFogButton.Text = "🌫  NO FOG   OFF"
        NoFogButton.TextColor3 = C.Text
        Lighting.FogEnd = OldLighting.FogEnd

    end

end)

--========================================================
-- NO SHADOWS
--========================================================

NoShadowButton.MouseButton1Click:Connect(function()

    State.NoShadows = not State.NoShadows

    if State.NoShadows then

        NoShadowButton.Text = "◐  NO SHADOWS   ON"
        NoShadowButton.TextColor3 = C.Accent
        Lighting.GlobalShadows = false

    else

        NoShadowButton.Text = "◐  NO SHADOWS   OFF"
        NoShadowButton.TextColor3 = C.Text
        Lighting.GlobalShadows = OldLighting.GlobalShadows

    end

end)

--========================================================
-- THIRD PERSON
--========================================================

ThirdPersonButton.MouseButton1Click:Connect(function()

    State.ThirdPerson = not State.ThirdPerson

    if State.ThirdPerson then

        ThirdPersonButton.Text = "🎥  THIRD PERSON   ON"
        ThirdPersonButton.TextColor3 = C.Accent

        Player.CameraMode = Enum.CameraMode.Classic
        Player.CameraMinZoomDistance = 8
        Player.CameraMaxZoomDistance = 18

    else

        ThirdPersonButton.Text = "🎥  THIRD PERSON   OFF"
        ThirdPersonButton.TextColor3 = C.Text

        Player.CameraMinZoomDistance = .5
        Player.CameraMaxZoomDistance = 400

    end

end)

--========================================================
-- FOV
--========================================================

FOVApply.MouseButton1Click:Connect(function()

    local Value = tonumber(FOVBox.Text)

    if Value then

        Value = math.clamp(Value,40,120)

        Camera.FieldOfView = Value

    end

end)

--========================================================
-- TOOLS PAGE
--========================================================

local TeleportButton = Button("📍  TELEPORT TOOL",0,0,205,42,ToolsPage)
local ResetButton = Button("↻  RESET CHARACTER",215,0,205,42,ToolsPage)

local GravityBox = Instance.new("TextBox")
GravityBox.Position = UDim2.fromOffset(0,52)
GravityBox.Size = UDim2.fromOffset(150,42)
GravityBox.BackgroundColor3 = C.Button
GravityBox.BorderSizePixel = 0
GravityBox.PlaceholderText = "Gravity"
GravityBox.PlaceholderColor3 = C.Muted
GravityBox.TextColor3 = C.Text
GravityBox.TextSize = 12
GravityBox.Font = Enum.Font.Gotham
GravityBox.Parent = ToolsPage

Instance.new("UICorner",GravityBox).CornerRadius = UDim.new(0,10)

local GravityButton = Button("UYGULA",160,52,125,42,ToolsPage)

local NormalGravity = Button("NORMAL GRAVITY",295,52,125,42,ToolsPage)

--========================================================
-- TELEPORT TOOL
--========================================================

local function GiveTeleportTool()

    if Player.Backpack:FindFirstChild("AZAMET") then
        return
    end

    if Character and Character:FindFirstChild("AZAMET") then
        return
    end

    local Tool = Instance.new("Tool")

    Tool.Name = "AZAMET"
    Tool.ToolTip = "Tıkla → teleport"
    Tool.RequiresHandle = false
    Tool.CanBeDropped = false

    Tool.Activated:Connect(function()

        local Mouse = Player:GetMouse()

        if Mouse and Mouse.Hit and Root then

            Root.CFrame =
                CFrame.new(Mouse.Hit.Position + Vector3.new(0,3,0))

        end

    end)

    Tool.Parent = Player.Backpack

end

local function RemoveTeleportTool()

    local BackpackTool = Player.Backpack:FindFirstChild("AZAMET")

    if BackpackTool then
        BackpackTool:Destroy()
    end

    if Character then

        local EquippedTool = Character:FindFirstChild("AZAMET")

        if EquippedTool then
            EquippedTool:Destroy()
        end

    end

end

TeleportButton.MouseButton1Click:Connect(function()

    State.Teleport = not State.Teleport

    if State.Teleport then

        TeleportButton.Text = "📍  TOOL ACTIVE"
        TeleportButton.TextColor3 = C.Accent

        GiveTeleportTool()

    else

        TeleportButton.Text = "📍  TELEPORT TOOL"
        TeleportButton.TextColor3 = C.Text

        RemoveTeleportTool()

    end

end)

--========================================================
-- GRAVITY
--========================================================

GravityButton.MouseButton1Click:Connect(function()

    local Value = tonumber(GravityBox.Text)

    if Value then
        workspace.Gravity = Value
    end

end)

NormalGravity.MouseButton1Click:Connect(function()
    workspace.Gravity = OldGravity
    GravityBox.Text = tostring(OldGravity)
end)

--========================================================
-- RESET
--========================================================

ResetButton.MouseButton1Click:Connect(function()

    UpdateCharacter()

    if Humanoid then
        Humanoid.Health = 0
    end

end)

--========================================================
-- WORLD PAGE
--========================================================

local AntiAFKButton = Button("💤  ANTI-AFK   OFF",0,0,205,42,WorldPage)

local DayButton = Button("☀  DAY",215,0,95,42,WorldPage)
local NightButton = Button("🌙  NIGHT",320,0,100,42,WorldPage)

local WorldFOVBox = Instance.new("TextLabel")
WorldFOVBox.Position = UDim2.fromOffset(0,52)
WorldFOVBox.Size = UDim2.fromOffset(420,42)
WorldFOVBox.BackgroundColor3 = C.Button
WorldFOVBox.BorderSizePixel = 0
WorldFOVBox.Text = "AZAMET WORLD CONTROL"
WorldFOVBox.TextColor3 = C.Accent
WorldFOVBox.TextSize = 13
WorldFOVBox.Font = Enum.Font.GothamBold
WorldFOVBox.Parent = WorldPage

Instance.new("UICorner",WorldFOVBox).CornerRadius = UDim.new(0,10)

--========================================================
-- ANTI AFK
--========================================================

AntiAFKButton.MouseButton1Click:Connect(function()

    State.AntiAFK = not State.AntiAFK

    if State.AntiAFK then

        AntiAFKButton.Text = "💤  ANTI-AFK   ON"
        AntiAFKButton.TextColor3 = C.Accent

        if AntiAFKConnection then
            AntiAFKConnection:Disconnect()
        end

        AntiAFKConnection = UserInputService.InputBegan:Connect(function()
            -- UI input keeps the local session active.
        end)

    else

        AntiAFKButton.Text = "💤  ANTI-AFK   OFF"
        AntiAFKButton.TextColor3 = C.Text

        if AntiAFKConnection then
            AntiAFKConnection:Disconnect()
            AntiAFKConnection = nil
        end

    end

end)

--========================================================
-- DAY / NIGHT
--========================================================

DayButton.MouseButton1Click:Connect(function()

    Lighting.ClockTime = 14

end)

NightButton.MouseButton1Click:Connect(function()

    Lighting.ClockTime = 0

end)

--========================================================
-- PAGE OPEN
--========================================================

ShowPage("Movement")

--========================================================
-- CONFIRMATION MODAL
--========================================================

local Overlay = Instance.new("Frame")
Overlay.Size = UDim2.fromScale(1,1)
Overlay.BackgroundColor3 = Color3.new(0,0,0)
Overlay.BackgroundTransparency = 1
Overlay.BorderSizePixel = 0
Overlay.Visible = false
Overlay.ZIndex = 100
Overlay.Parent = Gui

local Confirm = Instance.new("Frame")
Confirm.AnchorPoint = Vector2.new(.5,.5)
Confirm.Position = UDim2.fromScale(.5,.5)
Confirm.Size = UDim2.fromOffset(380,205)
Confirm.BackgroundColor3 = Color3.fromRGB(8,11,17)
Confirm.BorderSizePixel = 0
Confirm.Visible = false
Confirm.ZIndex = 101
Confirm.Parent = Gui

Instance.new("UICorner",Confirm).CornerRadius = UDim.new(0,18)

local ConfirmScale = Instance.new("UIScale")
ConfirmScale.Scale = .75
ConfirmScale.Parent = Confirm

local ConfirmStroke = Instance.new("UIStroke")
ConfirmStroke.Color = C.Danger
ConfirmStroke.Transparency = .25
ConfirmStroke.Thickness = 1.5
ConfirmStroke.Parent = Confirm

local ConfirmTitle = Instance.new("TextLabel")
ConfirmTitle.Position = UDim2.fromOffset(22,18)
ConfirmTitle.Size = UDim2.new(1,-44,0,30)
ConfirmTitle.BackgroundTransparency = 1
ConfirmTitle.Text = "UI'Yİ KAPAT?"
ConfirmTitle.TextColor3 = Color3.fromRGB(255,100,110)
ConfirmTitle.TextSize = 21
ConfirmTitle.Font = Enum.Font.GothamBold
ConfirmTitle.TextXAlignment = Enum.TextXAlignment.Left
ConfirmTitle.ZIndex = 102
ConfirmTitle.Parent = Confirm

local ConfirmText = Instance.new("TextLabel")
ConfirmText.Position = UDim2.fromOffset(22,53)
ConfirmText.Size = UDim2.new(1,-44,0,45)
ConfirmText.BackgroundTransparency = 1
ConfirmText.Text = "Emin misin?\nAktif özellikler kapatılacak."
ConfirmText.TextColor3 = Color3.fromRGB(170,180,190)
ConfirmText.TextSize = 13
ConfirmText.Font = Enum.Font.Gotham
ConfirmText.TextXAlignment = Enum.TextXAlignment.Left
ConfirmText.ZIndex = 102
ConfirmText.Parent = Confirm

local NoButton = Instance.new("TextButton")
NoButton.Position = UDim2.fromOffset(22,130)
NoButton.Size = UDim2.fromOffset(158,45)
NoButton.BackgroundColor3 = C.Button
NoButton.BorderSizePixel = 0
NoButton.Text = "HAYIR"
NoButton.TextColor3 = C.Text
NoButton.TextSize = 13
NoButton.Font = Enum.Font.GothamBold
NoButton.AutoButtonColor = false
NoButton.ZIndex = 103
NoButton.Parent = Confirm

Instance.new("UICorner",NoButton).CornerRadius = UDim.new(0,10)

local YesButton = Instance.new("TextButton")
YesButton.Position = UDim2.fromOffset(200,130)
YesButton.Size = UDim2.fromOffset(158,45)
YesButton.BackgroundColor3 = Color3.fromRGB(175,45,55)
YesButton.BorderSizePixel = 0
YesButton.Text = "EVET"
YesButton.TextColor3 = Color3.new(1,1,1)
YesButton.TextSize = 13
YesButton.Font = Enum.Font.GothamBold
YesButton.AutoButtonColor = false
YesButton.ZIndex = 103
YesButton.Parent = Confirm

Instance.new("UICorner",YesButton).CornerRadius = UDim.new(0,10)

--========================================================
-- SHOW / HIDE CONFIRM
--========================================================

local function OpenConfirm()

    if Destroyed then return end

    ConfirmOpen = true

    Overlay.Visible = true
    Confirm.Visible = true

    Overlay.BackgroundTransparency = 1
    ConfirmScale.Scale = .75

    TweenService:Create(
        Overlay,
        TweenInfo.new(.22),
        {BackgroundTransparency = .38}
    ):Play()

    TweenService:Create(
        ConfirmScale,
        TweenInfo.new(.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
        {Scale = 1}
    ):Play()

    PlaySound(OpenSound)

end

local function CloseConfirm()

    ConfirmOpen = false

    TweenService:Create(
        Overlay,
        TweenInfo.new(.18),
        {BackgroundTransparency = 1}
    ):Play()

    TweenService:Create(
        ConfirmScale,
        TweenInfo.new(.18,Enum.EasingStyle.Quart,Enum.EasingDirection.In),
        {Scale = .75}
    ):Play()

    task.wait(.18)

    if not ConfirmOpen then
        Confirm.Visible = false
        Overlay.Visible = false
    end

end

NoButton.MouseButton1Click:Connect(CloseConfirm)

--========================================================
-- DISABLE EVERYTHING
--========================================================

local function DisableEverything()

    Destroyed = true

    State.Fly = false
    State.Freeze = false
    State.ESP = false
    State.Invisible = false
    State.Noclip = false
    State.Fullbright = false
    State.InfiniteJump = false
    State.Teleport = false
    State.AntiAFK = false
    State.NoFog = false
    State.NoShadows = false
    State.NightVision = false
    State.ThirdPerson = false
    State.AutoSprint = false

    if FlyConnection then
        FlyConnection:Disconnect()
        FlyConnection = nil
    end

    if NoclipConnection then
        NoclipConnection:Disconnect()
        NoclipConnection = nil
    end

    if InfiniteJumpConnection then
        InfiniteJumpConnection:Disconnect()
        InfiniteJumpConnection = nil
    end

    if AntiAFKConnection then
        AntiAFKConnection:Disconnect()
        AntiAFKConnection = nil
    end

    if AutoSprintConnection then
        AutoSprintConnection:Disconnect()
        AutoSprintConnection = nil
    end

    if NightEffect then
        NightEffect:Destroy()
        NightEffect = nil
    end

    UpdateCharacter()

    if Humanoid then

        Humanoid.PlatformStand = false
        Humanoid.WalkSpeed = 16
        Humanoid.UseJumpPower = true
        Humanoid.JumpPower = 50

    end

    if Root then

        Root.Anchored = false
        Root.AssemblyLinearVelocity = Vector3.zero
        Root.AssemblyAngularVelocity = Vector3.zero

    end

    workspace.Gravity = OldGravity
    Camera.FieldOfView = OldFOV

    Lighting.Brightness = OldLighting.Brightness
    Lighting.ClockTime = OldLighting.ClockTime
    Lighting.FogEnd = OldLighting.FogEnd
    Lighting.GlobalShadows = OldLighting.GlobalShadows

    Player.CameraMinZoomDistance = .5
    Player.CameraMaxZoomDistance = 400

    if Character then

        for _,Obj in ipairs(Character:GetDescendants()) do

            if Obj:IsA("BasePart") then
                Obj.LocalTransparencyModifier = 0
                Obj.CanCollide = true
            elseif Obj:IsA("Decal") then
                Obj.Transparency = 0
            end

        end

    end

    for P,Object in pairs(ESPObjects) do

        if Object then
            Object:Destroy()
        end

        ESPObjects[P] = nil

    end

    RemoveTeleportTool()

    PlaySound(CloseSound)

    local Fade = Instance.new("Frame")
    Fade.Size = UDim2.fromScale(1,1)
    Fade.BackgroundColor3 = Color3.fromRGB(3,5,9)
    Fade.BackgroundTransparency = 1
    Fade.BorderSizePixel = 0
    Fade.ZIndex = 999
    Fade.Parent = Gui

    TweenService:Create(
        Fade,
        TweenInfo.new(.35,Enum.EasingStyle.Quart),
        {BackgroundTransparency = 0}
    ):Play()

    task.wait(.4)

    Gui:Destroy()

end

YesButton.MouseButton1Click:Connect(DisableEverything)

--========================================================
-- CLOSE
--========================================================

CloseButton.MouseButton1Click:Connect(function()

    if not ConfirmOpen then
        OpenConfirm()
    end

end)

--========================================================
-- MINIMIZE
--========================================================

MinButton.MouseButton1Click:Connect(function()

    if ConfirmOpen then
        CloseConfirm()
    end

    UIClosed = true

    TweenService:Create(
        MainScale,
        TweenInfo.new(.28,Enum.EasingStyle.Quart,Enum.EasingDirection.In),
        {Scale = .75}
    ):Play()

    TweenService:Create(
        Main,
        TweenInfo.new(.28,Enum.EasingStyle.Quart,Enum.EasingDirection.In),
        {BackgroundTransparency = 1}
    ):Play()

    task.wait(.28)

    Main.Visible = false
    Main.BackgroundTransparency = 0

    Mini.Visible = true
    Mini.Size = UDim2.fromOffset(0,36)

    TweenService:Create(
        Mini,
        TweenInfo.new(.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
        {Size = UDim2.fromOffset(230,36)}
    ):Play()

end)

--========================================================
-- RESTORE
--========================================================

Mini.MouseButton1Click:Connect(function()

    UIClosed = false

    Mini.Visible = false

    Main.Visible = true
    MainScale.Scale = .75

    TweenService:Create(
        MainScale,
        TweenInfo.new(.45,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
        {Scale = 1}
    ):Play()

    PlaySound(OpenSound)

end)

--========================================================
-- LOGIN
--========================================================

Enter.MouseButton1Click:Connect(function()

    if KeyBox.Text == KEY then

        PlaySound(OpenSound)

        KeyStatus.Text = "✓ Erişim onaylandı"
        KeyStatus.TextColor3 = Color3.fromRGB(0,255,150)

        task.wait(.35)

        KeyFrame.Visible = false
        Main.Visible = true

        MainScale.Scale = .72

        TweenService:Create(
            MainScale,
            TweenInfo.new(.6,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
            {Scale = 1}
        ):Play()

    else

        KeyStatus.Text = "✕ Hatalı key"
        KeyStatus.TextColor3 = C.Danger

        KeyBox.Text = ""

        PlaySound(CloseSound)

        local Original = KeyFrame.Position

        TweenService:Create(
            KeyFrame,
            TweenInfo.new(
                .055,
                Enum.EasingStyle.Linear,
                Enum.EasingDirection.InOut,
                4,
                true
            ),
            {
                Position = Original + UDim2.fromOffset(8,0)
            }
        ):Play()

    end

end)

--========================================================
-- CHARACTER UPDATE
--========================================================

Player.CharacterAdded:Connect(function()

    task.wait(.5)

    if Destroyed then
        return
    end

    UpdateCharacter()

    if State.Invisible then
        SetInvisible(true)
    end

    if State.ESP then
        RefreshESP()
    end

    if State.Teleport then
        GiveTeleportTool()
    end

end)

--========================================================
-- FINAL
--========================================================

print("AZAMET HUB LOADED")
