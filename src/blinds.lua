-- The Axe
SMODS.Blind {
    key = "hatch_axe",
    dollars = 5,
    mult = 2,
    pos = { x = 0, y = 0 },
    boss = { min = 2 },
    boss_colour = HEX("b6315e"),
    atlas = 'CustomBlinds',

    loc_txt = {
        ['name'] = 'The Axe',
        ['text'] = {
            [1] = 'Destroy first played card',
            [2] = 'after every played hand',
        },
    },

    calculate = function(self, blind, context)
    if not blind.disabled then
        if context.destroy_card and context.destroy_card.should_destroy  then
            return { remove = true }
        end
        if context.individual and context.cardarea == G.play  then
            context.other_card.should_destroy = false
            if context.other_card == context.scoring_hand[1] then
                context.other_card.should_destroy = true
                return {
                    message = "Destroyed!"
                }
            end
        end
    end
end
}

-- The Sack
SMODS.Blind {
    key = "hatch_sack",
    dollars = 5,
    mult = 2,
    pos = { x = 0, y = 1 },
    boss = { min = 4 },
    boss_colour = HEX("6caa70"),
    atlas = 'CustomBlinds',

    loc_txt = {
        ['name'] = 'The Sack',
        ['text'] = {
            [1] = 'Downgrade scored',
            [2] = 'cards by rank',
        },
    },

    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.individual and context.cardarea == G.play  then
                assert(SMODS.modify_rank(context.other_card, -1))
                return {
                    message = "Downgrade!"
                }
            end
        end
end
}

-- The Whip (has been removed)

-- The Cudgel
SMODS.Blind({
	key = "hatch_cudgel",
	config = {
		extra = {
			hands_removed = 0,
			hand_size = 1,
		},
	},
	dollars = 5,
	mult = 1,
	pos = { x = 0, y = 3 },
	boss = { min = 3 },
	boss_colour = HEX("a652c0"),
	atlas = "CustomBlinds",

	loc_txt = {
		["name"] = "The Cudgel",
		["text"] = {
			[1] = "Decrease hand size",
			[2] = "per played hand",
		},
	},
-- Credit to ThunderEdge for this code: I had no idea what I was doing but he helped me a ton! - Plasma
	loc_vars = function(self)
		return { vars = { self.config.extra.hands_removed } }
	end,
	calculate = function(self, blind, context)
		if not blind.disabled then
			if context.before then
				return {
					func = function()
						G.hand:change_size(-1)
						self.config.extra.hands_removed = self.config.extra.hands_removed + 1
						return true
					end,
				}
                -- Blinds require different code for end of round effects - ThunderEdge
                -- Hence, I deleted the context.end_of_round checks - ThunderEdge
			end
		end
	end,
    -- Called when the blind is defeated - ThunderEdge
    defeat = function(self)
        G.hand:change_size(self.config.extra.hands_removed)
        -- reset value
        self.config.extra.hands_removed = 0
    end,
    -- Called when the blind is disabled (e.g. Chicot) - ThunderEdge
    disable = function (self)
        G.hand:change_size(self.config.extra.hands_removed)
        -- reset value
        self.config.extra.hands_removed = 0
    end,
})


-- The Claw
SMODS.Blind {
    key = "hatch_claw",
    config = {
        extra = {
            play_size = 5
        }
    },
    dollars = 5,
    mult = 2,
    pos = { x = 0, y = 4 },
    boss = { min = 4 },
    boss_colour = HEX("6899ff"),
    atlas = 'CustomBlinds',

    loc_txt = {
        ['name'] = 'The Claw',
        ['text'] = {
            [1] = 'Decrease play',
            [2] = 'size per discard',
            [3] = '(resets after Boss is defeated)',
        },
    },

    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.pre_discard  then
                return {
                    func = function()
                        SMODS.change_play_limit(-1)
                        return true
                    end
                }
            end
            if context.end_of_round and context.game_over == false and context.main_eval  then
                return {
                    func = function()
                        SMODS.change_play_limit((-G.GAME.starting_params.play_limit)+5)
                        return true
                    end
                }
            end
        end
end
}