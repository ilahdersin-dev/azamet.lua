--========================================================
-- AZAMET HUB
-- By Zeth
-- Roblox Studio Admin / Test System
--========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Camera = workspace.CurrentCamera

local Character
local Humanoid
local Root

local function RefreshCharacter()
	Character = Player.Character or Player.CharacterAdded:Wait()
	Humanoid = Character:WaitForChild("Humanoid")
	Root = Character:WaitForChild("HumanoidRootPart")
end

RefreshCharacter()

Player.CharacterAdded:Connect(function()
	task.wait(0.5)
	RefreshCharacter()
end)

--========================================================
-- CONFIG
--========================================================

local KEY = "raiderzethvoid"

local MAX_SPEED = 6000

local FlySpeed = 100
local SpinSpeed = 5
local ShakePower = 2
local WalkFlingPower = 120

local OldGravity = workspace.Gravity
local OldFOV = Camera.FieldOfView

local OldLighting = {
	Brightness = Lighting.Brightness,
	ClockTime = Lighting.ClockTime,
	FogEnd = Lighting.FogEnd,
	Ambient = Lighting.Ambient,
	OutdoorAmbient = Lighting.OutdoorAmbient
}

local State = {
	Fly = false,
	ESP = false,
	Invisible = false,
	Noclip = false,
	Fullbright = false,
	InfiniteJump = false,
	Platform = false,
	Coordinates = false,
	FPS = false,
	Ping = false,
	Crosshair = false,
	Compass = false,
	CameraShake = false,
	WalkFling = false,
	AntiAFK = false,
	Atmosphere = false,
	Spin = false
}

local Destroyed = false

--========================================================
-- REMOTES
--========================================================

local AvatarRemote = ReplicatedStorage:WaitForChild(
	"AZAMET_AvatarRemote",
	10
)

local FlingRemote = ReplicatedStorage:WaitForChild(
	"AZAMET_WalkFling",
	10
)

--========================================================
-- SOUND
--========================================================

local function PlaySound(Type)
	local Sound = Instance.new("Sound")

	Sound.SoundId = "rbxasset://sounds/electronicpingshort.wav"
	Sound.Volume = 0.3

	if Type == "Error" then
		Sound.PlaybackSpeed = 0.65
	elseif Type == "Success" then
		Sound.PlaybackSpeed = 1.3
	else
		Sound.PlaybackSpeed = 1
	end

	Sound.Parent = SoundService
	Sound:Play()

	task.delay(2, function()
		if Sound then
			Sound:Destroy()
		end
	end)
end

--========================================================
-- GUI
--========================================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "AZAMET_BY_ZETH"
Gui.ResetOnSpawn = false

-- ÖNEMLİ:
-- Roblox üst barının arkasına gitmemesi için false
Gui.IgnoreGuiInset = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.DisplayOrder = 50
Gui.Parent = PlayerGui

local Scale = Instance.new("UIScale")
Scale.Scale = UIS.TouchEnabled and 0.86 or 0.96
Scale.Parent = Gui

--========================================================
-- KEY PAGE
--========================================================

local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.fromOffset(340,255)
KeyFrame.Position = UDim2.fromScale(0.5,0.5)
KeyFrame.AnchorPoint = Vector2.new(0.5,0.5)
KeyFrame.BackgroundColor3 = Color3.fromRGB(6,10,16)
KeyFrame.BorderSizePixel = 0
KeyFrame.Parent = Gui

local KC = Instance.new("UICorner")
KC.CornerRadius = UDim.new(0,16)
KC.Parent = KeyFrame

local KS = Instance.new("UIStroke")
KS.Color = Color3.fromRGB(0,255,210)
KS.Thickness = 1.5
KS.Parent = KeyFrame

local KTitle = Instance.new("TextLabel")
KTitle.Size = UDim2.new(1,0,0,45)
KTitle.Position = UDim2.fromOffset(0,8)
KTitle.BackgroundTransparency = 1
KTitle.Text = "AZAMET"
KTitle.Font = Enum.Font.GothamBlack
KTitle.TextSize = 28
KTitle.TextColor3 = Color3.fromRGB(0,255,210)
KTitle.Parent = KeyFrame

local KBy = Instance.new("TextLabel")
KBy.Size = UDim2.new(1,0,0,20)
KBy.Position = UDim2.fromOffset(0,48)
KBy.BackgroundTransparency = 1
KBy.Text = "By Zeth"
KBy.Font = Enum.Font.GothamBold
KBy.TextSize = 12
KBy.TextColor3 = Color3.fromRGB(135,150,160)
KBy.Parent = KeyFrame

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(1,-40,0,42)
KeyBox.Position = UDim2.fromOffset(20,78)
KeyBox.BackgroundColor3 = Color3.fromRGB(14,20,29)
KeyBox.PlaceholderText = "KEY GİR..."
KeyBox.Text = ""
KeyBox.PlaceholderColor3 = Color3.fromRGB(100,115,125)
KeyBox.TextColor3 = Color3.new(1,1,1)
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextSize = 13
KeyBox.ClearTextOnFocus = false
KeyBox.Parent = KeyFrame

local KBC = Instance.new("UICorner")
KBC.CornerRadius = UDim.new(0,9)
KBC.Parent = KeyBox

local Login = Instance.new("TextButton")
Login.Size = UDim2.fromOffset(142,40)
Login.Position = UDim2.fromOffset(20,130)
Login.BackgroundColor3 = Color3.fromRGB(0,205,175)
Login.Text = "GİRİŞ"
Login.Font = Enum.Font.GothamBold
Login.TextSize = 13
Login.TextColor3 = Color3.new(0,0,0)
Login.AutoButtonColor = false
Login.Parent = KeyFrame

local LC = Instance.new("UICorner")
LC.CornerRadius = UDim.new(0,9)
LC.Parent = Login

local GetKey = Instance.new("TextButton")
GetKey.Size = UDim2.fromOffset(142,40)
GetKey.Position = UDim2.fromOffset(178,130)
GetKey.BackgroundColor3 = Color3.fromRGB(20,28,38)
GetKey.Text = "🔑 KEY AL"
GetKey.Font = Enum.Font.GothamBold
GetKey.TextSize = 13
GetKey.TextColor3 = Color3.fromRGB(0,255,210)
GetKey.AutoButtonColor = false
GetKey.Parent = KeyFrame

local GKC = Instance.new("UICorner")
GKC.CornerRadius = UDim.new(0,9)
GKC.Parent = GetKey

local KStatus = Instance.new("TextLabel")
KStatus.Size = UDim2.new(1,-30,0,45)
KStatus.Position = UDim2.fromOffset(15,183)
KStatus.BackgroundTransparency = 1
KStatus.Text = "Key gerekli • By Zeth"
KStatus.Font = Enum.Font.Gotham
KStatus.TextSize = 11
KStatus.TextColor3 = Color3.fromRGB(125,140,150)
KStatus.Parent = KeyFrame

