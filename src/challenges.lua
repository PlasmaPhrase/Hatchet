-- Massacre
SMODS.Challenge {
    key = 'massacre',
    jokers = {
        { id = 'j_hatch_hatchet', eternal = true },
        { id = 'j_certificate', eternal = true },
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
            { id = 'j_dna'},
            { id = 'j_marble'},
            { id = 'v_magic_trick'},
            { id = 'v_illusion'},
            { id = 'c_cryptid'},
        },
        banned_tags = {
            { id = 'tag_standard' },
        }
    },
}

-- Six Seven
SMODS.Challenge {
    key = 'sixseven',
    rules = {
        modifiers = {
        { id = 'joker_slots', value = 7 },
        { id = 'dollars', value = 67},
        { id = 'hands', value = 6},
        { id = 'discards', value = 7},
        { id = 'hand_size', value = 6},
        { id = 'consumable_slots', value = 67},
        }
    },
    jokers = {
        { id = 'j_hatch_supersevens'},
        { id = 'j_hatch_supersevens'},
        { id = 'j_hatch_supersevens'},
        { id = 'j_hatch_supersevens'},
        { id = 'j_hatch_supersevens'},
        { id = 'j_hatch_supersevens'},
    },
    loc_txt = {
        ['name'] = 'SIX SEVEN',
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    deck = {
        type = 'Challenge Deck',
        cards = {
            { s = 'C', r = '7' },
            { s = 'H', r = '7' },
            { s = 'S', r = '7' },
            { s = 'D', r = '7' },
            { s = 'C', r = '7' },
            { s = 'C', r = '7' },
        },
},
 restrictions = {
        banned_cards = {
            { id = 'p_standard_normal_1', ids = {
                'p_standard_normal_1', 'p_standard_normal_2',
                'p_standard_normal_3', 'p_standard_normal_4',
                'p_standard_jumbo_1', 'p_standard_jumbo_2',
                'p_standard_mega_1', 'p_standard_mega_2', }
            },
            { id = 'j_marble'},
            { id = 'v_magic_trick'},
            { id = 'v_illusion'},
            { id = 'c_strength'},
            { id = 'c_tower'},
            { id = 'c_incantation'},
            { id = 'c_grim'},
            { id = 'c_familiar'},
            { id = 'c_hatch_hod'},
        },
        banned_tags = {
            { id = 'tag_standard' },
        },
        banned_other = {
            { id = 'bl_club', type = 'blind' },
            { id = 'bl_goad', type = 'blind' },
            { id = 'bl_head', type = 'blind' },
            { id = 'bl_window', type = 'blind' },
        }
    },
}

-- Upside Down
SMODS.Challenge {
    key = 'upsidedown',
    jokers = {
        { id = 'j_oops', eternal = true, edition = 'negative' },
        { id = 'j_oops', eternal = true, edition = 'negative' },
        { id = 'j_hatch_topsyturvy', eternal = true },
    },
    loc_txt = {
        ['name'] = 'Upside Down',
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
}