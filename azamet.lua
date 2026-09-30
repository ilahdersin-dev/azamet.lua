--// AZAMET HUB
--// By Zeth
--// Roblox Studio Admin / Test System

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local Root = Character:WaitForChild("HumanoidRootPart")
local Camera = workspace.CurrentCamera

local KEY = "raiderzethvoid"

local State = {
	Fly = false,
	ESP = false,
	Invisible = false,
	Noclip = false,
	Fullbright = false,
	InfiniteJump = false,
	AutoRotate = true,
	Platform = false,
	AntiAFK = false,
	Coordinates = false,
	FPS = false,
	Ping = false,
	Crosshair = false,
	Compass = false,
	CameraShake = false,
	WalkFling = false,
	Atmosphere = false,
}

local Destroyed = false
local FlySpeed = 60
local CameraShakePower = 2
local OldGravity = workspace.Gravity
local OldFOV = Camera.FieldOfView

local OriginalLighting = {
	Brightness = Lighting.Brightness,
	ClockTime = Lighting.ClockTime,
	FogEnd = Lighting.FogEnd,
	Ambient = Lighting.Ambient,
	OutdoorAmbient = Lighting.OutdoorAmbient
}

--==================================================
-- CHARACTER
--==================================================

local function RefreshCharacter()
	Character = Player.Character or Player.CharacterAdded:Wait()
	Humanoid = Character:WaitForChild("Humanoid")
	Root = Character:WaitForChild("HumanoidRootPart")
end

Player.CharacterAdded:Connect(function()
	task.wait(1)
	RefreshCharacter()
end)

--==================================================
-- SOUND SYSTEM
--==================================================

local function PlaySound(soundType)
	local Sound = Instance.new("Sound")
	Sound.Volume = 0.35
	Sound.Parent = SoundService

	-- Roblox default UI sound
	Sound.SoundId = "rbxasset://sounds/electronicpingshort.wav"

	if soundType == "Error" then
		Sound.PlaybackSpeed = 0.65
	elseif soundType == "Success" then
		Sound.PlaybackSpeed = 1.35
	else
		Sound.PlaybackSpeed = 1
	end

	Sound:Play()
	task.delay(2, function()
		if Sound then
			Sound:Destroy()
		end
	end)
end

--==================================================
-- GUI
--==================================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "AZAMET_BY_ZETH"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.Parent = Player:WaitForChild("PlayerGui")

local Scale = Instance.new("UIScale")
Scale.Scale = UIS.TouchEnabled and 0.88 or 1
Scale.Parent = Gui

--==================================================
-- KEY SCREEN
--==================================================

local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.fromOffset(330, 245)
KeyFrame.Position = UDim2.fromScale(0.5, 0.5)
KeyFrame.AnchorPoint = Vector2.new(0.5, 0.5)
KeyFrame.BackgroundColor3 = Color3.fromRGB(7, 10, 15)
KeyFrame.BorderSizePixel = 0
KeyFrame.Parent = Gui

local KeyCorner = Instance.new("UICorner", KeyFrame)
KeyCorner.CornerRadius = UDim.new(0, 14)

local KeyStroke = Instance.new("UIStroke", KeyFrame)
KeyStroke.Color = Color3.fromRGB(0, 255, 210)
KeyStroke.Thickness = 1.5

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 48)
Title.BackgroundTransparency = 1
Title.Text = "AZAMET"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 27
Title.TextColor3 = Color3.fromRGB(0, 255, 210)
Title.Parent = KeyFrame

local By = Instance.new("TextLabel")
By.Size = UDim2.new(1, 0, 0, 22)
By.Position = UDim2.fromOffset(0, 42)
By.BackgroundTransparency = 1
By.Text = "By Zeth"
By.Font = Enum.Font.GothamBold
By.TextSize = 13
By.TextColor3 = Color3.fromRGB(145, 155, 170)
By.Parent = KeyFrame

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(1, -40, 0, 42)
KeyBox.Position = UDim2.fromOffset(20, 78)
KeyBox.BackgroundColor3 = Color3.fromRGB(15, 20, 28)
KeyBox.PlaceholderText = "KEY GİR..."
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.new(1,1,1)
KeyBox.PlaceholderColor3 = Color3.fromRGB(100,110,120)
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextSize = 14
KeyBox.ClearTextOnFocus = false
KeyBox.Parent = KeyFrame

Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0, 8)