GetKey.MouseButton1Click:Connect(function()
	PlaySound("Click")

	if setclipboard then
		setclipboard("https://discord.gg/FNrA9rfCZz")
		KStatus.Text = "Discord daveti kopyalandı!"
	else
		KStatus.Text = "discord.gg/FNrA9rfCZz"
	end

	KStatus.TextColor3 = Color3.fromRGB(0,255,210)
end)

--========================================================
-- MAIN
--========================================================

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(500,390)
Main.Position = UDim2.fromScale(0.5,0.5)
Main.AnchorPoint = Vector2.new(0.5,0.5)
Main.BackgroundColor3 = Color3.fromRGB(5,8,13)
Main.BorderSizePixel = 0
Main.Visible = false
Main.Parent = Gui

local MC = Instance.new("UICorner")
MC.CornerRadius = UDim.new(0,15)
MC.Parent = Main

local MS = Instance.new("UIStroke")
MS.Color = Color3.fromRGB(0,235,200)
MS.Thickness = 1.4
MS.Parent = Main

--========================================================
-- HEADER
--========================================================

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1,0,0,48)
Header.BackgroundColor3 = Color3.fromRGB(9,14,21)
Header.BorderSizePixel = 0
Header.Parent = Main

local HC = Instance.new("UICorner")
HC.CornerRadius = UDim.new(0,15)
HC.Parent = Header

local HeaderTitle = Instance.new("TextLabel")
HeaderTitle.Size = UDim2.new(1,-100,1,0)
HeaderTitle.Position = UDim2.fromOffset(15,0)
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.Text = "AZAMET  •  By Zeth"
HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
HeaderTitle.Font = Enum.Font.GothamBlack
HeaderTitle.TextSize = 16
HeaderTitle.TextColor3 = Color3.fromRGB(0,255,210)
HeaderTitle.Parent = Header

local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.fromOffset(32,30)
Minimize.Position = UDim2.new(1,-72,0,9)
Minimize.BackgroundColor3 = Color3.fromRGB(22,31,41)
Minimize.Text = "—"
Minimize.Font = Enum.Font.GothamBold
Minimize.TextSize = 18
Minimize.TextColor3 = Color3.new(1,1,1)
Minimize.AutoButtonColor = false
Minimize.Parent = Header

local MIC = Instance.new("UICorner")
MIC.CornerRadius = UDim.new(0,7)
MIC.Parent = Minimize

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(30,30)
Close.Position = UDim2.new(1,-36,0,9)
Close.BackgroundColor3 = Color3.fromRGB(120,35,45)
Close.Text = "×"
Close.Font = Enum.Font.GothamBold
Close.TextSize = 19
Close.TextColor3 = Color3.new(1,1,1)
Close.AutoButtonColor = false
Close.Parent = Header

local CIC = Instance.new("UICorner")
CIC.CornerRadius = UDim.new(0,7)
CIC.Parent = Close

--========================================================
-- SCROLL
--========================================================

local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1,-18,1,-60)
Scroll.Position = UDim2.fromOffset(9,54)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.ScrollBarThickness = 4
Scroll.ScrollBarImageColor3 = Color3.fromRGB(0,230,195)
Scroll.CanvasSize = UDim2.new(0,0,0,0)
Scroll.Parent = Main

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0,6)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Layout.Parent = Scroll

local Pad = Instance.new("UIPadding")
Pad.PaddingTop = UDim.new(0,4)
Pad.PaddingBottom = UDim.new(0,15)
Pad.Parent = Scroll

Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	Scroll.CanvasSize = UDim2.fromOffset(
		0,
		Layout.AbsoluteContentSize.Y + 20
	)
end)

--========================================================
-- UI HELPERS
--========================================================

local function Section(Text)
	local L = Instance.new("TextLabel")
	L.Size = UDim2.new(1,-4,0,25)
	L.BackgroundTransparency = 1
	L.Text = "  "..Text
	L.TextXAlignment = Enum.TextXAlignment.Left
	L.Font = Enum.Font.GothamBlack
	L.TextSize = 11
	L.TextColor3 = Color3.fromRGB(0,255,210)
	L.Parent = Scroll
	return L
end

local function Button(Text)
	local B = Instance.new("TextButton")

	B.Size = UDim2.new(1,-4,0,37)
	B.BackgroundColor3 = Color3.fromRGB(13,19,27)
	B.Text = Text
	B.Font = Enum.Font.GothamBold
	B.TextSize = 12
	B.TextColor3 = Color3.fromRGB(230,235,240)
	B.AutoButtonColor = false
	B.Parent = Scroll

	local C = Instance.new("UICorner")
	C.CornerRadius = UDim.new(0,8)
	C.Parent = B

	local S = Instance.new("UIStroke")
	S.Color = Color3.fromRGB(28,39,49)
	S.Thickness = 1
	S.Parent = B

	B.MouseEnter:Connect(function()
		TweenService:Create(
			B,
			TweenInfo.new(.12),
			{BackgroundColor3 = Color3.fromRGB(19,30,38)}
		):Play()
	end)

	B.MouseLeave:Connect(function()
		TweenService:Create(
			B,
			TweenInfo.new(.12),
			{BackgroundColor3 = Color3.fromRGB(13,19,27)}
		):Play()
	end)

	return B
end

local function Input(Placeholder)
	local B = Instance.new("TextBox")

	B.Size = UDim2.new(1,-4,0,35)
	B.BackgroundColor3 = Color3.fromRGB(11,17,24)
	B.PlaceholderText = Placeholder
	B.Text = ""
	B.PlaceholderColor3 = Color3.fromRGB(110,125,135)
	B.TextColor3 = Color3.new(1,1,1)
	B.Font = Enum.Font.Gotham
	B.TextSize = 12
	B.ClearTextOnFocus = false
	B.Parent = Scroll

	local C = Instance.new("UICorner")
	C.CornerRadius = UDim.new(0,8)
	C.Parent = B

	local S = Instance.new("UIStroke")
	S.Color = Color3.fromRGB(27,38,48)
	S.Thickness = 1
	S.Parent = B

	return B
end

--========================================================
-- MOVEMENT
--========================================================

Section("MOVEMENT")

local FlyButton = Button("✈  Fly  [OFF]")
local FlySpeedBox = Input("Fly Speed • 1 - 6000")
local FlySpeedApply = Button("⚡  Fly Speed Uygula")

local FlyVelocity
local FlyConnection

local FlyUp = Instance.new("TextButton")
FlyUp.Size = UDim2.fromOffset(52,52)
FlyUp.Position = UDim2.new(1,-70,1,-135)
FlyUp.BackgroundColor3 = Color3.fromRGB(7,15,22)
FlyUp.Text = "▲"
FlyUp.TextColor3 = Color3.fromRGB(0,255,210)
FlyUp.TextSize = 20
FlyUp.Font = Enum.Font.GothamBlack
FlyUp.Visible = false
FlyUp.ZIndex = 80
FlyUp.Parent = Gui

