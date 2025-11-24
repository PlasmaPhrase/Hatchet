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
    key = "CustomBlinds", 
    path = "CustomBlinds.png", 
    px = 34,
    py = 34, 
    frames = 21, 
    atlas_table = "ANIMATION_ATLAS"
})

local NFS = require("nativefs")
to_big = to_big or function(a) return a end
lenient_bignum = lenient_bignum or function(a) return a end

assert(SMODS.load_file('src/jokers.lua'))()
assert(SMODS.load_file("src/c_sephirot.lua"))()
assert(SMODS.load_file("src/c_divine.lua"))()
assert(SMODS.load_file("sounds.lua"))()
assert(SMODS.load_file("src/backs.lua"))()
assert(SMODS.load_file("src/enhancements.lua"))()
assert(SMODS.load_file("src/editions.lua"))()
assert(SMODS.load_file("src/challenges.lua"))()

local function load_boosters_file()
    local mod_path = SMODS.current_mod.path
    assert(SMODS.load_file("boosters.lua"))()
end

load_boosters_file()
SMODS.ObjectType({
    key = "hatch_food",
    cards = {
        ["j_gros_michel"] = true,
        ["j_egg"] = true,
        ["j_ice_cream"] = true,
        ["j_cavendish"] = true,
        ["j_turtle_bean"] = true,
        ["j_diet_cola"] = true,
        ["j_popcorn"] = true,
        ["j_ramen"] = true,
        ["j_selzer"] = true
    },
})

SMODS.ObjectType({
    key = "hatch_hatch_jokers",
    cards = {
        ["j_hatch_airmissile"] = true,
        ["j_hatch_blackjoker"] = true,
        ["j_hatch_blueshoes"] = true,
        ["j_hatch_cave"] = true,
        ["j_hatch_composter"] = true,
        ["j_hatch_d20"] = true,
        ["j_hatch_etzchaim"] = true,
        ["j_hatch_giraffe"] = true,
        ["j_hatch_graveyardshift"] = true,
        ["j_hatch_handout"] = true,
        ["j_hatch_loveletter"] = true,
        ["j_hatch_musketeer"] = true,
        ["j_hatch_needlenonsense"] = true,
        ["j_hatch_nightvision"] = true,
        ["j_hatch_ninelives"] = true,
        ["j_hatch_nodice"] = true,
        ["j_hatch_pizza"] = true,
        ["j_hatch_plantparty"] = true,
        ["j_hatch_riskyrevolver"] = true,
        ["j_hatch_staircase"] = true,
        ["j_hatch_stockexchange"] = true,
        ["j_hatch_sunset"] = true,
        ["j_hatch_swindler"] = true,
        ["j_hatch_trickyjoker"] = true,
        ["j_hatch_wildside"] = true
    },
})

SMODS.ConsumableType {
    key = 'divine',
    primary_colour = HEX('484cdb'),
    secondary_colour = HEX('484cdb'),
    collection_rows = { 4, 5 },
    shop_rate = 4,
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