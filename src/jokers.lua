-- Proud Joker
SMODS.Joker {
    key = "proudjoker",
    config = {
        extra = {
            mult = 3
        }
    },
    loc_txt = {
        ['name'] = 'Proud Joker',
        ['text'] = {
            'Played {C:attention}Stone Cards{} give',
            '{C:mult}+3{} Mult when scored'
        },
        ['unlock'] = {
            ''
        }
    },
    pos = { x = 0, y = 0 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if SMODS.get_enhancements(context.other_card)["m_stone"] then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}

-- Handout
SMODS.Joker {
    key = "handout",
    config = {
        extra = {
            handsleft = 0,
            handsremaining = 0
        }
    },
    loc_txt = {
        ['name'] = 'Handout',
        ['text'] = {
            'Earn {C:money}$1{} per remaining {C:attention}hand{}',
            'at the end of round'
        },
        ['unlock'] = {
            ''
        }
    },
    pos = { x = 1, y = 0 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["hatch_hatchet_jokers"] = true },

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval then
            return {
                dollars = G.GAME.current_round.hands_left
            }
        end
    end
}

-- Hatchet
SMODS.Joker {
    key = "hatchet",
    config = {
        extra = {
            xmult = 2.5
        }
    },
    loc_txt = {
        ['name'] = 'Hatchet',
        ['text'] = {
            {
                '{X:red,C:white}X2.5{} Mult on {C:attention}first',
                '{C:attention}hand of round',
                '{C:red}Destroy{} scored cards'
            }
        },
        ['unlock'] = {
            ''
        }
    },
    pos = { x = 4, y = 0 },
    cost = 9,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

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

-- Blue Shoes
SMODS.Joker {
    key = "blueshoes",
    config = {
        extra = {
            chips = 200,
            start_dissolve = 0,
            n = 0
        }
    },
    loc_txt = {
        ['name'] = 'Blue Shoes',
        ['text'] = {
            '{C:blue}+200{} Chips',
            '{C:red}Self-destruct{} if',
            'played {C:attention}poker hand{} has',
            'already been played',
            'this round'
        },
        ['unlock'] = {
            ''
        }
    },
    pos = { x = 2, y = 0 },
    cost = 7,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["hatch_hatchet_jokers"] = true },

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            if G.GAME.hands[context.scoring_name] and G.GAME.hands[context.scoring_name].played_this_round > 1 then
                return {
                    func = function()
                        card:start_dissolve()
                        return true
                    end
                }
            else
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
    end
}

-- Earthquake
SMODS.Joker {
    key = "earthquake",
    config = {
        extra = {
            mult = 0
        }
    },
    loc_txt = {
        ['name'] = 'Earthquake',
        ['text'] = {
            'This Joker gains {C:red}+2{} Mult every',
            'time a card is destroyed',
            '{C:inactive}(Currently {C:mult}#1#{} {C:inactive}Mult)'
        },
        ['unlock'] = {
            ''
        }
    },
    pos = { x = 3, y = 0 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.remove_playing_cards and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + (2 * #context.removed)
        end
    end
}

-- Saving Grace
SMODS.Joker {
    key = "savinggrace",
    config = {
        extra = {
            levels = 2,
            start_dissolve = 0,
            n = 0
        }
    },
    loc_txt = {
        ['name'] = 'Saving Grace',
        ['text'] = {
            'Upgrade level of',
            'played poker hand by {C:attention}2{}',
            'in {C:attention}final hand{} of the round',
            '{C:red,E:1}self destructs{}'
        },
        ['unlock'] = {
            ''
        }
    },
    pos = { x = 5, y = 0 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.before then
            if G.GAME.current_round.hands_left == 0 then
                local target_hand = (context.scoring_name or "High Card")
                return {
                    level_up = card.ability.extra.levels,
                    level_up_hand = target_hand,
                    message = localize('k_level_up_ex'),
                    extra = {
                        func = function()
                            card:start_dissolve()
                            return true
                        end,
                        colour = G.C.RED
                    }
                }
            end
        end
    end
}

-- Super Sevens
SMODS.Joker {
    key = "supersevens",
    config = {
        extra = {
            chips = 0
        }
    },
    loc_txt = {
        ['name'] = 'Super Sevens',
        ['text'] = {
            'This Joker gains',
            '{C:blue}+7{} Chips when each',
            'played {C:attention}7{} is scored',
            '{C:inactive}(Currently {C:blue}+#1#{C:inactive} Chips)'
        },
        ['unlock'] = {
            ''
        }
    },
    pos = {
        x = 6,
        y = 0
    },
    display_size = {
        w = 71 * 1,
        h = 95 * 1
    },
    cost = 7,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if context.other_card:get_id() == 7 then
                card.ability.extra.chips = card.ability.extra.chips + 7
                return {
                    message = "Upgrade!",
                    colour = G.C.BLUE
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

-- Seven Sisters
SMODS.Joker {
    key = "sevensisters",
    config = {
        extra = {
            xmult = 2
        }
    },
    loc_txt = {
        ['name'] = 'Seven Sisters',
        ['text'] = {
            '{C:white,X:mult}X2{} Mult if played hand',
            'has a scoring {C:attention}7{} and a',
            'scoring card of any other rank'
        },
        ['unlock'] = {
            ''
        }
    },
    pos = { x = 7, y = 0 },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.joker_main then
            local has_seven = false
            local all_sevens = true
            for _, c in ipairs(context.scoring_hand) do
                local is_seven = (c:get_id() == 7)
                has_seven = has_seven or is_seven
                all_sevens = all_sevens and is_seven
            end
            local valid_hand = has_seven and (#context.scoring_hand > 1) and
                not (all_sevens and #context.scoring_hand > 0)
            if valid_hand then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end
}

-- Diary Entry
SMODS.Joker {
    key = "diary_entry",
    config = {
        extra = {
            chips = 50,
        }
    },
    loc_txt = {
        ['name'] = 'Diary Entry',
        ['text'] = {
            "{C:blue}Common Jokers{} each give {C:blue}50{} Chips",
        },
        ['unlock'] = {
            ''
        }
    },
    pos = { x = 8, y = 0 },
    cost = 9,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,

    calculate = function(self, card, context)
        if context.other_joker and (context.other_joker.config.center.rarity == 1 or context.other_joker.config.center.rarity == "Common") then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,
}

-- Black Joker
SMODS.Joker {
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
            'When this card is sold',
            'Add {C:enhanced}Negative {}to a random {C:attention}Joker.{}',
            '{C:blue}-1{} hand per round'
        },
        ['unlock'] = {
            ''
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
    discovered = false,
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
        if context.selling_self then
            return {
                func = function()
                    local available_jokers = {}
                    for i, joker in ipairs(G.jokers.cards) do
                        table.insert(available_jokers, joker)
                    end
                    local target_joker = #available_jokers > 0 and
                        pseudorandom_element(available_jokers, pseudoseed('copy_joker')) or nil

                    if target_joker then
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                local copied_joker = copy_card(target_joker, nil, nil, nil,
                                    target_joker.edition and target_joker.edition.negative)
                                copied_joker:set_edition("e_negative", true)

                                copied_joker:add_to_deck()
                                G.jokers:emplace(copied_joker)
                                return true
                            end
                        }))
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                            { message = localize('k_duplicated_ex'), colour = G.C.GREEN })
                    end
                    return true
                end,
                extra = {
                    func = function()
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                            { message = "-" .. tostring(card.ability.extra.hands) .. " Hand", colour = G.C.RED })

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

-- Musketeer
SMODS.Joker {
    key = "musketeer",
    config = {
        extra = {
            investment = 0
        }
    },
    loc_txt = {
        ['name'] = 'Musketeer',
        ['text'] = {
            'If played hand contains',
            'a {C:attention}Three of a Kind{} and',
            'a {C:attention}4{}, create an',
            '{C:attention}Investment Tag{}'
        },
        ['unlock'] = {
            'Unlocked by default.'
        }
    },
    pos = { x = 0, y = 1 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["hatch_hatchet_jokers"] = true },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS.tag_investment
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            if (next(context.poker_hands["Three of a Kind"]) and (function()
                    local rankCount = 0
                    for i, c in ipairs(context.scoring_hand) do
                        if c:get_id() == 4 then
                            rankCount = rankCount + 1
                        end
                    end

                    return rankCount >= 1
                end)()) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local tag = Tag("tag_investment")
                        if tag.name == "Orbital Tag" then
                            local _poker_hands = {}
                            for k, v in pairs(G.GAME.hands) do
                                if v.visible then
                                    _poker_hands[#_poker_hands + 1] = k
                                end
                            end
                            tag.ability.orbital_hand = pseudorandom_element(_poker_hands, "jokerforge_orbital")
                        end
                        tag:set_ability()
                        add_tag(tag)
                        play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                        return true
                    end
                }))
                return {
                    message = "Created Tag!"
                }
            end
        end
    end
}

-- Old Photograph
SMODS.Joker {
    key = "old_photograph",
    config = {
        extra = {
            odds = 2,
            repetitions = 1,
            Xmult = 1.5
        }
    },
    loc_txt = {
        ['name'] = 'Old Photograph',
        ['text'] = {
            'First played {C:orange}face{} card gives',
            '{X:red,C:white}X1.5{} Mult when scored.',
            '{C:green}1 in 2{} chance to retrigger'
        },
        ['unlock'] = {
            ''
        }
    },
    pos = { x = 1, y = 1 },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if (function()
                    for i = 1, #context.scoring_hand do
                        local scoring_card = context.scoring_hand[i]
                        if scoring_card:is_face() then
                            return scoring_card == context.other_card
                        end
                    end
                    return false
                end)() then
                if SMODS.pseudorandom_probability(card, 'group_0_35e7c8fb', 1, card.ability.extra.odds, 'j_hatch_oldphotograph', false) then
                    return { repetitions = card.ability.extra.repetitions }
                end
            end
        end
        if context.individual and context.cardarea == G.play then
            if (function()
                    for i = 1, #context.scoring_hand do
                        local scoring_card = context.scoring_hand[i]
                        if scoring_card:is_face() then
                            return scoring_card == context.other_card
                        end
                    end
                    return false
                end)() then
                return {
                    Xmult = card.ability.extra.Xmult
                }
            end
        end
    end
}

-- Interstice
SMODS.Joker {
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
            'Prevents Death if Chips scored',
            'are at least {C:attention}50%{} of required Chips',
            '{C:red}Destroys{} a random Joker',
            '{C:inactive}(bypasses Eternal){}'
        },
        ['unlock'] = {
            ''
        }
    },
    pos = { x = 2, y = 1 },
    cost = 7,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over and context.main_eval and not context.blueprint then
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
                            local target_joker = #destructable_jokers > 0 and
                                pseudorandom_element(destructable_jokers, pseudoseed('destroy_joker')) or nil
                            if target_joker then
                                if target_joker.ability.eternal then
                                    target_joker.ability.eternal = nil
                                end
                                target_joker.getting_sliced = true
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        target_joker:start_dissolve({ G.C.RED }, nil, 1.6)
                                        return true
                                    end
                                }))
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                                    { message = "Destroyed!", colour = G.C.RED })
                            end
                            card:start_dissolve()
                            return true
                        end,
                        colour = G.C.RED
                    }
                }
            end
        end
    end
}

