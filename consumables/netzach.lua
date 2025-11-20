
SMODS.Consumable {
    key = 'netzach',
    set = 'sephirot',
    pos = { x = 6, y = 0 },
    loc_txt = {
        name = 'Netzach',
        text = {
            [1] = 'Creates up to {C:attention}2{} random {C:spectral}Spectral{} cards',
            [2] = '{C:inactive}(Must have room){}'
        }
    },
    cost = 3,
    unlocked = false,
    discovered = false,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',
    use = function(self, card, area, copier)
        local used_card = copier or card
        for i = 1, math.min(2, G.consumeables.config.card_limit - #G.consumeables.cards) do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    
                    play_sound('timpani')
                    SMODS.add_card({ set = 'Spectral', })                            
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
        end
        delay(0.6)
        
        if created_consumable then
            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral})
        end
        return true
    end,
    can_use = function(self, card)
        return true
    end
}