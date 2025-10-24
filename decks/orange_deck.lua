SMODS.Back {
    key = 'orange_deck',
    pos = { x = 0, y = 0 },
    config = {
      hand_size = -3,
        discards = 3,
},
    loc_txt = {
        name = 'Orange Deck',
        text = {
            [1] = '{C:attention}-3{} hand size',
            [2] = '{C:attention}+1{} hand size per Ante',
            [3] = '{C:red}+3{} discards'
        },
    },
    unlocked = true,
    discovered = true,
    no_collection = false,
    atlas = 'CustomDecks',
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and context.beat_boss and not context.blueprint then
             G.hand:change_size(1)
        end
  end,
}