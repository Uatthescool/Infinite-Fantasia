# Infinite Fantasia — Design Ledger

**Version:** 0.128  
**Started:** August 23, 2026  
**Project phase:** Prototyping  
**Purpose:** Maintain a single, living record of what Infinite Fantasia is, which decisions are settled, what remains provisional, and why important choices were made.

This is a design ledger, not yet a complete game design document. It should record decisions as they happen and prevent settled ideas from being unintentionally overwritten. Detailed specifications can later branch into separate combat, class, content, interface, technical, and production documents.

## Status Language

| Status | Meaning |
| --- | --- |
| **Locked** | Accepted as part of the game unless a later decision explicitly supersedes it. |
| **Proposed** | Current recommendation; not accepted yet. |
| **Open** | Requires a design decision or experiment. |
| **Testing** | Implemented in a prototype but not yet validated. |
| **Superseded** | Replaced by a later ledger entry; retained for history. |
| **Rejected** | Considered and deliberately excluded. |

## 1. Current Product Definition

### IF-VIS-001 — Central Fantasy

- **Status:** Locked
- **Decision:** Infinite Fantasia is built around discovering and creating a character class through combinations of small, foundational fantasy classes.
- **Player promise:** “My class is the result of the path I built, and changing one ingredient can create a meaningfully different identity.”
- **Reasoning:** The class-combination tree is the concept that distinguishes the project from a conventional fantasy RPG with a fixed class roster.

### IF-VIS-002 — Long-Term Form

- **Status:** Proposed
- **Decision:** Preserve the original online multiplayer/MMORPG-shaped ambition as the long-term direction, but do not begin production by building an MMO.
- **First product target:** A polished, locally playable 2D RPG vertical slice that proves the eight foundational class identities without implementing advanced class combinations. Online multiplayer and class combination become later milestones after the base combat model is fun and stable.
- **Reasoning:** Networking, persistence, accounts, live operations, server authority, social systems, and large-scale content would multiply risk before the central mechanic has been validated.

### IF-VIS-003 — DCMC Separation

- **Status:** Proposed
- **Decision:** Treat the older DCMC online card-game concept as a separate project unless an explicit later decision connects it to Infinite Fantasia.

## 2. Design Pillars

### IF-PIL-001 — Small Foundations, Large Outcomes

- **Status:** Locked
- Base classes must be compact, broadly useful identities rather than near-complete advanced classes.
- Their interactions should create the complexity.

### IF-PIL-002 — Composition Creates Identity

- **Status:** Locked
- The ingredients a player chooses determine the resulting class.
- Order does not matter; composition and repetition do.

### IF-PIL-003 — Repetition Means Specialization

- **Status:** Locked
- Repeating a base class distills that fantasy instead of wasting a selection.
- A pure AAA build should feel like the most complete expression of its base class.

### IF-PIL-004 — Hybrids Must Be More Than Addition

- **Status:** Proposed
- Hybrid classes should contain at least one mechanic that changes how their ingredients interact. Simply receiving separate Warrior and Mage abilities is not enough to make a convincing Warrior–Mage class.

### IF-PIL-005 — Readable Fantasy

- **Status:** Locked
- Class names and major mechanics should communicate a strong, recognizable fantasy.
- Equipment associated with a class is typical flavor, not an absolute restriction on later combinations.

### IF-PIL-006 — Player Control Over Guaranteed Performance

- **Status:** Proposed
- When appropriate, systems may trade a measure of automatic or guaranteed efficiency for increased player control. This should create meaningful decisions, not merely extra input.

### IF-PIL-007 — Configurability Without Friction

- **Status:** Locked as a design principle
- When a behavior can be made configurable at reasonable implementation and interface cost, and doing so would improve play without undermining balance or the game's identity, Infinite Fantasia should plan to make it configurable.
- Provide a strong default and a small number of readable presets before exposing advanced controls.
- Configuration should prevent repetitive prompts and routine menu labor rather than move that labor into a more complicated settings screen.
- Similar edge cases should inherit an established policy whenever possible instead of requiring separate player confirmation or a new design decision.
- Core rules do not need to become optional when variation would compromise encounter balance, technical reliability, multiplayer fairness, or the intended experience.

### IF-PIL-008 — Automate Resolved Friction

- **Status:** Locked as a design principle
- Once the player has made the meaningful decision and completed the interesting part of an interaction, automate purely repetitive reversal, cleanup, or confirmation whenever doing so preserves the outcome.
- Automation should remove real-time chores such as manually retracing a solved infiltration route, repeating routine recovery inputs, or waiting through an interaction whose outcome is already settled.
- Automation must not erase unresolved danger, conceal new information, make a choice on the player's behalf, bypass an unsolved obstacle, or remove a tactically meaningful cost.
- A brief transition, animation, or acknowledgement may communicate what happened, but it should not become a disguised time sink.
- Similar situations should inherit this principle unless a deliberate gameplay reason makes the return journey or cleanup itself meaningful.

## 3. Presentation Direction

### IF-FMT-001 — 2D RPG Structure

- **Status:** Proposed
- Use an early-*Final Fantasy*-style 2D game structure rather than higher-dimensional action gameplay.
- The working hybrid is:
  - Top-down, tile-based exploration for towns, routes, and dungeons.
  - A separate turn-based battle scene.
  - Larger and more animated combat sprites inspired by the original *Brave Frontier* mobile game.
- **Reasoning:** This focuses production on combat rules, class identity, interface, maps, sprites, and effects instead of 3D models, skeletal animation, free-camera behavior, navigation meshes, and action collision.

### IF-FMT-002 — Scalable Battle-Art Target

- **Status:** Proposed
- Capture the energy of original *Brave Frontier* through composition and feedback before attempting its full art density.
- Initial character animation budget should center on a small reusable state set: idle, basic attack, class action/cast, hit, incapacitated, and victory.
- Impact flashes, screen motion, projectiles, particles, damage numbers, sound, and timing should provide much of the spectacle.
- More elaborate class-specific animation can be added after the battle system is validated.

## 4. Proposed Combat Model

### IF-CBT-001 — Battlefield Zone System

- **Status:** Proposed
- Battles retain a classic side-on presentation, normally placing player characters on the right and enemies on the left.
- Combatants occupy a small number of meaningful zones rather than exact grid coordinates.
- A standard open battlefield may contain Melee, Midrange, and Backline zones.
- Battlefield templates may add, remove, connect, restrict, or modify zones. An interior may have only two cramped zones; a cliff encounter may add High Ground and Cliff Edge zones.
- Movement between connected zones costs action economy and may trigger engagement rules, reactions, hazards, or class abilities.
- Forced movement can push, pull, exchange, or otherwise relocate combatants. Environmental defeat is possible when the battlefield and target state justify it.

### IF-CBT-002 — Interactable Battle Scenes

- **Status:** Proposed
- Battle scenes contain selectable objects and environmental features anchored to zones.
- Characters may spend actions or action points interacting with these features.
- Examples include shooting an oil barrel, electrifying water, breaking cover, dropping a suspended object, opening or barricading a route, or climbing to a firing position.
- Objects should use reusable tags and state transitions rather than encounter-specific scripts wherever possible. Example states include intact, leaking, wet, burning, electrified, frozen, broken, and destroyed.
- Classes should interact with the same objects differently, allowing the environment to express class identity outside of ordinary attacks.

### IF-CBT-003 — Curated Variability

- **Status:** Proposed
- Battlefields may select props, hazards, and special zones from curated encounter templates.
- Randomness should change tactical opportunities without deciding whether the encounter is fair or solvable.
- Each generated variation must remain visually readable and should contain at least one intentional interaction opportunity.
- Interactables must be discoverable through clear highlighting or a tactical-view function; the system must not become pixel hunting.

### IF-CBT-004 — Shared Rules for Enemies

- **Status:** Proposed
- Enemies should understand and use the same zone, forced-movement, object, and environmental-reaction rules available to the player.
- The limited number of zones should make this behavior more tractable than unrestricted grid navigation.
- Enemy intent may be telegraphed so players can reposition, protect an object, interrupt a setup, or deliberately bait an interaction.

### IF-CBT-005 — First Combat-System Test

- **Status:** Proposed
- Begin with three standard zones plus at most one battlefield-specific special zone.
- Test three battlefield templates: open field, cramped interior, and cliff or elevated terrain.
- Begin with a small reusable prop vocabulary: volatile container, liquid surface, cover/support object, and climbable or positional feature.
- Test forced movement, one environmental reaction chain, and enemy use of the system before expanding the object library.
- Initiative structure, reactions, engagement rules, and exact range calculations remain open.

### IF-CBT-006 — Continuous Character Action Gauges

- **Status:** Locked at concept level
- Every character has an individual continuous Action Gauge rather than a small displayed integer of action points.
- Actions deplete portions of the gauge. Costs may be fractional and need not resolve to a visible whole-number economy.
- The gauge is an abstraction of how much meaningful activity that character can still perform during the current turn or activation window.
- Basic attacks, shoves, physical interactions, movement, zone transitions, and other ordinary actions consume different portions of the gauge.
- Spells, class abilities, and class-specific passives normally use the character's class resource rather than the Action Gauge.
- Specific passives or exceptional effects may interact with Action Gauge costs, but paying both Action Gauge and class resource is not the default structure.

### IF-CBT-007 — Free-Form Click-to-Move

- **Status:** Locked at concept level
- Movement uses point-and-click navigation similar in feel to *RuneScape*, not tile-by-tile commands or a fixed Move action.
- Characters can select any reachable point within their current zone, subject to terrain, collision, engagement, and hazards.
- Movement within a zone consumes a small continuous portion of the Action Gauge based on the path taken.
- Crossing into another zone adds a larger transition cost and may trigger reactions, hazards, class abilities, or other zone rules.
- A single destination click calculates the complete path and cost; repeatedly issuing tiny movement commands should never reduce the total cost.
- Zones determine broad tactical state, while exact position within a zone may determine proximity to objects, local area effects, and the physical presentation of interactions.

### IF-CBT-008 — Visible Cost Preview, Hidden Modifiers

- **Status:** Locked at concept level
- Before committing to any action other than direct movement input, the interface previews how much of the selected character’s Action Gauge the proposed action will consume.
- Movement previews its path and projected gauge depletion before commitment wherever input flow permits.
- The preview should appear as a temporary or ghosted segment on the gauge and may be linked visually to the selected target, object, or destination.
- Classes possess internal cost increases and reductions for different action categories. Equipment, conditions, terrain, and other effects may modify them further.
- Exact internal multipliers need not be displayed, but their combined result must be reflected accurately in the preview.
- This follows the rule: hidden calculation, visible consequence.

### IF-CBT-009 — Continuous Radial Range

- **Status:** Core geometry, footprint-overlap test, and preview requirement locked; numerical units remain open
- Zones classify broad tactical territory, terrain, and positional effects; they do not divide ability range into discrete zone steps.
- Every combatant retains a precise continuous position within its current zone on both the horizontal and vertical axes of the battlefield.
- A standard ranged ability defines a maximum distance **X** from its source's current focal point. Its eligible reach forms a circle centered on that point and may cross any number of zone boundaries that physically fall inside the radius.
- Moving within a zone changes the source point. Moving toward the right, left, top, or bottom of a zone therefore extends reach in that direction and reduces reach in the opposite direction even when the source never changes zones.
- Zone membership alone never makes a target reachable or unreachable. The source and target's actual positions determine whether they satisfy the ability's distance requirement.
- Selecting a ranged ability must display its exact reach on the battlefield before commitment. Eligible and ineligible targets must be unmistakable so continuous positioning creates tactics rather than pixel guessing.
- Ability-specific shapes, line of sight, cover, terrain obstruction, and other targeting restrictions may further narrow the targets inside the geometric range when explicitly applicable.
- A target is inside radial range when the range circle touches or overlaps any part of its combat footprint as defined by IF-CBT-010; its focal point does not need to be inside the circle.
- The standard distance unit and conversion between data and screen coordinates remain open.

### IF-CBT-010 — Combat Footprints

- **Status:** Core targeting geometry locked; exact actor shapes and secondary uses deferred
- Every combatant has an invisible two-dimensional **combat footprint** used for spatial targeting tests.
- A combat footprint is larger than a single focal point but deliberately smaller than the combatant's complete displayed artwork.
- Decorative extremities, animation overshoot, visual effects, weapons, hair, wings, and other sprite details may extend beyond the footprint without changing whether the combatant is in range.
- Touching any portion of the combat footprint is sufficient for an otherwise valid range circle to reach that combatant. This prevents center-point precision from turning positioning into pixel hunting.
- Footprints may differ by combatant body size and form, but they must remain stable, predictable, and visually fair across animations.
- Exact footprint dimensions and shapes, their debugging display, and whether the same geometry also governs movement collision, body blocking, melee contact, or area-effect resolution remain open.

### IF-CBT-011 — Standard Sound Propagation

- **Status:** Core propagation rule locked; exceptional materials and detection interactions deferred
- Sound effects use continuous radial distance from their stated source unless the individual effect explicitly defines another origin or shape.
- Combatants, companions, ordinary props, ordinary cover, and visual line-of-sight obstructions do not block sound propagation.
- A solid wall or sealed barrier between the sound's source and a potential receiver blocks the effect even when the receiver's combat footprint lies inside the sound's radius.
- Open doors, gaps, porous structures, and ordinary battlefield cover do not count as sealed sound barriers unless explicitly classified otherwise.
- The standard system does not simulate acoustic reflection, diffraction, attenuation, or routing around a blocking wall. It uses one clear radial range plus the solid-barrier check.
- Range and target previews must show which otherwise-nearby combatants are excluded by a sound-blocking barrier.
- Explicit effects and materials may later be **Soundproof**, amplify sound, extend its radius, create another origin point, or otherwise override the baseline.
- The relationship between sound, stealth, awareness, deafness, Silence, and environmental noise remains open for their respective systems.

### IF-CBT-012 — Default Random Midrange Deployment

- **Status:** Universal default and no-manual-formation rule locked; passive override order and random distribution details remain open
- At the beginning of every battle, each ordinary combatant defaults to a random valid starting position within its own side's **Midrange** band.
- Party combatants roll positions independently inside Party Midrange. Enemy combatants roll positions independently inside Enemy Midrange.
- A valid starting position must remain inside the assigned band, fit the combatant's footprint, avoid overlapping another combatant or solid object, and satisfy the battlefield's walkability rules.
- The fixed battlefield and environmental layout is established before random combatant placement. Cover, range, proximity, and environmental opportunities therefore vary naturally according to the generated positions.
- Random deployment does not assign any combatant to Melee or Backline by default. A class feature, companion effect, enemy trait, encounter rule, equipment effect, or other explicit passive may change a combatant's starting band or position later.
- Attached companions do not roll independent positions. Each companion begins beside and moves with its master under the established attached-companion rules.
- After random deployment and any valid deployment passives resolve, the player receives no free manual formation phase, drag-and-drop adjustment, or prebattle movement allowance.
- The battle begins from the resulting positions. Any repositioning performed after initiative starts uses the ordinary movement, Action-Gauge, zone-transition, collision, and hazard rules.
- The interface may reveal and briefly frame the generated battlefield before the first activation, but inspection does not permit free placement changes.
- Deployment passives modify the default rather than requiring separate encounter scripting. Exact priority when multiple deployment effects conflict, random-distribution weighting, seed handling, and safeguards against tactically extreme but technically valid formations remain open.

### IF-CBT-013 — Unified Click and Direct Movement Input

- **Status:** Core input contract locked; pathfinding and numerical tuning remain open
- Battle movement supports both point-and-click travel and continuous **WASD or Arrow-key** control of the currently selected combatant.
- Hovering a valid battlefield destination previews the route, destination footprint, crossed zone boundaries, resolved Action-Gauge cost, and linked ghost depletion on the selected character's Gauge. One left-click commits that valid route immediately without requiring a second confirmation.
- Holding a movement key moves the selected combatant directly and depletes Action Gauge continuously according to actual distance traveled. Diagonal input is normalized so it provides no speed or Gauge-efficiency advantage.
- Beginning direct keyboard movement cancels an active click route. Releasing the keys stops movement without adding a separate action or refunding Gauge already spent.
- Both input methods resolve through the same movement-cost, zone-transition, collision, terrain, hazard, and modifier pipeline. Switching input methods must never produce a cheaper result for the same actual path.
- Within-zone travel has a continuous distance cost. Every crossed zone boundary adds the applicable transition cost and effects. Movement stops at battlefield limits, blocking footprints, impassable objects, or the farthest point affordable with the remaining Gauge.
- Hidden class, equipment, condition, and terrain modifiers alter the common resolved cost rather than creating different mouse and keyboard rules. Their combined consequence remains visible through the Gauge and preview under IF-CBT-008.
- Prototype 0.0.2 may accept only an unobstructed direct click route while WASD allows manual steering around collision. Full pathfinding may replace that temporary limitation without changing this input contract.

### IF-CBT-014 — Command-First Basic Attack Targeting

- **Status:** Locked; revised after the accepted Prototype 0.0.3 test; exact numerical tuning remains open
- A character's **Basic Attack** is defined by the currently equipped weapon rather than being permanently hardcoded into the named class. The weapon supplies the attack's reach, Action-Gauge cost, damage, applicable tags, and any other attack-specific properties.
- Selecting **Attack** from the temporary command tray enters a targeting mode before any target is chosen. Every currently valid enemy or compatible environmental object becomes visibly eligible under one shared targeting layer.
- Hovering a candidate displays the attack's exact radial reach, whether the target is in range, proposed Action-Gauge cost, resolved Accuracy, and projected damage before commitment. One left click on a valid affordable target commits the attack.
- An out-of-range candidate remains inspectable but is clearly marked **Out of Range**. The player must reposition manually before attacking; the prototype does not combine movement and attack into one automatic pathing command.
- A Basic Attack has a hard default limit of **one committed use per combatant turn**. The use is consumed when the attack is committed whether the Accuracy roll hits or misses, and the attack still pays its ordinary Action-Gauge cost.
- The limit resets when that combatant begins its next eligible initiative turn. Switching between allies in a shared block does not restore a spent use.
- A weapon may explicitly define a different Basic Attack use limit, and an explicit class passive may modify that limit. Without one of those stated exceptions, repeated Basic Attacks during the same turn are prohibited even when Action Gauge remains.
- After the default Basic Attack resolves, Attack mode closes and the command displays **Attack Used** for that combatant. Right click or Escape still cancels an uncommitted targeting mode.
- Ordinary Basic Attacks cannot directly target allies. Friendly fire occurs only through an action, area effect, environmental reaction, or other rule that explicitly permits it.
- The Prototype 0.0.3 party demonstrates three weapon profiles: the Warrior's close-range sword, the Archer's long-range bow, and the Mage's close-range staff. Their exact values are prototype tuning rather than locked balance.

### IF-CBT-015 — First Complete Battle Resolution Loop

- **Status:** Locked for Prototype 0.0.3; implemented with provisional numerical tuning and accepted in the Windows engine test
- Prototype 0.0.3 is the first **winnable-or-losable** battle rather than a one-sided targeting sandbox.
- Party members, enemies, and destructible objects possess working Health where appropriate. A successful damaging attack reduces current Health; reaching zero defeats a combatant or destroys the applicable object.
- Defeated combatants immediately leave ordinary targeting and collision while retaining a defeated marker in the initiative ribbon. Empty initiative blocks are skipped without changing the stable relative order of surviving blocks.
- Defeating all enemies produces Victory. Defeating all three party members produces Defeat. Either result stops further actions and offers Retry with a fully reset random deployment or return to town.
- The two crates use their previously locked modest durability, cover, and collision behavior. Destroying one removes its cover and collision. The intact oil barrel follows its locked first-damaging-hit rupture rule and creates an Oiled surface; ignition remains deferred until an Ignite-capable ability exists.
- Base Accuracy, additive cover, target Dodge, Action-Gauge expenditure, radial footprint range, damage, and object compatibility resolve through shared functions rather than separate player and enemy exceptions.
- All Health, damage, range, cost, and durability values introduced in this checkpoint are isolated prototype tuning. They test the loop without becoming final balance commitments.
- Prototype-only movement speed, cost per pixel, zone surcharge, and debug numbers are testing constants rather than locked balance values.

### IF-TURN-001 — Initiative Blocks

- **Status:** Initiative-block concept and same-side exact-tie rule locked
- Every combatant receives a position in the initiative order.
- Consecutive allied combatants in that order form a shared initiative block.
- All members of a block may act before initiative passes to the next opposing block.
- An enemy initiative position interrupts allied coordination and separates the allied characters on either side into different blocks.
- High initiative can therefore create larger coordinated blocks without guaranteeing that the entire party always acts before every enemy.
- Enemies follow the same block rules and may coordinate within uninterrupted enemy blocks.
- Combatants from the same side with exactly equal Initiative share the same initiative position and activation group rather than receiving arbitrary separate placements.
- Members of a tied group may resolve movement and actions one at a time for animation, state tracking, and rules clarity, but initiative cannot pass to the opposing side between them.
- Each resolved action updates the battlefield before the next tied combatant acts. Sharing an initiative time does not make their consequences mechanically simultaneous or cause later actions to ignore earlier state changes.
- Resolution of an exact Initiative tie between opposing sides remains open.

### IF-TURN-002 — Interwoven Allied Actions

- **Status:** Locked at concept level
- Within an initiative block, the player may switch freely among eligible allied characters.
- A character may spend part of its Action Gauge or class resources, yield to another ally in the same block, and resume acting later before the block ends.
- This permits deliberate sequences involving forced movement, environmental objects, surfaces, buffs, debuffs, and cross-class ability combinations.
- A character cannot resume after the block has been committed or initiative has passed to the next block.
- Exact rules for ending a block, marking a character finished, reactions, and initiative modification remain open.

### IF-TURN-003 — Stable Battle Initiative

- **Status:** Locked at concept level
- Each combatant's foundational Initiative is established once at the beginning of battle and remains stable across rounds.
- Initiative does not reroll automatically each round.
- At the beginning of each new initiative set, active Initiative modifiers are applied to those stable foundational values to form that set's order and initiative blocks.
- Specific abilities, conditions, battlefield events, or other explicit effects may alter initiative.
- Changes take effect when the next initiative set is formed rather than rearranging the set currently being resolved, preventing surprise double activations or lost turns.
- Any proposed initiative change must be previewed before the player commits the causing action.

### IF-TURN-004 — Prototype 0.1 Foundational Initiative Order

- **Status:** Relative order and block structure locked; numerical Initiative values remain open
- Prototype 0.1 assigns foundational Initiative values that produce this opening order: **Archer → Warrior → tied Sludge group → Mage → Drowsing Toad**.
- Because Archer and Warrior are consecutive party combatants, they form the first shared allied initiative block and may interweave actions under IF-TURN-002. They are not required to have equal Initiative values.
- Both Sludges occupy the next exact Initiative position as the tied enemy group defined by IF-TURN-001 and IF-ENM-001.
- The Sludge group interrupts the party sequence. Mage therefore forms a later single-character allied block rather than joining Archer and Warrior.
- Drowsing Toad forms the final single-enemy block in the set.
- Without active Initiative modifiers, the same relative order repeats when each new initiative set is formed. Approved modifiers may change a future set under IF-TURN-003 without rewriting the combatants' foundational values.
- Companions remain nested under their masters and add no positions to this order.
- Exact Initiative numbers and spacing between values remain deferred to the prototype numerical pass.

### IF-TURN-005 — Active-Block Selection and Block Exit

- **Status:** Locked
- When an allied initiative block begins, the first available ally in that block is selected automatically so combat begins in a ready state rather than waiting for a redundant selection.
- The player may switch among eligible allies by clicking a battlefield combatant or its persistent HUD panel. Keyboard/controller cycling may provide the same operation without becoming a separate rule.
- Only members of the current allied block are selectable for action. Attempting to select an ally whose initiative has not arrived communicates that the character is waiting rather than silently changing the active block.
- Switching preserves every character's position, spent Action Gauge, resource expenditure, PP, companion readiness, and resolved actions. Returning to an earlier ally in the same block never refreshes or rewinds that character.
- The block uses one **End Block** command rather than separate per-character End Turn commands. Committing it forfeits the remaining opportunities of every ally in the active block and passes initiative to the next block.
- When meaningful actions remain, End Block requires one concise confirmation. If no active member has any legal action remaining, the block may advance without the redundant warning.
- Reaching zero Action Gauge does not automatically finish a combatant or end the block because resource abilities, free companion commands, passives, items, or other legal actions may remain available.
- Once End Block is committed or another rule advances initiative, no member of that block may resume until its next eligible activation.

### IF-UI-001 — At-a-Glance Initiative Ribbon

- **Status:** Core ribbon and exact-tie grouping presentation locked; internal tied-resolution order remains open
- The complete initiative order remains visible during battle in a clean ribbon or timeline.
- Each combatant is represented primarily by a recognizable portrait or silhouette placed in exact activation order.
- Consecutive allies are enclosed within a shared visual block so available coordination is immediately apparent.
- Combatants sharing one exact Initiative position appear as distinct portraits side by side inside one outlined initiative slot rather than being collapsed into a single portrait or count badge.
- When a tied group activates, the shared slot and every portrait inside it highlight together. Each combatant remains individually recognizable and inspectable despite the group highlight.
- If a tied member is removed from battle, its individual portrait follows the ordinary completed-or-defeated presentation and the shared slot updates without implying that the surviving member lost its activation.
- The current block is strongly highlighted; completed members dim without disappearing; the selected character receives a separate focus indicator.
- The next opposing interruption must be visually obvious without requiring hover text.
- Team identity uses color plus spacing, border shape, direction, insignia, or another redundant cue. Essential information must not depend on color alone.
- Only information that changes initiative belongs on the initiative ribbon. Health, resources, ordinary status effects, and other combat details remain elsewhere unless temporarily relevant.
- When an explicit effect changes initiative, affected portraits preview their destination and then slide cleanly to the new position.
- The display prioritizes immediate decoding over decoration, animation density, or exhaustive information.

### IF-UI-002 — Universal Mechanical Description Language

- **Status:** Locked as a design objective; exact grammar remains open
- Every mechanically relevant game object must use one shared description language, including equipment, weapons, active abilities, passive abilities, companions, enemies, conditions, environmental objects, and overworld interactions.
- The language must communicate exact numbers, triggers, targets, costs, limits, durations, ranges, conditions, and results with the fewest words compatible with complete accuracy.
- Identical mechanics must always use identical terms and clause structures. Descriptions must not substitute decorative synonyms for established rules language.
- Information should appear in a predictable order so players can locate important values without rereading the entire description.
- Flavor text, lore, and personality may accompany a mechanic but must remain visually and grammatically separate from binding rules text.
- A mechanic that cannot be expressed cleanly through the shared language should prompt revision of the language or the mechanic rather than receiving an unexplained one-off wording exception.
- The description grammar and canonical glossary should be established before large-scale class, item, companion, and encounter authoring begins.

### IF-UI-003 — Tag-Led Skill Descriptions

- **Status:** Locked at concept level; exact layout remains open
- Mechanical descriptions contain no decorative or colorful prose. Flavor, when present elsewhere, cannot carry rules information.
- Every skill has a compact set of visible mechanical tags drawn from one canonical game-wide dictionary.
- Tags may identify elemental damage, non-elemental damage form, status or interaction properties, targeting behavior, and reusable battle or overworld permissions.
- Example: **Flame Lance** may display **Fire**, **Piercing**, and **Ignite**. **Fire** identifies its element, **Piercing** identifies its non-elemental damage form, and **Ignite** grants the skill's standardized interaction with valid flammable targets or objects.
- Example: **Ice Hammer** may display **Ice** and **Bludgeoning**, plus only the interaction tags for the specific freezing or crushing permissions it actually possesses.
- A tag must mean the same thing everywhere it appears. If two effects behave differently, they require different tags or explicit parameterization.
- Reusable secondary effects should normally be expressed through tags. A unique effect that does not have a canonical reusable definition remains a short rules clause rather than creating misleading tag semantics.
- Not every skill needs an overworld interaction tag; such utility is assigned deliberately.
- Hovering a tag reveals its complete definition. Controller focus, keyboard focus, and touch inspection must provide the same information so no rule depends on mouse hover alone.

### IF-UI-004 — Minimal Skill Rules Block

- **Status:** Locked at concept level; exact visual layout remains open
- The default skill display contains only its name, tags, required costs and use limits, range or target information, and the shortest complete statement of its unique result.
- A direct-damage skill such as **Fireball** may use the entire core effect line **Deal 6 damage.** when its tags and adjacent fields already communicate every other rule.
- Costs, range, PP, and other frequently compared values should use consistent labeled fields or icons rather than being buried in sentences.
- The ordering of fields and tag categories remains fixed across every skill.
- Spells and class abilities display their class-resource cost and PP rather than an Action Gauge cost. The earlier Fireball Action Gauge example was a misstatement and does not revise the combat-resource rules.

### IF-UI-005 — Equipment Stat Strip

- **Status:** Locked at concept level
- Equipment presents direct numerical changes as a compact stat strip, such as **HP +10**, **Fire Defense +2**, or **Piercing Defense +1**.
- Equipment does not restate these values in prose.
- Additional reusable mechanics appear as canonical tags with inspectable definitions.
- A bespoke effect that cannot be represented truthfully by an existing tag uses the same short rules-clause grammar as skills.
- Equipment comparison should expose changed values immediately without requiring tag inspection.

