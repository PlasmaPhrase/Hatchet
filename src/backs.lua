-- Orange Deck
SMODS.Back {
    key = 'orange_deck',
    pos = { x = 0, y = 0 },
    config = {hand_size = -2, discards = 2},
    loc_txt = {
        name = 'Orange Deck',
        text = {
            [1] = '{C:attention}-2{} hand size',
            [2] = '{C:red}+2{} discards every round'
        },
    },
    unlocked = true,
    discovered = true,
    no_collection = false,
    atlas = 'CustomDecks',
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.hand_size, self.config.discards } }
    end,
}

-- Holy Deck
SMODS.Back {
    key = 'holy_deck',
    pos = { x = 1, y = 0 },
    config = { sephirot_rate = 2, consumables = { 'c_hatch_kether' }  },
    loc_txt = {
        name = 'Holy Deck',
        text = {
            [1] = '{C:green}Sephirot{} cards may appear in the',
            [2] = 'shop, start with a {C:green}Kether{} card'
        },
    },
    unlocked = true,
    atlas = 'CustomDecks',

    apply = function(self, back)
        -- Apply the spectral rate
        G.GAME.sephirot_rate = self.config.sephirot_rate
    end,
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.sephirot_rate, self.config.consumables[1] } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'win_stake' and get_deck_win_stake() >= 10
    end
}

-- Indigo Deck
SMODS.Back {
    key = 'indigo_deck',
    pos = { x = 2, y = 0 },
    loc_txt = {
        name = 'Indigo Deck',
        text = {
            [1] = '{C:attention}+1{} booster pack per shop',
        },
    },
    unlocked = false,
    no_collection = false,
    atlas = 'CustomDecks',

    apply = function(self, back)
        SMODS.change_booster_limit(1)
    end,

    check_for_unlock = function(self, args)
        return args.type == 'win_stake' and get_deck_win_stake() >= 9
    end
}

-- Violet Deck
SMODS.Back {
    key = 'violet_deck',
    pos = { x = 3, y = 0 },
    config = {hands = 1, discards = 1, ante_scaling = 2},
    loc_txt = {
        name = 'Violet Deck',
        text = {
            [1] = '{C:chips}+1{} hand and {C:mult}+1{}',
            [2] = 'discard every round',
            [3] = '{C:attention}X2{} base Blind size'
        },
    },
    unlocked = false,
    no_collection = false,
    atlas = 'CustomDecks',

    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.hands, self.config.discards, self.config.ante_scaling } }
    end,

    check_for_unlock = function(self, args)
        return args.type == 'win_stake' and get_deck_win_stake() >= 10
    end
}