local FUC = Instance.new("UICorner")
FUC.CornerRadius = UDim.new(1,0)
FUC.Parent = FlyUp

local FlyDown = Instance.new("TextButton")
FlyDown.Size = UDim2.fromOffset(52,52)
FlyDown.Position = UDim2.new(1,-70,1,-72)
FlyDown.BackgroundColor3 = Color3.fromRGB(7,15,22)
FlyDown.Text = "▼"
FlyDown.TextColor3 = Color3.fromRGB(0,255,210)
FlyDown.TextSize = 20
FlyDown.Font = Enum.Font.GothamBlack
FlyDown.Visible = false
FlyDown.ZIndex = 80
FlyDown.Parent = Gui

local FDC = Instance.new("UICorner")
FDC.CornerRadius = UDim.new(1,0)
FDC.Parent = FlyDown

local UpHeld = false
local DownHeld = false

FlyUp.MouseButton1Down:Connect(function()
	UpHeld = true
end)

FlyUp.MouseButton1Up:Connect(function()
	UpHeld = false
end)

FlyDown.MouseButton1Down:Connect(function()
	DownHeld = true
end)

FlyDown.MouseButton1Up:Connect(function()
	DownHeld = false
end)

local function StopFly()
	State.Fly = false
	FlyUp.Visible = false
	FlyDown.Visible = false
	UpHeld = false
	DownHeld = false

	if FlyConnection then
		FlyConnection:Disconnect()
		FlyConnection = nil
	end

	if FlyVelocity then
		FlyVelocity:Destroy()
		FlyVelocity = nil
	end

	if Humanoid then
		Humanoid.PlatformStand = false
	end

	FlyButton.Text = "✈  Fly  [OFF]"
	FlyButton.TextColor3 = Color3.fromRGB(230,235,240)
end

local function StartFly()

	RefreshCharacter()

	State.Fly = true

	FlyButton.Text = "✈  Fly  [ON]"
	FlyButton.TextColor3 = Color3.fromRGB(0,255,210)

	FlyUp.Visible = true
	FlyDown.Visible = true

	if FlyVelocity then
		FlyVelocity:Destroy()
	end

	FlyVelocity = Instance.new("BodyVelocity")
	FlyVelocity.Name = "AZAMET_FlyVelocity"
	FlyVelocity.MaxForce = Vector3.new(
		math.huge,
		math.huge,
		math.huge
	)
	FlyVelocity.P = 30000
	FlyVelocity.Velocity = Vector3.zero
	FlyVelocity.Parent = Root

	Humanoid.PlatformStand = true

	FlyConnection = RunService.RenderStepped:Connect(function()

		if not State.Fly or not Root or not Root.Parent then
			return
		end

		local Direction = Humanoid.MoveDirection

		local Velocity = Vector3.zero

		-- YATAY HAREKET
		if Direction.Magnitude > 0 then
			Velocity += Direction.Unit * FlySpeed
		end

		-- PC YUKARI
		if UIS:IsKeyDown(Enum.KeyCode.Space) then
			Velocity += Vector3.new(0,FlySpeed,0)
		end

		-- PC AŞAĞI
		if UIS:IsKeyDown(Enum.KeyCode.LeftControl)
			or UIS:IsKeyDown(Enum.KeyCode.LeftShift) then

			Velocity -= Vector3.new(0,FlySpeed,0)
		end

		-- MOBİL YUKARI
		if UpHeld then
			Velocity += Vector3.new(0,FlySpeed,0)
		end

		-- MOBİL AŞAĞI
		if DownHeld then
			Velocity -= Vector3.new(0,FlySpeed,0)
		end

		FlyVelocity.Velocity = Velocity
	end)
end

FlyButton.MouseButton1Click:Connect(function()

	PlaySound("Click")

	if State.Fly then
		StopFly()
	else
		StartFly()
	end
end)

FlySpeedApply.MouseButton1Click:Connect(function()

	local N = tonumber(FlySpeedBox.Text)

	if N then

		FlySpeed = math.clamp(N,1,MAX_SPEED)

		FlySpeedBox.Text = ""

		PlaySound("Success")
	end
end)

--========================================================
-- WALKSPEED
--========================================================

local WalkBox = Input("WalkSpeed • 1 - 6000")
local WalkApply = Button("🏃  WalkSpeed Uygula")

WalkApply.MouseButton1Click:Connect(function()

	local N = tonumber(WalkBox.Text)

	if N and Humanoid then

		Humanoid.WalkSpeed =
			math.clamp(N,1,MAX_SPEED)

		WalkBox.Text = ""

		PlaySound("Success")
	end
end)

--========================================================
-- JUMP
--========================================================

local JumpBox = Input("JumpPower • 1 - 6000")
local JumpApply = Button("🦘  JumpPower Uygula")

JumpApply.MouseButton1Click:Connect(function()

	local N = tonumber(JumpBox.Text)

	if N and Humanoid then

		Humanoid.UseJumpPower = true
		Humanoid.JumpPower =
			math.clamp(N,1,MAX_SPEED)

		JumpBox.Text = ""

		PlaySound("Success")
	end
end)

--========================================================
-- NOCLIP
--========================================================

local NoclipButton = Button("🚫  Noclip  [OFF]")

NoclipButton.MouseButton1Click:Connect(function()

	State.Noclip = not State.Noclip

	NoclipButton.Text =
		"🚫  Noclip  [" ..
		(State.Noclip and "ON" or "OFF") .. "]"

	NoclipButton.TextColor3 =
		State.Noclip
		and Color3.fromRGB(0,255,210)
		or Color3.fromRGB(230,235,240)
end)

--========================================================
-- INFINITE JUMP
--========================================================

local InfiniteButton =
	Button("🦘  Infinite Jump  [OFF]")

InfiniteButton.MouseButton1Click:Connect(function()

	State.InfiniteJump =
		not State.InfiniteJump

	InfiniteButton.Text =
		"🦘  Infinite Jump  [" ..
		(State.InfiniteJump and "ON" or "OFF") .. "]"

	InfiniteButton.TextColor3 =
		State.InfiniteJump
		and Color3.fromRGB(0,255,210)
		or Color3.fromRGB(230,235,240)
end)

UIS.JumpRequest:Connect(function()

	if State.InfiniteJump and Humanoid then
		Humanoid:ChangeState(
			Enum.HumanoidStateType.Jumping
		)
	end
end)

--========================================================
-- SPIN
--========================================================

local SpinButton = Button("🌀  Spin  [OFF]")
local SpinSpeedBox = Input("Spin Speed • 1 - 6000")
local SpinApply = Button("🌀  Spin Speed Uygula")

