SMODS.Joker{ --Earthquake
    key = "earthquake",
    config = {
        extra = {
            multvar = 0
        }
    },
    loc_txt = {
        ['name'] = 'Earthquake',
        ['text'] = {
            [1] = 'Gains {C:red}+2{} Mult every',
            [2] = 'time a card is destroyed',
            [3] = '(Currently {C:red}#1#{} Mult)'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 8,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.multvar}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    mult = card.ability.extra.multvar
                }
        end
        if context.remove_playing_cards  and not context.blueprint then
                return {
                    func = function()
                    card.ability.extra.multvar = (card.ability.extra.multvar) + 2 * #context.removed
                    return true
                end,
                }
        end
    end
}