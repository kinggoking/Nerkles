--Nerkles v3
local AntiSkid = Instance.new("ScreenGui")
local Nerkless = Instance.new("Frame")
local ImageLabel = Instance.new("ImageLabel")
local MainFrame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local ImageButton = Instance.new("ImageButton")
local Kill = Instance.new("TextButton")
local Kick = Instance.new("TextButton")
local Ban = Instance.new("TextButton")
local dex = Instance.new("TextButton")
local Noregen = Instance.new("TextButton")
local SLOCK = Instance.new("TextButton")
local dws = Instance.new("TextButton")
local blockhead = Instance.new("TextButton")
local dg = Instance.new("TextButton")
local target = Instance.new("TextBox")
local Players = game:GetService("Players")
local player = game.Players.LocalPlayer
local char = player.Character
local tool
--functions
for i,v in player:GetDescendants() do
	if v.Name == "SyncAPI" then
		tool = v.Parent
	end
end
for i,v in game.ReplicatedStorage:GetDescendants() do
	if v.Name == "SyncAPI" then
		tool = v.Parent
	end
end
local remote = tool.SyncAPI.ServerEndpoint
local function _(args)
	remote:InvokeServer(unpack(args))
end
local function AddFire(part)
	local args = {
		[1] = "CreateDecorations",
		[2] = {
			[1] = {
				["Part"] = part,
				["DecorationType"] = "Fire"
			}
		}
	}
	_(args)
end
function MovePart(part,cf)
	local args = {
		[1] = "SyncMove",
		[2] = {
			[1] = {
				["Part"] = part,
				["CFrame"] = cf
			}
		}
	}
	_(args)
end
function Resize(part,size,cf)
	local args = {
		[1] = "SyncResize",
		[2] = {
			[1] = {
				["Part"] = part,
				["CFrame"] = cf,
				["Size"] = size
			}
		}
	}
	_(args)
end
function AddMesh(part)
	local args = {
		[1] = "CreateMeshes",
		[2] = {
			[1] = {
				["Part"] = part
			}
		}
	}
	_(args)
end

function SetMesh(part,meshid)
	local args = {
		[1] = "SyncMesh",
		[2] = {
			[1] = {
				["Part"] = part,
				["MeshId"] = "rbxassetid://"..meshid
			}
		}
	}
	_(args)
end
function SetTexture(part, texid)
	local args = {
		[1] = "SyncMesh",
		[2] = {
			[1] = {
				["Part"] = part,
				["TextureId"] = "rbxassetid://"..texid
			}
		}
	}
	_(args)
end
function SpawnDecal(part,side)
	local args = {
		[1] = "CreateTextures",
		[2] = {
			[1] = {
				["Part"] = part,
				["Face"] = side,
				["TextureType"] = "Decal"
			}
		}
	}

	_(args)
end
function MeshResize(part,size)
	local args = {
		[1] = "SyncMesh",
		[2] = {
			[1] = {
				["Part"] = part,
				["Scale"] = size
			}
		}
	}
	_(args)
end
function AddDecal(part,asset,side)
	local args = {
		[1] = "SyncTexture",
		[2] = {
			[1] = {
				["Part"] = part,
				["Face"] = side,
				["TextureType"] = "Decal",
				["Texture"] = "rbxassetid://".. asset
			}
		}
	}
	_(args)
end
function SetName(part, stringg)
	local args = {
		[1] = "SetName",
		[2] = {
			[1] = part
		},
		[3] = stringg
	}

	_(args)
end
function Weld(part1, part2,lead)
	local args = {
		[1] = "CreateWelds",
		[2] = {
			[1] = part1,
			[2] = part2
		},
		[3] = lead
	}
	_(args)

end
function SetLocked(part,boolean)
	local args = {
		[1] = "SetLocked",
		[2] = {
			[1] = part
		},
		[3] = boolean
	}
	_(args)
end
function SetTrans(part,int)
	local args = {
		[1] = "SyncMaterial",
		[2] = {
			[1] = {
				["Part"] = part,
				["Transparency"] = int
			}
		}
	}
	_(args)
end
function CreateSpotlight(part)
	local args = {
		[1] = "CreateLights",
		[2] = {
			[1] = {
				["Part"] = part,
				["LightType"] = "SpotLight"
			}
		}
	}
	_(args)
