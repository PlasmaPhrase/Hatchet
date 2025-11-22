-- Massacre
SMODS.Challenge {
    key = 'massacre',
    jokers = {
        { id = 'j_hatch_hatchet', eternal = true },
        { id = 'j_certificate', eternal = true },
    },
    loc_txt = {
        ['name'] = 'Massacre',
        ['text'] = {
            [1] = 'Hatchet and Certificate are eternal',
        },
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
            { id = 'j_dna'},
            { id = 'marble_joker'},
            { id = 'v_magic_trick'},
            { id = 'v_illusion'},
            { id = 'c_cryptid'},
        },
        banned_tags = {
            { id = 'tag_standard' },
        }
    },
}

-- Debug 1
SMODS.Challenge {
    key = 'debug1',
    jokers = {
        { id = 'j_hatch_plantparty' },
    },
    loc_txt = {
        ['name'] = 'Debug 1',
        ['text'] = {
            [1] = 'Debug Challenge',
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
}

-- Debug 2
SMODS.Challenge {
    key = 'debug2',
    jokers = {
        { id = 'j_hatch_wheelbarrow' },
    },
    loc_txt = {
        ['name'] = 'Debug 2',
        ['text'] = {
            [1] = 'Debug Challenge',
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
        deck = {
        type = 'Challenge Deck',
    deck = {
        type = 'Challenge Deck',
        cards = {
            { s = 'C', r = 'K' },
            { s = 'C', r = 'K' },
            { s = 'D', r = 'K' },
            { s = 'D', r = 'K' },
        }
    }
}
}