### IF-EQP-001 — Resource-Based Equipment Requirements

- **Status:** Locked at concept level
- Equipment may require access to a specific class resource rather than requiring a specific named class.
- The concise equipment field uses the form **Requires: [Resource]**. The Lesser Storm Elemental's summoning amulet displays **Requires: Mana**.
- Eligibility checks whether the character currently possesses the required resource bar. It does not check whether the character is named Mage.
- A future Mage hybrid that retains Mana therefore qualifies to equip the amulet regardless of its combined class name or the order of its base-class selections.
- This pattern may later support equipment requiring Resolve, Faith, Focus, multiple resources, or another explicitly stated resource combination.
- Behavior when a class change would make already equipped gear invalid remains open.

### IF-UI-006 — Visible Results, Hidden Formulas

- **Status:** Locked as a design direction; percentage presentation remains open
- Default descriptions show the exact outputs and player-facing values needed to make a decision rather than exposing the complete mathematical formula behind them.
- Detailed calculations, scaling sources, and tag definitions remain available through inspection for players who want them.
- Hiding formulas must not hide the current resolved consequence of a proposed action; previews should expose the result or chance that matters at the point of commitment.
- The forthcoming accuracy, probability, and percentage system must follow the same layered-information principle.

### IF-UI-007 — Prototype Battle-Screen Wireframe A

- **Status:** Locked for Prototype 0.1; subject to playtest revision
- Design the battle interface as three persistent horizontal regions within the native canvas:
  - A thin initiative ribbon across the top.
  - A large central battlefield.
  - A compact three-character party HUD across the bottom.
- Prototype 0.1 will begin with **36 pixels** for initiative, **238 pixels** for the battlefield, and **86 pixels** for the party HUD, totaling the 360-pixel canvas height.
- The working open-field model uses five left-to-right depth bands: **Enemy Backline**, **Enemy Midrange**, **shared Melee**, **Party Midrange**, and **Party Backline**.
- The five bands are an interface representation of relative combat depth, not a visible tile grid. Exact position inside a band still supports click-to-move, proximity, local effects, and object interaction.
- Battlefield-specific spaces such as High Ground, Cliff Edge, or a cramped interior may overlay, replace, merge, or remove ordinary bands rather than forcing every encounter into the same geometry.
- Each of the three persistent party panels shows its character and attached companion together with the five-slot bar architecture defined by IF-UI-014. A base class occupies Health, Action Gauge, and one class-resource slot while the two remaining class-resource positions stay visually absent but spatially reserved.
- The selected character receives a clear focus state. Proposed Action-Gauge cost appears as a ghosted segment directly on that character's gauge.
- Commands appear in a temporary tray while a character is selected rather than permanently consuming a large part of the battlefield.
- This template is a build target rather than a permanent final-interface commitment. Exact proportions, spacing, command placement, iconography, and narrow-window behavior may be revised when direct playtesting exposes a readability or usability problem.

### IF-UI-008 — Companion-Replacement Confirmation

- **Status:** Locked
- When equipping an item-granted companion into an occupied companion slot, show a confirmation popup before changing equipment.
- The popup names the currently assigned companion, names or identifies the incoming summon, and states that the assigned companion will return safely to the available expedition roster.
- The player may confirm or cancel. Canceling leaves both the equipment and companion assignment unchanged.
- Equipping the item into an empty companion slot requires no replacement warning.
- This warning communicates a reversible but tactically meaningful consequence and should remain short enough to decode immediately.

### IF-UI-009 — Expression-Driven Portrait System

- **Status:** Core architecture, protagonist exception, one-speaker presentation, fixed left anchor, and standard crop locked; exact dimensions, expression roster, and content tiers remain open
- Portraits are a primary emotional acting layer rather than static identity icons. Important dialogue and reactions may change the displayed portrait expression while allowing overworld and battle sprites to remain deliberately simple.
- Dialogue displays at most one character portrait at a time: the current authored speaker. A change of speaker replaces the portrait rather than keeping multiple conversational portraits visible simultaneously.
- The full dialogue portrait always occupies one fixed position on the **left side** of the dialogue box. It does not alternate sides according to speaker, relationship, or scene composition. Speaker and expression changes occur within the same reserved portrait region so the interface reads consistently from portrait identification into speaker name and dialogue text without changing text width or rhythm.
- The player-created protagonist receives no authored emotional portrait library and no dialogue portrait that dictates how the player character feels. The player supplies the protagonist's emotional interpretation.
- The protagonist may still use a neutral, character-creation-derived identity image where mechanically necessary, including the party menu, character sheet, initiative ribbon, or targeting interface. This image identifies the character without asserting an authored emotional response.
- The two authored starting party members receive extensive reusable expression libraries. Because their histories and personalities are fixed, their portraits may communicate deliberate emotional interpretations of events.
- The two authored party members are intended to interact with and comment on a large portion of exploration, conversations, discoveries, combat developments, and other contextual events. Their recurring reactions should make them feel observant and continuously present in the journey, taking inspiration from the reactive companion presence of *Dragon's Dogma 2* without copying its dialogue or characters.
- Expression changes are authored as deliberate acting beats. They may occur between dialogue messages and, when supported by the dialogue system, during a message without requiring a speaker change.
- Portrait artwork uses a consistent square composition and stable character framing so changes in eyes, mouth, posture, and other expressive features remain immediately legible.
- The standard composition is a tight **head-and-shoulders crop** rather than a torso-focused bust. The face and its expression receive visual priority, while hair, headwear, shoulders, and a limited amount of clothing preserve character identity without competing for the small frame.
- The interface must request portraits through structured data such as **Character + Expression + Orientation + Presentation**, not through a single permanently assigned image. Prototype placeholders must preserve this architecture even though a complete expression library is outside Prototype 0.1.
- Dialogue UI must reserve a square portrait region from its first implementation. When the protagonist speaks or selects a response, that region may collapse or remain intentionally empty rather than displaying a fabricated emotion. The same portrait system must support enlarged dialogue presentation, character and party menus, reduced initiative-ribbon presentation, and contextual battle reactions without assuming identical framing or scale in every context.
- Initiative portraits remain calm and readable by default rather than cycling continuously. Contextual expression changes may later punctuate selection, activation, injury, conditions, victory, defeat, or other clearly defined events for characters with the necessary portrait art.
- Class and fusion identity should be communicated through compatible frames, emblems, or adjacent interface elements rather than requiring every facial expression to be redrawn for every class combination.
- Companion portraits remain visually attached to their master. A companion may later receive a brief reaction or activation presentation without becoming an independent combatant or initiative entry. A speaking companion may temporarily occupy the single current-speaker portrait position.
- Major characters, recurring characters, minor NPCs, and incidental characters may receive different expression-library sizes. Exact tiers and the canonical expression vocabulary remain a later art-scope decision.
- The system adopts the compact expressive grammar demonstrated by the *Pokémon Mystery Dungeon* series while requiring original portraits, original interface framing, and adaptations appropriate to customizable human characters, equipment, companions, and Infinite Fantasia's combat UI.
- During portrait-system design, proven *Pokémon Mystery Dungeon* conventions that clearly improve readability, expressive clarity, consistency, or production efficiency may be adopted as recorded working standards without requiring a separate approval question for each minor detail. Decisions that materially change Infinite Fantasia's visual identity, player agency, content scope, or interface behavior still require explicit consideration.

### IF-UI-010 — Layered Party-Commentary Presentation

- **Status:** Locked
- Party dialogue uses three trigger tiers supported by only two visual interfaces. The distinction concerns why a line occurs and whether it deserves to interrupt play, not the creation of three separate dialogue widgets.
- **Ambient commentary** is automatic, brief, and non-blocking. It appears as a speech bubble associated with the speaking authored party member and disappears without requiring player input.
- Ambient commentary covers routine exploration observations, environmental notices, enemy warnings, ordinary combat reactions, discoveries, and personality remarks that enrich the journey without demanding the player's full attention.
- Ambient lines are preserved in an accessible recent-dialogue history so a player who was concentrating elsewhere can review them.
- The ambient system must use contextual eligibility, priority, repetition tracking, and cooldowns. It must prevent simultaneous overlapping party remarks and choose one valid speaker when multiple comments become eligible at once.
- **Player-initiated conversation** begins when the player deliberately speaks with an authored party member. It pauses ordinary play and uses the full one-speaker expressive portrait box, even when the exchange contains only one or two lines.
- **Important scripted reaction** begins automatically when a discovery, consequence, argument, relationship development, or other authored event deserves the player's attention. It pauses ordinary play and uses the same full expressive portrait interface as a player-initiated conversation.
- The governing presentation rule is: **routine and safely ignorable information uses a speech bubble; focused or important communication uses the portrait dialogue box.**
- The protagonist's contributions continue to use dialogue or response text without an authored emotional portrait. When the protagonist is the current speaker, the portrait region may collapse, remain empty, or yield space to response options according to the final layout.
- The UI architecture must reserve support for both an anchored ambient speech-bubble layer and the full dialogue overlay even if Prototype 0.1 uses placeholders or does not yet author the complete commentary content.

### IF-UI-011 — Pixel-Portrait Production Standard

- **Status:** Visual medium and working UI dimensions locked for implementation; exact palette and final border ornamentation remain open to art testing
- Full dialogue portraits use deliberately visible **pixel art**, matching Infinite Fantasia's low-resolution world rather than placing smooth or painterly illustrations over it.
- The working native dialogue-portrait canvas is **64×64 logical pixels**. Portrait pixels remain hard-edged with no smoothing, subpixel placement, fractional scaling, or automatic antialiasing.
- Each expression keeps the same head-and-shoulders scale, eye line, lighting direction, silhouette placement, and transparent background. Only expressive anatomy, pose accents, and deliberately authored reaction marks should change between frames.
- The portrait palette should remain economical and character-specific, preserving readable value separation at native size. The early Mystery Dungeon games' strict small-palette discipline is adopted as an artistic principle rather than a mandatory fifteen-color technical ceiling.
- Full portraits are static expression frames exchanged at authored acting beats. The standard system does not require lip synchronization, facial tweening, or idle portrait animation.
- The 640×360 interface reserves a **72×72-pixel left portrait slot** for the 64×64 artwork plus its frame and breathing room. The working full dialogue overlay occupies **96 pixels of screen height** at the bottom of the canvas, leaving consistent space for the speaker name and a compact text page to the right.
- The 64×64 dialogue portrait must not be fractionally reduced for very small interface contexts. The initiative ribbon and similarly constrained displays use a separately authored or deliberately simplified small portrait thumbnail connected to the same character record.
- Menu presentation may use the full portrait or an integer-scaled presentation variant when space permits. Every use must preserve nearest-neighbor rendering and the portrait system's character identity even when its expression coverage differs.
- Prototype placeholder portraits must already occupy these working dimensions so later art replacement does not require restructuring the dialogue overlay, menus, or portrait-data interface.

### IF-UI-012 — Stable Portrait Appearance

- **Status:** Locked
- A character's dialogue portraits and small UI thumbnails preserve one stable canonical appearance across ordinary equipment changes, class changes, specializations, and future class fusions.
- Equipped armor, helmets, weapons, accessories, and ordinary outfits do not require corresponding portrait variants. The portrait may therefore omit equipment that is visible on the character's world or battle sprite; this is an accepted interface abstraction.
- Class identity, fusion identity, equipped gear, and current resources are communicated through adjacent names, emblems, frames, icons, and mechanical UI rather than by redrawing the character's entire expression library.
- The player-created protagonist's neutral identity image preserves the character-creation features needed for recognition but follows the same rule against systemic equipment and class variants.
- Temporary Conditions, Afflictions, buffs, and damage do not permanently alter portrait artwork. When useful, the interface may add a separate overlay icon, tint, frame treatment, or contextual reaction without creating a new equipment-dependent portrait set.
- A rare permanent physical transformation, major story-state change, or deliberately supported identity-changing cosmetic may receive a replacement portrait set only through an explicit content decision. Such exceptions are authored events rather than a general equipment-preview promise.
- This rule keeps every expression reusable, prevents the portrait workload from multiplying across the class-combination system, and preserves immediate character recognition.

### IF-UI-013 — Authored-Party Core Expression Atlas

- **Status:** Locked for the two authored starting party members; character-specific special expressions and nonparty portrait tiers remain open
- Each of the two authored starting party members receives the same sixteen-expression core atlas so dialogue, reaction, and event scripts can request one stable emotional vocabulary regardless of which authored ally is speaking.
- The core expressions are: **Neutral, Happy, Joyous, Inspired, Determined, Angry, Worried, Sad, Teary-Eyed, Crying, Pained, Surprised, Stunned, Shouting, Sighing, and Confused/Dizzy.**
- These labels identify clear performance intentions rather than requiring the two characters to make identical faces. Every expression must be interpreted through that character's established personality, habitual posture, and emotional openness.
- The sixteen core portraits reuse the fixed crop, eye line, scale, palette, lighting, and canonical appearance established by IF-UI-009 through IF-UI-012.
- Individual authored characters may receive additional special expressions when their personality or a significant scene requires a reaction that the shared atlas cannot convey honestly. Special expressions supplement rather than replace the core vocabulary.
- Dialogue scripting should prefer the closest core expression unless the emotional distinction materially improves the scene; special expressions must not become decorative one-use art without sufficient narrative value.
- This standard adapts the compact sixteen-emotion performance library associated with the early *Pokémon Mystery Dungeon* games while replacing creature-specific conventions with a vocabulary suitable for expressive human characters.

### IF-UI-014 — Clean Five-Slot Combat Bars and Locked Palette

- **Status:** Locked; implemented in the working Prototype 0.0.3 HUD foundation
- Every persistent character panel reserves five identically sized bar positions in one stable vertical sequence: **Health**, **Action Gauge**, and up to **three inherited class resources**.
- A base class displays only its three active bars. The two additional class-resource positions remain spatially reserved but are not drawn, preventing an unavailable resource from resembling an empty active bar and preventing future fusions from resizing the HUD.
- Combat bars contain no labels, numbers, letters, icons, symbols, gradients, or decorative patterns. Proposed Action-Gauge expenditure appears as a clean darkened portion of the same green fill rather than hatching or text inside the bar.
- The tutorial teaches the palette through use. Character-summary and other deliberate inspection screens may display labeled bars; the persistent combat HUD remains clean.
- Bar identity is communicated through fixed order and the following exact fill colors:

| Bar or class resource | Locked color name | Hex |
| --- | --- | --- |
| Health | Blood Red | `#8F1025` |
| Action Gauge | Pure Green | `#00BF00` |
| Mana | Deep Blue | `#2854B8` |
| Rage | Hot Pink | `#FF3B7A` |
| Energy | Yellow | `#FFFD01` |
| Warlock resource, final name open | Purple | `#913FD0` |
| Faith | White | `#F4F4F0` |
| Focus | Orange | `#F28A18` |
| Warden resource, final name open | Forest Green | `#00613C` |
| Resolve | Bronze | `#B87333` |

- Health uses a dark blood red while Rage uses an aggressive magenta-pink, eliminating the need to distinguish two red fills. Bronze reinforces Resolve's metallic endurance identity; Focus remains vivid orange rather than inheriting the less intuitive pink assignment.
- Prototype 0.0.3 uses these bar fills as its **only chromatic hues**. Battlefield geometry, actors, portraits, controls, text, borders, tracks, and every other visual element remain grayscale so the color vocabulary can be evaluated without artwork noise.
- A future accessibility palette may substitute colors through settings, but it must preserve the same fixed bar order, clean geometry, and immediate differentiation without changing the default palette recorded here.

### IF-UI-015 — Reserved Ranged-Delivery Line

- **Status:** Locked; implemented for Prototype 0.0.4
- Movement previews do not draw a line between the combatant and destination and do not place crossed-zone markers along that route. They retain the destination footprint, validity state, movement-cost label, and linked Action-Gauge depletion preview.
- A source-to-target delivery line is reserved for **ranged attacks of any kind**. While a ranged action is being aimed, the line connects the acting combatant's focal point to the hovered target or target focal point.
- Melee and other close-range attacks do not draw this connector. They may still display their reach, valid targets, and ordinary numerical preview without implying a projectile path.
- Range radii, zone boundaries, hitbox outlines, destination footprints, and area-of-effect boundaries remain available because they communicate geometry rather than connecting an actor to a proposed action endpoint.
- This is a universal interface vocabulary, not a Bow Shot exception. Future ranged weapon attacks, ranged spells, ranged companion commands, and other ranged actions inherit the delivery line unless a later targeting model explicitly supersedes it.
- Removing the movement connector changes presentation only. Click movement continues to validate and price its complete direct path, including distance, collision, and zone transitions.

### IF-TAG-001 — Element Tag Category

- **Status:** Locked as a taxonomy direction; exact roster remains open
- **Element** is the first formal category in the universal tag dictionary.
- An Element tag identifies the elemental damage or affinity carried by a skill, attack, weapon, condition, defense, enemy, object, or other mechanical entity.
- Element tags remain classificatory and do not automatically grant a status effect or overworld interaction.
- Example: **Fire** means that the effect deals or interacts with Fire elemental damage. It does not automatically mean that the effect can ignite objects or inflict a burning condition; those require their own canonical tags.
- Example: **Ice** identifies Ice elemental damage. Freezing water, immobilizing a creature, or freezing an object requires a separate interaction or status tag.
- This separation keeps each tag's meaning stable and allows designers to grant world utility deliberately rather than attaching it to every elemental effect.
- The number system must later define how an Element tag combines with a non-elemental damage-form tag such as **Piercing** or **Bludgeoning** and how multiple applicable defenses resolve.

### IF-TAG-002 — Initial Element Roster Candidates

- **Status:** Partially locked; remaining natural roster relationships remain proposed
- **Light**, **Shadow**, and **Arcane** are accepted as genuine damage elements with corresponding defensive interactions.
- **Nature** is accepted as a genuine Natural damage element distinct from the broader practice or spell source of nature magic.
- A compact conventional foundation could begin with **Fire**, **Ice**, **Lightning**, **Water**, **Terra**, and **Wind**.
- **Light** and **Shadow** replace the earlier provisional Holy and Dark terminology.
- The natural candidates and the accepted esoteric Elements may appear in the same global tag category without belonging to the same matchup wheel.
- **Poison** and similar concepts should not be labeled Elements automatically; each must justify being a distinct damage-and-defense axis rather than a condition, source, or interaction tag.
- The final roster should remain small enough that elemental defenses are readable, equipment decisions are meaningful, and individual elements receive sufficient content.

### IF-TAG-003 — Two Vulnerabilities and Two Resistances

- **Status:** Selected direction for Natural Elements; exact roster remains under audit
- Every Natural Element's defensive profile contains exactly two incoming Elemental vulnerabilities and exactly two incoming Elemental resistances.
- Elemental relationships belong to the receiver. An attack declares its damage Element; the defending creature, object, surface, or effect determines whether that incoming Element is a vulnerability, resistance, or neutral matchup.
- Example: a Fire-aligned defender may be vulnerable to Water. This does not automatically mean that a Water-aligned defender resists Fire.
- Example: an Ice-aligned defender may be vulnerable to Fire. This does not automatically mean that a Fire-aligned defender resists Ice.
- Vulnerabilities and resistances therefore do not need to form reciprocal pairs unless the final profile independently assigns both directions.
- All remaining incoming Natural Elements are neutral unless another universal rule applies.
- This gives every elemental creature, skill, defense, and environment a learnable tactical identity without requiring constant reference to a bestiary or chart.
- The rule concerns different Natural Elements; same-Element behavior and Esoteric Elements use separate decisions.
- The number of neutral incoming Natural Elements in each defensive profile is determined by the size of the Natural roster:

| Natural Elements | Vulnerable to | Resists | Neutral incoming Elements | Structural consequence |
| ---: | ---: | ---: | ---: | --- |
| 5 | 2 | 2 | 0 | Every other Natural Element modifies incoming damage. |
| 6 | 2 | 2 | 1 | Each profile has one neutral incoming Natural Element. |
| 7 | 2 | 2 | 2 | Each profile has two neutral incoming Natural Elements. |
| 9 | 2 | 2 | 4 | Each profile treats half of the other Natural Elements neutrally. |

- Exact vulnerability and resistance multipliers, defense calculations, dual-element handling, and same-Element behavior belong to the later number-system discussion.

### IF-TAG-004 — Natural and Esoteric Element Families

- **Status:** Locked as a taxonomy direction; exact Esoteric rules remain open
- Elements are divided into at least two mechanical families for matchup purposes:
  1. **Natural Elements:** use the exact two-vulnerability/two-resistance defensive-profile rule.
  2. **Esoteric Elements:** currently Light, Shadow, and Arcane; use their own smaller, explicitly stated relationship rules.
- Natural and Esoteric Elements remain part of the same visible Element tag category so the player does not need two unrelated interface languages.
- Esoteric Elements are not forced into the Natural wheel or into a mathematically artificial two-and-two structure.
- Cross-family matchups should normally be neutral unless a small universal rule is later approved.
- Each family's complete relationship rule must remain short enough to understand from its tags without consulting a bestiary.

### IF-TAG-005 — Natural-Roster Expansion Discipline

- **Status:** Locked as a design constraint
- The Natural roster may expand beyond the initial six candidates when expansion produces more intuitive and aesthetically coherent relationships.
- A new Natural Element cannot be added solely to provide one missing matchup. Adding one Element also creates a new identity that requires two vulnerabilities, two resistances, skills, enemies, equipment hooks, and sufficient world content.
- Every added Element must possess a distinct damage fantasy and enough mechanical and environmental expression to justify permanent inclusion.
- **Nature** is accepted as the first roster expansion because Nature-aligned and Ice-aligned defenders can both be intuitively vulnerable to incoming Fire damage while Nature still supplies a distinct organic damage fantasy.
- Terra-aligned defenders can potentially be vulnerable to Water through erosion, but no matchup is locked until the complete Natural defensive profiles are coherent.

### IF-TAG-006 — Esoteric Relationship Candidates

- **Status:** Proposed for later confirmation
- Light-aligned and Shadow-aligned defenders may be mutually vulnerable to the opposite incoming Element.
- Arcane may operate as a deliberately neutral, reliable magical damage element with no ordinary elemental strengths or weaknesses.
- This would give the Esoteric family a one-sentence rule while distinguishing Arcane from the Natural wheel and from the Light–Shadow conflict.
- Alternative Esoteric rules remain open, but they should not require adding elements merely to complete a wheel.

### IF-TAG-007 — Terra and Nature Domain Boundary

- **Status:** Locked at concept level
- **Terra** represents the inorganic side of the natural world, especially solid mineral and geological matter such as stone, soil, sand, clay, and crystal when those materials are not governed by another explicit Element.
- **Nature** represents the organic side of the natural world, especially plants, fungi, roots, vines, thorns, spores, biological growth, and related living forces.
- Water, Ice, Wind, and Lightning retain their own Element identities even though they are inorganic phenomena; the Terra definition does not absorb an already distinct Element.
- An object or creature can belong conceptually to one of these domains without automatically receiving an Element tag. Element tags indicate a mechanical damage or affinity relationship rather than serving as exhaustive biological or geological taxonomy.
- Ordinary beasts may belong to Nature thematically while remaining non-elemental mechanically. A separate **Beast** enemy-type tag can express biology, targeting, Warden interaction, and Expertise without implying Nature damage, vulnerability, or resistance.
- Nature-infused, magically empowered, or explicitly elemental beasts may carry both a Beast classification and the Nature Element tag.

### IF-TAG-008 — Receiver-Owned Reaction Model

- **Status:** Locked as a universal mechanical principle
- Actions state what they deliver; receivers state how they react.
- A skill's Element tag declares its incoming damage property but does not carry a universal list of targets against which it is inherently strong or weak.
- The target's Elemental defensive profile determines vulnerability, resistance, or neutrality at resolution.
- The same philosophy should guide later systems where practical: **Ignite** declares an interaction attempt while the receiver's **Flammable** or equivalent property determines whether ignition is valid; creature-family tags such as Beast remain separate receiver classifications with their own explicitly defined interactions.
- Targeting previews must show the resolved result, such as **Vulnerable**, **Resisted**, or **Neutral**, before commitment whenever the character has enough information to know it.
- This receiver-owned model allows logically asymmetric relationships without creating exceptions in the attack descriptions.

### IF-TAG-009 — Global Elemental Distribution Balance

- **Status:** Locked as a mathematical constraint
- Across the complete Natural defensive chart, every Natural attack Element appears in exactly two vulnerability lists.
- Across the complete Natural defensive chart, every Natural attack Element appears in exactly two resistance lists.
- This global column balance exists in addition to the local rule that every Natural defender has exactly two vulnerabilities and two resistances.
- The constraint gives every Natural Element equal total offensive opportunity and equal total exposure to resistance without requiring any individual relationship to be reciprocal.
- Any Natural-roster addition or removal requires the complete chart to be revalidated against both the local defensive-profile rule and the global distribution rule.

### IF-TAG-010 — Initial Obvious Vulnerabilities

- **Status:** Partially locked; additional obvious relationships await confirmation
- **Locked:** Fire-aligned defenders are vulnerable to incoming Water damage.
- **Locked:** Ice-aligned defenders are vulnerable to incoming Fire damage.
- **Strong proposal:** Water-aligned defenders are vulnerable to incoming Lightning damage.
- **Strong proposal:** Terra-aligned defenders are vulnerable to incoming Water damage through erosion.
- **Strong proposal:** Nature-aligned defenders are vulnerable to incoming Fire damage.
- Resistances are not inferred automatically from these vulnerabilities and will be assigned independently.
- The chart should lock only relationships that remain intuitive when phrased from the receiver's perspective; harder Wind and Lightning profiles should not be filled merely to complete the matrix.

### IF-TAG-011 — Revised Seven-Element Vulnerability Chart

- **Status:** Provisionally accepted; revisit during resistance design
- Water receives vulnerability to Nature rather than Wind because living growth absorbs and consumes water.
- Terra receives vulnerability to Wind rather than Nature because wind erodes exposed mineral matter.
- Wind receives vulnerability to Ice and Lightning, using frozen stillness and storm disruption as its defensive identity.
- Completing the chart with Ice vulnerable to Wind forces Lightning to be vulnerable to Nature under the global distribution rule:

| Defender | Vulnerable to |
| --- | --- |
| Fire | Water, Terra |
| Ice | Fire, Wind |
| Water | Lightning, Nature |
| Terra | Water, Wind |
| Wind | Ice, Lightning |
| Lightning | Terra, Nature |
| Nature | Fire, Ice |

- Every Natural attack Element appears in exactly two vulnerability lists:
  - Fire attacks vulnerability on Ice and Nature.
  - Ice attacks vulnerability on Wind and Nature.
  - Water attacks vulnerability on Fire and Terra.
  - Terra attacks vulnerability on Fire and Lightning.
  - Wind attacks vulnerability on Ice and Terra.
  - Lightning attacks vulnerability on Water and Wind.
  - Nature attacks vulnerability on Water and Lightning.
- Wind's effect on Ice should be explained as **scouring**, abrasion, and accelerated sublimation rather than as hot air. This preserves Wind's identity and avoids borrowing Fire's temperature domain.
- Nature's effect on Lightning is the least automatic remaining relationship; its proposed reading is that rooted living networks ground and diffuse electrical charge.
- The vulnerability chart is accepted for current design work without prematurely determining resistances.
- Resistance profiles remain deferred. They may invert or rearrange vulnerability relationships, but either approach must satisfy the existing local and global two-resistance rules.

### IF-TAG-012 — Natural-Roster Addition Audit

- **Status:** Working analysis; no new Element approved
- The revised seven-Element draft is already complete, so no new Element is required to satisfy the vulnerability-distribution rule.
- Adding exactly one Natural Element would expand the roster to eight Elements and require sixteen total vulnerability relationships plus a complete rebalance of existing columns; the new Element cannot simply be appended while every current relationship remains.
- Any new Element must supply two intuitive incoming vulnerabilities, appear intuitively in two other defenders' vulnerability lists, and later satisfy the equivalent resistance obligations.
- Adding two Elements permits more rearrangement but creates two complete mechanical identities, including vulnerabilities, resistances, skills, enemies, equipment hooks, and environmental expression.
- No Natural Element should be admitted solely to fill a chart. If the revised seven-Element draft fails the intuition test, the roster and drafted relationships should be reopened together rather than patched one blank at a time.

### IF-TAG-013 — Future Electrical Interaction Tag

- **Status:** Category boundary locked; name and behavior deferred
- **Shock** is not part of the Affliction roster.
- Lightning and other electrical abilities may use existing Afflictions such as Slow or Stun when those mechanical effects fit the source.
- A future electrical interaction tag may represent electrical charge, conductivity, or another world and combat interaction without functioning as an Affliction or an Affliction-like status.
- The future tag's name, exact behavior, duration model if any, valid receivers, and relationship to the Lightning Element remain open until interaction tags are designed.

### IF-TAG-014 — Prototype Combatant Sizes

