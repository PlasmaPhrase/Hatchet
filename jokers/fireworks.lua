SMODS.Joker{ --Fireworks
    key = "fireworks",
    config = {
        extra = {
            Xmult = 3,
            start_dissolve = 0,
            n = 0
        }
    },
    loc_txt = {
        ['name'] = 'Fireworks',
        ['text'] = {
            [1] = '{X:red,C:white}X3{} Mult if poker hand does {C:attention}not{}',
            [2] = 'contain a {C:attention}#1#{}, poker hand',
            [3] = 'changes at the end of round.',
            [4] = 'If {C:attention}#1#{} is played, {C:red}self destruct{}'
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
    cost = 6,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        
        return {vars = {G.GAME.current_round.pokervar_hand}}
    end,

    set_ability = function(self, card, initial)
        G.GAME.current_round.pokervar_hand = 'High Card'
    end,

    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if not (context.scoring_name == G.GAME.current_round.pokervar_hand) then
                return {
                    Xmult = card.ability.extra.Xmult
                }
            elseif context.scoring_name == G.GAME.current_round.pokervar_hand then
                return {
                    func = function()
                        card:start_dissolve()
                        return true
                        end
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