local Login = Instance.new("TextButton")
Login.Size = UDim2.fromOffset(135, 40)
Login.Position = UDim2.fromOffset(20, 132)
Login.BackgroundColor3 = Color3.fromRGB(0, 190, 160)
Login.Text = "GİRİŞ"
Login.Font = Enum.Font.GothamBold
Login.TextSize = 14
Login.TextColor3 = Color3.fromRGB(0, 0, 0)
Login.Parent = KeyFrame

Instance.new("UICorner", Login).CornerRadius = UDim.new(0, 8)

local GetKey = Instance.new("TextButton")
GetKey.Size = UDim2.fromOffset(135, 40)
GetKey.Position = UDim2.fromOffset(175, 132)
GetKey.BackgroundColor3 = Color3.fromRGB(25, 32, 42)
GetKey.Text = "🔑 KEY AL"
GetKey.Font = Enum.Font.GothamBold
GetKey.TextSize = 13
GetKey.TextColor3 = Color3.fromRGB(0, 255, 210)
GetKey.Parent = KeyFrame

Instance.new("UICorner", GetKey).CornerRadius = UDim.new(0, 8)

local KeyStatus = Instance.new("TextLabel")
KeyStatus.Size = UDim2.new(1, -30, 0, 45)
KeyStatus.Position = UDim2.fromOffset(15, 185)
KeyStatus.BackgroundTransparency = 1
KeyStatus.Text = "Key gerekli • By Zeth"
KeyStatus.Font = Enum.Font.Gotham
KeyStatus.TextSize = 12
KeyStatus.TextColor3 = Color3.fromRGB(130,140,150)
KeyStatus.Parent = KeyFrame

GetKey.MouseButton1Click:Connect(function()
	PlaySound("Click")

	if setclipboard then
		setclipboard("https://discord.gg/FNrA9rfCZz")
		KeyStatus.Text = "Discord linki kopyalandı!"
	else
		KeyStatus.Text = "Discord: discord.gg/FNrA9rfCZz"
	end

	KeyStatus.TextColor3 = Color3.fromRGB(0,255,210)
end)

--==================================================
-- MAIN
--==================================================

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(520, 360)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(6, 9, 14)
Main.BorderSizePixel = 0
Main.Visible = false
Main.Parent = Gui

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 13)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(0, 220, 185)
MainStroke.Thickness = 1.2

-- HEADER

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1,0,0,48)
Header.BackgroundColor3 = Color3.fromRGB(10,15,22)
Header.BorderSizePixel = 0
Header.Parent = Main

Instance.new("UICorner", Header).CornerRadius = UDim.new(0,13)

local HeaderTitle = Instance.new("TextLabel")
HeaderTitle.Size = UDim2.new(1,-100,1,0)
HeaderTitle.Position = UDim2.fromOffset(15,0)
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.Text = "AZAMET  •  By Zeth"
HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
HeaderTitle.Font = Enum.Font.GothamBlack
HeaderTitle.TextSize = 17
HeaderTitle.TextColor3 = Color3.fromRGB(0,255,210)
HeaderTitle.Parent = Header

local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.fromOffset(38,32)
Minimize.Position = UDim2.new(1,-78,0,8)
Minimize.BackgroundColor3 = Color3.fromRGB(25,32,42)
Minimize.Text = "—"
Minimize.Font = Enum.Font.GothamBold
Minimize.TextSize = 18
Minimize.TextColor3 = Color3.new(1,1,1)
Minimize.Parent = Header
Instance.new("UICorner",Minimize).CornerRadius = UDim.new(0,7)

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(32,32)
Close.Position = UDim2.new(1,-38,0,8)
Close.BackgroundColor3 = Color3.fromRGB(120,35,45)
Close.Text = "×"
Close.Font = Enum.Font.GothamBold
Close.TextSize = 20
Close.TextColor3 = Color3.new(1,1,1)
Close.Parent = Header
Instance.new("UICorner",Close).CornerRadius = UDim.new(0,7)

-- SCROLL

local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1,-20,1,-62)
Scroll.Position = UDim2.fromOffset(10,55)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.ScrollBarThickness = 4
Scroll.ScrollBarImageColor3 = Color3.fromRGB(0,220,185)
Scroll.CanvasSize = UDim2.new(0,0,0,0)
Scroll.Parent = Main

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0,7)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Layout.Parent = Scroll

local Padding = Instance.new("UIPadding")
Padding.PaddingTop = UDim.new(0,3)
Padding.PaddingBottom = UDim.new(0,12)
Padding.Parent = Scroll

local function UpdateCanvas()
	Scroll.CanvasSize = UDim2.fromOffset(0, Layout.AbsoluteContentSize.Y + 15)
