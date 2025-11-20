
SMODS.Joker{ --Cave
    key = "cave",
    config = {
        extra = {
            Xmult = 1.5
        }
    },
    loc_txt = {
        ['name'] = 'Cave',
        ['text'] = {
            [1] = 'Each {C:attention}Stone{} card held in',
            [2] = 'hand gives {X:red,C:white}X1.5{} Mult'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 4
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["hatch_hatchet_jokers"] = true },
    
    calculate = function(self, card, context)
        if context.cardarea == G.hand and context.end_of_round  then
            if SMODS.get_enhancements(context.other_card)["m_stone"] == true then
                return {
                    Xmult = card.ability.extra.Xmult
                }
            end
        end
    end
}