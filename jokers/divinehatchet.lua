
SMODS.Joker{ --Divine Hatchet
    key = "divinehatchet",
    config = {
        extra = {
            divine = 0,
            Xmult = 4,
            n = 0,
            no = 0,
            var1 = 0,
            start_dissolve = 0,
            ignore = 0
        }
    },
    loc_txt = {
        ['name'] = 'Divine Hatchet',
        ['text'] = {
            [1] = '{X:red,C:white}X4{} Mult per {C:attention}played hand{}',
            [2] = 'then destroy scored cards',
            [3] = '{C:inactive}(Used #1# of 5 times){}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 7,
        y = 4
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 10,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    soul_pos = {
        x = 8,
        y = 4
    },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.divine}}
    end,
    
    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card.should_destroy  then
            return { remove = true }
        end
        if context.individual and context.cardarea == G.play  then
            context.other_card.should_destroy = false
            if to_big(#context.full_hand) >= to_big(1) then
                context.other_card.should_destroy = true
                return {
                    message = "Destroyed!"
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval  then
            if to_big((card.ability.extra.divine or 0)) >= to_big(5) then
                return {
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
                    extra = {
                        func = function()
                            
                            local created_joker = false
                            if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                                created_joker = true
                                G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_hatch_hatchet' })
                                        if joker_card then
                                            
                                            
                                        end
                                        G.GAME.joker_buffer = 0
                                        return true
                                    end
                                }))
                            end
                            if created_joker then
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_joker'), colour = G.C.BLUE})
                            end
                            return true
                        end,
                        colour = G.C.BLUE
                    }
                }
            else
                return {
                    func = function()
                        card.ability.extra.divine = (card.ability.extra.divine) + 1
                        return true
                    end,
                    message = "Used #1# times!"
                }
            end
        end
    end
}