- **Status:** Small behavior and Medium prototype comparator locked; complete size taxonomy deferred
- **Small** is a standardized combatant-size category that abilities may use as a targeting qualifier.
- Guard Dog is the first prototype ability to select targets through this category: it affects all Small enemies that satisfy its other targeting requirements.
- **Medium** is accepted as the prototype's ordinary non-Small comparator. The Drowsing Toad is Medium and therefore is not eligible for Guard Dog.
- The Small size category is distinct from the **Small** chance term. Interface context, placement, and category labeling must make it immediately clear whether the word identifies a target's size or the hidden 10% chance rung.
- Small size does not automatically grant access to Tiny-Character Passageways or determine Weight, Shove Resistance, reach, or any other rule unless a separate system explicitly connects them.
- The complete size scale, assignment criteria, interface presentation, and any additional systemic effects remain open.

### IF-TAG-015 — Sound Delivery Tag

- **Status:** Core tag meaning locked; secondary interactions deferred
- **Sound** identifies an ability, interaction, or effect that propagates through the standard sound rules in IF-CBT-011.
- Sound is a delivery and interaction tag, not an Element, physical damage form, Affliction, or inherent damage type.
- The Sound tag does not by itself determine damage, targeting allegiance, application chance, duration, or whether an effect reveals its source.
- Guard Dog is the first prototype active to carry the Sound tag.
- Soundproofing, amplification, stealth, awareness, deafness, Silence, and environmental-noise interactions remain open.

### IF-TAG-016 — Untagged Damage

- **Status:** Core interpretation locked; universal-defense interaction deferred
- An effect may deal damage without carrying an Element tag or a physical damage-form tag such as Slashing, Piercing, or Bludgeoning.
- This is represented by the deliberate absence of those tags. **Untyped**, **Neutral**, **Physical**, or a similar substitute tag is not added merely to fill the empty category.
- Untagged damage does not activate Element- or damage-form-specific vulnerabilities, resistances, immunities, bonuses, or interactions.
- Untagged damage is not automatically true damage. Mechanics that explicitly modify all damage may still apply according to the eventual universal damage rules.
- The minimal player-facing effect may simply read **Deal X damage.** with no Element or damage-form tag displayed.
- Whether the game has universal Defense, universal damage reduction, or explicit modifiers that name untagged damage remains open for the numerical and defense-system passes.

### IF-STS-001 — Status Definition and Application Separation

- **Status:** Locked structural direction; exact sentence template remains proposed
- A status tag defines what the status does. It does not contain or imply its application chance.
- Example: the **Burn** tag's inspection text explains Burn's canonical mechanical effect.
- The skill, weapon, passive, or other source separately states its chance to inflict that status.
- Working sentence: **Has a High chance to inflict Burn.**
- Description text is noninteractive. Hovering or selecting **High**, **Burn**, or any other word inside the description does nothing.
- A separate tag row appears below the description. The **Burn** tag in that row may be hovered, focused, or selected to inspect Burn's canonical rules.
- Chance terms are not tags and do not receive separate hover definitions.
- Each chance term maps to one exact internal percentage everywhere in the game, but the percentage is hidden from the player and is not revealed through inspection.
- The shorter form **High chance to inflict Burn.** should be tested against the working sentence during interface prototyping.
- How defenses or other effects alter the displayed chance term remains deferred until those systems are designed.

### IF-STS-002 — First Canonical Chance Ladder

- **Status:** Locked

| Internal chance — designer only | Final player-facing term |
| ---: | --- |
| 1% | Abysmal |
| 3% | Minuscule |
| 5% | Tiny |
| 10% | Small |
| 20% | Modest |
| 30% | Medium |
| 50% | High |
| 70% | Great |
| 90% | Extreme |
| 100% | Guaranteed |

- The final ladder is **Abysmal, Minuscule, Tiny, Small, Modest, Medium, High, Great, Extreme, Guaranteed**.
- The internal percentages are never shown to the player; only the corresponding terms appear in descriptions and other player-facing rules text.
- Broader questions about proc balance, multi-hit rolls, modifiers, and the use cases for individual percentages are intentionally deferred to later status-system design.

### IF-STS-003 — Immunity Removes Existing Effects

- **Status:** Locked universal rule
- Immunity prevents the named effect from being applied while that immunity is active.
- If a combatant, object, or other valid receiver becomes immune to an effect that is already active on it, the active effect is removed immediately.
- This removal is part of gaining immunity and does not require a separate cleanse, dispel, or removal instruction.
- The rule applies universally whenever an immunity explicitly names an Affliction, Condition, interaction tag, or other removable effect.
- Because Wet grants immunity to Burn and Ignite, applying Wet immediately removes any Burn or Ignite already affecting that receiver.

### IF-AFL-001 — Affliction Category Boundary

- **Status:** Locked
- An **Affliction** is a mechanically harmful state that remains on a combatant after the effect that applied it has resolved.
- Direct damage, forced movement, immediate Action Gauge loss, and similar one-time consequences are effects rather than Afflictions.
- Beneficial states belong to a separate buff or boon category.
- Neutral or setup-oriented states such as **Wet** and **Oiled** belong to a separate **Condition** category because they can create advantages or disadvantages depending on the next interaction.
- The current Affliction roster is:
  - **Ongoing harm:** Burn, Poison, Bleed, and Disease.
  - **Control:** Chilled, Stun, Sleep, Rooted, and Fear.
  - **Impairment:** Blind, Silence, Slow, and Curse.
- Shock is explicitly omitted. Electrical sources may use existing Afflictions or a future non-Affliction interaction tag rather than creating a redundant harmful status.
- The roster may expand later, but every proposed addition must be defined individually, possess a distinct canonical purpose, and justify why it is not an existing Affliction under another name.

### IF-AFL-002 — Semantic-First Affliction Design

- **Status:** Locked design method
- Afflictions are currently defined by their qualitative mechanical identity and systemic interactions rather than by premature balance values.
- An Affliction tag defines what the Affliction does, including any universal triggers or early-removal interactions. It never defines a fixed duration.
- Every ability, item, environmental effect, or other source that applies an Affliction defines that particular application's duration in its own description. The same Affliction may therefore last one turn from one source and many turns from another.
- A source-assigned duration is the ordinary endpoint. Any removal interaction stated by the Affliction, such as damage waking Sleep, may end it sooner.
- Damage amounts, stacking limits, tick timing details, resistance values, cleansing costs, and other combat numbers remain unspecified unless the user explicitly opens that subject.
- Placeholder numbers must not be invented merely to make an Affliction definition appear complete.
- A useful early Affliction definition may therefore state what happens and which tags are temporarily gained without specifying a magnitude; source durations will be written when the applying sources are designed.
- Numeric rules will be added later without changing the Affliction's established semantic identity unless testing reveals a genuine design problem.

### IF-AFL-003 — Burn

- **Status:** Locked at semantic level; numbers and detailed timing remain deferred
- Canonical description: **Take damage every turn. Gain Ignite while Burn is active.**
- The wording is bearer-neutral and applies equally to player characters, authored companions, enemies, and any other valid combatant.
- Burn's damage amount is intentionally unspecified.
- Burn grants the existing **Ignite** interaction tag for its duration, allowing a burning entity to participate in every applicable rule that recognizes Ignite.
- The universal behavior of Ignite, including precisely which contacts or interactions it enables, will be defined in the interaction-tag discussion rather than repeated inside Burn.
- Each Burn source defines its own duration. Burn's stacking behavior, removal rules, and exact damage timing remain open for later combat design.

### IF-AFL-004 — Poison

- **Status:** Locked at semantic level; numbers and detailed timing remain deferred
- Canonical description: **Take damage every turn. This damage increases every turn while Poison is active.**
- Escalation is Poison's defining mechanical identity and distinguishes it from Burn's steady recurring damage plus Ignite interaction.
- Each Poison source defines its own duration. Poison's starting damage, growth rate, maximum damage, stacking behavior, removal rules, and exact damage timing remain open for later combat design.
- The eventual numerical implementation must preserve the readable promise that untreated Poison becomes progressively more dangerous.

### IF-AFL-005 — Bleed

- **Status:** Locked at semantic level; numbers and detailed timing remain deferred
- Canonical description: **Take damage whenever you spend Action Gauge.**
- Action-Gauge expenditure is Bleed's defining trigger, making it an exertion punishment rather than a third automatic turn-based damage effect.
- Bleed applies across movement, basic attacks, shoves, interactions, and any other action that spends Action Gauge under the universal action rules.
- Each Bleed source defines its own duration. Bleed's damage amount, stacking behavior, removal rules, and the exact handling of continuous or subdivided Gauge spending remain open for later combat design.
- The eventual implementation must prevent arbitrary input segmentation, such as dividing one movement into several clicks, from unintentionally multiplying Bleed triggers.

### IF-AFL-006 — Disease

- **Status:** Locked at semantic level; source-specific duration and removal details remain deferred
- Canonical description: **Receive no healing. Disease persists after battle.**
- Disease prevents every form of Health restoration while active, including abilities, items, regeneration, lifesteal, automatic provisions, and exploration healing.
- Disease itself may still be cleansed or treated; removing Disease is not healing.
- Post-battle recovery automation must never consume a healing provision on a Diseased character while Disease still blocks the result.
- The recovery policy may attempt an eligible Disease remedy before healing when its configuration permits, using the already established cleansing-priority rules.
- Each Disease source defines its own duration while the Affliction's post-battle persistence remains universal. Disease's stacking behavior, valid remedies, and cleansing costs remain open for later design.

### IF-AFL-007 — Chilled

- **Status:** Locked at semantic level; source-specific duration and proximity details remain deferred
- Chilled replaces Freeze in the current Affliction roster.
- Canonical description: **Cannot spend Action Gauge. Taking Fire damage or being near anything with Ignite removes Chilled.**
- Chilled prevents movement, basic attacks, shoves, interactions, and every other action that requires Action Gauge, while leaving actions that do not spend Action Gauge available.
- Direct Fire damage and proximity to an entity, object, or other source carrying **Ignite** are independent removal routes.
- The precise battlefield meaning of **near**, including whether it is based on zones, spatial distance, or another universal proximity rule, remains deferred until battlefield proximity is formalized.
- Each Chilled source defines its own duration. Chilled's application resistance, stacking behavior, and non-heat cleansing routes remain open for later design.
- Full immobilization or total loss of action belongs to stronger Afflictions such as Stun rather than Chilled.

### IF-AFL-008 — Stun

- **Status:** Locked at semantic level; source-specific duration and detailed timing remain deferred
- Canonical description: **Cannot take actions.**
- Stun prevents Action-Gauge actions, class abilities, spells, item use, interactions, and companion commands.
- Passive and triggered effects continue functioning because they are not actions initiated by the Stunned combatant.
- Each Stun source states its duration in that source's description; Stun itself has no universal one-turn limit.
- The precise duration boundary under initiative-block interweaving, and the behavior of Stun reapplied before expiration, remain open until detailed turn timing is formalized.

### IF-AFL-009 — Sleep

- **Status:** Locked at semantic level; source-specific duration and detailed timing remain deferred
- Canonical description: **Cannot take actions. Taking damage, being moved, or a waking effect removes Sleep.**
- Sleep prevents the same initiated actions as Stun while allowing passive and triggered effects to continue.
- Any damage removes Sleep regardless of its source or damage type.
- Any movement of the sleeping combatant removes Sleep, including forced movement, pulling, swapping, teleportation, or another valid relocation effect.
- A **waking effect** is any ability, item, companion command, environmental interaction, or other action that explicitly states that it removes Sleep.
- Sleep is distinguished from Stun by its multiple systemic removal routes; damage or movement does not inherently remove Stun.
- Each Sleep source defines its own duration. The timing relationship between Sleep removal and the damage or movement that caused it remains open for later combat design.

### IF-AFL-010 — Rooted

- **Status:** Locked at semantic level; source-specific duration and detailed timing remain deferred
- Canonical description: **Cannot spend Action Gauge on movement. Forced movement or Ignite removes Rooted.**
- Rooted prohibits both within-zone movement and movement between zones when initiated through Action-Gauge spending.
- The Rooted combatant may still spend Action Gauge on basic attacks, shoves, interactions, companion commands, and every other non-movement action.
- Forced movement resolves normally and then removes Rooted; Rooted does not make the combatant immovable.
- An applicable **Ignite** interaction removes Rooted by burning away the restraining growth or material.
- Each Rooted source defines its own duration. Rooted's application resistance, stacking behavior, non-Ignite cleansing routes, and precise removal timing remain open for later design.

### IF-AFL-011 — Fear

- **Status:** Locked at semantic level; source-specific duration and detailed timing remain deferred
- Canonical description: **Cannot attack or move toward any enemy.**
- Fear is not tied to one source. It prevents attacks against every target and voluntary movement that brings the affected combatant closer to any enemy.
- The attack restriction applies to basic attacks, spells, abilities, companion commands, and any other action ultimately classified as an **Attack** under the universal action taxonomy.
- Fear does not prevent healing, buffs, defensive actions, item use, interactions, retreat, lateral repositioning, or movement that does not approach an enemy.
- Forced movement may move the Feared combatant toward an enemy because the movement is not voluntarily initiated by that combatant.
- Each Fear source states its duration in that source's description; Fear itself has no universal one-turn limit. The precise initiative-block boundary and reapplication behavior remain open until detailed turn timing is formalized.

### IF-AFL-012 — Blind

- **Status:** Locked, including its internal Accuracy reduction; source-specific duration and detailed accuracy exceptions remain deferred
- Canonical description: **Reduces Accuracy by a High amount.**
- A **High** Accuracy reduction is internally equal to 50 percentage points.
- Because Accuracy modifiers are additive, Blind changes the default 95% Accuracy to 45% before Dodge and any other modifiers are applied.
- Blind affects basic attacks, spells, abilities, companion attacks, and every other action governed by Accuracy.
- Blind's player-facing definition uses the qualitative term **High** rather than exposing the internal 50% value.
- Each Blind source defines its own duration. Blind's application resistance, stacking behavior, cleansing routes, and interaction with any future guaranteed-hit property remain open for later design.

### IF-AFL-013 — Silence

- **Status:** Locked at semantic level; source-specific duration and detailed classification remain deferred
- Canonical description: **Cannot use Spells.**
- Silence prevents the affected combatant from initiating any action carrying the **Spell** tag, regardless of that combatant's class, class resource, or any future fusion class.
- Silence does not prohibit movement, basic attacks, items, companion commands, or abilities that do not carry the Spell tag.
- Passive and triggered effects already in operation continue unless their own rules explicitly require the Silenced combatant to use a Spell.
- Each Silence source defines its own duration. Silence itself has no universal duration.

### IF-AFL-014 — Slow

- **Status:** Locked at semantic level; source-specific duration and numerical magnitudes remain deferred
- Canonical description: **Action Gauge costs are increased. Initiative is reduced.**
- Slow increases every Action Gauge cost, including within-zone movement, zone changes, shoves, interactions, basic attacks, and any other action that spends Action Gauge.
- Slow does not increase class-resource costs, PP costs, or any other cost that does not use Action Gauge.
- Every visible Action Gauge preview must incorporate Slow's increased cost before the player commits an action.
- Slow never rearranges the initiative set currently being resolved. Its Initiative reduction is applied when the next initiative set is formed.
- Every new initiative set formed while Slow remains active includes its Initiative reduction. Removing Slow prevents the reduction from affecting later sets.
- Each Slow source defines its own duration. The amounts by which Slow increases Action Gauge costs and reduces Initiative remain unspecified until the relevant number systems are designed.

### IF-AFL-015 — Curse

- **Status:** Locked at semantic level; source-specific duration, exact drain amount, and fusion handling remain deferred
- Canonical description: **Primary Resource is drained by a small amount at the start of every turn.**
- In the current base-class scope, **Primary Resource** means the character's class-specific third bar, such as Mana, Faith, Rage, Energy, Focus, or Resolve.
- Curse drains the afflicted combatant when that combatant's own turn begins; it does not trigger at the start of another combatant's turn.
- Curse does not drain Health, Action Gauge, individual ability PP, or any other pool that is not the affected character's Primary Resource.
- Each Curse source defines its own duration. The exact meaning of a small drain remains unspecified until resource values and magnitude language are formalized.
- Future fusion classes may possess multiple inherited class resources. Which of those resources counts as Primary for Curse remains open until fusion-resource rules are designed.

### IF-CND-001 — Wet

- **Status:** Locked at semantic level; duration and arc details remain deferred
- Player-facing presentation:
  - **Wet — Condition**
  - **Immune to Burn and Ignite.**
  - **(−) Fire weakness**
  - **(+) Lightning weakness**
  - **Lightning damage can arc between Wet targets in close proximity.**
  - **Replaces Oiled.**
- Wet is a Condition rather than an Affliction because it combines a protective benefit with elemental risks and positional interaction.
- Gaining Wet immediately removes existing Burn and Ignite under the universal immunity-removal rule and prevents both from being applied while Wet remains active.
- **(−) Fire weakness** moves the receiver downward by one rung on the Damage Multiplier Scale for incoming Fire damage. The established example moves an existing 0.9× Fire resistance to 0.7× while Wet.
- **(+) Lightning weakness** moves the receiver upward by one rung on the Damage Multiplier Scale for incoming Lightning damage.
- The Lightning arc checks for other Wet targets in close proximity. Exact proximity, arc sequence, damage, target count, and repeat-hit protections remain deferred.
- Each source that applies Wet defines that application's duration in its own description.

### IF-CND-002 — Oiled

- **Status:** Locked at semantic level; duration and general environmental ignition results remain deferred; prototype oil result defined by IF-ENV-004
- Player-facing presentation:
  - **Oiled — Condition**
  - **(+) Fire weakness**
  - **Combatant: Weight and resistance do not reduce Shoves.**
  - **Environment: Slippery.**
  - **Ignite applies Burn when valid and removes Oiled.**
  - **Replaces Wet.**
- **(+) Fire weakness** moves the receiver upward by one rung on the Damage Multiplier Scale for incoming Fire damage.
- An Oiled combatant receives full Shove force. Its Weight and Shove Resistance do not reduce the Shove's resulting speed or distance while Oiled remains active.
- An Oiled environment gains the **Slippery** property instead of carrying the combatant-specific wording.
- When a valid combatant is exposed to Ignite, Burn is applied and Oiled is removed. The prototype oil-barrel spill uses the explicit environmental transformation in IF-ENV-004; other Oiled surfaces may define different source-specific ignition results later.
- Each source that applies Oiled defines that application's duration in its own description.

### IF-CND-003 — Wet and Oiled Supersession

- **Status:** Locked universal interaction between Wet and Oiled
- Wet and Oiled are mutually exclusive and cannot coexist on the same combatant, object, environment, or other receiver.
- Applying Wet to an Oiled receiver removes Oiled and then leaves Wet as the active Condition.
- Applying Oiled to a Wet receiver removes Wet and then leaves Oiled as the active Condition.
- The Condition applied second always supersedes the Condition applied first, reflecting oil's hydrophobic separation from water.
- A superseded Condition is removed rather than suspended. It does not return when the newer Condition expires or is removed.
- Removing Oiled through supersession also ends any Slippery property that existed only because that environment was Oiled.
- After supersession, only the active Condition's immunities, elemental rung changes, Shove interactions, and other rules apply.

### IF-ENV-001 — Slippery

- **Status:** Locked at semantic level; detailed Shove formula and collision rules remain deferred
- Player-facing presentation:
  - **Slippery — Environment**
  - **Weight and resistance do not reduce Shoves.**
- A Shove normally possesses force that translates into movement speed and distance, with the target's Weight and Shove Resistance reducing that result.
- A combatant affected by a Slippery environment receives the Shove's full force. Its Weight and Shove Resistance are ignored when resolving that Shove's speed and distance.
- Slippery is therefore the environmental equivalent of the Shove vulnerability carried directly by an Oiled combatant.
- Slippery does not initiate movement by itself and does not make an otherwise invalid Shove valid.
- Being both Oiled and affected by Slippery does not amplify the result further because both rules remove the same defensive factors.
- Exact force values, speed and distance conversion, collisions, falls, ledge behavior, and impact damage remain deferred until forced-movement rules are designed.

### IF-ENV-002 — Tiny-Character Passageways

- **Status:** Locked as an environmental traversal category
- A **Tiny-Character Passageway** is a hole, pipe, vent, narrow tunnel, wall gap, or comparable route intended for explicitly qualified tiny characters, companions, summons, or transformations.
- Tiny-Character Passageways are not Rat-exclusive. Infiltrator grants the Sewer Rat permission to use them, while future actors may qualify through their own skills, forms, tags, or rules.
- Visual smallness alone does not grant access. Eligibility must be stated mechanically so passage behavior remains predictable.
- A Tiny-Character Passageway may connect locations within one map or serve as a dedicated transition into another compatible area.
- While directly controlling a tiny companion, these dedicated passageways may be crossed; ordinary party doors, stairways, map exits, and unrelated transitions may not be used unless another explicit rule permits them.
- Exact visual marking, interaction highlighting, destination preview, obstruction states, and whether some passageways require an additional action remain open.

### IF-NUM-001 — Additive Accuracy and Dodge

- **Status:** Locked foundation, including final roll boundaries
- Default Accuracy is 95%.
- Dodge is an internal percentage derived from hidden calculations and subtracts directly from Accuracy.
- The foundational calculation is **Raw Hit Chance = Accuracy − Target Dodge**, after incorporating any other additive Accuracy and Dodge modifiers.
- Example: 95% Accuracy against 20% Dodge produces a 75% Raw Hit Chance.
- Example: Blind reduces default Accuracy from 95% to 45%; against 20% Dodge, the resulting Raw Hit Chance is 25% before any other modifiers.
- A 20% Dodge value represents a large end-game Dodge chance, not necessarily a universal hard cap.
- Dodge may be negative. Subtracting negative Dodge increases the attacker's Raw Hit Chance.
- Accuracy and Raw Hit Chance may exceed 100%. Values above 100% remain meaningful as a buffer against Dodge and other Accuracy reductions rather than being discarded early.
- Raw Hit Chance remains uncapped throughout the additive calculation.
- At resolution, a Raw Hit Chance of 100% or higher always hits, a Raw Hit Chance of 0% or lower always misses, and any value between those boundaries is rolled normally.
- There is no universal natural-hit or natural-miss exception that can override these boundaries.

### IF-NUM-002 — Additive Percentage Principle

- **Status:** Locked mathematical principle; detailed damage formula remains deferred
- All percentage modifiers affecting damage and Accuracy combine additively rather than multiplicatively.
- Accuracy and Dodge modifiers add or subtract percentage points from the relevant calculation.
- Damage percentage bonuses and penalties are summed into one combined modifier rather than successively multiplying damage by each modifier.
- Exact damage order of operations, rounding, defenses, critical hits, vulnerability multipliers, and any final caps or floors remain open for later number-system design.

### IF-NUM-003 — Damage Multiplier Scale

- **Status:** Locked current scale, stacking method, and endpoint behavior; possible expansion and final order of operations remain deferred
- Elemental weaknesses, resistances, and comparable categorical damage relationships use the following discrete Damage Multiplier Scale:

| Damage Multiplier Scale |
| ---: |
| 0.0× |
| 0.5× |
| 0.7× |
| 0.9× |
| 1.0× |
| 1.1× |
| 1.3× |
| 1.5× |
| 2.0× |

- **1.0×** is neutral damage. Values below 1.0× are progressively stronger resistance, values above 1.0× are progressively stronger weakness, and 0.0× is damage immunity.
- Each signed weakness change moves the receiver exactly one rung down **(−)** or up **(+)** through this ordered scale rather than creating a new free-form multiplier.
- Multiple signed changes affecting the same damage type stack by rung count. Two **(+)** changes move two rungs upward; two **(−)** changes move two rungs downward.
- Opposing changes cancel before movement is resolved. One **(+)** and one **(−)** produce a net change of zero rungs.
- After all applicable signed changes are combined, the receiver moves the net number of rungs from its underlying multiplier and uses the resulting listed value.
- Example: a receiver at 0.9× against Fire moves to 0.7× while affected by Wet's **(−) Fire weakness**.
- Example: a receiver at 1.0× against Lightning with two separate **(+) Lightning weakness** effects moves two rungs upward to 1.3×.
- Status immunity, such as Wet's immunity to Burn and Ignite, is separate from damage immunity and does not by itself set an elemental damage multiplier to 0.0×.
- The displayed 0.0×–2.0× ladder is the standard scale for current design work, but it is not locked as the permanent theoretical limit of the complete game.
- Under the current rules, net rung movement clamps at 0.0× and 2.0× after all active positive and negative shifts have been combined.
- A result that would currently fall below 0.0× resolves at 0.0× and deals no damage. A result that would currently rise above 2.0× resolves at 2.0×.
- No healing or damage beyond 2.0× occurs under the current scale.
- A future mirrored expansion beyond both ends of the standard scale remains an approved possibility. Sufficient resistance stacking could potentially cross below 0.0× and convert incoming damage into healing, while a matching weakness expansion could extend above 2.0×.
- No expanded multiplier values, healing conversion formula, access requirements, stacking thresholds, or maximum extended bounds are currently approved.
- Crossing into absorption must require enough deliberate build investment, encounter setup, or rare effects that it creates a rewarding strategy without making ordinary encounters trivial.
- Any future expansion should remain symmetrical and use the same readable rung language rather than introducing unrelated calculations at either end.
- The relationship between this categorical multiplier layer and ordinary additive damage bonuses, defenses, critical hits, rounding, and final damage order remains deferred.

### IF-PTY-001 — Three Character and Three Companion Slots

- **Status:** Locked at concept level
- The standard active party contains three player-character slots and three pet or companion slots.
- Up to six allied figures may therefore be visible on the battlefield, but only the three characters are independent combatant entities. Companions are attached cosmetic-and-ability components of those characters.
- The three-character limit keeps class composition consequential while companion slots provide a narrower secondary layer of customization and coverage.
- The battle interface, initiative ribbon, formation, and resource display must remain readable at the full three-character plus three-companion capacity.

### IF-PTY-002 — Paired Character–Companion Slots

- **Status:** Locked at concept level
- Each of the three companion slots is directly attached to its corresponding character slot.
- The active party is therefore organized as three character–companion pairs rather than three characters plus a shared companion pool.
- A recruited pet or companion is equipped, bonded, or otherwise assigned to a specific active character.
- Class-granted animal companions and summons normally occupy the attached slot belonging to that classed character.
- The interface should visually group each character with its attached companion.
- A companion acts only through or during its attached character's initiative block and never receives an independent initiative position.
- Temporary effects may create exceptions to the normal slot limit only when explicitly designed to do so.

### IF-PTY-003 — Protagonist and Tutorial Companions

- **Status:** Locked at concept level
- Character Slot 1 contains one protagonist created by the player.
- Character Slots 2 and 3 contain two authored characters met during the tutorial.
- The tutorial companions have fixed identities, personalities, relationships, histories, and roles in the story rather than functioning as player-created blank characters.
- They join early enough that the three-character party structure can be taught and established during the tutorial.

### IF-PTY-004 — Player-Directed Starting Classes

- **Status:** Locked at concept level
- The player chooses the protagonist's starting base class.
- The player also chooses the starting base class of each of the two authored tutorial companions.
- Authored character identity must remain legible across every permitted class choice; personality should not be reducible to combat role.
- This allows the player to build the desired starting party without abandoning preferred story characters or relying on a conventional respec explanation.
- The class-selection event should be integrated into the tutorial narrative through training, an oath, attunement, guild initiation, advice, or another world-appropriate mechanism to be defined later.
- The implementation should use shared class data and modular presentation so supporting eight starting classes across three characters does not require twenty-four separately designed combat kits.

### IF-NAR-001 — Fictional Ownership of Companion Class Choice

- **Status:** Proposed
- Although the player makes the mechanical selection, the tutorial companions should retain agency within the fiction.
- A strong working approach is for each companion to reach a genuine class decision and ask the protagonist for advice, allowing the player's selection to function as an in-character relationship moment.
- The exact tutorial event and reason all eight base disciplines are available remain open until the world premise is established.

### IF-CHR-001 — Player-Authored Protagonist Identity

- **Status:** Locked at concept level
- Character creation allows the player to define the protagonist's name, appearance, personality, history, background, and other appropriate identity choices.
- These choices are separate from the protagonist's selected base class.
- Personality and background can affect dialogue, narration, relationships, recognition, and available story approaches without being reduced to combat-stat packages.
- The exact character-creation format, number of choices, and degree of mechanical consequence remain open.

### IF-CHR-002 — Renameable Authored Companions

- **Status:** Locked at concept level
- The two tutorial companions have default names that the player may change.
- Renaming does not replace or rewrite their authored personality, history, relationships, personal motives, or story role.
- Their dialogue voice and behavioral identity remain consistent across every starting-class selection.

### IF-CHR-003 — Personality- and History-Driven Passives

- **Status:** Locked as a design direction
- Each authored tutorial companion may possess fixed passive narrative traits derived from personality, upbringing, and history.
- These passives primarily open conversations, recognition, interjections, social routes, contextual knowledge, or story opportunities.
- They should not generally alter how the selected class performs in combat or make one class choice mathematically preferred for that companion.
- Working examples include:
  - A determined and stubborn character who is the child of a blacksmith and can access conversations involving smithing, labor, craftspeople, or perseverance.
  - An easygoing and light-hearted runaway royal who can recognize court customs, noble relationships, etiquette, heraldry, or concealed political information.
- These are working archetypes rather than locked final characters.

### IF-CHR-004 — Identity and Class Remain Separate

