-- Hatchet
SMODS.Joker {
    key = "hatchet",
    config = { extra = { xmult = 2.5 } },
    pos = { x = 0, y = 0 },
    cost = 9,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.hands_played == 0 then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        if context.after and G.GAME.current_round.hands_played == 0 then
            SMODS.destroy_cards(context.full_hand, nil, nil, true)
            return {
                message = "Felled!",
                colour = G.C.RED,
            }
        end
    end,
}

-- Handout
SMODS.Joker {
    key = "handout",
    config = { extra = { dollars = 1 } },
    pos = { x = 1, y = 0 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,

    calc_dollar_bonus = function(self, card)
        return card.ability.extra.dollars * G.GAME.current_round.discards_left
    end
}

-- Blue Shoes
SMODS.Joker {
    key = "blueshoes",
    config = { extra = { chips = 200, chips_sub = 50, } },
    pos = { x = 2, y = 0 },
    cost = 9,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chips_sub } }
    end,

    calculate = function(self, card, context)
        if context.poker_hand_changed == true then
            if card.ability.extra.chips - card.ability.extra.chips_sub <= 0 then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize('k_extinct_ex'),
                    colour = G.C.CHIPS
                }
            else
                card.ability.extra.chips = card.ability.extra.chips - card.ability.extra.chips_sub
                return {
                    message = localize { type = 'variable', key = 'a_chips_minus', vars = { card.ability.extra.chips_sub } },
                    colour = G.C.CHIPS
                }
            end
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}

-- Earthquake
SMODS.Joker {
    key = "earthquake",
    config = { extra = { chips = 0, chip_mod = 25 } },
    pos = { x = 3, y = 0 },
    cost = 7,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chip_mod } }
    end,

    calculate = function(self, card, context)
        if context.remove_playing_cards then
            card.ability.extra.chips = card.ability.extra.chips + (card.ability.extra.chip_mod * #context.removed)
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS,
            }
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}

-- Proud Joker
SMODS.Joker {
    key = "proudjoker",
    config = { extra = { mult = 4 } },
    pos = { x = 4, y = 0 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card, 'm_stone') then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}

-- Saving Grace
SMODS.Joker {
    key = "savinggrace",
    config = { extra = { levels = 2, } },
    pos = { x = 5, y = 0 },
    cost = 9,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.levels } }
    end,

    calculate = function(self, card, context)
        if context.before and G.GAME.current_round.hands_left == 0 then
            SMODS.destroy_cards(card, nil, nil, true)
            return {
                level_up = card.ability.extra.levels,
                message = localize('k_level_up_ex')
            }
        end
    end
}

-- Super Sevens
SMODS.Joker {
    key = "supersevens",
    pos = { x = 6, y = 0 },
    cost = 5,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_hatch_mercury
    end,

    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local sevens = 0
            for _, scored_card in ipairs(context.scoring_hand) do
                if scored_card:get_id() == 7 then
                    sevens = sevens + 1
                    scored_card:set_ability('m_hatch_mercury', nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:juice_up()
                            return true
                        end
                    }))
                end
            end
            if sevens > 0 then
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.BLUE
                }
            end
        end
    end
}

-- Seven Sisters
SMODS.Joker {
    key = "sevensisters",
    pos = { x = 7, y = 0 },
    config = { extra = { xmult = 3.5 } },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,

    -- Code by Somethingcom515
    calculate = function(self, card, context)
        if context.joker_main then
            local passed = true
            for k, v in pairs(context.full_hand) do
                if v:get_id() ~= 7 then -- if even one card is NOT 7, its false. ~= is the lua equivalent of !=
                    passed = false      -- the local "passed" variable is set to false
                end
            end
            if passed then
                return { xmult = card.ability.extra.xmult }
            end
        end
    end
}

--[[

k = *key*
v = value

the code above runs a loop for each corresponding key within the table.
everything within a table (whether its cards, blinds, etc) is assigned a key.

everytime the loop runs in the code, [k] is the index within the context (your full hand) while [v] is the card object
itself. think of [k] as a search string and [v] as the card object. your loop is checking each card's ID. if even one of them
ISNT a 7, the code will not run, hence why its set to false

credit to Somethingcom515, Meta and notmario for teaching me!

--]]

-- Diary Entry
SMODS.Joker {
    key = "diaryentry",
    config = { extra = { chips = 50, } },
    pos = { x = 8, y = 0 },
    cost = 7,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,

    calculate = function(self, card, context)
        if context.other_joker and (context.other_joker.config.center.rarity == 1 or context.other_joker.config.center.rarity == "Common") then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}

-- Black Joker (Ownerships) / Code by Somethingcom515 + LilyFelli
local oldweight = G.P_CENTERS.e_negative.get_weight
SMODS.Edition:take_ownership('e_negative', {
    get_weight = function(self)
        local weight = oldweight(self)
        for k, v in pairs(SMODS.find_card('j_hatch_blackjoker')) do
            weight = weight * (20 ^ #SMODS.find_card("j_hatch_blackjoker"))
        end
        return weight
    end
}, true)

--[[

We are taking ownership of the game's negative rate!
The old weight is defined as a GAME variable. We are taking the base weight, then telling "Black Joker"
to apply its increased rate, which is 2.

--]]

-- Black Joker
SMODS.Joker {
    key = "blackjoker",
    config = { extra = { negative_rate = 20 } },
    pos = { x = 9, y = 0 },
    cost = 9,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
        return { vars = { card.ability.extra.negative_rate } }
    end,
}

-- Musketeer
SMODS.Joker {
    key = "musketeer",
    config = { extra = { dollars = 4, type = 'Three of a Kind' } },
    pos = { x = 0, y = 1 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars, localize(card.ability.extra.type, 'poker_hands') } }
    end,

    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands[card.ability.extra.type]) then
            return {
                dollars = card.ability.extra.dollars
            }
        end
    end
}

-- Old Photograph
SMODS.Joker {
    key = "oldphotograph",
    config = { extra = { xmult = 1.5, odds = 4, xmult2 = 3 } },
    pos = { x = 1, y = 1 },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds,
            'j_hatch_oldphotograph')
        return { vars = { card.ability.extra.xmult, numerator, denominator, card.ability.extra.xmult2 } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_face() then
            local is_first_face = false
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:is_face() then
                    is_first_face = context.scoring_hand[i] == context.other_card
                    break
                end
            end
            if is_first_face and SMODS.pseudorandom_probability(card, 'j_hatch_oldphotograph', 1, card.ability.extra.odds) then
                return {
                    xmult = card.ability.extra.xmult2
                }
            else
                if is_first_face then
                    return {
                        xmult = card.ability.extra.xmult
                    }
                end
            end
        end
    end
}

-- Interstice
SMODS.Joker {
    key = "interstice",
    config = { extra = {} },
    pos = { x = 2, y = 1 },
    cost = 7,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    calculate = function(self, card, context)
        if context.selling_self then
            G.GAME.blind.chips = G.GAME.blind.chips / 2
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        end
    end
}

-- Sewing Needle
SMODS.Joker {
    key = "sewingneedle",
    pos = { x = 3, y = 1 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.end_of_round and G.GAME.current_round.hands_played == 1
            and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = (function()
                    SMODS.add_card {
                        set = 'Spectral',
                        key_append = 'hatch_sewingneedle'
                    }
                    G.GAME.consumeable_buffer = 0
                    return true
                end)
            }))
            return {
                message = localize('k_plus_spectral'),
                colour = G.C.SECONDARY_SET.Spectral
            }
        else
            if context.cardarea == G.jokers and context.end_of_round and G.GAME.current_round.hands_played > 1 then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize('k_extinct_ex')
                }
            end
        end
    end
}

-- Tricky Joker
SMODS.Joker {
    key = "tricky",
    config = { extra = {} },
    pos = { x = 4, y = 1 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    calculate = function(self, card, context)
        if context.setting_blind then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.current_round.hands_left = G.GAME.round_resets.discards
                    SMODS.calculate_effect(
                        { message = localize { type = 'variable', key = 'a_hands', vars = { G.GAME.round_resets.discards } } },
                        context.blueprint_card or card)
                    return true
                end
            }))
            return nil, true -- This is for Joker retrigger purposes
        end
    end
}

-- Loss Leader
SMODS.Joker {
    key = "lossleader",
    config = { extra = { percent = 25 } },
    pos = { x = 5, y = 1 },
    cost = 5,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.percent } }
    end,

    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.discount_percent = card.ability.extra.percent
                for _, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.discount_percent = 0
                for _, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end
}

-- Azure Card
SMODS.Joker {
    key = "azurecard",
    config = { extra = { chips = 0, chip_mod = 50, reward = true } },
    pos = { x = 6, y = 1 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    -- credit to thunderedge
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chip_mod, card.ability.extra.reward } }
    end,

    calculate = function(self, card, context)
        if context.buying_card then
            card.ability.extra.reward = false
        end
        if context.ending_shop then
            if card.ability.extra.reward then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.CHIPS
                }
            end
            card.ability.extra.reward = true
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}

-- Dakimakura
SMODS.Joker {
    key = "dakimakura",
    config = { extra = {} },
    pos = { x = 7, y = 1 },
    cost = 5,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands["Flush"]) then
            for i = 1, #context.full_hand do
                local percent = 1.15 - (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
                local target = context.full_hand[i]
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        target:flip()
                        play_sound("card1", percent)
                        target:juice_up(0.3, 0.3)
                        return true
                    end,
                }))
            end
            for i = 1, #context.full_hand do
                local target = context.full_hand[i]
                G.E_MANAGER:add_event(Event({
                    func = function()
                        assert(SMODS.change_base(target, pseudorandom_element(SMODS.Suits, "edit_card_suit").key, nil))
                        return true
                    end,
                }))
            end
            for i = 1, #context.full_hand do
                local percent = 1.15 - (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
                local target = context.full_hand[i]
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        target:flip()
                        play_sound("card1", percent)
                        target:juice_up(0.3, 0.3)
                        return true
                    end,
                }))
            end
        end
    end,
}

-- Fortress
SMODS.Joker {
    key = "fortress",
    config = { extra = { xmult = 3 } },
    pos = { x = 8, y = 1 },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if context.first_hand_drawn and not context.blueprint then
            local eval = function() return G.GAME.current_round.discards_used == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
        if context.joker_main and G.GAME.current_round.discards_used == 0 then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}

-- D20
SMODS.Joker {
    key = "d20",
    config = { extra = { odds = 20, dollars = 1, luckdollars = 20 } },
    pos = { x = 9, y = 1 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_hatch_d20')
        return { vars = { numerator, denominator, card.ability.extra.dollars, card.ability.extra.luckdollars } }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'j_hatch_d20', 1, card.ability.extra.odds) then
                return {
                    dollars = card.ability.extra.luckdollars,
                }
            else
                return {
                    dollars = card.ability.extra.dollars
                }
            end
        end
    end
}