end
function SyncLighting(part,brightness)
	local args = {
		[1] = "SyncLighting",
		[2] = {
			[1] = {
				["Part"] = part,
				["LightType"] = "SpotLight",
				["Brightness"] = brightness
			}
		}
	}
	_(args)
end
function Color(part,color)
	local args = {
		[1] = "SyncColor",
		[2] = {
			[1] = {
				["Part"] = part,
				["Color"] = color --[[Color3]],
				["UnionColoring"] = false
			}
		}
	}
	_(args)
end
function SetCollision(part,boolean)
	local args = {
		[1] = "SyncCollision",
		[2] = {
			[1] = {
				["Part"] = part,
				["CanCollide"] = boolean
			}
		}
	}
	_(args)
end
function SetAnchor(boolean,part)
	local args = {
		[1] = "SyncAnchor",
		[2] = {
			[1] = {
				["Part"] = part,
				["Anchored"] = boolean
			}
		}
	}
	_(args)
end
function CreatePart(cf,parent)
	local args = {
		[1] = "CreatePart",
		[2] = "Normal",
		[3] = cf,
		[4] = parent
	}
	_(args)
end
local function DestroyPart(part)
	local args = {
		[1] = "Remove",
		[2] = {
			[1] = part
		}
	}
	_(args)
