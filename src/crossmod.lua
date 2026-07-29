-- Out-of-the-Box crossmod content.
local basecrossmod = {
	next(SMODS.find_mod('RevosVault')) and 'revosvault.lua',
	next(SMODS.find_mod('Incognito')) and 'incognito.lua',
	next(SMODS.find_mod('CardSleeves')) and 'sleeves.lua',
	next(SMODS.find_mod('TOGAPack')) and 'toga.lua'
    --e.g. next(SMODS.find_mod('Smallpox')) and 'smallpox.lua',
}

-- If none of these are valid, stop here.
if not next(basecrossmod) then sendInfoMessage("No eligible mods found, aborting...", "Hatchet"); return end

sendInfoMessage("Loading Cross-Mod content...", "Hatchet")
for _, file in pairs(basecrossmod) do
	sendDebugMessage("Executing src/crossmod/"..file, "Hatchet - Crossmod")
	assert(SMODS.load_file("src/crossmod/"..file))()
end

-- credit to TOGA'S Pack for this