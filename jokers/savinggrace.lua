
SMODS.Joker{ --Saving Grace
    key = "savinggrace",
    config = {
        extra = {
            levels = 2,
            start_dissolve = 0,
            n = 0,
            no = 0,
            var1 = 0
        }
    },
    loc_txt = {
        ['name'] = 'Saving Grace',
        ['text'] = {
            [1] = 'Upgrade level of',
            [2] = 'played poker hand by 2',
            [3] = 'in {C:attention}final hand{} of the round',
            [4] = '{C:red}Self destructs{}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 5,
        y = 0
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
    
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers  then
            if to_big(G.GAME.current_round.hands_left) == to_big(1) then
                local target_hand = (context.scoring_name or "High Card")
                level_up_hand(card, target_hand, true, card.ability.extra.levels)
                return {
                    message = localize('k_level_up_ex'),
                    extra = {
                        func = function()
                            local target_joker = card
                            
                            if target_joker then
                                target_joker.getting_sliced = true
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                                        return true
                                    end
                                }))
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Destroyed!", colour = G.C.RED})
                            end
                            return true
                        end,
                        colour = G.C.RED
                    }
                }
            end
        end
    end
}