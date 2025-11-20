
SMODS.Consumable {
    key = 'malkuth',
    set = 'sephirot',
    pos = { x = 9, y = 0 },
    loc_txt = {
        name = 'Malkuth',
        text = {
            [1] = 'Create a {C:uncommon}Kether{} card',
            [2] = '{C:inactive}(must have room){}'
        }
    },
    cost = 1,
    unlocked = false,
    discovered = false,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',
    use = function(self, card, area, copier)
        local used_card = copier or card
        for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    
                    play_sound('timpani')
                    SMODS.add_card({ set = 'sephirot', key = 'c_hatchet_kether'})                            
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
        end
        delay(0.6)
        
        if created_consumable then
            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_consumable'), colour = G.C.PURPLE})
        end
        return true
    end,
    can_use = function(self, card)
        return true
    end
}