end

Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateCanvas)

--==================================================
-- BUTTON HELPERS
--==================================================

local function Button(text)
	local B = Instance.new("TextButton")
	B.Size = UDim2.new(1,-5,0,38)
	B.BackgroundColor3 = Color3.fromRGB(15,21,29)
	B.Text = text
	B.Font = Enum.Font.GothamBold
	B.TextSize = 13
	B.TextColor3 = Color3.fromRGB(220,230,235)
	B.AutoButtonColor = false
	B.Parent = Scroll

	Instance.new("UICorner",B).CornerRadius = UDim.new(0,8)

	local Stroke = Instance.new("UIStroke",B)
	Stroke.Color = Color3.fromRGB(30,42,52)
	Stroke.Thickness = 1

	B.MouseEnter:Connect(function()
		TweenService:Create(B,TweenInfo.new(.15),{
			BackgroundColor3=Color3.fromRGB(20,32,40)
		}):Play()
	end)

	B.MouseLeave:Connect(function()
		TweenService:Create(B,TweenInfo.new(.15),{
			BackgroundColor3=Color3.fromRGB(15,21,29)
		}):Play()
	end)

	B.MouseButton1Click:Connect(function()
		PlaySound("Click")
	end)

	return B
end

local function Section(text)
	local L = Instance.new("TextLabel")
	L.Size = UDim2.new(1,-5,0,25)
	L.BackgroundTransparency = 1
	L.Text = "  "..text
	L.TextXAlignment = Enum.TextXAlignment.Left
	L.Font = Enum.Font.GothamBlack
	L.TextSize = 12
	L.TextColor3 = Color3.fromRGB(0,255,210)
	L.Parent = Scroll
end

local function InputRow(placeholder, default)
	local Box = Instance.new("TextBox")
	Box.Size = UDim2.new(1,-5,0,38)
	Box.BackgroundColor3 = Color3.fromRGB(15,21,29)
	Box.PlaceholderText = placeholder
	Box.Text = default or ""
	Box.TextColor3 = Color3.new(1,1,1)
	Box.PlaceholderColor3 = Color3.fromRGB(100,110,120)
	Box.Font = Enum.Font.Gotham
	Box.TextSize = 13
	Box.Parent = Scroll

	Instance.new("UICorner",Box).CornerRadius = UDim.new(0,8)

	return Box
end

local function Toggle(button, state, label)
	state = not state

	button.Text = label .. (state and "  [ON]" or "  [OFF]")
	button.TextColor3 = state
		and Color3.fromRGB(0,255,210)
		or Color3.fromRGB(220,230,235)

	return state
end

--==================================================
-- FLY
--==================================================

local FlyButton
local FlyVelocity
local FlyConnection

local function SetFly(value)
	State.Fly = value

	if value then
		FlyButton.Text = "✈ Fly  [ON]"
		FlyButton.TextColor3 = Color3.fromRGB(0,255,210)

		FlyVelocity = Instance.new("BodyVelocity")
		FlyVelocity.MaxForce = Vector3.new(1e6,1e6,1e6)
		FlyVelocity.Velocity = Vector3.zero
		FlyVelocity.Parent = Root

		FlyConnection = RunService.RenderStepped:Connect(function()
			if not State.Fly or not Root then return end

			local Direction = Vector3.zero
			local CamCF = Camera.CFrame

			if UIS:IsKeyDown(Enum.KeyCode.W) then
				Direction += CamCF.LookVector
			end
			if UIS:IsKeyDown(Enum.KeyCode.S) then
				Direction -= CamCF.LookVector
			end
			if UIS:IsKeyDown(Enum.KeyCode.A) then
				Direction -= CamCF.RightVector
			end
			if UIS:IsKeyDown(Enum.KeyCode.D) then
				Direction += CamCF.RightVector
			end

			if UIS:IsKeyDown(Enum.KeyCode.Space) then
				Direction += Vector3.yAxis
			end
			if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
				Direction -= Vector3.yAxis
			end

			FlyVelocity.Velocity =
				Direction.Magnitude > 0
				and Direction.Unit * FlySpeed
				or Vector3.zero
		end)
	else
		FlyButton.Text = "✈ Fly  [OFF]"
		FlyButton.TextColor3 = Color3.fromRGB(220,230,235)

		if FlyConnection then
			FlyConnection:Disconnect()
			FlyConnection=nil
		end

		if FlyVelocity then
			FlyVelocity:Destroy()
			FlyVelocity=nil
		end
	end
