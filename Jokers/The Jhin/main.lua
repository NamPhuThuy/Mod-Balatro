--- STEAMODDED HEADER
--- MOD_NAME: The Jhin Mod
--- MOD_ID: TheJhinMod
--- MOD_AUTHOR: [ParZival]
--- MOD_DESCRIPTION: I like Jhin, and I like Balatro. So Here's Jhin in Balatro.
--- PREFIX: xmpl
----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas{
    key = 'Jokers', --atlas key
    path = 'Jokers.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}
SMODS.Joker{
    key = 'The Virtuoso', --joker key
    loc_txt = {
        ['name'] = 'The Virtuoso',
        ['text'] = {
            [1] = 'When {C:attention}exactly 4{} {C:black}cards are played,{}',
            [2] = 'Retrigger each scored {C:red}4, 4{} {C:black}times{}.'
        }
    },
    config = {
        extra = {
            [4] = 4
        }
    },
    rarity = 3,
    pos = { x = 0, y = 0 },
    atlas = 'Jokers',
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,

    -- Function to provide dynamic variables for the Joker's description
    loc_vars = function(self, info_queue, card)
        local vars = {}
        for k, _ in pairs(card.ability.extra) do
            if PB_UTIL and PB_UTIL.get_rank_from_id then
                local rank = PB_UTIL.get_rank_from_id(k)
                if rank and rank.key then
                    vars[#vars + 1] = (localize and localize(rank.key, 'ranks')) or "Localization Missing"
                else
                    vars[#vars + 1] = "Unknown Rank"
                end
            else
                vars[#vars + 1] = "PB_UTIL Missing"
            end
        end
        return { vars = vars }
    end,

    -- Main function that determines the Joker's effect
    calculate = function(self, card, context)
        -- Check 1: In play area and during retrigger phase?
        if context.cardarea == G.play and context.repetition then
            -- Check 2: Evaluating a specific card?
            if context.other_card then
                -- Check 3: Does the *currently scoring hand* have exactly 4 cards?
                if context.scoring_hand and #context.scoring_hand == 4 then
                    -- Check 4: Is the card being evaluated a '4'? (Assuming rank ID 4)
                    local rank_id_to_retrigger = 4
                    if context.other_card:get_id() == rank_id_to_retrigger then
                        -- Check 5: Is the Joker configured for rank 4?
                        if card.ability.extra[rank_id_to_retrigger] then
                            -- Conditions met! Return the number of repetitions.
                            return {
                                repetitions = card.ability.extra[rank_id_to_retrigger]
                            }
                        end
                    end
                end
            end
        end
        -- If any check fails, return nil (no effect)
        return nil
    end
}

     

  
----------------------------------------------
------------MOD CODE END----------------------

