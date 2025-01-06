--Nerkles v1
--Based on HarkedV2 Reborn
local DELETEEVENT = game:GetService("ReplicatedStorage").DeleteCar
local Nerkles = Instance.new("ScreenGui")
local main = Instance.new("Frame")
local Text = Instance.new("TextLabel")
local Topbar = Instance.new("Frame")
local ScrollingFrame = Instance.new("ScrollingFrame")
local KickAll = Instance.new("TextButton")
local dex = Instance.new("TextButton")
local KillAll = Instance.new("TextButton")
local DestroyWS = Instance.new("TextButton")
local DestroyGame = Instance.new("TextButton")
local DestroyRP = Instance.new("TextButton")
local TextButton = Instance.new("TextButton")
local Slock = Instance.new("TextButton")
local TextButton_2 = Instance.new("TextButton")
local TextButton_3 = Instance.new("TextButton")
local TextButton_4 = Instance.new("TextButton")
local TextButton_5 = Instance.new("TextButton")
local Players = game:GetService("Players")
function splitString(str,delim)
	local broken = {}
	if delim == nil then delim = "," end
	for w in string.gmatch(str,"[^"..delim.."]+") do
		table.insert(broken,w)
	end
	return broken
end
function toTokens(str)
	local tokens = {}
	for op,name in string.gmatch(str,"([+-])([^+-]+)") do
		table.insert(tokens,{Operator = op,Name = name})
	end
	return tokens
end
function getRoot(char)
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end
local WTS = function(Object)
	local ObjectVector = workspace.CurrentCamera:WorldToScreenPoint(Object.Position)
	return Vector2.new(ObjectVector.X, ObjectVector.Y)
end
local mouse = Players.LocalPlayer:GetMouse()
local MousePositionToVector2 = function()
	return Vector2.new(mouse.X, mouse.Y)
end
local GetClosestPlayerFromCursor = function()
	local found = nil
	local ClosestDistance = math.huge
	for i, v in pairs(Players:GetPlayers()) do
		if v ~= Players.LocalPlayer and v.Character and v.Character:FindFirstChildOfClass("Humanoid") then
			for k, x in pairs(v.Character:GetChildren()) do
				if string.find(x.Name, "Torso") then
					local Distance = (WTS(x) - MousePositionToVector2()).Magnitude
					if Distance < ClosestDistance then
						ClosestDistance = Distance
						found = v
					end
				end
			end
		end
	end
	return found
