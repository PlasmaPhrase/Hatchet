
SMODS.Joker{ --Swindler
    key = "swindler",
    config = {
        extra = {
            mult = 20,
            dollars = 20
        }
    },
    loc_txt = {
        ['name'] = 'Swindler',
        ['text'] = {
            [1] = '{C:red}+20{} Mult',
            [2] = '{C:money}-$20{} {C:attention}sell value{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 3
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["hatch_hatchet_jokers"] = true },
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.selling_self  then
            return {
                
                func = function()
                    
                    local current_dollars = G.GAME.dollars
                    local target_dollars = G.GAME.dollars - card.ability.extra.dollars
                    local dollar_value = target_dollars - current_dollars
                    ease_dollars(dollar_value)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "-"..tostring(card.ability.extra.dollars), colour = G.C.MONEY})
                    return true
                end
            }
        end
    end
}