end

--==================================================
-- FEATURES
--==================================================

Section("MOVEMENT")

FlyButton = Button("✈ Fly  [OFF]")
FlyButton.MouseButton1Click:Connect(function()
	SetFly(not State.Fly)
end)

local SpeedBox = InputRow("Fly Speed", "60")

local SpeedApply = Button("⚡ Uygula Fly Speed")
SpeedApply.MouseButton1Click:Connect(function()
	local n = tonumber(SpeedBox.Text)
	if n then
		FlySpeed = math.clamp(n,1,500)
	end
end)

local WalkBox = InputRow("WalkSpeed", "16")
local WalkApply = Button("🏃 WalkSpeed Uygula")
WalkApply.MouseButton1Click:Connect(function()
	local n=tonumber(WalkBox.Text)
	if n and Humanoid then
		Humanoid.WalkSpeed=math.clamp(n,0,500)
	end
end)

local JumpBox = InputRow("JumpPower", "50")
local JumpApply = Button("🦘 JumpPower Uygula")
JumpApply.MouseButton1Click:Connect(function()
	local n=tonumber(JumpBox.Text)
	if n and Humanoid then
		Humanoid.UseJumpPower=true
		Humanoid.JumpPower=math.clamp(n,0,300)
	end
end)

local NoclipButton = Button("🚫 Noclip  [OFF]")
NoclipButton.MouseButton1Click:Connect(function()
	State.Noclip=not State.Noclip
	NoclipButton.Text="🚫 Noclip  ["..(State.Noclip and "ON" or "OFF").."]"
end)

local InfiniteButton = Button("🦘 Infinite Jump  [OFF]")
InfiniteButton.MouseButton1Click:Connect(function()
	State.InfiniteJump=not State.InfiniteJump
	InfiniteButton.Text="🦘 Infinite Jump  ["..(State.InfiniteJump and "ON" or "OFF").."]"
end)

local AutoRotateButton = Button("🔄 Auto Rotate  [ON]")
AutoRotateButton.MouseButton1Click:Connect(function()
	State.AutoRotate=not State.AutoRotate
	Humanoid.AutoRotate=State.AutoRotate
	AutoRotateButton.Text="🔄 Auto Rotate  ["..(State.AutoRotate and "ON" or "OFF").."]"
end)

local SitButton = Button("🪑 Sit / Stand")
SitButton.MouseButton1Click:Connect(function()
	if Humanoid then
		Humanoid.Sit=not Humanoid.Sit
	end
end)

local PlatformButton = Button("🟦 Character Platform  [OFF]")
local Platform

PlatformButton.MouseButton1Click:Connect(function()
	State.Platform=not State.Platform

	if State.Platform then
		Platform=Instance.new("Part")
		Platform.Size=Vector3.new(7,0.5,7)
		Platform.Anchored=true
		Platform.CanCollide=true
		Platform.Transparency=.2
		Platform.Material=Enum.Material.Neon
		Platform.Parent=workspace

		PlatformButton.Text="🟦 Character Platform  [ON]"
	else
		if Platform then Platform:Destroy() Platform=nil end
		PlatformButton.Text="🟦 Character Platform  [OFF]"
	end
end)

Section("PLAYER / VISUAL")

local ESPButton = Button("👁 ESP  [OFF]")
local ESPObjects={}

local function ClearESP()
	for _,v in pairs(ESPObjects) do
		if v then v:Destroy() end
	end
	table.clear(ESPObjects)
end

local function ApplyESP()
	ClearESP()

	if not State.ESP then return end

	for _,p in ipairs(Players:GetPlayers()) do
		if p~=Player and p.Character then
			local H=Instance.new("Highlight")
			H.FillTransparency=.65
			H.OutlineColor=Color3.fromRGB(0,255,210)
			H.FillColor=Color3.fromRGB(0,180,150)
			H.Adornee=p.Character
			H.Parent=p.Character
			table.insert(ESPObjects,H)
		end
	end
end

ESPButton.MouseButton1Click:Connect(function()
	State.ESP=not State.ESP
	ESPButton.Text="👁 ESP  ["..(State.ESP and "ON" or "OFF").."]"
	ApplyESP()
end)

local InvisibleButton=Button("👻 Invisible  [OFF]")
InvisibleButton.MouseButton1Click:Connect(function()
	State.Invisible=not State.Invisible

	for _,v in ipairs(Character:GetDescendants()) do
		if v:IsA("BasePart") then
			v.LocalTransparencyModifier=State.Invisible and 1 or 0
		end
	end

	InvisibleButton.Text="👻 Invisible  ["..(State.Invisible and "ON" or "OFF").."]"
end)

