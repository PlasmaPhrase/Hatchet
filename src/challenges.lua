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
                'p_standard_mega_1', 'p_standard_mega_2' }
            },
        },
        banned_tags = {
            { id = 'tag_standard' },
        }
    },
}