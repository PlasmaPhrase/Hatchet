SMODS.Joker{ --Old Photograph
    key = "oldphotograph",
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
    pos = {
        x = 9,
        y = 1
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
    discovered = true,
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