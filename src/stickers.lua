-- Burdened
SMODS.Sticker {
    key = "burdened",
    badge_colour = HEX '3abd4c',
    pos = { x = 0, y = 0 },
    atlas = 'CustomStickers',

    -- Credit to Metanite64 for the code: this is taken from Astro's Starspace Mod (with permission.)
    -- Credit to Eris for support on the tooltips.
    apply = function(self,card,val)
        if val then
            card.ability.extra_slots_used = card.ability.extra_slots_used + 1
        else
            card.ability.extra_slots_used = card.ability.extra_slots_used - 1
        end
        card.ability[self.key] = val
        end,

    needs_enable_flag = true,
    sets = { Joker = true }
}