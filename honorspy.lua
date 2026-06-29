-- TurtleHonorSpyEnhanced: core addon setup
-- Slash commands are in commands.lua; minimap button is in minimap.lua.

-- With THSE being defined in locale file, we don't want to override it here
THSE              = THSE or {}
THSE.addonUsers   = {}
THSE.versionDebug = false

function THSE.GetDB()
	return HonorSpy and HonorSpy.db and HonorSpy.db.char and HonorSpy.db.char.hs
end

function THSE.GetRealmDB()
	return HonorSpy and HonorSpy.db and HonorSpy.db.realm
end

-- Returns the canonical BG ID for a raw zone name, or nil if not a BG.
function THSE.GetBGID(zone)
    return zone and THSE.L.ZONE_TO_BG[zone]
end

-- Returns true if the zone name maps to a known battleground in the active locale.
function THSE.IsBGZone(zone)
    return zone ~= nil and THSE.L.ZONE_TO_BG[zone] ~= nil
end

-- ===== Shared BG data (used by overlay + honorhistory) =====
THSE.BG_MARK_ICON = {
	[THSE.LOCALE.BG.WSG]   = "Interface\\Icons\\INV_Misc_Rune_07",
	[THSE.LOCALE.BG.AB]    = "Interface\\Icons\\INV_Jewelry_Amulet_07",
	[THSE.LOCALE.BG.AV]    = "Interface\\Icons\\INV_Jewelry_Necklace_21",
	[THSE.LOCALE.BG.THORN] = "Interface\\Icons\\INV_Jewelry_Talisman_04",
	[THSE.LOCALE.BG.BLOOD] = "Interface\\Icons\\INV_Jewelry_Talisman_05",
}

THSE.ZONE_ABBR = {
	[THSE.LOCALE.BG.WSG]   = "WSG",
	[THSE.LOCALE.BG.AB]    = "AB",
	[THSE.LOCALE.BG.AV]    = "AV",
	[THSE.LOCALE.BG.THORN] = "Thorn",
	[THSE.LOCALE.BG.BLOOD] = "Blood",
}

-- Daily BG rotation (5-day cycle). Anchor: 2026-03-22 = index 0 (WSG).
local _DAILY_BG_CYCLE = {
	[0] = THSE.LOCALE.BG.WSG,
	[1] = THSE.LOCALE.BG.AB,
	[2] = THSE.LOCALE.BG.BLOOD,
	[3] = THSE.LOCALE.BG.THORN,
	[4] = THSE.LOCALE.BG.AV,
}
local _DAILY_BG_ANCHOR = 20534  -- floor(time({2026,3,22,0,0,0}) / 86400) in UTC days

function THSE.GetDailyBG(timestamp)
	local utcDay = math.floor(timestamp / 86400)
	local diff = utcDay - _DAILY_BG_ANCHOR
	local idx = math.mod(diff, 5)
	if idx < 0 then idx = idx + 5 end
	return _DAILY_BG_CYCLE[idx]
end

HonorSpy = AceLibrary("AceAddon-2.0"):new("AceDB-2.0", "AceEvent-2.0", "AceModuleCore-2.0")

HonorSpy:RegisterDB("HonorSpyDB")
HonorSpy:RegisterDefaults('char', {
	hs = {
		overlayPos          = nil,
		overlayHidden       = false,
		minimapAngle        = 200,
		minimapHidden       = false,
		weeklyStartProgress = nil,
		weeklyResetStamp    = 0,
		weekApiHonor        = {},
		sessionStartHonor   = 0,
		honorHistory        = {},
		histCollapsed       = {},
		histCompactMode     = 0,
		histHideZero        = false,
		histDayCollapsed    = {},
		histWeekCollapsed   = {},
	}
})
HonorSpy:RegisterDefaults('realm', {
	addonUsers          = {}
})

function HonorSpy:OnEnable()
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
end

function HonorSpy:PLAYER_ENTERING_WORLD()
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	-- Minimap button creation is handled by minimap.lua
end