SpinButton.MouseButton1Click:Connect(function()

	State.Spin = not State.Spin

	SpinButton.Text =
		"🌀  Spin  [" ..
		(State.Spin and "ON" or "OFF") .. "]"

	SpinButton.TextColor3 =
		State.Spin
		and Color3.fromRGB(0,255,210)
		or Color3.fromRGB(230,235,240)
end)

SpinApply.MouseButton1Click:Connect(function()

	local N = tonumber(SpinSpeedBox.Text)

	if N then

		SpinSpeed =
			math.clamp(N,1,MAX_SPEED)

		SpinSpeedBox.Text = ""

		PlaySound("Success")
	end
end)

--========================================================
-- SIT
--========================================================

local SitButton = Button("🪑  Sit / Stand")

SitButton.MouseButton1Click:Connect(function()

	if Humanoid then
		Humanoid.Sit = not Humanoid.Sit
	end
end)

--========================================================
-- PLATFORM
--========================================================

local Platform
local PlatformButton =
	Button("🟦  Character Platform  [OFF]")

PlatformButton.MouseButton1Click:Connect(function()

	State.Platform = not State.Platform

	if State.Platform then

		Platform = Instance.new("Part")
		Platform.Name = "AZAMET_Platform"
		Platform.Size = Vector3.new(7,0.4,7)
		Platform.Anchored = true
		Platform.CanCollide = true
		Platform.Material = Enum.Material.Neon
		Platform.Transparency = 0.25
		Platform.Parent = workspace

	else

		if Platform then
			Platform:Destroy()
			Platform = nil
		end
	end

	PlatformButton.Text =
		"🟦  Character Platform  [" ..
		(State.Platform and "ON" or "OFF") .. "]"
end)

--========================================================
-- VISUAL
--========================================================

Section("VISUAL")

--========================================================
-- ESP
--========================================================

local ESPButton = Button("👁  ESP  [OFF]")
local ESPObjects = {}

local function ClearESP()

	for _,Object in ipairs(ESPObjects) do
		if Object then
			Object:Destroy()
		end
	end

	table.clear(ESPObjects)
end

local function ApplyESP()

	ClearESP()

	if not State.ESP then
		return
	end

	for _,Target in ipairs(Players:GetPlayers()) do

		if Target ~= Player
			and Target.Character then

			local H = Instance.new("Highlight")

			H.FillTransparency = 0.65
			H.OutlineColor =
				Color3.fromRGB(0,255,210)

			H.FillColor =
				Color3.fromRGB(0,170,150)

			H.Adornee =
				Target.Character

			H.Parent =
				Target.Character

			table.insert(ESPObjects,H)
		end
	end
end

ESPButton.MouseButton1Click:Connect(function()

	State.ESP = not State.ESP

	ESPButton.Text =
		"👁  ESP  [" ..
		(State.ESP and "ON" or "OFF") .. "]"

	ESPButton.TextColor3 =
		State.ESP
		and Color3.fromRGB(0,255,210)
		or Color3.fromRGB(230,235,240)

	ApplyESP()
end)

--========================================================
-- INVISIBLE
--========================================================

local InvisibleButton =
	Button("👻  Invisible  [OFF]")

InvisibleButton.MouseButton1Click:Connect(function()

	State.Invisible =
		not State.Invisible

	if Character then

		for _,Object in ipairs(
			Character:GetDescendants()
		) do

			if Object:IsA("BasePart") then
				Object.LocalTransparencyModifier =
					State.Invisible and 1 or 0
			end
		end
	end

	InvisibleButton.Text =
		"👻  Invisible  [" ..
		(State.Invisible and "ON" or "OFF") .. "]"

	InvisibleButton.TextColor3 =
		State.Invisible
		and Color3.fromRGB(0,255,210)
		or Color3.fromRGB(230,235,240)
end)

--========================================================
-- FULLBRIGHT
--========================================================

local FullbrightButton =
	Button("💡  Fullbright  [OFF]")

FullbrightButton.MouseButton1Click:Connect(function()

	State.Fullbright =
		not State.Fullbright

	if State.Fullbright then

		Lighting.Brightness = 3
		Lighting.ClockTime = 14
		Lighting.FogEnd = 100000
		Lighting.Ambient = Color3.new(1,1,1)
		Lighting.OutdoorAmbient = Color3.new(1,1,1)

	else

		Lighting.Brightness =
			OldLighting.Brightness

		Lighting.ClockTime =
			OldLighting.ClockTime

		Lighting.FogEnd =
			OldLighting.FogEnd

		Lighting.Ambient =
			OldLighting.Ambient

		Lighting.OutdoorAmbient =
			OldLighting.OutdoorAmbient
	end

	FullbrightButton.Text =
		"💡  Fullbright  [" ..
		(State.Fullbright and "ON" or "OFF") .. "]"
end)

--========================================================
-- FOV
--========================================================

local FOVBox = Input("Camera FOV • 40 - 120")
local FOVApply = Button("🎥  Camera FOV Uygula")

FOVApply.MouseButton1Click:Connect(function()

	local N = tonumber(FOVBox.Text)

	if N then

		Camera.FieldOfView =
			math.clamp(N,40,120)

		FOVBox.Text = ""

		PlaySound("Success")
	end
end)

--========================================================
-- ZOOM
--========================================================

local ZoomBox = Input("Camera Zoom Max • 5 - 6000")
local ZoomApply = Button("🔭  Camera Zoom Uygula")

ZoomApply.MouseButton1Click:Connect(function()

	local N = tonumber(ZoomBox.Text)

	if N then

		Player.CameraMaxZoomDistance =
			math.clamp(N,5,MAX_SPEED)

		ZoomBox.Text = ""

		PlaySound("Success")
	end
end)

--========================================================
-- CAMERA SHAKE
--========================================================

local ShakeButton =
	Button("🎬  Camera Shake  [OFF]")

local ShakePowerBox =
	Input("Shake Power • 1 - 6000")

local ShakeApply =
	Button("🎬  Shake Power Uygula")

ShakeButton.MouseButton1Click:Connect(function()

	State.CameraShake =
		not State.CameraShake

	ShakeButton.Text =
		"🎬  Camera Shake  [" ..
		(State.CameraShake and "ON" or "OFF") .. "]"
end)

ShakeApply.MouseButton1Click:Connect(function()

	local N = tonumber(ShakePowerBox.Text)

	if N then

		ShakePower =
			math.clamp(N,1,MAX_SPEED)

		ShakePowerBox.Text = ""

		PlaySound("Success")
	end
end)

--========================================================
-- WORLD
--========================================================

Section("WORLD")

local GravityBox = Input("Gravity • 0 - 6000")
local GravityApply = Button("🪐  Gravity Uygula")