end
function getPlayer(name,speaker)
	if string.lower(name) == "all" then
		local chars = { }
		local c = game.Players:GetChildren()
		for i =1,#c do
			if c[i].className == "Player" then
				table.insert(chars,c[i])
			end end
		return chars
	elseif string.sub(string.lower(name),1,6) == "random" then
		while true do
			local c = game.Players:GetChildren()
			local r = math.random(1,#c)
			if c[r].className == "Player" then
				return { c[r] }
			end end
	elseif string.sub(string.lower(name),1,5) == "team " then
		local theteam = nil
		local tnum = 0
		if game.Teams ~= nil then
			local c = game.Teams:GetChildren()
			for i =1,#c do
				if c[i].className == "Team" then
					if string.find(string.lower(c[i].Name),string.sub(string.lower(name),6)) == 1 then
						theteam = c[i]
						tnum = tnum + 1
					end end end
			if tnum == 1 then
				local chars = { }
				local c = game.Players:GetChildren()
				for i =1,#c do
					if c[i].className == "Player" then
						if c[i].TeamColor == theteam.TeamColor then
							table.insert(chars,c[i])
						end end end
				return chars
			end end
		return 0
	elseif string.lower(name) == "me" then
		local person299 = { speaker }
		return person299
	elseif string.lower(name) == "others" then
		local chars = { }
		local c = game.Players:GetChildren()
		for i =1,#c do
			if c[i].className == "Player" then
				if c[i] ~= speaker then
					table.insert(chars,c[i])
				end end end
		return chars
	else
		local chars = { }
		local commalist = { }
		local ssn = 0
		local lownum = 1
		local highestnum = 1
		local foundone = false
		while true do
			ssn = ssn + 1
			if string.sub(name,ssn,ssn) == "" then
				table.insert(commalist,lownum)
				table.insert(commalist,ssn - 1)
				highestnum = ssn - 1
				break
			end
			if string.sub(name,ssn,ssn) == "," then
				foundone = true
				table.insert(commalist,lownum)
				table.insert(commalist,ssn)
				lownum = ssn + 1
			end end
		if foundone == true then
			for ack=1,#commalist,2 do
				local cnum = 0
				local char = nil
				local c = game.Players:GetChildren()
				for i =1,#c do
					if c[i].className == "Player" then
						if string.find(string.lower(c[i].Name),string.sub(string.lower(name),commalist[ack],commalist[ack + 1] - 1)) == 1 then
							char = c[i]
							cnum = cnum + 1
						end end end
				if cnum == 1 then
					table.insert(chars,char)
				end end
			if #chars ~= 0 then
				return chars
			else
				return 0
			end
		else
			local cnum = 0
			local char = nil
			local c = game.Players:GetChildren()
			for i =1,#c do
				if c[i].className == "Player" then
					if string.find(string.lower(c[i].Name),string.lower(name)) == 1 then
						char = {c[i]}
						cnum = cnum + 1
					end end end
			if cnum == 1 then
				return char 
			elseif cnum == 0 then
				print("That name is not found.",1,"Message",speaker)
				return 0
			elseif cnum > 1 then
				print("That name is ambiguous.",1,"Message",speaker)
				return 0
			end end end end
AntiSkid.Name = "AntiSkid"
AntiSkid.Parent = game:GetService("CoreGui")
AntiSkid.ResetOnSpawn=false
AntiSkid.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Nerkless.Name = "Nerkless"
Nerkless.Parent = AntiSkid
Nerkless.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Nerkless.Position = UDim2.new(0.332909256, 0, 0.185909986, 0)
Nerkless.Size = UDim2.new(0, 390, 0, 243)

ImageLabel.Parent = Nerkless
ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel.Position = UDim2.new(0, 0, 0.139917701, 0)
ImageLabel.Size = UDim2.new(0, 390, 0, 209)
ImageLabel.ZIndex = 3
ImageLabel.Image = "rbxassetid://7371693428"
ImageLabel.ImageColor3 = Color3.fromRGB(255, 179, 0)
ImageLabel.ImageTransparency = 0.420

MainFrame.Name = "MainFrame"
MainFrame.Parent = Nerkless
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.Size = UDim2.new(0, 390, 0, 34)

TextLabel.Parent = MainFrame
TextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.Position = UDim2.new(0, 0, -0.0294117648, 0)
TextLabel.Size = UDim2.new(0, 390, 0, 34)
TextLabel.Font = Enum.Font.Bodoni
TextLabel.RichText = true
TextLabel.LineHeight = 1.060
TextLabel.Text = "<i> Nerkles </i>"
TextLabel.TextColor3 = Color3.fromRGB(255, 179, 0)
TextLabel.TextSize = 40.000

ImageButton.Parent = MainFrame
ImageButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ImageButton.LayoutOrder = 5
ImageButton.Position = UDim2.new(0.905128121, 0, -5.96046448e-08, 0)
ImageButton.Size = UDim2.new(0, 37, 0, 34)
ImageButton.ZIndex = 4
ImageButton.Image = "rbxassetid://10720159507"

Kill.Name = "Kill"
Kill.Parent = Nerkless
Kill.BackgroundColor3 = Color3.fromRGB(107, 107, 107)
Kill.BackgroundTransparency = 0.600
Kill.BorderSizePixel = 0
Kill.Position = UDim2.new(0.0333333351, 0, 0.168070167, 0)
Kill.Size = UDim2.new(0, 120, 0, 50)
Kill.ZIndex = 999999999
Kill.Font = Enum.Font.ArialBold
Kill.Text = "Kill"
Kill.TextColor3 = Color3.fromRGB(0, 0, 0)
Kill.TextSize = 20.000
Kill.MouseButton1Click:connect(function()
	local players = getPlayer(target.Text, Players.LocalPlayer)
	for i, v in pairs(players) do
		if v.Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then
				SetLocked(v.Character.Torso.Neck,false)
				DestroyPart(v.Character.Torso.Neck)
		else
				SetLocked(v.Character.Head,false)
				DestroyPart(v.Character.Head)
		end
	end
end)

Kick.Name = "Kick"
Kick.Parent = Nerkless
Kick.BackgroundColor3 = Color3.fromRGB(107, 107, 107)
Kick.BackgroundTransparency = 0.600
Kick.BorderSizePixel = 0
Kick.Position = UDim2.new(0.356410265, 0, 0.168070152, 0)
Kick.Size = UDim2.new(0, 109, 0, 50)
Kick.ZIndex = 999999999
Kick.Font = Enum.Font.ArialBold
Kick.Text = "UnAnchor"
Kick.TextColor3 = Color3.fromRGB(0, 0, 0)
Kick.TextSize = 20.000
Kick.MouseButton1Click:connect(function()
	local function Unanchor()
		for i,v in game.Workspace:GetDescendants() do
			spawn(function()
				SetLocked(v,false)
				SetAnchor(false,v)
			end)
		end
	end
	Unanchor()
end)

Ban.Name = "Ban"
Ban.Parent = Nerkless
Ban.BackgroundColor3 = Color3.fromRGB(107, 107, 107)
Ban.BackgroundTransparency = 0.600
Ban.BorderSizePixel = 0
Ban.Position = UDim2.new(0.658974349, 0, 0.167802468, 0)
Ban.Size = UDim2.new(0, 120, 0, 50)
Ban.ZIndex = 999999999
Ban.Font = Enum.Font.ArialBold
Ban.Text = "BigHead"
Ban.TextColor3 = Color3.fromRGB(0, 0, 0)
Ban.TextSize = 20.000
Ban.MouseButton1Click:connect(function()
	local function BigHead(player)
		local chara = player.Character
		spawn(function()
			SetLocked(chara.Head,false)
			MeshResize(chara.Head,Vector3.new(10,10,10))
		end)
	end
	local players = getPlayer(target.Text, Players.LocalPlayer)
	for i,v in players do
  BigHead(v)
	end
end)

dex.Name = "omg"
dex.Parent = Nerkless
dex.BackgroundColor3 = Color3.fromRGB(107, 107, 107)
dex.BackgroundTransparency = 0.600
dex.BorderSizePixel = 0
dex.Position = UDim2.new(0.0333333351, 0, 0.39440763, 0)
dex.Size = UDim2.new(0, 120, 0, 50)
dex.ZIndex = 999999999
dex.Font = Enum.Font.ArialBold
dex.Text = "Top Secret"
dex.TextColor3 = Color3.fromRGB(0, 0, 0)
dex.TextSize = 20.000
dex.MouseButton1Click:Connect(function()
	local function a(player)
		char = player.Character
		for i,v in char:GetChildren() do
			pcall(function()
				SetLocked(v,false)
			end)
		end
		if player.Character:FindFirstChild("Boob2") then
			return
		else

			SetAnchor(true,player.Character.HumanoidRootPart)
			spawn(function()
				CreatePart(player.Character:WaitForChild("Right Leg").CFrame * CFrame.new(0,2,-0.6),player.Character)
				SetName(player.Character.Part,"Boob1")
				CreatePart(player.Character:WaitForChild("Left Leg").CFrame * CFrame.new(0,2,-0.6),player.Character)
				SetName(player.Character.Part,"Boob2")
			end)
			wait(0.2)
			repeat wait() until char:FindFirstChild("Boob2")
			spawn(function()
				AddMesh(char.Boob1)
				AddMesh(char.Boob2)
				SetMesh(char.Boob1,"5697933202")
				SetMesh(char.Boob2,"5697933202")
			end)
			wait(0.2)
			repeat wait() until char.Boob2:FindFirstChild("Mesh")
			MeshResize(char.Boob1,Vector3.new(0.4,0.4,0.4))
			MeshResize(char.Boob2,Vector3.new(0.4,0.4,0.4))
			pcall(function()
				Color(char.Boob1,char:WaitForChild("Torso").Color)
				Color(char.Boob2,char:WaitForChild("Torso").Color)
			end)
			wait(0.2)
			spawn(function()
				SetCollision(player.Character.Boob1,false)
				SetCollision(player.Character.Boob2,false)
				Weld(char.Boob1,char.HumanoidRootPart,char.Boob1)
				Weld(char.Boob2,char.Boob1,char.Boob2)
			end)
			repeat wait() until char.Boob2:FindFirstChild("BTWeld")
			for i,v in char:GetChildren() do
				pcall(function()
					SetLocked(v,false)
				end)
			end
			for i,v in char:GetChildren() do
				pcall(function()
					SetAnchor(false,v)
				end)
			end
			spawn(function()
				SetAnchor(false,char.HumanoidRootPart)
				SetAnchor(false,char.Boob1)
				SetAnchor(false,char.Boob2)
			end)
		end
	end
	local function b(player)
		char = player.Character
		for i,v in char:GetChildren() do
			pcall(function()
				SetLocked(v,false)
			end)
		end
		if player.Character:FindFirstChild("Part1") then
			return
		else

			SetAnchor(true,player.Character.HumanoidRootPart)
			spawn(function()
				CreatePart(player.Character:WaitForChild("Right Leg").CFrame * CFrame.new(0,1,0.6),player.Character)
				SetName(player.Character.Part,"Part1")
				CreatePart(player.Character:WaitForChild("Left Leg").CFrame * CFrame.new(0,1,0.6),player.Character)
				SetName(player.Character.Part,"Part2")
			end)
			wait(0.2)
			repeat wait() until char:FindFirstChild("Part2")
			spawn(function()
				AddMesh(char.Part1)
				AddMesh(char.Part2)
				SetMesh(char.Part1,"5697933202")
				SetMesh(char.Part2,"5697933202")
			end)
			wait(0.2)
			repeat wait() until char.Part2:FindFirstChild("Mesh")
			spawn(function()
				MeshResize(char.Part1,Vector3.new(0.5,0.5,0.5))
				MeshResize(char.Part2,Vector3.new(0.5,0.5,0.5))
			end)
			wait(0.2)
			pcall(function()
				Color(char.Part1,char:WaitForChild("Right Leg").Color)
				Color(char.Part2,char:WaitForChild("Left Leg").Color)
			end)
			wait(0.2)
			spawn(function()
				SetCollision(player.Character.Part1,false)
				SetCollision(player.Character.Part2,false)
				Weld(char.Part1,char.HumanoidRootPart,char.Part1)
				Weld(char.Part2,char.Part1,char.Part2)
			end)
			repeat wait() until char.Part2:FindFirstChild("BTWeld")
			spawn(function()
				SetAnchor(false,char.HumanoidRootPart)
				SetAnchor(false,char.Part1)
				SetAnchor(false,char.Part2)
			end)
			repeat wait()
				SetAnchor(false,char.HumanoidRootPart)
				SetAnchor(false,char.Part1)
				SetAnchor(false,char.Part2)
			until char.Part2.Anchored == false
		end
	end
	local players = getPlayer(target.Text, Players.LocalPlayer)
	for i,v in pairs(players)do
		pcall(function()
			a(v)
			wait(.5)
			b(v)
		end)
	end
end)

Noregen.Name = "Fire"
Noregen.Parent = Nerkless
Noregen.BackgroundColor3 = Color3.fromRGB(107, 107, 107)
Noregen.BackgroundTransparency = 0.600
Noregen.BorderSizePixel = 0
Noregen.Position = UDim2.new(0.356410265, 0, 0.3944076, 0)
Noregen.Size = UDim2.new(0, 109, 0, 50)
Noregen.ZIndex = 999999999
Noregen.Font = Enum.Font.ArialBold
Noregen.Text = "Fire"
Noregen.TextColor3 = Color3.fromRGB(0, 0, 0)
Noregen.TextSize = 20.000
Noregen.MouseButton1Click:connect(function()
	local players = getPlayer(target.Text, Players.LocalPlayer)
	local function Fire(player)
		for i,v in player.Character:GetDescendants() do
			if v:IsA("BasePart") then
				AddFire(v)
			end
		end
		DestroyPart(player.Character.Head)
	end
	for i,v in pairs(players) do
		spawn(function()
			pcall(function()
				Fire(v)
			end)
		end)
	end
end)

SLOCK.Name = "Penis"
SLOCK.Parent = Nerkless
SLOCK.BackgroundColor3 = Color3.fromRGB(107, 107, 107)
SLOCK.BackgroundTransparency = 0.600
SLOCK.BorderSizePixel = 0
SLOCK.Position = UDim2.new(0.658974349, 0, 0.394139916, 0)
SLOCK.Size = UDim2.new(0, 120, 0, 50)
SLOCK.ZIndex = 999999999
SLOCK.Font = Enum.Font.ArialBold
SLOCK.Text = "Penis"
SLOCK.TextColor3 = Color3.fromRGB(0, 0, 0)
SLOCK.TextSize = 20.000
SLOCK.MouseButton1Click:connect(function()
	local function Penis(player)
		char = player.Character
		for i,v in pairs(char:GetDescendants()) do
			pcall(function()
				SetLocked(v,false)
			end)
		end
		if player.Character:FindFirstChild("Penis") then
			return
		else
			SetAnchor(true,player.Character.HumanoidRootPart)
			spawn(function()
				CreatePart(player.Character:WaitForChild("Right Leg").CFrame * CFrame.new(-0.8,1,-0.6),player.Character)
				SetName(player.Character.Part,"Balls1")
				CreatePart(player.Character:WaitForChild("Left Leg").CFrame * CFrame.new(0.8,1,-0.6),player.Character)
				SetName(player.Character.Part,"Balls2")
			end)
			wait(0.2)
			repeat wait() until char:FindFirstChild("Balls2")
			print("done")
			spawn(function()
				CreatePart(player.Character:WaitForChild("Torso").CFrame * CFrame.new(0,-1,-1.3),player.Character)
				SetName(player.Character.Part,"Penis")
				CreatePart(player.Character:WaitForChild("Torso").CFrame * CFrame.new(0,-1,-2.5),player.Character)
				SetName(player.Character.Part,"Head1")
			end)
			repeat wait() until char:FindFirstChild("Head1")
			spawn(function()
				AddMesh(char.Balls1)
				AddMesh(char.Balls2)
				AddMesh(char.Head1)
				AddMesh(char.Penis)
			end)
			repeat wait() until char.Penis:FindFirstChild("Mesh")
			spawn(function()
				SetMesh(char.Penis,"4743972117")
				SetMesh(char.Head1,"4743972117")
				MeshResize(char.Penis,Vector3.new(0.5,0.5,3))
				MeshResize(char.Head1,Vector3.new(0.5,0.5,1))
			end)
			spawn(function()
				Weld(char.Penis,char.HumanoidRootPart,char.Penis)
				SetMesh(char.Balls1,"5697933202")
				SetMesh(char.Balls2,"5697933202")
				MeshResize(char.Balls1,Vector3.new(0.2,0.2,0.2))
				MeshResize(char.Balls2,Vector3.new(0.2,0.2,0.2))
			end)
			wait(0.2)
			pcall(function()
				Color(char.Balls1,char:WaitForChild("Torso").Color)
				Color(char.Balls2,char:WaitForChild("Torso").Color)
				Color(char.Penis,char:WaitForChild("Torso").Color)
				Color(char.Head1, Color3.fromRGB(255,100,100))
			end)
			wait(0.2)
			spawn(function()
				SetCollision(player.Character.Balls1,false)
				SetCollision(player.Character.Balls2,false)
				SetCollision(player.Character.Penis,false)
				SetCollision(player.Character.Head1,false)
			end)
			wait(0.2)
			spawn(function()
				Weld(char.Balls1,char.HumanoidRootPart,char.Balls1)
				Weld(char.Balls2,char.Balls1,char.Balls2)
				Weld(char.Head1,char.Penis,char.Head1)
			end)
			wait(0.2)
			spawn(function()
				SetAnchor(false,char.Balls1)
				SetAnchor(false,char.Balls2)
				SetAnchor(false,char.Penis)
				SetAnchor(false,char.Head1)
				SetAnchor(false,char.HumanoidRootPart)
			end)
			repeat wait()
				SetAnchor(false,char.HumanoidRootPart)
				SetAnchor(false,char.Balls1)
				SetAnchor(false,char.Balls2)
				SetAnchor(false,char.Penis)
				SetAnchor(false,char.Head1)
			until char.Head1.Anchored == false
		end
	end
	local player = getPlayer(target.Text, Players.LocalPlayer)
	for i,v in pairs(player)do
			Penis(v)
	end
end)

dws.Name = "dws"
dws.Parent = Nerkless
dws.BackgroundColor3 = Color3.fromRGB(107, 107, 107)
dws.BackgroundTransparency = 0.600
dws.BorderSizePixel = 0
dws.Position = UDim2.new(0.658974349, 0, 0.628707826, 0)
dws.Size = UDim2.new(0, 120, 0, 50)
dws.ZIndex = 999999999
dws.Font = Enum.Font.ArialBold
dws.Text = "Skybox"
dws.TextColor3 = Color3.fromRGB(0, 0, 0)
dws.TextScaled = true
dws.TextSize = 20.000
dws.TextWrapped = true
dws.MouseButton1Click:Connect(function()
	local function Sky(id)
		local e = char.HumanoidRootPart.CFrame.x
		local f = char.HumanoidRootPart.CFrame.y
		local g = char.HumanoidRootPart.CFrame.z
		CreatePart(CFrame.new(math.floor(e),math.floor(f),math.floor(g)) + Vector3.new(0,6,0),workspace)
		for i,v in game.Workspace:GetDescendants() do
			if v:IsA("BasePart") and v.CFrame.x == math.floor(e) and v.CFrame.z == math.floor(g) then
				SetName(v,"Sky")
				AddMesh(v)
				SetMesh(v,"8006679977")
				SetTexture(v,id)
				MeshResize(v,Vector3.new(50,50,50))
				SetLocked(v,true)
			end
		end
	end
	Sky(target.Text)
end)

blockhead.Name = "thomas"
blockhead.Parent = Nerkless
blockhead.BackgroundColor3 = Color3.fromRGB(107, 107, 107)
blockhead.BackgroundTransparency = 0.600
blockhead.BorderSizePixel = 0
blockhead.Position = UDim2.new(0.0333333351, 0, 0.628975511, 0)
blockhead.Size = UDim2.new(0, 120, 0, 50)
blockhead.ZIndex = 999999999
blockhead.Font = Enum.Font.ArialBold
blockhead.Text = "Thomas Engine"
blockhead.TextColor3 = Color3.fromRGB(0, 0, 0)
blockhead.TextSize = 20.000
blockhead.TextScaled=true
blockhead.MouseButton1Click:connect(function()
		SetAnchor(true,char.HumanoidRootPart)
		CreatePart(char.HumanoidRootPart.CFrame,char)
		SetCollision(char.Part,false)
		SetLocked(char.Part,false)
		CreateSpotlight(char.Part)
		SyncLighting(char.Part,100)
		SetLocked(char.HumanoidRootPart,false)
		Weld(char.Part,char.HumanoidRootPart,char.Part)
		SetAnchor(false,char.Part)
		AddMesh(char.Part)
		MeshResize(char.Part,Vector3.new(3,3,3))
		SetMesh(char.Part,"4340968808")
		SetTexture(char.Part,"4340968918")
		SetAnchor(false,char.HumanoidRootPart)
		char.Humanoid.WalkSpeed = 100
		char.HumanoidRootPart.Touched:connect(function(obj)
			if obj.Parent:FindFirstChild("Humanoid") then
				SetLocked(obj.Parent.Head,false)
				DestroyPart(obj.Parent.Head)
			end
		end)
		game:GetService("RunService").RenderStepped:Connect(function()
			for i,v in char:GetDescendants() do
				if v:IsA("BasePart") then
					char.Humanoid.WalkSpeed = 100
					v.CanCollide = false
				end
			end
		end)
end)

dg.Name = "dg"
dg.Parent = Nerkless
dg.BackgroundColor3 = Color3.fromRGB(107, 107, 107)
dg.BackgroundTransparency = 0.600
dg.BorderSizePixel = 0
dg.Position = UDim2.new(0.356410265, 0, 0.628975511, 0)
dg.Size = UDim2.new(0, 109, 0, 50)
dg.ZIndex = 999999999
dg.Font = Enum.Font.ArialBold
dg.Text = "Decal Spam"
dg.TextColor3 = Color3.fromRGB(0, 0, 0)
dg.TextScaled = true
dg.TextSize = 20.000
dg.TextWrapped = true
dg.MouseButton1Click:Connect(function()
	local function spam(id)
		for i,v in game.workspace:GetDescendants() do
			if v:IsA("BasePart") then
				spawn(function()
					SetLocked(v,false)
					SpawnDecal(v,Enum.NormalId.Front)
					AddDecal(v,id,Enum.NormalId.Front)
					SpawnDecal(v,Enum.NormalId.Back)
					AddDecal(v,id,Enum.NormalId.Back)
					SpawnDecal(v,Enum.NormalId.Right)
					AddDecal(v,id,Enum.NormalId.Right)
					SpawnDecal(v,Enum.NormalId.Left)
					AddDecal(v,id,Enum.NormalId.Left)
					SpawnDecal(v,Enum.NormalId.Bottom)
					AddDecal(v,id,Enum.NormalId.Bottom)
					SpawnDecal(v,Enum.NormalId.Top)
					AddDecal(v,id,Enum.NormalId.Top)
				end)
			end
		end 
	end
	spam(target.Text)
end)

target.Name = "target"
target.Parent = Nerkless
target.BackgroundColor3 = Color3.fromRGB(107, 107, 107)
target.BackgroundTransparency = 0.600
target.BorderSizePixel = 0
target.Position = UDim2.new(0.0333333351, 0, 0.868312776, 0)
target.Size = UDim2.new(0, 363, 0, 27)
target.ZIndex = 999999999
target.ClearTextOnFocus = false
target.Font = Enum.Font.SourceSans
target.PlaceholderColor3 = Color3.fromRGB(44, 44, 44)
target.PlaceholderText = "Target or decal id"
target.Text = ""
target.TextColor3 = Color3.fromRGB(0, 0, 0)
target.TextSize = 20.000
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "Success",
	Text = "Successfully loaded!"
})

