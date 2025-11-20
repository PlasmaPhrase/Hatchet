-- The Axe
SMODS.Blind {
    key = "hatch_axe",
    dollars = 5,
    mult = 2,
    pos = { x = 0, y = 0 },
    boss = { min = 1 },
    boss_colour = HEX("b6315e"),
    atlas = 'CustomBlinds',

    loc_txt = {
        ['name'] = 'The Axe',
        ['text'] = {
            [1] = 'Destroy first played card',
            [2] = 'after every played hand',
        },
    },

    calculate = function(self, blind, context)
    if not blind.disabled then
        if context.destroy_card and context.destroy_card.should_destroy  then
            return { remove = true }
        end
        if context.individual and context.cardarea == G.play  then
            context.other_card.should_destroy = false
            if context.other_card == context.scoring_hand[1] then
                context.other_card.should_destroy = true
                return {
                    message = "Destroyed!"
                }
            end
        end
    end
end
}

-- The Sack
SMODS.Blind {
    key = "hatch_sack",
    dollars = 5,
    mult = 2,
    pos = { x = 0, y = 1 },
    boss = { min = 1 },
    boss_colour = HEX("6caa70"),
    atlas = 'CustomBlinds',

    loc_txt = {
        ['name'] = 'The Sack',
        ['text'] = {
            [1] = 'Scored cards downgrade',
            [2] = 'by rank each hand played',
        },
    },

    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.individual and context.cardarea == G.play  then
                assert(SMODS.modify_rank(context.other_card, -1))
                return {
                    message = "Downgrade!"
                }
            end
        end
end
}

-- The Gun
SMODS.Blind {
    key = "hatch_gun",
    dollars = 5,
    mult = 2,
    pos = { x = 0, y = 2 },
    boss = { min = 1 },
    boss_colour = HEX("cbb9a3"),
    atlas = 'CustomBlinds',

    loc_vars = function(self)
        local numerator, denominator = SMODS.get_probability_vars(self, 1, 6, 'vremade_gun')
        return { vars = { numerator, denominator } }
    end,
    collection_loc_vars = function(self)
        return { vars = { '1' } }
    end,

    loc_txt = {
        ['name'] = 'The Gun',
        ['text'] = {
            [1] = '#1# in #2# chance to',
            [2] = 'destroy a random Joker',
        },
    },

        calculate = function(self, blind, context)
            if not blind.disabled then
                if context.before then
                    if true then
                        if SMODS.pseudorandom_probability(blind, 'vremade_gun', 1, 6) then
                            local destructable_jokers = {}
                            for i, joker in ipairs(G.jokers.cards) do
                                if joker ~= hand and not SMODS.is_eternal(joker) and not joker.getting_sliced then
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
                                card_eval_status_text(context.blueprint_card or blind, 'extra', nil, nil, nil, {message = "Destroyed!", colour = G.C.RED})
                            end
                        end
                    end
                end
            end
    end
}

-- The String
SMODS.Blind {
    key = "hatch_string",
    config = {
        extra = {
            currenthandsize = 0,
            hand_size = 1
        }
    },
    dollars = 5,
    mult = 2,
    pos = { x = 0, y = 3 },
    boss = { min = 1 },
    boss_colour = HEX("a652c0"),
    atlas = 'CustomBlinds',

    loc_txt = {
        ['name'] = 'The String',
        ['text'] = {
            [1] = 'Decrease hand size',
            [2] = 'per played hand',
        },
    },

    loc_vars = function(self, info_queue, blind)
        return {vars = {((G.hand and G.hand.config.card_limit or 0) or 0)}}
    end,

    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.before then
                return {
                    func = function()
                        G.hand:change_size(-1)
                        return true
                    end
                }
            end
            if context.end_of_round and context.game_over == false and context.main_eval  then
                return { 
                    func = function()
                        G.hand:change_size(current_hand_size)
                        return true
                    end
                }
            end
        end
end
}

-- The Claw
SMODS.Blind {
    key = "hatch_claw",
    config = {
        extra = {
            play_size = 5
        }
    },
    dollars = 5,
    mult = 2,
    pos = { x = 0, y = 4 },
    boss = { min = 1 },
    boss_colour = HEX("6899ff"),
    atlas = 'CustomBlinds',

    loc_txt = {
        ['name'] = 'The Claw',
        ['text'] = {
            [1] = 'Decrease play size',
            [2] = 'per discard',
            [3] = '(resets after Boss is defeated)',
        },
    },

    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.pre_discard  then
                return {
                    func = function()
                        SMODS.change_play_limit(-1)
                        return true
                    end
                }
            end
            if context.end_of_round and context.game_over == false and context.main_eval  then
                return {
                    func = function()
                        SMODS.change_play_limit((-G.GAME.starting_params.play_limit)+5)
                        return true
                    end
                }
            end
        end
end
}