-- Needle Nonsense
SMODS.Joker {
    key = "needle_nonsense",
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
            'Create a {C:spectral}Spectral{} card at end of round',
            '{C:red}Self destructs{} if {C:attention}Blind{} is not',
            'beaten in one hand'
        },
        ['unlock'] = {
            'Unlocked by default.'
        }
    },
    pos = { x = 3, y = 1 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["hatch_hatchet_jokers"] = true },


    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval then
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
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                            { message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral })
                    end
                    return true
                end
            }
        end
        if context.cardarea == G.jokers and context.joker_main then
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

-- Tricky Joker
SMODS.Joker {
    key = "tricky_joker",
    config = {
        extra = {
            basediscardsperround = 0,
            round = 0
        }
    },
    loc_txt = {
        ['name'] = 'Tricky Joker',
        ['text'] = {
            'Your {C:blue}Hands{} are set to',
            'the number of {C:red}discards{} you',
            'have per round'
        },
        ['unlock'] = {
            'Unlocked by default.'
        }
    },
    pos = { x = 4, y = 1 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["hatch_hatchet_jokers"] = true },

    calculate = function(self, card, context)
        if context.setting_blind then
            return {
                func = function()
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                        { message = "Set to " .. tostring(G.GAME.round_resets.discards) .. " Hands", colour = G.C.BLUE })
                    G.GAME.current_round.hands_left = G.GAME.round_resets.discards
                    return true
                end
            }
        end
    end
}

-- Loss Leader
SMODS.Joker {
    key = "loss_leader",
    config = {
        extra = {
            discount = 30
        }
    },
    loc_txt = {
        ['name'] = 'Loss Leader',
        ['text'] = {
            'All items in the',
            'shop are {C:attention}30%{} off'
        },
        ['unlock'] = {
            ''
        }
    },
    pos = { x = 5, y = 1 },
    pixel_size = { h = 71 },
    cost = 2,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',

    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then
                        v:set_cost()
                    end
                end
                return true
            end
        }))
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then
                        v:set_cost()
                    end
                end
                return true
            end
        }))
    end
}

local card_set_cost_ref = Card.set_cost
function Card:set_cost()
    card_set_cost_ref(self)
    local ll = SMODS.find_card("j_hatch_loss_leader")
    if next(ll) then
        self.cost = math.max(0, math.floor(self.cost * (1 - ll[1].ability.extra.discount / 100)))
    end
end

-- Blue Card
SMODS.Joker {
    key = "blue_card",
    config = {
        extra = {
            chips = 0
        }
    },
    loc_txt = {
        ['name'] = 'Blue Card',
        ['text'] = {
            'This Joker gains {C:blue}+10{} Chips when',
            'any {C:orange}Booster Pack{} is skipped',
            '{C:inactive}(Currently {C:blue}+#1#{C:inactive} Chips)'
        },
        ['unlock'] = {
            ''
        }
    },
    pos = { x = 6, y = 1 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,


    calculate = function(self, card, context)
        if context.skipping_booster and not context.blueprint then
            card.ability.extra.chips = (card.ability.extra.chips) + 10
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
}

-- Dakimakura
SMODS.Joker {
    key = "dakimakura",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Dakimakura',
        ['text'] = {
            'If played hand contains a {C:attention}Flush{}',
            'convert each card into',
            '{C:attention}random suits{}'
        },
        ['unlock'] = {
            ''
        }
    },
    pos = { x = 7, y = 1 },
    cost = 5,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',

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
    config = {
        extra = {
            multvar = 0,
            discardsusedthisround = 0
        }
    },
    loc_txt = {
        ['name'] = 'Fortress',
        ['text'] = {
            '{C:red}+1{} Mult per discard',
            'Resets if no discards',
            'are used in a round',
            '{C:inactive}(Does not apply to {C:attention}The Water{C:inactive})'
        },
        ['unlock'] = {
            ''
        }
    },
    pos = { x = 8, y = 1 },
    cost = 5,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            return {
                mult = card.ability.extra.multvar
            }
        end
        if context.discard then
            return {
                func = function()
                    card.ability.extra.multvar = (card.ability.extra.multvar) + 1
                    return true
                end,
                message = "+1 Mult"
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval then
            if (0 == G.GAME.current_round.discards_used and not (G.GAME.blind.config.blind.key == "bl_water")) then
                return {
                    func = function()
                        card.ability.extra.multvar = 1
                        return true
                    end,
                    message = "Reset!"
                }
            end
        end
    end
}

-- D20
SMODS.Joker {
    key = "d20",
    config = {
        extra = {
            odds = 20,
            dollars = 20
        }
    },
    loc_txt = {
        ['name'] = 'D20',
        ['text'] = {
            '{C:green}#1# in 20{} chance to',
            'earn {C:money}$20{}'
        },
        ['unlock'] = {
            'Unlocked by default.'
        }
    },
    pos = { x = 9, y = 1 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["hatch_hatchet_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_hatch_d20')
        return { vars = { new_numerator, new_denominator } }
    end,


    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_bb3f3a02', 1, card.ability.extra.odds, 'j_hatch_d20', false) then
                    SMODS.calculate_effect({ dollars = card.ability.extra.dollars }, card)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                        { message = "Rolled a 20!", colour = G.C.MONEY })
                end
            end
        end
    end
}

-- Risky Revolver
SMODS.Joker {
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
            '{C:green}1 in 6{} chance to give {X:red,C:white}X4{} Mult',
            '{C:green}1 in 6{} chance to destroy a random Joker',
            '{C:green}4 in 6{} chance to do nothing'
        },
        ['unlock'] = {
            'Unlocked by default.'
        }
    },
    pos = { x = 0, y = 2 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["hatch_hatchet_jokers"] = true },

    calculate = function(self, card, context)
        if context.joker_main then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_c0e78a1c', 1, card.ability.extra.odds, 'j_hatch_riskyrevolver', false) then
                    local destructable_jokers = {}
                    for i, joker in ipairs(G.jokers.cards) do
                        if joker ~= card and not SMODS.is_eternal(joker) and not joker.getting_sliced then
                            table.insert(destructable_jokers, joker)
                        end
                    end
                    local target_joker = #destructable_jokers > 0 and
                        pseudorandom_element(destructable_jokers, pseudoseed('destroy_joker')) or nil

                    if target_joker then
                        target_joker.getting_sliced = true
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                target_joker:start_dissolve({ G.C.RED }, nil, 1.6)
                                return true
                            end
                        }))
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                            { message = "Shot!", colour = G.C.RED })
                    end
                end
                if SMODS.pseudorandom_probability(card, 'group_1_a9c87948', 1, card.ability.extra.odds, 'j_hatch_riskyrevolver', false) then
                    SMODS.calculate_effect({ Xmult = card.ability.extra.Xmult }, card)
                end
            end
        end
    end
}

