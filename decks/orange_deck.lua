SMODS.Back {
    key = 'orange_deck',
    pos = { x = 0, y = 0 },
    config = {
      hand_size_value = 6,
        discards_value = 2,
},
    loc_txt = {
        name = 'Orange Deck',
        text = {
            [1] = '{C:attention}-2{} hand size',
            [2] = '{C:red}+2{} discards every round'
        },
    },
    unlocked = true,
    discovered = true,
    no_collection = false,
    atlas = 'CustomDecks',
     apply = function(self, back)
            G.GAME.starting_params.hand_size = 6
            G.GAME.starting_params.discards = G.GAME.starting_params.discards + 2
    end
}