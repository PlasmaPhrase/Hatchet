SMODS.Joker{ --Needle Nonsense
    key = "needlenonsense",
    config = {
        extra = {
            dollarvar = 0,
            n = 0,
            start_dissolve = 0
        }
    },
    loc_txt = {
        ['name'] = 'Needle Nonsense',
        ['text'] = {
            [1] = 'Create a {C:spectral}Spectral{} when {C:attention}Blind {}is defeated',
            [2] = '{C:red}Self destructs{} if your winning hand is',
            [3] = 'not your {C:attention}first  hand{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 1
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
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["hatchet_hatchet_jokers"] = true },

    
    calculate = function(self, card, context)
    if context.end_of_round and context.game_over == false and context.main_eval  then
        return {
            func = function()
                
                for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
                    G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        play_sound('timpani')
                        SMODS.add_card({ set = 'Spectral', })                            
                        card:juice_up(0.3, 0.5)
                        return true
                        end
                    }))
                end
                delay(0.6)
                
                if created_consumable then
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral})
                end
                return true
                end
            }
        end
        if context.cardarea == G.jokers and context.joker_main  then
            if not (G.GAME.current_round.hands_played == 0) then
                return {
                    func = function()
                        card:start_dissolve()
                        return true
                        end
                    }
                end
            end
        end
}