- **Status:** Locked as a design principle
- A character's authored or player-selected personality and background answer who that character is.
- A base class answers what discipline that character has learned and what class systems they can use.
- Class selection may create contextual dialogue or exploration knowledge, but it should not overwrite the character's established temperament, upbringing, loyalties, or personal arc.
- Class-derived exploration and dialogue capabilities are governed by earned Class Expertise rather than granted at full strength immediately upon class selection.

### IF-EXP-005 — Per-Character Class Expertise

- **Status:** Locked at concept level
- Every base class has an Expertise progression that develops separately for each character who possesses that class.
- Selecting a class grants entry into that discipline but does not immediately grant mastery of all its exploration, investigation, dialogue, environmental, or contextual capabilities.
- Expertise represents learned application of the class beyond its basic combat kit.
- Higher Expertise can reveal observations, open dialogue responses, identify objects or phenomena, improve class-specific interactions, unlock alternate routes, and enable more advanced solutions.
- The protagonist and both authored tutorial companions follow the same Expertise rules.
- An authored companion assigned Thief may eventually identify criminal signals, traps, concealed mechanisms, or suspicious behavior, but must earn the required Thief Expertise.
- Personal background and personality passives remain separate and may provide knowledge that the character possesses from the beginning.

### IF-EXP-006 — Party Expertise Contributions

- **Status:** Locked as a design direction
- An active party member with sufficient relevant Expertise can contribute that knowledge to exploration or conversation even when they are not the protagonist.
- Companion contributions should be presented as observations, interjections, advice, or offered actions consistent with that character's fixed personality.
- The player retains control over the party's final response whenever the situation permits a choice.
- The source character should be identified so earned Expertise feels attached to an individual rather than functioning as an anonymous party statistic.
- Only characters currently present and able to participate normally contribute Expertise unless a specific system provides remote knowledge or preparation.

### IF-EXP-007 — Expertise Must Be Earned Without Grinding

- **Status:** Locked as a design principle
- Expertise growth must represent meaningful practice, training, discoveries, decisions, or accomplishments rather than repetitive low-risk action spam.
- Repeating the same trivial interaction should not provide an efficient path to mastery.
- The exact progression model may combine class level, meaningful use, trainers, quests, milestones, discoveries, and class-specific accomplishments.
- Basic class identity should be visible early, while advanced world influence remains something the character demonstrably earns.
- When class fusion is later implemented, each character retains and develops Expertise associated with every base-class ingredient they possess; exact fusion and specialization modifiers remain open.

### IF-EXP-008 — Accomplishment and Training Progression

- **Status:** Locked at concept level
- Class Expertise is earned primarily through meaningful class-specific accomplishments, training, quests, discoveries, and successful application of the discipline.
- Character level or another broad progression threshold gates access to higher Expertise ranks and prevents premature mastery.
- Ordinary character-level advancement does not automatically grant full Expertise progression by itself.
- Examples of qualifying progress may include resolving a class-relevant obstacle, learning from a trainer, discovering specialized knowledge, completing a class-tagged objective, or applying the class successfully in a consequential situation.
- Repeated trivial actions, safe loops, and duplicated low-level interactions do not provide efficient or unlimited Expertise growth.
- Every class must have multiple reasonable sources of Expertise progress so missing one trainer, quest, or route does not permanently cripple development.
- An authored companion can earn Expertise through active participation and relevant accomplishments under the same rules as the protagonist.
- Expertise does not use branching choices or spendable Expertise points. Exact rank names, thresholds, and credit values remain open.

### IF-EXP-009 — Level Curriculum and Achievement Perks

- **Status:** Locked at concept level
- Class Expertise contains two complementary forms of progression:
  1. **Level Curriculum:** Simple skills and baseline versions of important class capabilities unlock automatically at defined character or class levels.
  2. **Expertise Achievements:** More advanced passives, improved techniques, and specialized world capabilities unlock automatically after the character completes qualifying class-specific accomplishments.
- The Level Curriculum guarantees that a class develops its expected foundational identity even when a particular campaign route contains fewer opportunities for one activity.
- Expertise Achievements reward demonstrated practice without asking the player to spend points or choose between mutually exclusive branches.
- Unlocking a perk never removes access to another potential Expertise reward.

### IF-EXP-010 — Background Challenge Tracking

- **Status:** Locked at concept level
- The game tracks qualifying class actions and accomplishments separately for each character in the background.
- Example Thief progress includes successfully opening meaningful locks, bypassing encounters through stealth, disarming traps, exploiting concealed routes, and completing relevant training.
- Reaching a defined threshold automatically grants the associated Expertise passive, skill, permission, or improvement.
- Example: after sufficient qualifying lock work, the character earns an Expertise achievement that permits attempts against a higher lock difficulty.
- A character only receives credit when that character meaningfully performs or contributes to the qualifying action.

### IF-EXP-011 — Meaningful Credit Rules

- **Status:** Locked as a design principle
- Repeatedly interacting with the same object, target, encounter, or reversible setup cannot generate repeated Expertise credit.
- Qualifying accomplishments should normally be unique, first-time, risk-bearing, resource-bearing, or connected to actual progress.
- Difficulty may weight credit so one sophisticated lock, dangerous infiltration, or important class challenge can count more than several elementary actions.
- Trainers, manuals, quests, and discoveries can provide alternate credit when campaign content does not naturally supply enough qualifying actions.
- Thresholds must be tuned against the content actually present in the game rather than chosen as arbitrary large numbers intended to prolong playtime.

### IF-EXP-012 — Expertise Achievement Feedback

- **Status:** Locked at concept level
- When an Expertise challenge is completed, the game presents a concise achievement-style notification naming the earned passive, skill, or capability.
- The notification should explain the practical result clearly, such as gaining permission to attempt a higher category of lock.
- Expertise rewards take effect immediately unless the skill explicitly requires training, equipment, or another stated condition.
- The interface should preserve a record of earned Expertise so the player can understand why the character possesses each capability.
- Unearned Expertise achievements and their progress remain hidden. They do not appear as locked entries, silhouettes, counters, or conventional quests.

### IF-EXP-013 — Unmarked Expertise Challenges

- **Status:** Locked at concept level
- Expertise achievements function like unmarked side quests or *Fallout: New Vegas*-style challenge perks: their requirements are tracked silently while the player naturally plays the game.
- The game does not announce, mark, or add an Expertise challenge to a quest log before completion.
- Completing all qualifying requirements reveals the achievement for the first time through its unlock notification and immediately grants its reward.
- Hidden requirements should describe coherent accomplishments that make the awarded Expertise feel like a recognition of demonstrated behavior rather than a random surprise.
- After discovery, the permanent Expertise entry may explain the completed requirements or summarize the behavior that produced the reward.

### IF-EXP-014 — Expertise Menu

- **Status:** Locked at concept level
- The main menu includes a dedicated **Expertise** tab organized into **Class Expertise** and **General Expertise**.
- Class Expertise contains earned capabilities tied to particular class disciplines.
- General Expertise contains earned capabilities that are not exclusive to one class discipline.
- The tab displays only Expertise the relevant character has already earned; it is a record of discovered mastery rather than a preview checklist.
- Baseline level-curriculum abilities remain part of ordinary class progression and do not create hidden placeholder entries in the Expertise tab.
- Class Expertise and General Expertise are both stored separately for each character rather than shared across the party.

### IF-EXP-015 — Per-Character General Expertise

- **Status:** Locked at concept level
- General Expertise belongs to the individual character whose experiences fulfilled its hidden requirements.
- Progress, rewards, and discovered entries do not merge into a party-wide pool when characters travel together or change the active formation.
- When several characters contribute to an event, credit should follow the character who meaningfully performed or resolved the qualifying action unless a particular achievement explicitly supports shared contribution.
- Truly party-wide accomplishments, world discoveries, and campaign milestones should normally be recorded through another system rather than disguised as personal Expertise.

### IF-EXP-016 — One Challenge System, Two Expertise Families

- **Status:** Proposed
- Class Expertise and General Expertise should use the same unmarked challenge-perk machinery rather than functioning as unrelated progression systems.
- Class Expertise deepens capabilities that belong to a base class's defining discipline. If lock mastery is part of the Thief's identity, increasingly difficult lock permissions belong under Thief Expertise.
- General Expertise reflects the individual character's broader lived experience in activities not owned by one class, such as repeated successful bartering.
- Classification should follow the identity of the reward rather than merely the action that advanced it.
- The design should avoid parallel Class and General tracks that improve the same capability, because duplicated progression would make ownership and interface feedback difficult to understand.

### IF-EXP-017 — Selected Actor and Party Awareness

- **Status:** Locked at concept level
- The character selected in the overworld should be the default actor for deliberate interactions, including locks, bartering, intimidation, object use, and other intentional actions.
- The selected actor's Expertise, background, and other personal modifiers resolve the interaction and receive any resulting progression credit.
- The game should not silently substitute or pool the party's highest relevant Expertise.
- When the fiction permits another present party member to take over, the interface may offer a clear, low-friction handoff before commitment rather than forcing the player to exit and reposition.
- Genuinely passive observations, such as noticing a concealed object or recalling relevant knowledge, check all present and able party members; the character who succeeds is identified and receives appropriate credit.
- This hybrid preserves the meaning of character selection without making the player miss passive discoveries merely because the wrong party member happened to be leading.

### IF-CMP-001 — Persistent Recruitable Companions

- **Status:** Locked at concept level
- The player can recruit optional companions through exploration, quests, relationships, discoveries, and other events during the adventure.
- Recruited companions persist, gain levels or equivalent growth, and learn new abilities, tricks, or passive traits.
- Recruitment should feel like a consequence of adventure rather than an impersonal equipment drop or mandatory checklist.
- Example: a Cleric befriends a baby dragon whose overworld trick can ignite small fires and which also participates in battle.

### IF-CMP-002 — Class Companions and Summons

- **Status:** Locked at concept level
- Some base classes include companion or summoning mechanics in their kit.
- Warden may receive an animal companion; Mage and Warlock may gain summoned creatures or other magical entities.
- Class companions, temporary summons, and recruited companions must operate within a clear companion-slot framework so battlefield population remains controlled.
- Exact rules for reserving, equipping, replacing, or generating occupants of companion slots remain open.

### IF-CMP-003 — Companion Exploration Tricks

- **Status:** Locked as a design direction
- Companions can contribute useful overworld tricks such as igniting small fires, tracking, flying to a switch, squeezing through an opening, digging, carrying, sensing danger, or interacting with particular creatures.
- These tricks allow parties to patch some missing utility without erasing the broader identity of a full class.
- A companion's trick should be narrower in scope, flexibility, or power than the corresponding class's complete exploration capability.
- Companion discoveries should create new solutions and optional opportunities rather than making one specific recruit universally mandatory.

### IF-CMP-004 — Companion Complexity Boundary

- **Status:** Specialized cosmetic-attachment model locked as a design principle
- A companion is treated mechanically as a **specialized cosmetic attachment** that visually accompanies its master and adds its fixed passive-and-active kit to that master.
- Companions are meaningful combat and exploration systems but are not independent player characters with separate movement, initiative, Action Gauges, full resource bars, equipment screens, or equivalent decision load.
- The companion's separate artwork, animation, locomotion, personality, name, equipment appearance, and overworld presence provide the living-character fantasy without creating another combatant simulation.
- Outside its one passive and one active—or one passive and two actives for a Legendary companion—a companion gains no implied independent actions, basic attack, statistics, defenses, or combat subsystems.
- A companion should have a compact identity: a focused ability or trick set, clear growth, and strong synergy opportunities.
- Companion-focused classes may deepen, transform, command, or exploit companion mechanics more effectively than ordinary classes so their class identity remains valuable even when every party can recruit companions.
- Companion durability, ability count, and initial equipment purpose are defined below.

### IF-CMP-005 — Attached Combat Component

- **Status:** Locked at concept level
- A companion remains physically beside its master throughout combat and moves whenever its master moves.
- The companion inherits its master's current zone and does not select an independent battlefield position.
- The companion cannot act outside its master's initiative block.
- Active companion behavior is commanded by the master during the master's available activation window.
- The initiative ribbon represents the master as the combatant and nests or attaches the companion's icon to that portrait rather than granting the companion a separate initiative portrait.
- Companions function structurally more like deep, living equipment than additional party members.
- Companion commands appear as additions to the master's available interface during that master's activation rather than opening a separate companion turn or command screen.

### IF-CMP-006 — Companion Effect Modes

- **Status:** Locked as a design direction
- Companion kits may contain one or more of the following:
  - **Command:** The master deliberately orders an active attack, support action, movement interaction, or special trick.
  - **Passive:** A continuous benefit or rule modification requiring no separate command.
  - **Triggered:** A chance-based or conditional effect at the start of the master's turn, after a qualifying action, when entering a zone, when attacked, or at another explicit timing point.
  - **Exploration Trick:** An overworld interaction or capability associated with the companion.
- Examples include a mangy dog attempting to frighten smaller enemies by barking and a conjured elemental having a chance to imbue party weapons at the start of its master's turn.

### IF-CMP-007 — Master Position Determines Companion Reach

- **Status:** Locked at concept level
- Companion effects calculate range, targets, and positional requirements from the master's zone and local position.
- A melee companion such as a rat requires its master to be in an appropriate melee position before it can attack.
- A ranged or magical companion such as a summoned imp can use qualifying effects while its master remains in Midrange or Backline.
- Assigning a companion to a master whose normal battlefield behavior supports that companion is an intended layer of party construction.
- Reassigning companions can therefore change the tactical role of a character–companion pair without changing either character's class.

### IF-CMP-008 — Data-Driven Companion Depth

- **Status:** Locked as a production principle
- The companion system may grow to a depth comparable to the class system, but new companions should be assembled from reusable command, passive, trigger, range, zone, scaling, usage-limit, and exploration-trick components wherever possible.
- Companion attacks and effects should normally scale from the master, companion level or bond, and a compact set of companion properties rather than a second full character-stat model.
- The combination of character class, fused resources, assigned companion, battlefield zones, and environmental objects is a central source of Infinite Fantasia's long-term possibility space.

### IF-CMP-009 — Companion Command Costs and Limits

- **Status:** Superseded by IF-CMP-021
- The former rule made deliberately commanded companion abilities consume the master's Action Gauge and used per-turn or per-battle limits as additional balance levers.
- On August 25, 2026, the default was replaced with free once-per-turn companion actives. Explicit costs and once-per-battle limits remain available only when a specific companion departs from that baseline.

### IF-CMP-010 — Rat Baseline Example

- **Status:** Rejected as a kit; retained only as early design history
- The former example gave the Rat +1 Basic-Attack damage and a Bite command that spent Action Gauge and had a 15% Disease chance.
- The user rejected the proposed passive and reserved a different design philosophy for the Rat. None of the former example's passive, cost, chance, damage, or final active behavior is binding.
- The only surviving positional principle is established independently by IF-CMP-007: any close-range Rat action derives its reach from the master's position.

### IF-CMP-011 — No Independent Health or Targeting

- **Status:** Locked for the current design
- Companions do not possess independent Health bars and cannot normally be selected as direct targets.
- A companion is not a separate combatant for deployment, collision, range reception, area damage, initiative, status, or defeat resolution. Those systems evaluate the master unless an explicit pair-level effect says otherwise.
- Damage, healing, defeat, and ordinary status management apply to the master rather than creating a parallel companion-survival layer.
- When the master is incapacitated or otherwise unable to command the companion, the companion becomes inactive unless a specific passive says otherwise.
- Explicit effects may suppress, frighten, silence, dismiss, or disable a companion through the character–companion pair without treating it as a separate combatant.

### IF-CMP-012 — Fixed Companion Ability Count

- **Status:** Locked at concept level
- Every standard companion has exactly:
  1. One passive skill.
  2. One active skill commanded through its master.
- A Legendary companion gains one additional active skill, for a total of one passive and two active skills.
- Rarity should primarily add a meaningful new decision or identity rather than merely increasing numerical stats.
- Companion growth may improve, modify, or add interactions to these skills, but should not expand ordinary companions beyond the fixed one-passive/one-active structure.

### IF-CMP-013 — Companion Equipment and Cosmetics

- **Status:** Locked for initial scope
- Some companions have one or more equipment slots appropriate to their anatomy and fantasy.
- Companion equipment is cosmetic in the initial implementation and does not add another statistical equipment system.
- Equipped items visibly alter the companion in the overworld and battle presentation when practical.
- Examples include a tiny helmet for a rat, collars, ribbons, cloaks, barding, saddlebags, charms, or other species-appropriate accessories.
- Whether any companion equipment later gains mechanical effects remains open and is not required for the initial companion system.

### IF-CMP-014 — Visible Overworld Companions

- **Status:** Locked at concept level
- When a character is selected as the active overworld master, that character's assigned companion visibly walks, flies, crawls, floats, or otherwise moves alongside them.
- The companion should feel physically present during exploration rather than existing only as a menu icon or battle effect.
- Companion locomotion and follow behavior should reflect species identity while remaining reliable around obstacles and transitions.
- Cosmetic appearance therefore contributes directly to player expression and the visible experience of exploration.

### IF-CMP-015 — Contextual Overworld Applications

- **Status:** Locked at concept level
- A companion's existing passive or active skill may also have one or more overworld applications.
- Overworld utility does not create a separate third ability slot and is not mandatory for every companion or every skill.
- Important, non-obvious, or defining exploration functions should be stated directly in the skill description or companion interface.
- Obvious systemic interactions may occur through shared tags and environmental rules without enumerating every possible target in the skill text.
- Example: a Fire-tagged active may ignite compatible torches, oil, dry vegetation, or mechanisms according to the world's general Fire interaction rules even when every object is not named individually.
- Companion skills should use the same environmental language and interaction tags as class abilities so experimentation remains consistent across systems.

### IF-CMP-016 — Expedition Companion Roster

- **Status:** Locked at concept level
- The party chooses three traveling companions when leaving town, beginning an expedition, or using another true long-rest-equivalent expedition reset.
- Recruited companions outside those three remain behind and cannot be swapped into the active roster during the expedition under ordinary circumstances.
- While out of combat, the player may freely reassign the three traveling companions among the three active character slots.
- Companions cannot be reassigned during battle unless an explicit ability or encounter rule creates an exception.
- Separating roster selection from master assignment preserves expedition planning while allowing tactical experimentation with character–companion pairings.
- The game should not permit the player to carry an invisible complete companion collection and summon the perfect exploration answer from storage at every obstacle.
- How a newly recruited companion is handled during an expedition remains an implementation and narrative exception to define later.

### IF-CMP-017 — Prototype Companion 1: Sewer Rat

- **Status:** Identity and core kit locked; damage and direct-control boundaries remain open
- Prototype Companion 1 is a **Sewer Rat** and serves as the prototype's close-range ordinary companion.
- In a later build, the Sewer Rat is discovered and befriended within the starting city's sewer. Prototype 0.1 makes it available immediately while preserving that future recruitment location.
- Its commanded action operates at close range according to its master's current position; the Rat does not occupy an independent zone or leave its master's side.
- The Sewer Rat establishes a close-range application of the minimum companion pattern: one persistent passive, one commanded active, a reach requirement, and an explicit use cadence.
- The proposed **Opportunistic Bite** passive and its automatic +1 damage to close-range Basic Attacks are rejected; **Infiltrator** below replaces that early example.
- Its passive is **Infiltrator**: **Control this companion in the overworld through the Pet screen. It can use Tiny-Character Passageways and chew through certain objects.**
- Infiltrator occupies the Rat's single passive slot even though its primary benefit is exploration rather than combat.
- Its active is **Gross Gnaw**: **Deal X damage. Has an abysmal chance to inflict Disease.**
- Gross Gnaw is a free close-range command usable once per turn. **Abysmal** resolves through the established hidden 1% chance rung.
- Gross Gnaw's exact damage and damage-form tag remain open. Infiltrator's control range, party behavior during control, scene-transition rules, detection rules, and exact valid objects also remain open.

### IF-CMP-018 — Prototype Companion 2: Mangy Mutt

- **Status:** Identity, acquisition concept, and core combat kit locked; overworld-warning design deferred beyond Prototype 0.1
- Prototype Companion 2 is the **Mangy Mutt**, a classic unwanted stray dog that becomes the player's first companion during normal game progression.
- The player shows it a single moment of kindness by petting it. The dog then begins following the player because no one else wanted it.
- The introduction should feel like an immediate response from a living creature rather than a formal quest reward, purchase, or elaborate recruitment ceremony.
- The acquisition naturally introduces visible overworld following and can become the player's first practical exposure to companion attachment and assignment.
- Prototype 0.1 makes the Mangy Mutt available for system testing without yet building this recruitment sequence.
- Its passive is **Man's Best Friend**: **At the start of the master's turn, remove Sleep from them. Warn the master of certain dangerous overworld triggers.**
- The waking effect resolves before Sleep can deny the master that turn's actions. It is the explicit passive exception anticipated by IF-CMP-011: it functions while the master is incapacitated by Sleep even though the master could not command an active companion ability.
- Overworld warnings alert the player to designated dangers early enough to respond; they do not automatically prevent, disarm, or negate those dangers.
- Its active is **Guard Dog**: **Bark at all Small enemies within range. Has a Modest chance to inflict Fear.**
- Guard Dog is a free companion command usable once per turn. It consumes no Health, Action Gauge, Primary Resource, PP, or companion resource and deals no damage.
- **Modest** resolves through the established hidden 20% chance rung.
- Fear inflicted by Guard Dog lasts **1 turn**. This duration belongs to Guard Dog rather than to the canonical Fear tag.
- Guard Dog rolls its Modest Fear chance independently for every eligible Small enemy. One target's success or failure does not affect any other target's result.
- Guard Dog uses the continuous radial-range model in IF-CBT-009, centered on its master's current battlefield focal point. Its circular range may cross zone boundaries according to the master's exact horizontal and vertical position.
- Guard Dog carries the **Sound** tag and follows IF-CBT-011: combatants, ordinary cover, and visual line-of-sight obstruction do not block it, while solid walls and sealed barriers do.
- Guard Dog's exact radius is deferred to the numerical pass.
- Man's Best Friend's overworld-warning function remains part of the companion's permanent concept, but its trigger categories, detection rules, and presentation are not required for Prototype 0.1 and will not be designed now.
- The exact city location, whether the recruitment can be missed, personal name or renaming rules, warning implementation, and progression remain open for later milestones.

### IF-CMP-019 — Item- and Class-Granted Companions

- **Status:** Locked at concept level
- A character's companion slot may be filled by a companion granted through an equipped item or relic rather than by assigning a recruited companion from the expedition roster.
- An item-granted companion remains automatically attached to the item's wearer for as long as the granting item remains equipped and cannot be reassigned independently of that item.
- If the wearer already has a recruited companion assigned, equipping the granting item requires confirmation. Confirming safely returns that companion to the available expedition roster and replaces it with the item-granted companion; canceling aborts the equipment change.
- Removing the granting item removes its companion and leaves the companion slot empty. The previously assigned companion is not restored automatically.
- Item-granted companions use the same fundamental combat contract as recruited and class-granted companions: they remain beside the master, use the master's position and Action Gauge, act only through the master, have no independent Health, and receive the appropriate passive-and-active kit.
- Later class features may grant companions through the same source-neutral attachment architecture rather than creating a separate summon system.
- The interface must clearly identify the source that is filling the slot and explain why an item- or class-granted companion cannot be freely reassigned.

### IF-CMP-020 — Prototype Companion 3: Lesser Storm Elemental

- **Status:** Core kit locked; Tailwind reduction, exact range, and remaining details remain open
- Prototype Companion 3 is a **Lesser Storm Elemental** summoned by an amulet equipped to the prototype Mage.
- The amulet displays **Requires: Mana** and may be equipped by any character who possesses the Mana resource, including future Mage hybrid classes.
- While the amulet remains equipped, the Elemental automatically fills the Mage's companion slot. Removing the amulet removes the Elemental.
- The Elemental provides the prototype's ranged companion proof and demonstrates how equipment can summon a companion before later class features introduce class-granted summons.
- The Elemental has exactly one passive and one active ability.
- Its passive is **Tailwind**: the master's first zone transition each turn costs less Action Gauge.
- Tailwind's reduction must appear in the movement path and Action-Gauge cost preview before the player commits the transition. Its exact reduction remains open for the numerical pass.
- Its active ability is **Wind Shear**: deal **3 Wind damage** at range. Wind Shear has no Piercing, Slashing, Bludgeoning, or other non-elemental damage-form tag.
- Wind Shear therefore establishes that an elemental attack may deal damage using only its Element tag when no physical damage form applies.
- Wind Shear is a free companion command usable once per turn. It consumes no Action Gauge, Mana, other Primary Resource, or PP.
- Wind Shear's exact range, targeting rules, and any interaction permissions remain open.

### IF-CMP-021 — Free Once-per-Turn Companion Baseline

- **Status:** Locked as the default companion design philosophy
- A standard companion's active ability is normally a **free command usable once per turn**.
- Free companion commands consume no Health, Action Gauge, Primary Resource, ability PP, or separate companion resource.
- The once-per-turn command opportunity is itself the baseline limit. It refreshes at the companion master's next eligible turn.
- Companion commands remain deliberate actions selected during the master's turn even though they do not deplete one of the master's bars.
- Companion actives should therefore be intentionally modest relative to class abilities, while the companion's passive provides a useful defining contribution. That passive may be combat-facing, exploration-facing, or applicable to both.
- Balance normally comes from effect size, targeting, range, conditions, trigger timing, and the interaction between the active and passive rather than from charging the master's resources.
- A particular companion may explicitly use a once-per-battle limit, an Action-Gauge cost, a resource cost, or another restriction when its effect justifies departing from the baseline.
- The attached companion icon must display whether its active is ready or already used for the turn. Free commands do not show an Action-Gauge depletion preview unless that companion explicitly has an Action-Gauge cost.

### IF-CMP-022 — Direct Overworld Companion Control

- **Status:** Capability, party anchoring, transition category, and voluntary return locked; remaining danger and range boundaries remain open
- A companion skill may allow the player to take direct overworld control of that companion through the Pet screen.
- Direct control is granted only by an explicit companion skill such as Infiltrator; it is not an automatic feature of every companion.
- The controlled companion uses its own locomotion and stated interaction permissions while the ordinary party remains represented separately.
- When direct companion control begins, the ordinary party remains stationary at the release point. Party members do not follow, repath toward, or teleport behind the controlled companion.
- Only the companion moves until direct control ends. Returning control to the party resumes ordinary movement from the party's unchanged position.
- Direct overworld control does not grant the companion independent combat turns, Health, resources, a complete character interaction set, or automatic access to its master's Expertise.
- The Sewer Rat is the first implementation: Infiltrator lets it use Tiny-Character Passageways and chew through objects explicitly compatible with that capability.
- A directly controlled tiny companion may cross scene or subarea boundaries only through a compatible Tiny-Character Passageway. It cannot use ordinary party doors, stairways, map exits, or unrelated transitions without another explicit permission.
- The Pet interface provides a **Return to Party** command. Using it ends direct control and automatically returns the companion to its master through an implied retracing of the valid route.
- The player is not required to manually walk the companion back through already traversed passageways. A brief transition may communicate the return without simulating the entire journey.
- Returning does not undo switches, chewing, collected information, or other world-state changes completed during direct control.
- How far the companion may travel, how involuntary control endings and danger are handled, and how valid routes and objects are communicated remain open.

### IF-RES-001 — Three Base-Class Bars

- **Status:** Locked at concept level
- Every Tier-1 character has three primary bars:
  1. Health.
  2. Action Gauge.
  3. The unique resource belonging to that base class.
- Health and Action Gauge are universal. The third resource is part of the class's identity and must differ mechanically rather than functioning as renamed Mana.

### IF-RES-002 — Base-Class Resource Identities

- **Status:** Partially locked

| Base class | Resource | Current direction |
| --- | --- | --- |
| Warrior | Resolve | Defensive commitment, pressure resistance, guarding, and martial techniques. |
| Mage | Mana | A stored magical pool that can support deliberate spell-heavy turns. |
| Thief | Energy | A rapidly cycling resource for tricks, mobility, and opportunistic actions. |
| Cleric | Faith | Divine power shaped by worship, conduct, support, and sacred actions. |
| Archer | Focus | Precision accumulated or preserved through aim, position, and controlled action. |
| Barbarian | Rage | Power generated through aggression, injury, and sustained combat. |
| Warden | Open | Working possibilities include Harmony, Essence, or another nature-specific model. |
| Warlock | Open | Corruption or Insanity are working directions; the final name and risk model remain open. |

### IF-RES-003 — Resource Lifecycles as Class Restrictions

- **Status:** Locked as a design principle
- Each base resource must differ in how it begins an encounter, is generated, is preserved or lost, is spent, and is restored.
- These lifecycle rules are the primary restrictions on repeated spell and ability use because class abilities normally do not consume Action Gauge.
- A resource-heavy build may intentionally enable an explosive multi-ability turn.
- Classes should not receive arbitrary one-action limits merely to recreate a hidden hard-AP system.
- Individual abilities may still have costs, cooldowns, limited uses, setup requirements, positioning requirements, or other restrictions appropriate to their fantasy.

### IF-RES-004 — Fusion Resource Inheritance