-- Risky Revolver
SMODS.Joker {
    key = "riskyrevolver",
    config = { extra = { xmult = 3, odds = 6 } },
    pos = { x = 0, y = 2 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds,
            'j_hatch_riskyrevolver')
        return { vars = { numerator, denominator, card.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if context.joker_main and SMODS.pseudorandom_probability(card, 'j_hatch_riskyrevolver', 1, card.ability.extra.odds) then
            local destructable_jokers = {}
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] ~= card and not SMODS.is_eternal(G.jokers.cards[i], card) and not G.jokers.cards[i].getting_sliced then
                    destructable_jokers[#destructable_jokers + 1] =
                        G.jokers.cards[i]
                end
            end
            local joker_to_destroy = pseudorandom_element(destructable_jokers, 'j_hatch_riskyrevolver')

            if joker_to_destroy then
                joker_to_destroy.getting_sliced = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        (context.blueprint_card or card):juice_up(0.8, 0.8)
                        joker_to_destroy:start_dissolve({ G.C.RED }, nil, 1.6)
                        return true
                    end
                }))
            end
        else
            if context.joker_main then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end
}
-- Sunset
SMODS.Joker {
    key = "sunset",
    config = { extra = { xchips = 2 } },
    pos = { x = 1, y = 2 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xchips } }
    end,

    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.hands_played == 0 then
            return {
                xchips = card.ability.extra.xchips
            }
        end
    end
}

-- Pizza
SMODS.Joker {
    key = "pizza",
    config = { extra = { chips = 300, chip_sub = 50 } },
    pos = { x = 2, y = 2 },
    cost = 5,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chip_sub } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
        if context.reroll_shop and card.ability.extra.chips - card.ability.extra.chip_sub <= 0 then
            SMODS.destroy_cards(card, nil, nil, true)
            return {
                message = localize('k_eaten_ex'),
                colour = G.C.CHIPS
            }
        else
            if context.reroll_shop then
                card.ability.extra.chips = card.ability.extra.chips - card.ability.extra.chip_sub
                return {
                    message = localize { type = 'variable', key = 'a_chips_minus', vars = { card.ability.extra.chip_sub } },
                    colour = G.C.CHIPS
                }
            end
        end
    end
}

-- Roulette
SMODS.Joker {
    key = "roulette",
    config = { extra = { dollars = 8 } },
    pos = { x = 3, y = 2 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        local suit = (G.GAME.current_round.vremade_roulette_card or {}).suit or 'Spades'
        return { vars = { card.ability.extra.dollars, localize(suit, 'suits_singular'), colours = { G.C.SUITS[suit] } } }
    end,

    calculate = function(self, card, context)
        if context.joker_main and not context.blueprint and next(context.poker_hands['Flush']) then
            local passed = true
            for k, v in pairs(context.full_hand) do
                if not v:is_suit(G.GAME.current_round.vremade_roulette_card.suit) then
                    passed = false
                end
            end
            if passed then
                return {
                    dollars = card.ability.extra.dollars,
                    delay = 0.45
                }
            end
        end
    end
}

-- Roulette Functions

local function reset_vremade_roulette_card()
    G.GAME.current_round.vremade_roulette_card = { suit = 'Spades' }
    local valid_roulette_cards = {}
    for _, playing_card in ipairs(G.playing_cards) do
        if not SMODS.has_no_suit(playing_card) then
            valid_roulette_cards[#valid_roulette_cards + 1] = playing_card
        end
    end
    local roulette_card = pseudorandom_element(valid_roulette_cards,
        'j_hatch_roulette' .. G.GAME.round_resets.ante)
    if roulette_card then
        G.GAME.current_round.vremade_roulette_card.suit = roulette_card.base.suit
    end
end

function SMODS.current_mod.reset_game_globals(run_start)
    reset_vremade_roulette_card()
end

-- Pickpocket
SMODS.Joker {
    key = "pickpocket",
    config = { extra = { xmult = 3, passed = false } },
    pos = { x = 4, y = 2 },
    cost = 7,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'tag_coupon', set = 'Tag' }
        return { vars = { localize { type = 'name_text', set = 'Tag', key = 'tag_coupon' } } }
    end,

    calculate = function(self, card, context)
        if context.selling_self then
            G.E_MANAGER:add_event(Event({
                func = (function()
                    add_tag({ key = 'tag_coupon' })
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end)
            }))
            return nil, true -- This is for Joker retrigger purposes
        end
    end,
}

-- Fireworks
SMODS.Joker {
    key = "fireworks",
    config = { extra = { xmult = 4, type = 'Straight', passed = false } },
    pos = { x = 5, y = 2 },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, localize(card.ability.extra.type, 'poker_hands') } }
    end,

    calculate = function(self, card, context)
        if context.pre_discard then
            local _, _, poker_hands = G.FUNCS.get_poker_hand_info(context.full_hand) -- Checks Poker Hands
            if next(poker_hands[card.ability.extra.type]) then                       -- Checks if it matches the Type
                card.ability.extra.passed = true                                     -- Passed becomes True
                return {
                    message = localize('k_active_ex'),                               -- Returns "Active!"
                    card:juice_up()
                }
            else
                card.ability.extra.passed = false  -- Passed becomes False
                return {
                    message = localize('k_reset'), -- Returns "Reset!"
                    card:juice_up()
                }
            end
        end
        if card.ability.extra.passed == true and context.joker_main then -- Joker Main will not trigger unless Passed is also true
            return {
                xmult = card.ability.extra.xmult
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.passed = false
            return {
                message = localize('k_reset'), -- Returns "Reset!"
                card:juice_up()
            }
        end
    end
}

-- Stock Exchange
SMODS.Joker {
    key = "stockexchange",
    config = { extra = { dollars = 5, size = 2 } },
    pos = { x = 6, y = 2 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars, card.ability.extra.size } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and #context.full_hand <= card.ability.extra.size then
            return {
                dollars = card.ability.extra.dollars
            }
        end
    end
}

-- Ace in the Hole
SMODS.Joker {
    key = "aceinthehole",
    config = { extra = { chips = 100 } },
    pos = { x = 7, y = 2 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card:get_id() == 14 then
            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.CHIPS
                }
            else
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
    end,
}

-- Witch
SMODS.Joker {
    key = "witch",
    config = { extra = { xmult = 1, xmult_gain = 0.2 } },
    pos = { x = 8, y = 2 },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_gain } }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if context.beat_boss and card.ability.extra.xmult > 1 then
                card.ability.extra.xmult = 1
                return {
                    message = localize('k_reset'),
                    colour = G.C.RED
                }
            end
            if not context.beat_boss then
                card.ability.extra.xmult = card.ability.extra.xmult +
                    (card.ability.extra.xmult_gain * G.GAME.current_round.hands_left)
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.RED

                }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}

-- Black Swan
SMODS.Joker {
    key = "blackswan",
    config = { extra = { suit = "Spades" } },
    pos = { x = 9, y = 2 },
    cost = 9,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
        return { vars = { card.ability.extra.suit } }
    end,

    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local spades = 0
            for _, scored_card in ipairs(context.scoring_hand) do
                if scored_card:is_suit(card.ability.extra.suit) then
                    spades = spades + 1
                    scored_card:set_ability('m_glass', nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:juice_up()
                            return true
                        end
                    }))
                end
            end
            if spades > 0 then
                return {
                    message = "Glass!",
                    colour = G.C.RED
                }
            end
        end
    end
}

-- Composter
SMODS.Joker {
    key = "composter",
    config = { extra = { dollars = 4 } },
    pos = { x = 0, y = 3 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,

    calculate = function(self, card, context)
        if context.remove_playing_cards then
            return {
                dollars = card.ability.extra.dollars * #context.removed
            }
        end
    end,
}

-- Nine Lives
SMODS.Joker {
    key = "ninelives",
    config = { extra = { mult = 9 } },
    pos = { x = 1, y = 3 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card:get_id() == 9 then
            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
            else
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end,
}

-- Swindler Localisations (Code by LasagnaFelidae and Somethingcom515)

local oldcardsetsellvalue = Card.set_sell_value
function Card:set_sell_value()
    g = oldcardsetsellvalue(self)
    if self.config.center.key == 'j_hatch_swindler' then
        self.sell_cost = -20
    end
    return g
end

-- Swindler
SMODS.Joker {
    key = "swindler",
    config = { extra = { mult = 20, price = 20 } },
    pos = { x = 2, y = 3 },
    cost = 5,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.price } }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

-- No Dice
SMODS.Joker {
    key = "nodice",
    config = { extra = { mult = 6 } },
    pos = { x = 3, y = 3 },
    cost = 5,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local id = context.other_card:get_id()
            if id == 2 or id == 3 or id == 4 or id == 5 or id == 6 or id == 14 then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
        if context.mod_probability then
            return {
                numerator = 0
            }
        end
    end
}

-- Sailor
SMODS.Joker {
    key = "sailor",
    config = { extra = { chips = 30 } },
    pos = { x = 4, y = 3 },
    cost = 5,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            SMODS.has_enhancement(context.other_card, 'm_gold') then
            return { chips = card.ability.extra.chips }
        end
    end
}

-- Snake Eyes
SMODS.Joker {
    key = "snakeeyes",
    config = { extra = { denominator = 2 } },
    pos = { x = 5, y = 3 },
    cost = 7,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.denominator } }
    end,

    calculate = function(self, card, context)
        if context.mod_probability and not context.blueprint then
            return {
                denominator = 2
            }
        end
    end,
}

-- Wheelbarrow
SMODS.Joker {
    key = "wheelbarrow",
    config = { extra = { odds = 7, xmult = 1, xmult_gain = 0.2 } },
    pos = { x = 6, y = 3 },
    cost = 7,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_hatch_wheelbarrow')
        return { vars = { numerator, denominator, card.ability.extra.xmult, card.ability.extra.xmult_gain } }
    end,

    calculate = function(self, card, context)
        if context.stay_flipped and context.to_area == G.hand and SMODS.pseudorandom_probability(card, 'j_hatch_wheelbarrow', 1, card.ability.extra.odds) then
            return {
                stay_flipped = true
            }
        end
        if context.press_play then -- quite literally pressing play
            for k, v in pairs(G.hand.highlighted) do
                if v.facing == 'back' then
                    v.hatchet_was_flipped = true
                end
            end
            --[[
            as mentioned in seven sisters, k = key and v = value.
            pairs runs all values in nonchronological order (e.g. 2,3,5,1) while ipairs runs them in chronological order
            --]]
        end
        if context.before then
            for k, v in pairs(context.scoring_hand) do
                if v.hatchet_was_flipped then
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = 'xmult',
                        scalar_value = 'xmult_gain',
                    })
                end
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        if context.after then
            for k, v in pairs(G.play.cards) do
                v.hatchet_was_flipped = nil
            end
        end
    end
}

-- Love Letter
SMODS.Joker {
    key = "loveletter",
    config = { extra = {} },
    pos = { x = 7, y = 3 },
    cost = 7,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    calculate = function(self, card, context)
        if context.before and #context.full_hand == 1 and G.GAME.current_round.hands_left == 0 then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    context.full_hand[1]:set_edition("e_polychrome", true)
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
        end
    end
}

