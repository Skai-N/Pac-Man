# Pac-Man

<p> <a href="https://docs.google.com/document/d/1kgMOwK3Hvl9qedhFxxRxU04NU001gjAafCrqJr1HqKc/edit#">Documentation/Prototype</a> </p>

<p> Team name: Team JV Basketball </p>
<p> Team members: Skai Nzeuton, Aahan Mehta </p>
<p> Basic Pac-Man with features such as power ups and multiple map options. If we have time, we plan to implement the actual behaviors of the ghosts from the actual Pac-Man. Having accurate level advancement and scoring would also be another long term goal. Implementing the actual sound effects and multiple color themes would also be a nice touch. </p>

INSTRUCTIONS FOR MR. K!
You can hard reset by clicking 'f'
You can take away one of pacmans lives by clicking 'k'
You can skip a level by clicking 'q'
-------------------------------------------------------------

Aahan 5/23/22: Finished the readfile function that makes a map based on a file.

Skai 5/23/22: Created Entity class and added instance variables and get methods.

Aahan 5/24/22: Continued workign on map, made changes to PACMan board.

Skai 5/24/22: Finished Entity class methods with Eatable interface implementation, started and finished Fruit class, started and finished Score class.

Aahan 5/25/22: FINISHED THE READFILE AND LOADING METHODS, updated the PacMan methods keyPressed, done, run

Skai 5/25/22: Finished Player class and added more set methods + die() and respawn().

Aahan 5/26/22: Cleaned up the Pac-Man class, fixed problems with gameBoard.

Skai 5/26/22: Added unique speeds to each Entity subclass and started working on the Ghost class and Ghost move().

Aahan 5/27/22: Started putting together the PacMan class with the entities.

Skai 5/27/22: Completed Ghost class and Ghost move(). Modified the main class to be able to run for testing purposes.

Skai 5/29/22: Cleaned up the overall graphics and made PacMan and the fruits display properly.

Aahan 5/30/22: Added updating score and working on invincible modes depending on framecount.

Skai 5/30/22: Added more maps to be able to test and use in general. PacMan and the ghosts have very crude mechanics.

Aahan 5/31/22: Added Invincible mode and working on fruit modes with points/powerups.

Aahan 6/1/22: Modified invincible mode to come and go in intervals + bigdots get right points

Skai 6/1/22: Started working on implementing a ghost chamber for ghosts to spawn in, created a new display for energizers, updated the map file to reflect these changes.

Aahan 6/2/22: Added multiple ghosts movement and an updating score

Skai 6/2/22: Fixed the ghost being able to edit fruit locations (door fixed), made level progression fully functional, and stopped the ghost and PacMan from being able to move instantly after respawning.

Aahan 6/3/22: Maps now had a teleport, and an arraylist that stores warps and links them

Skai 6/3/22: Fixed ghost and PacMan moving instantly after loading a new level and started working on PacMan invincibility after eating an energizer.

Aahan 6/4/22: Updated the readfile and maps for teleportation.

Skai 6/4/22: Fixed TPs to make them work properly.

Aahan 6/6/22: Added high score functions, set up a start and end page with keys.

Aahan 6/11/22: Worked on how to make movement smooth without weird display.

Aahan 6/12/22: ADded ghost icons and cheat codes.
