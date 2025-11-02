SMODS.Joker{ --Blue Card
    key = "bluecard",
    config = {
        extra = {
            chipsvar = 0
        }
    },
    loc_txt = {
        ['name'] = 'Blue Card',
        ['text'] = {
            [1] = 'This Joker gains {C:chips}+10{} Chips when any {C:orange}Booster Pack{} is skipped',
            [2] = '{C:inactive}(Currently{} {C:blue}+#1#{} {C:inactive}Chips){}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 6,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.chipsvar}}
    end,

    
    calculate = function(self, card, context)
        if context.skipping_booster  and not context.blueprint then
            return {
                func = function()
                    card.ability.extra.chipsvar = (card.ability.extra.chipsvar) + 10
                    return true
                    end,
                    message = "+10"
                }
            end
            if context.cardarea == G.jokers and context.joker_main  then
                return {
                    chips = card.ability.extra.chipsvar
                }
            end
        end
}