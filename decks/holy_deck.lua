SMODS.Back {
    key = 'holy_deck',
    pos = { x = 1, y = 0 },
    config = { sephirot_rate = 2, consumables = { 'c_hatch_kether' }  },
    loc_txt = {
        name = 'Holy Deck',
        text = {
            [1] = '{C:green}Sephirot{} cards may appear in the',
            [2] = 'shop, start with a {C:green}Kether{} card'
        },
    },
    unlocked = false,
    atlas = 'CustomDecks',

    apply = function(self, back)
        -- Apply the spectral rate
        G.GAME.sephirot_rate = self.config.sephirot_rate
    end,
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.sephirot_rate, self.config.consumables[1] } }
    end,
}