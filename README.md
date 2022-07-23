 # BackroomsBaseProject
Baseplate project made in Godot for a Backrooms Game

 # Versions
 ### Alpha 1.0
- Added main features to the game
  - Player movement, camera and animations
  - Player sounds (Run/Sprint)
  - Ability to sprint with Ctrl
  - Ability to toggle flashlight with F
- Added basic enemies
  - Enemy 1, the "Stalker", moves slowly and can go trough walls. Long detection range.
  - Enemy 2, the "Chaser". Moves quicker and has a short detection range.
 
 ### Alpha 1.1
 - Big changes to the map rendering
   - Individual lights temporarily removed due to performance issues
   - Global lights added to sed the "backrooms-y" mood
   - Still some bugs with intersecting walls
 - Systems / gameplay rework
   - Flashlight temporarily removed (no use with lighting changes)
   - Movement tracker added
     - Spacebar to toggle
     - Responsive sounds
     - Responsive animations
     - Probably will debuff in next update (finite batteries/slowing the player)
 - Aesthetics rework
   - Added shadders to make the game feel like actual footage
   - Added timer (time counter) on the top left of the screen, next to "REC" text

 #### Alpha 1.1.1
 - Systems / Mechanics
   - Added Stamina and Stamina Bar
   - Details / animation to Movement Tracker
   - Minor changes to player movement
 - Levels
   - Added baseplate of Level 7
   - Added new textures for levels
 
 #### Alpha 1.1.2
 - Systems / Mechanics
   - Added Flash mechanic
   - Model of the "Flasher" tool to be added in 1.1.3
   - Added checkpoint idea (old computers). To be implemented

 #### Alpha 1.1.3
 - Added picking up / dropping items
   - Pick up with E, drop with Q
   - BUG A1131: Dropping items makes them fall trough the world
   - BUG A1132: Player can sometimes fall trough the world when picking up / dropping items

 #### Alpha 1.1.4
 - Systems / Mechanics
   - Removed the ability to drop items
 - Bugs
   - Fixed Bug A1131
   - Bug A1132 still persists, even in other levels than Level7
 - Gameplay 
   - Main menu revamped
     - "OPTN" button (options) has no functionality yet
 #### Alpha 1.1.5
 - Systems / Mechanics
   - Created saving / loading system. Not fully implemented in-game yet, but the code is there
   - Added "Secrets". They will be collectibles that unlock different looks in the main menu.
 - Bugs:
   - A1151: when acquired, motion tracker is up but off. It should be on.
   - A1152: motion tracker can be activated from main menu.
 ### Alpha 1.2 (stable)
 - Systems / Mechanics
   - Saving / loading now works in-game. Checkpoint's model will need a rework.
   - Flasher now visually updates its charges.
 - Bugs:
   - Fixed BUG A1151
   - Fixed BUG A1152
   - Found BUG A121: On load, player's rotation doesn't get saved and updated. This makes them face weird angles.

 #### Alpha 1.2.1
 - Gameplay
   - Added new introductory video / analog horror styled
 - Levels
   - Added new materials and objects for levels, still unused
 - Incoming Changes:
   - Enemy Balance / Rework, they are too easy to run away from
   - Loading file needs more information
     - To not repeat cinematic every time (first time play or not?)
     - To keep track of player's camera time
 - Bugs:
   - Found BUG A1211: Items respawn when reloading level, but the player still has them in their hand

 #### Alpha 1.2.2
 - Levels
   - Added Level14, entire new level dungeon-like. Added Collisions, they should be fine.
 - (Debug: added debug mode, so player doesn't get automatically tp'd to checkpoints)