- **Status:** Locked at concept level
- Adding a distinct base class later adds that base class's resource bar rather than replacing or merging the existing resource.
- Example: a Warrior–Mage Spellsword possesses both Resolve and Mana, and its defining class mechanics are designed to use, convert, or require both.
- A three-way ABC hybrid may therefore possess Health, Action Gauge, and three separate class-resource bars.
- Repeating the same base class should deepen or improve its existing resource rather than displaying duplicate identical bars; the exact specialization benefits remain open.
- Hybrid balance must account for the additional resource pools. Fusion abilities that cross-spend resources and behavioral generation requirements are preferred over simply granting multiple independent full turns' worth of abilities.

### IF-RES-005 — Numeric Ability-Use Model

- **Status:** Locked at concept level
- Infinite Fantasia will not use the Dungeons & Dragons/BG3 spell-slot model as its general ability system.
- Spells and class abilities consume both:
  1. An amount from the relevant shared class-resource bar.
  2. One or more uses from that specific ability's individual PP pool.
- Example: Fireball may cost Mana and reduce Fireball's own PP from 6/6 to 5/6.
- Basic attacks, ordinary movement, and ordinary environmental interactions use Action Gauge and do not require PP unless a specific effect says otherwise.
- This is a numeric resource-and-use system, not a spell-slot preparation system.

### IF-RES-006 — Purpose of the Dual Limit

- **Status:** Locked as a design principle
- The shared class resource limits the character's total exceptional output and creates the class-specific resource lifecycle.
- Individual PP limits repeated use of a particular ability and encourages broader use of the character's available techniques.
- A resource-heavy build may intentionally use many spells or abilities during one activation, but cannot automatically convert its entire resource pool into repeated use of only the mathematically strongest ability.
- Builds, equipment, passives, consumables, and class mechanics may increase, restore, conserve, exchange, or overdraw resource and PP under controlled rules.
- PP is an encounter-level limit and automatically resets after battle.

### IF-REC-001 — Automatic Post-Battle Reset

- **Status:** Locked at concept level
- After every battle, each character's Action Gauge resets to its default amount.
- Every spell and class ability's PP automatically resets to its default maximum.
- Each class-resource bar resets to that class's defined default amount.
- Default does not always mean full. Mana may begin full while Rage begins empty, and other resources may begin at distinct baselines appropriate to their lifecycle.
- No manual rest action, camp interaction, repeated menu selection, or recovery animation is required for these resets.

### IF-REC-002 — Automatic Provision Healing

- **Status:** Locked at concept level
- Health lost in battle is automatically restored after battle when the party possesses eligible provisions such as food, drinks, medicine, or other recovery supplies.
- The game consumes the required provisions automatically instead of asking the player to perform routine inventory actions or initiate a rest sequence.
- Recovery should resolve immediately or through a compact summary rather than consuming real time through an uninteractive animation.
- Inventory recovery supplies are referred to as **provisions** in design discussion to distinguish them from class-resource bars.
- When provisions are insufficient, the system restores as much Health as the available provisions allow and leaves the party partially injured.
- The exact conversion between provisions and restored Health, treatment of status conditions, and consumption priority remain open.

### IF-REC-003 — Configurable Recovery Policy

- **Status:** Locked at concept level
- Automatic post-battle recovery follows a standing player-configured policy rather than presenting a recovery prompt after every encounter.
- The policy can automatically combine provisions with eligible out-of-combat class abilities.
- Initial policy presets should include:
  - **Conserve Expedition Abilities:** Spend provisions first; use field healing only when supplies are insufficient or another configured condition is met.
  - **Conserve Provisions:** Spend eligible field-healing uses before provisions when doing so is efficient.
  - **Balanced:** Preserve configurable minimum reserves of both provisions and Expedition PP.
- The system should respect efficiency thresholds and avoid wasting a limited heal on negligible missing Health or using a large group heal for one minor injury.
- Advanced configuration may allow the player to reserve a minimum number of uses of particular abilities or exclude an ability from automatic recovery.
- Once configured, recovery resolves without additional confirmation until the player changes the policy.

### IF-REC-004 — Automatic Routine Condition Treatment

- **Status:** Locked at concept level
- The configurable recovery policy also uses eligible remedies and out-of-combat cleansing abilities to remove ordinary post-battle conditions such as Poison, Bleeding, or Burning.
- Treatment respects the same conservation priorities, reserve thresholds, efficiency rules, and exclusions used for Health recovery.
- Routine conditions should not require repetitive post-battle inventory actions when the party already possesses the appropriate treatment.
- Major curses, diseases, injuries, story afflictions, and other deliberately persistent conditions may be excluded from automatic removal and require specific treatment.

### IF-BAL-001 — Full-Strength Encounter Assumption

- **Status:** Locked as a balance principle
- Encounters are designed under the assumption that a correctly prepared player begins at the intended default Health, Action Gauge, class-resource, and PP state.
- Previous encounters primarily tax provisions rather than forcing routine combat-resource hoarding or repeated rest interactions.
- This permits encounters to be balanced as complete tactical problems and encourages players to use their class abilities rather than preserving them for an unknown later fight.
- Encounter-level PP means a low-PP ability is limited within each battle, not across an entire dungeon.
- Strong opening turns must be balanced through resource defaults, PP, setup requirements, positioning, enemy composition, reactions, and encounter structure rather than persistent depletion.

### IF-EXP-001 — Every Class Contributes to Exploration

- **Status:** Locked as a design principle
- Every base class must provide useful exploration, traversal, investigation, dialogue, recovery, obstacle, or environmental capabilities outside of combat.
- Exploration utility is part of a class's identity rather than a secondary perk reserved for traditional utility classes.
- A party should feel the absence and presence of each class without one class becoming universally mandatory.
- Important objectives should normally support multiple class-informed approaches rather than requiring one prescribed party composition.

### IF-EXP-002 — Expedition Abilities

- **Status:** Locked at concept level
- Some out-of-combat abilities have limited uses per dungeon expedition or between true long rests.
- These abilities use a persistent **Expedition PP** cadence rather than the encounter PP used by combat abilities.
- Expedition PP resets when the party returns to town or performs another meaningful long-rest-equivalent expedition reset.
- A long rest is an expedition boundary, not a routine post-battle recovery interaction.
- Routine combat PP, Action Gauge, and class-resource resets still occur automatically after every fight.

### IF-EXP-003 — Field Recovery Classes

- **Status:** Direction locked; exact abilities open
- Cleric and Warden will have access to limited out-of-combat recovery abilities.
- Warlock may also receive unconventional recovery through sacrifice, life transfer, Corruption, ritual, or another class-appropriate mechanism.
- These abilities can compensate for depleted provisions, conserve supplies, or recover from unusually damaging encounters.
- Because their uses persist across encounters, they create real expedition decisions without requiring repetitive rest behavior.
- Field recovery can participate in the configurable automatic recovery policy. Manual activation may also remain available but is not required after routine encounters.

### IF-EXP-004 — Working Exploration Identities

- **Status:** Proposed

| Base class | Possible exploration contribution |
| --- | --- |
| Warrior | Brace structures, protect the party from hazards, force mechanisms, or apply martial knowledge. |
| Mage | Identify or manipulate enchantments, magical mechanisms, wards, and arcane phenomena. |
| Thief | Detect and disarm traps, open locks, scout, conceal the party, and exploit illicit routes. |
| Cleric | Heal, cleanse, recognize sacred traditions, interact with divine sites, and address curses. |
| Archer | Scout at distance, notice remote details, track trajectories, and activate distant mechanisms. |
| Barbarian | Break obstacles, move massive objects, intimidate, and survive physically punishing routes. |
| Warden | Heal, forage, communicate with nature, track wildlife, and create or reveal natural paths. |
| Warlock | Interpret occult signs, perform dangerous rituals, manipulate curses, and exchange risk for recovery or access. |

## 5. Locked Class Framework

### IF-CLS-001 — Three Base-Class Selections

- **Status:** Locked
- The player makes three total base-class selections:
  - First selection at Level 1.
  - Second selection at Level 20.
  - Third selection at Level 40.
- Players always select a base class. They never directly select an advanced class.

### IF-CLS-002 — Tier Definition

- **Status:** Locked
- Tier 1 = one base-class selection.
- Tier 2 = two base-class selections.
- Tier 3 = three base-class selections.

### IF-CLS-003 — Composition Rules

- **Status:** Locked
- Selection order does not matter.
- Selection counts do matter.
- Warrior + Mage + Cleric is identical to Cleric + Warrior + Mage.
- Warrior + Warrior + Cleric is distinct from Warrior + Cleric + Cleric.

### IF-CLS-004 — Tier-3 Composition Types

- **Status:** Locked
- **AAA:** Pure specialization.
- **AAB:** One dominant base with a secondary influence.
- **ABC:** True three-way hybrid.

### IF-CLS-005 — Base-Class Roster

- **Status:** Locked

| Base class | Foundational identity | Typical equipment/flavor |
| --- | --- | --- |
| Warrior | Durable, defensive martial combat | One-handed weapon and shield |
| Mage | Learned arcane magic | Staff, or wand and tome |
| Thief | Agile, sneaky, underhanded play | Dual blades |
| Cleric | Deity-centered holy magic; modest healing and holy damage | Mace and tome, or staff |
| Archer | Ranged precision and perception | Bow |
| Barbarian | Aggressive, brutal martial combat | Two-handed weapon of any kind |
| Warden | Nature magic and stronger healing | Staff |
| Warlock | Dark, cursed, or corrupt magic; demon summoning | Staff, or wand and tome |

### IF-CLS-006 — Pure Specialization Lines

- **Status:** Locked, except where noted

| Tier 1 | Tier 2 | Tier 3 | Ultimate identity |
| --- | --- | --- | --- |
| Warrior | Champion | Bastion | Defense taken to its extreme |
| Mage | Wizard | Sage | Arcane mastery taken to its extreme |
| Thief | Assassin | Shade | Stealth and lethality taken to their extreme |
| Cleric | Zealot | Divine Vessel | Divine devotion taken to its extreme |
| Archer | Marksman | Deadeye | Precision taken to its extreme |
| Barbarian | Juggernaut* | Colossus | Brutal physical power taken to its extreme |
| Warden | Grovekeeper | Lifebinder | Nature and healing taken to their extreme |
| Warlock | Demonologist | Netherlord | Demon summoning and occult power taken to their extreme |

\* **Juggernaut** remains explicitly open to renaming.

### IF-CLS-007 — Class Selection Interface

- **Status:** Locked at concept level
- The class screen uses three vertical panels.
- The left panel is available from the start.
- The middle panel unlocks at Level 20.
- The right panel unlocks at Level 40.
- Exact visual styling and interaction behavior remain open.

### IF-CLS-008 — Prototype Mage Spell Set

- **Status:** Ability identities locked; exact mechanics and numbers remain open
- The Prototype 0.1 Mage has **Fireball**, **Snowball**, and **Arcane Missile**.
- Their working elemental identities are Fire, Ice, and Arcane respectively.
- Exact damage, range, Mana cost, PP, targeting, secondary effects, interaction tags, and damage-form tags remain open unless defined by a later entry.
- The Mage also wears the amulet that grants the Lesser Storm Elemental for Prototype 0.1, allowing one character package to prove both spell diversity and an item-granted companion.

### IF-CLS-009 — Prototype Berserker Rage and Weapon Package

- **Status:** Core equipment, Rage-generation roles, physical-ammunition model, and recovered-axe timing locked; exact numbers and pickup cost remain open
- The Prototype 0.0.5 Rage-class combatant uses **Berserker** as its working label and begins each encounter with an empty Rage bar.
- Receiving damage generates Rage. The exact conversion between damage received and Rage gained remains provisional.
- The Berserker equips a two-handed weapon that supplies its ordinary baseline Basic Attack. That attack generates Rage in addition to resolving its weapon-defined damage, reach, Action-Gauge cost, tags, and other properties.
- The Berserker also equips a ranged weapon. For the base-class prototype this weapon is a set of exactly **two throwing axes**.
- Equipping the throwing axes grants **Free Throw**, a second weapon attack that is deliberately low damage, medium range, and primarily intended to improve early Rage generation before the Berserker reaches close combat.
- Free Throw is a separate free weapon action usable once per Berserker turn. It costs no Action Gauge and does not consume or prevent the two-handed weapon's once-per-turn Basic Attack. Committing either attack does not consume the other attack's independent use.
- Free Throw follows the universal ranged-targeting rules, including a source-to-target delivery line, compatible-object targeting, Accuracy, Dodge, partial cover, and any other applicable ranged modifiers.
- Its two PP represent the two physical axes rather than an abstract technique limit. Throwing one consumes one ready axe and leaves a recoverable axe on the battlefield. The remaining carried axe remains available subject to Free Throw's once-per-turn limit.
- Recovering an axe removes that physical axe from the battlefield but places it in an individual **unready** state for the remainder of the Berserker's current turn. It becomes ready and restores one usable Free Throw PP at the start of the Berserker's next turn.
- This recovery delay belongs only to the particular picked-up axe. Any second axe that remained carried and ready is unaffected and may still support Free Throw subject to the action's ordinary once-per-turn limit.
- The exact damage, range, Rage gain, pickup interaction cost, and landing behavior remain prototype tuning or open design decisions.
- Both throwing axes automatically return with the ordinary post-battle PP reset so none can be permanently lost between encounters.
- Whether **Berserker** formally replaces **Barbarian** as the full base-class name remains a separate naming decision; this entry does not silently rename the complete class roster.

## 6. Combinatorial Scope

With eight base classes and order-independent selection with repetition:

| Stage | Distinct compositions |
| --- | ---: |
| Tier 1 | 8 |
| Tier 2 | 36 |
| Tier 3 final builds | 120 |
| Total named states across all tiers | 164 |

### IF-SCP-001 — Content Explosion Risk

- **Status:** Locked as a production constraint
- The complete system cannot rely on every class being built as an entirely independent character kit.
- Shared base-class components and data-driven combination rules are required to keep implementation, UI, balance, and testing manageable.

### IF-SCP-002 — Recommended Class Construction Model

- **Status:** Proposed
- Each base-class selection contributes a standardized package:
  1. Attribute or scaling emphasis.
  2. A resource or combat-rule contribution.
  3. Access to an ability family.
  4. Passive keywords or modifiers.
  5. Gear affinities rather than hard gear locks.
- Each resulting named class then adds a smaller bespoke “fusion identity” that makes the combination interact as a whole.
- AAA capstones intensify one identity, AAB mechanics let the dominant ingredient transform the secondary one, and ABC mechanics create a new three-way interaction.

### IF-SCP-003 — First Prototype Matrix

- **Status:** Superseded
- The earlier proposal was to begin with four base classes and selected AAA, AAB, and ABC paths.
- On August 23, 2026, this was replaced by the decision to restrict the first playable version to base classes only.

## 7. First Playable Vertical Slice

### IF-PRO-000 — Base Classes Only

- **Status:** Locked
- The first playable version will implement only Tier-1 base classes.
- It will not implement Tier-2 or Tier-3 class combinations.
- The number of base classes required in the earliest internal build remains open; the complete intended base roster remains eight.
- The underlying class data should still be designed so that second and third class selections can be added later without rebuilding every character system.

### IF-PRO-001 — Prototype Goal

- **Status:** Proposed
- Prove that the foundational classes possess immediate, legible, and mechanically useful identities.
- The prototype succeeds when players can identify the base classes from how they behave and can explain why they would choose one over another without relying only on stat totals or costume differences.

### IF-PRO-002 — Suggested Slice Contents

- **Status:** Proposed
- One small top-down location and one short dungeon or combat route.
- One dedicated 2D battle scene.
- Basic exploration, interaction, dialogue, battle transition, attacks, abilities, damage, recovery, incapacitation, victory, defeat, and restart.
- A small enemy roster covering melee pressure, ranged pressure, support or disruption, and a durable threat.
- One boss or capstone encounter.
- A deliberately limited set of base classes, eventually expanding to the locked roster of eight.
- A minimal class or party-selection interface.
- Debug controls that can instantly change base classes, party composition, levels, and battle state for testing.

### IF-PRO-003 — What the First Slice Does Not Need

- **Status:** Proposed
- Massive world.
- Persistent online accounts.
- MMO servers.
- Large-scale multiplayer.
- Tier-2 or Tier-3 class combinations.
- Final art, final animation, voice acting, crafting, economy, guilds, housing, or dozens of quests.
- Any portion of the 120-build Tier-3 matrix.

### IF-PRO-004 — First Playable Demo Target

- **Status:** Proposed discussion target
- Limit the first coherent playable build to three base classes with a maximum level of 5.
- Include a deliberately small portion of the main town containing its central area, a few functional buildings, an alleyway, a chapel, and entrances connecting the spaces.
- Use the town sewer as a compact local mini-dungeon that proves exploration, interaction, party utility, combat, recovery, and return-to-town flow.
- Place the beginning or entrance of the first larger dungeon beyond the sewer so the build ends by demonstrating how the adventure can expand outward.
- Reaching this milestone should establish that the game's foundational loop works; subsequent classes, levels, districts, dungeons, and systems should extend the same foundation rather than replace disposable prototype work.
- Exact class selection, town buildings, quest content, sewer encounters, boss structure, and completion boundary remain open for later discussion.

### IF-PRO-005 — Playable Prototype 0.1 Loop

- **Status:** Locked at milestone level; exact content remains open
- The first executable milestone contains one small town square and one complete playable battle.
- The player must be able to move through the town, initiate the battle, complete a victory or defeat loop, and return to or restart from a valid playable state.
- The milestone exists to prove reusable exploration, scene-transition, battle, interface, and data foundations rather than to resemble a content-complete demo.
- Systems not required to prove that loop remain excluded until the foundational implementation is stable.

### IF-PRO-006 — Prototype 0.1 Class Trio

- **Status:** Locked
- Prototype 0.0.1 through 0.0.4 used **Warrior**, **Mage**, and **Archer**, allowing the first complete playable battle to prove the shared movement and Basic Attack foundation.
- Beginning with Prototype 0.0.5, the working trio becomes **Berserker**, **Mage**, and **Archer**. Berserker replaces Warrior in the active test roster without erasing the completed Warrior implementation.
- Berserker proves empty-starting Rage generation, a two-handed baseline Basic Attack, a separate free ranged weapon action, physical ammunition, battlefield pickup, and recoverable equipment.
- Mage proves Mana, ability PP, elemental effects, surfaces, and magical object interactions.
- Archer proves ranged positioning, backline play, object targeting, and positional advantages.
- The trio is selected for the breadth of foundational systems it exposes rather than as a declaration that these classes form the canonical story party.

### IF-PRO-007 — Prototype Companion Proof

- **Status:** Locked for Prototype 0.1
- Prototype 0.1 includes exactly **three companion-system representatives** so every character–companion slot and multiple companion sources can be exercised.
- The Sewer Rat and Mangy Mutt are genuine recruitable starting-city companions. The Lesser Storm Elemental is summoned by an amulet equipped to the Mage rather than recruited into the expedition roster.
- These are permanent game concepts rather than disposable test entities. Their prototype data, rules, and eventual visual identities should carry forward into later builds.
- For Prototype 0.1 the two recruited companions begin available for assignment and the Mage begins with the summoning amulet equipped; city recruitment content and item acquisition are deferred.
- Each companion is limited to the already established ordinary kit of exactly one passive and one active ability. The default active is a free once-per-turn command and does not use the master's Action Gauge, Primary Resource, or PP.
- Players may assign the Sewer Rat and Mangy Mutt among characters outside battle or leave slots empty. The Lesser Storm Elemental remains bound to the amulet's wearer until the amulet is removed.
- The set covers a close-range recruited companion, the player's first ordinary companion, and a ranged item-granted summon. Exact kit roles may create further distinctions later.
- The proof must support assigning and reassigning companions outside battle, showing each companion beside its current master, resolving the passive behavior required by the prototype encounter, commanding its active, enforcing reach from the master's exact battlefield position, displaying once-per-turn readiness, and supporting explicit exceptions to the free-command baseline.
- Prototype 0.1 must support Man's Best Friend waking a sleeping master when the encounter tests Sleep. Its overworld-warning function is explicitly deferred and does not require warning triggers or interface work for this milestone.
- Companion leveling, functional companion-worn equipment, cosmetic customization, recruitment content, and a larger expedition roster remain outside this milestone unless later required by the playable loop.

### IF-PRO-008 — Prototype Narrative and Portrait Boundary

- **Status:** Locked for Prototype 0.1
- Detailed development of the two authored starting party members—including their final identities, histories, personalities, relationships, visual designs, complete expression artwork, and extensive contextual commentary—is deferred until the foundational playable loop is working.
- This deferral does not reverse their permanent role as authored party members or any locked portrait-system architecture. It prevents narrative and art production from blocking validation of exploration, battle, companions, environmental interactions, and interface flow.
- Prototype 0.1 may identify the party through temporary names, labels, silhouettes, or placeholder faces. The current Berserker, Mage, and Archer prototype assignments remain system-test roles rather than canonical story-class declarations; Berserker takes the test slot occupied by Warrior through Prototype 0.0.4.
- Prototype UI must retain the locked 64×64 portrait data contract, fixed 72×72 left portrait slot, 96-pixel dialogue overlay, one-speaker behavior, expression identifier, ambient-bubble layer, and separate small-thumbnail support even when the corresponding artwork and commentary content are placeholders.
- A minimal scripted dialogue test may use placeholder authored-speaker portraits to prove portrait replacement, expression lookup, protagonist-without-emotional-portrait behavior, and return to play. The complete sixteen-expression atlases are not Prototype 0.1 acceptance requirements.
- Character and portrait production resumes before final narrative authoring and presentation art, after the prototype provides a stable interface and playable context in which those characters can be judged.

### IF-PRO-009 — Prototype 0.0.1 Functional Shell

- **Status:** Completed — Windows Godot engine smoke test passed
- The first Godot project checkpoint is a reusable grayscale functional shell rather than a disposable visual mockup. It lives in the `infinite_fantasia` project directory and targets Godot 4 with GDScript.
- The town-square scene provides click-to-move, keyboard movement fallback, simple collision, three visible party hitboxes, a courtyard battle trigger, and a placeholder dialogue interaction.
- The battle scene establishes the locked 640×360 canvas, five battlefield bands, initiative ribbon, three character–companion HUD panels, two Midrange crate placeholders, oil-barrel and puddle placeholders, the Warrior–Mage–Archer party, the Sewer Rat–Mangy Mutt–Lesser Storm Elemental attachments, and the two-Sludge-plus-Drowsing-Toad encounter composition.
- Battle entry and the in-place Reroll debug command generate random valid Midrange positions for all six combatants. The tied Sludges share one initiative slot, and the opening initiative ribbon follows the locked Archer, Warrior, Sludge group, Mage, Toad order.
- The dialogue proof reserves the 64×64 portrait data area inside the fixed 72×72 left-side slot and 96-pixel bottom overlay, swaps placeholder authored-speaker expressions, and expands the text area when the protagonist speaks without a portrait.
- The shell deliberately contains no combat turns, Action-Gauge expenditure, selection, targeting, attacks, enemy AI, victory, or defeat. Those rules begin in the next implementation checkpoint rather than being faked for presentation.
- Static project structure and resource-reference checks passed in the build environment. The user then completed the Windows Godot smoke test, including town movement, dialogue, town-to-battle flow, deployment reroll, and return to town. Reroll was revised to mutate deployment in place after scene replacement proved unsafe during input handling.
- Finished artwork, character design, animation, and sound remain outside this checkpoint. Grayscale geometry and labeled hitboxes are the intended proof format.

### IF-PRO-010 — Prototype 0.0.2 Movement Foundation

- **Status:** Completed — implemented, statically validated, and accepted in the Windows Godot smoke test
- Prototype 0.0.2 converts party and enemy placeholders into mutable combatant records and adds the first actual battle interaction layer without adding attacks prematurely.
- The current allied block automatically selects its first combatant. Active allies may be selected through their battlefield footprints, HUD panels, or a keyboard cycle; inactive allies remain visibly unavailable until their initiative block.
- Hovered click movement originally displayed the direct route, destination footprint, crossed-zone markers, proposed Gauge cost, and linked Gauge-depletion segment. IF-UI-015 later removed the route connector and crossed-zone markers while preserving the destination, cost, Gauge, and underlying path-validation behavior.
- WASD and Arrow-key movement provide continuous direct control, normalized diagonal movement, live Gauge depletion, collision, battlefield clamping, and automatic cancellation of an active click route.
- Click and keyboard movement use one cost function containing distance cost and a zone-transition surcharge. The current numerical constants exist only to make the interaction testable and are not balance decisions.
- Crates, the oil barrel, combatant footprints, and battlefield bounds block movement. The puddle remains traversable. Prototype click routes must currently be clear straight paths; WASD can steer around obstacles.
- The opening Archer–Warrior shared block permits free switching without restoring spent Gauge. One confirmed End Block command advances through a timed placeholder Sludge block to Mage, then through the placeholder Toad block into the next initiative set.
- Enemy-block timing is an interface and state-machine proof only. It performs no enemy movement, targeting, AI, attacks, damage, statuses, victory, or defeat.
- The Windows Godot smoke test accepted selection, both movement methods, Gauge agreement, collision, switching, confirmation, block progression, Gauge refresh, reroll, and return to town.

### IF-PRO-011 — Prototype 0.0.3 Targeting and Palette Foundation

- **Status:** Completed — implemented, statically validated, and accepted in the Windows Godot smoke test; the user also completed and won the battle
- Prototype 0.0.3 adds the command-first targeting and weapon-defined Basic Attack contract from IF-CBT-014 on top of the accepted 0.0.2 movement chassis.
- Its HUD implements IF-UI-014: five equal reserved bar positions, three visible bars for each current base-class character, no bar labels or patterns, and the locked resource palette as the prototype's only chromatic color.
- Exact sword, bow, staff, Sludge, Toad, Health, object-durability, movement, and damage numbers remain isolated prototype tuning.
- The accepted checkpoint proves input, range, target eligibility, previews, Action-Gauge spending, Accuracy, partial cover, damage, compatible object targeting, object state changes, minimal enemy actions, defeat, block skipping, Victory, Defeat, Retry, and town return. Its repeated-affordable-Basic-Attack behavior was identified during acceptance and is superseded by IF-CBT-014's revised once-per-turn rule in Prototype 0.0.4.
- Companion commands, class abilities, PP, class-resource expenditure, Afflictions, environmental ignition chains, and finished tactical AI remain outside this checkpoint.

### IF-PRO-012 — Prototype 0.0.4 Attack Cadence and Preview Revision

- **Status:** Completed — working implementation statically validated and accepted in the Windows Godot test
- Prototype 0.0.4 preserves the accepted 0.0.3 battle and applies two focused revisions without adding artwork or another system layer.
- Every current party and enemy weapon defines one Basic Attack use per turn. A committed attack increments that combatant's use count before the Accuracy result, so both hits and misses consume it; the count resets only at that combatant's next initiative turn.
- Weapon data owns the default use limit and each combatant exposes a separate class-passive modifier, allowing explicit future exceptions without bypassing the common attack pipeline.
- After a party member commits the default Basic Attack, targeting closes and the disabled command reads **Attack Used**. Another active ally in the same shared initiative block retains its own independent use.
- Movement previews remove their source-to-destination connector and crossed-zone dots while retaining destination geometry, cost text, legality feedback, and the linked Action-Gauge ghost.
- Ranged attack previews draw a source-to-target delivery line; melee previews do not. The current Bow Shot demonstrates the player-facing rule, while the same data classification is available to Tongue Strike and future ranged actions.
- All preexisting Health, Action-Gauge, Accuracy, cover, collision, enemy-decision, object, Victory, Defeat, Retry, town-flow, palette, and grayscale-presentation behavior remains unchanged.
- The user confirmed that one ally's committed Basic Attack correctly changes to **Attack Used** while another ally in the shared initiative block retains its independent attack, accepting the revised cadence in an engine run.

### IF-PRO-013 — Prototype 0.0.5 Berserker and Placeholder-Art Checkpoint

- **Status:** Planned; recovered-axe timing locked, while exact Berserker values, pickup cost, and art implementation remain open
- Replace the active Warrior test character with the Berserker while preserving the reusable Warrior data and code.
- Implement the Berserker weapon and Rage package from IF-CLS-009 so the checkpoint proves its first empty-starting, actively generated class resource; two independently limited weapon attacks; zero-Gauge weapon action; physical ammunition; recoverable battlefield equipment; and post-battle restoration.
- Introduce basic static grayscale pixel placeholders for the three party characters, three companion attachments, two Sludges, Drowsing Toad, crates, oil barrel, puddle, HUD thumbnails, and initiative thumbnails.
- Use silhouette, size, shape, facing, and value contrast for identification. Do not establish canonical faces, costumes, authored-character designs, final animation, or finished environment art.
- The locked resource bars remain the only chromatic elements. All placeholder sprites, terrain, objects, effects, and interfaces remain grayscale unless a later mechanic requires an explicitly approved exception.

### IF-ENC-001 — Prototype 0.1 Battlefield Location