local FullbrightButton=Button("💡 Fullbright  [OFF]")
FullbrightButton.MouseButton1Click:Connect(function()
	State.Fullbright=not State.Fullbright

	if State.Fullbright then
		Lighting.Brightness=3
		Lighting.ClockTime=14
		Lighting.FogEnd=100000
		Lighting.Ambient=Color3.new(1,1,1)
		Lighting.OutdoorAmbient=Color3.new(1,1,1)
	else
		Lighting.Brightness=OriginalLighting.Brightness
		Lighting.ClockTime=OriginalLighting.ClockTime
		Lighting.FogEnd=OriginalLighting.FogEnd
		Lighting.Ambient=OriginalLighting.Ambient
		Lighting.OutdoorAmbient=OriginalLighting.OutdoorAmbient
	end

	FullbrightButton.Text="💡 Fullbright  ["..(State.Fullbright and "ON" or "OFF").."]"
end)

local FOVBox=InputRow("Camera FOV",tostring(OldFOV))
local FOVApply=Button("🎥 FOV Uygula")
FOVApply.MouseButton1Click:Connect(function()
	local n=tonumber(FOVBox.Text)
	if n then
		Camera.FieldOfView=math.clamp(n,40,120)
	end
end)

local ZoomBox=InputRow("Camera Zoom Max", "128")
local ZoomApply=Button("🔭 Camera Zoom Uygula")
ZoomApply.MouseButton1Click:Connect(function()
	local n=tonumber(ZoomBox.Text)
	if n then
		Player.CameraMaxZoomDistance=math.clamp(n,5,500)
	end
end)

Section("WORLD / EFFECTS")

local GravityBox=InputRow("Gravity",tostring(OldGravity))
local GravityApply=Button("🪐 Gravity Uygula")
GravityApply.MouseButton1Click:Connect(function()
	local n=tonumber(GravityBox.Text)
	if n then workspace.Gravity=math.clamp(n,0,500) end
end)

local TimeBox=InputRow("ClockTime 0-24",tostring(Lighting.ClockTime))
local TimeApply=Button("🌅 Time Changer")
TimeApply.MouseButton1Click:Connect(function()
	local n=tonumber(TimeBox.Text)
	if n then Lighting.ClockTime=math.clamp(n,0,24) end
end)

local AtmosButton=Button("🌫 Atmosphere  [OFF]")
AtmosButton.MouseButton1Click:Connect(function()
	State.Atmosphere=not State.Atmosphere

	local atm=Lighting:FindFirstChildOfClass("Atmosphere")

	if State.Atmosphere then
		if not atm then
			atm=Instance.new("Atmosphere")
			atm.Parent=Lighting
		end
		atm.Density=.35
		atm.Haze=1
	else
		if atm then atm.Density=0 end
	end

	AtmosButton.Text="🌫 Atmosphere  ["..(State.Atmosphere and "ON" or "OFF").."]"
end)

local ShakeButton=Button("🎬 Camera Shake  [OFF]")
local ShakeTime=0

ShakeButton.MouseButton1Click:Connect(function()
	State.CameraShake=not State.CameraShake
	ShakeButton.Text="🎬 Camera Shake  ["..(State.CameraShake and "ON" or "OFF").."]"
end)

local CrossButton=Button("🎯 Crosshair  [OFF]")

local Crosshair

CrossButton.MouseButton1Click:Connect(function()
	State.Crosshair=not State.Crosshair

	if State.Crosshair then
		Crosshair=Instance.new("TextLabel")
		Crosshair.Size=UDim2.fromOffset(30,30)
		Crosshair.Position=UDim2.fromScale(.5,.5)
		Crosshair.AnchorPoint=Vector2.new(.5,.5)
		Crosshair.BackgroundTransparency=1
		Crosshair.Text="+"
		Crosshair.Font=Enum.Font.GothamBold
		Crosshair.TextSize=25
		Crosshair.TextColor3=Color3.fromRGB(0,255,210)
		Crosshair.Parent=Gui
	else
		if Crosshair then Crosshair:Destroy() Crosshair=nil end
	end

	CrossButton.Text="🎯 Crosshair  ["..(State.Crosshair and "ON" or "OFF").."]"
end)

local CompassButton=Button("🧭 Compass  [OFF]")
local Compass

