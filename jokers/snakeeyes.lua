SMODS.Joker{ --Snake Eyes
    key = "snakeeyes",
    config = {
        extra = {
            dollars = 5
        }
    },
    loc_txt = {
        ['name'] = 'Snake Eyes',
        ['text'] = {
            [1] = 'Earn {C:money}$5{} for every destroyed card'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 5,
        y = 3
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    
    calculate = function(self, card, context)
        if context.remove_playing_cards  then
            return {
                dollars = card.ability.extra.dollars * #context.removed
            }
        end
    end
}