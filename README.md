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
   - Added Stamina and Stamina Bar (to be reworked)
   - Added Flash mechanic
   - Model of the "Flasher" tool to be added in 1.1.3
   - Added checkpoint idea (old computers). To be implemented

 #### Alpha 1.1.3
 - Added picking up / dropping items
   - Pick up with E, drop with Q
   - BUG A1131: Dropping items makes them fall trough the world
   - BUG A1132: Player can sometimes fall trough the world when picking up / dropping items

 ### Alpha 1.1.4
 - Systems / Mechanics
   - Removed the ability to drop items
 - Bugs
   - Fixed Bug A1131
   - Bug A1132 still persists, even in other levels than Level7
 - Gameplay 
   - Main menu revamped
     - "OPTN" button (options) has no functionality yet
 
