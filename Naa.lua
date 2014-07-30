-----------------------------------------------------------------------------------------------
-- Client Lua Script for Naa
-- Copyright (c) NCsoft. All rights reserved
-----------------------------------------------------------------------------------------------
 
require "Window"
require "GameLib"

local error, floor, ipairs, pairs, tostring = error, math.floor, ipairs, pairs, tostring
local strformat = string.format

-- Wildstar APIs
local Apollo, ApolloColor, ApolloTimer, ICCommLib = Apollo, ApolloColor, ApolloTimer, ICCommLib
local GameLib, CraftingLib = GameLib, CraftingLib
local Event_FireGenericEvent, Print = Event_FireGenericEvent, Print

local Naa = Apollo.GetPackage("Gemini:Addon-1.1").tPackage:NewAddon("Naa", false)
local GeminiGUI = Apollo.GetPackage("Gemini:GUI-1.0").tPackage

function Naa:OnInitialize()
    Apollo.RegisterSlashCommand("naa", "OnNaaOn", self)
    self.db = Apollo.GetPackage("Gemini:DB-1.0").tPackage:New("NaaDB", defaults, true)
end
 
function Naa:OnEnable()

end

function Naa:OnNaaOn()
    local unitMe = GameLib.GetPlayerUnit()
    local ClassID = unitMe.GetClassId()
    self.CharacterInfo =
    {
        CharEP = GetElderPoints(),
        CharXP = GetXp(),
        CharRestedXP = GetRestXp(),
        CharXpToNextLevel = GetXpToNextLevel(),
        CharPercentToNext = GetXpPercentToNextLevel(),
        CharGearScore = GameLib.GetGearScore(),
        Realm = GameLib.GetRealmName(),
        CharAP = GameLib.GetTotalAbilityPoints(),
        PlayerName = unitMe:GetName(),
        LastLoginTime = "",
        CharClass = GameLib.GetClassName(ClassID),
        CharRaceid = unitMe.GetRaceId(),
        CharGender = unitMe.GetGender(),
        CharHealth = unitMe.GetHealth(),
        CharMana = unitMe.GetMana(),
        CharShield = unitMe.GetShieldCapacityMax(),
        CharLevel = unitMe.GetLevel(),
        CharPath = unitMe.GetPlayerPathType(),
        CharGuildName = unitMe.GetGuildName(),
        CharTradeskills = CraftingLib.GetKnownTradeskills()
    }
    Event_FireGenericEvent("SendVarToRover", "CharacterInfo", self.CharacterInfo)
end


-- when the OK button is clicked
function Naa:OnOK()
	self.wndMain:Close() -- hide the window
end

-- when the Cancel button is clicked
function Naa:OnCancel()
	self.wndMain:Close() -- hide the window
end