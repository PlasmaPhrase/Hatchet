-- Proud Joker
SMODS.Joker{
    key = "proudjoker",
    config = {
        extra = {
            mult = 3
        }
    },
    loc_txt = {
        ['name'] = 'Proud Joker',
        ['text'] = {
            [1] = 'Played {C:attention}Stone Cards{} give',
            [2] = '{C:mult}+3{} Mult when scored'
        },
        ['unlock'] = {
            [1] = ''
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
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if SMODS.get_enhancements(context.other_card)["m_stone"] then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}

-- Handout
SMODS.Joker{ 
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
            [1] = 'Earn {C:money}$1{} per remaining {C:attention}hand{}',
            [2] = 'at the end of round'
        },
        ['unlock'] = {
            [1] = ''
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
    pools = { ["hatchet_hatchet_jokers"] = true },
    
    calculate = function(self, card, context)
    if context.end_of_round and context.game_over == false and context.main_eval  then
        return {
            dollars = G.GAME.current_round.hands_left
        }
    end
end
}

-- Blue Shoes
SMODS.Joker{
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
            [1] = '{C:blue}+200{} Chips',
            [2] = '{C:red}Self-destruct{} if',
            [3] = 'played {C:attention}poker hand{} has',
            [4] = 'already been played',
            [5] = 'this round'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = { x = 2, y = 0 },
    cost = 7,
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
SMODS.Joker{
    key = "earthquake",
    config = {
        extra = {
            mult = 0
        }
    },
    loc_txt = {
        ['name'] = 'Earthquake',
        ['text'] = {
            [1] = 'This Joker gains {C:red}+2{} Mult every',
            [2] = 'time a card is destroyed',
            [3] = '{C:inactive}(Currently {C:mult}#1#{} {C:inactive}Mult)'
        },
        ['unlock'] = {
            [1] = ''
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

-- Hatchet
SMODS.Joker{
    key = "hatchet",
    config = {
        extra = {
            xmult = 2.5
        }
    },
    loc_txt = {
        ['name'] = 'Hatchet',
        ['text'] = {
            [1] = '{X:red,C:white}X2.5{} Mult on {C:attention}first',
            [2] = '{C:attention}hand of round',
            [3] = 'Destroy scored cards'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = { x = 4, y = 0 },
    cost = 9,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    
    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card.should_destroy then
            return {
                remove = true
            }
        end
        if context.individual and context.cardarea == G.play then
            context.other_card.should_destroy = false
            if (G.GAME.current_round.hands_played == 0 and #context.full_hand >= 1) then
                context.other_card.should_destroy = true
                return {
                    message = "Destroyed!"
                }
            end
        end
        if context.joker_main then
            if G.GAME.current_round.hands_played == 0 then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end
}

-- Saving Grace
SMODS.Joker{
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
            [1] = 'Upgrade level of',
            [2] = 'played poker hand by 2',
            [3] = 'in {C:attention}final hand{} of the round',
            [4] = '{C:red,E:1}self destructs{}'
        },
        ['unlock'] = {
            [1] = ''
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
SMODS.Joker{
    key = "supersevens",
    config = {
        extra = {
            chips = 0
        }
    },
    loc_txt = {
        ['name'] = 'Super Sevens',
        ['text'] = {
            [1] = 'This Joker gains',
            [2] = '{C:chips}+7{} Chips when each',
            [3] = 'played {C:attention}7{} is scored',
            [4] = '{C:inactive}(Currently {C:blue}+#1#{C:inactive} Chips)'
        },
        ['unlock'] = {
            [1] = ''
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
SMODS.Joker{
    key = "sevensisters",
    config = {
        extra = {
            xmult = 2
        }
    },
    loc_txt = {
        ['name'] = 'Seven Sisters',
        ['text'] = {
            [1] = '{C:white,X:mult}X2{} Mult if played hand',
            [2] = 'has a scoring {C:attention}7{} and a',
            [3] = 'scoring card of any other rank'
        },
        ['unlock'] = {
            [1] = ''
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
            local valid_hand = has_seven and (#context.scoring_hand > 1) and not (all_sevens and #context.scoring_hand > 0)
            if valid_hand then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end
}

-- Diary Entry
SMODS.Joker{
    key = "diary_entry",
    config = {
        extra = {
            chips = 0
        }
    },
    loc_txt = {
        ['name'] = 'Diary Entry',
        ['text'] = {
            [1] = 'This Joker gains {C:chips}+30{} Chips per',
            [2] = '{C:attention}consecutive{} hand played without',
            [3] = 'playing your most played {C:attention}poker hand{}',
            [4] = '{C:inactive}(Currently {C:blue}+#1#{C:inactive} Chips)',
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = { x = 8, y = 0 },
    cost = 9,
    rarity = 3,
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
        if context.before and not context.blueprint then
            local function is_most_played_hand()
                local current_played = G.GAME.hands[context.scoring_name].played or 0
                for handname, values in pairs(G.GAME.hands) do
                    if handname ~= context.scoring_name and values.played > current_played and values.visible then
                        return false
                    end
                end
                return true
            end
            
            if not is_most_played_hand() then
                card.ability.extra.chips = card.ability.extra.chips + 30
            else
                card.ability.extra.chips = 0
                return {
                    message = "Reset!"
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

-- Black Joker
SMODS.Joker{
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
            [1] = 'When this card is sold, add',
            [2] = '{C:dark_edition}Negative{} to a random {C:attention}Joker',
            [3] = 'and {C:blue}-1{} hand per round'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = { x = 9, y = 0 },
    cost = 9,
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
        end
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
        ease_hands_played(-card.ability.extra.hands)
        return {
            message = "-"..tostring(card.ability.extra.hands).." Hand",
            colour = G.C.RED
        }
    end
}

-- Musketeer
SMODS.Joker{
    key = "musketeer",
    config = {
        extra = {
            investment = 0
        }
    },
    loc_txt = {
        ['name'] = 'Musketeer',
        ['text'] = {
            [1] = 'If played hand contains',
            [2] = 'a {C:attention}Three of a Kind{} and',
            [3] = 'a {C:attention}4{}, create an',
            [4] = '{C:attention}Investment Tag{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
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
    pools = { ["hatchet_hatchet_jokers"] = true },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS.tag_investment
        return { vars = {  } }
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
SMODS.Joker{
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
            [1] = 'First played {C:orange}face{} card gives',
            [2] = '{X:red,C:white}X1.5{} Mult when scored.',
            [3] = '{C:green}1 in 2{} chance to retrigger'
        },
        ['unlock'] = {
            [1] = ''
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
        if context.repetition and context.cardarea == G.play  then
            if (function()
                for i = 1, #context.scoring_hand do
                    local scoring_card = context.scoring_hand[i]
                    if scoring_card:is_face() then
                        return scoring_card == context.other_card
                        end
                    end
                    return false
                    end)() then
                        if SMODS.pseudorandom_probability(card, 'group_0_35e7c8fb', 1, card.ability.extra.odds, 'j_hatchet_oldphotograph', false) then
                            
                            return {repetitions = card.ability.extra.repetitions}
                        end
                    end
                end
                if context.individual and context.cardarea == G.play  then
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
SMODS.Joker{
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
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, { message = "Destroyed!", colour = G.C.RED })
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
SMODS.Joker{
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
            [1] = 'Create a {C:spectral}Spectral{} card at end of round',
            [2] = '{C:red}Self destructs{} if {C:attention}Blind{} is not',
            [3] = 'beaten in one hand'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
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

-- Tricky Joker
SMODS.Joker{
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
            [1] = 'Your {C:blue}Hands{} are set to',
            [2] = 'the number of {C:red}discards{} you',
            [3] = 'have per round'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
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
    pools = { ["hatchet_hatchet_jokers"] = true },
    
    calculate = function(self, card, context)
        if context.setting_blind  then
            return {
                func = function()
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Set to "..tostring(G.GAME.round_resets.discards).." Hands", colour = G.C.BLUE})
                    G.GAME.current_round.hands_left = G.GAME.round_resets.discards
                    return true
                    end
                }
            end
        end
}

-- Loss Leader
SMODS.Joker{
    key = "loss_leader",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Loss Leader',
        ['text'] = {
            [1] = 'All items in the shop are {C:attention}30%{} off'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = { x = 5, y = 1 },
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
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end
}

local card_set_cost_ref = Card.set_cost
function Card:set_cost()
    card_set_cost_ref(self)
    
    if next(SMODS.find_card("j_hatchet_lossleader")) then
        if (self.ability.set == 'Joker' or self.ability.set == 'Tarot' or self.ability.set == 'Planet' or self.ability.set == 'Spectral' or self.ability.set == 'Enhanced' or self.ability.set == 'Booster' or self.ability.set == 'Voucher') then
            self.cost = math.max(0, math.floor(self.cost * (1 - (30) / 100)))
        end
    end
    
    self.sell_cost = math.max(1, math.floor(self.cost / 2)) + (self.ability.extra_value or 0)
    self.sell_cost_label = self.facing == 'back' and '?' or self.sell_cost
end

-- Blue Card
SMODS.Joker{
    key = "blue_card",
    config = {
        extra = {
            chips = 0
        }
    },
    loc_txt = {
        ['name'] = 'Blue Card',
        ['text'] = {
            [1] = 'This Joker gains {C:chips}+10{} Chips when',
            [2] = 'any {C:orange}Booster Pack{} is skipped',
            [3] = '{C:inactive}(Currently {C:blue}+#1#{C:inactive} Chips)'
        },
        ['unlock'] = {
            [1] = ''
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
SMODS.Joker{
    key = "dakimakura",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Dakimakura',
        ['text'] = {
            [1] = 'If played hand contains a {C:attention}Flush{}',
            [2] = 'convert each card into',
            [3] = '{C:attention}random suits{}'
        },
        ['unlock'] = {
            [1] = ''
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
        if context.individual and context.cardarea == G.play  and not context.blueprint then
            if next(context.poker_hands["Flush"]) then
                assert(SMODS.change_base(context.other_card, pseudorandom_element(SMODS.Suits, 'edit_card_suit').key, nil))
                return {
                    message = "Card Modified!"
                    }
                end
            end
        end
}

-- Fortress
SMODS.Joker{
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
            [1] = '{C:red}+1{} Mult per discard',
            [2] = 'Resets if no discards',
            [3] = 'are used in a round',
            [4] = '{C:inactive}(Does not apply to {C:attention}The Water{C:inactive})'
        },
        ['unlock'] = {
            [1] = ''
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
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                mult = card.ability.extra.multvar
            }
        end
        if context.discard  then
            return {
                func = function()
                    card.ability.extra.multvar = (card.ability.extra.multvar) + 1
                    return true
                    end,
                    message = "+1 Mult"
                }
            end
        if context.end_of_round and context.game_over == false and context.main_eval  then
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
SMODS.Joker{
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
            [1] = '{C:green}#1# in 20{} chance to',
            [2] = 'earn {C:money}$20{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
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
    pools = { ["hatchet_hatchet_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_hatchet_d20') 
        return { vars = { new_numerator, new_denominator } }
    end,

    
    calculate = function(self, card, context)
    if context.end_of_round and context.game_over == false and context.main_eval  then
        if true then
            if SMODS.pseudorandom_probability(card, 'group_0_bb3f3a02', 1, card.ability.extra.odds, 'j_hatchet_d20', false) then
                    SMODS.calculate_effect({dollars = card.ability.extra.dollars}, card)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Rolled a 20!", colour = G.C.MONEY})
                end
            end
        end
    end
}

-- Risky Revolver
SMODS.Joker{
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
            [1] = '{C:green}1 in 6{} chance to give {X:red,C:white}X4{} Mult',
            [2] = '{C:green}1 in 6{} chance to destroy a random Joker',
            [3] = '{C:green}4 in 6{} chance to do nothing'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
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
    pools = { ["hatchet_hatchet_jokers"] = true },
    
    calculate = function(self, card, context)
        if context.joker_main  then
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

-- Sunset
SMODS.Joker{
    key = "sunset",
    config = {
        extra = {
            xchips = 2
        }
    },
    loc_txt = {
        ['name'] = 'Sunset',
        ['text'] = {
            [1] = 'On the first hand,',
            [2] = 'double all played {C:blue}chips{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
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
    pools = { ["hatchet_hatchet_jokers"] = true },
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if G.GAME.current_round.hands_played == 0 then
                return {
                    x_chips = card.ability.extra.xchips
                }
            end
        end
    end
}

-- Pizza
SMODS.Joker{
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
            [1] = '{C:blue}+80{} Chips',
            [2] = 'Lasts 8 rounds',
            [3] = '{C:inactive}(Used {C:attention}#1#{C:inactive} times)'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
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
    pools = { ["hatchet_hatchet_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.pizza}}
    end,

    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
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
            if context.after and context.cardarea == G.jokers  then
                return {
                    message = "-1 Slice"
                }
            end
        end
}

-- Roulette
SMODS.Joker{
    key = "roulette",
    config = {
        extra = {
            mult = 12
        }
    },
    loc_txt = {
        ['name'] = 'Roulette',
        ['text'] = {
            [1] = '{C:red}+12 {}Mult if played hand has a {C:attention}#1#{},',
            [2] = 'suit changes at end of round'
        },
        ['unlock'] = {
            [1] = ''
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
        
        return {vars = {localize((G.GAME.current_round.suitvar_card or {}).suit or 'Spades', 'suits_singular')}, colours = {G.C.SUITS[(G.GAME.current_round.suitvar_card or {}).suit or 'Spades']}}
    end,

    set_ability = function(self, card, initial)
        G.GAME.current_round.suitvar_card = { suit = 'Spades' }
    end,

    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
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
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
            if G.playing_cards then
                local valid_suitvar_cards = {}
                for _, v in ipairs(G.playing_cards) do
                    if not SMODS.has_no_suit(v) then
                        valid_suitvar_cards[#valid_suitvar_cards + 1] = v
                    end
                end
                if valid_suitvar_cards[1] then
                    local suitvar_card = pseudorandom_element(valid_suitvar_cards, pseudoseed('suitvar' .. G.GAME.round_resets.ante))
                    G.GAME.current_round.suitvar_card.suit = suitvar_card.base.suit
                end
            end
        end
    end
}

-- Pickpocket
SMODS.Joker{
    key = "pickpocket",
    config = {
        extra = {
            coupon = 0
        }
    },
    loc_txt = {
        ['name'] = 'Pickpocket',
        ['text'] = {
            [1] = 'Sell this card to create a',
            [2] = 'free {C:attention}Coupon Tag{}'
        },
        ['unlock'] = {
            [1] = ''
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
        return { vars = {  } }
    end,
    
    calculate = function(self, card, context)
        if context.selling_self  and not context.blueprint then
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
SMODS.Joker{
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
            [1] = '{X:red,C:white}X3{} Mult if poker hand does {C:attention}not{}',
            [2] = 'contain a {C:attention}#1#{}, poker hand',
            [3] = 'changes at the end of round.',
            [4] = 'If {C:attention}#1#{} is played, {C:red}self destruct{}'
        },
        ['unlock'] = {
            [1] = ''
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
        
        return {vars = {G.GAME.current_round.pokervar_hand}}
    end,

    set_ability = function(self, card, initial)
        G.GAME.current_round.pokervar_hand = 'High Card'
    end,

    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
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
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
            local pokervar_hands = {}
            for handname, _ in pairs(G.GAME.hands) do
                if G.GAME.hands[handname].visible then
                    pokervar_hands[#pokervar_hands + 1] = handname
                end
            end
            if pokervar_hands[1] then
                G.GAME.current_round.pokervar_hand = pseudorandom_element(pokervar_hands, pseudoseed('pokervar' .. G.GAME.round_resets.ante))
            end
        end
    end
}

-- Stock Exchange
SMODS.Joker{
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
            [1] = 'Earn {C:money}$5{} for each',
            [2] = 'remaining {C:attention}discard{}',
            [3] = '{X:red,C:white}X0.5{} Mult per hand',
            [4] = ''
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
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
    pools = { ["hatchet_hatchet_jokers"] = true },

    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    if context.end_of_round and context.game_over == false and context.main_eval  then
        return {
            dollars = (G.GAME.current_round.hands_left) * 5
        }
    end
end
}

-- Ace in the Hole
SMODS.Joker{
    key = "aceinthehole",
    config = {
        extra = {
            chips = 100
        }
    },
    loc_txt = {
        ['name'] = 'Ace in the Hole',
        ['text'] = {
            [1] = 'Each {C:orange}Ace{} held in hand gives {C:blue}+100{} Chips'
        },
        ['unlock'] = {
            [1] = ''
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
    if context.individual and context.cardarea == G.hand and not context.end_of_round  then
        if context.other_card:get_id() == 14 then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
end
}

-- Witch
SMODS.Joker{
    key = "witch",
    config = {
        extra = {
            xmultvar = 1
        }
    },
    loc_txt = {
        ['name'] = 'Witch',
        ['text'] = {
            [1] = 'This Joker gains {X:red,C:white}X0.1{} Mult for every unplayed hand',
            [2] = '{C:inactive}(Currently{} {X:red,C:white}X#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = ''
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
        
        return {vars = {card.ability.extra.xmultvar}}
    end,

    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = card.ability.extra.xmultvar
            }
        end
    if context.end_of_round and context.game_over == false and context.main_eval  then
        if true then
            for i = 1, G.GAME.current_round.hands_left do
                    SMODS.calculate_effect({func = function()
                        card.ability.extra.xmultvar = (card.ability.extra.xmultvar) + 0.1
                        return true
                        end}, card)
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "x0.1 Mult", colour = G.C.GREEN})
                    end
                end
            end
        end
}

-- Night Vision
SMODS.Joker{
    key = "nightvision",
    config = {
        extra = {
            xmult = 1
        }
    },
    loc_txt = {
        ['name'] = 'Night Vision',
        ['text'] = {
            [1] = '{X:red,C:white}X0.25{} Mult if poker hand has {C:attention}not{}',
            [2] = 'already been played during round',
            [3] = 'Resets per {C:attention}Ante{}',
            [4] = '{C:inactive}(Currently{} {X:red,C:white}X#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
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
    pools = { ["hatchet_hatchet_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.xmult}}
    end,

    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if not (G.GAME.hands[context.scoring_name] and G.GAME.hands[context.scoring_name].played_this_round > 1) then
                card.ability.extra.xmult = (card.ability.extra.xmult) + 0.25
            else
                return {
                    Xmult = card.ability.extra.xmult
                }
            end
        end
        if context.ante_change  then
            return {
                func = function()
                    card.ability.extra.xmult = 1
                    return true
                    end
                }
            end
        end
}

-- Composter
SMODS.Joker{
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
            [1] = 'Gain {C:money}$1{} per card {C:attention}destroyed{}',
            [2] = 'at the end of round'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
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
    pools = { ["hatchet_hatchet_jokers"] = true },

    
    calculate = function(self, card, context)
    if context.end_of_round and context.game_over == false and context.main_eval  then
        return {
            dollars = (G.GAME.starting_deck_size - #(G.playing_cards or {}))
        }
    end
end
}

-- Nine Lives
SMODS.Joker{
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
            [1] = 'Every {C:attention}9{} held in hand gives {C:red}+9{} Mult',
            [2] = '{C:attention}Self destructs{} after nine rounds',
            [3] = '{C:inactive}(Used #1# times){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
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
    pools = { ["hatchet_hatchet_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.ninelives}}
    end,

    
    calculate = function(self, card, context)
    if context.individual and context.cardarea == G.hand and not context.end_of_round  then
        if context.other_card:get_id() == 9 then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
    if context.cardarea == G.jokers and context.joker_main  then
        if (card.ability.extra.ninelives or 0) >= 9 then
            return {
                func = function()
                    card:start_dissolve()
                    return true
                    end
                }
            end
        end
    if context.end_of_round and context.game_over == false and context.main_eval  then
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
SMODS.Joker{
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
            [1] = '{C:red}+20{} Mult',
            [2] = '{C:money}-$20{} {C:attention}sell value{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
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
    pools = { ["hatchet_hatchet_jokers"] = true },

    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.selling_self  then
            return {
                dollars = -card.ability.extra.dollars
            }
        end
    end
}

-- No Dice
SMODS.Joker{
    key = "nodice",
    config = {
        extra = {
            mult = 3,
            mult2 = 3,
            mult3 = 3,
            mult4 = 3,
            mult5 = 3,
            mult6 = 3,
            set_probability = 6,
            set_probability2 = 1000,
            set_probability3 = 0,
            set_probability4 = 0,
            set_probability5 = 0,
            set_probability6 = 4,
            set_probability7 = 7,
            set_probability8 = 0,
            set_probability9 = 2,
            set_probability10 = 0,
            numerator = 0,
            denominator = 0
        }
    },
    loc_txt = {
        ['name'] = 'No Dice',
        ['text'] = {
            [1] = 'Each played {C:attention}A{}, {C:attention}2{}, {C:attention}3{}, {C:attention}4{}, {C:attention}5{}, {C:attention}6{}',
            [2] = 'give {C:red}+3{} Mult when scored',
            [3] = 'All {C:attention}successful {}{C:green}probabilities{} fail',
            [4] = ''
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
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
    pools = { ["hatchet_hatchet_jokers"] = true },

    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
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
        if context.fix_probability  then
            local numerator, denominator = context.numerator, context.denominator
            if context.identifier == "gros_michel" then
                numerator = card.ability.extra.set_probability
            elseif context.identifier == "cavendish" then
                numerator = card.ability.extra.set_probability2
            elseif (context.identifier == "bloodstone" or context.identifier == "halu1" or context.identifier == "parking" or context.identifier == "space" or context.identifier == "space" or context.identifier == "8ball") then
                numerator = card.ability.extra.set_probability3
            elseif context.identifier == "wheel_of_fortune" then
                numerator = card.ability.extra.set_probability4
            elseif (context.identifier == "lucky_money" or context.identifier == "lucky_mult") then
                numerator = card.ability.extra.set_probability5
            elseif context.identifier == "glass" then
                numerator = card.ability.extra.set_probability6
            elseif context.identifier == "wheel" then
                numerator = card.ability.extra.set_probability7
            elseif (context.identifier == "j_hatchet_d20" or context.identifier == "j_hatchet_riskyrevolver" or context.identifier == "j_hatchet_staircase" and context.identifier == "j_hatchet_airmissile") then
                numerator = card.ability.extra.set_probability8
            elseif context.identifier == "j_hatchet_wheelbarrow" then
                numerator = card.ability.extra.set_probability9
            elseif context.identifier == "j_hatchet_snakeeyes" then
                denominator = card.ability.extra.set_probability10
            end
            return {
                numerator = numerator, 
                denominator = denominator
            }
        end
    end
}

-- Sailor
SMODS.Joker{
    key = "sailor",
    config = {
        extra = {
            goldchips = 0
        }
    },
    loc_txt = {
        ['name'] = 'Sailor',
        ['text'] = {
            [1] = 'Played {C:attention}Gold{} Cards',
            [2] = 'add {C:blue}20{} Chips when scored',
            [3] = '(Currently {C:blue}#1#{} Chips)'
        },
        ['unlock'] = {
            [1] = ''
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
        
        return {vars = {card.ability.extra.goldchips}}
    end,

    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                chips = card.ability.extra.goldchips
            }
        end
        if context.individual and context.cardarea == G.play  then
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
SMODS.Joker{
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
            [1] = 'All {C:attention}listed {C:green,E:1}denominators',
            [2] = 'are set to {C:attention}2'
        },
        ['unlock'] = {
            [1] = ''
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
        if context.fix_probability  then
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
SMODS.Joker{
    key = "wheelbarrow",
    config = {
        extra = {
            multvar = 1
        }
    },
    loc_txt = {
        ['name'] = 'Wheelbarrow',
        ['text'] = {
            [1] = 'Gains {X:red,C:white}X0.2{} Mult per round',
            [2] = '{C:green}1 in 2{} cards get drawn face down',
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
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)   
        local numerator, denominator = SMODS.get_probability_vars(self, 1, 2, 'wheelbarrow')
        return {vars = {numerator, denominator, card.ability.extra.multvar}}
    end,

    collection_loc_vars = function(self)
        return { vars = { '1' } }
    end,

    calculate = function(self, card, context)
            if context.stay_flipped and context.to_area == G.hand and
                SMODS.pseudorandom_probability(card, 'wheelbarrow', 1, 2) then
                return {
                    stay_flipped = true
                }
            end
        if context.end_of_round and context.game_over == false and context.main_eval  then
            return {
                func = function()
                    card.ability.extra.multvar = (card.ability.extra.multvar) + 0.5
                    return true
                end
            }
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = card.ability.extra.multvar
            }
        end
    end,
    disable = function(self)
        for i = 1, #G.hand.cards do
            if G.hand.cards[i].facing == 'back' then
                G.hand.cards[i]:flip()
            end
        end
        for _, playing_card in pairs(G.playing_cards) do
            playing_card.ability.wheel_flipped = nil
        end
    end
}

-- Love Letter
SMODS.Joker{
    key = "loveletter",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Love Letter',
        ['text'] = {
            [1] = 'On the {C:attention}final hand{} of a round,',
            [2] = 'if a {C:attention}High Card{} is played,',
            [3] = 'add {C:dark_edition}Polychrome{} to it'
        },
        ['unlock'] = {
            [1] = ''
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
    pools = { ["hatchet_hatchet_jokers"] = true },

    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
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
SMODS.Joker{
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
            [1] = 'Every played {C:attention}face card{} has a {C:green}#2# in #3#{} chance',
            [2] = 'to create a {C:green}Sephirot{} card',
            [3] = '{C:inactive}(Must have room){}'
        },
        ['unlock'] = {
            [1] = ''
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
    pools = { ["hatchet_hatchet_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_hatchet_staircase') 
        return {vars = {card.ability.extra.n, new_numerator, new_denominator}}
    end,

    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:is_face() then
                if SMODS.pseudorandom_probability(card, 'group_0_8534ce80', 1, card.ability.extra.odds, 'j_hatchet_staircase', false) then
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
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = created_consumable and localize('k_plus_consumable') or nil, colour = G.C.PURPLE})
                end
            end
        end
    end
}

-- Graveyard Shift
SMODS.Joker{
    key = "graveyardshift",
    config = {
        extra = {
            discards = 0
        }
    },
    loc_txt = {
        ['name'] = 'Graveyard Shift',
        ['text'] = {
            [1] = 'Gain {C:red}+1{} Mult per {C:attention}discarded{} card.',
            [2] = 'On the {C:attention}final hand{} of the round, apply',
            [3] = 'the total Mult. Resets per {C:attention}round{}',
            [4] = '{C:inactive}(Currently {C:red}+#1#{C:inactive} Mult)'
        },
        ['unlock'] = {
            [1] = ''
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
    pools = { ["hatchet_hatchet_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.discards}}
    end,

    
    calculate = function(self, card, context)
        if context.discard  then
            return {
                func = function()
                    card.ability.extra.discards = (card.ability.extra.discards) + 1
                    return true
                    end,
                    message = "+1"
                }
            end
            if context.cardarea == G.jokers and context.joker_main  then
                if G.GAME.current_round.hands_left == 0 then
                    return {
                        mult = card.ability.extra.discards
                    }
                end
            end
        if context.end_of_round and context.game_over == false and context.main_eval  then
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
SMODS.Joker{
    key = "plantparty",
    config = {
        extra = {
            xmult = 1
        }
    },
    loc_txt = {
        ['name'] = 'Plant Party',
        ['text'] = {
            [1] = 'All face cards are debuffed',
            [2] = '{X:red,C:white}X0.2{} Mult for each {C:attention}played hand {}',
            [3] = '{C:inactive}(Currently{} {X:red,C:white}X#1#{}{}{C:inactive} Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
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
        
        return {vars = {card.ability.extra.xmult}}
    end,
    
    calculate = function(self, card, context)
        if context.debuff_card and context.debuff_card:is_face() then
        return { debuff = true }
        end
        if context.cardarea == G.jokers and context.joker_main  then
            card.ability.extra.xmult = (card.ability.extra.xmult) + 0.2
            return {
                Xmult = card.ability.extra.xmult
            }
        end
    end
}

-- Air Missile
SMODS.Joker{
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
            [1] = '{C:green}#2# in #3#{} chance to downgrade',
            [2] = 'level of played {C:attention}poker hand{}',
            [3] = 'and gain {X:red,C:white}X0.5{} Mult',
            [4] = '{C:inactive}(Currently{} {X:red,C:white}X#1#{}{}{C:inactive} Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
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
    pools = { ["hatchet_hatchet_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_hatchet_airmissile') 
        return {vars = {card.ability.extra.xmult, new_numerator, new_denominator}}
    end,

    
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_f9f9ec2e', 1, card.ability.extra.odds, 'j_hatchet_airmissile', false) then
                    local target_hand = (context.scoring_name or "High Card")
                        SMODS.calculate_effect({level_up = card.ability.extra.levels,
                    level_up_hand = target_hand}, card)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_level_up_ex'), colour = G.C.RED})
                        SMODS.calculate_effect({func = function()
                            card.ability.extra.xmult = (card.ability.extra.xmult) + 0.5
                            return true
                            end}, card)
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "x0.5", colour = G.C.GREEN})
                        end
                    end
                end
                if context.cardarea == G.jokers and context.joker_main  then
                    return {
                        Xmult = card.ability.extra.xmult
                    }
                end
            end
}

-- Wildside
SMODS.Joker{
    key = "wildside",
    config = {
        extra = {
            repetitions = 1
        }
    },
    loc_txt = {
        ['name'] = 'Wildside',
        ['text'] = {
            [1] = 'Retrigger each',
            [2] = 'played {C:attention}Wild Card{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
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
    pools = { ["hatchet_hatchet_jokers"] = true },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
        return { vars = {  } }
    end,
    
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play  then
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
SMODS.Joker{
    key = "cave",
    config = {
        extra = {
            Xmult = 1.5
        }
    },
    loc_txt = {
        ['name'] = 'Cave',
        ['text'] = {
            [1] = 'Each {C:attention}Stone{} card held in',
            [2] = 'hand gives {X:red,C:white}X1.5{} Mult'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
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
    pools = { ["hatchet_hatchet_jokers"] = true },

    
    calculate = function(self, card, context)
    if context.individual and context.cardarea == G.hand and not context.end_of_round  then
        if SMODS.get_enhancements(context.other_card)["m_stone"] == true then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
end
}

-- Giraffe
SMODS.Joker{
    key = "giraffe",
    config = {
        extra = {
            chips = 0
        }
    },
    loc_txt = {
        ['name'] = 'Giraffe',
        ['text'] = {
            [1] = '{C:blue}+50{} Chips per {C:attention}reroll{} this run',
            [2] = '{C:inactive}(Currently {C:blue}+#1#{C:inactive} Chips)'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
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
    pools = { ["hatchet_hatchet_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.chips}}
    end,

    
    calculate = function(self, card, context)
        if context.reroll_shop  then
            return {
                func = function()
                    card.ability.extra.chips = (card.ability.extra.chips) + 50
                    return true
                    end,
                    message = "+50"
                }
            end
            if context.cardarea == G.jokers and context.joker_main  then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
}

-- Divine Hatchet
SMODS.Joker{
    key = "divine_hatchet",
    config = {
        extra = {
            divine = 0,
            xmult = 4,
        }
    },
    loc_txt = {
        ['name'] = 'Divine Hatchet',
        ['text'] = {
            [1] = '{C:white,X:mult}X4{} Mult',
            [2] = 'Destroy scored cards',
            [3] = '{C:inactive}(Used {C:attention}#1#{C:inactive} of {C:attention}5{C:inactive} times)'
        },
        ['unlock'] = {
            [1] = 'Evolve Hatchet'
        }
    },
    pos = { x = 7, y = 4 },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = false,
    discovered = false,
    atlas = 'CustomJokers',
    soul_pos = { x = 8, y = 4 },
    
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.divine } }
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            context.other_card.should_destroy = false
            if to_big(#context.full_hand) >= to_big(1) then
                context.other_card.should_destroy = true
                return {
                    message = "Destroyed!"
                }
            end
        end
        if context.destroy_card and context.destroy_card.should_destroy then
            return {
                remove = true
            }
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval then
            if (to_big((card.ability.extra.divine or 0)) + 1) >= to_big(5) then
                card.ability.extra.divine = card.ability.extra.divine + 1
                local target_joker = card
                if target_joker then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound("tarot1")
                            card.T.r = -0.2
                            card:juice_up(0.3, 0.4)
                            card.states.drag.is = true
                            card.children.center.pinch.x = true
                            G.E_MANAGER:add_event(Event({
                                trigger = "after",
                                delay = 0.3,
                                blockable = false,
                                func = function()
                                    G.jokers:remove_card(card)
                                    card:remove()
                                    card = nil
                                    return true
                                end,
                            }))
                            return true
                        end,
                    }))
                    if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                        G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_hatch_hatchet")
                                card:add_to_deck()
                                card:start_materialize()
                                G.jokers:emplace(card)
                                return true
                            end
                        }))
                    end
                    return {
                        message = "Destroyed!",
                        colour = G.C.RED
                    }
                end
            else
                card.ability.extra.divine = card.ability.extra.divine + 1
                return {
                    message = "Losing energy...",
                    colour = G.C.DARK_EDITION
                }
            end
        end
    end
}

-- Etz Chaim
SMODS.Joker{
    key = "etzchaim",
    config = {
        extra = {
            xmult = 1
        }
    },
    loc_txt = {
        ['name'] = 'Etz Chaim',
        ['text'] = {
            [1] = '{X:red,C:white}X1{} Mult per consumable used',
            [2] = '(Currently {X:red,C:white}X#1#{} Mult)'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 5,
        y = 4
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 20,
    rarity = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = false,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["hatchet_hatchet_jokers"] = true },
    soul_pos = {
        x = 6,
        y = 4
    },
    in_pool = function(self, args)
          return (
          not args 
          or args.source ~= 'sho' and args.source ~= 'buf' and args.source ~= 'jud' and args.source ~= 'sou' 
          or args.source == 'rif' or args.source == 'rta' or args.source == 'uta' or args.source == 'wra'
          )
          and true
      end,

    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.xmult}}
    end,

    
    calculate = function(self, card, context)
        if context.using_consumeable  then
            return {
                func = function()
                    card.ability.extra.xmult = (card.ability.extra.xmult) + 1
                    return true
                    end,
                    extra = {
                    message = "X1",
                    colour = G.C.RED
                }
            }
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = card.ability.extra.xmult
            }
        end
    end
}

local check_for_buy_space_ref = G.FUNCS.check_for_buy_space
G.FUNCS.check_for_buy_space = function(card)
    if card.config.center.key == "j_hatchet_etzchaim" then -- ignore slot limit when bought
        return true
    end
    return check_for_buy_space_ref(card)
end

local can_select_card_ref = G.FUNCS.can_select_card
G.FUNCS.can_select_card = function(e)
	if e.config.ref_table.config.center.key == "j_hatchet_etzchaim" then
		e.config.colour = G.C.GREEN
		e.config.button = "use_card"
	else
		can_select_card_ref(e)
	end
end