-- Sunset
SMODS.Joker {
    key = "sunset",
    config = {
        extra = {
            xchips = 2
        }
    },
    loc_txt = {
        ['name'] = 'Sunset',
        ['text'] = {
            'On the first hand,',
            'double all played {C:blue}chips{}'
        },
        ['unlock'] = {
            'Unlocked by default.'
        }
    },
    pos = { x = 1, y = 2 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["hatch_hatchet_jokers"] = true },

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            if G.GAME.current_round.hands_played == 0 then
                return {
                    x_chips = card.ability.extra.xchips
                }
            end
        end
    end
}

-- Pizza
SMODS.Joker {
    key = "pizza",
    config = {
        extra = {
            pizza = 0,
            chips = 80,
            start_dissolve = 0,
            n = 0
        }
    },
    loc_txt = {
        ['name'] = 'Pizza',
        ['text'] = {
            '{C:blue}+80{} Chips',
            'Lasts 8 rounds',
            '{C:inactive}(Used {C:attention}#1#{C:inactive} times)'
        },
        ['unlock'] = {
            'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 2
    },
    display_size = {
        w = 71 * 1,
        h = 95 * 1
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["hatch_hatchet_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.pizza } }
    end,


    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            if (card.ability.extra.pizza or 0) >= 8 then
                return {
                    func = function()
                        card:start_dissolve()
                        return true
                    end
                }
            else
                card.ability.extra.pizza = (card.ability.extra.pizza) + 1
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
        if context.after and context.cardarea == G.jokers then
            return {
                message = "-1 Slice"
            }
        end
    end
}

-- Roulette
SMODS.Joker {
    key = "roulette",
    config = {
        extra = {
            mult = 12
        }
    },
    loc_txt = {
        ['name'] = 'Roulette',
        ['text'] = {
            '{C:red}+12 {}Mult if played hand has a {C:attention}#1#{},',
            'suit changes at end of round'
        },
        ['unlock'] = {
            ''
        }
    },
    pos = {
        x = 3,
        y = 2
    },
    display_size = {
        w = 71 * 1,
        h = 95 * 1
    },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { localize((G.GAME.current_round.suitvar_card or {}).suit or 'Spades', 'suits_singular') }, colours = { G.C.SUITS[(G.GAME.current_round.suitvar_card or {}).suit or 'Spades'] } }
    end,

    set_ability = function(self, card, initial)
        G.GAME.current_round.suitvar_card = { suit = 'Spades' }
    end,


    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            if (function()
                    local suitFound = false
                    for i, c in ipairs(context.scoring_hand) do
                        if c:is_suit(G.GAME.current_round.suitvar_card.suit) then
                            suitFound = true
                            break
                        end
                    end

                    return suitFound
                end)() then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if G.playing_cards then
                local valid_suitvar_cards = {}
                for _, v in ipairs(G.playing_cards) do
                    if not SMODS.has_no_suit(v) then
                        valid_suitvar_cards[#valid_suitvar_cards + 1] = v
                    end
                end
                if valid_suitvar_cards[1] then
                    local suitvar_card = pseudorandom_element(valid_suitvar_cards,
                        pseudoseed('suitvar' .. G.GAME.round_resets.ante))
                    G.GAME.current_round.suitvar_card.suit = suitvar_card.base.suit
                end
            end
        end
    end
}

-- Pickpocket
SMODS.Joker {
    key = "pickpocket",
    config = {
        extra = {
            coupon = 0
        }
    },
    loc_txt = {
        ['name'] = 'Pickpocket',
        ['text'] = {
            'Sell this card to create a',
            'free {C:attention}Coupon Tag{}'
        },
        ['unlock'] = {
            ''
        }
    },
    pos = { x = 4, y = 2 },
    cost = 7,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS.tag_coupon
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if context.selling_self and not context.blueprint then
            return {
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local tag = Tag("tag_coupon")
                            if tag.name == "Orbital Tag" then
                                local _poker_hands = {}
                                for k, v in pairs(G.GAME.hands) do
                                    if v.visible then
                                        _poker_hands[#_poker_hands + 1] = k
                                    end
                                end
                                tag.ability.orbital_hand = pseudorandom_element(_poker_hands, "jokerforge_orbital")
                            end
                            tag:set_ability()
                            add_tag(tag)
                            play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                            return true
                        end
                    }))
                    return true
                end,
                message = "Created Tag!"
            }
        end
    end
}

-- Fireworks
SMODS.Joker {
    key = "fireworks",
    config = {
        extra = {
            Xmult = 3,
            start_dissolve = 0,
            n = 0
        }
    },
    loc_txt = {
        ['name'] = 'Fireworks',
        ['text'] = {
            '{X:red,C:white}X3{} Mult if poker hand does {C:attention}not{}',
            'contain a {C:attention}#1#{}, poker hand',
            'changes at the end of round.',
            'If {C:attention}#1#{} is played, {C:red}self destruct{}'
        },
        ['unlock'] = {
            ''
        }
    },
    pos = {
        x = 5,
        y = 2
    },
    display_size = {
        w = 71 * 1,
        h = 95 * 1
    },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.current_round.pokervar_hand } }
    end,

    set_ability = function(self, card, initial)
        G.GAME.current_round.pokervar_hand = 'High Card'
    end,


    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            if not (context.scoring_name == G.GAME.current_round.pokervar_hand) then
                return {
                    Xmult = card.ability.extra.Xmult
                }
            elseif context.scoring_name == G.GAME.current_round.pokervar_hand then
                return {
                    func = function()
                        card:start_dissolve()
                        return true
                    end
                }
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            local pokervar_hands = {}
            for handname, _ in pairs(G.GAME.hands) do
                if G.GAME.hands[handname].visible then
                    pokervar_hands[#pokervar_hands + 1] = handname
                end
            end
            if pokervar_hands[1] then
                G.GAME.current_round.pokervar_hand = pseudorandom_element(pokervar_hands,
                    pseudoseed('pokervar' .. G.GAME.round_resets.ante))
            end
        end
    end
}

-- Stock Exchange
SMODS.Joker {
    key = "stockexchange",
    config = {
        extra = {
            handsremaining = 0,
            Xmult = 0.5
        }
    },
    loc_txt = {
        ['name'] = 'Stock Exchange',
        ['text'] = {
            'Earn {C:money}$5{} for each',
            'remaining {C:attention}discard{}',
            '{X:red,C:white}X0.5{} Mult per hand',
            ''
        },
        ['unlock'] = {
            'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 2
    },
    display_size = {
        w = 71 * 1,
        h = 95 * 1
    },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["hatch_hatchet_jokers"] = true },


    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval then
            return {
                dollars = (G.GAME.current_round.hands_left) * 5
            }
        end
    end
}

