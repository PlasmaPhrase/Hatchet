SMODS.Joker{ --Interstice
    key = "interstice",
    config = {
        extra = {
            yes = 0,
            var1 = 0,
            start_dissolve = 0,
            n = 0
        }
    },
    loc_txt = {
        ['name'] = 'Interstice',
        ['text'] = {
            [1] = 'Prevents Death if Chips scored',
            [2] = 'are at least {C:attention}50%{} of required Chips',
            [3] = '{C:red}Destroys{} a random Joker',
            [4] = '{C:inactive}(bypasses Eternal){}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 2,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over and context.main_eval  and not context.blueprint then
            if G.GAME.chips / G.GAME.blind.chips >= to_big(0.5) then
                return {
                    saved = "Saved by Interstice",
                    message = localize('k_saved_ex'),
                    extra = {
                        func = function()
                local destructable_jokers = {}
                for i, joker in ipairs(G.jokers.cards) do
                    if joker ~= card and not joker.getting_sliced then
                        table.insert(destructable_jokers, joker)
                    end
                end
                local target_joker = #destructable_jokers > 0 and pseudorandom_element(destructable_jokers, pseudoseed('destroy_joker')) or nil
                
                if target_joker then
                    if target_joker.ability.eternal then
                        target_joker.ability.eternal = nil
                    end
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
            elseif G.GAME.chips / G.GAME.blind.chips >= to_big(0.5) then
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