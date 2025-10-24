SMODS.Joker{ --Black Joker
    key = "blackjoker",
    config = {
        extra = {
            hands = 1,
            respect = 0,
            permanent = 0
        }
    },
    loc_txt = {
        ['name'] = 'Black Joker',
        ['text'] = {
            [1] = 'When this card is sold',
            [2] = 'Add {C:enhanced}Negative {}to a random {C:attention}Joker.{}',
            [3] = '{C:blue}-1{} hand per round'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["hatchet_hatchet_jokers"] = true },
    in_pool = function(self, args)
          return (
          not args 
          or args.source ~= 'jud' 
          or args.source == 'sho' or args.source == 'buf' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
          )
          and true
      end,

    
    calculate = function(self, card, context)
        if context.selling_self  then
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
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "-"..tostring(card.ability.extra.hands).." Hand", colour = G.C.RED})
                        
                        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
                        ease_hands_played(-card.ability.extra.hands)
                        
                        return true
                        end,
                        colour = G.C.GREEN
                    }
                }
            end
        end
}