end
local SpecialPlayerCases = {
	["all"] = function(speaker) return Players:GetPlayers() end,
	["others"] = function(speaker)
		local plrs = {}
		for i,v in pairs(Players:GetPlayers()) do
			if v ~= speaker then
				table.insert(plrs,v)
			end
		end
		return plrs
	end,
	["me"] = function(speaker)return {speaker} end,
	["#(%d+)"] = function(speaker,args,currentList)
		local returns = {}
		local randAmount = tonumber(args[1])
		local players = {unpack(currentList)}
		for i = 1,randAmount do
			if #players == 0 then break end
			local randIndex = math.random(1,#players)
			table.insert(returns,players[randIndex])
			table.remove(players,randIndex)
		end
		return returns
	end,
	["random"] = function(speaker,args,currentList)
		local players = Players:GetPlayers()
		local localplayer = Players.LocalPlayer
		table.remove(players, table.find(players, localplayer))
		return {players[math.random(1,#players)]}
	end,
	["%%(.+)"] = function(speaker,args)
		local returns = {}
		local team = args[1]
		for _,plr in pairs(Players:GetPlayers()) do
			if plr.Team and string.sub(string.lower(plr.Team.Name),1,#team) == string.lower(team) then
				table.insert(returns,plr)
			end
		end
		return returns
	end,
	["allies"] = function(speaker)
		local returns = {}
		local team = speaker.Team
		for _,plr in pairs(Players:GetPlayers()) do
			if plr.Team == team then
				table.insert(returns,plr)
			end
		end
		return returns
	end,
	["enemies"] = function(speaker)
		local returns = {}
		local team = speaker.Team
		for _,plr in pairs(Players:GetPlayers()) do
			if plr.Team ~= team then
				table.insert(returns,plr)
			end
		end
		return returns
	end,
	["team"] = function(speaker)
		local returns = {}
		local team = speaker.Team
		for _,plr in pairs(Players:GetPlayers()) do
			if plr.Team == team then
				table.insert(returns,plr)
			end
		end
		return returns
	end,
	["nonteam"] = function(speaker)
		local returns = {}
		local team = speaker.Team
		for _,plr in pairs(Players:GetPlayers()) do
			if plr.Team ~= team then
				table.insert(returns,plr)
			end
		end
		return returns
	end,
	["friends"] = function(speaker,args)
		local returns = {}
		for _,plr in pairs(Players:GetPlayers()) do
			if plr:IsFriendsWith(speaker.UserId) and plr ~= speaker then
				table.insert(returns,plr)
			end
		end
		return returns
	end,
	["nonfriends"] = function(speaker,args)
		local returns = {}
		for _,plr in pairs(Players:GetPlayers()) do
			if not plr:IsFriendsWith(speaker.UserId) and plr ~= speaker then
				table.insert(returns,plr)
			end
		end
		return returns
	end,
	["guests"] = function(speaker,args)
		local returns = {}
		for _,plr in pairs(Players:GetPlayers()) do
			if plr.Guest then
				table.insert(returns,plr)
			end
		end
		return returns
	end,
	["bacons"] = function(speaker,args)
		local returns = {}
		for _,plr in pairs(Players:GetPlayers()) do
			if plr.Character:FindFirstChild('Pal Hair') or plr.Character:FindFirstChild('Kate Hair') then
				table.insert(returns,plr)
			end
		end
		return returns
	end,
	["age(%d+)"] = function(speaker,args)
		local returns = {}
		local age = tonumber(args[1])
		if not age == nil then return end
		for _,plr in pairs(Players:GetPlayers()) do
			if plr.AccountAge <= age then
				table.insert(returns,plr)
			end
		end
		return returns
	end,
	["nearest"] = function(speaker,args,currentList)
		local speakerChar = speaker.Character
		if not speakerChar or not getRoot(speakerChar) then return end
		local lowest = math.huge
		local NearestPlayer = nil
		for _,plr in pairs(currentList) do
			if plr ~= speaker and plr.Character then
				local distance = plr:DistanceFromCharacter(getRoot(speakerChar).Position)
				if distance < lowest then
					lowest = distance
					NearestPlayer = {plr}
				end
			end
		end
		return NearestPlayer
	end,
	["farthest"] = function(speaker,args,currentList)
		local speakerChar = speaker.Character
		if not speakerChar or not getRoot(speakerChar) then return end
		local highest = 0
		local Farthest = nil
		for _,plr in pairs(currentList) do
			if plr ~= speaker and plr.Character then
				local distance = plr:DistanceFromCharacter(getRoot(speakerChar).Position)
				if distance > highest then
					highest = distance
					Farthest = {plr}
				end
			end
		end
		return Farthest
	end,
	["group(%d+)"] = function(speaker,args)
		local returns = {}
		local groupID = tonumber(args[1])
		for _,plr in pairs(Players:GetPlayers()) do
			if plr:IsInGroup(groupID) then  
				table.insert(returns,plr)
			end
		end
		return returns
	end,
	["alive"] = function(speaker,args)
		local returns = {}
		for _,plr in pairs(Players:GetPlayers()) do
			if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") and plr.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
				table.insert(returns,plr)
			end
		end
		return returns
	end,
	["dead"] = function(speaker,args)
		local returns = {}
		for _,plr in pairs(Players:GetPlayers()) do
			if (not plr.Character or not plr.Character:FindFirstChildOfClass("Humanoid")) or plr.Character:FindFirstChildOfClass("Humanoid").Health <= 0 then
				table.insert(returns,plr)
			end
		end
		return returns
	end,
	["rad(%d+)"] = function(speaker,args)
		local returns = {}
		local radius = tonumber(args[1])
		local speakerChar = speaker.Character
		if not speakerChar or not getRoot(speakerChar) then return end
		for _,plr in pairs(Players:GetPlayers()) do
			if plr.Character and getRoot(plr.Character) then
				local magnitude = (getRoot(plr.Character).Position-getRoot(speakerChar).Position).magnitude
				if magnitude <= radius then table.insert(returns,plr) end
			end
		end
		return returns
	end,
	["cursor"] = function(speaker)
		local plrs = {}
		local v = GetClosestPlayerFromCursor()
		if v ~= nil then table.insert(plrs, v) end
		return plrs
	end,
}
function onlyIncludeInTable(tab,matches)
	local matchTable = {}
	local resultTable = {}
	for i,v in pairs(matches) do matchTable[v.Name] = true end
	for i,v in pairs(tab) do if matchTable[v.Name] then table.insert(resultTable,v) end end
	return resultTable
end

function removeTableMatches(tab,matches)
	local matchTable = {}
	local resultTable = {}
	for i,v in pairs(matches) do matchTable[v.Name] = true end
	for i,v in pairs(tab) do if not matchTable[v.Name] then table.insert(resultTable,v) end end
	return resultTable
end

function getPlayersByName(Name)
	local Name,Len,Found = string.lower(Name),#Name,{}
	for _,v in pairs(Players:GetPlayers()) do
		if Name:sub(0,1) == '@' then
			if string.sub(string.lower(v.Name),1,Len-1) == Name:sub(2) then
				table.insert(Found,v)
			end
		else
			if string.sub(string.lower(v.Name),1,Len) == Name or string.sub(string.lower(v.DisplayName),1,Len) == Name then
				table.insert(Found,v)
			end
		end
	end
	return Found
end
function getPlayer(list,speaker)
	if list == nil then return {speaker.Name} end
	local nameList = splitString(list,",")

	local foundList = {}

	for _,name in pairs(nameList) do
		if string.sub(name,1,1) ~= "+" and string.sub(name,1,1) ~= "-" then name = "+"..name end
		local tokens = toTokens(name)
		local initialPlayers = Players:GetPlayers()

		for i,v in pairs(tokens) do
			if v.Operator == "+" then
				local tokenContent = v.Name
				local foundCase = false
				for regex,case in pairs(SpecialPlayerCases) do
					local matches = {string.match(tokenContent,"^"..regex.."$")}
					if #matches > 0 then
						foundCase = true
						initialPlayers = onlyIncludeInTable(initialPlayers,case(speaker,matches,initialPlayers))
					end
				end
				if not foundCase then
					initialPlayers = onlyIncludeInTable(initialPlayers,getPlayersByName(tokenContent))
				end
			else
				local tokenContent = v.Name
				local foundCase = false
				for regex,case in pairs(SpecialPlayerCases) do
					local matches = {string.match(tokenContent,"^"..regex.."$")}
					if #matches > 0 then
						foundCase = true
						initialPlayers = removeTableMatches(initialPlayers,case(speaker,matches,initialPlayers))
					end
				end
				if not foundCase then
					initialPlayers = removeTableMatches(initialPlayers,getPlayersByName(tokenContent))
				end
			end
		end

		for i,v in pairs(initialPlayers) do table.insert(foundList,v) end
	end

	local foundNames = {}
	for i,v in pairs(foundList) do table.insert(foundNames,v.Name) end

	return foundNames
end
function Destroy(instance)
	spawn(function()
		DELETEEVENT:FireServer(instance)
	end)
end

local slockk = false
local banned = {}
Players.PlayerAdded:connect(function(plr)
	if slockk then
		Destroy(plr)
	end
end)

Nerkles.Name = "Nerkles"
Nerkles.Parent = game:GetService("CoreGui")
Nerkles.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Nerkles.ResetOnSpawn = false

main.Name = "main"
main.Parent = Nerkles
main.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
main.BackgroundTransparency = 0.200
main.BorderColor3 = Color3.fromRGB(0, 0, 0)
main.BorderSizePixel = 0
main.Position = UDim2.new(0.520370364, 0, 0.461346626, 0)
main.Size = UDim2.new(0, 388, 0, 259)
main.ZIndex = 99999999999999999999

Text.Name = "Text"
Text.Parent = main
Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Text.BackgroundTransparency = 1.000
Text.LayoutOrder = 1
Text.Position = UDim2.new(0, 0, 0.0154440152, 0)
Text.Size = UDim2.new(0, 176, 0, 34)
Text.Font = Enum.Font.Highway
Text.Text = "Nerkles v1"
Text.TextColor3 = Color3.fromRGB(255, 255, 255)
Text.TextSize = 43.000

Topbar.Name = "Topbar"
Topbar.Parent = main
Topbar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Topbar.BackgroundTransparency = 0.900
Topbar.BorderColor3 = Color3.fromRGB(27, 42, 53)
Topbar.Size = UDim2.new(0, 388, 0, 39)

ScrollingFrame.Parent = main
ScrollingFrame.Active = true
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ScrollingFrame.BackgroundTransparency = 1.000
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.Position = UDim2.new(0, 0, 0.146718144, 0)
ScrollingFrame.Size = UDim2.new(0, 386, 0, 218)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 1, 0)

KickAll.Name = "KickAll"
KickAll.Parent = ScrollingFrame
KickAll.BackgroundColor3 = Color3.fromRGB(135, 135, 135)
KickAll.Position = UDim2.new(0.0414507762, 0, 0.058928553, 0)
KickAll.Size = UDim2.new(0, 109, 0, 47)
KickAll.Font = Enum.Font.Arial
KickAll.Text = "Kick all"
KickAll.TextColor3 = Color3.fromRGB(255, 255, 255)
KickAll.TextSize = 20.000
KickAll.MouseButton1Click:connect(function()
	local Players = game:GetService("Players")
	for _,o in pairs(Players:GetPlayers()) do
		Destroy(o)
	end
end)

dex.Name = "dex"
dex.Parent = ScrollingFrame
dex.BackgroundColor3 = Color3.fromRGB(135, 135, 135)
dex.Position = UDim2.new(0.360103607, 0, 0.058928553, 0)
dex.Size = UDim2.new(0, 109, 0, 47)
dex.Font = Enum.Font.Arial
dex.Text = "Explorer"
dex.TextColor3 = Color3.fromRGB(255, 255, 255)
dex.TextSize = 20.000

KillAll.Name = "KillAll"
KillAll.Parent = ScrollingFrame
KillAll.BackgroundColor3 = Color3.fromRGB(135, 135, 135)
KillAll.Position = UDim2.new(0.665803075, 0, 0.058928553, 0)
KillAll.Size = UDim2.new(0, 109, 0, 47)
KillAll.Font = Enum.Font.Arial
KillAll.Text = "KillAll"
KillAll.TextColor3 = Color3.fromRGB(255, 255, 255)
KillAll.TextSize = 20.000
KillAll.MouseButton1Click:Connect(function()
for _, Target in pairs(game.Workspace:GetDescendants()) do
    if Target:FindFirstChild("Humanoid") then
			local humanoid = Target.Humanoid
			Destroy(humanoid)
		end
	end
end)

DestroyWS.Name = "DestroyWS"
DestroyWS.Parent = ScrollingFrame
DestroyWS.BackgroundColor3 = Color3.fromRGB(135, 135, 135)
DestroyWS.Position = UDim2.new(0.0414507762, 0, 0.259700745, 0)
DestroyWS.Size = UDim2.new(0, 109, 0, 47)
DestroyWS.Font = Enum.Font.Arial
DestroyWS.Text = "Destroy(WS)"
DestroyWS.TextColor3 = Color3.fromRGB(255, 0, 0)
DestroyWS.TextScaled = true
DestroyWS.TextSize = 20.000
DestroyWS.TextWrapped = true
DestroyWS.MouseButton1Click:Connect(function()
	for _, Target in pairs(game.Workspace:GetDescendants()) do
		Destroy(Target)
	end
end)

DestroyGame.Name = "DestroyGame"
DestroyGame.Parent = ScrollingFrame
DestroyGame.BackgroundColor3 = Color3.fromRGB(135, 135, 135)
DestroyGame.Position = UDim2.new(0.360103607, 0, 0.259700745, 0)
DestroyGame.Size = UDim2.new(0, 109, 0, 47)
DestroyGame.Font = Enum.Font.Arial
DestroyGame.Text = "Destroy(GAME)"
DestroyGame.TextColor3 = Color3.fromRGB(255, 0, 0)
DestroyGame.TextScaled = true
DestroyGame.TextSize = 20.000
DestroyGame.TextWrapped = true
DestroyGame.MouseButton1Click:Connect(function()
	for _, Target in pairs(game:GetDescendants()) do
		Destroy(Target)
	end
end)

DestroyRP.Name = "DestroyRP"
DestroyRP.Parent = ScrollingFrame
DestroyRP.BackgroundColor3 = Color3.fromRGB(135, 135, 135)
DestroyRP.Position = UDim2.new(0.665803075, 0, 0.259700745, 0)
DestroyRP.Size = UDim2.new(0, 109, 0, 47)
DestroyRP.Font = Enum.Font.Arial
DestroyRP.Text = "Destroy(RP)"
DestroyRP.TextColor3 = Color3.fromRGB(255, 0, 0)
DestroyRP.TextScaled = true
DestroyRP.TextSize = 20.000
DestroyRP.TextWrapped = true
DestroyRP.MouseButton1Click:Connect(function()
	for _, Target in pairs(game.ReplicatedStorage:GetDescendants()) do
		Destroy(Target)
	end
end)

TextButton.Parent = ScrollingFrame
TextButton.BackgroundColor3 = Color3.fromRGB(91, 91, 91)
TextButton.Position = UDim2.new(0.0414507762, 0, 0.460472941, 0)
TextButton.Size = UDim2.new(0, 109, 0, 47)
TextButton.Font = Enum.Font.Arial
TextButton.Text = "SOON"
TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton.TextSize = 20.000

Slock.Name = "Slock"
Slock.Parent = ScrollingFrame
Slock.BackgroundColor3 = Color3.fromRGB(135, 135, 135)
Slock.Position = UDim2.new(0.360103607, 0, 0.460472941, 0)
Slock.Size = UDim2.new(0, 109, 0, 47)
Slock.Font = Enum.Font.Arial
Slock.Text = "ServerLock"
Slock.TextColor3 = Color3.fromRGB(255, 255, 255)
Slock.TextSize = 20.000
Slock.MouseButton1Click:connect(function()
	if slockk then 
		print"SLOCK: false"
		slockk = false
	else
		print"SLOCK: true"
		slockk = true
	end
end)

TextButton_2.Parent = ScrollingFrame
TextButton_2.BackgroundColor3 = Color3.fromRGB(91, 91, 91)
TextButton_2.Position = UDim2.new(0.665803075, 0, 0.460472941, 0)
TextButton_2.Size = UDim2.new(0, 109, 0, 47)
TextButton_2.Font = Enum.Font.Arial
TextButton_2.Text = "SOON"
TextButton_2.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_2.TextSize = 20.000

TextButton_3.Parent = ScrollingFrame
TextButton_3.BackgroundColor3 = Color3.fromRGB(91, 91, 91)
TextButton_3.Position = UDim2.new(0.360103607, 0, 0.665106177, 0)
TextButton_3.Size = UDim2.new(0, 109, 0, 47)
TextButton_3.Font = Enum.Font.Arial
TextButton_3.Text = "SOON"
TextButton_3.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_3.TextSize = 20.000

TextButton_4.Parent = ScrollingFrame
TextButton_4.BackgroundColor3 = Color3.fromRGB(91, 91, 91)
TextButton_4.Position = UDim2.new(0.0414507762, 0, 0.665106177, 0)
TextButton_4.Size = UDim2.new(0, 109, 0, 47)
TextButton_4.Font = Enum.Font.Arial
TextButton_4.Text = "SOON"
TextButton_4.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_4.TextSize = 20.000

TextButton_5.Parent = ScrollingFrame
TextButton_5.BackgroundColor3 = Color3.fromRGB(91, 91, 91)
TextButton_5.Position = UDim2.new(0.665803075, 0, 0.665106177, 0)
TextButton_5.Size = UDim2.new(0, 109, 0, 47)
TextButton_5.Font = Enum.Font.Arial
TextButton_5.Text = "SOON"
TextButton_5.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_5.TextSize = 20.000

local function drag()
	local script = Instance.new('LocalScript', Topbar)

	local UserInputService = game:GetService("UserInputService")
	
	local gui = script.Parent
	
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
end
coroutine.wrap(drag)()