GravityApply.MouseButton1Click:Connect(function()

	local N = tonumber(GravityBox.Text)

	if N then

		workspace.Gravity =
			math.clamp(N,0,MAX_SPEED)

		GravityBox.Text = ""

		PlaySound("Success")
	end
end)

local TimeBox = Input("ClockTime • 0 - 24")
local TimeApply = Button("🌅  Time Changer")

TimeApply.MouseButton1Click:Connect(function()

	local N = tonumber(TimeBox.Text)

	if N then

		Lighting.ClockTime =
			math.clamp(N,0,24)

		TimeBox.Text = ""

		PlaySound("Success")
	end
end)

local AtmosButton =
	Button("🌫  Atmosphere  [OFF]")

AtmosButton.MouseButton1Click:Connect(function()

	State.Atmosphere =
		not State.Atmosphere

	local Atmos =
		Lighting:FindFirstChildOfClass("Atmosphere")

	if State.Atmosphere then

		if not Atmos then

			Atmos = Instance.new("Atmosphere")
			Atmos.Parent = Lighting
		end

		Atmos.Density = 0.35
		Atmos.Haze = 1

	else

		if Atmos then
			Atmos.Density = 0
		end
	end

	AtmosButton.Text =
		"🌫  Atmosphere  [" ..
		(State.Atmosphere and "ON" or "OFF") .. "]"
end)

--========================================================
-- AVATAR
--========================================================

Section("AVATAR")

local HeadlessButton =
	Button("💀  Headless  [OFF]")

local KorbloxButton =
	Button("🦿  Korblox  [OFF]")

local NormalAvatarButton =
	Button("👤  Normal Avatar")

HeadlessButton.MouseButton1Click:Connect(function()

	if AvatarRemote then
		AvatarRemote:FireServer("Headless",true)
	end

	HeadlessButton.Text = "💀  Headless  [ON]"
	KorbloxButton.Text = "🦿  Korblox  [OFF]"

	PlaySound("Success")
end)

KorbloxButton.MouseButton1Click:Connect(function()

	if AvatarRemote then
		AvatarRemote:FireServer("Korblox",true)
	end

	KorbloxButton.Text = "🦿  Korblox  [ON]"
	HeadlessButton.Text = "💀  Headless  [OFF]"

	PlaySound("Success")
end)

NormalAvatarButton.MouseButton1Click:Connect(function()

	if AvatarRemote then
		AvatarRemote:FireServer("Normal",true)
	end

	HeadlessButton.Text = "💀  Headless  [OFF]"
	KorbloxButton.Text = "🦿  Korblox  [OFF]"

	PlaySound("Success")
end)

--========================================================
-- ANIMATIONS
--========================================================

Section("ANIMATIONS")

local ZombieButton =
	Button("🧟  Zombie Animation")

local NinjaButton =
	Button("🥷  Ninja Animation")

local RobotButton =
	Button("🤖  Robot Animation")

local NormalAnimationButton =
	Button("👤  Normal Animation")

local function Animation(Name)

	if AvatarRemote then
		AvatarRemote:FireServer(
			"Animation",
			Name
		)

		PlaySound("Success")
	end
end

ZombieButton.MouseButton1Click:Connect(function()
	Animation("Zombie")
end)

NinjaButton.MouseButton1Click:Connect(function()
	Animation("Ninja")
end)

RobotButton.MouseButton1Click:Connect(function()
	Animation("Robot")
end)

NormalAnimationButton.MouseButton1Click:Connect(function()
	Animation("Normal")
end)

--========================================================
-- MONITOR
--========================================================

Section("MONITOR")

local CoordLabel = Instance.new("TextLabel")
CoordLabel.Size = UDim2.fromOffset(230,55)
CoordLabel.Position = UDim2.fromOffset(10,65)
CoordLabel.BackgroundColor3 = Color3.fromRGB(4,9,14)
CoordLabel.BackgroundTransparency = 0.15
CoordLabel.Text = ""
CoordLabel.TextColor3 = Color3.fromRGB(0,255,210)
CoordLabel.Font = Enum.Font.Code
CoordLabel.TextSize = 11
CoordLabel.TextXAlignment = Enum.TextXAlignment.Left
CoordLabel.Visible = false
CoordLabel.ZIndex = 40
CoordLabel.Parent = Gui

local CCC = Instance.new("UICorner")
CCC.CornerRadius = UDim.new(0,8)
CCC.Parent = CoordLabel

local CoordButton =
	Button("📍  Coordinates HUD  [OFF]")

CoordButton.MouseButton1Click:Connect(function()

	State.Coordinates =
		not State.Coordinates

	CoordLabel.Visible =
		State.Coordinates

	CoordButton.Text =
		"📍  Coordinates HUD  [" ..
		(State.Coordinates and "ON" or "OFF") .. "]"
end)

local FPSLabel = Instance.new("TextLabel")
FPSLabel.Size = UDim2.fromOffset(120,28)
FPSLabel.Position = UDim2.new(1,-130,0,10)
FPSLabel.BackgroundColor3 = Color3.fromRGB(4,9,14)
FPSLabel.BackgroundTransparency = 0.15
FPSLabel.TextColor3 = Color3.fromRGB(0,255,210)
FPSLabel.Font = Enum.Font.Code
FPSLabel.TextSize = 11
FPSLabel.Visible = false
FPSLabel.ZIndex = 40
FPSLabel.Parent = Gui

local FC = Instance.new("UICorner")
FC.CornerRadius = UDim.new(0,7)
FC.Parent = FPSLabel

local FPSButton =
	Button("📊  FPS Counter  [OFF]")

FPSButton.MouseButton1Click:Connect(function()

	State.FPS = not State.FPS

	FPSLabel.Visible =
		State.FPS

	FPSButton.Text =
		"📊  FPS Counter  [" ..
		(State.FPS and "ON" or "OFF") .. "]"
end)

local PingLabel = Instance.new("TextLabel")
PingLabel.Size = UDim2.fromOffset(120,28)
PingLabel.Position = UDim2.new(1,-130,0,42)
PingLabel.BackgroundColor3 = Color3.fromRGB(4,9,14)
PingLabel.BackgroundTransparency = 0.15
PingLabel.TextColor3 = Color3.fromRGB(0,255,210)
PingLabel.Font = Enum.Font.Code
PingLabel.TextSize = 11
PingLabel.Visible = false
PingLabel.ZIndex = 40
PingLabel.Parent = Gui

local PC = Instance.new("UICorner")
PC.CornerRadius = UDim.new(0,7)
PC.Parent = PingLabel

local PingButton =
	Button("📡  Ping Counter  [OFF]")

PingButton.MouseButton1Click:Connect(function()

	State.Ping = not State.Ping

	PingLabel.Visible =
		State.Ping

	PingButton.Text =
		"📡  Ping Counter  [" ..
		(State.Ping and "ON" or "OFF") .. "]"
end)

--========================================================
-- CROSSHAIR
--========================================================