-- Staircase
SMODS.Joker {
    key = "staircase",
    config = { extra = { odds = 4 } },
    pos = { x = 8, y = 3 },
    cost = 7,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_hatch_staircase')
        return { vars = { numerator, denominator } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            if ((context.other_card:is_face())) and SMODS.pseudorandom_probability(card, 'j_hatch_staircase', 1, card.ability.extra.odds) then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                return {
                    extra = {
                        message_card = card,
                        func = function() -- This is for timing purposes, everything here runs after the message
                            G.E_MANAGER:add_event(Event({
                                func = (function()
                                    SMODS.add_card({ set = 'hatch_sephirot' })
                                    G.GAME.consumeable_buffer = 0
                                    return true
                                end)
                            }))
                        end
                    },
                }
            end
        end
    end
}

-- Graveyard
SMODS.Joker {
    key = "graveyardshift",
    config = { extra = { xmult = 3, faces = 5, condition = false } },
    pos = { x = 9, y = 3 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.faces, card.ability.extra.condition } }
    end,

    calculate = function(self, card, context)
        if context.discard and context.other_card == context.full_hand[#context.full_hand] then
            local face_cards = 0
            for _, discarded_card in ipairs(context.full_hand) do
                if discarded_card:is_face() then face_cards = face_cards + 1 end
            end
            if face_cards >= card.ability.extra.faces then
                card.ability.extra.condition = true
                return { -- Doesn't work but it's necessary to make the condition true, for some reason????
                    message = localize('k_active_ex'),
                    colour = G.C.FILTER,
                    delay = 0.4
                }
            end
        end
        if context.joker_main and card.ability.extra.condition == true then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.condition = false
            return {
                message = localize('k_reset'),
                colour = G.C.FILTER,
                delay = 0.4
            }
        end
    end
}

-- Poison Ivy
SMODS.Joker {
    key = "poisonivy",
    config = { extra = { xmult = 1, xmult_gain = 0.2, odds = 4 } },
    pos = { x = 0, y = 4 },
    cost = 9,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_hatch_poisonivy')
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_gain, numerator, denominator } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        if context.individual and context.cardarea == G.play and SMODS.pseudorandom_probability(card, 'j_hatch_poisonivy', 1, card.ability.extra.odds) then
            local scored_card = context.other_card
            G.E_MANAGER:add_event(Event({ -- Juice Up Animation
                trigger = 'after',
                delay = 0.4,
                func = function()
                    SMODS.modify_rank(scored_card, -1)
                    scored_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain -- Mult Manipulation
            return {                                                                            -- Localisation
                message = localize('k_upgrade_ex'),
                colour = G.C.FILTER,
                delay = 0.4
            }
        end
    end
}

-- Air Missile
SMODS.Joker {
    key = "airmissile",
    config = { extra = { xmult = 1, xmult_gain = 0.2, odds = 4, levels = -1 } },
    pos = { x = 1, y = 4 },
    cost = 9,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_hatch_airmissile')
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_gain, numerator, denominator } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        if context.before and SMODS.pseudorandom_probability(card, 'j_hatch_airmissile', 1, card.ability.extra.odds) then
            if G.GAME.hands[context.scoring_name].level <= 1 then
                return {}
            else
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                return {
                    level_up = card.ability.extra.levels,
                    message = "Downgrade!"
                }
            end
        end
    end
}

-- Wildside
SMODS.Joker {
    key = "wildside",
    config = { extra = { repetitions = 1 } },
    pos = { x = 2, y = 4 },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if SMODS.get_enhancements(context.other_card)["m_wild"] == true then
                return {
                    repetitions = card.ability.extra.repetitions,
                    message = localize('k_again_ex')
                }
            end
        end
    end
}

-- Iron Cave
SMODS.Joker {
    key = "cave",
    config = { extra = { repetitions = 1 } },
    pos = { x = 3, y = 4 },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
    end,

    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local stones = 0
            for _, scored_card in ipairs(context.scoring_hand) do
                if SMODS.has_enhancement(scored_card, 'm_stone') then
                    stones = stones + 1
                    scored_card:set_ability('m_steel', nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:juice_up()
                            return true
                        end
                    }))
                end
            end
            if stones > 0 then
                return {
                    message = "Mined!",
                    colour = G.C.MULT
                }
            end
        end
    end
}

-- Giraffe
SMODS.Joker {
    key = "giraffe",
    config = { extra = { chips = 75, vouchers = 0 } },
    pos = { x = 4, y = 4 },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } } -- this joker currently lacks chip count localisation
    end,
    calculate = function(self, card, context)
        if context.buying_card and context.card.ability.set == "Voucher" then -- credit to N'
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS
            }
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips * #G.vouchers.cards
            }
        end
    end,
}

-- Four-Leaf Clover Localisations

local x_same_ref = get_X_same
function get_X_same(num, hand, or_more)
    if next(SMODS.find_card("j_hatch_fourleaf")) and num == 4 then
        num = 3
    end
    return x_same_ref(num, hand, or_more)
end

-- Four-Leaf Clover
SMODS.Joker {
    key = "fourleaf",
    config = { extra = { type = 'Three of a Kind' } },
    pos = { x = 5, y = 4 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',
}

-- Steel Ball
SMODS.Joker {
    key = "steelball",
    config = { extra = { mult_gain = 4, mult = 0 } },
    pos = { x = 6, y = 4 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_steel') then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.RED,
                message_card = card
            }
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
}

-- Fool's Gold
SMODS.Joker {
    key = "foolsgold",
    config = { extra = { odds = 4 } },
    pos = { x = 9, y = 8 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_hatch_foolsgold')
        return { vars = { numerator, denominator } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_gold') and
            #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            if SMODS.pseudorandom_probability(card, 'j_hatch_foolsgold', 1, card.ability.extra.odds) then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                return {
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card {
                                key = 'c_fool',
                            }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    })) }
            end
        end
    end
}

-- Hands Down
SMODS.Joker {
    key = "handsdown",
    config = { extra = { xmult = 0.5, h_size = 2 } },
    pos = { x = 7, y = 4 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.h_size } }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(card.ability.extra.h_size)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.h_size)
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
}

-- Defaced (Hook)
local oldcardgetid = Card.get_id
function Card:get_id()
    if next(SMODS.find_card('j_hatch_defaced')) and not SMODS.has_no_rank(self) and SMODS.Ranks[self.base.value].face then
        return 2
    end
    return oldcardgetid(self)
end

-- Credit to somethingcom515 for the hook.

-- Defaced
SMODS.Joker {
    key = "defaced",
    pos = { x = 8, y = 4 },
    cost = 5,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    calculate = function(self, card, context)
    end,

    add_to_deck = function(self, card, from_debuff)
    end,

    remove_from_deck = function(self, card, from_debuff)
    end
}

-- Topsy Turvy
SMODS.Joker {
    key = "topsyturvy",
    config = { extra = { odds = 4 } },
    pos = { x = 9, y = 4 },
    cost = 5,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_hatch_topsyturvy')
        return { vars = { numerator, denominator } }
    end,

    calculate = function(self, card, context)
        if context.joker_main and
            SMODS.pseudorandom_probability(card, 'j_hatch_topsyturvy', 1, card.ability.extra.odds) then
            return {
                swap = true,
                message = "Swapped!",
                colour = G.C.PURPLE
            }
        end
    end
}

-- Windmill
SMODS.Joker {
    key = "windmill",
    config = {
        extra = { chips = 50, repetitions = 1 } },
    pos = { x = 0, y = 5 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_hatch_mercury
        return { vars = { card.ability.extra.chips, card.ability.extra.repetitions } }
    end,

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and
            SMODS.has_enhancement(context.other_card, 'm_hatch_mercury') then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
    end,
}

-- Wild West
SMODS.Joker {
    key = "wildwest",
    config = {
        extra = { mult = 1 } },
    pos = { x = 1, y = 5 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
        return { vars = { card.ability.extra.mult } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            SMODS.has_enhancement(context.other_card, 'm_wild') then
            context.other_card.ability.perma_mult = (context.other_card.ability.perma_mult or 0) +
                card.ability.extra.mult
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.RED
            }
        end
    end
}

-- Lime Pie
SMODS.Joker {
    key = "limepie",
    config = { extra = { dollars = 8, discard_sub = 1 } },
    pos = { x = 2, y = 5 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars, card.ability.extra.discard_sub } }
    end,
    calculate = function(self, card, context)
        if
            context.discard
            and not context.blueprint
            and context.other_card == context.full_hand[#context.full_hand]
        then
            local prev_gold = card.ability.extra.dollars
            card.ability.extra.dollars = math.max(0, card.ability.extra.dollars - card.ability.extra.discard_sub)
            if card.ability.extra.dollars ~= prev_gold then
                return {
                    message = "-$1",
                    colour = G.C.YELLOW,
                }
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if card.ability.extra.dollars - card.ability.extra.discard_sub <= 0 then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize("k_eaten_ex"),
                    colour = G.C.RED,
                }
            end
        end
    end,
    calc_dollar_bonus = function(self, card)
        return card.ability.extra.dollars
    end,
}

-- Heart Transplant
SMODS.Joker({
    key = "hearttransplant",
    pos = { x = 3, y = 5 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "HatchetJokers",

    calculate = function(self, card, context)
        if context.joker_main and SMODS.seeing_double_check(context.scoring_hand, 'Hearts') then
            for i = 1, #context.full_hand do
                local percent = 1.15 - (i - 0.999) / (#context.full_hand - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        context.full_hand[i]:flip()
                        play_sound('card1', percent)
                        context.full_hand[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            local _suit = 'Hearts'
            for i = 1, #context.full_hand do
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local _card = context.full_hand[i]
                        assert(SMODS.change_base(_card, _suit))
                        return true
                    end
                }))
            end
            for i = 1, #context.full_hand do
                local percent = 0.85 + (i - 0.999) / (#context.full_hand - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        context.full_hand[i]:flip()
                        play_sound('tarot2', percent, 0.6)
                        context.full_hand[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.5)
        end
    end
})

-- Empty Crown
SMODS.Joker {
    key = "emptycrown",
    config = { extra = {} },
    pos = { x = 4, y = 5 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and
            #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            return {
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card {
                            key = 'c_hatch_kether',
                        }
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                })) }
        end
    end
}

-- Royal Guard
SMODS.Joker {
    key = "royalguard",
    config = { extra = { mult = 0 } },
    pos = { x = 5, y = 5 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        local face_tally = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if playing_card:is_face {} then face_tally = face_tally + 1 end
            end
        end
        return { vars = { card.ability.extra.mult, card.ability.extra.mult + face_tally } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local face_tally = 0
            for _, playing_card in ipairs(G.playing_cards) do
                if playing_card:is_face {} then face_tally = face_tally + 1 end
            end
            return {
                mult = card.ability.extra.mult + face_tally
            }
        end
    end
}

-- Meteorite
SMODS.Joker {
    key = "meteorite",
    config = { extra = {} },
    pos = { x = 6, y = 5 },
    cost = 5,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'tag_meteor', set = 'Tag' }
        return { vars = { localize { type = 'name_text', set = 'Tag', key = 'tag_meteor' } } }
    end,
    calculate = function(self, card, context)
        if context.selling_self then
            G.E_MANAGER:add_event(Event({
                func = (function()
                    add_tag(Tag('tag_meteor'))
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end)
            }))
            return nil, true -- This is for Joker retrigger purposes
        end
    end,
}

-- Panic Attack
SMODS.Joker({
    key = "panic",
    config = { extra = { mult = 0, mult_gain = 1, size = 5 } },
    pos = { x = 7, y = 5 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "HatchetJokers",

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain, card.ability.extra.size } }
    end,

    calculate = function(self, card, context)
        if context.joker_main and #context.full_hand == card.ability.extra.size then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
            return {
                mult = card.ability.extra.mult
            }
        else
            if context.joker_main and #context.full_hand <= card.ability.extra.size then
                return {
                    card.ability.extra.mult == 0,
                    message = localize('k_reset')
                }
            end
        end
    end
})