- **Status:** Locked
- Prototype 0.1's single complete encounter takes place in a **service courtyard behind the town square, directly outside the sewer entrance**.
- The courtyard is reached from the playable town-square area and provides the transition from exploration into the prototype battle.
- This is a permanent starting-city location rather than a disposable testing room. Its layout and data should remain reusable when later builds add the alley, sewer mini-dungeon, and surrounding town district.
- The location naturally supports courtyard walls, service clutter, drainage, liquids, containers, and the sealed sewer entrance, but no specific prop or interaction is implied until the encounter's object set is chosen.
- The battle does not require the player to enter or explore the sewer in Prototype 0.1. The entrance acts as environmental context and a visible promise of later progression.
- Exact courtyard dimensions, enemy group, interactable objects, battle trigger, narrative premise, and victory condition remain open. Its zone structure is defined by IF-ENC-002.

### IF-ENC-002 — Prototype Courtyard Zone Structure

- **Status:** Locked for Prototype 0.1
- The sewer-entrance courtyard uses the standard five left-to-right battlefield bands: **Enemy Backline**, **Enemy Midrange**, **shared Melee**, **Party Midrange**, and **Party Backline**.
- Prototype 0.1 adds no special zone, elevated overlay, merged zone, or battlefield-specific replacement zone to this encounter.
- Combatants retain continuous horizontal and vertical positions inside their current band. Range uses continuous radial geometry and is never granted merely because two actors share a band.
- Movement within a band and transitions between bands follow the established Action-Gauge and cost-preview rules.
- Props, surfaces, walls, and hazards may occupy parts of one or more bands without automatically becoming additional zones.
- Beginning with the baseline isolates whether movement, range, band transitions, targeting, companions, and environmental interactions function together before a later encounter introduces special-zone rules.
- Exact band widths, walkable boundaries, starting coordinates, collision geometry, and transition costs remain deferred to layout implementation and the numerical pass.

### IF-ENM-001 — Prototype Courtyard Enemy Group

- **Status:** Composition and broad roles locked; individual kits and numbers remain open
- Prototype 0.1's single battle contains exactly **three enemies**: **two Small Sludges** and **one Medium Drowsing Toad**.
- Sludges fill the recognizable introductory-JRPG-monster role associated with classic slime creatures while remaining an original *Infinite Fantasia* enemy identity with its own eventual artwork and mechanics.
- The two Sludges are close-range pressure enemies. Their Small size gives Guard Dog two eligible targets and demonstrates its independent multi-target Fear rolls.
- The two Sludges have equal Initiative statistics in Prototype 0.1 and therefore share one tied enemy activation group under IF-TURN-001. The party cannot act between the first and second Sludge.
- Their individual movement and actions resolve sequentially inside that shared group so the second Sludge evaluates the current battlefield after the first Sludge acts.
- The Drowsing Toad is a non-Small ranged or support enemy capable of inflicting Sleep. It gives Man's Best Friend a deliberate combat wake-up test while remaining ineligible for Guard Dog.
- Using one different enemy alongside two matching simple enemies provides enough behavioral contrast to test targeting and initiative without requiring three unrelated AI packages.
- Sludges do not automatically possess Wet, Oiled, Poison, Acid, splitting, merging, or any other unstated mechanic merely because they are amorphous.
- The Sludge's minimum action set is defined by IF-ENM-002 and the Drowsing Toad's core kit by IF-ENM-003. All three enemies use the universal random Enemy Midrange deployment in IF-CBT-012 unless a later explicit passive overrides it. Remaining movement priorities, Health, resources if any, defenses, vulnerabilities, damage, status chances, visual designs, and reward data remain open.

### IF-ENM-002 — Prototype Sludge

- **Status:** Minimum action set and damage classification locked; numerical values deferred
- Each prototype Sludge can move through the ordinary Action-Gauge rules and perform one close-range Basic Attack.
- The Sludge has no passive, special active ability, Primary Resource, or ability PP in Prototype 0.1.
- Its Basic Attack's complete mechanical effect is **Deal X damage.** It carries no Element tag and no Slashing, Piercing, Bludgeoning, or other damage-form tag.
- The attack therefore uses the untagged-damage interpretation in IF-TAG-016. It does not gain a Neutral or Untyped tag.
- The Sludge's simple combat role is to approach an eligible target and spend Action Gauge on its Basic Attack, providing a clean test of movement, range, targeting, Accuracy, damage, and defeat.
- Its exact damage, Action-Gauge costs, Initiative, Accuracy, movement priorities, target-selection rules, and all other numerical values remain deferred.

### IF-ENM-003 — Prototype Drowsing Toad

- **Status:** Core kit and hopping benefit locked; passive name, damage form, chance, duration, cadence, and numerical values remain open
- The Medium Drowsing Toad has one Basic Attack, one passive movement feature, and exactly one special ability in Prototype 0.1.
- Its Basic Attack is **Tongue Strike**: **Deal X Water damage.** Tongue Strike has slightly greater range than the Sludge's close-range Basic Attack.
- Water is Tongue Strike's locked Element tag. Whether Tongue Strike also carries a physical damage-form tag remains open rather than being inferred from its animation.
- Tongue Strike remains a Basic Attack and therefore uses the ordinary Action-Gauge economy. Its exact damage, range, and cost are deferred to the numerical pass.
- Its sole special ability is **Lulling Croak**: **Target one enemy within range. Has a [chance] to inflict Sleep.**
- Lulling Croak deals no damage and carries the **Sound** tag, inheriting the standard radial propagation and solid-barrier rules.
- Lulling Croak's exact chance term, Sleep duration, range, Action-Gauge or other cost if any, and use cadence remain open.
- The Toad also has one passive, currently unnamed, that makes hopping its movement method and allows it to reposition more easily than an ordinary grounded enemy.
- Hopping is passive movement behavior rather than a second special ability.
- A hop may pass over combatants and low obstacles between takeoff and landing. Those intervening footprints and low obstacles do not invalidate its movement path.
- The Toad must land at an otherwise valid, walkable, unoccupied destination. Hopping does not permit it to land inside another footprint or solid object.
- Solid walls and obstacles not classified as low remain impassable. The passive does not permit movement through them.
- Hopping still pays the ordinary Action-Gauge cost for its displacement and every crossed zone boundary. It does not inherently reduce movement or transition costs.
- The exact maximum distance of one hop, treatment of ground hazards crossed during flight, engagement and reaction timing, animation timing, and passive name remain open.

### IF-ENM-004 — Prototype 0.0.3 Minimum Enemy Decisions

- **Status:** Accepted prototype implementation; not the final enemy-AI design
- Each enemy chooses the nearest living party member as its provisional target, approaches through the shared Action-Gauge, zone-transition, collision, and valid-landing rules when necessary, and uses its Basic Attack when the target is within radial footprint range and the remaining Gauge can pay the attack cost.
- The two equal-stat Sludges remain one tied initiative group and resolve sequentially without a party interruption. The Drowsing Toad acts in its separate final block.
- The Drowsing Toad's implemented approach movement honors its locked hopping passive: its route may cross combatants and low crates, while the landing point must remain walkable and unoccupied and displacement and zone transitions retain their ordinary Action-Gauge costs. The oil barrel and other non-low solid objects continue to block the hop.
- Enemy Basic Attacks use the same 95% base Accuracy, target Dodge subtraction, ranged partial-cover test, damage application, and defeat checks as party Basic Attacks. Tongue Strike retains its Water Element classification even though elemental defenses are not yet active in this checkpoint.
- Prototype enemies may deliberately end with unspent Action Gauge after completing this small decision sequence. They do not yet optimize targets, cover, environmental objects, hazards, class abilities, companion interactions, focus fire, retreats, or future-turn planning.
- This behavior exists to make the battle honestly winnable or losable while keeping tactical-AI design separable from validation of the common combat pipeline.

### IF-ENC-003 — Prototype Courtyard Environmental Set

- **Status:** Object categories, revised fixed count, baseline behaviors, and functional courtyard placements locked; exact coordinates and dimensions remain open
- Prototype 0.1's courtyard contains exactly four designed environmental pieces: **one oil barrel**, **one shallow puddle**, and **two low crate stacks**.
- These pieces are always present in the prototype encounter. Randomized object inclusion and alternate courtyard configurations are deferred so testing remains reproducible.
- The oil barrel represents a targetable object with state changes and chained environmental reactions.
- The shallow puddle represents a persistent surface that can interact with Conditions, Elements, movement, and other environmental rules.
- The two low crate stacks represent cover and collision geometry from both sides of the same battlefield and are explicitly low obstacles that the Drowsing Toad may cross through its hopping passive.
- Each piece proves a different reusable content category rather than existing solely as decoration.
- No additional optional prop, hazard, special zone, or randomized interactable is required for Prototype 0.1.
- Exact oil-barrel and puddle placement, object dimensions, remaining numerical values, tags not already defined, durations, and advanced interactions remain open and will be defined one environmental piece at a time.

### IF-ENV-003 — Prototype Oil Barrel

- **Status:** Rupture, ignition, explosion, persistent-surface routes, and courtyard placement locked; target allegiance details, ongoing triggers, and numerical values remain open
- The oil barrel begins the prototype encounter intact and may be selected as a combat target by any action capable of targeting and damaging compatible objects.
- The first valid damaging hit ruptures the barrel; Prototype 0.1 does not require a separate multi-hit Health pool for it.
- Rupturing the barrel destroys the intact object and creates an **Oiled surface** around its former position. The surface inherits the established environmental Oiled and Slippery rules.
- If the rupturing hit does not carry **Ignite**, the Oiled surface remains available for a later Ignite-tagged action. This is the deliberate setup route available to an Archer or any other valid object attacker.
- If the rupturing hit carries **Ignite**, resolution remains ordered: the barrel ruptures, the Oiled surface is created, and Ignite then applies to that surface immediately. This is the direct reaction route available to an Ignite-capable Mage action.
- Fire damage without the Ignite interaction does not automatically ignite the barrel or surface merely because it carries the Fire Element tag.
- Both routes use the same object and surface state system rather than separate scripted outcomes.
- Igniting the barrel's spill produces the immediate explosion and persistent Burning Oil transformation defined in IF-ENV-004 regardless of whether Ignite was part of the rupturing hit or applied later.
- The intact barrel begins near the **Enemy Midrange edge of the shared Melee zone**, offset toward one flank rather than centered on the battlefield.
- Because combatants deploy randomly within their respective Midrange bands, the fixed barrel placement does not guarantee that any particular Sludge, the Toad, or any other combatant begins inside its eventual explosion area.
- The barrel's flank placement creates a recurring opportunity to threaten enemies that deploy or move near it without making one predetermined enemy an automatic opening victim in every battle.
- The barrel remains readily visible and targetable as an environmental object; its location is not intended to be hidden behind the enemy crate's partial cover.
- The spill radius, exact targeting footprint, Action-Gauge or resource costs inherited from the causing action, environmental duration, visual feedback, and numerical values remain open.

### IF-ENV-004 — Prototype Burning Oil

- **Status:** Explosion, chain reactions, persistent surface, Slippery, and Burn exposure triggers locked; Burn duration, extinguishing, and numerical values remain open
- When the Oiled surface created by the prototype oil barrel is first exposed to **Ignite**, it produces one immediate area-of-effect explosion and then becomes a persistent **Burning Oil** surface.
- The explosion damages every combatant inside its area regardless of allegiance. Party members and enemies use the same spatial test and damage resolution; the actor who caused the ignition grants no immunity to themselves or their allies.
- Companions are not separate damage targets under the established attached-companion rules. If a master is inside the explosion, damage applies to the master rather than to a parallel companion Health layer.
- At minimum the explosion damage carries the **Fire** Element tag; whether it also has a physical damage-form tag remains open.
- The explosion also carries **Ignite** and damages every compatible environmental object inside its area. Decorative scenery and objects not classified as damage-compatible are unaffected.
- Each damaged object resolves its own state rules. A compatible oil barrel may therefore rupture, create its Oiled surface, receive Ignite from the originating explosion, and produce the next explosion in the chain.
- Each one-time state transition may resolve only once during a chain. An already ruptured barrel or already transformed Burning Oil surface cannot be used to create an infinite reaction loop.
- Explosion range uses continuous area geometry and combat footprints rather than affecting an entire battlefield band automatically.
- Before an Ignite action is committed, its consequence preview must identify every combatant expected to be caught by the resulting explosion, including allies, and every deterministic compatible-object reaction that will follow.
- The explosion occurs only during the Oiled-to-Burning-Oil transformation. Applying Ignite to the already-burning surface does not repeat the initial explosion.
- The Burning Oil surface remains on the battlefield after the explosion and continues to present an environmental threat until its source-defined duration or removal condition ends it.
- Burning Oil carries **Ignite** and does not deal a separate contact or periodic surface-damage tick.
- Burning Oil retains the **Slippery** environmental property for as long as the surface exists. The underlying Oiled Condition is removed by the transformation, but the resulting surface carries Slippery directly because it remains burning liquid oil.
- Slippery does not gain additional strength from the transformation. Burning Oil uses the same rule that causes Weight and Shove Resistance to be ignored when resolving a Shove against a combatant affected by the surface.
- Instead, Burning Oil attempts to apply **Burn** immediately to every valid combatant whose footprint overlaps the surface when it forms, whenever a combatant's footprint enters or crosses into the surface, and at the start of each combatant turn that begins with its footprint overlapping the surface.
- These exposure checks use the ordinary Burn immunity and application rules. A combatant immune to Burn or Ignite does not receive Burn merely because it touches the surface.
- Leaving the surface does not itself remove an already applied Burn; that Affliction follows the duration and removal rules assigned by the Burning Oil source.
- The explosion area and Burning Oil footprint are distinct. A combatant caught by the wider explosion but not overlapping the resulting surface takes the explosion damage without automatically receiving Burn from surface exposure.
- The explosion does not inherently Shove, pull, launch, or otherwise move targets because only area damage has been approved.
- Exact explosion damage and radius, whether the blast itself applies Burn separately from surface exposure, the Burn duration assigned by the surface, surface duration, extinguishing methods, reactions whose outcomes are not deterministic at preview time, and presentation remain open.

### IF-ENV-005 — Prototype Shallow Puddle

- **Status:** Baseline contact behavior and courtyard placement locked; dimensions, advanced reactions, and presentation remain open
- The shallow puddle begins the prototype encounter as a persistent environmental surface and deals no damage by itself.
- A combatant has **Wet** exactly while any part of their combat footprint overlaps the puddle.
- Entering or moving across the puddle applies Wet immediately when overlap begins. Leaving it removes that puddle's Wet immediately when overlap ends; merely crossing the puddle does not leave a lingering Wet duration.
- Remaining stationary inside the puddle keeps Wet active continuously. The rule is based on current spatial overlap rather than entry or start-of-turn pulses.
- Wet retains all established universal effects while active, including immunity to Burn and Ignite, removal of existing Burn and Ignite, Fire and Lightning weakness-rung changes, replacement of Oiled, and eligibility for Lightning arcs.
- The puddle does not inherently deal damage, alter Action-Gauge movement cost, or gain Slippery merely because it applies Wet.
- The puddle begins on the flank opposite the oil barrel near the **Party Midrange edge of the shared Melee zone**.
- It is positioned as an optional tactical destination rather than directly beneath any starting combatant or across a route every combatant must use to approach the enemy.
- Either side can reach and use the puddle through ordinary movement. Its party-side bias makes it a readily available way for the player to remove Burn or Ignite by deliberately standing in Wet.
- The starting puddle and intact oil barrel are separated far enough that their initial footprints do not overlap. Later surface expansion, movement, or environmental manipulation may create interactions under the normal Wet-and-Oiled supersession rules.
- Exact footprint, interactions that could remove or transform the puddle, Lightning arc details, interactions between overlapping environmental surfaces, and visual feedback remain open.

### IF-ENV-006 — Prototype Low Crate Stack

- **Status:** Partial-cover role, affected action categories, center-line geometry, nonstacking rule, additive counterplay, prototype accuracy magnitude, and simple destruction result locked; area propagation and numerical durability remain open
- The low crate stack is a solid low obstacle and a source of **partial cover**.
- When it provides partial cover against an eligible ranged attack, that attack remains legal but receives a reduction to its final accuracy.
- Partial cover changes hit probability rather than reducing the damage of an attack that successfully hits.
- Partial cover applies to every **directly targeted ranged action that makes an accuracy roll**, regardless of whether its delivery is physical or magical. An arrow, thrown weapon, magical bolt, or targeted beam therefore uses the same cover rule when it otherwise qualifies.
- A guaranteed-hit action receives no partial-cover accuracy reduction because it makes no accuracy roll. Partial cover does not introduce a new failure roll into an action defined to hit automatically.
- Selecting a ground location for an area ability ignores partial cover. Whether solid geometry changes the resulting area's propagation after detonation is a separate rule and remains open; the low crate does not make the placement point invalid merely by standing between the caster and that point.
- **Sound** actions continue to use the established Sound propagation rules instead of partial-cover accuracy rules.
- Melee and close-range attacks are unaffected by partial cover.
- Partial cover uses a straight center-line test from the attacker's focal point to the target's focal point. If that line segment intersects the low crate's solid combat footprint, the crate provides partial cover for that attack.
- The test uses logical combat geometry rather than visible sprite pixels. Decorative portions of the crate art and character art do not independently create or negate cover.
- Cover is recalculated from the actors' current continuous positions whenever an action is previewed or resolved. Moving the attacker or target sideways can therefore move the center line clear of the crate and remove its accuracy reduction without requiring a zone change.
- Partial cover does not stack with itself. If the center line intersects multiple sources of partial cover, the attack receives the partial-cover accuracy reduction only once.
- Each qualifying object is still checked independently. Removing or destroying one cover source clears the penalty only if no other qualifying partial-cover source continues to intersect the line.
- Stronger future cover categories may use different rules, but multiple partial-cover sources do not combine to create stronger or full cover automatically.
- In Prototype 0.1, partial cover applies a **−20 percentage-point accuracy penalty**. An otherwise unmodified attack using the universal 95% base accuracy therefore has 75% accuracy before Dodge and any other modifiers are applied.
- The cover penalty participates in the universal additive accuracy calculation. Accuracy bonuses from equipment, passives, Conditions, abilities, or other effects may partially or completely offset it; the game does not require a separate Cover Penetration statistic.
- The aiming preview must clearly identify that cover applies and display the resulting hit chance before the player commits the attack.
- Ordinary movement cannot pass through or end inside the crate's solid footprint. The Drowsing Toad's established hopping passive may cross it because it is classified as a low obstacle, but the Toad must still land in a valid unoccupied location.
- The crate is a valid combat target for actions capable of targeting and damaging compatible objects. Party members and enemies use the same targetability and damage rules.
- The crate has modest durability rather than being destroyed automatically by the first damaging hit. Its exact Health and any damage affinities remain deferred until prototype combat values are assigned.
- When its durability reaches zero, the crate is destroyed once and immediately stops providing partial cover or collision. Navigation, movement previews, and attack previews recalculate against the opened route and cleared shot line.
- Destruction leaves harmless cosmetic debris only. It causes no explosion, damage, forced movement, Condition, Affliction, persistent surface, or replacement obstacle.
- Prototype 0.1 contains two independent instances of the low crate stack: one in **Enemy Midrange** and one in **Party Midrange**.
- The two crates use approximately mirrored functional placement across the battlefield center. They should create comparable opportunities to use cover from either side without requiring exact pixel-for-pixel symmetry.
- Random Enemy Midrange deployment may place any enemy behind, beside, or clear of the enemy crate relative to a particular attacker. The crate therefore teaches the player to inspect the actual shot line instead of memorizing a protected enemy slot.
- Random Party Midrange deployment creates the same possibilities around the party crate, allowing party members to begin protected or exposed and then reposition deliberately.
- Each crate tracks its own durability and destruction state. Destroying one has no effect on the other.
- Area propagation around solid geometry, exact numerical durability, damage affinities, presentation, and any future stronger cover categories remain open.

## 8. Production Path

### IF-TEC-001 — Engine and Scripting Language

- **Status:** Locked
- Infinite Fantasia will be developed in **Godot 4** using **GDScript**.
- Core combat rules, classes, abilities, tags, Afflictions, Conditions, enemies, and encounter content should be data-driven so new content does not require rewriting scene logic.
- The prototype will not depend on C# or engine modifications.
- Godot's free, open-source licensing supports development and commercial distribution without engine royalties or subscription fees.
- Initial target platform, export priority, native resolution, renderer, and detailed project configuration remain open.

### IF-TEC-002 — Initial Platform Priority

- **Status:** Locked
- Windows desktop is the primary development, testing, and Prototype 0.1 acceptance target.
- Browser export is the secondary target for convenient sharing and remote playtesting.
- The project architecture should preserve a viable Godot web export path unless a later explicit decision accepts an incompatible dependency.
- Windows behavior and reliability take priority if a platform-specific compromise is unavoidable during the first prototype.
- A browser build is not required for every internal revision, but the complete Prototype 0.1 loop should receive a web-export checkpoint before the milestone is considered portable.
- Native mobile platforms, consoles, and other desktop operating systems are not Prototype 0.1 targets.

### IF-TEC-003 — Native Canvas and Pixel Scaling

- **Status:** Locked
- Prototype 0.1 uses a **640×360 internal presentation canvas** with a **16:9** aspect ratio.
- All battlefield composition, interface placement, camera framing, and pixel-art sizing are designed against those 640×360 logical coordinates.
- The game uses nearest-neighbor filtering and pixel-perfect integer scaling whenever the display permits it.
- A 1280×720 window displays the canvas at 2× scale; a 1920×1080 window displays it at 3× scale. The internal layout does not become smaller on those displays; each source pixel is enlarged into a clean square block.
- When the available window has a different aspect ratio, preserve the game image and use letterboxing or pillarboxing instead of stretching it.
- Behavior for windows smaller than the native canvas or for unavoidable noninteger scale factors remains an implementation and settings decision.

### Phase A — Foundation and Decisions

- Confirm party structure and battle-turn model.
- Confirm exploration structure and target device/input.
- Define moment-to-moment battle commands.
- Define the standard contents of one base-class package.
- Select the base classes required for the earliest internal build.
- Confirm the initial target platform and input priorities; Godot 4 and GDScript are already fixed.

### Phase B — Combat Sandbox

- Implement one generic character and one enemy.
- Establish movement, attacks, hit response, damage, cooldown/resource rules, and death.
- Add debug and automated combat-state tests where practical.

### Phase C — Base-Class Proof

- Implement the selected base classes using the reusable class-package model.
- Compare them against shared encounters.
- Record which class differences players can perceive without reading tooltips.
- Expand toward all eight base classes only after the initial set works.

### Phase D — Vertical Slice

- Add a short environment, enemy variety, a boss, basic progression, sound, interface, save/settings, and a coherent art-direction target.
- Package a build that another person can play without developer guidance.

### Phase E — Multiplayer Proof

- Only after the base-class combat loop is validated, test the smallest multiplayer form that serves the intended game: likely a limited co-op session before persistent-world infrastructure.

### Phase F — Class-Combination Proof

- Add the second and third class slots only after the base classes function as clean, reusable components.
- Test a small number of AAA, AAB, and ABC outcomes before expanding the combination matrix.

### Phase G — Full Production Planning

- Re-estimate content, team size, budget, network model, platform targets, release model, and the extent of the class matrix using evidence from the slice.

## 9. Major Open Questions

Questions are intentionally ordered. Resolve them one at a time because each answer constrains the next.

1. **Initial platform:** Windows-first with browser export secondary, browser-first, or another priority.
2. **Battle-screen template:** locked as the Prototype 0.1 working layout; revisit its proportions and detailed behavior only in response to implementation or playtest evidence.
3. **Prototype party:** locked as Warrior, Mage, and Archer.
4. **Companion proof:** locked at the recruitable Sewer Rat, recruitable Mangy Mutt, and amulet-granted Lesser Storm Elemental; all three core combat kits are sufficient for current prototype planning, exact numerical ranges are deferred to the numerical pass, and nonessential overworld-warning details are deferred beyond Prototype 0.1.
5. **First encounter:** the battlefield location, standard five-band structure with no special zone, enemy group and kits, fixed environmental set, and oil-barrel chain through its explosion and persistent Burning Oil surface are locked; detailed Burning Oil behavior, puddle and crate behaviors, battle trigger, and victory condition remain open.
6. **Minimum class packages:** the basic attack, abilities, resources, PP, passives, and required Interaction Tags for each included class.
7. **Prototype numbers:** provisional Health, Action Gauge, resource, damage, cost, Initiative, Accuracy, and enemy values needed to make the battle playable.
8. **Enemy behavior:** the smallest readable AI capable of using zones, targets, attacks, and environmental opportunities.
9. **Town-square contents:** walkable boundaries, collision, visible party representation, interactions, battle entrance, and return state.
10. **Interface and acceptance:** exact information layout, input feedback, debug tools, test cases, and the checklist that declares Prototype 0.1 complete.

## 10. Decision Record