local CrossButton =
	Button("🎯  Crosshair  [OFF]")

local Crosshair

CrossButton.MouseButton1Click:Connect(function()

	State.Crosshair =
		not State.Crosshair

	if State.Crosshair then

		Crosshair = Instance.new("TextLabel")
		Crosshair.Size = UDim2.fromOffset(30,30)
		Crosshair.Position = UDim2.fromScale(.5,.5)
		Crosshair.AnchorPoint = Vector2.new(.5,.5)
		Crosshair.BackgroundTransparency = 1
		Crosshair.Text = "+"
		Crosshair.Font = Enum.Font.GothamBlack
		Crosshair.TextSize = 24
		Crosshair.TextColor3 =
			Color3.fromRGB(0,255,210)
		Crosshair.ZIndex = 70
		Crosshair.Parent = Gui

	else

		if Crosshair then
			Crosshair:Destroy()
			Crosshair = nil
		end
	end

	CrossButton.Text =
		"🎯  Crosshair  [" ..
		(State.Crosshair and "ON" or "OFF") .. "]"
end)

--========================================================
-- COMPASS
--========================================================

local CompassButton =
	Button("🧭  Compass  [OFF]")

local Compass

CompassButton.MouseButton1Click:Connect(function()

	State.Compass =
		not State.Compass

	if State.Compass then

		Compass = Instance.new("TextLabel")
		Compass.Size = UDim2.fromOffset(160,28)
		Compass.Position = UDim2.fromScale(.5,0)
		Compass.AnchorPoint = Vector2.new(.5,0)
		Compass.BackgroundColor3 =
			Color3.fromRGB(4,9,14)
		Compass.BackgroundTransparency = .15
		Compass.Text = "N     E     S     W"
		Compass.Font = Enum.Font.GothamBold
		Compass.TextSize = 11
		Compass.TextColor3 =
			Color3.fromRGB(0,255,210)
		Compass.ZIndex = 70
		Compass.Parent = Gui

		local C = Instance.new("UICorner")
		C.CornerRadius = UDim.new(0,8)
		C.Parent = Compass

	else

		if Compass then
			Compass:Destroy()
			Compass = nil
		end
	end

	CompassButton.Text =
		"🧭  Compass  [" ..
		(State.Compass and "ON" or "OFF") .. "]"
end)

--========================================================
-- ADMIN
--========================================================

Section("ADMIN")

local FlingButton =
	Button("💥  Walk Fling  [OFF]")

local FlingPowerBox =
	Input("Fling Power • 1 - 6000")

local FlingPowerApply =
	Button("💥  Fling Power Uygula")

FlingButton.MouseButton1Click:Connect(function()

	State.WalkFling =
		not State.WalkFling

	FlingButton.Text =
		"💥  Walk Fling  [" ..
		(State.WalkFling and "ON" or "OFF") .. "]"

	if FlingRemote then
		FlingRemote:FireServer(
			State.WalkFling,
			WalkFlingPower
		)
	end
end)

FlingPowerApply.MouseButton1Click:Connect(function()

	local N = tonumber(FlingPowerBox.Text)

	if N then

		WalkFlingPower =
			math.clamp(N,1,MAX_SPEED)

		FlingPowerBox.Text = ""

		if State.WalkFling
			and FlingRemote then

			FlingRemote:FireServer(
				true,
				WalkFlingPower
			)
		end

		PlaySound("Success")
	end
end)

local AntiAFKButton =
	Button("⏱  Anti-AFK  [OFF]")

AntiAFKButton.MouseButton1Click:Connect(function()

	State.AntiAFK =
		not State.AntiAFK

	AntiAFKButton.Text =
		"⏱  Anti-AFK  [" ..
		(State.AntiAFK and "ON" or "OFF") .. "]"
end)

Player.Idled:Connect(function()

	if State.AntiAFK then

		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(
			Vector2.new()
		)
	end
end)

local ResetButton =
	Button("🔄  Reset Character")

ResetButton.MouseButton1Click:Connect(function()

	if Humanoid then
		Humanoid.Health = 0
	end
end)

--========================================================
-- RENDER
--========================================================

local LastFPS = tick()
local Frames = 0
local FPS = 0
local ShakeTime = 0

RunService.RenderStepped:Connect(function(dt)

	if Destroyed then
		return
	end

	Frames += 1

	if tick() - LastFPS >= 1 then
		FPS = Frames
		Frames = 0
		LastFPS = tick()
	end

	-- Noclip
	if State.Noclip and Character then

		for _,Object in ipairs(
			Character:GetDescendants()
		) do

			if Object:IsA("BasePart") then
				Object.CanCollide = false
			end
		end
	end

	-- Platform
	if State.Platform
		and Platform
		and Root then

		Platform.CFrame =
			CFrame.new(
				Root.Position.X,
				Root.Position.Y - 3.2,
				Root.Position.Z
			)
	end

	-- Spin
	if State.Spin and Root then

		Root.CFrame =
			Root.CFrame *
			CFrame.Angles(
				0,
				math.rad(SpinSpeed),
				0
			)
	end

	-- Coordinates
	if State.Coordinates and Root then

		local P = Root.Position

		CoordLabel.Text =
			string.format(
				"  X %.1f\n  Y %.1f\n  Z %.1f",
				P.X,
				P.Y,
				P.Z
			)
	end

	-- FPS
	if State.FPS then
		FPSLabel.Text =
			"FPS: "..FPS
	end

	-- Ping
	if State.Ping then

		local Ping =
			math.floor(
				Player:GetNetworkPing() * 1000
			)

		PingLabel.Text =
			"Ping: "..Ping.." ms"
	end

	-- Camera shake
	if State.CameraShake then

		ShakeTime += dt * 12

		local X =
			math.sin(ShakeTime)
			* ShakePower / 100

		local Y =
			math.cos(ShakeTime * 1.3)
			* ShakePower / 100

		Camera.CFrame =
			Camera.CFrame *
			CFrame.Angles(X,Y,0)
	end
end)

--========================================================
-- DRAG
--========================================================

local Dragging = false
local DragStart
local StartPos