-- Astrophysicist
SMODS.Joker({
    key = "astrophysicist",
    config = { extra = { chips = 0 } },
    pos = { x = 8, y = 5 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "HatchetJokers",

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,

    calculate = function(self, card, context)
        if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == 'Planet' then
            card.ability.extra.chips = card.ability.extra.chips + 10
            return {
                message = "Upgrade!",
                colour = G.C.BLUE
            }
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
})

-- Science Lab
SMODS.Joker({
    key = "sciencelab",
    config = { extra = { chips = 0, chips_gain = 30 } },
    pos = { x = 9, y = 5 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "HatchetJokers",

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chips_gain } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round and SMODS.has_enhancement(context.other_card, 'm_hatch_mercury') then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
            return {
                message = "Upgrade!",
                colour = G.C.BLUE
            }
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
})

-- Bonus Round
SMODS.Joker {
    key = "bonusround",
    config = { extra = { dollars = 3 } },
    pos = { x = 0, y = 6 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_bonus') then
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
            return {
                dollars = card.ability.extra.dollars,
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.dollar_buffer = 0
                            return true
                        end
                    }))
                end
            }
        end
    end
}

-- Playground
SMODS.Joker({
    key = "playground",
    config = { extra = { tags = 1 } },
    pos = { x = 1, y = 6 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "HatchetJokers",

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.tags } }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.beat_boss then
            add_tag({ key = get_next_tag_key(self.key) })
        end
    end
})

-- Slippery Slope
SMODS.Joker({
    key = "slipperyslope",
    config = { extra = { mult = 0, dollars = 2, mult_gain = 4 } },
    pos = { x = 2, y = 6 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "HatchetJokers",

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.dollars, card.ability.extra.mult_gain } }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
            return {
                dollars = card.ability.extra.dollars * -1
            }
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
})

-- Textile Joker
SMODS.Joker {
    key = "textile",
    config = { extra = { mult = 0, mult_gain = 4 } },
    pos = { x = 3, y = 6 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.end_of_round and G.GAME.current_round.hands_played == 1 then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT,
            }
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

-- Abacus
SMODS.Joker({
    key = "abacus",
    config = { extra = { mult = 0, mult_gain = 1, mult_loss = 1 } },
    pos = { x = 4, y = 6 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "HatchetJokers",

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain, card.ability.extra.mult_loss } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 3 or
                context.other_card:get_id() == 5 or
                context.other_card:get_id() == 7 or
                context.other_card:get_id() == 9 then
                card.ability.extra.mult = math.max(0, card.ability.extra.mult - card.ability.extra.mult_loss)
                return {
                    message = localize { type = 'variable', key = 'a_mult_minus', vars = { card.ability.extra.mult_loss } },
                    colour = G.C.RED,
                    message_card = card
                }
            end
            if context.other_card:get_id() == 2 or
                context.other_card:get_id() == 4 or
                context.other_card:get_id() == 6 or
                context.other_card:get_id() == 8 then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                return {
                    message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult_gain } },
                    colour = G.C.RED,
                    message_card = card
                }
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
})

-- Medicine Cabinet
SMODS.Joker {
    key = "medicine",
    config = { extra = { xmult = 3, odds = 4 } },
    pos = { x = 5, y = 6 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_hatch_medicine')
        return { vars = { numerator, denominator, card.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if G.GAME.blind.boss and context.end_of_round and context.main_eval then
            if SMODS.pseudorandom_probability(card, 'j_hatch_medicine', 1, card.ability.extra.odds) then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize('k_extinct_ex')
                }
            else
                return {
                    message = localize('k_safe_ex')
                }
            end
        end
        if context.joker_main then
            if G.GAME.blind.boss then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end
}

-- Burrito
SMODS.Joker({
    key = "burrito",
    config = { extra = { d_size = 7, d_size_sub = 1 } },
    pos = { x = 6, y = 6 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "HatchetJokers",

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.d_size, card.ability.extra.d_size_sub } }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false then
            if card.ability.extra.d_size <= 1 then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize('k_eaten_ex'),
                    colour = G.C.FILTER
                }
            else
                G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.d_size_sub
                card.ability.extra.d_size = card.ability.extra.d_size - card.ability.extra.d_size_sub
                return {
                    message = "-1 Discard",
                    colour = G.C.FILTER
                }
            end
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.d_size
        ease_discard(card.ability.extra.d_size)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.d_size
        ease_discard(-card.ability.extra.d_size)
    end
})

-- Cake Slice
SMODS.Joker({
    key = "cakeslice",
    config = { extra = { tags = 1, odds = 4 } },
    pos = { x = 7, y = 6 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "HatchetJokers",

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_hatch_cakeslice')
        return { vars = { numerator, denominator, card.ability.extra.tags } }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false then
            add_tag({ key = get_next_tag_key(self.key) })
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'j_hatch_cakeslice', 1, card.ability.extra.odds) then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize('k_extinct_ex')
                }
            else
                return {
                    message = localize('k_safe_ex')
                }
            end
        end
    end
})

-- Soured Milk
SMODS.Joker {
    key = "sourmilk",
    config = { extra = { dollar = 1, limit = 20 } },
    pos = { x = 8, y = 6 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollar, card.ability.extra.limit } }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false then
            if G.GAME.dollars <= -20 then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = "Soured!",
                    colour = G.C.FILTER
                }
            else
                return {
                    dollars = -card.ability.extra.dollar
                }
            end
        end
    end
}

-- Milkman
SMODS.Joker {
    key = "milkman",
    config = { extra = { xmult_gain = 0.2 } },
    pos = { x = 9, y = 6 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult_gain, 1 + (G.GAME.dollars < 0 and card.ability.extra.xmult_gain * -G.GAME.dollars or 0) } }
    end,

    -- Credit to N' + aure_
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = 1 + (G.GAME.dollars < 0 and card.ability.extra.xmult_gain * -G.GAME.dollars or 0)
            }
        end
    end
}

-- Ballad of Jimbo
SMODS.Joker({
    key = "ballad",
    pos = { x = 0, y = 7 },
    cost = 7,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "HatchetJokers",

    -- Credit to N'
    add_to_deck = function(self, card, context)
        G.GAME.modifiers.booster_size_mod = (G.GAME.modifiers.booster_size_mod or 0) + 1
    end,
})

-- Hearts and Minds
SMODS.Joker({
    key = "heartminds",
    config = { extra = { mult = 0, mult_mod = 4 } },
    pos = { x = 1, y = 7 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "HatchetJokers",

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_mod } }
    end,

    calculate = function(self, card, context)
        if context.before and not context.blueprint and next(context.poker_hands['Flush']) then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.RED,
            }
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.after then
            if next(context.poker_hands['Flush']) then
                SMODS.destroy_cards(context.full_hand, nil, nil, true)
                return {
                    message = "Destroyed!",
                    colour = G.C.RED,
                }
            end
        end
    end
})

-- Spoiled Ballot
SMODS.Joker({
    key = "spoiledballot",
    config = { extra = {} },
    pos = { x = 2, y = 7 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "HatchetJokers",

    calculate = function(self, card, context)
        if G.GAME.current_round.hands_played == 0 then
            if context.individual and context.cardarea == G.play and context.other_card == context.scoring_hand[1] then
                context.other_card:set_ability('m_hatch_salt', nil, true)
                return {
                    message = "Spoiled!",
                    colour = G.C.GREEN
                }
            end
        end
    end
})

-- Philosopher's Stone
SMODS.Joker({
    key = "philosopher",
    pos = { x = 3, y = 7 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "HatchetJokers",

    calculate = function(self, card, context)
        if context.joker_main then
            local elements = {
                ['Sulfur'] = 0,
                ['Mercury'] = 0,
                ['Salt'] = 0,
            }
            for i = 1, #context.scoring_hand do -- IF NOT
                if SMODS.has_enhancement(context.scoring_hand[i], 'm_hatch_sulfur') then
                    elements["Sulfur"] = elements["Sulfur"] + 1
                elseif SMODS.has_enhancement(context.scoring_hand[i], 'm_hatch_mercury') then
                    elements["Mercury"] = elements["Mercury"] + 1
                elseif SMODS.has_enhancement(context.scoring_hand[i], 'm_hatch_salt') then
                    elements["Salt"] = elements["Salt"] + 1
                end
            end
            for i = 1, #context.scoring_hand do -- IF YES
                if SMODS.has_enhancement(context.scoring_hand[i], 'm_hatch_sulfur') then
                    elements["Sulfur"] = elements["Sulfur"] + 1
                elseif SMODS.has_enhancement(context.scoring_hand[i], 'm_hatch_mercury') then
                    elements["Mercury"] = elements["Mercury"] + 1
                elseif SMODS.has_enhancement(context.scoring_hand[i], 'm_hatch_salt') then
                    elements["Salt"] = elements["Salt"] + 1
                end
            end
            if elements["Sulfur"] > 0 and
                elements["Mercury"] > 0 and
                elements["Salt"] > 0 then
                return {
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card {
                                set = 'hatch_divine',
                            }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                }
            end
        end
    end
})

-- Plea Deal
SMODS.Joker({
    key = "pleadeal",
    config = { extra = { d_size = 1, h_size = 1 } },
    pos = { x = 4, y = 7 },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "HatchetJokers",

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.d_size, card.ability.extra.h_size } }
    end,

    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(G.GAME.round_resets.discards)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-G.GAME.round_resets.discards)
    end,
})

-- Treasure Chest
SMODS.Joker({
    key = "treasure",
    config = { extra = { dollars = 5 } },
    pos = { x = 5, y = 7 },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "HatchetJokers",

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars, localize('Hearts', 'suits_plural'), localize('Diamonds', 'suits_plural') } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local all_red_suits = true
            for _, playing_card in ipairs(G.hand.cards) do
                if not playing_card:is_suit('Hearts', nil, true) and not playing_card:is_suit('Diamonds', nil, true) then
                    all_red_suits = false
                    break
                end
            end
            if all_red_suits then
                return {
                    dollars = card.ability.extra.dollars,
                }
            end
        end
    end
})

-- Tarot Ritual
SMODS.Joker({
    key = "ritual",
    config = { extra = { discards = 5, tarot = 1 } },
    pos = { x = 6, y = 7 },
    cost = 9,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "HatchetJokers",

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.discards, card.ability.extra.tarot } }
    end,

    calculate = function(self, card, context)
        if context.pre_discard and not context.blueprint and #context.full_hand == 5 then
            return {
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card {
                            set = 'Tarot',
                            edition = 'e_negative'
                        }
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                }))
            }
        end
    end
})

-- Room No. 202
SMODS.Joker {
    key = "room202",
    config = { extra = { h_size = 0, h_mod = 1 } },
    pos = { x = 7, y = 7 },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.h_size, localize('Full House', 'poker_hands', card.ability.extra.h_mod) } }
    end,

    calculate = function(self, card, context)
        if context.before and not context.blueprint and (next(context.poker_hands['Flush House']) or next(context.poker_hands['Full House'])) then
            -- See note about SMODS Scaling Manipulation on the wiki
            card.ability.extra.h_size = card.ability.extra.h_size + card.ability.extra.h_mod
            G.hand:change_size(card.ability.extra.h_mod)
            return {
                message = localize('k_upgrade_ex'),
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if context.beat_boss and card.ability.extra.h_size > 1 then
                G.hand:change_size(-card.ability.extra.h_size)
                card.ability.extra.h_size = 0
                return {
                    message = localize('k_reset'),
                }
            end
        end
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.h_size)
        card.ability.extra.h_size = 0
    end
}