| Date | ID | Status | Summary |
| --- | --- | --- | --- |
| 2026-04-18 | IF-CLS-001–007 | Locked | Established eight base classes, three selections, order-independent composition, specialization rules, pure lines, and three-panel class UI. |
| 2026-08-23 | IF-VIS-002 | Proposed | Use a local vertical slice as the first production target while preserving the long-term online ambition. |
| 2026-08-23 | IF-SCP-001 | Locked constraint | Treat the 120-build final matrix as a combinatorial production risk requiring reusable systems. |
| 2026-08-23 | IF-SCP-002–003 | Proposed | Use modular base packages and begin prototype work with a representative subset. |
| 2026-08-23 | IF-PRO-001–003 | Proposed | Define a class-combat vertical slice and explicit exclusions for its first version. |
| 2026-08-23 | IF-PRO-000 | Locked | Restrict the first playable version to base classes; defer all Tier-2 and Tier-3 combinations. |
| 2026-08-23 | IF-FMT-001–002 | Proposed | Use early-*Final Fantasy*-style 2D exploration and turn-based combat with original-*Brave Frontier*-inspired battle presentation. |
| 2026-08-23 | IF-CBT-001–005 | Proposed | Abstract tabletop-style positioning into battlefield zones with interactable props, environmental reactions, forced movement, and curated encounter variation. |
| 2026-08-23 | IF-CBT-006–008 | Locked concept | Replace hard AP with individual continuous Action Gauges, free-form click-to-move, variable action costs, and visible projected depletion over hidden class modifiers. |
| 2026-08-23 | IF-TURN-001–002 | Locked concept | Use initiative blocks: consecutive allies share an activation window and may freely interweave partial actions until an opposing initiative position interrupts. |
| 2026-08-23 | IF-TURN-003 | Locked concept | Establish initiative once per battle; change it only through explicit, previewed effects with clearly defined timing. |
| 2026-08-23 | IF-UI-001 | Locked concept | Keep a simple initiative ribbon always visible, group consecutive allies into clear blocks, and make current and next interruptions readable at a glance. |
| 2026-08-24 | IF-UI-002 | Locked objective | Create one minimal, exact, exception-free mechanical description language for every game object and separate binding rules from flavor. |
| 2026-08-24 | IF-UI-003–006 | Locked direction | Use canonical inspectable tags, minimal skill rules blocks, direct equipment stat strips, and visible resolved outputs over hidden formulas; leave exact skill-cost and percentage presentation for reconciliation. |
| 2026-08-24 | IF-TAG-001 | Locked direction | Define Elements as stable damage-and-defense tags that do not automatically grant statuses or world interactions. |
| 2026-08-24 | IF-TAG-002 | Partially locked | Accept Light, Shadow, and Arcane as damage Elements; retain Fire, Ice, Lightning, Water, Terra, and Wind as the proposed natural roster. |
| 2026-08-24 | IF-TAG-003–004 | Locked direction | Give each Natural Elemental defensive profile exactly two incoming vulnerabilities and two resistances while allowing Light, Shadow, and Arcane to use a separate, simpler Esoteric rule set. |
| 2026-08-24 | IF-TAG-005–006 | Locked constraint / proposed rule | Permit justified Natural-roster expansion, accept Nature as the first addition, and consider mutual Light–Shadow vulnerability plus neutral Arcane damage. |
| 2026-08-24 | IF-TAG-007 | Locked concept | Distinguish inorganic Terra from organic Nature while preventing thematic domain membership from automatically assigning elemental combat affinity. |
| 2026-08-24 | IF-TAG-008 | Locked principle | Make actions declare their properties and receivers determine reactions; keep Beast as a separate enemy-type tag with no inherent effect on the Element chart. |
| 2026-08-24 | IF-TAG-009–010 | Locked constraint / partial chart | Balance every Natural attack Element across exactly two vulnerability and two resistance profiles; lock Fire's Water vulnerability and Ice's Fire vulnerability while holding other obvious candidates for confirmation. |
| 2026-08-24 | IF-TAG-011–012 | Provisional audit | Rename Earth to Terra; preserve the seven-Element vulnerability draft, identify its two valid completions, and quantify the constraints created by adding one or two Natural Elements. |
| 2026-08-24 | IF-TAG-011–012 | Revised provisional chart | Move Wind's vulnerability assignment from Water to Terra and Nature's from Terra to Water; make Wind vulnerable to Ice and Lightning; complete the balanced candidate with Ice vulnerable to Wind and Lightning vulnerable to Nature. |
| 2026-08-24 | IF-TAG-011 | Provisionally accepted | Accept the complete seven-Element vulnerability chart for current work and defer whether resistance lists mirror or differ from vulnerabilities. |
| 2026-08-24 | IF-STS-001–002 | Locked structure / proposed vocabulary | Separate canonical status definitions from source application chances; establish internally exact player-facing chance terms and audit the first ten-grade percentage ladder. |
| 2026-08-24 | IF-STS-001–002 | UI correction / revised proposal | Keep all description text noninteractive, place inspectable status tags below it, hide percentages completely from players, and narrow the naming recommendation to Minuscule and Modest substitutions. |
| 2026-08-24 | IF-STS-002 | Locked | Fix the hidden internal chance ladder to Abysmal, Minuscule, Tiny, Small, Modest, Medium, High, Great, Extreme, and Guaranteed. |
| 2026-08-24 | IF-AFL-001 | Proposed taxonomy | Define Afflictions as persistent harmful combatant states and consider separating neutral reactive states such as Wet and Oiled into a Condition category. |
| 2026-08-24 | IF-AFL-001–003 | Locked taxonomy / semantic definition | Separate harmful Afflictions from neutral Conditions and immediate effects; prohibit premature Affliction numbers; define Burn as turn-based damage that temporarily grants Ignite. |
| 2026-08-24 | IF-AFL-004 | Locked semantic definition | Define Poison as recurring damage that increases every turn while Poison remains active; defer all magnitudes, limits, durations, and detailed timing. |
| 2026-08-24 | IF-AFL-005 | Locked semantic definition | Define Bleed as damage triggered by Action-Gauge expenditure, making it the exertion-based damaging Affliction while deferring numerical and detailed trigger rules. |
| 2026-08-24 | IF-AFL-006 | Locked semantic definition | Define Disease as a complete healing prohibition that persists after battle; prevent recovery automation from wasting healing while Disease remains active. |
| 2026-08-24 | IF-AFL-007 | Locked semantic definition | Replace Freeze with Chilled; prevent Action-Gauge spending while active and remove it through Fire damage or proximity to Ignite. |
| 2026-08-24 | IF-AFL-008 | Locked definition | Define Stun as total action denial for exactly one turn while allowing passive and triggered effects to continue. |
| 2026-08-24 | IF-AFL-009 | Locked semantic definition | Define Sleep as total action denial removed by damage, movement, or an explicitly stated waking effect; defer its ordinary duration and detailed timing. |
| 2026-08-24 | IF-AFL-010 | Locked semantic definition | Prevent Action-Gauge spending on movement while Rooted without restricting other Gauge actions; remove Rooted through forced movement or Ignite. |
| 2026-08-24 | IF-AFL-011 | Locked definition | Prevent all attacks and voluntary movement toward any enemy for exactly one turn while allowing defensive, supportive, retreating, and lateral actions. |
| 2026-08-24 | IF-AFL-012 | Locked definition | Reduce Accuracy by a High amount while Blind; define High as an internal additive reduction of 50 percentage points. |
| 2026-08-24 | IF-AFL-002, 008, 011 | Locked duration rule / superseding revision | Make every Affliction's duration source-specific rather than part of its tag; remove the former universal one-turn durations from Stun and Fear while preserving their mechanical identities. |
| 2026-08-24 | IF-AFL-013 | Locked semantic definition | Define Silence as a prohibition on initiating actions carrying the Spell tag without restricting movement, basic attacks, items, companion commands, or non-Spell abilities. |
| 2026-08-24 | IF-TURN-003; IF-AFL-014 | Locked semantic and timing definition | Define Slow as increased Action Gauge costs plus reduced Initiative; apply its Initiative reduction to every newly formed initiative set while Slow remains active without rearranging the current set. |
| 2026-08-24 | IF-AFL-015 | Locked semantic definition | Define Curse as a small drain to the afflicted combatant's Primary Resource at the start of each of its turns; exclude Health, Action Gauge, and ability PP while deferring fusion-resource handling. |
| 2026-08-24 | IF-AFL-001; IF-TAG-013 | Locked omission and category boundary | Omit Shock from the Affliction roster; allow electrical abilities to use Slow or Stun where appropriate and reserve an unnamed non-Affliction electrical interaction tag for later design. |
| 2026-08-24 | IF-STS-003 | Locked universal rule | Prevent immune effects from being applied and immediately remove any named effect that is already active when its receiver gains immunity. |
| 2026-08-24 | IF-CND-001; IF-NUM-003 | Locked semantic definition and numerical scale | Define Wet as Burn/Ignite immunity, reduced Fire weakness, increased Lightning weakness, and proximity-based Lightning arcing; establish the discrete 0.0×–2.0× Damage Multiplier Scale. |
| 2026-08-24 | IF-CND-002 | Locked semantic definition | Define Oiled as increased Fire weakness; prevent Oiled combatants from resisting Shoves; grant Slippery to Oiled environments; and let Ignite apply Burn when valid before removing Oiled. |
| 2026-08-24 | IF-CND-002; IF-ENV-001 | Locked Shove interaction | Define Slippery as the environmental equivalent of Oiled Shove vulnerability: ignore Weight and Shove Resistance when determining the affected combatant's Shove speed and distance. |
| 2026-08-24 | IF-CND-003 | Locked mutual supersession | Make Wet and Oiled mutually exclusive; whichever Condition is applied second removes and permanently replaces the first on that receiver. |
| 2026-08-24 | IF-NUM-003 | Locked stacking method | Make every signed weakness modifier worth one rung, stack modifiers by rung count, and cancel opposing positive and negative changes before resolving the final multiplier. |
| 2026-08-24 | IF-NUM-003 | Preserved future option | Treat 0.0×–2.0× as the standard current scale while allowing a later mirrored expansion in which extreme resistance can become absorption and extreme weakness can exceed 2.0×, subject to strict balance safeguards. |
| 2026-08-24 | IF-NUM-003 | Locked current endpoint behavior | Clamp net multiplier movement at 0.0× and 2.0× under the current rules, producing neither healing below the floor nor damage above the ceiling until a future expansion is explicitly approved. |
| 2026-08-24 | IF-NUM-001–002 | Locked mathematical foundation | Set default Accuracy to 95%, subtract hidden Dodge additively, allow negative Dodge and over-100 Accuracy, and make all damage and Accuracy percentage modifiers additive. |
| 2026-08-24 | IF-NUM-001 | Locked resolution rule | Keep Raw Hit Chance uncapped through calculation; resolve values at or above 100% as guaranteed hits and values at or below 0% as guaranteed misses, with no natural-hit or natural-miss exceptions. |
| 2026-08-23 | IF-PTY-001 | Locked concept | Use three active character slots and three active pet or companion slots. |
| 2026-08-23 | IF-PTY-002 | Locked concept | Pair each companion slot directly with one character slot, organizing the active party as three character–companion pairs. |
| 2026-08-23 | IF-PTY-003–004 | Locked concept | Use one player-created protagonist plus two authored tutorial companions while allowing the player to choose all three starting base classes. |
| 2026-08-23 | IF-NAR-001 | Proposed | Integrate tutorial companion class selection into the fiction as a decision in which the companions retain agency and may ask the protagonist for advice. |
| 2026-08-24 | IF-CHR-001–004 | Locked direction | Let the player author the protagonist's identity; keep the two renameable tutorial companions' histories and personalities fixed; use identity-driven narrative passives that remain separate from class combat performance. |
| 2026-08-24 | IF-EXP-005–007 | Locked direction | Give every class per-character Expertise that must be earned; let active authored companions contribute developed class knowledge without replacing protagonist agency; prevent trivial grinding. |
| 2026-08-24 | IF-EXP-008 | Locked concept | Advance Expertise through class-specific accomplishments and training, subject higher ranks to character-level gates, and provide multiple non-grind progression sources. |
| 2026-08-24 | IF-EXP-009–012 | Locked concept | Use automatic level-curriculum unlocks plus Fallout-style background challenge achievements; award non-branching Expertise perks automatically and restrict progress to meaningful qualifying accomplishments. |
| 2026-08-24 | IF-EXP-013–014 | Locked concept | Keep Expertise challenges entirely unmarked until completion, then record revealed rewards in an Expertise tab divided into Class Expertise and General Expertise. |
| 2026-08-24 | IF-EXP-015 | Locked concept | Store General Expertise per character and credit the individual who meaningfully performs the qualifying action. |
| 2026-08-24 | IF-EXP-016 | Proposed | Use one hidden challenge system for Class and General Expertise, distinguishing class identity from general lived experience. |
| 2026-08-24 | IF-EXP-017 | Locked concept | Resolve deliberate interactions through the selected actor while checking all present characters for genuinely passive observations. |
| 2026-08-23 | IF-CMP-001–004 | Locked direction | Recruit persistent growing companions with narrow battle and exploration tricks; integrate class pets and summons without turning companions into full duplicate characters. |
| 2026-08-23 | IF-CMP-005–008 | Locked concept | Treat companions as equipment-like attachments that remain beside their master, act only during the master's block, inherit the master's position, and express commands, passives, triggers, and exploration tricks. |
| 2026-08-23 | IF-CMP-009–010 | Locked direction | Price active companion commands with master Action Gauge; use no companion PP; balance commands through AP cost and per-turn or per-battle limits, with the rat as the baseline example. |
| 2026-08-23 | IF-CMP-011–014 | Locked concept | Give companions no separate Health or targeting; fix ordinary kits at one passive plus one active and Legendary kits at one passive plus two actives; add cosmetic equipment slots and visible overworld following. |
| 2026-08-23 | IF-CMP-015 | Locked concept | Let existing companion skills have stated or systemic overworld applications without adding a separate exploration-ability slot or requiring utility on every skill. |
| 2026-08-23 | IF-CMP-016 | Locked concept | Choose three traveling companions at expedition boundaries, then freely reassign only those three among active masters while out of combat. |
| 2026-08-23 | IF-RES-001–005 | Locked direction | Give every base class Health, Action Gauge, and a distinct class resource; class abilities normally spend their resource rather than AP, and future fusions inherit multiple resource bars. |
| 2026-08-23 | IF-RES-005–006 | Locked concept | Every spell and class ability spends both its shared class resource and its own PP; the two limits govern total output and individual ability repetition respectively. |
| 2026-08-23 | IF-REC-001–002 | Locked concept | Automatically reset Action Gauge, PP, and class resources to their class-specific defaults after battle; automatically consume provisions to restore Health without a manual rest sequence. |
| 2026-08-23 | IF-REC-003 | Locked concept | Let players configure a persistent automatic recovery policy that prioritizes provisions, Expedition PP, or a balanced reserve without post-battle prompts. |
| 2026-08-23 | IF-REC-004 | Locked concept | Apply the recovery policy to ordinary status remedies and cleansing abilities while preserving deliberately persistent afflictions. |
| 2026-08-23 | IF-BAL-001 | Locked principle | Balance encounters around a properly prepared party beginning each fight fully provisioned and at its intended default combat state. |
| 2026-08-23 | IF-EXP-001–004 | Locked direction | Give every base class exploration utility; add limited Expedition PP for field abilities that reset only at a meaningful return to town or long-rest expedition boundary. |
| 2026-08-23 | IF-PIL-007 | Locked principle | Prefer sensible defaults plus configuration when it improves play at reasonable cost without compromising balance, identity, reliability, or fairness. |
| 2026-08-24 | IF-PRO-004 | Proposed discussion target | Aim the first coherent demo at three base classes through Level 5, a compact town core, an alley, a chapel, a sewer mini-dungeon, and the threshold of the first larger dungeon. |
| 2026-08-25 | IF-PRO-005; IF-TEC-001 | Locked milestone and technical foundation | Set Prototype 0.1 at one town square plus one complete battle, and choose Godot 4 with GDScript as the free, data-driven development chassis. |
| 2026-08-25 | IF-TEC-002 | Locked platform priority | Develop and validate Prototype 0.1 for Windows first while preserving browser export as a secondary sharing and playtesting target. |
| 2026-08-25 | IF-TEC-003; IF-UI-007 | Locked canvas; proposed interface | Set the internal canvas to 640×360 with integer pixel scaling and letterboxing, then established the first proportional battle-screen wireframe for validation. |
| 2026-08-25 | IF-UI-007 | Locked prototype template | Accepted the five-band battlefield, top initiative ribbon, transient command tray, and three paired character–companion HUD panels as the Prototype 0.1 implementation target while preserving later playtest revision. |
| 2026-08-25 | IF-PRO-006–007 | Locked class trio; proposed companion scope | Selected Warrior, Mage, and Archer for the first battle and committed the prototype to testing assignment and commanded use of two or three permanent starting-city companions, with three recommended. |
| 2026-08-25 | IF-PRO-007 | Locked prototype count | Set Prototype 0.1 at exactly three permanent starting-city companions while allowing players to leave slots empty and deferring recruitment and progression content. |
| 2026-08-25 | IF-CMP-017 | Locked companion identity | Made the Sewer Rat Prototype Companion 1, assigned it the close-range proof role, and reserved its later recruitment for the starting-city sewer. |
| 2026-08-25 | IF-CMP-017–018 | Rejected passive; locked companion identity | Kept the Sewer Rat's kit open by rejecting Opportunistic Bite, then made the Mangy Mutt Companion 2 and the eventual first companion acquired through a single act of kindness. |
| 2026-08-25 | IF-CMP-019–020; IF-CLS-008 | Locked source architecture and prototype content | Made Companion 3 a ranged Lesser Storm Elemental granted by the Mage's amulet, defined Wind Shear as Wind-only damage, and set Fireball, Snowball, and Arcane Missile as the prototype Mage's spells. |
| 2026-08-25 | IF-EQP-001; IF-UI-008; IF-CMP-019–020 | Locked eligibility and replacement flow | Made the amulet require Mana rather than the Mage class name; added a confirmation before it replaces an assigned companion; returns that companion to the expedition roster and leaves the slot empty when the amulet is later removed. |
| 2026-08-25 | IF-CMP-020 | Locked companion passive | Gave the Lesser Storm Elemental Tailwind, reducing the master's first zone-transition Action-Gauge cost each turn and exposing the reduction through the normal preview. |
| 2026-08-25 | IF-CMP-009–010; IF-CMP-020–021 | Superseded cost model; locked new baseline | Replaced Action-Gauge-priced companion commands with free once-per-turn actives as the default; fixed Wind Shear at 3 Wind damage once per turn; and kept explicit costs or stricter limits as companion-specific exceptions. |
| 2026-08-25 | IF-CMP-017; IF-CMP-021–022 | Locked Rat kit and exploration model | Gave the Sewer Rat Infiltrator for direct overworld control, small-space traversal, and object chewing; gave it free once-per-turn Gross Gnaw with an Abysmal Disease chance; and allowed companion passives to be primarily exploration-facing. |
| 2026-08-25 | IF-CMP-022 | Locked direct-control party behavior | Made the ordinary party remain stationary at the release point while the player directly controls a qualifying companion such as the Sewer Rat. |
| 2026-08-25 | IF-ENV-002; IF-CMP-017; IF-CMP-022 | Locked reusable passage category | Replaced Rat-specific passages with Tiny-Character Passageways usable by any explicitly qualified actor; allowed those passages to cross subareas while blocking ordinary exits during direct companion control. |
| 2026-08-25 | IF-PIL-008; IF-CMP-022 | Locked friction-removal philosophy and return flow | Added Return to Party with an implied automatic retrace and generalized the rule that resolved, consequence-free cleanup should not consume the player's real time. |
| 2026-08-25 | IF-CMP-018; IF-TAG-014 | Locked Mutt kit and Small target qualifier | Gave the Mangy Mutt Man's Best Friend to wake its sleeping master and warn of designated overworld dangers; gave it free once-per-turn Guard Dog to threaten every Small enemy in range with a Modest Fear chance; and introduced Small as a standardized size qualifier. |
| 2026-08-25 | IF-CMP-018 | Locked source-specific duration | Set Fear inflicted by Guard Dog to 1 turn, preserving the rule that Affliction duration belongs to the effect's source rather than the Affliction tag. |
| 2026-08-25 | IF-CMP-018 | Locked multi-target roll behavior | Make a separate Modest Fear roll for each Small enemy eligible for Guard Dog so one target's result never determines the entire group's result. |
| 2026-08-25 | IF-CBT-009; IF-CMP-018 | Locked continuous radial-range model | Measure standard ranged reach as a circle of distance X from the source's precise battlefield position rather than by zone adjacency; make horizontal and vertical within-zone positioning affect reach; require a visible pre-commitment range preview; and apply the model to Guard Dog from its master. |
| 2026-08-25 | IF-CBT-009–010 | Locked combat-footprint range test | Give combatants stable two-dimensional targeting footprints that are larger than focal points but smaller than their artwork, and count any contact between a range circle and a target's footprint as within range. |
| 2026-08-25 | IF-CBT-011; IF-TAG-015; IF-CMP-018 | Locked universal Sound rule | Make Sound effects ignore combatants, ordinary cover, and visual line-of-sight obstruction while solid walls and sealed barriers block propagation; establish Sound as a delivery tag; and make Guard Dog inherit the shared rule. |
| 2026-08-25 | IF-CMP-018; IF-PRO-007 | Locked prototype deferral | Preserve Man's Best Friend's dangerous-overworld-trigger warning as a permanent concept but exclude its trigger taxonomy and presentation from Prototype 0.1; retain only the combat wake-up behavior for any prototype Sleep test. |
| 2026-08-25 | IF-ENC-001 | Locked prototype battlefield | Place Prototype 0.1's single battle in a permanent service courtyard behind the town square and directly outside the sewer entrance, linking the initial exploration area to the future sewer without building that dungeon yet. |
| 2026-08-25 | IF-ENC-002 | Locked prototype zone structure | Use the standard Enemy Backline, Enemy Midrange, shared Melee, Party Midrange, and Party Backline bands in the courtyard with no special zone, while preserving continuous two-dimensional positioning inside every band. |
| 2026-08-25 | IF-ENM-001; IF-TAG-014 | Locked prototype enemy group | Replace the proposed Sewer Rats with two original Small Sludges as the encounter's close-range enemies, retain one Medium Drowsing Toad as a Sleep-capable support enemy, and use the mixed sizes to test Guard Dog's qualifier. |
| 2026-08-25 | IF-ENM-002; IF-TAG-016 | Locked Sludge kit and untagged damage | Limit each prototype Sludge to movement and one close-range Basic Attack; give that attack no Element or damage-form tag; and define untagged damage as intentional tag absence rather than a new Neutral or Untyped damage category. |
| 2026-08-25 | IF-ENM-003 | Locked Drowsing Toad core kit | Give the Toad a slightly longer-reaching Water Basic Attack named Tongue Strike, the non-damaging Sound ability Lulling Croak as its only special ability, and an unnamed hopping passive that improves repositioning. |
| 2026-08-25 | IF-ENM-003 | Locked hopping advantage | Let the Drowsing Toad hop over combatants and low obstacles while requiring a valid unoccupied landing point and charging ordinary displacement and zone-transition Action-Gauge costs. |
| 2026-08-25 | IF-ENC-003 | Locked prototype environmental set | Place exactly one oil barrel, one shallow puddle, and one low crate stack in every prototype courtyard battle to test a reactive object, a surface, and low-obstacle pathing without randomized layouts. |
| 2026-08-25 | IF-ENV-003 | Locked oil-barrel rupture routes | Make the first valid damaging hit rupture the barrel and create an Oiled surface; leave ordinary spills available for later ignition while resolving an Ignite-tagged rupture as spill first and immediate ignition second. |
| 2026-08-25 | IF-ENV-003–004 | Locked ignited-oil result | Make the barrel's Oiled spill produce one immediate area-damage explosion when first ignited and then persist as a Burning Oil surface, without adding unapproved forced movement. |
| 2026-08-25 | IF-ENV-004 | Locked environmental friendly fire | Make the oil explosion damage every combatant in its area regardless of allegiance, retain attached companions as nontargetable components, and require the pre-commitment preview to expose allied risk. |
| 2026-08-25 | IF-ENV-004 | Locked compatible-object chain reactions | Make the oil explosion carry Ignite and damage compatible environmental objects, resolve each object's own state transitions in sequence, prevent repeated one-time transitions, and preview deterministic reaction chains. |
| 2026-08-25 | IF-ENV-004 | Locked Burning Oil exposure rule | Give Burning Oil no separate surface-damage tick; instead apply Burn when the surface forms beneath a combatant, when a footprint enters it, and when a combatant begins a turn within it, while leaving the initial explosion as the direct-damage event. |
| 2026-08-25 | IF-ENV-004 | Locked Burning Oil movement property | Preserve Slippery after Oiled transforms into Burning Oil by granting it directly to the persistent surface without retaining the mutually exclusive Oiled Condition or increasing the Shove vulnerability. |
| 2026-08-25 | IF-ENV-005 | Locked shallow-puddle contact behavior | Make the puddle a harmless persistent surface that grants Wet only during actual combat-footprint overlap and removes its Wet immediately when the combatant leaves. |
| 2026-08-25 | IF-ENV-006 | Locked low-crate partial cover | Keep ranged attacks legal through partial cover while reducing their accuracy rather than their damage, and expose the modified hit chance in the pre-commitment preview. |
| 2026-08-25 | IF-ENV-006 | Locked partial-cover eligibility | Apply partial cover to every directly targeted ranged action with an accuracy roll regardless of physical or magical delivery; exempt guaranteed-hit, ground-targeted, Sound, melee, and close-range actions according to their existing resolution rules. |
| 2026-08-25 | IF-ENV-006 | Locked partial-cover geometry | Trace a line from attacker focal point to target focal point and grant partial cover when it intersects the crate's logical footprint, allowing continuous repositioning to clear the shot. |
| 2026-08-25 | IF-ENV-006 | Locked nonstacking partial cover | Treat partial cover as one binary accuracy state regardless of how many qualifying objects cross the shot line, while preserving the penalty until every intersecting source is cleared. |
| 2026-08-26 | IF-ENV-006 | Locked partial-cover accuracy counterplay | Resolve the cover penalty inside the existing additive accuracy calculation so ordinary accuracy bonuses from items, passives, and effects can offset it without a separate penetration statistic. |
| 2026-08-26 | IF-ENV-006 | Locked prototype partial-cover magnitude | Apply a −20 percentage-point accuracy penalty, reducing the universal 95% base accuracy to 75% before Dodge and other additive modifiers. |
| 2026-08-26 | IF-ENV-006 | Locked destructible low cover | Give the crate modest durability under shared party-and-enemy object-targeting rules; at zero Health, remove its cover and collision and leave only harmless cosmetic debris. |
| 2026-08-26 | IF-ENC-003; IF-ENV-006 | Revised and locked mirrored crate layout | Replace the single crate with two independently destructible stacks placed approximately opposite one another in Party and Enemy Midrange, using the enemy crate to protect the backline Toad and the party crate to teach defensive cover use. |
| 2026-08-26 | IF-ENC-003; IF-ENV-003 | Locked oil-barrel placement | Place the intact barrel near one flank at the enemy-side edge of Melee so its initial explosion can threaten one Sludge while the Toad, second Sludge, and enemy crate begin outside the blast. |
| 2026-08-26 | IF-ENC-003; IF-ENV-005 | Locked shallow-puddle placement | Place the puddle on the opposite flank near the party-side edge of Melee as an optional, mutually accessible destination for gaining Wet and extinguishing Burn without obstructing required movement. |
| 2026-08-26 | IF-CBT-012; IF-ENM-001; IF-ENV-003; IF-ENV-006 | Locked universal random Midrange deployment | Spawn every ordinary party and enemy combatant at a random valid position in its side's Midrange by default, let explicit passives override that baseline later, and supersede fixed party, Toad, and Sludge opening placements. |
| 2026-08-26 | IF-CBT-012 | Locked no manual formation | Begin initiative from the generated and passively modified deployment without granting free prebattle repositioning; all later movement uses the ordinary Action-Gauge rules. |
| 2026-08-26 | IF-PTY-001; IF-CMP-004–005; IF-CMP-011–012 | Locked specialized cosmetic companion model | Treat companions as visible cosmetic attachments that add one passive and one commanded active to their master, or a second active when Legendary, without becoming independent combatants or command layers. |
| 2026-08-26 | IF-TURN-001; IF-ENM-001 | Locked tied Sludge activation | Give both Sludges equal Initiative and one shared enemy activation group, resolving their actions sequentially without allowing the party to act between them. |
| 2026-08-26 | IF-TURN-004 | Locked prototype foundational initiative order | Order the first initiative set as Archer, Warrior, tied Sludge group, Mage, and Drowsing Toad, producing an opening two-character allied block followed by alternating enemy and single-character blocks. |
| 2026-08-26 | IF-UI-001 | Locked exact-tie ribbon presentation | Show tied combatants as separate side-by-side portraits within one outlined initiative slot and highlight the entire grouped slot during their shared activation. |
| 2026-08-26 | IF-UI-009 | Locked expression-driven portrait architecture | Show only the current authored speaker's portrait; give the protagonist no authored emotional portrait; give both authored party members extensive expression libraries and broad contextual commentary; and reserve an expression-aware square portrait slot in the UI now without requiring the complete art library in Prototype 0.1. |
| 2026-08-26 | IF-UI-010 | Locked layered commentary presentation | Use non-blocking speech bubbles for automatic routine remarks, the full portrait box for player-initiated conversations and important scripted reactions, a recent-dialogue history for missed ambient lines, and contextual priority and cooldown rules that prevent overlapping or repetitive chatter. |
| 2026-08-26 | IF-UI-009 | Locked fixed portrait anchor | Keep the single full-dialogue portrait in one consistent screen position for every speaker and scene rather than alternating sides, preserving stable text geometry and reading rhythm; leave the choice of left or right for the next layout decision. |
| 2026-08-26 | IF-UI-009 | Locked left-side portrait placement | Place the single full-dialogue portrait on the left for every speaker and scene, creating a consistent portrait-to-name-to-text reading sequence. |
| 2026-08-26 | IF-UI-009 | Locked portrait crop and reference workflow | Use a consistent tight head-and-shoulders portrait crop, and permit clearly beneficial Mystery Dungeon-derived portrait conventions to become recorded working standards without separate approval while reserving consequential identity, scope, agency, and behavior choices for discussion. |
| 2026-08-26 | IF-UI-011 | Locked pixel-portrait working standard | Use 64×64 hard-edged pixel portraits in a fixed 72×72 left slot within a 96-pixel-tall bottom dialogue overlay; preserve transparent backgrounds, stable framing, palette economy, static expression swaps, and separate simplified thumbnails for small UI contexts. |
| 2026-08-26 | IF-UI-012 | Locked stable portrait appearance | Keep portraits visually stable across ordinary gear, classes, specializations, and fusions; communicate those systems through adjacent UI; and reserve replacement portrait sets for explicitly authored permanent transformations or exceptional identity changes. |
| 2026-08-26 | IF-UI-013 | Locked authored-party expression atlas | Give both authored starting party members the same sixteen core expression intents, interpret each through the character's personality, and allow additional character-specific expressions only when they add meaningful narrative value. |
| 2026-08-26 | IF-PRO-008 | Locked prototype narrative boundary | Defer final authored-party identities, writing, visual designs, expression art, and broad commentary until the foundational loop works; preserve all portrait data and UI contracts with placeholders so later content requires no structural rebuild. |
| 2026-08-26 | IF-PRO-009 | Testing implementation checkpoint | Build Prototype 0.0.1 as a grayscale Godot 4 functional shell containing town movement and collision, town-to-battle scene flow, the five-band battle and HUD template, random Midrange deployment, attached-companion placeholders, and the reserved dialogue/portrait contract; defer combat rules to the next checkpoint and retain engine-run verification as pending. |
| 2026-08-26 | IF-PRO-009 | Completed implementation checkpoint | Accept the Windows Godot smoke test for Prototype 0.0.1 and retain Reroll as an in-place development command after replacing the unsafe scene-restart implementation. |
| 2026-08-26 | IF-TURN-005 | Locked selection and exit behavior | Automatically select the first available ally; allow battlefield- and HUD-based switching within the active block while preserving all spent state; and use one confirmed End Block command for the complete allied block. |
| 2026-08-26 | IF-CBT-013; IF-PRO-010 | Locked input contract; testing implementation | Support previewed one-click travel and continuous WASD or Arrow-key movement through one Action-Gauge and collision pipeline, then implement that contract with selection, Gauge previews, zone surcharges, collision, and placeholder initiative-block progression in Prototype 0.0.2. |
| 2026-08-26 | IF-PRO-010 | Completed implementation checkpoint | Accept Prototype 0.0.2's Windows Godot smoke test for unified click and direct movement, Action-Gauge expenditure, collision, active-block switching, block progression, rerolling, and return to town. |
| 2026-08-26 | IF-CBT-014; IF-PRO-011 | Locked targeting foundation | Use command-first targeting and weapon-defined Basic Attacks; preview range, cost, Accuracy, and damage; require manual positioning for out-of-range targets; share the target layer between enemies and compatible objects; and exclude direct ally targeting from ordinary Basic Attacks. |
| 2026-08-26 | IF-UI-014 | Locked combat-bar architecture and palette | Reserve five equal unlabeled bar positions for Health, Action Gauge, and up to three inherited class resources; teach their identities outside the persistent HUD; and make the exact ten-color bar palette the only chromatic color in Prototype 0.0.3. |
| 2026-08-26 | IF-CBT-015; IF-ENM-004; IF-PRO-011 | Completed first battle checkpoint | Accept Prototype 0.0.3's Windows test and completed victory as proof of the shared-rule battle loop, including enemy movement and attacks, Health and defeat, destructible crates, barrel rupture, skipped defeated blocks, Victory, Defeat, Retry, and town return. |
| 2026-08-26 | IF-CBT-014 | Locked default Basic Attack cadence | Limit every Basic Attack to one committed use per combatant turn by default, consume the use on hit or miss, reset it on that combatant's next turn, and permit only explicit weapon or class-passive exceptions. |
| 2026-08-26 | IF-UI-015 | Locked ranged-delivery line vocabulary | Remove movement connectors and crossed-zone route markers while retaining destination and Gauge previews; reserve source-to-target delivery lines for ranged attacks of any kind and omit them from melee attacks. |
| 2026-08-26 | IF-PRO-012 | Testing implementation checkpoint | Apply the revised Basic Attack cadence and ranged-only delivery-line vocabulary in Prototype 0.0.4 without adding artwork or another system layer. |
| 2026-08-27 | IF-PRO-012 | Completed implementation checkpoint | Accept Prototype 0.0.4's Windows test after confirming independent once-per-turn Basic Attack use across allied characters in the same initiative block. |
| 2026-08-27 | IF-PRO-006; IF-PRO-013 | Locked next prototype direction | Replace Warrior with the working Berserker test character in Prototype 0.0.5, retain Mage and Archer, and introduce rudimentary static grayscale pixel placeholders while keeping resource bars as the only color. |
| 2026-08-27 | IF-CLS-009 | Locked Berserker weapon-action foundation | Begin Rage empty; generate it through injury and designated weapon attacks; use a two-handed baseline Basic Attack plus a separate zero-Gauge, once-per-turn, low-damage medium-range Free Throw; and represent the throwing weapon as two recoverable physical axes. |
| 2026-08-27 | IF-CLS-009 | Locked recovered-axe readiness | Track each axe independently; make a picked-up axe unready for the rest of the pickup turn and ready it at the start of the Berserker's next turn without disabling a second axe that remained carried. |

