
SMODS.Joker{ --Composter
    key = "composter",
    config = {
        extra = {
            handsleft = 0,
            cardsremovedfromdeck = 0
        }
    },
    loc_txt = {
        ['name'] = 'Composter',
        ['text'] = {
            [1] = 'Gain {C:money}$1{} per card {C:attention}destroyed{}',
            [2] = 'at the end of round'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
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
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.handsleft, ((G.GAME.starting_deck_size - #(G.playing_cards or {})) or 0)}}
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  then
            return {
                
                func = function()
                    
                    local current_dollars = G.GAME.dollars
                    local target_dollars = G.GAME.dollars + (G.GAME.starting_deck_size - #(G.playing_cards or {}))
                    local dollar_value = target_dollars - current_dollars
                    ease_dollars(dollar_value)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring((G.GAME.starting_deck_size - #(G.playing_cards or {}))), colour = G.C.MONEY})
                    return true
                end
            }
        end
    end
}