-- Paper Plane
SMODS.Joker({
    key = "paperplane",
    config = { extra = { xmult = 1, xmult_mod = 0.2 } },
    pos = { x = 8, y = 7 },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "HatchetJokers",

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_mod, localize('High Card', 'poker_hands') } }
    end,

    calculate = function(self, card, context)
        if context.before and not context.blueprint and context.scoring_name == "High Card" then
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.RED,
            }
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        if context.before and not context.blueprint and not context.scoring_name ~= "High Card" then
            card.ability.extra.xmult = 1
            return {
                message = localize('k_reset'),
                colour = G.C.RED,
            }
        end
    end,
})

-- Negative Nancy
SMODS.Joker({
    key = "nancy",
    config = { extra = { nmult = 12 } },
    pos = { x = 9, y = 7 },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "HatchetJokers",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative

        local nega_tally = 0
        if G.jokers then
            for _, joker in ipairs(G.jokers and G.jokers.cards or {}) do
                if joker.edition and joker.edition.key == "e_negative" then nega_tally = nega_tally + 1 end
            end
        end
        return { vars = { card.ability.extra.nmult, card.ability.extra.nmult * nega_tally } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local nega_tally = 0
            for _, joker in ipairs(G.jokers and G.jokers.cards or {}) do
                if joker.edition and joker.edition.key == "e_negative" then nega_tally = nega_tally + 1 end
            end
            return {
                mult = card.ability.extra.nmult * nega_tally,
            }
        end

        in_pool = function(self, args)
            for _, joker in ipairs(G.jokers or {}) do
                if joker.edition and joker.edition.key == "e_negative" then
                    return true
                end
            end
            return false
        end
    end
})

-- Final Ace
SMODS.Joker {
    key = "finalace",
    config = { extra = { mult = 0, mult_mod = 11 } },
    pos = { x = 8, y = 8 },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_mod } }
    end,

    calculate = function(self, card, context)
        if context.destroy_card and not context.blueprint then
            if #context.full_hand == 1 and context.destroy_card == context.full_hand[1] and context.full_hand[1]:get_id() == 14 then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.RED,
                    remove = true
                }
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

-- Clock Tower
SMODS.Joker({
    key = "clocktower",
    config = { extra = { every = 11, threshold = 11 } },
    pos = { x = 0, y = 8 },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "HatchetJokers",

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.every + 1,
                localize { type = 'variable', key = (card.ability.extra.threshold == 0 and 'loyalty_active' or 'loyalty_inactive'), vars = { card.ability.extra.threshold } }
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            card.ability.extra.threshold = (card.ability.extra.every - 1 - (G.GAME.hands_played - card.ability.hands_played_at_create)) %
                (card.ability.extra.every + 1)
            if not context.blueprint then
                if card.ability.extra.threshold == 0 then
                    local eval = function(card) return card.ability.extra.threshold == 0 and not G.RESET_JIGGLES end
                    juice_card_until(card, eval, true)
                end
            end
            if card.ability.extra.threshold == card.ability.extra.every then
                return {
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card { set = 'hatch_divine', }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                }
            end
        end
    end
})

-- Demented Face
SMODS.Joker({
    key = "dementedface",
    config = { extra = { xmult = 1.5, odds = 4 } },
    pos = { x = 1, y = 8 },
    cost = 9,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "HatchetJokers",
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds,
            'j_hatch_dementedface')
        return { vars = { numerator, denominator, card.ability.extra.xmult } }
    end,

    -- credit to NopeTooFast and Meta and N' for help
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_face() and not context.other_card.getting_sliced then
            if SMODS.pseudorandom_probability(card, 'j_hatch_dementedface', 1, card.ability.extra.odds) then
                context.other_card.getting_sliced = true
            else
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
        if context.destroy_card and context.destroy_card.getting_sliced then
            return { remove = true }
        end
    end
})

-- Rabbit Foot
SMODS.Joker({
    key = "rabbitfoot",
    config = { extra = { repetitions = 2, odds = 2 } },
    pos = { x = 2, y = 8 },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "HatchetJokers",
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds,
            'j_hatch_rabbitfoot')
        return { vars = { numerator, denominator, card.ability.extra.repetitions } }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and context.other_card:get_id() == 2 then
            if SMODS.pseudorandom_probability(card, 'j_hatch_rabbitfoot', 1, card.ability.extra.odds) then
                return {
                    repetitions = card.ability.extra.repetitions
                }
            end
        end
    end
})

-- Cap and Bells
SMODS.Joker({
    key = "capbells",
    config = { extra = { booster = 1 } },
    pos = { x = 3, y = 8 },
    cost = 9,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "HatchetJokers",

    add_to_deck = function(self, card, from_debuff)
        SMODS.change_booster_limit(1)
    end,

    remove_from_deck = function(self, card, from_debuff)
        SMODS.change_booster_limit(-1)
    end,
})

-- Prion
SMODS.Joker({
    key = "prion",
    config = { extra = { odds = 4 } },
    pos = { x = 4, y = 8 },
    cost = 9,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "HatchetJokers",

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds,
            'j_hatch_prion')
        return { vars = { numerator, denominator } }
    end,

    calculate = function(self, card, context)
        if context.discard then
            if SMODS.pseudorandom_probability(card, 'j_hatch_prion', 1, card.ability.extra.odds) then
                return {
                    remove = true
                }
            end
        end
    end
})

-- Green Card
SMODS.Joker({
    key = "greencard",
    pos = { x = 5, y = 8 },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "HatchetJokers",

    -- Code by Meta, annotated by me!
    calculate = function(self, card, context)
        if context.skip_blind and not context.blueprint then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then -- check for consumable space
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({                                                            -- the event shouldnt be put in the return
                    func = function()
                        SMODS.add_card { set = "hatch_sephirot" }
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                }))
            end
        end
    end
})

-- Contract (Hooks)

local ease_ante_ref = ease_ante
function ease_ante(mod)
    local flags = SMODS.calculate_context({ modify_ante = mod, ante_end = SMODS.ante_end })
    if flags.modify then mod = flags.modify end
    ease_ante_ref(mod)
    SMODS.calculate_context({ ante_change = mod, ante_end = SMODS.ante_end })
end

-- Contract
SMODS.Joker({
    key = "contract",
    config = { extra = { deduction = 2 } },
    pos = { x = 6, y = 8 },
    cost = 9,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "HatchetJokers",

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.deduction } }
    end,

    calculate = function(self, card, context)
        if context.selling_self then
            ease_ante(-card.ability.extra.deduction)
            G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
            G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - card.ability.extra.deduction

            G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.deduction
            ease_hands_played(-card.ability.extra.deduction)
        end
    end
})

-- Fallen Tree
SMODS.Joker({
    key = "fallentree",
    config = { extra = { xmult = 3, xmult_loss = 0.2 } },
    loc_txt = {
        ["name"] = "Fallen Tree",
        ["text"] = {
            {
                "{C:white,X:mult}X#1#{} Mult",
                "Lose {C:white,X:mult}X#2#{} Mult",
                "per {C:attention}destroyed{} card"
            }
        },
    },
    pos = { x = 7, y = 8 },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "HatchetJokers",

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_loss } }
    end,

    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint then
            if card.ability.extra.xmult - card.ability.extra.xmult_loss <= 1 then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = "Destroyed!",
                    colour = G.C.FILTER
                }
            else
                card.ability.extra.xmult = card.ability.extra.xmult - (card.ability.extra.xmult_loss * #context.removed)
                return {
                    message = localize { type = 'variable', key = 'a_xmult_minus', vars = { card.ability.extra.xmult_loss } },
                    colour = G.C.RED,
                    delay = 0.2
                }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
})

