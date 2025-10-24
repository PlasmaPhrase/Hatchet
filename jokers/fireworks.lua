SMODS.Joker{ --Fireworks
    key = "fireworks",
    config = {
        extra = {
            Xmult = 1.5
        }
    },
    loc_txt = {
        ['name'] = 'Fireworks',
        ['text'] = {
            [1] = '{X:red,C:white}x1.5{} Mult if {C:attention}played hand{} is a {C:attention}#1#{},',
            [2] = 'poker hand changes at end of round'
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
    cost = 4,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        
        return {vars = {localize((G.GAME.current_round.pokervar_hand or 'High Card'), 'poker_hands')}}
    end,

    set_ability = function(self, card, initial)
        G.GAME.current_round.pokervar_hand = 'High Card'
    end,

    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if context.scoring_name == G.GAME.current_round.pokervar_hand then
                return {
                    Xmult = card.ability.extra.Xmult
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