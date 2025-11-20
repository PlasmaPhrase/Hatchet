
SMODS.Joker{ --Graveyard Shift
    key = "graveyardshift",
    config = {
        extra = {
            discards = 0
        }
    },
    loc_txt = {
        ['name'] = 'Graveyard Shift',
        ['text'] = {
            [1] = 'Gain {C:red}+1{} Mult per {C:attention}discarded{} card.',
            [2] = 'On the {C:attention}final hand{} of the round, apply',
            [3] = 'the total Mult. Resets per {C:attention}round{}',
            [4] = '{C:inactive}(Currently{} {C:red}#1#{}{C:inactive} Mult){}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 9,
        y = 3
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["hatch_hatchet_jokers"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.discards}}
    end,
    
    calculate = function(self, card, context)
        if context.discard  then
            return {
                func = function()
                    card.ability.extra.discards = (card.ability.extra.discards) + 1
                    return true
                end,
                message = "+1"
            }
        end
        if context.cardarea == G.jokers and context.joker_main  then
            if to_big(G.GAME.current_round.hands_left) == to_big(1) then
                return {
                    mult = card.ability.extra.discards
                }
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval  then
            return {
                func = function()
                    card.ability.extra.discards = 1
                    return true
                end,
                message = "Resets!"
            }
        end
    end
}