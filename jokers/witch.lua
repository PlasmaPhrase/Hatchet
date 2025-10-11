SMODS.Joker{ --Witch
    key = "witch",
    config = {
        extra = {
            xmultvar = 1
        }
    },
    loc_txt = {
        ['name'] = 'Witch',
        ['text'] = {
            [1] = 'This Joker gains {X:red,C:white}X0.1{} Mult for every unplayed hand',
            [2] = '{C:inactive}(Currently{} {X:red,C:white}X#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 9,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 7,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.xmultvar}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    Xmult = card.ability.extra.xmultvar
                }
        end
        if context.end_of_round and context.game_over == false and context.main_eval  then
            if true then
                for i = 1, G.GAME.current_round.hands_left do
              SMODS.calculate_effect({func = function()
                    card.ability.extra.xmultvar = (card.ability.extra.xmultvar) + 0.1
                    return true
                end}, card)
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "x0.1 Mult", colour = G.C.GREEN})
          end
            end
        end
    end
}