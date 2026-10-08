# Infinite Fantasia — Prototype 0.0.4

This is the revised first winnable-or-losable combat greybox for **Infinite Fantasia**. It retains the Windows-tested 0.0.3 battle loop while enforcing one Basic Attack per combatant turn by default and simplifying previews: movement has no connecting line, while ranged attacks gain a source-to-target line. Everything remains grayscale except the locked combat-bar palette.

## Requirements

- Godot 4.x
- Windows is the primary target, although this shell contains no platform-specific code.

## Run

1. Open Godot 4.
2. Import `project.godot` from this folder.
3. Run the project with **F6/F5** or the editor's Run button.

Command-line launch, when Godot 4 is available:

```text
godot4 --path /path/to/infinite_fantasia --editor
```

## Prototype 0.0.4 smoke test

The workspace used to create this checkpoint did not contain a Godot executable, so its files and resource references were validated statically but the engine-run test must be completed on a machine with Godot 4.

Prototype 0.0.4 passes its first engine test when all of the following are true:

1. Godot imports the project without parser or missing-resource errors.
2. The grayscale town square opens at a crisp 16:9 aspect ratio.
3. Left-click and keyboard movement both work, while building and fountain rectangles block the party leader.
4. The `!` interaction advances through two placeholder authored portraits and one protagonist line without a portrait.
5. Walking into the right-side courtyard gate opens the battle shell.
6. The battle automatically selects the Archer and displays equal, unlabeled Health, Action Gauge, and class-resource bars in the locked colors; every other visual remains grayscale.
7. Hovering a destination draws its footprint, movement cost, and linked Action-Gauge depletion preview without drawing a source-to-destination line or crossed-zone markers.
8. Left-clicking that destination commits movement and drains the Gauge; holding **WASD** moves directly and drains the same Gauge continuously.
9. Clicking the Warrior or its HUD panel switches selection without resetting the Archer's spent Gauge; **Tab** provides the same switch.
10. Crates, the oil barrel, battlefield limits, allies, and enemies block movement. Direct click routes through them are rejected, while WASD can steer around them.
11. **Attack** or **F** enters command-first targeting. The selected weapon's radial range appears, enemies and intact compatible objects highlight, and hovering shows range eligibility, Gauge cost, Accuracy, damage, Health, and cover. A ranged attack draws a source-to-target line; a melee attack does not.
12. Clicking an in-range affordable target spends Gauge, consumes that combatant's one default Basic Attack use whether it hits or misses, and resolves the 95% base Accuracy roll. Attack mode closes and the command reads **Attack Used** until that combatant's next turn. Weapon data or a class passive may explicitly alter this limit later.
13. The Archer's ranged shot receives the locked −20 percentage-point partial-cover penalty when its focal-point line crosses an intact crate. Destroying a crate removes its Health, collision, and cover.
14. A damaging hit on the intact oil barrel ruptures it into a visible Oiled surface. Oil ignition remains deferred because Prototype 0.0.4 contains no class abilities.
15. **End Block** or **E** requires confirmation while usable Gauge remains. Both Sludges then act sequentially, choosing the nearest living party member, approaching through the shared movement rules, and using Ooze Slap when able.
16. Mage receives the next allied block, followed by the Drowsing Toad's movement and Water-tagged Tongue Strike. Its hopping route may cross combatants and low crates but must end at a legal landing point and pays normal movement costs.
17. Party and enemy Health persists through the battle. Defeated combatants leave targeting and collision, and their initiative portraits receive a defeated mark.
18. Defeating all enemies opens Victory; losing all three party members opens Defeat. **R** retries with a fully reset random deployment and **Escape** returns to town.

## Controls

### Town square

- **Left mouse:** Click-to-move.
- **WASD / Arrow keys:** Direct movement fallback.
- **E / Space / Enter:** Use the dialogue test while standing near the `!` marker.
- Walk into the dark **COURTYARD / BATTLE** gate on the right to enter the battle shell.
- **Escape:** Quit while in town.

### Battle shell

