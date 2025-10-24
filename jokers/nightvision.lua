SMODS.Joker{ --Night Vision
    key = "nightvision",
    config = {
        extra = {
            jokercount = 1
        }
    },
    loc_txt = {
        ['name'] = 'Night Vision',
        ['text'] = {
            [1] = 'Gains {X:red,C:white}X0.2{} Mult per',
            [2] = '{C:attention}Joker {}held in hand',
            [3] = '{C:inactive}(Currently {}{X:red,C:white}X#1#{}{C:inactive} Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["hatchet_hatchet_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.jokercount + (#(G.jokers and (G.jokers and G.jokers.cards or {}) or {})) * 0.2}}
    end,

    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = card.ability.extra.jokercount + (#(G.jokers and G.jokers.cards or {})) * 0.2
            }
        end
    end
}