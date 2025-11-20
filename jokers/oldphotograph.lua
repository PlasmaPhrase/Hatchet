
SMODS.Joker{ --Old Photograph
    key = "oldphotograph",
    config = {
        extra = {
            odds = 2,
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
        x = 1,
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
    discovered = false,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_hatch_oldphotograph') 
        return {vars = {new_numerator, new_denominator}}
    end,
    
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