-- Divine Mime
SMODS.Joker {
    key = "divine_mime",
    config = { extra = { repetitions = 2, energy = 5 } },
    pos = { x = 6, y = 10 },
    soul_pos = { x = 7, y = 10 },
    cost = 11,
    rarity = "hatch_evolved",
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xchips, card.ability.extra.energy } }
    end,

    calculate = function(self, card, context) -- Joker Effect
        if context.repetition and context.cardarea == G.hand and (next(context.card_effects[1]) or #context.card_effects > 1) then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then -- Devolution
            if card.ability.extra.energy <= 0 then
                G.E_MANAGER:add_event(Event({                                                                       -- Devolve Effect
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local evolution = card
                        play_sound('timpani')
                        card:set_ability("j_mime") -- The Original Joker
                        card:set_edition()         -- No edition
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                return { -- Devolve Message
                    message = "Reverted!",
                    colour = G.C.BLUE
                }
            else -- Losing Energy...
                card.ability.extra.energy = card.ability.extra.energy - 1
                return {
                    message = "Losing energy...",
                    colour = G.C.BLUE
                }
            end
        end
    end
}

-- Divine Banner
SMODS.Joker {
    key = "divine_banner",
    config = { extra = { xchips = 1.5, energy = 5 } },
    pos = { x = 4, y = 10 },
    soul_pos = { x = 5, y = 10 },
    cost = 11,
    rarity = "hatch_evolved",
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xchips, card.ability.extra.energy } }
    end,

    calculate = function(self, card, context) -- Joker Effect
        if context.joker_main then
            return {
                xchips = G.GAME.current_round.discards_left * card.ability.extra.xchips
            }
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then -- Devolution
            if card.ability.extra.energy <= 0 then
                G.E_MANAGER:add_event(Event({                                                                       -- Devolve Effect
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local evolution = card
                        play_sound('timpani')
                        card:set_ability("j_banner") -- The Original Joker
                        card:set_edition()           -- No edition
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                return { -- Devolve Message
                    message = "Reverted!",
                    colour = G.C.BLUE
                }
            else -- Losing Energy...
                card.ability.extra.energy = card.ability.extra.energy - 1
                return {
                    message = "Losing energy...",
                    colour = G.C.BLUE
                }
            end
        end
    end
}

-- Divine Summit
SMODS.Joker {
    key = "divine_summit",
    config = { extra = { xmult = 1.5, d_remaining = 0, energy = 5 } },
    pos = { x = 2, y = 12 },
    soul_pos = { x = 3, y = 12 },
    cost = 11,
    rarity = "hatch_evolved",
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.d_remaining, card.ability.extra.energy } }
    end,

    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.discards_left == card.ability.extra.d_remaining then
            return {
                xmult = card.ability.extra.xmult
            }
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then -- Devolution
            if card.ability.extra.energy <= 0 then
                G.E_MANAGER:add_event(Event({                                                                       -- Devolve Effect
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local evolution = card
                        play_sound('timpani')
                        card:set_ability("j_mystic_summit") -- The Original Joker
                        card:set_edition()                  -- No edition
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                return { -- Devolve Message
                    message = "Reverted!",
                    colour = G.C.BLUE
                }
            else -- Losing Energy...
                card.ability.extra.energy = card.ability.extra.energy - 1
                return {
                    message = "Losing energy...",
                    colour = G.C.BLUE
                }
            end
        end
    end
}

-- Divine 8-Ball
SMODS.Joker {
    key = "divine_8_ball",
    config = { extra = { energy = 5 } },
    pos = { x = 4, y = 12 },
    soul_pos = { x = 5, y = 12 },
    cost = 11,
    rarity = "hatch_evolved",
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.energy } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 8 then
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = (function()
                            SMODS.add_card {
                                set = 'Spectral',
                            }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end)
                    }))
                    return {
                        message = localize('k_plus_spectral'),
                        colour = G.C.SECONDARY_SET.Spectral,
                    }
                end
            end
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then -- Devolution
            if card.ability.extra.energy <= 0 then
                G.E_MANAGER:add_event(Event({                                                                       -- Devolve Effect
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local evolution = card
                        play_sound('timpani')
                        card:set_ability("j_8_ball") -- The Original Joker
                        card:set_edition()           -- No edition
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                return { -- Devolve Message
                    message = "Reverted!",
                    colour = G.C.BLUE
                }
            else -- Losing Energy...
                card.ability.extra.energy = card.ability.extra.energy - 1
                return {
                    message = "Losing energy...",
                    colour = G.C.BLUE
                }
            end
        end
    end
}

-- Divine Fist
SMODS.Joker {
    key = "divine_fist",
    config = { extra = { energy = 5 } },
    pos = { x = 8, y = 10 },
    soul_pos = { x = 9, y = 10 },
    cost = 11,
    rarity = "hatch_evolved",
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.energy } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            local temp_Mult, temp_ID = 15, 15
            local raised_card = nil
            for i = 1, #G.hand.cards do
                if temp_ID >= G.hand.cards[i].base.id and not SMODS.has_no_rank(G.hand.cards[i]) then
                    temp_Mult = G.hand.cards[i].base.nominal
                    temp_ID = G.hand.cards[i].base.id
                    raised_card = G.hand.cards[i]
                end
            end
            if raised_card == context.other_card then
                if context.other_card.debuff then
                    return {
                        message = localize('k_debuffed'),
                        colour = G.C.RED
                    }
                else
                    return {
                        xmult = 2 * temp_Mult
                    }
                end
            end
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then -- Devolution
            if card.ability.extra.energy <= 0 then
                G.E_MANAGER:add_event(Event({                                                                       -- Devolve Effect
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local evolution = card
                        play_sound('timpani')
                        card:set_ability("j_raised_fist") -- The Original Joker
                        card:set_edition()                -- No edition
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                return { -- Devolve Message
                    message = "Reverted!",
                    colour = G.C.BLUE
                }
            else -- Losing Energy...
                card.ability.extra.energy = card.ability.extra.energy - 1
                return {
                    message = "Losing energy...",
                    colour = G.C.BLUE
                }
            end
        end
    end

}

-- Divine Fibonacci
SMODS.Joker {
    key = "divine_fibonacci",
    config = { extra = { xmult = 1.5, energy = 5 } },
    pos = { x = 8, y = 12 },
    soul_pos = { x = 9, y = 12 },
    cost = 11,
    rarity = "hatch_evolved",
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.energy } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local id = context.other_card:get_id()
            if id == 2 or id == 3 or id == 5 or id == 8 or id == 14 then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then -- Devolution
            if card.ability.extra.energy <= 0 then
                G.E_MANAGER:add_event(Event({                                                                       -- Devolve Effect
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local evolution = card
                        play_sound('timpani')
                        card:set_ability("j_fibonacci") -- The Original Joker
                        card:set_edition()              -- No edition
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                return { -- Devolve Message
                    message = "Reverted!",
                    colour = G.C.BLUE
                }
            else -- Losing Energy...
                card.ability.extra.energy = card.ability.extra.energy - 1
                return {
                    message = "Losing energy...",
                    colour = G.C.BLUE
                }
            end
        end
    end
}

-- Divine Scholar
SMODS.Joker {
    key = "divine_scholar",
    config = { extra = { chips = 200, xmult = 4, odds = 2, energy = 5 } },
    pos = { x = 6, y = 12 },
    soul_pos = { x = 7, y = 12 },
    cost = 11,
    rarity = "hatch_evolved",
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds,
            'j_hatch_divine_scholar')
        return { vars = { numerator, denominator, card.ability.extra.chips, card.ability.extra.xmult, card.ability.extra.energy } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 14
            and SMODS.pseudorandom_probability(card, 'j_hatch_divine_scholar', 1, card.ability.extra.odds) then
            return {
                xmult = card.ability.extra.xmult
            }
        else
            if context.individual and context.cardarea == G.play and context.other_card:get_id() == 14 then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then -- Devolution
            if card.ability.extra.energy <= 0 then
                G.E_MANAGER:add_event(Event({                                                                       -- Devolve Effect
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local evolution = card
                        play_sound('timpani')
                        card:set_ability("j_scholar") -- The Original Joker
                        card:set_edition()            -- No edition
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                return { -- Devolve Message
                    message = "Reverted!",
                    colour = G.C.BLUE
                }
            else -- Losing Energy...
                card.ability.extra.energy = card.ability.extra.energy - 1
                return {
                    message = "Losing energy...",
                    colour = G.C.BLUE
                }
            end
        end
    end
}

-- Divine Space Joker
SMODS.Joker {
    key = "divine_space",
    config = { extra = { energy = 5 } },
    pos = { x = 0, y = 11 },
    soul_pos = { x = 1, y = 11 },
    cost = 11,
    rarity = "hatch_evolved",
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.energy } }
    end,

    calculate = function(self, card, context)
        if context.before then
            return {
                level_up = true,
                message = localize('k_level_up_ex')
            }
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then -- Devolution
            if card.ability.extra.energy <= 0 then
                G.E_MANAGER:add_event(Event({                                                                       -- Devolve Effect
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local evolution = card
                        play_sound('timpani')
                        card:set_ability("j_space") -- The Original Joker
                        card:set_edition()          -- No edition
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                return { -- Devolve Message
                    message = "Reverted!",
                    colour = G.C.BLUE
                }
            else -- Losing Energy...
                card.ability.extra.energy = card.ability.extra.energy - 1
                return {
                    message = "Losing energy...",
                    colour = G.C.BLUE
                }
            end
        end
    end
}

-- Divine Hiker
SMODS.Joker {
    key = "divine_hiker",
    config = { extra = { xchips = 0.5, energy = 5 } },
    pos = { x = 0, y = 13 },
    soul_pos = { x = 1, y = 13 },
    cost = 11,
    rarity = "hatch_evolved",
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xchips, card.ability.extra.energy } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            context.other_card.ability.perma_x_chips = (context.other_card.ability.perma_x_chips or 0) +
                card.ability.extra.xchips
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS
            }
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then -- Devolution
            if card.ability.extra.energy <= 0 then
                G.E_MANAGER:add_event(Event({                                                                       -- Devolve Effect
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local evolution = card
                        play_sound('timpani')
                        card:set_ability("j_hiker") -- The Original Joker
                        card:set_edition()          -- No edition
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                return { -- Devolve Message
                    message = "Reverted!",
                    colour = G.C.BLUE
                }
            else -- Losing Energy...
                card.ability.extra.energy = card.ability.extra.energy - 1
                return {
                    message = "Losing energy...",
                    colour = G.C.BLUE
                }
            end
        end
    end
}

-- Divine Riffraff
SMODS.Joker {
    key = "divine_riffraff",
    config = { extra = { creates = 2, energy = 5 } },
    pos = { x = 2, y = 13 },
    soul_pos = { x = 3, y = 13 },
    cost = 11,
    rarity = "hatch_evolved",
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.creates, card.ability.extra.energy } }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            local jokers_to_create = math.min(card.ability.extra.creates,
                G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
            G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
            G.E_MANAGER:add_event(Event({
                func = function()
                    for _ = 1, jokers_to_create do
                        SMODS.add_card {
                            set = 'Joker',
                            rarity = 'Rare',
                            key_append = 'hatch_riffraff'
                        }
                        G.GAME.joker_buffer = 0
                    end
                    return true
                end
            }))
            return {
                message = localize('k_plus_joker'),
                colour = G.C.RED,
            }
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then -- Devolution
            if card.ability.extra.energy <= 0 then
                G.E_MANAGER:add_event(Event({                                                                       -- Devolve Effect
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local evolution = card
                        play_sound('timpani')
                        card:set_ability("j_riff_raff") -- The Original Joker
                        card:set_edition()              -- No edition
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                return { -- Devolve Message
                    message = "Reverted!",
                    colour = G.C.BLUE
                }
            else -- Losing Energy...
                card.ability.extra.energy = card.ability.extra.energy - 1
                return {
                    message = "Losing energy...",
                    colour = G.C.BLUE
                }
            end
        end
    end
}

-- Divine Rebate
SMODS.Joker {
    key = "divine_mail",
    config = { extra = { dollars = 5, energy = 5 } },
    pos = { x = 8, y = 14 },
    soul_pos = { x = 9, y = 14 },
    cost = 11,
    rarity = "hatch_evolved",
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars, card.ability.extra.energy } }
    end,

    calculate = function(self, card, context)
        if context.discard and not context.blueprint then
            return {
                dollars = card.ability.extra.dollars,
                func = function() -- This is for timing purposes, it runs after the dollar manipulation
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.dollar_buffer = 0
                            return true
                        end
                    }))
                end
            }
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then -- Devolution
            if card.ability.extra.energy <= 0 then
                G.E_MANAGER:add_event(Event({                                                                       -- Devolve Effect
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local evolution = card
                        play_sound('timpani')
                        card:set_ability("j_mail") -- The Original Joker
                        card:set_edition()         -- No edition
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                return { -- Devolve Message
                    message = "Reverted!",
                    colour = G.C.BLUE
                }
            else -- Losing Energy...
                card.ability.extra.energy = card.ability.extra.energy - 1
                return {
                    message = "Losing energy...",
                    colour = G.C.BLUE
                }
            end
        end
    end
}

-- Divine Vagabond
SMODS.Joker {
    key = "divine_vagabond",
    config = { extra = { dollars = 4, energy = 5 } },
    pos = { x = 4, y = 13 },
    soul_pos = { x = 5, y = 13 },
    cost = 11,
    rarity = "hatch_evolved",
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars, card.ability.extra.energy } }
    end,

    calculate = function(self, card, context)
        if context.joker_main and
            #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            if G.GAME.dollars <= card.ability.extra.dollars then -- See note about Talisman compatibility on the wiki
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        SMODS.add_card {
                            set = 'hatch_divine',
                            key_append = 'vremade_vagabond' -- Optional, useful for manipulating the random seed and checking the source of the creation in `in_pool`.
                        }
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
                }))
            end
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then -- Devolution
            if card.ability.extra.energy <= 0 then
                G.E_MANAGER:add_event(Event({                                                                       -- Devolve Effect
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local evolution = card
                        play_sound('timpani')
                        card:set_ability("j_vagabond") -- The Original Joker
                        card:set_edition()             -- No edition
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                return { -- Devolve Message
                    message = "Reverted!",
                    colour = G.C.BLUE
                }
            else -- Losing Energy...
                card.ability.extra.energy = card.ability.extra.energy - 1
                return {
                    message = "Losing energy...",
                    colour = G.C.BLUE
                }
            end
        end
    end
}

-- Divine Baseball
SMODS.Joker {
    key = "divine_baseball",
    config = { extra = { xmult = 1.5, energy = 5 } },
    pos = { x = 6, y = 13 },
    soul_pos = { x = 7, y = 13 },
    cost = 11,
    rarity = "hatch_evolved",
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.energy } }
    end,

    calculate = function(self, card, context)
        if context.other_joker then
            return {
                xmult = card.ability.extra.xmult
            }
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then -- Devolution
            if card.ability.extra.energy <= 0 then
                G.E_MANAGER:add_event(Event({                                                                       -- Devolve Effect
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local evolution = card
                        play_sound('timpani')
                        card:set_ability("j_baseball") -- The Original Joker
                        card:set_edition()             -- No edition
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                return { -- Devolve Message
                    message = "Reverted!",
                    colour = G.C.BLUE
                }
            else -- Losing Energy...
                card.ability.extra.energy = card.ability.extra.energy - 1
                return {
                    message = "Losing energy...",
                    colour = G.C.BLUE
                }
            end
        end
    end
}

-- Divine Walkie Talkie
SMODS.Joker {
    key = "divine_walkie_talkie",
    config = { extra = { chips = 100, mult = 44, energy = 5 } },
    pos = { x = 4, y = 14 },
    soul_pos = { x = 5, y = 14 },
    cost = 11,
    rarity = "hatch_evolved",
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.energy } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            (context.other_card:get_id() == 10 or context.other_card:get_id() == 4) then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult
            }
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then -- Devolution
            if card.ability.extra.energy <= 0 then
                G.E_MANAGER:add_event(Event({                                                                       -- Devolve Effect
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local evolution = card
                        play_sound('timpani')
                        card:set_ability("j_walkie_talkie") -- The Original Joker
                        card:set_edition()                  -- No edition
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                return { -- Devolve Message
                    message = "Reverted!",
                    colour = G.C.BLUE
                }
            else -- Losing Energy...
                card.ability.extra.energy = card.ability.extra.energy - 1
                return {
                    message = "Losing energy...",
                    colour = G.C.BLUE
                }
            end
        end
    end
}

-- Divine Trousers
SMODS.Joker {
    key = "divine_trousers",
    config = { extra = { xmult = 1, xmult_mod = 0.5, dollars = 4, energy = 5 } },
    pos = { x = 2, y = 10 },
    soul_pos = { x = 3, y = 10 },
    cost = 11,
    rarity = "hatch_evolved",
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_mod, card.ability.extra.dollars, card.ability.extra.energy, localize('Two Pair', 'poker_hands') } }
    end,

    calculate = function(self, card, context) -- Joker Effect
        if context.before and not context.blueprint and (next(context.poker_hands['Two Pair']) or next(context.poker_hands['Full House'])) then
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
            return {
                dollars = card.ability.extra.dollars,
                message = localize('k_upgrade_ex'),
                colour = G.C.RED
            }
        end
        func = function() -- For timing purposes, it runs after the dollar manipulation
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.dollar_buffer = 0
                    return true
                end
            }))
        end
        if context.joker_main then -- Joker Effect
            return {
                xmult = card.ability.extra.xmult
            }
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then -- Devolution
            if card.ability.extra.energy <= 0 then
                G.E_MANAGER:add_event(Event({                                                                       -- Devolve Effect
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local evolution = card
                        play_sound('timpani')
                        card:set_ability("j_trousers") -- The Original Joker
                        card:set_edition()             -- No edition
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                return { -- Devolve Message
                    message = "Reverted!",
                    colour = G.C.BLUE
                }
            else -- Losing Energy...
                card.ability.extra.energy = card.ability.extra.energy - 1
                return {
                    message = "Losing energy...",
                    colour = G.C.BLUE
                }
            end
        end
    end
}

-- Divine Ticket
SMODS.Joker {
    key = "divine_ticket",
    config = { extra = { dollars = 8, energy = 5 } },
    pos = { x = 8, y = 13 },
    soul_pos = { x = 9, y = 13 },
    cost = 11,
    rarity = "hatch_evolved",
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars, card.ability.extra.energy } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play
            and next(SMODS.get_enhancements(context.other_card)) then
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
            return {
                dollars = card.ability.extra.dollars,
                func = function() -- This is for timing purposes, it runs after the dollar manipulation
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.dollar_buffer = 0
                            return true
                        end
                    }))
                end
            }
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then -- Devolution
            if card.ability.extra.energy <= 0 then
                G.E_MANAGER:add_event(Event({                                                                       -- Devolve Effect
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local evolution = card
                        play_sound('timpani')
                        card:set_ability("j_ticket") -- The Original Joker
                        card:set_edition()           -- No edition
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                return { -- Devolve Message
                    message = "Reverted!",
                    colour = G.C.BLUE
                }
            else -- Losing Energy...
                card.ability.extra.energy = card.ability.extra.energy - 1
                return {
                    message = "Losing energy...",
                    colour = G.C.BLUE
                }
            end
        end
    end
}

-- Divine Swashbuckler
SMODS.Joker {
    key = "divine_buckler",
    config = { extra = { xmult = 1, xmult_mod = 0.2, energy = 5 } },
    pos = { x = 6, y = 14 },
    soul_pos = { x = 7, y = 14 },
    cost = 11,
    rarity = "hatch_evolved",
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        local sell_cost = 0
        for _, joker in ipairs(G.jokers and G.jokers.cards or {}) do
            if joker ~= card then
                sell_cost = sell_cost + joker.sell_cost
            end
        end
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult + (card.ability.extra.xmult_mod * sell_cost), card.ability.extra.energy, card.ability.extra.xmult_mod } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local sell_cost = 0
            for _, joker in ipairs(G.jokers.cards) do
                if joker ~= card then
                    sell_cost = sell_cost + joker.sell_cost
                end
            end
            return {
                xmult = card.ability.extra.xmult + (card.ability.extra.xmult_mod * sell_cost)
            }
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then -- Devolution
            if card.ability.extra.energy <= 0 then
                G.E_MANAGER:add_event(Event({                                                                       -- Devolve Effect
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local evolution = card
                        play_sound('timpani')
                        card:set_ability("j_swashbuckler") -- The Original Joker
                        card:set_edition()                 -- No edition
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                return { -- Devolve Message
                    message = "Reverted!",
                    colour = G.C.BLUE
                }
            else -- Losing Energy...
                card.ability.extra.energy = card.ability.extra.energy - 1
                return {
                    message = "Losing energy...",
                    colour = G.C.BLUE
                }
            end
        end
    end
}

-- Divine Smeared Hook
local divine_smeared_check_ref = SMODS.smeared_check
function SMODS.smeared_check(card, suit, ...)
    if next(SMODS.find_card("j_hatch_divine_smeared")) then
        if ((card.base.suit == 'Spades' or card.base.suit == 'Clubs' or card.base.suit == 'Hearts' or
                card.base.suit == 'Diamonds') and (card.base.suit == 'Spades' or card.base.suit == 'Clubs' or
                card.base.suit == 'Hearts' or card.base.suit == 'Diamonds')) then
            return true
        end
    end
    return divine_smeared_check_ref(card, suit, ...)
end

-- Divine Smeared Joker
SMODS.Joker {
    key = "divine_smeared",
    config = { extra = { energy = 5 } },
    pos = { x = 2, y = 14 },
    soul_pos = { x = 3, y = 14 },
    cost = 11,
    rarity = "hatch_evolved",
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.energy } }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then -- Devolution
            if card.ability.extra.energy <= 0 then
                G.E_MANAGER:add_event(Event({                                                                       -- Devolve Effect
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local evolution = card
                        play_sound('timpani')
                        card:set_ability("j_smeared") -- The Original Joker
                        card:set_edition()            -- No edition
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                return { -- Devolve Message
                    message = "Reverted!",
                    colour = G.C.BLUE
                }
            else -- Losing Energy...
                card.ability.extra.energy = card.ability.extra.energy - 1
                return {
                    message = "Losing energy...",
                    colour = G.C.BLUE
                }
            end
        end
    end
}

-- Divine Stuntman
SMODS.Joker {
    key = "divine_stuntman",
    config = { extra = { h_size = 2, xchips = 3, energy = 5 } },
    pos = { x = 0, y = 14 },
    soul_pos = { x = 1, y = 14 },
    cost = 11,
    rarity = "hatch_evolved",
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xchips, card.ability.extra.h_size, card.ability.extra.energy } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xchips = card.ability.extra.xchips
            }
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then -- Devolution
            if card.ability.extra.energy <= 0 then
                G.E_MANAGER:add_event(Event({                                                                       -- Devolve Effect
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local evolution = card
                        play_sound('timpani')
                        card:set_ability("j_stuntman") -- The Original Joker
                        card:set_edition()             -- No edition
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                return { -- Devolve Message
                    message = "Reverted!",
                    colour = G.C.BLUE
                }
            else -- Losing Energy...
                card.ability.extra.energy = card.ability.extra.energy - 1
                return {
                    message = "Losing energy...",
                    colour = G.C.BLUE
                }
            end
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.h_size)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(card.ability.extra.h_size)
    end,
}

-- Divine License
SMODS.Joker {
    key = "divine_license",
    config = { extra = { xmult = 1, xmult_mod = 0.4, energy = 5 } },
    pos = { x = 0, y = 15 },
    soul_pos = { x = 1, y = 15 },
    cost = 11,
    rarity = "hatch_evolved",
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        local driver_tally = 0
        for _, playing_card in pairs(G.playing_cards or {}) do
            if next(SMODS.get_enhancements(playing_card)) then driver_tally = driver_tally + 1 end
        end
        return { vars = { card.ability.extra.xmult_mod, card.ability.extra.xmult + (card.ability.extra.xmult_mod * driver_tally), card.ability.extra.energy } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local driver_tally = 0
            for _, playing_card in pairs(G.playing_cards or {}) do
                if next(SMODS.get_enhancements(playing_card)) then driver_tally = driver_tally + 1 end
            end
            return {
                xmult = card.ability.extra.xmult + (card.ability.extra.xmult_mod * driver_tally)
            }
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then -- Devolution
            if card.ability.extra.energy <= 0 then
                G.E_MANAGER:add_event(Event({                                                                       -- Devolve Effect
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local evolution = card
                        play_sound('timpani')
                        card:set_ability("j_drivers_license") -- The Original Joker
                        card:set_edition()                    -- No edition
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                return { -- Devolve Message
                    message = "Reverted!",
                    colour = G.C.BLUE
                }
            else -- Losing Energy...
                card.ability.extra.energy = card.ability.extra.energy - 1
                return {
                    message = "Losing energy...",
                    colour = G.C.BLUE
                }
            end
        end
    end,
}

-- Divine Hatchet
SMODS.Joker({
    key = "divine_hatchet",
    config = { extra = { xmult = 4, energy = 5, } },
    pos = { x = 2, y = 9 },
    soul_pos = { x = 3, y = 9 },
    cost = 11,
    rarity = "hatch_evolved",
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.energy } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        if context.after then
            SMODS.destroy_cards(context.full_hand, nil, nil, true)
            return {
                message = "Felled!",
                colour = G.C.RED,
            }
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then -- Devolution
            if card.ability.extra.energy <= 0 then
                G.E_MANAGER:add_event(Event({                                                                       -- Devolve Effect
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local evolution = card
                        play_sound('timpani')
                        card:set_ability("j_hatch_hatchet") -- The Original Joker
                        card:set_edition()                  -- No edition
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                return { -- Devolve Message
                    message = "Reverted!",
                    colour = G.C.BLUE
                }
            else -- Losing Energy...
                card.ability.extra.energy = card.ability.extra.energy - 1
                return {
                    message = "Losing energy...",
                    colour = G.C.BLUE
                }
            end
        end
    end
})

-- Divine Love Letter
SMODS.Joker {
    key = "divine_loveletter",
    config = { extra = { xmult = 1.5, energy = 5, } },
    pos = { x = 4, y = 9 },
    soul_pos = { x = 5, y = 9 },
    cost = 11,
    rarity = "hatch_evolved",
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome

        local poly_tally = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if playing_card.edition and playing_card.edition.key == "e_polychrome" then poly_tally = poly_tally + 1 end
            end
        end
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult * poly_tally, card.ability.extra.energy } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local poly_tally = 0
            for _, playing_card in ipairs(G.playing_cards) do
                if playing_card.edition and playing_card.edition.key == "e_polychrome" then poly_tally = poly_tally + 1 end
            end
            return {
                Xmult = 1 + card.ability.extra.xmult * poly_tally,
            }
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then -- Devolution
            if card.ability.extra.energy <= 0 then
                G.E_MANAGER:add_event(Event({                                                                       -- Devolve Effect
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local evolution = card
                        play_sound('timpani')
                        card:set_ability("j_hatch_loveletter") -- The Original Joker
                        card:set_edition()                     -- No edition
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                return { -- Devolve Message
                    message = "Reverted!",
                    colour = G.C.BLUE
                }
            else -- Losing Energy...
                card.ability.extra.energy = card.ability.extra.energy - 1
                return {
                    message = "Losing energy...",
                    colour = G.C.BLUE
                }
            end
        end

        in_pool = function(self, args)
            for _, playing_card in ipairs(G.playing_cards or {}) do
                if playing_card.edition and playing_card.edition.key == "e_polychrome" then
                    return true
                end
            end
            return false
        end
    end
}

-- Divine Wildside
SMODS.Joker {
    key = "divine_wildside",
    config = { extra = { repetitions = 1, xmult = 1.5, energy = 5 } },
    pos = { x = 6, y = 9 },
    soul_pos = { x = 7, y = 9 },
    cost = 11,
    rarity = "hatch_evolved",
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
        return { vars = { card.ability.extra.repetitions, card.ability.extra.xmult, card.ability.extra.energy } }
    end,

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if SMODS.get_enhancements(context.other_card)["m_wild"] == true then
                return {
                    repetitions = card.ability.extra.repetitions,
                    message = localize('k_again_ex'),
                    xmult = card.ability.extra.xmult,
                }
            end
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then -- Devolution
            if card.ability.extra.energy <= 0 then
                G.E_MANAGER:add_event(Event({                                                                       -- Devolve Effect
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local evolution = card
                        play_sound('timpani')
                        card:set_ability("j_hatch_wildside") -- The Original Joker
                        card:set_edition()                   -- No edition
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                return { -- Devolve Message
                    message = "Reverted!",
                    colour = G.C.BLUE
                }
            else -- Losing Energy...
                card.ability.extra.energy = card.ability.extra.energy - 1
                return {
                    message = "Losing energy...",
                    colour = G.C.BLUE
                }
            end
        end
    end
}

-- Divine Clover Localisations
local x_same_ref = get_X_same
function get_X_same(num, hand, or_more)
    if next(SMODS.find_card("j_hatch_divine_fourleaf")) and num == 5 then
        num = 3
    end
    return x_same_ref(num, hand, or_more)
end

-- Divine Clover
SMODS.Joker {
    key = "divine_fourleaf",
    config = { extra = { energy = 5 } },
    pos = { x = 8, y = 9 },
    soul_pos = { x = 9, y = 9 },
    cost = 11,
    rarity = "hatch_evolved",
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.energy } }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            return {}
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then -- Devolution
            if card.ability.extra.energy <= 0 then
                G.E_MANAGER:add_event(Event({                                                                       -- Devolve Effect
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local evolution = card
                        play_sound('timpani')
                        card:set_ability("j_hatch_fourleaf") -- The Original Joker
                        card:set_edition()                   -- No edition
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                return { -- Devolve Message
                    message = "Reverted!",
                    colour = G.C.BLUE
                }
            else -- Losing Energy...
                card.ability.extra.energy = card.ability.extra.energy - 1
                return {
                    message = "Losing energy...",
                    colour = G.C.BLUE
                }
            end
        end
    end
}

-- Divine Steel Ball
SMODS.Joker {
    key = "divine_ball",
    config = { extra = { xmult = 1, xmult_mod = 0.5, energy = 5 } },
    pos = { x = 0, y = 10 },
    soul_pos = { x = 1, y = 10 },
    cost = 11,
    rarity = "hatch_evolved",
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_mod, card.ability.extra.energy } }
    end,

    calculate = function(self, card, context) -- Steel Gain
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_steel') then
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
        end
        if context.joker_main then -- Joker Main
            return {
                xmult = card.ability.extra.xmult
            }
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then -- Devolution
            if card.ability.extra.energy <= 0 then
                G.E_MANAGER:add_event(Event({                                                                       -- Devolve Effect
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local evolution = card
                        play_sound('timpani')
                        card:set_ability("j_hatch_steelball") -- The Original Joker
                        card:set_edition()                    -- No edition
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                return { -- Devolve Message
                    message = "Reverted!",
                    colour = G.C.BLUE
                }
            else -- Losing Energy...
                card.ability.extra.energy = card.ability.extra.energy - 1
                return {
                    message = "Losing energy...",
                    colour = G.C.BLUE
                }
            end
        end
    end
}

-- Divine Musketeer
SMODS.Joker {
    key = "divine_musketeer",
    config = { extra = { type = 'Four of a Kind', energy = 5 } },
    pos = { x = 2, y = 11 },
    soul_pos = { x = 3, y = 11 },
    cost = 11,
    rarity = "hatch_evolved",
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { localize(card.ability.extra.type, 'poker_hands'), card.ability.extra.energy } }
    end,

    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands[card.ability.extra.type]) then
            G.E_MANAGER:add_event(Event({
                func = (function()
                    add_tag({ key = 'tag_investment' })
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end)
            }))
            return nil, true -- This is for Joker retrigger purposes
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then -- Devolution
            if card.ability.extra.energy <= 0 then
                G.E_MANAGER:add_event(Event({                                                                       -- Devolve Effect
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local evolution = card
                        play_sound('timpani')
                        card:set_ability("j_hatch_musketeer") -- The Original Joker
                        card:set_edition()                    -- No edition
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                return { -- Devolve Message
                    message = "Reverted!",
                    colour = G.C.BLUE
                }
            else -- Losing Energy...
                card.ability.extra.energy = card.ability.extra.energy - 1
                return {
                    message = "Losing energy...",
                    colour = G.C.BLUE
                }
            end
        end
    end
}

-- Divine Guard
SMODS.Joker {
    key = "divine_guard",
    config = { extra = { xmult = 0.2, energy = 5 } },
    pos = { x = 4, y = 11 },
    soul_pos = { x = 5, y = 11 },
    cost = 11,
    rarity = "hatch_evolved",
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        local face_tally = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if playing_card:is_face {} then face_tally = face_tally + 1 end
            end
        end
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult * face_tally, card.ability.extra.energy } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local face_tally = 0
            for _, playing_card in ipairs(G.playing_cards) do
                if playing_card:is_face {} then face_tally = face_tally + 1 end
            end
            return {
                xmult = card.ability.extra.xmult * face_tally
            }
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then -- Devolution
            if card.ability.extra.energy <= 0 then
                G.E_MANAGER:add_event(Event({                                                                       -- Devolve Effect
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local evolution = card
                        play_sound('timpani')
                        card:set_ability("j_hatch_royalguard") -- The Original Joker
                        card:set_edition()                     -- No edition
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                return { -- Devolve Message
                    message = "Reverted!",
                    colour = G.C.BLUE
                }
            else -- Losing Energy...
                card.ability.extra.energy = card.ability.extra.energy - 1
                return {
                    message = "Losing energy...",
                    colour = G.C.BLUE
                }
            end
        end
    end
}

-- Divine Ritual
SMODS.Joker {
    key = "divine_ritual",
    config = { extra = { discards = 5, energy = 5 } },
    pos = { x = 6, y = 11 },
    soul_pos = { x = 7, y = 11 },
    cost = 11,
    rarity = "hatch_evolved",
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.discards, card.ability.extra.energy } }
    end,

    calculate = function(self, card, context)
        if context.pre_discard and not context.blueprint and #context.full_hand == 5 then
            return {
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card {
                            set = 'hatch_sephirot',
                            edition = 'e_negative'
                        }
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                }))
            }
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then -- Devolution
            if card.ability.extra.energy <= 0 then
                G.E_MANAGER:add_event(Event({                                                                       -- Devolve Effect
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local evolution = card
                        play_sound('timpani')
                        card:set_ability("j_hatch_ritual") -- The Original Joker
                        card:set_edition()                 -- No edition
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                return { -- Devolve Message
                    message = "Reverted!",
                    colour = G.C.BLUE
                }
            else -- Losing Energy...
                card.ability.extra.energy = card.ability.extra.energy - 1
                return {
                    message = "Losing energy...",
                    colour = G.C.BLUE
                }
            end
        end
    end
}

-- Divine Ballot
SMODS.Joker {
    key = "divine_ballot",
    config = { extra = { energy = 5 } },
    pos = { x = 8, y = 11 },
    soul_pos = { x = 9, y = 11 },
    cost = 11,
    rarity = "hatch_evolved",
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.energy } }
    end,

    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.hands_played == 0 then
            for i = 1, #context.full_hand do
                local percent = 1.15 - (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
                local target = context.full_hand[i]
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        target:flip()
                        play_sound("card1", percent)
                        target:juice_up(0.3, 0.3)
                        return true
                    end,
                }))
            end
            for i = 1, #context.full_hand do
                local target = context.full_hand[i]
                G.E_MANAGER:add_event(Event({
                    func = function()
                        target:set_ability("m_hatch_salt")
                        return true
                    end,
                }))
            end
            for i = 1, #context.full_hand do
                local percent = 1.15 - (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
                local target = context.full_hand[i]
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        target:flip()
                        play_sound("card1", percent)
                        target:juice_up(0.3, 0.3)
                        return true
                    end,
                }))
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then -- Devolution
            if card.ability.extra.energy <= 0 then
                G.E_MANAGER:add_event(Event({                                                                       -- Devolve Effect
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local evolution = card
                        play_sound('timpani')
                        card:set_ability("j_hatch_spoiledballot") -- The Original Joker
                        card:set_edition()                        -- No edition
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                return { -- Devolve Message
                    message = "Reverted!",
                    colour = G.C.BLUE
                }
            else -- Losing Energy...
                card.ability.extra.energy = card.ability.extra.energy - 1
                return {
                    message = "Losing energy...",
                    colour = G.C.BLUE
                }
            end
        end
    end
}

-- Divine Tree
SMODS.Joker {
    key = "divine_tree",
    config = { extra = { xmult = 1, xmult_mod = 0.2, energy = 5 } },
    pos = { x = 0, y = 12 },
    soul_pos = { x = 1, y = 12 },
    cost = 11,
    rarity = "hatch_evolved",
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_mod, card.ability.extra.energy } }
    end,

    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint then
            card.ability.extra.xmult = card.ability.extra.xmult + (card.ability.extra.xmult_mod * #context.removed)
            return {
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } }
            }
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then -- Devolution
            if card.ability.extra.energy <= 0 then
                G.E_MANAGER:add_event(Event({                                                                       -- Devolve Effect
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local evolution = card
                        play_sound('timpani')
                        card:set_ability("j_hatch_fallentree") -- The Original Joker
                        card:set_edition()                     -- No edition
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                return { -- Devolve Message
                    message = "Reverted!",
                    colour = G.C.BLUE
                }
            else -- Losing Energy...
                card.ability.extra.energy = card.ability.extra.energy - 1
                return {
                    message = "Losing energy...",
                    colour = G.C.BLUE
                }
            end
        end
    end
}

-- Etz Chaim
SMODS.Joker {
    key = "etzchaim",
    config = { extra = { xmult = 1, xmult_gain = 1 } },
    pos = { x = 0, y = 9 },
    soul_pos = { x = 1, y = 9 },
    cost = 20,
    rarity = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'HatchetJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_gain } }
    end,

    calculate = function(self, card, context)
        if context.using_consumeable and not context.blueprint then
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
            return {
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
            }
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
}