## 11. Next Decision

**Open:** Decide whether the two-handed Basic Attack and Free Throw generate their fixed Rage amount when committed against a hostile combatant or only after a successful hit. The current recommendation is to generate the fixed amount on commitment against a hostile combatant, even on a miss, because the hard once-per-turn limits and recoverable physical axes already constrain output; attacks against environmental objects would not generate Rage.

## 12. Change Log

- **0.1 — August 23, 2026:** Created the ledger from the established Infinite Fantasia class-system rules; added production-scope analysis, initial vertical-slice proposal, and ordered open questions.
- **0.2 — August 23, 2026:** Restricted the first playable version to base classes, superseded the early four-class combination-slice proposal, and added the proposed early-*Final Fantasy*/original-*Brave Frontier* 2D presentation direction.
- **0.3 — August 23, 2026:** Added the proposed Battlefield Zone System, interactable scene objects, curated battlefield variation, enemy use of shared environmental rules, and a deliberately limited first combat-system test.
- **0.4 — August 23, 2026:** Replaced hard AP with continuous per-character Action Gauges; added free-form click-to-move, variable within-zone and zone-transition costs, hidden class efficiencies, and visible pre-commitment cost previews.
- **0.5 — August 23, 2026:** Established universal Health and Action Gauges plus one mechanically distinct resource per base class; separated ordinary AP actions from class-resource abilities; defined future fusion-resource inheritance; rejected spell slots in favor of a still-to-be-specified numeric PP/resource model.
- **0.6 — August 23, 2026:** Locked the dual-limit ability model: spells and class abilities consume both their shared class resource and their own individual PP pool.
- **0.7 — August 23, 2026:** Made PP an encounter-level limit; established automatic post-battle Action Gauge, PP, and class-resource resets; added automatic Health recovery through provisions; and set full preparation as the encounter-balance assumption.
- **0.8 — August 23, 2026:** Established partial healing when provisions run out; required every class to contribute to exploration; added persistent Expedition PP for limited field abilities; and identified Cleric, Warden, and potentially Warlock as out-of-combat recovery classes.
- **0.9 — August 23, 2026:** Added a persistent configurable recovery policy with conserve-ability, conserve-provision, and balanced presets plus efficiency and reserve controls.
- **0.10 — August 23, 2026:** Extended automatic recovery to routine status treatment and established a general preference for sensible defaults plus configuration when it improves play without compromising the intended experience.
- **0.11 — August 23, 2026:** Locked initiative blocks and free interweaving of partial allied actions within uninterrupted initiative groups; applied the same coordination rules to enemies.
- **0.12 — August 23, 2026:** Fixed initiative for the duration of battle unless changed by an explicit effect and established an always-visible, block-grouped, at-a-glance initiative ribbon.
- **0.13 — August 23, 2026:** Set the active party at three character–companion pairs; added persistent recruitable companion growth, class pets and summons, exploration tricks, and a compact companion-complexity boundary.
- **0.14 — August 23, 2026:** Defined companions as attached, equipment-like systems that never act or move independently; added commanded, passive, triggered, and exploration effects whose reach derives from the master's position.
- **0.15 — August 23, 2026:** Made active companion commands spend master Action Gauge, removed companion PP, added per-turn and per-battle command limits, and recorded the rat's passive/basic-attack and commanded-Bite example.
- **0.16 — August 23, 2026:** Removed independent companion Health and targeting; fixed ordinary and Legendary companion ability counts; added initially cosmetic equipment slots and visible companion following beside the selected overworld master.
- **0.17 — August 23, 2026:** Allowed companion passives and actives to carry explicit or systemic overworld applications without adding a separate ability slot or requiring exploration utility on every companion.
- **0.18 — August 23, 2026:** Limited expeditions to three selected traveling companions while allowing those companions to be freely reassigned among the three active masters outside combat.
- **0.19 — August 23, 2026:** Established one player-created protagonist plus two authored tutorial companions and gave the player control over all three starting base classes while preserving the companions' fixed story identities.
- **0.20 — August 24, 2026:** Added player-authored protagonist identity, renameable authored companions with fixed personalities and histories, narrative passives based on background, and a firm separation between character identity and class performance.
- **0.21 — August 24, 2026:** Added per-character Class Expertise, allowed active companions to contribute earned class knowledge through character-consistent interjections, and prohibited trivial interaction grinding as the route to mastery.
- **0.22 — August 24, 2026:** Made class-specific accomplishments, training, quests, and discoveries the primary Expertise sources; added character-level gates and required multiple non-grind progression routes for every class.
- **0.23 — August 24, 2026:** Replaced branching Expertise choices with automatic level-curriculum unlocks and background challenge achievements; added meaningful-credit safeguards and concise perk-unlock notifications.
- **0.24 — August 24, 2026:** Hid all unearned Expertise challenges and progress; added a post-discovery Expertise tab divided into Class Expertise and General Expertise.
- **0.25 — August 24, 2026:** Made General Expertise per character; proposed one hidden challenge system divided by class identity versus general lived experience and a selected-actor model with party-wide passive awareness.
- **0.26 — August 24, 2026:** Locked selected-character deliberate interactions and party-wide passive observations; established the universal description-language objective and recorded the proposed three-class, Level-5 town-and-sewer demo target.
- **0.27 — August 24, 2026:** Established tag-led skill descriptions, minimal rules blocks, equipment stat strips, equivalent tag inspection across input methods, and the principle of visible results over hidden formulas; flagged skill-cost presentation for reconciliation.
- **0.28 — August 24, 2026:** Confirmed that spells retain class-resource and PP costs, established Elements as the first tag category, separated elemental identity from status and world-interaction permissions, and opened the initial element roster discussion.
- **0.29 — August 24, 2026:** Accepted Light, Shadow, and Arcane as damage Elements; audited the two-strength/two-weakness rule across different roster sizes and identified the mathematical cost of separate noninteracting wheels.
- **0.30 — August 24, 2026:** Split matchup logic into a two-and-two Natural family and a simpler Esoteric family; permitted justified Natural-roster expansion and proposed Nature, mutual Light–Shadow vulnerability, and neutral Arcane for audit.
- **0.31 — August 24, 2026:** Accepted Nature as an organic Natural Element, defined Terra as the inorganic natural domain, preserved existing inorganic Elements as distinct, and separated thematic domain membership from automatic elemental affinity.
- **0.32 — August 24, 2026:** Reframed elemental matchups as receiver-owned defensive profiles with two vulnerabilities and two resistances; locked Beast as a separate enemy type and generalized the action-declares/receiver-reacts philosophy.
- **0.33 — August 24, 2026:** Locked global two-list vulnerability and resistance distribution for every Natural attack Element; recorded the first explicit vulnerabilities and separated hard locks from strong proposals.
- **0.34 — August 24, 2026:** Renamed Earth to Terra; recorded and audited the first full vulnerability draft, identified its two valid seven-Element completions, and quantified the constraints of adding one new Natural Element.
- **0.35 — August 24, 2026:** Applied the Water–Nature and Terra–Wind vulnerability swaps; made Wind vulnerable to Ice and Lightning; completed the balanced provisional chart with Wind scouring Ice and Nature grounding Lightning.
- **0.36 — August 24, 2026:** Provisionally accepted the complete vulnerability chart, deferred resistance structure, separated status definitions from application chances, and recorded and audited the first exact word-based chance ladder.
- **0.37 — August 24, 2026:** Corrected chance presentation so percentages remain hidden and description words are noninteractive; limited inspection to the tag row and reduced the naming recommendation to Minuscule at 3% and Modest at 20%.
- **0.38 — August 24, 2026:** Locked the final hidden chance ladder and opened Affliction taxonomy with a proposed distinction between harmful Afflictions and neutral reactive Conditions.
- **0.39 — August 24, 2026:** Locked the Affliction, Condition, and immediate-effect distinction; adopted semantic-first Affliction design without premature numbers; defined Burn as turn-based damage that grants Ignite while active.
- **0.40 — August 24, 2026:** Defined Poison as recurring damage that escalates every turn while active, while deferring all numerical and detailed timing decisions.
- **0.41 — August 24, 2026:** Defined Bleed as damage triggered by Action-Gauge expenditure and preserved later design space for damage, duration, stacking, cleansing, and continuous-spending rules.
- **0.42 — August 24, 2026:** Defined Disease as a complete healing prohibition that persists after battle and prevented automatic recovery from wasting healing while Disease remains active.
- **0.43 — August 24, 2026:** Replaced Freeze with Chilled, defined Chilled as an Action-Gauge lock, and added removal through Fire damage or proximity to Ignite.
- **0.44 — August 24, 2026:** Defined Stun as complete action denial for exactly one turn while preserving passive and triggered effects.
- **0.45 — August 24, 2026:** Defined Sleep as breakable total action denial removed by damage, movement, or any explicitly stated waking effect.
- **0.46 — August 24, 2026:** Defined Rooted as a movement-only Action-Gauge restriction removed by forced movement or Ignite while preserving all other actions.
- **0.47 — August 24, 2026:** Defined Fear as a one-turn prohibition on all attacks and voluntary movement toward any enemy while preserving nonaggressive actions.
- **0.48 — August 24, 2026:** Defined Blind as a hidden 50-point High Accuracy reduction; set default Accuracy to 95%; made Dodge subtract additively; allowed negative Dodge and over-100 Accuracy; and locked additive damage and Accuracy percentage modifiers.
- **0.49 — August 24, 2026:** Locked final hit-roll boundaries: uncapped Raw Hit Chance during calculation, guaranteed hits at 100% or higher, guaranteed misses at 0% or lower, and no natural-hit or natural-miss exceptions.
- **0.50 — August 24, 2026:** Defined Silence as blocking Spell-tagged actions; made Affliction durations source-specific; and superseded the former universal one-turn durations for Stun and Fear.
- **0.51 — August 24, 2026:** Defined Slow as increased Action Gauge costs plus reduced Initiative; applied the Initiative reduction to every newly formed set while Slow remains active; and reconciled active Initiative modifiers with stable foundational Initiative.
- **0.52 — August 24, 2026:** Defined Curse as a small Primary-Resource drain at the start of each afflicted combatant's turn; excluded Health, Action Gauge, and ability PP; and deferred its treatment of fusion classes with multiple resources.
- **0.53 — August 24, 2026:** Omitted Shock from the Affliction roster, completed the current Affliction roster, and reserved an unnamed non-Affliction electrical interaction tag for later design.
- **0.54 — August 24, 2026:** Defined Wet as Burn/Ignite immunity, reduced Fire weakness, increased Lightning weakness, and proximity-based Lightning arcing; established the Damage Multiplier Scale; and made newly gained immunity remove matching active effects immediately.
- **0.55 — August 24, 2026:** Made every signed weakness modifier equal one Damage Multiplier Scale rung; allowed multiple modifiers to stack by rung count; and made opposing positive and negative modifiers cancel before resolution.
- **0.56 — August 24, 2026:** Preserved a future mirrored expansion beyond the standard 0.0×–2.0× scale, potentially allowing extreme resistance to become healing and extreme weakness to exceed 2.0×, while deferring all values and requiring strong balance safeguards.
- **0.57 — August 24, 2026:** Clamped current net multiplier results at 0.0× and 2.0×, preventing healing below the floor or damage beyond the ceiling until the future mirrored expansion is deliberately designed and approved.
- **0.58 — August 24, 2026:** Defined Oiled as increased Fire weakness; made Oiled combatants unable to resist Shoves; made Oiled environments Slippery; and allowed Ignite to apply Burn when valid before removing Oiled.
- **0.59 — August 24, 2026:** Defined Slippery as the environmental equivalent of Oiled Shove vulnerability, causing Weight and Shove Resistance to be ignored when determining Shove speed and distance.
- **0.60 — August 24, 2026:** Made Wet and Oiled mutually exclusive, with the second-applied Condition permanently replacing the first on combatants, objects, and environments.
- **0.61 — August 25, 2026:** Locked Godot 4 with GDScript as the engine and scripting language; set Prototype 0.1 at one town square plus one complete battle; and replaced the obsolete open-question list with the ordered production decisions for that milestone.
- **0.62 — August 25, 2026:** Made Windows desktop the primary development and acceptance target while preserving Godot browser export as the secondary sharing and remote-playtesting target.
- **0.63 — August 25, 2026:** Locked a 640×360 internal canvas with pixel-perfect integer scaling and letterboxing; added the first proportional battle-screen wireframe with a top initiative ribbon, central five-band battlefield, transient command tray, and three paired character–companion HUD panels.
- **0.64 — August 25, 2026:** Accepted the complete battle-screen wireframe as the Prototype 0.1 working template while explicitly preserving proportion and behavior changes driven by implementation and playtesting.
- **0.65 — August 25, 2026:** Locked Warrior, Mage, and Archer as the first battle's class trio; committed Prototype 0.1 to a narrow but genuine companion-system proof using two or three permanent starting-city companions, with three recommended and recruitment or progression content deferred.
- **0.66 — August 25, 2026:** Locked Prototype 0.1 at exactly three permanent starting-city companions, retained optional empty assignments, and moved companion design into a one-at-a-time identity-and-kit sequence.
- **0.67 — August 25, 2026:** Locked the Sewer Rat as Prototype Companion 1 and the close-range companion baseline, preserving its later recruitment in the starting-city sewer while leaving its exact kit open.
- **0.68 — August 25, 2026:** Rejected Opportunistic Bite and preserved the Sewer Rat's kit for later ideas; locked the Mangy Mutt as Companion 2 and as the eventual first companion, acquired when one small act of kindness causes the unwanted stray to follow the player.
- **0.69 — August 25, 2026:** Replaced the third recruitable prototype companion with an amulet-granted Lesser Storm Elemental; added the reusable item- and class-granted companion architecture, Wind Shear as ranged Wind-only damage, and Fireball, Snowball, and Arcane Missile as the prototype Mage's spell set.
- **0.70 — August 25, 2026:** Required a concise confirmation before a summoned companion replaces an assigned recruit; returned the displaced companion safely to the expedition roster; made removal leave the slot empty; and established **Requires: Mana** as a resource-based equipment requirement that remains valid for future Mage hybrids.
- **0.71 — August 25, 2026:** Locked Tailwind as the Lesser Storm Elemental's passive, reducing the master's first zone-transition Action-Gauge cost each turn while leaving the exact reduction for the numerical pass.
- **0.72 — August 25, 2026:** Replaced the former Action-Gauge companion-command rule with free once-per-turn actives as the standard; locked Wind Shear at 3 Wind damage once per turn with no resource cost; and formally rejected the obsolete Rat example while preserving close-range reach.
- **0.73 — August 25, 2026:** Locked the Sewer Rat's Infiltrator passive and Gross Gnaw active; introduced skill-granted direct overworld companion control; assigned Gross Gnaw an Abysmal hidden Disease chance and free once-per-turn cadence; and left its damage plus direct-control boundaries open.
- **0.74 — August 25, 2026:** Anchored the ordinary party at its release point during direct companion control and made ordinary movement resume from that unchanged position when control returns.
- **0.75 — August 25, 2026:** Created reusable Tiny-Character Passageways for explicitly qualified actors, granted their use through Infiltrator, allowed them to connect compatible subareas, and prevented directly controlled tiny companions from using ordinary party exits.
- **0.76 — August 25, 2026:** Added Return to Party with an implied automatic retrace after direct companion control and locked the broader principle of automating resolved, consequence-free friction without erasing danger or meaningful decisions.
- **0.77 — August 25, 2026:** Locked the Mangy Mutt's Man's Best Friend passive and Guard Dog active; made its Sleep removal an explicit incapacitation exception; introduced Small as a standardized target-size qualifier; and left Guard Dog's duration, range, and multi-target roll behavior for separate decisions.
- **0.78 — August 25, 2026:** Set Fear inflicted by Guard Dog to 1 turn as a source-specific duration and moved its multi-target chance resolution to the next decision.
- **0.79 — August 25, 2026:** Made Guard Dog roll its Modest Fear chance independently for every eligible Small enemy, preventing an all-or-nothing group result.
- **0.80 — August 25, 2026:** Replaced zone-step range with continuous radial geometry centered on the source's exact two-dimensional position; made within-zone movement affect reach across zone boundaries; required a visible range preview; and applied the model to Guard Dog.
- **0.81 — August 25, 2026:** Added stable two-dimensional combat footprints smaller than character artwork but larger than focal points, and made any range-circle contact with a target's footprint count as within range.
- **0.82 — August 25, 2026:** Promoted Guard Dog's obstruction behavior into a universal Sound rule and tag: sound ignores combatants, ordinary cover, and visual line-of-sight obstruction but is stopped by solid walls and sealed barriers.
- **0.83 — August 25, 2026:** Deferred Man's Best Friend's overworld-warning taxonomy and presentation beyond Prototype 0.1 while retaining its combat wake-up behavior, and advanced prototype planning to the first encounter's location.
- **0.84 — August 25, 2026:** Located Prototype 0.1's single battle in a permanent service courtyard behind the town square and directly outside the sewer entrance, preserving the sewer itself for a later milestone.
- **0.85 — August 25, 2026:** Gave the prototype courtyard the standard five battlefield bands with no special zone, preserving continuous positioning and leaving advanced zone layouts for later encounters.
- **0.86 — August 25, 2026:** Locked the prototype enemy group as two Small Sludges and one Medium Drowsing Toad, using the Sludges as original introductory JRPG monsters and the Toad as a Sleep-capable non-Small companion-system test.
- **0.87 — August 25, 2026:** Limited each prototype Sludge to movement and one close-range Basic Attack, gave that attack no Element or damage-form tag, and defined untagged damage as intentional tag absence rather than a new damage category.
- **0.88 — August 25, 2026:** Locked the Drowsing Toad's core kit: slightly extended Water damage through Tongue Strike, non-damaging Sleep application through the Sound-tagged Lulling Croak, and a passive hopping identity whose exact repositioning advantage remains open.
- **0.89 — August 25, 2026:** Let the Drowsing Toad's passive hopping movement pass over combatants and low obstacles while retaining ordinary movement and zone-transition costs and requiring a valid landing point.
- **0.90 — August 25, 2026:** Fixed the prototype courtyard's environmental set at one oil barrel, one shallow puddle, and one low crate stack, covering reactive objects, surfaces, and low-obstacle pathing with a reproducible layout.
- **0.91 — August 25, 2026:** Made any valid damaging hit rupture the prototype oil barrel into an Oiled surface and ordered Ignite-tagged ruptures as spill first, then immediate ignition, preserving both setup and direct-reaction routes.
- **0.92 — August 25, 2026:** Made the first ignition of the barrel's Oiled spill deal immediate area damage and transform the spill into a persistent Burning Oil surface, while preventing repeated explosions from the already-burning surface.
- **0.93 — August 25, 2026:** Gave the oil explosion full friendly fire against every combatant in its area and required its pre-commitment preview to identify endangered allies as clearly as enemies.
- **0.94 — August 25, 2026:** Let oil explosions damage compatible environmental objects, carry Ignite through deterministic chain reactions, and preview the resulting state sequence while preventing repeated one-time transitions.
- **0.95 — August 25, 2026:** Made Burning Oil apply Burn through formation, entry, and start-of-turn exposure while dealing no separate surface-damage tick, keeping the initial explosion as the chain's direct-damage event.
- **0.96 — August 25, 2026:** Made Burning Oil remain Slippery after Oiled transforms, carrying the movement property directly without retaining Oiled or amplifying the existing Shove vulnerability.
- **0.97 — August 25, 2026:** Made the shallow puddle apply Wet only during current combat-footprint overlap, removing that source's Wet immediately upon exit while leaving the surface harmless by itself.
- **0.98 — August 25, 2026:** Made the low crate stack grant partial cover that reduces eligible ranged-attack accuracy without preventing the attack or reducing successful-hit damage, with the modified chance shown before commitment.
- **0.99 — August 25, 2026:** Applied partial cover uniformly to directly targeted ranged actions with accuracy rolls regardless of physical or magical delivery, while preserving the separate rules for guaranteed-hit, ground-targeted, Sound, melee, and close-range actions.
- **0.100 — August 25, 2026:** Defined partial-cover geometry as a logical focal-point-to-focal-point line intersecting the crate footprint, recalculated from continuous positions so lateral movement can clear a shot.
- **0.101 — August 25, 2026:** Made partial cover a nonstacking binary state: multiple intersecting partial-cover sources apply one accuracy penalty, which remains until every qualifying source clears the shot line.
- **0.102 — August 26, 2026:** Integrated the partial-cover penalty into the existing additive accuracy calculation so accuracy bonuses from items, passives, and effects can partially or completely overcome it without a new penetration statistic.
- **0.103 — August 26, 2026:** Recorded the previously settled prototype partial-cover penalty as −20 percentage points, reducing an otherwise unmodified 95% accuracy check to 75% before Dodge and other modifiers.
- **0.104 — August 26, 2026:** Made the prototype low crate destructible with modest durability and shared allegiance-neutral targeting; destroying it removes cover and collision while leaving harmless cosmetic debris.
- **0.105 — August 26, 2026:** Revised the courtyard set from one crate to two approximately mirrored Midrange crate stacks, letting the player practice using partial cover while the enemy crate initially protects the backline Drowsing Toad.
- **0.106 — August 26, 2026:** Placed the oil barrel off-center near the enemy-side edge of Melee, tuning its opening threat around one Sludge while keeping the Toad, second Sludge, and enemy crate outside the initial explosion.
- **0.107 — August 26, 2026:** Placed the shallow puddle on the opposite flank near the party-side edge of Melee, making Wet and extinguishing available to either side without placing the surface beneath a starting actor or across a required route.
- **0.108 — August 26, 2026:** Replaced fixed starting formations with universal random valid deployment inside each side's Midrange, preserving future passive overrides and revising crate and barrel expectations around variable opening positions.
- **0.109 — August 26, 2026:** Removed free manual formation after random deployment and formalized companions as specialized cosmetic attachments that contribute their fixed passive-and-active kit through the master without becoming additional combatants.
- **0.110 — August 26, 2026:** Gave equal-Initiative allies one shared activation position and applied that rule to the two statistically identical Sludges, which act as one enemy group without party interruption while resolving their actions sequentially.
- **0.111 — August 26, 2026:** Locked the prototype's foundational initiative order as Archer, Warrior, tied Sludge group, Mage, and Drowsing Toad, guaranteeing an opening shared party block and a Sludge interruption before Mage.
- **0.112 — August 26, 2026:** Made exact Initiative ties appear as distinct side-by-side portraits inside one outlined ribbon slot, with the full group highlighted together while preserving individual readability.
- **0.113 — August 26, 2026:** Adopted an expression-driven portrait architecture inspired by *Pokémon Mystery Dungeon*; locked one authored speaker portrait at a time; exempted the player-created protagonist from authored emotional portraits; and assigned the two authored party members extensive expression libraries plus broad contextual reactions inspired by the persistent companion presence of *Dragon's Dogma 2*.
- **0.114 — August 26, 2026:** Locked three dialogue triggers across two interfaces: automatic routine remarks use non-blocking speech bubbles, while player-initiated conversations and important scripted reactions share the full one-speaker portrait box; added dialogue history, contextual priority, cooldowns, and overlap prevention for ambient commentary.
- **0.115 — August 26, 2026:** Fixed the single full-dialogue portrait to one consistent screen position across every speaker and scene, preventing text reflow or shifting reading order; left the final choice of left or right open.
- **0.116 — August 26, 2026:** Placed the fixed full-dialogue portrait on the left side for every speaker and scene, establishing a stable portrait-to-name-to-text reading sequence.
- **0.117 — August 26, 2026:** Locked a tight head-and-shoulders portrait crop and authorized the automatic adoption of clearly beneficial Mystery Dungeon-derived portrait conventions while preserving explicit discussion for decisions that materially affect identity, scope, agency, or interface behavior.
- **0.118 — August 26, 2026:** Chose visibly pixelated dialogue portraits and established the 64×64 native portrait canvas, 72×72 fixed left slot, 96-pixel bottom dialogue overlay, transparent stable framing, hard nearest-neighbor rendering, static expression swaps, palette economy, and separate simplified thumbnails for small UI contexts.
- **0.119 — August 26, 2026:** Made portrait appearance stable across ordinary equipment, class, specialization, and fusion changes; moved those identities into adjacent UI; and limited replacement portrait sets to explicitly authored permanent transformations or exceptional identity changes.
- **0.120 — August 26, 2026:** Standardized both authored starting party members around sixteen core portrait expressions—Neutral, Happy, Joyous, Inspired, Determined, Angry, Worried, Sad, Teary-Eyed, Crying, Pained, Surprised, Stunned, Shouting, Sighing, and Confused/Dizzy—while permitting narratively justified character-specific additions.
- **0.121 — August 26, 2026:** Deferred final authored-party identity, writing, portrait art, and contextual-commentary production until the foundational loop works, while requiring Prototype 0.1 placeholders to preserve the complete portrait and dialogue architecture for later replacement.
- **0.122 — August 26, 2026:** Began active prototyping and built Prototype 0.0.1 as a grayscale Godot 4 functional shell with town movement and collision, town-to-battle transitions, the locked battlefield and HUD composition, random Midrange deployment, companion attachments, and the reserved dialogue/portrait interface; documented that combat behavior begins in 0.0.2 and that engine-run verification remains pending.
- **0.123 — August 26, 2026:** Accepted Prototype 0.0.1's Windows smoke test; locked automatic active-block selection, HUD or battlefield switching, one confirmed End Block command, previewed one-click movement, and continuous WASD movement through a unified Action-Gauge pipeline; and implemented Prototype 0.0.2's selection, movement, collision, Gauge-preview, and placeholder block-progression foundation for testing.
- **0.124 — August 26, 2026:** Accepted Prototype 0.0.2's Windows smoke test; locked Prototype 0.0.3's command-first, weapon-defined Basic Attack targeting contract; and established equal unlabeled five-slot combat bars with the exact Health, Action Gauge, Mana, Rage, Energy, Warlock, Faith, Focus, Warden, and Resolve palette as the prototype's only chromatic color.
- **0.125 — August 26, 2026:** Expanded Prototype 0.0.3 into the first complete winnable-or-losable combat checkpoint; implemented shared-rule party and enemy Basic Attacks, damage and defeat, minimal nearest-target enemy decisions, destructible crates, oil-barrel rupture, Victory, Defeat, Retry, and updated acceptance coverage while leaving all numerical values provisional.
- **0.126 — August 26, 2026:** Accepted Prototype 0.0.3's Windows battle test and completed victory; revised Basic Attacks to one committed use per combatant turn by default with explicit weapon and class-passive exceptions; removed movement connectors and crossed-zone markers; reserved delivery lines for ranged attacks; and implemented the focused changes in Prototype 0.0.4 for testing.
- **0.127 — August 27, 2026:** Accepted Prototype 0.0.4's independent Basic Attack cadence; revised the active prototype trio by replacing Warrior with a working Berserker; planned rudimentary grayscale placeholder art for Prototype 0.0.5; and locked the Berserker's empty-starting Rage, two-handed Rage-generating Basic Attack, and separate low-damage medium-range zero-Gauge Free Throw backed by two recoverable physical axes.
- **0.128 — August 27, 2026:** Locked individual recovered-axe readiness: a picked-up axe leaves the battlefield immediately, remains unready for the rest of that turn, and restores one usable Free Throw PP at the start of the Berserker's next turn without affecting an independently ready second axe.
