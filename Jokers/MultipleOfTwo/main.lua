--- STEAMODDED HEADER
--- MOD_NAME: Multiples Of Two
--- MOD_ID: MultipleOfTwo
--- MOD_AUTHOR: [Somonosuke]
--- MOD_DESCRIPTION: Just an inside joke

----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas{
    key = 'MultipleOfTwo', --atlas key
    path = 'Jokers.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}
SMODS.Joker{
    key = 'MultipleOfTwo', --joker key
    loc_txt = { -- local text
        name = 'Multiples Of Two',
        text = {
          'Scoring {C:attention}3{}s, {C:attention}6{}s, or {C:attention}9{}s gain',
          '{C:chips}+#1#{} Chips and {C:mult}+#2#{} Mult.',
          'Whenever you play a hand',
          'that contains a pair, {X:mult,C:white}X#3#{} Mult.',
        },
    },
    atlas = 'MultipleOfTwo', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 6, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        chips = 15,
        mult = 12,
        Xmult = 1,
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.chips, center.ability.extra.mult, center.ability.extra.Xmult}} --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 3 or context.other_card:get_id() == 6 or context.other_card:get_id() == 9 then
                return {
                    card = card,
                    mult = card.ability.extra.mult,
                    chips = card.ability.extra.chips,
                }
            end
        end
        
        if context.joker_main then
            if next(context.poker_hands["Pair"]) then
                return {
                    Xmult_mod = card.ability.extra.Xmult,
                    message = "Multiple Of Two",
                    colour = G.C.MULT
                }
            end 
        end
    end,
    in_pool = function(self,wawa,wawa2)
        return true
    end,
}

----------------------------------------------
------------MOD CODE END----------------------