- **Mouse hover:** Preview a movement destination and its Action-Gauge cost without a connecting line.
- **Left mouse on battlefield:** Commit movement to the previewed destination.
- **Left mouse on an active ally or HUD panel:** Select that combatant.
- **WASD / Arrow keys:** Move the selected combatant directly while continuously spending Action Gauge; this cancels an active click route.
- **F / Attack button:** Enter or leave Basic Attack targeting mode.
- **Mouse hover while targeting:** Inspect reach, target Health, Accuracy, projected damage, Gauge cost, and cover; ranged attacks also show a source-to-target line.
- **Left mouse on a highlighted target:** Commit an in-range affordable Basic Attack; the default limit is one committed use per combatant turn.
- **Right mouse / Escape while targeting:** Cancel Attack mode without leaving battle.
- **Tab:** Switch between allies in the current shared initiative block.
- **E / End Block:** End the complete allied block; confirm once more if usable Gauge remains.
- **R:** Reset the complete battle and reroll all valid Midrange deployment positions; after Victory or Defeat this acts as Retry.
- **Escape:** Return to town.
- The on-screen buttons provide the same actions.

## What this checkpoint proves

- A 640×360 internal viewport shown at a 2× default window size.
- Nearest-neighbor rendering, integer-only viewport scaling, and letterboxing.
- A reusable town scene with click-to-move, keyboard fallback, boundary clamping, simple collision, a three-hitbox party marker, and a battle transition.
- A five-band battle shell using Enemy Backline, Enemy Midrange, shared Melee, Party Midrange, and Party Backline.
- The locked 36-pixel initiative ribbon, 238-pixel battlefield, and 86-pixel party HUD proportions.
- The opening Archer/Warrior allied block, tied two-Sludge slot, Mage position, and Drowsing Toad position.
- Three party HUD panels with five identically sized reserved positions: visible Health, Action Gauge, and current class resource plus two invisible future fusion-resource positions.
- The exact locked bar palette as the prototype's only chromatic color; clean combat bars contain no labels, values, icons, or patterns.
- Placeholder environmental geometry for two crates, one oil barrel, and one puddle.
- Random valid Midrange deployment at battle entry/restart.
- The reserved 64×64 portrait contract inside a 72×72 fixed left slot and 96-pixel dialogue overlay.
- Authored-speaker portrait replacement and a protagonist line without an emotional portrait.
- A complete town → battle → town flow with in-place deployment rerolling.
- Automatic selection of the first available ally in a party initiative block.
- Battlefield-hitbox, HUD-panel, and Tab selection with per-character Gauge state preserved while switching.
- A shared Action-Gauge cost function for previewed click movement and continuous WASD movement.
- Direct-route validation, actor and environmental collision, battlefield clamping, normalized diagonal input, and zone-transition surcharges.
- Destination-footprint, numeric cost, and HUD Gauge-depletion previews without a movement connector or crossed-zone markers.
- Weapon-defined Bow Shot, Sword Strike, and Staff Strike profiles with provisional range, Gauge cost, damage, Health tuning, and a default one-use-per-turn Basic Attack cadence.
- Source-to-target delivery lines for ranged attack previews only; melee attacks and movement display no connector.
- Command-first targeting shared by living enemies, intact crates, and the intact oil barrel, with out-of-range inspection and no automatic move-plus-attack.
- Additive Accuracy resolution, the locked 95% base, the locked −20-point ranged partial-cover penalty, visible hit previews, damage, misses, Health loss, and defeat.
- Destructible crates that lose cover and collision, plus the barrel's first-hit rupture into an Oiled surface.
- Minimal enemy decision-making: nearest living party target, shared-rule approach movement, then its weapon-defined Basic Attack when reachable and affordable; the Toad's locked hopping exception crosses combatants and low crates while preserving legal landings and normal costs.
- One confirmed End Block command for the complete allied block.
- The complete initiative sequence: Archer/Warrior → tied sequential Sludges → Mage → Toad → new initiative set.
- Victory, Defeat, Retry, and town-return states.

## Explicitly not implemented yet

- Companion commands, class abilities, PP spending, class-resource spending, Afflictions, Conditions on combatants, Shoves, oil ignition or explosion, puddle reactions, and finished enemy tactics.
- Click-route pathfinding around obstacles. Prototype click movement accepts a clear direct route; WASD supports steering around collision manually.
- Finished maps, sprites, portraits, animation, sound, character identities, narrative content, menus, saving, or web export.

Those exclusions are intentional. Prototype 0.0.4 proves one complete movement-and-damage battle before companions, class resources, abilities, statuses, and full environmental chains are placed on top of it.