Header.InputBegan:Connect(function(Input)

	if Input.UserInputType ==
		Enum.UserInputType.MouseButton1
		or Input.UserInputType ==
		Enum.UserInputType.Touch then

		Dragging = true
		DragStart = Input.Position
		StartPos = Main.Position

		Input.Changed:Connect(function()

			if Input.UserInputState ==
				Enum.UserInputState.End then

				Dragging = false
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(Input)

	if not Dragging then
		return
	end

	if Input.UserInputType ==
		Enum.UserInputType.MouseMovement
		or Input.UserInputType ==
		Enum.UserInputType.Touch then

		local Delta =
			Input.Position - DragStart

		Main.Position =
			UDim2.new(
				StartPos.X.Scale,
				StartPos.X.Offset + Delta.X,
				StartPos.Y.Scale,
				StartPos.Y.Offset + Delta.Y
			)
	end
end)

--========================================================
-- MINIMIZE
--========================================================

local Mini = Instance.new("TextButton")
Mini.Size = UDim2.fromOffset(180,34)

-- artık ekranın en üstüne değil,
-- Roblox topbar inset'inin ALTINA geliyor
Mini.Position = UDim2.fromOffset(10,10)

Mini.BackgroundColor3 = Color3.fromRGB(6,11,17)
Mini.Text = "──── AZAMET • By Zeth ────"
Mini.Font = Enum.Font.GothamBold
Mini.TextSize = 10
Mini.TextColor3 = Color3.fromRGB(0,255,210)
Mini.AutoButtonColor = false
Mini.Visible = false
Mini.ZIndex = 90
Mini.Parent = Gui

local MiniC = Instance.new("UICorner")
MiniC.CornerRadius = UDim.new(0,8)
MiniC.Parent = Mini

Minimize.MouseButton1Click:Connect(function()

	PlaySound("Click")

	Main.Visible = false
	Mini.Visible = true
end)

Mini.MouseButton1Click:Connect(function()

	PlaySound("Click")

	Mini.Visible = false
	Main.Visible = true
end)

--========================================================
-- CLOSE MODAL
--========================================================

local Overlay = Instance.new("Frame")
Overlay.Size = UDim2.fromScale(1,1)
Overlay.BackgroundColor3 = Color3.new(0,0,0)
Overlay.BackgroundTransparency = .45
Overlay.Visible = false
Overlay.ZIndex = 100
Overlay.Parent = Gui

local Confirm = Instance.new("Frame")
Confirm.Size = UDim2.fromOffset(310,170)
Confirm.Position = UDim2.fromScale(.5,.5)
Confirm.AnchorPoint = Vector2.new(.5,.5)
Confirm.BackgroundColor3 = Color3.fromRGB(7,11,17)
Confirm.Visible = false
Confirm.ZIndex = 101
Confirm.Parent = Gui

local ConC = Instance.new("UICorner")
ConC.CornerRadius = UDim.new(0,13)
ConC.Parent = Confirm

local ConS = Instance.new("UIStroke")
ConS.Color = Color3.fromRGB(0,255,210)
ConS.Thickness = 1.3
ConS.Parent = Confirm

local CT = Instance.new("TextLabel")
CT.Size = UDim2.new(1,0,0,40)
CT.BackgroundTransparency = 1
CT.Text = "UI'Yİ KAPAT?"
CT.Font = Enum.Font.GothamBlack
CT.TextSize = 18
CT.TextColor3 = Color3.fromRGB(0,255,210)
CT.ZIndex = 102
CT.Parent = Confirm

local CX = Instance.new("TextLabel")
CX.Size = UDim2.new(1,-20,0,50)
CX.Position = UDim2.fromOffset(10,42)
CX.BackgroundTransparency = 1
CX.Text = "Emin misin?\nAktif özellikler kapatılacak."
CX.Font = Enum.Font.Gotham
CX.TextSize = 12
CX.TextColor3 = Color3.fromRGB(175,185,195)
CX.ZIndex = 102
CX.Parent = Confirm

local No = Instance.new("TextButton")
No.Size = UDim2.fromOffset(125,38)
No.Position = UDim2.fromOffset(20,115)
No.BackgroundColor3 = Color3.fromRGB(27,36,46)
No.Text = "HAYIR"
No.Font = Enum.Font.GothamBold
No.TextSize = 12
No.TextColor3 = Color3.new(1,1,1)
No.ZIndex = 102
No.Parent = Confirm

local NOC = Instance.new("UICorner")
NOC.CornerRadius = UDim.new(0,8)
NOC.Parent = No

local Yes = Instance.new("TextButton")
Yes.Size = UDim2.fromOffset(125,38)
Yes.Position = UDim2.fromOffset(165,115)
Yes.BackgroundColor3 = Color3.fromRGB(125,35,45)
Yes.Text = "EVET"
Yes.Font = Enum.Font.GothamBold
Yes.TextSize = 12
Yes.TextColor3 = Color3.new(1,1,1)
Yes.ZIndex = 102
Yes.Parent = Confirm

local YEC = Instance.new("UICorner")
YEC.CornerRadius = UDim.new(0,8)
YEC.Parent = Yes

Close.MouseButton1Click:Connect(function()

	PlaySound("Click")

	Overlay.Visible = true
	Confirm.Visible = true
end)

No.MouseButton1Click:Connect(function()

	Confirm.Visible = false
	Overlay.Visible = false
end)

Yes.MouseButton1Click:Connect(function()

	Destroyed = true

	StopFly()

	if FlingRemote then
		FlingRemote:FireServer(false,0)
	end

	if Platform then
		Platform:Destroy()
	end

	ClearESP()

	workspace.Gravity = OldGravity
	Camera.FieldOfView = OldFOV

	Lighting.Brightness = OldLighting.Brightness
	Lighting.ClockTime = OldLighting.ClockTime
	Lighting.FogEnd = OldLighting.FogEnd
	Lighting.Ambient = OldLighting.Ambient
	Lighting.OutdoorAmbient = OldLighting.OutdoorAmbient

	if Crosshair then
		Crosshair:Destroy()
	end

	if Compass then
		Compass:Destroy()
	end

	Gui:Destroy()
end)

--========================================================
-- LOGIN
--========================================================

Login.MouseButton1Click:Connect(function()

	if KeyBox.Text == KEY then

		PlaySound("Success")

		KStatus.Text = "KEY DOĞRU • By Zeth"
		KStatus.TextColor3 =
			Color3.fromRGB(0,255,210)

		task.wait(.25)

		KeyFrame.Visible = false
		Main.Visible = true

	else

		PlaySound("Error")

		KStatus.Text = "Hatalı key!"
		KStatus.TextColor3 =
			Color3.fromRGB(255,70,80)

		local P = KeyFrame.Position

		for i = 1,4 do

			KeyFrame.Position =
				P + UDim2.fromOffset(7,0)

			task.wait(.035)

			KeyFrame.Position =
				P - UDim2.fromOffset(7,0)

			task.wait(.035)
		end

		KeyFrame.Position = P
	end
end)

print("AZAMET • By Zeth loaded")



--========================================================
-- AZAMET SERVER
-- By Zeth
-
--========================================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--========================================================
-- REMOTES
--========================================================

local AvatarRemote =
	ReplicatedStorage:FindFirstChild(
		"AZAMET_AvatarRemote"
	)

if not AvatarRemote then

	AvatarRemote =
		Instance.new("RemoteEvent")

	AvatarRemote.Name =
		"AZAMET_AvatarRemote"

	AvatarRemote.Parent =
		ReplicatedStorage
end

local FlingRemote =
	ReplicatedStorage:FindFirstChild(
		"AZAMET_WalkFling"
	)

if not FlingRemote then

	FlingRemote =
		Instance.new("RemoteEvent")

	FlingRemote.Name =
		"AZAMET_WalkFling"

	FlingRemote.Parent =
		ReplicatedStorage
end

--========================================================
-- SETTINGS
--========================================================

local FlingStates = {}

local MAX_FLING = 6000

--========================================================
-- AVATAR
--========================================================

local function GetHumanoid(Player)

	local Character =
		Player.Character

	if not Character then
		return nil
	end

	return Character:FindFirstChildOfClass(
		"Humanoid"
	)
end

local function ApplyDescription(Player,Description)

	local Humanoid =
		GetHumanoid(Player)

	if not Humanoid then
		return
	end

	local Success,Error =
		pcall(function()

			Humanoid:ApplyDescription(
				Description
			)
		end)

	if not Success then
		warn(
			"[AZAMET] Avatar error:",
			Error
		)
	end
end

--========================================================
-- HEADLESS
--========================================================

local function Headless(Player)

	local Humanoid =
		GetHumanoid(Player)

	if not Humanoid then
		return
	end

	local Success,Description =
		pcall(function()
			return Players:GetHumanoidDescriptionFromUserId(
				Player.UserId
			)
		end)

	if not Success or not Description then
		return
	end

	-- Roblox Headless Head asset
	Description.Head =
		134082579

	ApplyDescription(
		Player,
		Description
	)
end

--========================================================
-- KORBLOX
--========================================================

local function Korblox(Player)

	local Humanoid =
		GetHumanoid(Player)

	if not Humanoid then
		return
	end

	local Success,Description =
		pcall(function()
			return Players:GetHumanoidDescriptionFromUserId(
				Player.UserId
			)
		end)

	if not Success or not Description then
		return
	end

	-- Korblox right leg
	Description.RightLeg =
		139607718

	ApplyDescription(
		Player,
		Description
	)
end

--========================================================
-- NORMAL
--========================================================

local function Normal(Player)

	local Success,Description =
		pcall(function()
			return Players:GetHumanoidDescriptionFromUserId(
				Player.UserId
			)
		end)

	if Success and Description then
		ApplyDescription(
			Player,
			Description
		)
	end
end

--========================================================
-- ANIMATION
--========================================================

local Animations = {

	Zombie = {
		Idle = "rbxassetid://616006778",
		Walk = "rbxassetid://616013216",
		Run = "rbxassetid://616010382"
	},

	Ninja = {
		Idle = "rbxassetid://656117400",
		Walk = "rbxassetid://656121766",
		Run = "rbxassetid://656118852"
	},

	Robot = {
		Idle = "rbxassetid://616088211",
		Walk = "rbxassetid://616095330",
		Run = "rbxassetid://616091570"
	}
}

local function ApplyAnimation(Player,Name)

	local Data =
		Animations[Name]

	if not Data then
		return
	end

	local Character =
		Player.Character

	if not Character then
		return
	end

	local Animate =
		Character:FindFirstChild(
			"Animate"
		)

	if not Animate then
		return
	end

	local Idle =
		Animate:FindFirstChild("idle")

	local Walk =
		Animate:FindFirstChild("walk")

	local Run =
		Animate:FindFirstChild("run")

	local function ReplaceAnimation(
		Folder,
		AnimationId
	)

		if not Folder then
			return
		end

		local Animation =
			Folder:FindFirstChildOfClass(
				"Animation"
			)

		if Animation then
			Animation.AnimationId =
				AnimationId
		end
	end

	ReplaceAnimation(
		Idle,
		Data.Idle
	)

	ReplaceAnimation(
		Walk,
		Data.Walk
	)

	ReplaceAnimation(
		Run,
		Data.Run
	)

	-- Animate script'i yeniden başlat
	Animate.Disabled = true
	task.wait()
	Animate.Disabled = false
end

local function NormalAnimation(Player)

	local Character =
		Player.Character

	if not Character then
		return
	end

	local Animate =
		Character:FindFirstChild(
			"Animate"
		)

	if not Animate then
		return
	end

	-- Varsayılan R15/R6 animasyonlarını yeniden yüklemek
	-- için karakteri yeniden spawn ettirmiyoruz.
	-- Mevcut Animate script'i yeniden etkinleştiriliyor.
	Animate.Disabled = true
	task.wait()
	Animate.Disabled = false
end

--========================================================
-- REMOTE
--========================================================

AvatarRemote.OnServerEvent:Connect(
	function(Player,Action,Value)

		if Action == "Headless" then

			Headless(Player)

		elseif Action == "Korblox" then

			Korblox(Player)

		elseif Action == "Normal" then

			Normal(Player)

		elseif Action == "Animation" then

			if Value == "Zombie"
				or Value == "Ninja"
				or Value == "Robot" then

				ApplyAnimation(
					Player,
					Value
				)

			elseif Value == "Normal" then

				NormalAnimation(Player)
			end
		end
	end
)

--========================================================
-- WALK FLING
--========================================================

local function GetRoot(Character)

	if not Character then
		return nil
	end

	return Character:FindFirstChild(
		"HumanoidRootPart"
	)
end

FlingRemote.OnServerEvent:Connect(
	function(Player,Enabled,Power)

		if Enabled ~= true then

			FlingStates[Player] = nil
			return
		end

		Power =
			math.clamp(
				tonumber(Power) or 120,
				1,
				MAX_FLING
			)

		FlingStates[Player] =
			Power
	end
)

--========================================================
-- FLING LOOP
--========================================================

local Heartbeat =
	game:GetService("RunService").Heartbeat

Heartbeat:Connect(function()

	for Player,Power in pairs(
		FlingStates
	) do

		if not Player.Parent then

			FlingStates[Player] = nil

			continue
		end

		local Character =
			Player.Character

		local Root =
			GetRoot(Character)

		if not Root then
			continue
		end

		for _,Target in ipairs(
			Players:GetPlayers()
		) do

			if Target ~= Player then

				local TargetCharacter =
					Target.Character

				local TargetRoot =
					GetRoot(TargetCharacter)

				if TargetRoot then

					local Difference =
						TargetRoot.Position -
						Root.Position

					local Distance =
						Difference.Magnitude

					if Distance <= 5 then

						local Direction

						if Distance < 0.1 then

							Direction =
								Root.CFrame.LookVector

						else

							Direction =
								Difference.Unit
						end

						TargetRoot.AssemblyLinearVelocity =
							Direction * Power +
							Vector3.new(
								0,
								math.min(
									Power * .55,
									3000
								),
								0
							)
					end
				end
			end
		end
	end
end)

--========================================================
-- CLEANUP
--========================================================

Players.PlayerRemoving:Connect(function(Player)
	FlingStates[Player] = nil
end)

print("AZAMET SERVER • By Zeth loaded")
