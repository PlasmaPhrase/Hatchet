SMODS.Joker{ --Seven Sisters
    key = "sevensisters",
    config = {
        extra = {
            Xmult = 2
        }
    },
    loc_txt = {
        ['name'] = 'Seven Sisters',
        ['text'] = {
            [1] = '{X:red,C:white}X2{} Mult if played hand',
            [2] = 'has a scoring {C:attention}7 {}and a',
            [3] = 'scoring card of any other rank'
        },
        ['unlock'] = {
            [1] = ''
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
    cost = 6,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if ((function()
    local rankCount = 0
    for i, c in ipairs(context.scoring_hand) do
        if c:get_id() == 7 then
            rankCount = rankCount + 1
        end
    end
    
    return rankCount >= 1
end)() and not ((function()
    local allMatchRank = true
    for i, c in ipairs(context.scoring_hand) do
        if not (c:get_id() == 7) then
            allMatchRank = false
            break
        end
    end
    
    return allMatchRank and #context.scoring_hand > 0
end)())) then
                return {
                    Xmult = card.ability.extra.Xmult
                }
            end
        end
    end
}