-- Ace in the Hole
SMODS.Joker {
    key = "aceinthehole",
    config = {
        extra = {
            chips = 100
        }
    },
    loc_txt = {
        ['name'] = 'Ace in the Hole',
        ['text'] = {
            'Each {C:orange}Ace{} held in hand gives {C:blue}+100{} Chips'
        },
        ['unlock'] = {
            ''
        }
    },
    pos = {
        x = 7,
        y = 2
    },
    display_size = {
        w = 71 * 1,
        h = 95 * 1
    },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',


    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if context.other_card:get_id() == 14 then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
    end
}

-- Witch
SMODS.Joker {
    key = "witch",
    config = {
        extra = {
            xmultvar = 1
        }
    },
    loc_txt = {
        ['name'] = 'Witch',
        ['text'] = {
            'This Joker gains {X:red,C:white}X0.1{} Mult for every unplayed hand',
            '{C:inactive}(Currently{} {X:red,C:white}X#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            ''
        }
    },
    pos = {
        x = 8,
        y = 2
    },
    display_size = {
        w = 71 * 1,
        h = 95 * 1
    },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmultvar } }
    end,


    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            return {
                Xmult = card.ability.extra.xmultvar
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval then
            if true then
                for i = 1, G.GAME.current_round.hands_left do
                    SMODS.calculate_effect({
                        func = function()
                            card.ability.extra.xmultvar = (card.ability.extra.xmultvar) + 0.1
                            return true
                        end
                    }, card)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                        { message = "x0.1 Mult", colour = G.C.GREEN })
                end
            end
        end
    end
}

