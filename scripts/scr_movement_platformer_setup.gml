///movement_platformer_setup(speed, increase, decrease, jumpspeed, jumps, tolerance, delay, analog, factor, gravity, maximum, solid);

// Setups variables for the instance used in platformer movement.
// Should be placed within the creation event of an instance.

// NOTE: Creates the following instance variables: 
// spd, acc, deacc, jspd, jps_max, jps, jtol, jdelay_max, jdelay, janalog, grav, grav_max, collosion, hspd, vspd

// speed            = How many pixels the object can travel per step.
// increase         = Speed to increase per step for left/right movement. Use the value -1 for instant.
// decrease         = Speed to decrease per step for left/right movement. Use the value -1 for instant.
// jumpspeed        = Value for jumping. Total jump height may vary depending on gravity.
// jumps            = Number of jumps allowed. 0, disable jumping, 1 normal jump, 2 double jump, etc.
// tolerance        = Number of pixels above ground to allow for premature jumping.
// delay            = Numbers of steps to allow for jumping after leaving the ground.
// analog           = Boolean to allow analog jumping, meaning an early released key, cuts off the jump.
// factor           = Factor used in analog jumping for gravity. Higher value = earlier cut-off.
// gravity          = Value for gravity to accelerate per step.
// maximum          = Maximum value for gravity. Make -1 for unlimited.
// solid            = Parent solid used in collision checking. Usally an obj_solid or obj_wall.

//Converts arguments to locals.
var spd = argument0;
var increase = argument1;
var decrease = argument2;
var jumpspeed = argument3;
var jumps = argument4;
var tolerance = argument5;
var delay = argument6;
var analog = argument7;
var factor = argument8;
var grav = argument9;
var maximum = argument10;
var collision = argument11;

//Creates instance variables.
self.spd = spd;
acc = increase;
deacc = decrease;

jspd = jumpspeed;
jps_max = jumps;
jps = 0;
jtol = tolerance;
jdelay_max = delay;
jdelay = 0;
janalog = analog;
janalog_factor = factor;

self.grav = grav;
grav_max = maximum;

self.collision = collision;

hspd = 0;
vspd = 0;