CompassButton.MouseButton1Click:Connect(function()
	State.Compass=not State.Compass

	if State.Compass then
		Compass=Instance.new("TextLabel")
		Compass.Size=UDim2.fromOffset(160,30)
		Compass.Position=UDim2.fromScale(.5,0)
		Compass.AnchorPoint=Vector2.new(.5,0)
		Compass.BackgroundColor3=Color3.fromRGB(5,10,15)
		Compass.BackgroundTransparency=.2
		Compass.Text="N     E     S     W"
		Compass.Font=Enum.Font.GothamBold
		Compass.TextSize=13
		Compass.TextColor3=Color3.fromRGB(0,255,210)
		Compass.Parent=Gui
		Instance.new("UICorner",Compass).CornerRadius=UDim.new(0,8)
	else
		if Compass then Compass:Destroy() Compass=nil end
	end

	CompassButton.Text="🧭 Compass  ["..(State.Compass and "ON" or "OFF").."]"
end)

Section("MONITOR")

local CoordLabel=Instance.new("TextLabel")
CoordLabel.Size=UDim2.fromOffset(240,55)
CoordLabel.Position=UDim2.fromOffset(12,70)
CoordLabel.BackgroundColor3=Color3.fromRGB(5,10,15)
CoordLabel.BackgroundTransparency=.2
CoordLabel.Text=""
CoordLabel.TextColor3=Color3.fromRGB(0,255,210)
CoordLabel.Font=Enum.Font.Code
CoordLabel.TextSize=12
CoordLabel.TextXAlignment=Enum.TextXAlignment.Left
CoordLabel.Visible=false
CoordLabel.Parent=Gui
Instance.new("UICorner",CoordLabel).CornerRadius=UDim.new(0,8)

local CoordButton=Button("📍 Coordinates HUD  [OFF]")
CoordButton.MouseButton1Click:Connect(function()
	State.Coordinates=not State.Coordinates
	CoordLabel.Visible=State.Coordinates
	CoordButton.Text="📍 Coordinates HUD  ["..(State.Coordinates and "ON" or "OFF").."]"
end)

local FPSLabel=Instance.new("TextLabel")
FPSLabel.Size=UDim2.fromOffset(130,30)
FPSLabel.Position=UDim2.new(1,-140,0,70)
FPSLabel.BackgroundTransparency=.2
FPSLabel.BackgroundColor3=Color3.fromRGB(5,10,15)
FPSLabel.TextColor3=Color3.fromRGB(0,255,210)
FPSLabel.Font=Enum.Font.Code
FPSLabel.TextSize=12
FPSLabel.Visible=false
FPSLabel.Parent=Gui
Instance.new("UICorner",FPSLabel).CornerRadius=UDim.new(0,8)

local FPSButton=Button("📊 FPS Counter  [OFF]")
FPSButton.MouseButton1Click:Connect(function()
	State.FPS=not State.FPS
	FPSLabel.Visible=State.FPS
	FPSButton.Text="📊 FPS Counter  ["..(State.FPS and "ON" or "OFF").."]"
end)

local PingButton=Button("📡 Ping Counter  [OFF]")
local PingLabel=Instance.new("TextLabel")
PingLabel.Size=UDim2.fromOffset(130,30)
PingLabel.Position=UDim2.new(1,-140,0,105)
PingLabel.BackgroundColor3=Color3.fromRGB(5,10,15)
PingLabel.BackgroundTransparency=.2
PingLabel.TextColor3=Color3.fromRGB(0,255,210)
PingLabel.Font=Enum.Font.Code
PingLabel.TextSize=12
PingLabel.Visible=false
PingLabel.Parent=Gui
Instance.new("UICorner",PingLabel).CornerRadius=UDim.new(0,8)

PingButton.MouseButton1Click:Connect(function()
	State.Ping=not State.Ping
	PingLabel.Visible=State.Ping
	PingButton.Text="📡 Ping Counter  ["..(State.Ping and "ON" or "OFF").."]"
end)

Section("ADMIN")

local WalkFlingButton=Button("💥 Walk Fling  [OFF]")

WalkFlingButton.MouseButton1Click:Connect(function()
	State.WalkFling=not State.WalkFling
	WalkFlingButton.Text="💥 Walk Fling  ["..(State.WalkFling and "ON" or "OFF").."]"

	local Remote=ReplicatedStorage:FindFirstChild("AZAMET_WalkFling")

	if Remote then
		Remote:FireServer(State.WalkFling)
	end
end)

local AntiAFKButton=Button("⏱ Anti-AFK  [OFF]")

