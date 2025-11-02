SMODS.Joker{ --Green Card
    key = "greencard",
    config = {
        extra = {
            multvar = 0,
            n = 0
        }
    },
    loc_txt = {
        ['name'] = 'Green Card',
        ['text'] = {
            [1] = 'This Joker creates a {C:green}Sephirot Card{}',
            [2] = 'when any probability is {C:attention}successful{}',
            [3] = '{C:inactive}(Must have room){}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 6,
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
    discovered = true,
    atlas = 'CustomJokers',

    
    calculate = function(self, card, context)
        if context.pseudorandom_result  then
            if context.result then
                return {
                    func = function()
                        
                        for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
                            G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.4,
                            func = function()
                                play_sound('timpani')
                                SMODS.add_card({ set = 'sephirot', })                            
                                card:juice_up(0.3, 0.5)
                                return true
                                end
                            }))
                        end
                        delay(0.6)
                        
                        if created_consumable then
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_consumable'), colour = G.C.PURPLE})
                        end
                        return true
                        end
                    }
                end
            end
        end
}