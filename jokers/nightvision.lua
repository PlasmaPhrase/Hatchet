SMODS.Joker{ --Night Vision
    key = "nightvision",
    config = {
        extra = {
            nightrounds = 0,
            respect = 0,
            start_dissolve = 0,
            y = 0
        }
    },
    loc_txt = {
        ['name'] = 'Night Vision',
        ['text'] = {
            [1] = 'Creates a {C:dark_edition}Negative{} of a',
            [2] = 'random Joker every {C:attention}round{}',
            [3] = '{C:red}Self-destructs after 3 rounds{}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 8,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.setting_blind  then
            if (card.ability.extra.nightrounds or 0) >= 3 then
                return {
                    func = function()
                card:start_dissolve()
                return true
            end,
                    message = "Destroyed!"
                }
            else
                return {
                    func = function()
                local available_jokers = {}
                for i, joker in ipairs(G.jokers.cards) do
                    table.insert(available_jokers, joker)
                end
                local target_joker = #available_jokers > 0 and pseudorandom_element(available_jokers, pseudoseed('copy_joker')) or nil
                
                if target_joker then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local copied_joker = copy_card(target_joker, nil, nil, nil, target_joker.edition and target_joker.edition.negative)
                        copied_joker:set_edition("e_negative", true)
                            
                            copied_joker:add_to_deck()
                            G.jokers:emplace(copied_joker)
                            return true
                        end
                    }))
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_duplicated_ex'), colour = G.C.GREEN})
                end
                    return true
                end,
                    extra = {
                        func = function()
                    card.ability.extra.nightrounds = (card.ability.extra.nightrounds) + 1
                    return true
                end,
                        colour = G.C.GREEN
                        }
                }
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval  then
                return {
                    message = "-1 Round"
                }
        end
    end
}