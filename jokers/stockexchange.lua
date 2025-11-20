
SMODS.Joker{ --Stock Exchange
    key = "stockexchange",
    config = {
        extra = {
            handsremaining = 0,
            Xmult = 0.5
        }
    },
    loc_txt = {
        ['name'] = 'Stock Exchange',
        ['text'] = {
            [1] = 'Earn {C:money}$5{} for each',
            [2] = 'remaining {C:attention}discard{}',
            [3] = '{X:red,C:white}X0.5{} Mult per hand',
            [4] = ''
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["hatch_hatchet_jokers"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {((G.GAME.current_round.hands_left or 0)) * 5}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval  then
            return {
                
                func = function()
                    
                    local current_dollars = G.GAME.dollars
                    local target_dollars = G.GAME.dollars + (G.GAME.current_round.hands_left) * 5
                    local dollar_value = target_dollars - current_dollars
                    ease_dollars(dollar_value)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring((G.GAME.current_round.hands_left) * 5), colour = G.C.MONEY})
                    return true
                end
            }
        end
    end
}