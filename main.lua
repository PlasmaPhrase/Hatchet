--ATLASES
SMODS.Atlas({
    key = "modicon", 
    path = "ModIcon.png", 
    px = 34,
    py = 34,
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "balatro", 
    path = "balatro.png", 
    px = 333,
    py = 216,
    prefix_config = { key = false },
    atlas_table = "ASSET_ATLAS"
})


SMODS.Atlas({
    key = "CustomJokers", 
    path = "CustomJokers.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "CustomConsumables", 
    path = "CustomConsumables.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "CustomBoosters", 
    path = "CustomBoosters.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "CustomEnhancements", 
    path = "CustomEnhancements.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "CustomDecks", 
    path = "CustomDecks.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "CustomStickers", 
    path = "CustomStickers.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "CustomStakes", 
    path = "CustomStakes.png",
    px = 29,
    py = 29, 
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "CustomBlinds", 
    path = "CustomBlinds.png", 
    px = 34,
    py = 34, 
    frames = 21, 
    atlas_table = "ANIMATION_ATLAS"
})

--loading src files
assert(SMODS.load_file("src/blinds.lua"))()
assert(SMODS.load_file('src/jokers.lua'))()
assert(SMODS.load_file("src/c_sephirot.lua"))()
assert(SMODS.load_file("src/c_divine.lua"))()
assert(SMODS.load_file("src/sounds.lua"))()
assert(SMODS.load_file("src/stakes.lua"))()
assert(SMODS.load_file("src/backs.lua"))()
assert(SMODS.load_file("src/enhancements.lua"))()
assert(SMODS.load_file("src/editions.lua"))()
assert(SMODS.load_file("src/challenges.lua"))()
assert(SMODS.load_file("src/stickers.lua"))()
assert(SMODS.load_file("src/boosters.lua"))()

SMODS.ConsumableType {
    key = 'divine',
    primary_colour = HEX('484cdb'),
    secondary_colour = HEX('484cdb'),
    collection_rows = { 4, 5 },
    shop_rate = 0,
    cards = {
        ['c_hatch_daat'] = true,
        ['c_hatch_soulofhatchet'] = true
    },
    loc_txt = {
        name = "Divine",
        collection = "Divine Cards",
    }
}

SMODS.ConsumableType {
    key = 'sephirot',
    primary_colour = HEX('0ebab2'),
    secondary_colour = HEX('0ebab2'),
    collection_rows = { 4, 5 },
    shop_rate = 0,
    cards = {
        ['c_hatch_kether'] = true,
        ['c_hatch_chokmah'] = true,
        ['c_hatch_binah'] = true,
        ['c_hatch_chesed'] = true,
        ['c_hatch_gevurah'] = true,
        ['c_hatch_tiferet'] = true,
        ['c_hatch_netzach'] = true,
        ['c_hatch_hod'] = true,
        ['c_hatch_yesod'] = true,
        ['c_hatch_malkuth'] = true
    },
    loc_txt = {
        name = "Sephirot",
        collection = "Sephirot Cards",
    }
}

SMODS.current_mod.optional_features = function()
    return {
        cardareas = {} 
    }
end

-- rarities
SMODS.Rarity {
    key = "evolved",
    pools = {
        ["Joker"] = true
    },
    default_weight = 0,
    badge_colour = HEX('4a90e2'),
    loc_txt = {
        name = "Evolved"
    },
    get_weight = function(self, weight, object_type)
        return weight
    end,
}

--- Main Menu Colours (Credit to Cryptid and JoyousSpring)
local game_main_menu_ref = Game.main_menu
function Game:main_menu(change_context)
    local ret = game_main_menu_ref(self, change_context)

        local colours = { c1 = HEX("4d5670"), c2 = HEX("fd5f55") }
        G.SPLASH_BACK:define_draw_steps({
            {
                shader = "splash",
                send = {
                    { name = "time",       ref_table = G.TIMERS, ref_value = "REAL_SHADER" },
                    { name = "vort_speed", val = 0.4 },
                    { name = "colour_1",   ref_table = colours,  ref_value = "c1" },
                    { name = "colour_2",   ref_table = colours,      ref_value = "c2" },
                },
            },
        })
    return ret
end

-- Credit to NopeTooFast

SMODS.current_mod.menu_cards = function()
return {
  { key = 'j_hatch_hatchet' },
  remove_original = true
} end