-- Massacre
SMODS.Challenge {
    key = 'massacre',
    jokers = {
        { id = 'j_hatch_hatchet', eternal = true },
        { id = 'j_certificate',   eternal = true },
    },
    loc_txt = {
        ['name'] = 'Massacre',
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    restrictions = {
        banned_cards = {
            { id = 'p_standard_normal_1', ids = {
                'p_standard_normal_1', 'p_standard_normal_2',
                'p_standard_normal_3', 'p_standard_normal_4',
                'p_standard_jumbo_1', 'p_standard_jumbo_2',
                'p_standard_mega_1', 'p_standard_mega_2', }
            },
            { id = 'j_dna' },         -- Jokers
            { id = 'j_marble' },
            { id = 'v_magic_trick' }, -- Vouchers
            { id = 'v_illusion' },
            { id = 'c_cryptid' },     -- Spectrals
            { id = 'c_incantation' },
            { id = 'c_grim' },
            { id = 'c_familiar' },
        },
        banned_tags = {
            { id = 'tag_standard' },
        },
    },
}

-- Upside Down
SMODS.Challenge {
    key = 'upsidedown',
    jokers = {
        { id = 'j_oops',             eternal = true, edition = 'negative' },
        { id = 'j_oops',             eternal = true, edition = 'negative' },
        { id = 'j_hatch_topsyturvy', eternal = true },
    },
    loc_txt = {
        ['name'] = 'Upside Down',
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
}

-- Pillow Fight
SMODS.Challenge {
    key = 'pillowfight',
    jokers = {
        { id = 'j_hatch_dakimakura', eternal = true },
    },
    loc_txt = {
        ['name'] = 'Pillow Fight',
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    deck = {
        type = 'Challenge Deck',
        cards = {
            { s = 'S', r = 'K' },
            { s = 'S', r = 'Q' },
            { s = 'S', r = 'J' },
            { s = 'S', r = 'T' },
            { s = 'S', r = '9' },
            { s = 'S', r = '8' },
            { s = 'S', r = '7' },
            { s = 'S', r = '6' },
            { s = 'S', r = '5' },
            { s = 'S', r = '4' },
            { s = 'S', r = '3' },
            { s = 'S', r = '2' },
            { s = 'S', r = 'A' },     -- Spade Deck 1
            { s = 'S', r = 'K' },
            { s = 'S', r = 'Q' },
            { s = 'S', r = 'J' },
            { s = 'S', r = 'T' },
            { s = 'S', r = '9' },
            { s = 'S', r = '8' },
            { s = 'S', r = '7' },
            { s = 'S', r = '6' },
            { s = 'S', r = '5' },
            { s = 'S', r = '4' },
            { s = 'S', r = '3' },
            { s = 'S', r = '2' },
            { s = 'S', r = 'A' },     -- Spade Deck 2
            { s = 'S', r = 'K' },
            { s = 'S', r = 'Q' },
            { s = 'S', r = 'J' },
            { s = 'S', r = 'T' },
            { s = 'S', r = '9' },
            { s = 'S', r = '8' },
            { s = 'S', r = '7' },
            { s = 'S', r = '6' },
            { s = 'S', r = '5' },
            { s = 'S', r = '4' },
            { s = 'S', r = '3' },
            { s = 'S', r = '2' },
            { s = 'S', r = 'A' },     -- Spade Deck 3
            { s = 'S', r = 'K' },
            { s = 'S', r = 'Q' },
            { s = 'S', r = 'J' },
            { s = 'S', r = 'T' },
            { s = 'S', r = '9' },
            { s = 'S', r = '8' },
            { s = 'S', r = '7' },
            { s = 'S', r = '6' },
            { s = 'S', r = '5' },
            { s = 'S', r = '4' },
            { s = 'S', r = '3' },
            { s = 'S', r = '2' },
            { s = 'S', r = 'A' },     -- Spade Deck 4
        },
    },

    restrictions = {
        banned_cards = {
            { id = 'p_standard_normal_1', ids = { -- Booster Packs
                'p_standard_normal_1', 'p_standard_normal_2',
                'p_standard_normal_3', 'p_standard_normal_4',
                'p_standard_jumbo_1', 'p_standard_jumbo_2',
                'p_standard_mega_1', 'p_standard_mega_2', }
            },
            { id = 'j_dna' }, -- Jokers
            { id = 'j_marble' },
            { id = 'j_certificate' },
            { id = 'j_arrowhead' },
            { id = 'j_bloodstone' },
            { id = 'j_onyx_agate' },
            { id = 'j_rough_gem' },
            { id = 'j_greedy_joker' },
            { id = 'j_lusty_joker' },
            { id = 'j_wrathful_joker' },
            { id = 'j_gluttenous_joker' },
            { id = 'c_lovers' },      -- Tarots
            { id = 'c_tower' },
            { id = 'c_sun' },
            { id = 'c_moon' },
            { id = 'c_star' },
            { id = 'c_world' },
            { id = 'v_magic_trick' }, -- Vouchers
            { id = 'v_illusion' },
            { id = 'c_cryptid' },     -- Spectrals
            { id = 'c_incantation' },
            { id = 'c_grim' },
            { id = 'c_familiar' },
            { id = 'c_hatch_daat' } -- Divine
        },
        banned_tags = {
            { id = 'tag_standard' }, -- Tags
        }
    }
}

-- Stock Market
SMODS.Challenge {
    key = 'stockmarket',
    rules = {
        modifiers = {
            { id = 'dollars', value = 10 },
        }
    },
    jokers = {
        { id = 'j_hatch_slipperyslope', eternal = true },
        { id = 'j_hatch_handsdown',   eternal = true },
    },
    loc_txt = {
        ['name'] = 'Stock Market',
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
}