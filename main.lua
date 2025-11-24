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

SMODS.ConsumableType({
    key = "divine",
    name = "Divine",
    primary_colour = { 0.408, 0.420, 0.647, 1 },
    secondary_colour = { 0.306, 0.315, 0.485, 1 },
    collection_rows = { 4, 4 },
    shop_rate = 0,
    default = "c_hatch_daat"
})

SMODS.ConsumableType({
    key = "sephirot",
    name = "Sephirot",
    primary_colour = { 0.290, 0.541, 0.494, 1 },
    secondary_colour = { 0.218, 0.406, 0.371, 1 },
    collection_rows = { 4, 4 },
    shop_rate = 0,
    default = "c_hatch_kether"
})

SMODS.current_mod.optional_features = function()
    return {
        cardareas = {} 
    }
end