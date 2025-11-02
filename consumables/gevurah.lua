SMODS.Consumable {
    key = 'gevurah',
    set = 'sephirot',
    pos = { x = 4, y = 0 },
    loc_txt = {
        name = 'Gevurah',
        text = {
        [1] = 'Creates a random {C:dark_edition}Negative{}',
        [2] = '{C:attention}Common Joker{} card'
    }
    },
    cost = 3,
    unlocked = false,
    discovered = false,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',use = function(self, card, area, copier)
        local used_card = copier or card
            G.E_MANAGER:add_event(Event({
                  trigger = 'after',
                  delay = 0.4,
                  func = function()
                      play_sound('timpani')
                      local new_joker = SMODS.add_card({ set = 'Joker', rarity = 'Common' })
                      if new_joker then
                          new_joker:set_edition("e_negative", true)
                      end
                      used_card:juice_up(0.3, 0.5)
                      return true
                  end
              }))
              delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}