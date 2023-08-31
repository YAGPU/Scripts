local Library = loadstring(game:HttpGet(“https://raw.githubusercontent.com/YAGPU/Scripts/main/Ability%20Wars/Ability%20Mastery%20Creator.lua”, true))()

local MasteryTable = {
  E = false,
  Q = true,
  R = true,

  Base = "Gravity",
  
  QF = function()
    workspace.Gravity += 40
  end,

  RF = function()
    workspace.Gravity -= 40
  end,

  onDeath = function()
    workspace.Gravity = 196.2
  end
}

Library:SetupMastery(MasteryTable)