local selectionbox = Instance.new("SelectionBox", workspace)
local equipped = false
local mouse = Players.LocalPlayer:GetMouse()
local oldmouse = mouse.Icon
game:GetService("StarterGui"):SetCoreGuiEnabled('Backpack', true)
Players.LocalPlayer.CharacterAdded:connect(function()
	local destroytool = Instance.new("Tool", Players.LocalPlayer:FindFirstChildOfClass("Backpack"))
	destroytool.RequiresHandle = false
	destroytool.Name = "Delete Tool"
	destroytool.ToolTip = "Nerkles Tool"
	destroytool.TextureId = "http://www.roblox.com/asset/?id=7733955511"
	destroytool.CanBeDropped = false
	destroytool.Equipped:connect(function()
		equipped = true
		mouse.Icon = "rbxasset://textures\\HammerCursor.png"
		while equipped do
			selectionbox.Adornee = mouse.Target
			wait()
		end
	end)
	destroytool.Unequipped:connect(function()
		equipped = false
		selectionbox.Adornee = nil
		mouse.Icon = oldmouse
		print(oldmouse)
	end)
	destroytool.Activated:connect(function()
		local explosion = Instance.new("Explosion", workspace)
		explosion.BlastPressure = 0
		explosion.BlastRadius = 0
		explosion.DestroyJointRadiusPercent = 0
		explosion.ExplosionType = Enum.ExplosionType.NoCraters
		explosion.Position = mouse.Target.Position
		DestroyPart(mouse.Target)
	end)
	game:GetService("StarterGui"):SetCoreGuiEnabled('Backpack', true)
end)
local destroytool = Instance.new("Tool", Players.LocalPlayer:FindFirstChildOfClass("Backpack"))
destroytool.RequiresHandle = false
destroytool.Name = "Delete Tool"
destroytool.ToolTip = "Nerkles Tool"
destroytool.TextureId = "http://www.roblox.com/asset/?id=7733955511"
destroytool.CanBeDropped = false
destroytool.Equipped:connect(function()
	equipped = true
	mouse.Icon = "rbxasset://textures\\HammerCursor.png"
	while equipped do
		selectionbox.Adornee = mouse.Target
		wait()
	end
end)
destroytool.Unequipped:connect(function()
	equipped = false
	selectionbox.Adornee = nil
	mouse.Icon = oldmouse
	print(oldmouse)
end)
destroytool.Activated:connect(function()
	local explosion = Instance.new("Explosion", workspace)
	explosion.BlastPressure = 0
	explosion.BlastRadius = 0
	explosion.DestroyJointRadiusPercent = 0
	explosion.ExplosionType = Enum.ExplosionType.NoCraters
	explosion.Position = mouse.Target.Position
	DestroyPart(mouse.Target)
end)
game:GetService("StarterGui"):SetCoreGuiEnabled('Backpack', true)
spawn(function()
	while true do
		wait(60)
		ImageLabel.Image = "rbxassetid://11751396176"
		wait(60)
		ImageLabel.Image = "rbxassetid://11751396176"
		wait(60)
		ImageLabel.Image = "rbxassetid://10111107769"
		wait(60)
		ImageLabel.Image = "rbxassetid://12053823591"
		wait(60)
		ImageLabel.Image = "rbxassetid://6013453821"
		wait(60)
		ImageLabel.Image = "rbxassetid://1107231018"
	end
	end)
ImageButton.MouseButton1Click:Connect(function()
		AntiSkid:Destroy()
end)
local UserInputService = game:GetService("UserInputService")
local gui = MainFrame
local dragging
local dragInput
local dragStart
local startPos
	local function update(input)
		local delta = input.Position - dragStart
		gui.Parent.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end

	gui.InputBegan:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and UserInputService:GetFocusedTextBox() == nil then
			dragging = true
			dragStart = input.Position
			startPos = gui.Parent.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	gui.InputChanged:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and UserInputService:GetFocusedTextBox() == nil then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
