
SMODS.Back {
    key = 'orange_deck',
    pos = { x = 0, y = 0 },
    config = {hand_size = 4, discards = 2},
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
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.hand_size, self.config.discards } }
    end,
}