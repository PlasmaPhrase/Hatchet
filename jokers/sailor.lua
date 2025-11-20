
SMODS.Joker{ --Sailor
    key = "sailor",
    config = {
        extra = {
            goldchips = 0,
            text = 0
        }
    },
    loc_txt = {
        ['name'] = 'Sailor',
        ['text'] = {
            [1] = 'Played {C:attention}Gold{} Cards',
            [2] = 'add {C:blue}20{} Chips when scored',
            [3] = '(Currently {C:blue}#1#{} Chips)'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 4,
        y = 3
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.goldchips}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                chips = card.ability.extra.goldchips
            }
        end
        if context.individual and context.cardarea == G.play  then
            if SMODS.get_enhancements(context.other_card)["m_gold"] == true then
                card.ability.extra.goldchips = (card.ability.extra.goldchips) + 20
                return {
                    message = "+20 Chips"
                }
            end
        end
    end
}