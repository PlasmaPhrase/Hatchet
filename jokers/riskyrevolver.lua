SMODS.Joker{ --Risky Revolver
    key = "riskyrevolver",
    config = {
        extra = {
            odds = 6,
            Xmult = 4,
            no = 0,
            var1 = 0
        }
    },
    loc_txt = {
        ['name'] = 'Risky Revolver',
        ['text'] = {
            [1] = '{C:green}1 in 6 chance{} to give {X:red,C:white}X4{} Mult',
            [2] = '{C:green}1 in 6 chance{} to destroy a random Joker{}',
            [3] = '{C:green}4 in 6 chance{} to do nothing'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 2
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
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["hatchet_hatchet_jokers"] = true },

    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_c0e78a1c', 1, card.ability.extra.odds, 'j_hatchet_riskyrevolver', false) then
                    local destructable_jokers = {}
                    for i, joker in ipairs(G.jokers.cards) do
                        if joker ~= card and not SMODS.is_eternal(joker) and not joker.getting_sliced then
                            table.insert(destructable_jokers, joker)
                        end
                    end
                    local target_joker = #destructable_jokers > 0 and pseudorandom_element(destructable_jokers, pseudoseed('destroy_joker')) or nil
                    
                    if target_joker then
                        target_joker.getting_sliced = true
                        G.E_MANAGER:add_event(Event({
                        func = function()
                            target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                            return true
                            end
                        }))
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Shot!", colour = G.C.RED})
                    end
                    
                end
                if SMODS.pseudorandom_probability(card, 'group_1_a9c87948', 1, card.ability.extra.odds, 'j_hatchet_riskyrevolver', false) then
                        SMODS.calculate_effect({Xmult = card.ability.extra.Xmult}, card)
                    end
                end
            end
        end
}