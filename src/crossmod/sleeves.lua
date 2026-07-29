CardSleeves.Sleeve {
    key = "Chevron",
    atlas = "HatchetCrossSleeves",
    pos = { x = 0, y = 0 },
    config = { discards = 2, hand_size = -2 },
    unlocked = true,
    loc_vars = function(self)
        return { vars = { self.config.discards, self.config.hand_size } }
    end,
}

CardSleeves.Sleeve {
    key = "Holy",
    atlas = "HatchetCrossSleeves",
    pos = { x = 1, y = 0 },
    config = { sephirot_rate = 4, consumables = { 'c_hatch_kether' } },
    unlocked = true,
    apply = function(self)
        G.GAME.hatch_sephirot_rate = self.config.sephirot_rate
    end,
    loc_vars = function(self)
        return { vars = { self.config.sephirot_rate, self.config.consumables[1] } }
    end,
}

CardSleeves.Sleeve {
    key = "Harlequin",
    atlas = "HatchetCrossSleeves",
    pos = { x = 2, y = 0 },
    unlocked = true,
    apply = function(self)
        SMODS.change_booster_limit(1)
    end,
}