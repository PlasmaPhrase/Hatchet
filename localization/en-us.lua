return {
    descriptions = { -- Backs start below
        Back = {
            b_hatch_chevron = {
                name = "Chevron Deck",
                text = {
                    "{C:attention}-2{} hand size",
                    "{C:red}+2{} discards every round"
                },
            },
            b_hatch_holy = {
                name = "Holy Deck",
                text = {
                    "{C:green}Sephirot{} cards may",
                    "appear in the shop,",
                    "start with a {C:green}Kether{} card"
                },
            },
            b_hatch_harlequin = {
                name = "Harlequin Deck",
                text = {
                    "{C:attention}+1{} booster pack per shop",
                },
            },
            b_hatch_pilot = {
                name = "Pilot Deck",
                text = {
                    "Start run with",
                    "{C:green}#1#{},",
                    "and {C:attention}#2#{}",
                },
            },
            b_hatch_numinous = {
                name = "Numinous Deck",
                text = {
                    "{C:dark_edition}Divine{} cards",
                    "may appear in the shop",
                },
                unlock = {
                    "Win a run with any",
                    "deck on at least",
                    "{V:1}#1#{} difficulty",
                }
            },
        }, -- Blinds start below
        Blind = {
            bl_hatch_axe = {
                name = "The Axe",
                text = {
                    "Destroy first played card",
                    "after every played hand"
                },
            },
            bl_hatch_sack = {
                name = "The Sack",
                text = {
                    "Downgrade scored",
                    "cards by rank"
                },
            },
            bl_hatch_whip = {
                name = "The Whip",
                text = {
                    "All enhanced cards",
                    "are debuffed"
                },
            },
            bl_hatch_cudgel = {
                name = "The Cudgel",
                text = {
                    "Decrease hand size",
                    "per played hand"
                },
            },
            bl_hatch_claw = {
                name = "The Claw",
                text = {
                    "Decrease play size",
                    "per discard"
                },
            },
        }, -- Editions start below
        Edition = {
            e_hatch_divine = {
                name = "Divine",
                text = {
                    "A {C:attention}temporary{} evolution",
                    "{C:inactive}(Shader by {}{C:attention}cassknows{}{C:inactive}){}"
                },
            },
        }, -- Enhancements start below
        Enhanced = {
            m_hatch_sulfur = {
                name = "Sulfur",
                text = {
                    "Permanently gain {C:mult}+1{}",
                    "Mult when scored"
                },
            },
            m_hatch_mercury = {
                name = "Mercury",
                text = {
                    "Enhanced card gives",
                    "between {C:blue}+0{} to {C:blue}+75{}",
                    "Chips when scored"
                },
            },
            m_hatch_salt = {
                name = "Salt",
                text = {
                    "Enhanced card has a",
                    "{C:green}#1# in #2#{} chance",
                    "to {C:attention}retrigger{} twice",
                    "when scored"
                },
            },
        }, -- Jokers start below
        Joker = {
            j_hatch_hatchet = {
                name = "Hatchet",
                text = {
                    {
                        "{X:red,C:white}X#1#{} Mult on",
                        "{C:attention}first hand of round{}",
                    },
                    {
                        "{C:red}Destroy{} played cards"
                    }
                },
            },
            j_hatch_handout = {
                name = "Handout",
                text = {
                    {
                        "Earn {C:money}$1{} for each",
                        "remaining {C:attention}discard{}",
                    },
                },
            },
            j_hatch_blueshoes = {
                name = "Blue Shoes",
                text = {
                    "{C:blue}+#1#{} Chips",
                    "{C:blue}-#2#{} Chips per",
                    "{C:planet}poker hand{} upgrade"
                },
            },
            j_hatch_earthquake = {
                name = "Earthquake",
                text = {
                    {
                        "Gains {C:blue}+#2#{} Chips",
                        "per card {C:attention}destroyed{}",
                        "{C:inactive}(Currently {C:blue}+#1#{C:inactive} Chips)",
                    },
                },
            },
            j_hatch_proudjoker = {
                name = "Proud Joker",
                text = {
                    {
                        "Played {C:attention}Stone Cards{}",
                        "give {C:red}+#1#{} Mult",
                    },
                },
            },
            j_hatch_savinggrace = {
                name = "Saving Grace",
                text = {
                    "Upgrade the final",
                    "played {C:attention}poker hand{}",
                    "by {C:attention}#1#{} levels in",
                    "{C:attention}final hand{} of round",
                    "{C:red}Self destructs{}"
                },
            },
            j_hatch_supersevens = {
                name = "Super Sevens",
                text = {
                    "All played {C:attention}7s{}",
                    "become {C:attention}Mercury{}",
                    "cards when scored",
                },
            },
            j_hatch_sevensisters = {
                name = "Seven Sisters",
                text = {
                    "{X:red,C:white}X#1#{} Mult",
                    "if played hand",
                    "contains only {C:attention}7s{}",
                },
            },
            j_hatch_diaryentry = {
                name = "Diary Entry",
                text = {
                    "{C:blue}Common Jokers{} each give {C:blue}50{} Chips"
                },
            },
            j_hatch_blackjoker = {
                name = "Black Joker",
                text = {
                    "{C:dark_edition}Negative{} Jokers",
                    "are {C:attention}#1#X{} more",
                    "likely to appear"
                },
            },
            j_hatch_musketeer = {
                name = "Musketeer",
                text = {
                    "Earn {C:money}$#1#{} if played",
                    "hand contains",
                    "a {C:attention}#2#{}"
                },
            },
            j_hatch_oldphotograph = {
                name = "Old Photograph",
                text = {
                    {
                        "First played {C:attention}face",
                        "card gives {X:mult,C:white}X#1#{} Mult",
                        "when scored",
                    },
                    {
                        "{C:green}#2# in #3#{} chance",
                        "to give {X:mult,C:white}X#4#{} Mult",
                    }
                },
            },
            j_hatch_interstice = {
                name = "Interstice",
                text = {
                    "Sell this card to",
                    "halve {C:attention}Blind{} size"
                },
            },
            j_hatch_sewingneedle = {
                name = "Sewing Needle",
                text = {
                    {
                        "Create a {C:spectral}Spectral{} card",
                        "when {C:attention}Blind{} is defeated",
                        "{C:inactive}(Must have room){}"
                    },
                    {
                        "{C:red}Self destruct{} if blind",
                        "is not beaten in one hand"
                    },
                },
            },
            j_hatch_tricky = {
                name = "Tricky Joker",
                text = {
                    "{C:blue}Hands{} are set",
                    "to the number of",
                    " {C:red}discards{} per round"
                },
            },
            j_hatch_lossleader = {
                name = "Loss Leader",
                text = {
                    "All items in shop",
                    "are {C:attention}25%{} off"
                },
            },
            j_hatch_azurecard = {
                name = "Azure Card",
                text = {
                    "Gain {C:blue}+#2#{} Chips if",
                    "{{C:attention}no purchases{}",
                    "are made in shop",
                    "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
                },
            },
            j_hatch_dakimakura = {
                name = "Dakimakura",
                text = {
                    "If played hand contains a {C:attention}Flush{}",
                    "give each card a {C:attention}random{} suit"
                },
            },
            j_hatch_fortress = {
                name = "Fortress",
                text = {
                    "{X:mult,C:white}X#1#{} Mult",
                    "if no discards are used",
                    "by the end of round"
                },
            },
            j_hatch_d20 = {
                name = "D20",
                text = {
                    {
                        "Earn {C:money}$#3#{}",
                        "at the end",
                        "of round"
                    },
                    {
                        "{C:green}#1# in #2#{} chance",
                        "to receive {C:money}$#4#{}"
                    }
                },
            },
            j_hatch_riskyrevolver = {
                name = "Risky Revolver",
                text = {
                    "{C:green}#1# in #2#{} chance to",
                    "{C:red}destroy{} a random {C:attention}Joker{}",
                    "Else, give {C:white,X:mult}X#3#{} Mult"
                },
            },
            j_hatch_sunset = {
                name = "Sunset",
                text = {
                    "{X:chips,C:white}X#1#{} Chips",
                    "in the {C:attention}first hand{}",
                    "of round"
                },
            },
            j_hatch_pizza = {
                name = "Pizza",
                text = {
                    "{C:chips}+#1#{} Chips",
                    "{C:chips}-#2#{} Chips",
                    "per reroll"
                },
            },
            j_hatch_roulette = {
                name = "Roulette",
                text = {
                    "Earn {C:money}$#1#{} if",
                    "played hand contains",
                    "a {C:attention}Flush{} of {V:1}#2#s{}",
                    "{C:inactive}(Suit changes every round){}",
                },
            },
            j_hatch_pickpocket = {
                name = "Pickpocket",
                text = {
                    "Sell this card to",
                    "create a free",
                    "{C:attention}#1#{}",
                },
            },
            j_hatch_fireworks = {
                name = "Fireworks",
                text = {
                    {
                        "{X:red,C:white}X#1#{} Mult",
                        "if a {C:attention}#2#{}",
                        "is discarded this round",
                    },
                    {
                        "{C:attention}Reset{} if discarded",
                        "hand contains any",
                        "other {C:attention}poker hand{}"
                    }
                },
            },
            j_hatch_stockexchange = {
                name = "Stock Exchange",
                text = {
                    "Earn {C:money}$#1#{} if {C:attention}played hand{}",
                    "contains {C:attention}#2#{} or fewer cards",
                },
            },
            j_hatch_aceinthehole = {
                name = "Ace in the Hole",
                text = {
                    "Each {C:attention}Ace{}",
                    "held in hand",
                    "gives {C:chips}+#1#{} Chips",
                },
            },
            j_hatch_witch = {
                name = "Witch",
                text = {
                    {
                        "This Joker gains {C:white,X:mult}X#2#{} Mult",
                        "for every {C:attention}unplayed hand{}, resets",
                        "when {C:attention}Boss Blind{} is defeated",
                        "{C:inactive}(Currently {C:white,X:mult}X#1#{} {C:inactive}Mult)"
                    },
                },
            },
            j_hatch_blackswan = { -- Idea by M0Xes
                name = "Black Swan",
                text = {
                    "Played {C:spades}Spades{}",
                    "become {C:attention}Glass{} cards",
                    "when scored"
                },
            },
            j_hatch_composter = {
                name = "Composter",
                text = {
                    "Earn {C:money}$#1#{} per",
                    "{C:attention}destroyed{} card",
                },
            },
            j_hatch_ninelives = {
                name = "Nine Lives",
                text = {
                    "Every {C:attention}9{} held in hand",
                    "gives {C:red}+#1#{} Mult"
                },
            },
            j_hatch_swindler = {
                name = "Swindler",
                text = {
                    "{C:red}+#1#{} Mult",
                    "{C:money}-$#2#{} {C:attention}sell value{}"
                },
            },
            j_hatch_nodice = {
                name = "No Dice",
                text = {
                    {
                        "Each played {C:attention}Ace{},",
                        "{C:attention}2{}, {C:attention}3{}, {C:attention}4{}, {C:attention}5{} or {C:attention}6{} gives",
                        "{C:mult}+#1#{} Mult when scored",
                    },
                    {
                        "All {C:attention}listed probabilities{} fail"
                    }
                },
            },
            j_hatch_sailor = {
                name = "Sailor",
                text = {
                    "Played {C:attention}Gold{} cards",
                    "give {C:chips}+#1#{} Chips",
                    "when scored"
                },
            },
            j_hatch_snakeeyes = {
                name = "Snake Eyes",
                text = {
                    "All {C:attention}listed {C:green,E:1}denominators",
                    "are set to {C:attention}#1#{}"
                },
            },
            j_hatch_wheelbarrow = {
                name = "Wheelbarrow",
                text = {
                    "{C:green}#1# in #2#{} cards are drawn face down",
                    "This Joker gains {X:red,C:white}X#4#{} Mult",
                    "for every played {C:attention}flipped{} card",
                    "{C:inactive}(Currently {C:white,X:mult}X#3#{C:inactive} Mult)"
                },
            },
            j_hatch_loveletter = {
                name = "Love Letter",
                text = {
                    "If {C:attention}final hand of round",
                    "has only {C:attention}1{} card,",
                    "add {C:dark_edition}Polychrome{} to it",
                },
            },
            j_hatch_staircase = {
                name = "Staircase",
                text = {
                    "Every played {C:attention}face card{}",
                    "has a {C:green}#1# in #2#{} chance",
                    "to create a {C:green}Sephirot{} card",
                    "{C:inactive}(Must have room){}"
                },
            },
            j_hatch_graveyardshift = {
                name = "Graveyard",
                text = {
                    "{X:red,C:white}X#1#{} Mult",
                    "if {C:attention}#2#{} {C:attention}face cards{}",
                    "are discarded this round",
                },
            },
            j_hatch_poisonivy = {
                name = "Poison Ivy",
                text = {
                    {
                        "{C:green}#3# in #4#{} chance",
                        "for {C:attention}scored cards{}",
                        "to {C:attention}downgrade{} in rank",
                    },
                    {
                        "Gain {X:red,C:white}X#2#{} Mult per downgrade",
                        "{C:inactive}(Currently {C:white,X:mult}X#1#{C:inactive} Mult)"
                    }
                },
            },
            j_hatch_airmissile = {
                name = "Air Missile",
                text = {
                    "{C:green}#3# in #4#{} chance",
                    "to {C:attention}downgrade{}",
                    "level of played {C:attention}poker hand{}",
                    "and gain {X:red,C:white}X#2#{} Mult",
                    "{C:inactive}(Currently {C:white,X:mult}X#1#{C:inactive} Mult)"
                },
            },
            j_hatch_wildside = {
                name = "Wildside",
                text = {
                    "Retrigger each",
                    "played {C:attention}Wild Card{}"
                },
            },
            j_hatch_cave = {
                name = "Iron Mine",
                text = {
                    "Played {C:attention}Stone Cards{}",
                    "become {C:attention}Steel Cards{}"
                },
            },
            j_hatch_giraffe = {
                name = "Giraffe",
                text = {
                    "Gain {C:chips}+#1#{} Chips",
                    "per {C:attention}voucher{}",
                    "redeemed this run",
                },
            },
            j_hatch_fourleaf = {
                name = "Four-Leaf Clover",
                text = {
                    "{C:attention}Four of a Kinds",
                    "can be made with",
                    "{C:attention}Three of a Kinds"
                },
            },
            j_hatch_steelball = {
                name = "Steel Ball",
                text = {
                    "Gains {C:red}+2{} Mult per",
                    "{C:attention}Steel Card played",
                    "{C:inactive}(Currently {C:red}+#1#{C:inactive} Mult)"
                },
            },
            j_hatch_foolsgold = {
                name = "Fool's Gold",
                text = {
                    "Played {C:attention}Gold{} cards",
                    "have a {C:green}#1# in #2#{} chance to",
                    "create a {C:tarot}Fool{} card",
                    "{C:inactive}(Must have room)"
                },
            },
            j_hatch_handsdown = {
                name = "Hands Down",
                text = {
                    "{C:attention}+#2#{} hand size",
                    "{X:red,C:white}X#1#{} Mult per round",
                },
            },
            j_hatch_defaced = {
                name = "Defaced",
                text = {
                    "All {C:attention}face cards{}",
                    "are considered {C:attention}2s{}",
                },
            },
            j_hatch_topsyturvy = {
                name = "Topsy Turvy",
                text = {
                    "{C:green}#1# in #2#{} chance to",
                    "{C:tarot}swap{} {C:blue}Chips{} and {C:mult}Mult{}"
                },
            },
            j_hatch_windmill = {
                name = "Windmill",
                text = {
                    "Retrigger each played",
                    "{C:attention}Mercury Card{}",
                },
            },
            j_hatch_wildwest = {
                name = "Wild West",
                text = {
                    "Played {C:attention}Wild Cards{}",
                    "permanently gain {C:red}+1{} Mult",
                },
            },
            j_hatch_limepie = {
                name = "Lime Pie",
                text = {
                    "Earn {C:money}$#1#{} at end of round",
                    "Payout {C:attention}reduced{} by {C:money}$#2#{}",
                    "per discarded hand"
                },
            },
            j_hatch_hearttransplant = {
                name = "Heart Transplant",
                text = {
                    "If played hand contains a scoring {C:hearts}Heart{}",
                    "and a scoring card of any other {C:attention}Suit{}",
                    "{C:attention}Convert{} all played cards into the {C:hearts}Heart{} suit"
                }
            },
            j_hatch_emptycrown = {
                name = "Empty Crown",
                text = {
                    "At the end of every round,",
                    "create a {C:green}Kether{} card",
                    "{C:inactive}(Must have room){}"
                },
            },
            j_hatch_royalguard = {
                name = "Royal Guard",
                text = {
                    "{C:red}+1{} Mult for every",
                    "{C:attention}face card{} in your deck",
                    "{C:inactive}(Currently {C:mult}+#2#{} {C:inactive}Mult)"
                },
            },
            j_hatch_meteorite = {
                name = "Meteorite",
                text = {
                    "Sell this card to create",
                    "a free {C:attention}Meteor Tag{}"
                },
            },
            j_hatch_panic = {
                name = "Panic Attack",
                text = {
                    "Gain {C:mult}+1{} Mult for every {C:attention}5{} card hand played",
                    "{C:attention}Resets{} if less than {C:attention}5{} cards are played",
                    '{C:inactive}(Currently {C:red}+#1#{C:inactive} Mult)'
                },
            },
            j_hatch_astrophysicist = {
                name = "Astrophysicist",
                text = {
                    "Gain {C:blue}+10{} Chips for",
                    "every {C:planet}Planet{} card used",
                    "{C:inactive}(Currently {C:blue}+#1#{C:inactive} Chips)"
                },
            },
            j_hatch_sciencelab = {
                name = "Science Lab",
                text = {
                    "Gain {C:blue}+#2#{} Chips for each",
                    "{C:attention}Mercury Card{} held in hand",
                    "{C:inactive}(Currently {C:blue}+#1#{C:inactive} Chips)"
                },
            },
            j_hatch_bonusround = {
                name = "Bonus Round",
                text = {
                    "Played {C:attention}Bonus Cards{}",
                    "give {C:money}$#1#{} when scored"
                },
            },
            j_hatch_playground = {
                name = "Playground",
                text = {
                    "When {C:attention}Boss Blind{} is defeated",
                    "create a random {C:attention}Tag{}",
                },
            },
            j_hatch_slipperyslope = {
                name = "Slippery Slope",
                text = {
                    "{C:mult}+#3#{} Mult per round",
                    "Lose {C:money}$#2#{} at end of round",
                    "{C:inactive}(Currently {C:mult}+#1#{}{C:inactive} Mult){}"
                },
            },
            j_hatch_textile = {
                name = "Textile Joker",
                text = {
                    "Gain {C:mult}+#2#{} Mult if {C:attention}Blind{}",
                    "is cleared in {C:attention}one{} hand",
                    "{C:inactive}(Currently {C:mult}+#1#{}{C:inactive} Mult){}"
                },
            },
            j_hatch_abacus = {
                name = "Abacus",
                text = {
                    "{C:mult}+#2#{} Mult for each played {C:attention}2{}, {C:attention}4{}, {C:attention}6{} and {C:attention}8{}",
                    "{C:mult}-#3#{} Mult for each played {C:attention}3{}, {C:attention}5{}, {C:attention}7{} and {C:attention}9{}",
                    "{C:inactive}(Currently {C:mult}+#1#{}{C:inactive} Mult){}",
                },
            },
            j_hatch_medicine = {
                name = "Medicine Cabinet",
                text = {
                    "{C:white,X:mult}X#3#{} Mult in a {C:attention}Boss Blind{}",
                    "{C:green}#1# in #2#{} chance to expire",
                    "after a {C:attention}Boss Blind{}"
                },
            },
            j_hatch_burrito = {
                name = "Burrito",
                text = {
                    "{C:red}+#1#{} discards",
                    "{C:attention}-#2#{} discard per round",
                },
            },
            j_hatch_cakeslice = {
                name = "Cake Slice",
                text = {
                    "When {C:attention}Blind{} is cleared",
                    "gain a random {C:attention}Tag{}",
                    "{C:green}#1# in #2#{} chance to",
                    "{C:red}self-destruct{}"
                },
            },
            j_hatch_sourmilk = {
                name = "Soured Milk",
                text = {
                    "Lose {C:money}$#1#{} per round",
                    "If balance is below {C:money}-$#2#{}",
                    "this {C:attention}Joker{} spoils"
                },
            },
            j_hatch_milkman = {
                name = "Milkman",
                text = {
                    "Gain {C:white,X:mult}X#1#{} Mult",
                    "per {C:attention}dollar{} below zero",
                    "{C:inactive}(Currently {X:red,C:white}X#2#{C:inactive} Mult)"
                },
            },
            j_hatch_ballad = {
                name = "Ballad of Jimbo",
                text = {
                    "{C:attention}Booster Packs{} may",
                    "contain an {C:attention}extra{} card",
                },
            },
            j_hatch_heartminds = {
                name = "Hearts and Minds",
                text = {
                    "Gain {C:mult}+#2#{} Mult if played hand",
                    "contains a {C:attention}Flush{}, then",
                    "{C:attention}destroy{} played cards",
                    "{C:inactive}(Currently{} {C:red}+#1#{} {C:inactive}Mult{})"
                },
            },
            j_hatch_spoiledballot = {
                name = "Spoiled Ballot",
                text = {
                    "On the {C:attention}first hand{} of round",
                    "the {C:attention}first{} played card is",
                    "enhanced into a {C:attention}Salt Card{}",
                },
            },
            j_hatch_philosopher = {
                name = "Philosopher's Stone",
                text = {
                    "If played hand contains",
                    "a {C:attention}Sulfur Card{}",
                    "a {C:attention}Mercury Card{}",
                    "and a {C:attention}Salt Card{}",
                    "create a {C:dark_edition}Divine Card{}",
                },
            },
            j_hatch_pleadeal = {
                name = "Plea Deal",
                text = {
                    "At the start of round",
                    "{C:red}discards{} are added",
                    "to {C:attention}hand size{}"
                },
            },
            j_hatch_treasure = {
                name = "Treasure Chest",
                text = {
                    "Earn {C:money}$5{} if all cards",
                    "held in hand are",
                    "{C:hearts}Hearts{} or {C:diamonds}Diamonds{}",
                },
            },
            j_hatch_ritual = {
                name = "Tarot Ritual",
                text = {
                    "Create a {C:dark_edition}Negative{} {C:tarot}Tarot{} card",
                    "if {C:attention}5{} cards are discarded",
                    "at once"
                },
            },
            j_hatch_room202 = {
                name = "Room No. 202",
                text = {
                    "If played hand contains a {C:attention}#2#{}",
                    "add {C:attention}+1{} hand size, resets when",
                    "{C:attention}Boss Blind{} is defeated"
                },
            },
            j_hatch_paperplane = {
                name = "Paper Plane",
                text = {
                    "If played hand is a {C:attention}#3#{}",
                    "this Joker gains {C:white,X:mult}X#2#{} Mult",
                    '{C:inactive}(Currently{} {C:white,X:mult}X#1#{} {C:inactive}Mult){}',
                },
            },
            j_hatch_nancy = {
                name = "Negative Nancy",
                text = {
                    "{C:mult}+#1#{} Mult for each",
                    "{C:dark_edition}Negative{} {C:attention}Joker{}",
                    '{C:inactive}(Currently{} {C:mult}+#2#{} {C:inactive}Mult){}',
                },
            },
            j_hatch_finalace = {
                name = "Final Ace",
                text = {
                    "If {C:attention}scored hand{} contains",
                    "only one {C:attention}Ace{}, destroy it",
                    "and gain {C:mult}+#2#{} Mult",
                    "{C:inactive}(Currently{} {C:mult}+#1#{} {C:inactive}Mult){}"
                },
            },
            j_hatch_clocktower = {
                name = "Clock Tower",
                text = {
                    "Create a {C:dark_edition}Divine Card{}",
                    "every {C:attention}#1#{} hands played",
                    "{C:inactive}(#2#){}",
                    "{C:inactive,s:0.8}(Must have room){}"
                },
            },
            j_hatch_dementedface = {
                name = "Demented Face",
                text = {
                    "{C:white,X:mult}X#3#{} Mult",
                    "for played {C:attention}face{} cards",
                    "{C:green}#1# in #2#{} chance to",
                    "{C:attention}destroy{} played cards"
                },
            },
            j_hatch_rabbitfoot = {
                name = "Rabbit Foot",
                text = {
                    "Every {C:attention}2{} has a",
                    "{C:green}#1# in #2#{} chance to",
                    "{C:attention}retrigger{} twice"
                },
            },
            j_hatch_capbells = {
                name = "Cap and Bells",
                text = {
                    "{C:red}+1{} {C:attention}Booster Pack{} each round",
                },
            },
            j_hatch_prion = {
                name = "Prion",
                text = {
                    "Discards have a {C:green}#1# in #2#{} chance",
                    "to {C:red}destroy{} the card"
                },
            },
            j_hatch_greencard = {
                name = "Green Card",
                text = {
                    "Create a {C:green}Sephirot{} card",
                    "when {C:attention}Blind{} is skipped",
                    "{C:inactive}(Must have room){}"
                },
            },
            j_hatch_contract = {
                name = "Contract",
                text = {
                    "Sell this card to",
                    "go back {C:attention}#1#{} Antes",
                    "{C:blue}-#1#{} hands each round"
                },
            },
            j_hatch_fallentree = {
                name = "Fallen Tree",
                text = {
                    "{C:white,X:mult}X#1#{} Mult",
                    "Lose {C:white,X:mult}X#2#{} Mult",
                    "per {C:attention}destroyed{} card"
                },
            }, -- Divines start Here
            j_hatch_divine_hatchet = {
                name = "Divine Hatchet",
                text = {
                    {
                        "{X:red,C:white}X#1#{} Mult",
                        "{C:red}Destroy{} played cards"
                    },
                    {
                        "{C:inactive}Devolves after {}{C:attention}#2#{}{C:inactive} round(s){}",
                    }
                },
            },
            j_hatch_divine_loveletter = {
                name = "Divine Letter",
                text = {
                    {
                        "{C:white,X:mult}X#1#{} Mult for",
                        "every {C:dark_edition}Polychrome{}",
                        "card in deck",
                    },
                    {
                        "{C:inactive}Devolves after {}{C:attention}#3#{}{C:inactive} round(s){}",
                    }
                },
            },
            j_hatch_divine_wildside = {
                name = "Divine Wildside",
                text = {
                    {
                        "Scored {C:attention}Wild Cards{} give",
                        " {C:white,X:mult}X#2#{} Mult, then retrigger",
                    },
                    {
                        "{C:inactive}Devolves after {}{C:attention}#3#{}{C:inactive} round(s){}",
                    }
                },
            },
            j_hatch_divine_fourleaf = {
                name = "Divine Clover",
                text = {
                    {
                        "{C:attention}Five of a Kinds",
                        "can be created with",
                        "{C:attention}Three of a Kind"
                    },
                    {
                        "{C:inactive}Devolves after {}{C:attention}#1#{}{C:inactive} round(s){}",
                    }
                },
            },
            j_hatch_divine_ball = {
                name = "Divine Steel Ball",
                text = {
                    {
                        "Gain {C:white,X:mult}X#2#{} Mult",
                        "per {C:attention}Steel Card{} scored",
                        "{C:inactive}(Currently{} {C:white,X:mult}X#1#{} {C:inactive}Mult){}"
                    },
                    {
                        "{C:inactive}Devolves after {}{C:attention}#3#{}{C:inactive} round(s){}",
                    }
                },
            },
            j_hatch_divine_banner = {
                name = "Divine Banner",
                text = {
                    {
                        "{C:white,X:blue}X#1#{} Chips for",
                        "each remaining {C:attention}discard{}",
                    },
                    {
                        "{C:inactive}Devolves after {}{C:attention}#2#{}{C:inactive} round(s){}",
                    }
                },
            },
            j_hatch_divine_mime = {
                name = "Divine Mime",
                text = {
                    {
                        "Retrigger all card",
                        "{C:attention}held in hand{}",
                        "abilities {C:attention}twice{}"
                    },
                    {
                        "{C:inactive}Devolves after {}{C:attention}#2#{}{C:inactive} round(s){}",
                        "{C:inactive}(Art by {}{C:attention}Inky{}{C:inactive}){}"
                    },
                },
            },
            j_hatch_divine_fist = {
                name = "Divine Fist",
                text = {
                    {
                        "Adds {C:attention}double{} the rank",
                        "of {C:attention}lowest{} ranked card",
                        "held in hand to {C:white,X:mult}XMult{}"
                    },
                    {
                        "{C:inactive}Devolves after {}{C:attention}#1#{}{C:inactive} round(s){}",
                    },
                },
            },
            j_hatch_divine_space = {
                name = "Divine Space Joker",
                text = {
                    {
                        "Always upgrade level of",
                        "played {C:attention}poker hand{}",
                    },
                    {
                        "{C:inactive}Devolves after {}{C:attention}#1#{}{C:inactive} round(s){}",
                    },
                },
            },
            j_hatch_divine_trousers = {
                name = "Divine Trousers",
                text = {
                    {
                        "Gain {C:white,X:mult}X#2#{} Mult and {C:money}$#3#{}",
                        "if played hand",
                        "contains a {C:attention}#5#{}",
                        "{C:inactive}(Currently{} {C:white,X:mult}X#1#{} {C:inactive}Mult){}",
                    },
                    {
                        "{C:inactive}Devolves after {}{C:attention}#4#{}{C:inactive} round(s){}",
                    },
                },
            },
            j_hatch_divine_musketeer = {
                name = "Divine Musketeer",
                text = {
                    {
                        "Create an {C:attention}Investment Tag{}",
                        "if played hand contains",
                        "a {C:attention}#1#{}"
                    },
                    {
                        "{C:inactive}Devolves after {}{C:attention}#2#{}{C:inactive} round(s){}",
                    },
                },
            },
            j_hatch_divine_guard = {
                name = "Divine Guard",
                text = {
                    {
                        "{C:white,X:mult}X#1#{} Mult per",
                        "{C:attention}face card in deck",
                        "{C:inactive}(Currently{} {X:mult,C:white}X#2#{}{C:inactive} Mult){}",
                    },
                    {
                        "{C:inactive}Devolves after {}{C:attention}#3#{}{C:inactive} round(s){}",
                    },
                },
            },
            j_hatch_divine_ritual = {
                name = "Divine Ritual",
                text = {
                    {
                        "Create a {C:dark_edition}Negative{}",
                        "{C:green}Sephirot Card{} if {C:attention}5{} cards",
                        "are discarded at once",
                    },
                    {
                        "{C:inactive}Devolves after {}{C:attention}#2#{}{C:inactive} round(s){}",
                    },
                },
            },
            j_hatch_divine_ballot = {
                name = "Divine Ballot",
                text = {
                    {
                        "All {C:attention}scored cards{} in",
                        "the {C:attention}first hand{} of round",
                        "become {C:attention}Salt Cards{}",
                    },
                    {
                        "{C:inactive}Devolves after {}{C:attention}#1#{}{C:inactive} round(s){}",
                    },
                },
            },
            j_hatch_divine_tree = {
                name = "Divine Tree",
                text = {
                    {
                        "{C:white,X:mult}X#1#{} Mult",
                        "Gain {C:white,X:mult}X#2#{} Mult",
                        "per card {C:attention}destroyed{}",
                        "{C:inactive}(Currently{} {X:mult,C:white}X#1#{}{C:inactive} Mult){}",
                    },
                    {
                        "{C:inactive}Devolves after {}{C:attention}#3#{}{C:inactive} round(s){}",
                    },
                },
            },
            j_hatch_divine_summit = {
                name = "Divine Summit",
                text = {
                    {
                        "{C:white,X:mult}X#1#{} Mult",
                        "when {C:attention}#2#{} discards",
                        "remaining"
                    },
                    {
                        "{C:inactive}Devolves after {}{C:attention}#3#{}{C:inactive} round(s){}",
                    },
                },
            },
            j_hatch_divine_8_ball = {
                name = "Divine 8 Ball",
                text = {
                    {
                        "Each played {C:attention}8{} creates a",
                        "{C:spectral}Spectral{} card when scored",
                        "{C:inactive}(Must have room)",
                    },
                    {
                        "{C:inactive}Devolves after {}{C:attention}#1#{}{C:inactive} round(s){}",
                        "{C:inactive}(Art by {}{C:attention}Jewel Sparkles{}{C:inactive}){}"
                    },
                },
            },
            j_hatch_divine_fibonacci = {
                name = "Divine Fibonacci",
                text = {
                    {
                        "Each played {C:attention}Ace{},",
                        "{C:attention}2{}, {C:attention}3{}, {C:attention}5{}, or {C:attention}8{} gives",
                        "{C:white,X:mult}X#1#{} Mult when scored",
                    },
                    {
                        "{C:inactive}Devolves after {}{C:attention}#2#{}{C:inactive} round(s){}",
                    },
                },
            },
            j_hatch_divine_scholar = {
                name = "Divine Scholar",
                text = {
                    {
                        "Each played {C:attention}Ace{} either gives,",
                        "{C:blue}+#3#{} Chips or {C:white,X:mult}X#4#{} Mult",
                    },
                    {
                        "{C:inactive}Devolves after {}{C:attention}#5#{}{C:inactive} round(s){}",
                    },
                },
            },
            j_hatch_divine_hiker = {
                name = "Divine Hiker",
                text = {
                    {
                        "Every played {C:attention}card{}",
                        "permanently gains",
                        "{C:white,X:chips}X#1#{} Chips when scored",
                    },
                    {
                        "{C:inactive}Devolves after {}{C:attention}#2#{}{C:inactive} round(s){}",
                        "{C:inactive}(Art by {}{C:attention}Inky{}{C:inactive}){}"
                    },
                },
            },
            j_hatch_divine_riffraff = {
                name = "Divine Riffraff",
                text = {
                    {
                        "When {C:attention}Blind{} is selected,",
                        "create {C:attention}#1# {C:red}Rare{C:attention} Jokers",
                        "{C:inactive}(Must have room)",
                    },
                    {
                        "{C:inactive}Devolves after {}{C:attention}#2#{}{C:inactive} round(s){}",
                        "{C:inactive}(Art by {}{C:attention}LasagnaFelidae{}{C:inactive}){}"
                    },
                },
            },
            j_hatch_divine_mail = {
                name = "Divine Rebate",
                text = {
                    {
                        "Earn {C:money}$#1#{} for each,",
                        "discarded {C:attention}card{}"
                    },
                    {
                        "{C:inactive}Devolves after {}{C:attention}#2#{}{C:inactive} round(s){}",
                    },
                },
            },
            j_hatch_divine_vagabond = {
                name = "Divine Vagabond",
                text = {
                    {
                        "Create a {C:dark_edition}Divine{} card",
                        "if hand is played",
                        "with {C:money}$#1#{} or less",
                        "{C:inactive}(Must have room)",
                    },
                    {
                        "{C:inactive}Devolves after {}{C:attention}#2#{}{C:inactive} round(s){}",
                    },
                },
            },
            j_hatch_divine_baseball = {
                name = "Divine Baseball",
                text = {
                    {
                        "{C:attention}Held{} Jokers each",
                        "give {X:mult,C:white} X#1# {} Mult",
                    },
                    {
                        "{C:inactive}Devolves after {}{C:attention}#2#{}{C:inactive} round(s){}",
                    },
                },
            },
            j_hatch_divine_walkie_talkie = {
                name = "Divine Walkie Talkie",
                text = {
                    {
                        "Each played {C:attention}10{} or {C:attention}4",
                        "gives {C:chips}+#1#{} Chips and",
                        "{C:mult}+#2#{} Mult when scored",
                    },
                    {
                        "{C:inactive}Devolves after {}{C:attention}#3#{}{C:inactive} round(s){}",
                    },
                },
            },
            j_hatch_divine_ticket = {
                name = "Divine Ticket",
                text = {
                    {
                        "Each played {C:attention}Enhanced card{}",
                        "earns {C:attention}$#1#{} when scored",
                    },
                    {
                        "{C:inactive}Devolves after {}{C:attention}#2#{}{C:inactive} round(s){}",
                    },
                },
            },
            j_hatch_divine_buckler = {
                name = "Divine Swashbuckler",
                text = {
                    {
                        "{C:white,X:mult}X#4#{} Mult per {C:money}dollar{}",
                        "of sell value of all other",
                        "{C:attention}Jokers{} owned",
                        "{C:inactive}(Currently {C:white,X:mult}X#2#{C:inactive} Mult)",
                    },
                    {
                        "{C:inactive}Devolves after {}{C:attention}#3#{}{C:inactive} round(s){}",
                    },
                },
            },
            j_hatch_divine_smeared = {
                name = "Divine Smeared Joker",
                text = {
                    {
                        "All {C:attention}suits{} count as each other",
                    },
                    {
                        "{C:inactive}Devolves after {}{C:attention}#1#{}{C:inactive} round(s){}",
                    },
                },
            },
            j_hatch_divine_stuntman = {
                name = "Divine Stuntman",
                text = {
                    {
                        "{C:white,X:chips}X#1#{} Chips,",
                        "{C:attention}-#2#{} hand size",
                    },
                    {
                        "{C:inactive}Devolves after {}{C:attention}#3#{}{C:inactive} round(s){}",
                    },
                },
            },
            j_hatch_divine_license = {
                name = "Divine License",
                text = {
                    {
                        "{C:white,X:mult}X#1#{} Mult per",
                        "{C:attention}Enhanced card{}",
                        "in {C:attention}deck{}",
                        "{C:inactive}(Currently {C:white,X:mult}X#2#{C:inactive} Mult)",
                    },
                    {
                        "{C:inactive}Devolves after {}{C:attention}#3#{}{C:inactive} round(s){}",
                    },
                },
            },
            -- Etz Chaim starts here
            j_hatch_etzchaim = {
                name = "Etz Chaim",
                text = {
                    "This Joker gains {X:mult,C:white} X#2# {} Mult",
                    "per {C:attention}consumable{} used this run",
                    "{C:inactive}(Currently {X:mult,C:white} X#1# {C:inactive} Mult)",
                },
            },
            -- Crossmod Jokers start here
            j_hatch_sephiprinter = {
                name = "Sephirot Printer",
                text = {
                    "When Blind is selected,",
                    "print a random",
                    "{C:attention}Sephirot Card{}",
                    "{C:inactive}(Must have room)",
                },
            },
            j_hatch_yababaina = {
                name = "Yababaina",
                text = {
                    "Scored {C:hearts}Heart{} cards",
                    "becomes {C:attention}Sulfur Cards{}",
                },
            },
            j_hatch_eightone = {
                name = "Windows 8.1",
                text = {
                    "Played {C:attention}8s{}",
                    "permanently gain",
                    "{C:red}+#1#{} Mult"
                },
            },
            j_hatch_winnt5 = {
                name = "Windows NT5",
                text = {
                    {
                    "First played {C:attention}5{}",
                    "gives {X:mult,C:white} X#1# {} Mult",
                    "when scored",
                    },
                    {
                    "{C:inactive}Warning, very loud!{}"
                    }
                },
            },
            j_hatch_mint = {
                name = "Linux Mint",
                text = {
                    {
                    "Gain {C:red}+#2#{} Mult per",
                    "{C:attention}successful probability{}",
                    "Lose {C:red}-#2#{} Mult per",
                    "{C:attention}unsuccessful{} probability",
                    },
                    {
                    "{C:inactive}(Currently{} {C:red}+#1#{} {C:inactive}Mult)"
                    }
                },
            },
        }, -- Sephirot (Cards) starts below
        hatch_sephirot = {
            c_hatch_kether = {
                name = "Kether",
                text = {
                    "{C:inactive}Does nothing?",
                },
            },
            c_hatch_chokmah = {
                name = "Chokmah",
                text = {
                    "Enhances {C:attention}#1#{}",
                    "selected cards to",
                    "{C:attention}#2# Cards{}",
                },
            },
            c_hatch_binah = {
                name = "Binah",
                text = {
                    "Enhances {C:attention}#1#{}",
                    "selected cards to",
                    "{C:attention}#2# Cards{}",
                },
            },
            c_hatch_chesed = {
                name = "Chesed",
                text = {
                    "Enhances {C:attention}3{}",
                    "selected cards to a",
                    "{C:green}random{} enhancement",
                },
            },
            c_hatch_gevurah = {
                name = "Gevurah",
                text = {
                    "Creates a random",
                    "{C:dark_edition}Negative{} {C:attention}Joker{}",
                },
            },
            c_hatch_tiferet = {
                name = "Tiferet",
                text = {
                    "Add a {C:green}random{} seal",
                    "to {C:attention}1{} selected",
                    "card in your hand",
                },
            },
            c_hatch_netzach = {
                name = "Netzach",
                text = {
                    "Create a random",
                    "{C:spectral}Spectral{} card",
                    "{C:inactive}(Must have room){}",
                },
            },
            c_hatch_hod = {
                name = "Hod",
                text = {
                    "Decreases rank of",
                    "up to {C:attention}#1#{} selected",
                    "cards by {C:attention}1",
                },
            },
            c_hatch_yesod = {
                name = "Yesod",
                text = {
                    "Enhances {C:attention}#1#{} selected",
                    "card into a",
                    "{C:attention}#2# Card{}",
                },
            },
            c_hatch_malkuth = {
                name = "Malkuth",
                text = {
                    "Create {C:green}Kether{}",
                    "{C:inactive}(Must have room){}",
                },
            },
        }, -- Divine (Cards) starts below
        hatch_divine = {
            c_hatch_daat = {
                name = "Da'at",
                text = {
                    "Create {C:dark_edition}Etz Chaim{}",
                },
            },
            c_hatch_soul_of_hatchet = {
                name = "Soul of Hatchet",
                text = {
                    "A mysterious card with",
                    "a {C:enhanced}unique effect{}",
                },
            },
            c_hatch_soul_of_loveletter = {
                name = "Soul of Love Letter",
                text = {
                    "A mysterious card with",
                    "a {C:enhanced}unique effect{}",
                },
            },
            c_hatch_soul_of_wildside = {
                name = "Soul of Wildside",
                text = {
                    "A mysterious card with",
                    "a {C:enhanced}unique effect{}",
                },
            },
            c_hatch_soul_of_ball = {
                name = "Soul of Steel Ball",
                text = {
                    "A mysterious card with",
                    "a {C:enhanced}unique effect{}",
                },
            },
            c_hatch_soul_of_clover = {
                name = "Soul of Clover",
                text = {
                    "A mysterious card with",
                    "a {C:enhanced}unique effect{}",
                },
            },
            c_hatch_soul_of_banner = {
                name = "Soul of Banner",
                text = {
                    "A mysterious card with",
                    "a {C:enhanced}unique effect{}",
                },
            },
            c_hatch_soul_of_mime = {
                name = "Soul of Mime",
                text = {
                    "A mysterious card with",
                    "a {C:enhanced}unique effect{}",
                },
            },
            c_hatch_soul_of_fist = {
                name = "Soul of Fist",
                text = {
                    "A mysterious card with",
                    "a {C:enhanced}unique effect{}",
                },
            },
            c_hatch_soul_of_space = {
                name = "Soul of Space Joker",
                text = {
                    "A mysterious card with",
                    "a {C:enhanced}unique effect{}",
                },
            },
            c_hatch_soul_of_trousers = {
                name = "Soul of Trousers",
                text = {
                    "A mysterious card with",
                    "a {C:enhanced}unique effect{}",
                },
            },
            c_hatch_soul_of_musketeer = {
                name = "Soul of Musketeer",
                text = {
                    "A mysterious card with",
                    "a {C:enhanced}unique effect{}",
                },
            },
            c_hatch_soul_of_guard = {
                name = "Soul of Guard",
                text = {
                    "A mysterious card with",
                    "a {C:enhanced}unique effect{}",
                },
            },
            c_hatch_soul_of_ritual = {
                name = "Soul of Ritual",
                text = {
                    "A mysterious card with",
                    "a {C:enhanced}unique effect{}",
                },
            },
            c_hatch_soul_of_ballot = {
                name = "Soul of Ballot",
                text = {
                    "A mysterious card with",
                    "a {C:enhanced}unique effect{}",
                },
            },
            c_hatch_soul_of_tree = {
                name = "Soul of Tree",
                text = {
                    "A mysterious card with",
                    "a {C:enhanced}unique effect{}",
                },
            },
            c_hatch_soul_of_summit = {
                name = "Soul of Summit",
                text = {
                    "A mysterious card with",
                    "a {C:enhanced}unique effect{}",
                },
            },
            c_hatch_soul_of_8_ball = {
                name = "Soul of 8-Ball",
                text = {
                    "A mysterious card with",
                    "a {C:enhanced}unique effect{}",
                },
            },
            c_hatch_soul_of_fibonacci = {
                name = "Soul of Fibonacci",
                text = {
                    "A mysterious card with",
                    "a {C:enhanced}unique effect{}",
                },
            },
            c_hatch_soul_of_scholar = {
                name = "Soul of Scholar",
                text = {
                    "A mysterious card with",
                    "a {C:enhanced}unique effect{}",
                },
            },
            c_hatch_soul_of_hiker = {
                name = "Soul of Hiker",
                text = {
                    "A mysterious card with",
                    "a {C:enhanced}unique effect{}",
                },
            },
            c_hatch_soul_of_riffraff = {
                name = "Soul of Riff-Raff",
                text = {
                    "A mysterious card with",
                    "a {C:enhanced}unique effect{}",
                },
            },
            c_hatch_soul_of_rebate = {
                name = "Soul of Rebate",
                text = {
                    "A mysterious card with",
                    "a {C:enhanced}unique effect{}",
                },
            },
            c_hatch_soul_of_vagabond = {
                name = "Soul of Vagabond",
                text = {
                    "A mysterious card with",
                    "a {C:enhanced}unique effect{}",
                },
            },
            c_hatch_soul_of_baseball = {
                name = "Soul of Baseball",
                text = {
                    "A mysterious card with",
                    "a {C:enhanced}unique effect{}",
                },
            },
            c_hatch_soul_of_walkie_talkie = {
                name = "Soul of Walkie Talkie",
                text = {
                    "A mysterious card with",
                    "a {C:enhanced}unique effect{}",
                },
            },
            c_hatch_soul_of_ticket = {
                name = "Soul of Ticket",
                text = {
                    "A mysterious card with",
                    "a {C:enhanced}unique effect{}",
                },
            },
            c_hatch_soul_of_swashbuckler = {
                name = "Soul of Swashbuckler",
                text = {
                    "A mysterious card with",
                    "a {C:enhanced}unique effect{}",
                },
            },
            c_hatch_soul_of_smeared = {
                name = "Soul of Smeared",
                text = {
                    "A mysterious card with",
                    "a {C:enhanced}unique effect{}",
                },
            },
            c_hatch_soul_of_stuntman = {
                name = "Soul of Stuntman",
                text = {
                    "A mysterious card with",
                    "a {C:enhanced}unique effect{}",
                },
            },
            c_hatch_soul_of_license = {
                name = "Soul of License",
                text = {
                    "A mysterious card with",
                    "a {C:enhanced}unique effect{}",
                },
            },

        }, -- Stakes starts below
        Stake = {
            stake_hatch_infernal = {
                name = "Infernal Stake",
                text = {
                    "{C:red}-1{} hand size",
                    "{s:0.8}Applies all previous Stakes",
                },
            },
            stake_hatch_tempest = {
                name = "Tempest Stake",
                text = {
                    "Must beat {C:attention}Ante 10{} to win",
                    "{s:0.8}Applies all previous Stakes",
                },
            },
            stake_hatch_abyssal = {
                name = "Abyssal Stake",
                text = {
                    "{C:attention}Big Blind{} gives",
                    "no reward money",
                    "{s:0.8}Applies all previous Stakes",
                },
            },
            stake_hatch_vernal = {
                name = "Vernal Stake",
                text = {
                    "Shop can have {C:attention}Burdened{} Jokers",
                    "{C:inactive,s:0.8}(Take up an extra slot)",
                    "{s:0.8}Applies all previous Stakes",
                },
            },
            stake_hatch_ethereal = {
                name = "Ethereal Stake",
                text = {
                    "Required score scales even",
                    "faster for each {C:attention}Ante",
                    "{s:0.8}Applies all previous Stakes",
                },
            },
        }, -- Other starts below
        Other = {
            hatch_burdened = {
                name = "Burdened",
                text = {
                    "Purchased {C:attention}Jokers",
                    "take up {C:attention}+1{}",
                    "extra slot"
                },
            },
            hatch_infernal_sticker = {
                name = "Infernal Sticker",
                text = {
                    "Used this Joker",
                    "to win on {C:attention}Infernal",
                    "{C:attention}Stake{} difficulty",
                },
            },
            hatch_tempest_sticker = {
                name = "Tempest Sticker",
                text = {
                    "Used this Joker",
                    "to win on {C:attention}Tempest",
                    "{C:attention}Stake{} difficulty",
                },
            },
            hatch_abyssal_sticker = {
                name = "Abyssal Sticker",
                text = {
                    "Used this Joker",
                    "to win on {C:attention}Abyssal",
                    "{C:attention}Stake{} difficulty",
                },
            },
            hatch_verdant_sticker = {
                name = "Verdant Sticker",
                text = {
                    "Used this Joker",
                    "to win on {C:attention}Verdant",
                    "{C:attention}Stake{} difficulty",
                },
            },
            hatch_ethereal_sticker = {
                name = "Ethereal Sticker",
                text = {
                    "Used this Joker",
                    "to win on {C:attention}Ethereal",
                    "{C:attention}Stake{} difficulty",
                },
            },
            p_hatch_sephirot_normal_1 = {
                name = "Sephirot Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:green} Sephirot{} cards to",
                    "be used immediately",
                },
            },
            p_hatch_sephirot_normal_2 = {
                name = "Sephirot Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:green} Sephirot{} cards to",
                    "be used immediately",
                },
            },
            p_hatch_sephirot_jumbo_1 = {
                name = "Sephirot Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:green} Sephirot{} cards to",
                    "be used immediately",
                },
            },
            p_hatch_sephirot_mega_1 = {
                name = "Sephirot Pack",
                text = {
                    "Choose {C:attention}#2#{} of up to",
                    "{C:attention}#3#{C:green} Sephirot{} cards to",
                    "be used immediately",
                },
            },
            p_hatch_divine_pack = {
                name = "Divine Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:dark_edition} Divine{} cards to",
                    "be used immediately",
                },
            },
        }, -- Sleeves starts below
        Sleeve = {
            sleeve_hatch_Chevron = {
                name = "Chevron Sleeve",
                text = {
                    "{C:attention}-2{} hand size",
                    "{C:red}+2{} discards every round"
                }
            },
            sleeve_hatch_Holy = {
                name = "Holy Sleeve",
                text = {
                    "{C:green}Sephirot{} cards may",
                    "appear in the shop,",
                }
            },
            sleeve_hatch_Harlequin = {
                name = "Harlequin Sleeve",
                text = {
                    "{C:attention}+1{} booster pack per shop",
                }
            },
        }
    },
    misc = {
        challenge_names = {
            c_hatch_massacre = "Massacre",
            c_hatch_upsidedown = "Upside Down",
            c_hatch_pillowfight = "Pillow Fight",
            c_hatch_stockmarket = "Stock Market",
            c_hatch_skyhigh = "Sky High",
            c_hatch_blindspot = "Blind Spot",
            c_hatch_treeoflife = "Tree of Life",
            c_hatch_etherealchev = "Ethereal Chevron Needle",
        },
        dictionary = {
            b_hatch_sephirot_cards = "Sephirot Cards",
            b_hatch_divine_cards = "Divine Cards",
            k_hatch_evolved = "Evolved",
        },
        labels = {
            hatch_evolved = "Common",
            hatch_burdened = "Burdened",
            hatch_divine = "Divine",
            hatch_sephirot = "Sephirot",
        },
    }
}
