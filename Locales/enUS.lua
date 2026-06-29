-- No locale check, this is the default
-- If a locale has already been loaded, skip
if THSE and THSE.LOCALE then return end

THSE = THSE or {}
THSE.LOCALE = {}
local LOCALE = THSE.LOCALE



-- Battleground zone names (must match GetRealZoneText() output)
LOCALE.BG = {}
LOCALE.BG.WSG   = "Warsong Gulch"
LOCALE.BG.AB    = "Arathi Basin"
LOCALE.BG.AV    = "Alterac Valley"
LOCALE.BG.THORN = "Thorn Gorge"
LOCALE.BG.BLOOD = "Blood Ring"



LOCALE.ALLIANCE = {}
LOCALE.ALLIANCE.R1  = "Private"
LOCALE.ALLIANCE.R2  = "Corporal"
LOCALE.ALLIANCE.R3  = "Sergeant"
LOCALE.ALLIANCE.R4  = "Master Sergeant"
LOCALE.ALLIANCE.R5  = "Sergeant Major"
LOCALE.ALLIANCE.R6  = "Knight"
LOCALE.ALLIANCE.R7  = "Knight-Lieutenant"
LOCALE.ALLIANCE.R8  = "Knight-Captain"
LOCALE.ALLIANCE.R9  = "Knight-Champion"
LOCALE.ALLIANCE.R10 = "Lieutenant Commander"
LOCALE.ALLIANCE.R11 = "Commander"
LOCALE.ALLIANCE.R12 = "Marshal"
LOCALE.ALLIANCE.R13 = "Field Marshal"
LOCALE.ALLIANCE.R14 = "Grand Marshal"

LOCALE.HORDE = {}
LOCALE.HORDE.R1  = "Scout"
LOCALE.HORDE.R2  = "Grunt"
LOCALE.HORDE.R3  = "Sergeant"
LOCALE.HORDE.R4  = "Senior Sergeant"
LOCALE.HORDE.R5  = "First Sergeant"
LOCALE.HORDE.R6  = "Stone Guard"
LOCALE.HORDE.R7  = "Blood Guard"
LOCALE.HORDE.R8  = "Legionnaire"
LOCALE.HORDE.R9  = "Centurion"
LOCALE.HORDE.R10 = "Champion"
LOCALE.HORDE.R11 = "Lieutenant General"
LOCALE.HORDE.R12 = "General"
LOCALE.HORDE.R13 = "Warlord"
LOCALE.HORDE.R14 = "High Warlord"



-- ========== Quest names ==========
-- Quests that turn in marks from all three main BGs simultaneously

LOCALE.CONCERTED_QUESTS = {
    ["concerted efforts"] = "Concerted Efforts",
    ["for great honor"]   = "For Great Honor",
}



-- ===== Chat message patterns =====
-- Substrings are searched in the lowercased message
-- Capture patterns are applied to the raw (not lowercased) message

LOCALE.PATTERNS = {}
LOCALE.PATTERNS.BG_WIN           = { "win", "victori", "conquer" }
LOCALE.PATTERNS.BG_LOSS          = { "defea", "lost the battle" }
LOCALE.PATTERNS.FACTION_ALLIANCE = "alliance"
LOCALE.PATTERNS.FACTION_HORDE    = "horde"
LOCALE.PATTERNS.QUEST_COMPLETE   = { "completed" }
LOCALE.PATTERNS.HONOR_AWARD      = "awarded (%d+) honor"
LOCALE.PATTERNS.HONOR_AMOUNT     = {
    LOCALE.PATTERNS.HONOR_AWARD,
    "you gain (%d+) honor",
}
LOCALE.PATTERNS.HONOR_KILL       = "(.+) dies, honorable kill Rank: ([^%(]+)%(Estimated Honor Points: (%d+)%)"
LOCALE.PATTERNS.DISHONOR_KILL    = "(.+) dies, dishonorable kill"