AntiAFKButton.MouseButton1Click:Connect(function()
	State.AntiAFK=not State.AntiAFK
	AntiAFKButton.Text="⏱ Anti-AFK  ["..(State.AntiAFK and "ON" or "OFF").."]"
end)

local ResetButton=Button("🔄 Reset Character")
ResetButton.MouseButton1Click:Connect(function()
	if Humanoid then
		Humanoid.Health=0
	end
end)

--==================================================
-- RENDER LOOP
--==================================================

local LastTime=tick()
local Frames=0
local FPS=0

RunService.RenderStepped:Connect(function(dt)
	if Destroyed then return end

	Frames+=1

	if tick()-LastTime>=1 then
		FPS=Frames
		Frames=0
		LastTime=tick()
	end

	if State.Noclip and Character then
		for _,v in ipairs(Character:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide=false
			end
		end
	end

	if State.Platform and Platform and Root then
		Platform.CFrame=CFrame.new(
			Root.Position.X,
			Root.Position.Y-3.2,
			Root.Position.Z
		)
	end

	if State.Coordinates and Root then
		local p=Root.Position
		CoordLabel.Text=string.format(
			"  X: %.1f\n  Y: %.1f\n  Z: %.1f",
			p.X,p.Y,p.Z
		)
	end

	if State.FPS then
		FPSLabel.Text="FPS: "..FPS
	end

	if State.Ping then
		local ping=math.floor(Player:GetNetworkPing()*1000)
		PingLabel.Text="Ping: "..ping.." ms"
	end

	if State.CameraShake then
		ShakeTime+=dt*12

		local x=math.sin(ShakeTime)*CameraShakePower/100
		local y=math.cos(ShakeTime*1.3)*CameraShakePower/100

		Camera.CFrame=Camera.CFrame*CFrame.Angles(x,y,0)
	end
end)

--==================================================
-- INFINITE JUMP
--==================================================

UIS.JumpRequest:Connect(function()
	if State.InfiniteJump and Humanoid then
		Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

--==================================================
-- ANTI AFK
--==================================================

Player.Idled:Connect(function()
	if State.AntiAFK then
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
	end
end)

--==================================================
-- DRAG
--==================================================

local Dragging=false
local DragStart
local StartPos

Header.InputBegan:Connect(function(input)
	if input.UserInputType==Enum.UserInputType.MouseButton1
		or input.UserInputType==Enum.UserInputType.Touch then

		Dragging=true
		DragStart=input.Position
		StartPos=Main.Position

		input.Changed:Connect(function()
			if input.UserInputState==Enum.UserInputState.End then
				Dragging=false
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(input)
	if Dragging and (
		input.UserInputType==Enum.UserInputType.MouseMovement
		or input.UserInputType==Enum.UserInputType.Touch
	) then

		local Delta=input.Position-DragStart

		Main.Position=UDim2.new(
			StartPos.X.Scale,
			StartPos.X.Offset+Delta.X,
			StartPos.Y.Scale,
			StartPos.Y.Offset+Delta.Y
		)
	end
end)

--==================================================
-- MINIMIZE
--==================================================

local Mini=Instance.new("TextButton")
Mini.Size=UDim2.fromOffset(170,34)
Mini.Position=UDim2.fromOffset(12,12)
Mini.BackgroundColor3=Color3.fromRGB(7,12,18)
Mini.Text="──── AZAMET • By Zeth ────"
Mini.Font=Enum.Font.GothamBold
Mini.TextSize=11
Mini.TextColor3=Color3.fromRGB(0,255,210)
Mini.Visible=false
Mini.Parent=Gui
Instance.new("UICorner",Mini).CornerRadius=UDim.new(0,8)

Minimize.MouseButton1Click:Connect(function()
	PlaySound("Click")
	Main.Visible=false
	Mini.Visible=true
end)

Mini.MouseButton1Click:Connect(function()
	PlaySound("Click")
	Mini.Visible=false
	Main.Visible=true
end)

--==================================================
-- CLOSE CONFIRM
--==================================================

local Overlay=Instance.new("Frame")
Overlay.Size=UDim2.fromScale(1,1)
Overlay.BackgroundColor3=Color3.new(0,0,0)
Overlay.BackgroundTransparency=.4
Overlay.Visible=false
Overlay.ZIndex=100
Overlay.Parent=Gui

local Confirm=Instance.new("Frame")
Confirm.Size=UDim2.fromOffset(310,165)
Confirm.Position=UDim2.fromScale(.5,.5)
Confirm.AnchorPoint=Vector2.new(.5,.5)
Confirm.BackgroundColor3=Color3.fromRGB(8,12,18)
Confirm.ZIndex=101
Confirm.Parent=Gui

Instance.new("UICorner",Confirm).CornerRadius=UDim.new(0,12)

local CS=Instance.new("UIStroke",Confirm)
CS.Color=Color3.fromRGB(0,255,210)
CS.Thickness=1.3

local CT=Instance.new("TextLabel")
CT.Size=UDim2.new(1,0,0,40)
CT.BackgroundTransparency=1
CT.Text="UI'Yİ KAPAT?"
CT.Font=Enum.Font.GothamBlack
CT.TextSize=19
CT.TextColor3=Color3.fromRGB(0,255,210)
CT.ZIndex=102
CT.Parent=Confirm

local CX=Instance.new("TextLabel")
CX.Size=UDim2.new(1,-20,0,45)
CX.Position=UDim2.fromOffset(10,40)
CX.BackgroundTransparency=1
CX.Text="Emin misin?\nAktif özellikler kapatılacak."
CX.Font=Enum.Font.Gotham
CX.TextSize=12
CX.TextColor3=Color3.fromRGB(180,190,200)
CX.ZIndex=102
CX.Parent=Confirm

local No=Instance.new("TextButton")
No.Size=UDim2.fromOffset(125,38)
No.Position=UDim2.fromOffset(20,110)
No.BackgroundColor3=Color3.fromRGB(30,38,48)
No.Text="HAYIR"
No.Font=Enum.Font.GothamBold
No.TextSize=13
No.TextColor3=Color3.new(1,1,1)
No.ZIndex=102
No.Parent=Confirm
Instance.new("UICorner",No).CornerRadius=UDim.new(0,8)

local Yes=Instance.new("TextButton")
Yes.Size=UDim2.fromOffset(125,38)
Yes.Position=UDim2.fromOffset(165,110)
Yes.BackgroundColor3=Color3.fromRGB(125,35,45)
Yes.Text="EVET"
Yes.Font=Enum.Font.GothamBold
Yes.TextSize=13
Yes.TextColor3=Color3.new(1,1,1)
Yes.ZIndex=102
Yes.Parent=Confirm
Instance.new("UICorner",Yes).CornerRadius=UDim.new(0,8)

Confirm.Visible=false

Close.MouseButton1Click:Connect(function()
	PlaySound("Click")
	Overlay.Visible=true
	Confirm.Visible=true
end)

No.MouseButton1Click:Connect(function()
	PlaySound("Click")
	Confirm.Visible=false
	Overlay.Visible=false
end)

Yes.MouseButton1Click:Connect(function()
	PlaySound("Click")

	Destroyed=true

	State.Fly=false
	State.Noclip=false
	State.WalkFling=false

	if FlyVelocity then FlyVelocity:Destroy() end
	if FlyConnection then FlyConnection:Disconnect() end
	if Platform then Platform:Destroy() end

	Camera.FieldOfView=OldFOV
	workspace.Gravity=OldGravity

	if Crosshair then Crosshair:Destroy() end
	if Compass then Compass:Destroy() end

	Overlay:Destroy()
	Confirm:Destroy()
	Gui:Destroy()
end)

--==================================================
-- LOGIN
--==================================================

Login.MouseButton1Click:Connect(function()
	if KeyBox.Text==KEY then
		PlaySound("Success")

		KeyStatus.Text="KEY DOĞRU • By Zeth"
		KeyStatus.TextColor3=Color3.fromRGB(0,255,210)

		task.wait(.35)

		KeyFrame.Visible=false
		Main.Visible=true

		Main.Size=UDim2.fromOffset(490,330)

		TweenService:Create(
			Main,
			TweenInfo.new(.45,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
			{Size=UDim2.fromOffset(520,360)}
		):Play()
	else
		PlaySound("Error")

		KeyStatus.Text="Hatalı key!"
		KeyStatus.TextColor3=Color3.fromRGB(255,70,80)

		local Original=KeyFrame.Position

		for i=1,4 do
			KeyFrame.Position=Original+UDim2.fromOffset(8,0)
			task.wait(.04)
			KeyFrame.Position=Original-UDim2.fromOffset(8,0)
			task.wait(.04)
		end

		KeyFrame.Position=Original
	end
end)

--==================================================
-- START
--==================================================

KeyFrame.Visible=true
Main.Visible=false

print("AZAMET HUB • Zeth babapıro😎")