-- Night Vision
SMODS.Joker {
    key = "nightvision",
    config = { extra = { xmult = 1, xmult_mod = 0.2 } },
    loc_txt = {
        ['name'] = 'Night Vision',
        ['text'] = {
            'Gain {X:red,C:white}X0.2{} Mult for',
            'every {C:attention}successful probability{}',
            '{C:inactive}(Currently {C:white,X:mult}X#1#{C:inactive} Mult)'
        },
        ['unlock'] = {
            'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 2
    },
    display_size = {
        w = 71 * 1,
        h = 95 * 1
    },
    cost = 4,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["hatch_hatchet_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_mod } }
    end,

    calculate = function(self, card, context)
        if context.pseudorandom_result then
            if context.result then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT,
                    message_card = card
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

-- Composter
SMODS.Joker {
    key = "composter",
    config = {
        extra = {
            handsleft = 0,
            cardsremovedfromdeck = 0
        }
    },
    loc_txt = {
        ['name'] = 'Composter',
        ['text'] = {
            'Gain {C:money}$1{} per card {C:attention}destroyed{}',
            'at the end of round'
        },
        ['unlock'] = {
            'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 3
    },
    display_size = {
        w = 71 * 1,
        h = 95 * 1
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["hatch_hatchet_jokers"] = true },


    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval then
            return {
                dollars = (G.GAME.starting_deck_size - #(G.playing_cards or {}))
            }
        end
    end
}

-- Nine Lives
SMODS.Joker {
    key = "ninelives",
    config = {
        extra = {
            ninelives = 0,
            mult = 9,
            start_dissolve = 0,
            n = 0
        }
    },
    loc_txt = {
        ['name'] = 'Nine Lives',
        ['text'] = {
            'Every {C:attention}9{} held in hand gives {C:red}+9{} Mult',
            '{C:attention}Self destructs{} after nine rounds',
            '{C:inactive}(Used #1# times){}'
        },
        ['unlock'] = {
            'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 3
    },
    display_size = {
        w = 71 * 1,
        h = 95 * 1
    },
    cost = 9,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["hatch_hatchet_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.ninelives } }
    end,


    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if context.other_card:get_id() == 9 then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main then
            if (card.ability.extra.ninelives or 0) >= 9 then
                return {
                    func = function()
                        card:start_dissolve()
                        return true
                    end
                }
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval then
            return {
                func = function()
                    card.ability.extra.ninelives = (card.ability.extra.ninelives) + 1
                    return true
                end,
                message = "-1 Life"
            }
        end
    end
}

-- Swindler
SMODS.Joker {
    key = "swindler",
    config = {
        extra = {
            mult = 20,
            dollars = 20
        }
    },
    loc_txt = {
        ['name'] = 'Swindler',
        ['text'] = {
            '{C:red}+20{} Mult',
            '{C:money}-$20{} {C:attention}sell value{}'
        },
        ['unlock'] = {
            'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 3
    },
    display_size = {
        w = 71 * 1,
        h = 95 * 1
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["hatch_hatchet_jokers"] = true },


    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.selling_self then
            return {
                dollars = -card.ability.extra.dollars
            }
        end
    end
}

-- No Dice
SMODS.Joker {
    key = "nodice",
    config = {
        extra = {
            mult = 3,
            mult2 = 3,
            mult3 = 3,
            mult4 = 3,
            mult5 = 3,
            mult6 = 3,
            newnumerator = 0,
            numerator = 0,
            denominator = 0
        }
    },
    loc_txt = {
        ['name'] = 'No Dice',
        ['text'] = {
            'Each played {C:attention}A{}, {C:attention}2{}, {C:attention}3{}, {C:attention}4{}, {C:attention}5{}, {C:attention}6{}',
            'give {C:red}+3{} Mult when scored',
            'All {C:attention}listed probabilities{} fail',
            ''
        },
        ['unlock'] = {
            'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 3
    },
    display_size = {
        w = 71 * 1,
        h = 95 * 1
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["hatch_hatchet_jokers"] = true },


    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 14 then
                return {
                    mult = card.ability.extra.mult
                }
            elseif context.other_card:get_id() == 2 then
                return {
                    mult = card.ability.extra.mult2
                }
            elseif context.other_card:get_id() == 3 then
                return {
                    mult = card.ability.extra.mult3
                }
            elseif context.other_card:get_id() == 4 then
                return {
                    mult = card.ability.extra.mult4
                }
            elseif context.other_card:get_id() == 5 then
                return {
                    mult = card.ability.extra.mult5
                }
            elseif context.other_card:get_id() == 6 then
                return {
                    mult = card.ability.extra.mult6
                }
            end
        end
        if context.fix_probability then
            local numerator, denominator = context.numerator, context.denominator
            numerator = 0
            return {
                numerator = numerator,
                denominator = denominator
            }
        end
    end
}

-- Sailor
SMODS.Joker {
    key = "sailor",
    config = {
        extra = {
            goldchips = 0
        }
    },
    loc_txt = {
        ['name'] = 'Sailor',
        ['text'] = {
            'Played {C:attention}Gold{} Cards',
            'add {C:blue}20{} Chips when scored',
            '{c:inactive}(Currently{} {C:blue}#1#{} {c:inactive}Chips){}'
        },
        ['unlock'] = {
            ''
        }
    },
    pos = {
        x = 4,
        y = 3
    },
    display_size = {
        w = 71 * 1,
        h = 95 * 1
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.goldchips } }
    end,


    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            return {
                chips = card.ability.extra.goldchips
            }
        end
        if context.individual and context.cardarea == G.play then
            if SMODS.get_enhancements(context.other_card)["m_gold"] == true then
                card.ability.extra.goldchips = (card.ability.extra.goldchips) + 20
                return {
                    message = "+20 Chips"
                }
            end
        end
    end
}

-- Snake Eyes
SMODS.Joker {
    key = "snakeeyes",
    config = {
        extra = {
            set_probability = 2,
            denominator = 0
        }
    },
    loc_txt = {
        ['name'] = 'Snake Eyes',
        ['text'] = {
            'All {C:attention}listed {C:green,E:1}denominators',
            'are set to {C:attention}2'
        },
        ['unlock'] = {
            ''
        }
    },
    pos = { x = 5, y = 3 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.fix_probability then
            local numerator, denominator = context.numerator, context.denominator
            denominator = card.ability.extra.set_probability
            return {
                numerator = numerator,
                denominator = denominator
            }
        end
    end
}

-- Wheelbarrow
SMODS.Joker {
    key = "wheelbarrow",
    config = {
        extra = {
            odds = 2,
            xmult = 1
        }
    },
    loc_txt = {
        ['name'] = 'Wheelbarrow',
        ['text'] = {
            '{C:green}#1# in #2#{} cards are',
            'drawn face down',
            'This Joker gains {X:red,C:white}X0.2{} Mult',
            'at end of round',
            '{C:inactive}(Currently {C:white,X:mult}X#3#{C:inactive} Mult)'
        },
        ['unlock'] = {
            ''
        }
    },
    pos = { x = 6, y = 3 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_hatch_wheelbarrow')
        return { vars = { numerator, denominator, card.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if context.stay_flipped and context.to_area == G.hand and SMODS.pseudorandom_probability(card, 'j_hatch_wheelbarrow', 1, card.ability.extra.odds) then
            return {
                stay_flipped = true
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval then
            card.ability.extra.xmult = card.ability.extra.xmult + 0.2
            return {
                message = "Upgrade!",
                colour = G.C.MULT
            }
        end
        if context.joker_main then
            return {
                Xmult = card.ability.extra.xmult
            }
        end
    end
}

-- Love Letter
SMODS.Joker {
    key = "loveletter",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Love Letter',
        ['text'] = {
            'On the {C:attention}final hand{} of a round,',
            'if a {C:attention}High Card{} is played,',
            'add {C:dark_edition}Polychrome{} to it'
        },
        ['unlock'] = {
            ''
        }
    },
    pos = {
        x = 7,
        y = 3
    },
    display_size = {
        w = 71 * 1,
        h = 95 * 1
    },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["hatch_hatchet_jokers"] = true },


    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if (G.GAME.current_round.hands_left == 0 and next(context.poker_hands["High Card"])) then
                context.other_card:set_edition("e_polychrome", true)
                return {
                    message = "Card Modified!"
                }
            end
        end
    end
}

-- Staircase
SMODS.Joker {
    key = "staircase",
    config = {
        extra = {
            odds = 8,
            n = 0
        }
    },
    loc_txt = {
        ['name'] = 'Staircase',
        ['text'] = {
            'Every played {C:attention}face card{} has a {C:green}#2# in #3#{} chance',
            'to create a {C:green}Sephirot{} card',
            '{C:inactive}(Must have room){}'
        },
        ['unlock'] = {
            ''
        }
    },
    pos = {
        x = 8,
        y = 3
    },
    display_size = {
        w = 71 * 1,
        h = 95 * 1
    },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["hatch_hatchet_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds,
            'j_hatch_staircase')
        return { vars = { card.ability.extra.n, new_numerator, new_denominator } }
    end,


    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_face() then
                if SMODS.pseudorandom_probability(card, 'group_0_8534ce80', 1, card.ability.extra.odds, 'j_hatch_staircase', false) then
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
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                        { message = created_consumable and localize('k_plus_consumable') or nil, colour = G.C.PURPLE })
                end
            end
        end
    end
}

-- Graveyard Shift
SMODS.Joker {
    key = "graveyardshift",
    config = {
        extra = {
            discards = 0
        }
    },
    loc_txt = {
        ['name'] = 'Graveyard Shift',
        ['text'] = {
            'Gain {C:red}+1{} Mult per {C:attention}discarded{} card.',
            'On the {C:attention}final hand{} of the round, apply',
            'the total Mult. Resets per {C:attention}round{}',
            '{C:inactive}(Currently {C:red}+#1#{C:inactive} Mult)'
        },
        ['unlock'] = {
            ''
        }
    },
    pos = {
        x = 9,
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
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["hatch_hatchet_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.discards } }
    end,


    calculate = function(self, card, context)
        if context.discard then
            return {
                func = function()
                    card.ability.extra.discards = (card.ability.extra.discards) + 1
                    return true
                end,
                message = "+1"
            }
        end
        if context.cardarea == G.jokers and context.joker_main then
            if G.GAME.current_round.hands_left == 0 then
                return {
                    mult = card.ability.extra.discards
                }
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval then
            return {
                func = function()
                    card.ability.extra.discards = 0
                    return true
                end,
                message = "Resets!"
            }
        end
    end
}

-- Plant Party
SMODS.Joker {
    key = "plantparty",
    config = {
        extra = {
            xmult = 1
        }
    },
    loc_txt = {
        ['name'] = 'Plant Party',
        ['text'] = {
            'All face cards are debuffed',
            '{X:red,C:white}X0.2{} Mult for each {C:attention}played hand {}',
            '{C:inactive}(Currently{} {X:red,C:white}X#1#{}{}{C:inactive} Mult){}'
        },
        ['unlock'] = {
            'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 4
    },
    display_size = {
        w = 71 * 1,
        h = 95 * 1
    },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["hatch_hatchet_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if context.debuff_card and context.debuff_card:is_face() then
            return { debuff = true }
        end
        if context.cardarea == G.jokers and context.joker_main then
            card.ability.extra.xmult = (card.ability.extra.xmult) + 0.2
            return {
                Xmult = card.ability.extra.xmult
            }
        end
    end
}

-- Air Missile
SMODS.Joker {
    key = "airmissile",
    config = {
        extra = {
            xmult = 1,
            odds = 4,
            levels = -1
        }
    },
    loc_txt = {
        ['name'] = 'Air Missile',
        ['text'] = {
            '{C:green}#2# in #3#{} chance to downgrade',
            'level of played {C:attention}poker hand{}',
            'and gain {X:red,C:white}X0.5{} Mult',
            '{C:inactive}(Currently{} {X:red,C:white}X#1#{}{}{C:inactive} Mult){}'
        },
        ['unlock'] = {
            'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 4
    },
    display_size = {
        w = 71 * 1,
        h = 95 * 1
    },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["hatch_hatchet_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds,
            'j_hatch_airmissile')
        return { vars = { card.ability.extra.xmult, new_numerator, new_denominator } }
    end,


    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_f9f9ec2e', 1, card.ability.extra.odds, 'j_hatch_airmissile', false) then
                    local target_hand = (context.scoring_name or "High Card")
                    SMODS.calculate_effect({
                        level_up = card.ability.extra.levels,
                        level_up_hand = target_hand
                    }, card)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                        { message = localize('k_level_up_ex'), colour = G.C.RED })
                    SMODS.calculate_effect({
                        func = function()
                            card.ability.extra.xmult = (card.ability.extra.xmult) + 0.5
                            return true
                        end
                    }, card)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                        { message = "x0.5", colour = G.C.GREEN })
                end
            end
        end
        if context.cardarea == G.jokers and context.joker_main then
            return {
                Xmult = card.ability.extra.xmult
            }
        end
    end
}

-- Wildside
SMODS.Joker {
    key = "wildside",
    config = {
        extra = {
            repetitions = 1
        }
    },
    loc_txt = {
        ['name'] = 'Wildside',
        ['text'] = {
            'Retrigger each',
            'played {C:attention}Wild Card{}'
        },
        ['unlock'] = {
            'Unlocked by default.'
        }
    },
    pos = { x = 2, y = 4 },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["hatch_hatchet_jokers"] = true },
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

-- Cave
SMODS.Joker {
    key = "cave",
    config = {
        extra = {
            Xmult = 1.5
        }
    },
    loc_txt = {
        ['name'] = 'Cave',
        ['text'] = {
            'Each {C:attention}Stone{} card held in',
            'hand gives {X:red,C:white}X1.5{} Mult'
        },
        ['unlock'] = {
            'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 4
    },
    display_size = {
        w = 71 * 1,
        h = 95 * 1
    },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["hatch_hatchet_jokers"] = true },


    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if SMODS.get_enhancements(context.other_card)["m_stone"] == true then
                return {
                    Xmult = card.ability.extra.Xmult
                }
            end
        end
    end
}

-- Giraffe
SMODS.Joker {
    key = "giraffe",
    config = {
        extra = {
            chips = 0
        }
    },
    loc_txt = {
        ['name'] = 'Giraffe',
        ['text'] = {
            '{C:blue}+50{} Chips per {C:attention}reroll{} this run',
            '{C:inactive}(Currently {C:blue}+#1#{C:inactive} Chips)'
        },
        ['unlock'] = {
            'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 4
    },
    display_size = {
        w = 71 * 1,
        h = 95 * 1
    },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["hatch_hatchet_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,


    calculate = function(self, card, context)
        if context.reroll_shop then
            return {
                func = function()
                    card.ability.extra.chips = (card.ability.extra.chips) + 50
                    return true
                end,
                message = "+50"
            }
        end
        if context.cardarea == G.jokers and context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
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
    config = {
        extra = { type = 'Three of a Kind' }
    },
    loc_txt = {
        ['name'] = 'Four-Leaf Clover',
        ['text'] = {
            '{C:attention}Four of a Kinds',
            'can be created with',
            '{C:attention}Three of a Kind',
        },
    },
    pos = { x = 5, y = 4 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
}

-- Steel Ball
SMODS.Joker {
    key = "steelball",
    config = { extra = { mult_gain = 2, mult = 0 } },
    loc_txt = {
        ['name'] = 'Steel Ball',
        ['text'] = {
            'Gains {C:red}+2{} Mult per {C:attention}Steel Card',
            'played per round',
            '{C:inactive}(Currently {C:red}+#1#{C:inactive} Mult)',
        },
    },
    pos = { x = 6, y = 4 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',

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

-- Hands Down
SMODS.Joker {
    key = "handsdown",
    config = { extra = { xmult = 0.5, h_size = 4 } },
    loc_txt = {
        ['name'] = 'Hands Down',
        ['text'] = {
            '{C:attention}+4{} hand size',
            '{X:red,C:white}X0.5{} Mult per round',
        },
    },
    pos = { x = 7, y = 4 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.h_size } }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(card.ability.extra.h_size)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(card.ability.extra.h_size)
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
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Defaced',
        ['text'] = {
            'All {C:attention}face cards{} are',
            'considered {C:attention}2s{}',
        },
    },
    pos = { x = 8, y = 4 },
    cost = 5,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
    end,

    add_to_deck = function(self, card, from_debuff)
    end,

    remove_from_deck = function(self, card, from_debuff)
    end
}

-- Fool's Gold
SMODS.Joker {
    key = "foolsgold",
    loc_txt = {
        ['name'] = 'Fools Gold',
        ['text'] = {
            'Played {C:attention}Gold{} cards',
            'have a {C:green}#1# in #2#{} chance to',
            'create a {C:tarot}Fool{} card',
            '{C:inactive}(Must have room)'
        },
    },
    pos = { x = 9, y = 8 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    config = { extra = { odds = 4 } },

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_hatch_foolsgold')
        return { vars = { numerator, denominator } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_gold') and
            SMODS.pseudorandom_probability(card, 'j_hatch_foolsgold', 1, card.ability.extra.odds) then
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
}

-- Topsy Turvy
SMODS.Joker {
    key = "topsyturvy",
    config = {
        extra = { odds = 4 } },
    loc_txt = {
        ['name'] = 'Topsy Turvy',
        ['text'] = {
            '{C:green}#1# in #2#{} chance to',
            'swap {C:blue}Chips{} and {C:mult}Mult{}',
        },
    },
    pos = { x = 9, y = 4 },
    cost = 5,
    rarity = 1,
    blueprint_compat = false, -- lol
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',

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
        extra = { chips = 0 } },
    loc_txt = {
        ['name'] = 'Windmill',
        ['text'] = {
            'This Joker gains {C:blue}+20{} Chips when',
            'card {C:attention}Enhancement{} is removed',
            '{C:inactive}(Currently {C:blue}+#1#{C:inactive} Chips)',
        },
    },
    pos = { x = 0, y = 5 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,

    calculate = function(self, card, context)
        if context.setting_ability and G.P_CENTERS[context.old].set == 'Enhanced' and G.P_CENTERS[context.new].set ~= 'Enhanced' then
            card.ability.extra.chips = card.ability.extra.chips + 20
            return { message = localize('k_upgrade_ex'), colour = G.C.BLUE }
        end -- credit to Somethingcom515 for the enhanced ability thing
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}

-- Wild West
SMODS.Joker {
    key = "wildwest",
    config = {
        extra = { mult = 8 } },
    loc_txt = {
        ['name'] = 'Wild West',
        ['text'] = {
            'Each played {C:attention}Wild Card{}',
            'gives {C:red}8{} Mult when scored',
        },
    },
    pos = { x = 1, y = 5 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_wild') then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

-- Lime Pie
SMODS.Joker({
    key = "limepie",
    config = {
        extra = { dollars = 8, discard_sub = 1 },
    },
    loc_txt = {
        ["name"] = "Lime Pie",
        ["text"] = {
            "Earn {C:money}$8{} at end of round",
            "Payout {C:attention}reduced{} by {C:money}$1{}",
            "per discarded hand",
            "{C:inactive}(Payout is currently $#1#){}"
        },
    },
    pos = { x = 2, y = 5 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "CustomJokers",

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
})

-- Heart Transplant
SMODS.Joker({
    key = "hearttransplant",
    config = {
        extra = {},
    },
    loc_txt = {
        ["name"] = "Heart Transplant",
        ["text"] = {
            'If played hand contains a scoring {C:hearts}Heart{}',
            'card and a scoring card of any other suit',
            '{C:attention}convert{} all played cards into the {C:hearts}Heart{} suit',
        },
    },
    pos = { x = 3, y = 5 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "CustomJokers",

    calculate = function(self, card, context)
        if context.joker_main and SMODS.seeing_double_check(context.scoring_hand, 'Hearts') then
            for i = 1, #context.full_hand do
                local percent = 1.15 - (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
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
SMODS.Joker({
    key = "emptycrown",
    config = {
        extra = {},
    },
    loc_txt = {
        ["name"] = "Empty Crown",
        ["text"] = {
            "At the end of every round,",
            "create a {C:green}Kether{} card",
            "{C:inactive}(Must have room){}",
        },
    },
    pos = { x = 4, y = 5 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "CustomJokers",

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and not context.blueprint then
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
})

-- Royal Guard
SMODS.Joker({
    key = "royalguard",
    config = {
        extra = { mult = 0 },
    },
    loc_txt = {
        ["name"] = "Royal Guard",
        ["text"] = {
            "{C:red}+1{} Mult for every",
            "{C:attention}face card{} in your deck",
            "{C:inactive}(Currently {C:mult}#2#{} {C:inactive}Mult)"
        },
    },
    pos = { x = 5, y = 5 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "CustomJokers",

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
})

-- Meteorite
SMODS.Joker({
    key = "meteorite",
    config = { extra = {} },
    loc_txt = {
        ["name"] = "Meteorite",
        ["text"] = {
            "Sell this card to create a free",
            "{C:attention}Meteor Tag{}"
        },
    },
    pos = { x = 6, y = 5 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "CustomJokers",

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
})

-- Psychic Panic
SMODS.Joker({
    key = "psychicpanic",
    config = { extra = { mult = 0, mult_gain = 1, size = 5 } },
    loc_txt = {
        ["name"] = "Psychic Panic",
        ["text"] = {
            "Gain {C:mult}+1{} Mult for every {C:attention}5{} card hand played",
            "{C:attention}Resets{} if less than {C:attention}5{} cards are played",
            '{C:inactive}(Currently {C:red}+#1#{C:inactive} Mult)'
        },
    },
    pos = { x = 7, y = 5 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "CustomJokers",

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
    loc_txt = {
        ["name"] = "Astrophysicist",
        ["text"] = {
            "Gain {C:blue}+10{} Chips for",
            "every {C:planet}Planet{} card used",
            '{C:inactive}(Currently {C:blue}+#1#{C:inactive} Chips)'
        },
    },
    pos = { x = 8, y = 5 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "CustomJokers",

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
    loc_txt = {
        ["name"] = "Science Lab",
        ["text"] = {
            {
                "Gain {C:blue}+#2#{} Chips for each",
                "{C:attention}Mercury Card{} held in hand",
                "{C:inactive}(Currently {C:blue}+#1#{C:inactive} Chips)"
            }
        },
    },
    pos = { x = 9, y = 5 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "CustomJokers",

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
SMODS.Joker({
    key = "bonusround",
    config = { extra = { odds = 2, dollars = 2 } },
    loc_txt = {
        ["name"] = "Bonus Round",
        ["text"] = {
            {
                "Played {C:attention}Bonus{} cards have a {C:green}#1# in #2#{}",
                "chance to give {C:money}$2{} when scored",
            }
        },
    },
    pos = { x = 0, y = 6 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "CustomJokers",

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds,
            card.ability.extra.dollars, 'j_hatch_bonusround')
        return { vars = { numerator, denominator, card.ability.extra.dollars } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_bonus')
            and SMODS.pseudorandom_probability(card, 'j_hatch_bonusround', 1, card.ability.extra.odds) then
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
})

-- Playground
SMODS.Joker({
    key = "playground",
    config = { extra = { tags = 1 } },
    loc_txt = {
        ["name"] = "Playground",
        ["text"] = {
            {
                "When {C:attention}Boss Blind{} is defeated",
                "create a random {C:attention}Tag{}",
            }
        },
    },
    pos = { x = 1, y = 6 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "CustomJokers",

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
    loc_txt = {
        ["name"] = "Slippery Slope",
        ["text"] = {
            {
                "{C:mult}+#3#{} Mult per round",
                "Lose {C:money}$#2#{} at end of round",
                "{C:inactive}(Currently {C:mult}+#1#{}{C:inactive} Mult){}"
            }
        },
    },
    pos = { x = 2, y = 6 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "CustomJokers",

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
SMODS.Joker({
    key = "textile",
    config = { extra = { mult = 0, mult_gain = 4 } },
    loc_txt = {
        ["name"] = "Textile Joker",
        ["text"] = {
            {
                "Gain {C:mult}+#2#{} Mult if {C:attention}Blind{}",
                "is cleared in {C:attention}one{} hand",
                "{C:inactive}(Currently {C:mult}+#1#{}{C:inactive} Mult){}"
            }
        },
    },
    pos = { x = 3, y = 6 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "CustomJokers",

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
})

-- Abacus
SMODS.Joker({
    key = "abacus",
    config = { extra = { mult = 0, mult_gain = 1, mult_loss = 1 } },
    loc_txt = {
        ["name"] = "Abacus",
        ["text"] = {
            {
                "{C:mult}+#2#{} Mult for each played {C:attention}2{}, {C:attention}4{}, {C:attention}6{} and {C:attention}8{}",
                "{C:mult}-#3#{} Mult for each played {C:attention}3{}, {C:attention}5{}, {C:attention}7{} and {C:attention}9{}",
                "{C:inactive}(Currently {C:mult}+#1#{}{C:inactive} Mult){}",
            }
        },
    },
    pos = { x = 4, y = 6 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "CustomJokers",

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
SMODS.Joker({
    key = "medicine",
    config = { extra = { xmult = 3, odds = 4 } },
    loc_txt = {
        ["name"] = "Medicine Cabinet",
        ["text"] = {
            {
                "{C:white,X:mult}X#3#{} Mult in a {C:attention}Boss Blind{}",
                "{C:green}#1# in #2#{} chance to expire",
                "after a {C:attention}Boss Blind{}"
            }
        },
    },
    pos = { x = 5, y = 6 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "CustomJokers",

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_hatch_cakeslice')
        return { vars = { numerator, denominator, card.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if G.GAME.blind.boss and context.end_of_round and context.main_eval then
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
        if context.joker_main then
            if G.GAME.blind.boss then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end
})

-- Burrito
SMODS.Joker({
    key = "burrito",
    config = { extra = { d_size = 7, d_size_sub = 1 } },
    loc_txt = {
        ["name"] = "Burrito",
        ["text"] = {
            {
                "{C:red}+#1#{} discards",
                "{C:attention}-#2#{} discard per round",
            }
        },
    },
    pos = { x = 6, y = 6 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "CustomJokers",

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
    loc_txt = {
        ["name"] = "Cake Slice",
        ["text"] = {
            {
                "When {C:attention}Blind{} is cleared",
                "gain a random {C:attention}Tag{}",
                "{C:green}#1# in #2#{} chance to",
                "{C:red}self-destruct{}"
            }
        },
    },
    pos = { x = 7, y = 6 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "CustomJokers",

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
SMODS.Joker({
    key = "sourmilk",
    config = { extra = { dollar = 1, limit = 20 } },
    loc_txt = {
        ["name"] = "Soured Milk",
        ["text"] = {
            {
                "Lose {C:money}$#1#{} per round",
                "If balance is below {C:money}-$#2#{}",
                "this {C:attention}Joker{} spoils"
            }
        },
    },
    pos = { x = 8, y = 6 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "CustomJokers",

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
})

-- Milkman
SMODS.Joker({
    key = "milkman",
    config = { extra = { xmult_gain = 0.1 } },
    loc_txt = {
        ["name"] = "Milkman",
        ["text"] = {
            {
                "Gain {C:white,X:mult}X#1#{} Mult",
                "per {C:attention}dollar{} below zero",
                "{C:inactive}(Currently {X:red,C:white}X#2#{C:inactive} Mult)"
            }
        },
    },
    pos = { x = 9, y = 6 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "CustomJokers",

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
})

-- Ballad of Jimbo
SMODS.Joker({
    key = "ballad",
    config = { extra = {} },
    loc_txt = {
        ["name"] = "Ballad of Jimbo",
        ["text"] = {
            {
                "{C:attention}Buffoon Packs{} may",
                "contain an extra {C:attention}Joker{}",
            }
        },
    },
    pos = { x = 0, y = 7 },
    cost = 7,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "CustomJokers",

    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,

    -- Credit to N'
    add_to_deck = function(self, card, context)
        G.GAME.modifiers.booster_size_mod = (G.GAME.modifiers.booster_size_mod or 0) + 1
    end,

})

-- Hearts and Minds
SMODS.Joker({
    key = "heartminds",
    config = { extra = { mult = 0, mult_mod = 4 } },
    loc_txt = {
        ["name"] = "Hearts and Minds",
        ["text"] = {
            {
                "Gain {C:mult}+#2#{} Mult if played hand",
                "contains a {C:attention}Flush{}",
                "then {C:attention}destroy{} played cards",
                "{C:inactive}(Currently{} {C:red}+#1#{} {C:inactive}Mult{})"
            }
        },
    },
    pos = { x = 1, y = 7 },
    cost = 7,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "CustomJokers",

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
            SMODS.destroy_cards(context.full_hand, nil, nil, true)
            return {
                message = "Cards destroyed!",
                colour = G.C.RED,
            }
        end
    end
})

-- Spoiled Ballot
SMODS.Joker({
    key = "spoiledballot",
    config = { extra = {} },
    loc_txt = {
        ["name"] = "Spoiled Ballot",
        ["text"] = {
            {
                "On the {C:attention}first hand{} of round",
                "the {C:attention}first{} played card is",
                "enhanced into a {C:attention}Salt Card{}",
            }
        },
    },
    pos = { x = 2, y = 7 },
    cost = 7,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "CustomJokers",

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
    config = { extra = {} },
    loc_txt = {
        ["name"] = "Philosopher's Stone",
        ["text"] = {
            {
                "If played hand contains",
                "a {C:attention}Sulfur Card{}",
                "a {C:attention}Mercury Card{}",
                "and a {C:attention}Salt Card{}",
                "create a {C:tarot}Divine Card{}",
            }
        },
    },
    pos = { x = 3, y = 7 },
    cost = 7,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = "CustomJokers",

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
                                set = 'divine',
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

-- Divine Hatchet
SMODS.Joker {
    key = "divine_hatchet",
    config = {
        extra = {
            xmult = 4,
            energy = 5,
        }
    },
    loc_txt = {
        ['name'] = 'Divine Hatchet',
        ['text'] = {
            '{C:white,X:mult}X#1#{} Mult',
            '{C:red}Destroy{} scored cards',
            '',
            '{C:inactive,s:0.8}Devolves after{} {C:attention,s:0.8}five{} {C:inactive,s:0.8}rounds{}',
            '{C:inactive,s:0.8}({}{C:attention,s:0.8}#2#{}{C:inactive,s:0.8} remaining){}'
        },
        ['unlock'] = {
            'Evolve Hatchet'
        }
    },
    pos = { x = 2, y = 9 },
    soul_pos = { x = 3, y = 9 },
    cost = 9,
    rarity = "hatch_evolved",
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = false,
    discovered = false,
    atlas = 'CustomJokers',

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

        if context.end_of_round and context.game_over == false and context.main_eval then -- Devolution
            if card.ability.extra.energy <= 0 then
                G.E_MANAGER:add_event(Event({                                             -- Devolve Effect
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local evolution = card
                        play_sound('timpani')
                        card:set_ability("j_hatch_hatchet") -- The Original Joker
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

-- Divine Love Letter
SMODS.Joker {
    key = "divine_loveletter",
    config = {
        extra = {
            xmult = 0.5,
            energy = 5,
        }
    },
    loc_txt = {
        ['name'] = 'Divine Letter',
        ['text'] = {
            '{C:white,X:mult}X#1#{} Mult for',
            'every {C:dark_edition}Polychrome{}',
            'card in deck',
            '',
            '{C:inactive,s:0.8}Devolves after{} {C:attention,s:0.8}five{} {C:inactive,s:0.8}rounds{}',
            '{C:inactive,s:0.8}({}{C:attention,s:0.8}#3#{}{C:inactive,s:0.8} remaining){}'
        },
        ['unlock'] = {
            'Evolve Love Letter'
        }
    },
    pos = { x = 4, y = 9 },
    soul_pos = { x = 5, y = 9 },
    cost = 9,
    rarity = "hatch_evolved",
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = false,
    discovered = false,
    atlas = 'CustomJokers',

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

        if context.end_of_round and context.game_over == false and context.main_eval then -- Devolution
            if card.ability.extra.energy <= 0 then
                G.E_MANAGER:add_event(Event({                                             -- Devolve Effect
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local evolution = card
                        play_sound('timpani')
                        card:set_ability("j_hatch_loveletter") -- The Original Joker
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
    config = {
        extra = {
            repetitions = 1,
            xmult = 1.5,
            energy = 5
        }
    },
    loc_txt = {
        ['name'] = 'Divine Wildside',
        ['text'] = {
            'Played {C:attention}Wild Cards{}',
            'give {C:white,X:mult}X#2#{} Mult',
            'and {C:attention}retrigger{}',
            '',
            '{C:inactive,s:0.8}Devolves after{} {C:attention,s:0.8}five{} {C:inactive,s:0.8}rounds{}',
            '{C:inactive,s:0.8}({}{C:attention,s:0.8}#3#{}{C:inactive,s:0.8} remaining){}'

        },
        ['unlock'] = {
            'Evolve Wildside'
        }
    },
    pos = { x = 6, y = 9 },
    soul_pos = { x = 7, y = 9 },
    cost = 9,
    rarity = "hatch_evolved",
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = false,
    discovered = false,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
        return { vars = { card.ability.extra.repetitions, card.ability.extra.xmult, card.ability.extra.energy } }
    end,

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if SMODS.get_enhancements(context.other_card)["m_wild"] == true then
                return {
                    xmult = card.ability.extra.xmult,
                    repetitions = card.ability.extra.repetitions,
                    message = localize('k_again_ex')
                }
            end
        end

        if context.end_of_round and context.game_over == false and context.main_eval then -- Devolution
            if card.ability.extra.energy <= 0 then
                G.E_MANAGER:add_event(Event({                                             -- Devolve Effect
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local evolution = card
                        play_sound('timpani')
                        card:set_ability("j_hatch_wildside") -- The Original Joker
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
    config = {
        extra = {
            energy = 5
        }
    },
    loc_txt = {
        ['name'] = 'Divine Clover',
        ['text'] = {
            '{C:attention}Five of a Kinds',
            'can be created with',
            '{C:attention}Three of a Kind',
            '',
            '{C:inactive,s:0.8}Devolves after{} {C:attention,s:0.8}five{} {C:inactive,s:0.8}rounds{}',
            '{C:inactive,s:0.8}({}{C:attention,s:0.8}#1#{}{C:inactive,s:0.8} remaining){}'
        },
        ['unlock'] = {
            'Evolve Four-Leaf Clover'
        }
    },
    pos = { x = 8, y = 9 },
    soul_pos = { x = 9, y = 9 },
    cost = 9,
    rarity = "hatch_evolved",
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = false,
    discovered = false,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.energy } }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            return {}
        end

        if context.end_of_round and context.game_over == false and context.main_eval then -- Devolution
            if card.ability.extra.energy <= 0 then
                G.E_MANAGER:add_event(Event({                                             -- Devolve Effect
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local evolution = card
                        play_sound('timpani')
                        card:set_ability("j_hatch_fourleaf") -- The Original Joker
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
    config = {
        extra = {
            xmult = 1,
            xmult_mod = 1,
            energy = 5
        }
    },
    loc_txt = {
        ['name'] = 'Divine Steel Ball',
        ['text'] = {
            'Gain {C:white,X:mult}X#2#{} Mult',
            'per {C:attention}Steel Card{} scored',
            '{C:inactive}(Currently{} {C:white,X:mult}X#1#{} {C:inactive}Mult){}',
            '',
            '{C:inactive,s:0.8}Devolves after{} {C:attention,s:0.8}five{} {C:inactive,s:0.8}rounds{}',
            '{C:inactive,s:0.8}({}{C:attention,s:0.8}#3#{}{C:inactive,s:0.8} remaining){}'
        },
        ['unlock'] = {
            'Evolve Steel Ball'
        }
    },
    pos = { x = 0, y = 10 },
    soul_pos = { x = 1, y = 10 },
    cost = 9,
    rarity = "hatch_evolved",
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = false,
    discovered = false,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_mod, card.ability.extra.energy } }
    end,

    calculate = function(self, card, context) -- Steel Gain
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_steel') then
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
            return {
                message = "Upgrade!",
                colour = G.C.RED
            }
        end
        if context.joker_main then -- Joker Main
            return {
                Xmult = card.ability.extra.Xmult
            }
        end

        if context.end_of_round and context.game_over == false and context.main_eval then -- Devolution
            if card.ability.extra.energy <= 0 then
                G.E_MANAGER:add_event(Event({                                             -- Devolve Effect
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local evolution = card
                        play_sound('timpani')
                        card:set_ability("j_hatch_steelball") -- The Original Joker
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
    key = "etz_chaim",
    config = {
        extra = {
            xmult = 1
        }
    },
    loc_txt = {
        ['name'] = 'Etz Chaim',
        ['text'] = {
            'This Joker gains {X:red,C:white}X1{} Mult per {C:attention}consumable{} used',
            '{C:inactive}(Currently {X:red,C:white}X#1#{C:inactive} Mult)'
        },
        ['unlock'] = {
            'Use the Daat card'
        }
    },
    pos = { x = 0, y = 9 },
    soul_pos = { x = 1, y = 9 },
    cost = 20,
    rarity = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = false,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["hatch_hatchet_jokers"] = true },
    in_pool = function(self, args)
        return (
                not args
                or args.source ~= 'sho' and args.source ~= 'buf' and args.source ~= 'jud' and args.source ~= 'sou'
                or args.source == 'rif' or args.source == 'rta' or args.source == 'uta' or args.source == 'wra'
            )
            and true
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if context.using_consumeable then
            card.ability.extra.xmult = (card.ability.extra.xmult) + 1
            return {
                message = "X" .. card.ability.extra.xmult .. " Mult",
                colour = G.C.RED
            }
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}

-- Etz Chaim (Localisations)

local check_for_buy_space_ref = G.FUNCS.check_for_buy_space
G.FUNCS.check_for_buy_space = function(card)
    if card.config.center.key == "j_hatch_etzchaim" then -- ignore slot limit when bought
        return true
    end
    return check_for_buy_space_ref(card)
end

local can_select_card_ref = G.FUNCS.can_select_card
G.FUNCS.can_select_card = function(e)
    if e.config.ref_table.config.center.key == "j_hatch_etzchaim" then
        e.config.colour = G.C.GREEN
        e.config.button = "use_card"
    else
        can_select_card_ref(e)
    end
end
