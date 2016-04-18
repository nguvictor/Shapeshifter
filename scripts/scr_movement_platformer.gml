///movement_platformer(left, right, jump, player_number)

// Handles basic platformer movement, such as left, right, jumping and falling.
// Should be placed within the step event of a player instance.

// NOTE: Make sure movement_platformer_setup have been called least once before using.

// left             = Key to use for moving left.
// right            = Key to use for moving right.
// jump             = Key to use for jumping.

// Dependencies: spd, acc, deacc, jspd, jps_max, jps, jtol, jdelay_max, jdelay, janalog, grav, grav_max, collosion, hspd, vspd
show_debug_message("Working");

jump_joystick=2;
shield_joystick=1;
melee_joystick=3;
range_joystick=4;

//Converts arguments to locals.
var left = argument0;
var right = argument1;
var jump = argument2;
var player_number = argument3;

//Creates keypress checks.
var lkey = keyboard_check(left) || joystick_xpos(player_number) < 0;
var rkey = keyboard_check(right) || joystick_xpos(player_number) > 0;
var jkey = keyboard_check(jump) || joystick_check_button(player_number, jump_joystick);
var jkey_press = keyboard_check_pressed(jump) || joystick_check_button(player_number, jump_joystick);

//Check for collision with ground.
if place_meeting(x, y+1, collision)
{
    //Resets vertical speed.
    vspd = 0;
    
    //Resets jump amount.
    jps = 0;
    
    //Resets jump delay.
    jdelay = 0;
    
    //Handles initial jump.
    if jkey_press and jps_max != 0
    {
        vspd = -jspd;
        jps = 1;
    }
}
else
{
    //Limits step to 1 jump.
    var have_jumped = false; 
   
    //Check if analog jumping.
    if janalog and !jkey and vspd < 0
    {
        //Double gravity increase.
        vspd += grav * janalog_factor;
    }
    else
    { 
        //Normal gravity increase.
        vspd += grav;
    }
    
    //Check if gravity limit.
    if grav_max != -1 and vspd > grav_max
    {
        vspd = grav_max;
    }
    
    //Handles initial jump /w tolerance.
    if jkey_press and jps_max != 0 and place_meeting(x, y + jtol, collision)
    {
        have_jumped = true;
        vspd = -jspd;
        jps = 1;
    }
    
    //Handles delayed initial jumping.
    if jkey_press and jps_max != 0 and jdelay < jdelay_max and jps = 0 and !have_jumped
    {
        have_jumped = true;
        vspd = -jspd;
        jps = 1;
    }
    
    //Handles mid-air jumping.
    if jkey_press and jps < jps_max and !have_jumped
    {
        vspd = -jspd;
        jps += 1;
    }
    
    //Increments jump delay.
    jdelay += 1;
    
    //Check for delay limit.
    if jdelay > jdelay_max
    {
        //Caps the delay to max.
        jdelay = jdelay_max;
        
        //Adds initial jump.
        if jps_max != 0 and jps = 0
        {
            jps += 1;
        }
    }
}

//Left Movement
if lkey and !rkey
{
    //Check if acceleration.
    if acc != -1
    {
        //Check for existing movement.
        if sign(hspd) = -1 or sign(hspd) = 0
        {
            hspd -= acc;
            if -hspd > spd hspd = -spd;
        }
        else
        {
            hspd = -acc;
        }
    }
    else
    {
        hspd = -spd;
    }
}

//Right Movement
if rkey and !lkey
{
    //Check if acceleration.
    if acc != -1
    {
        //Check for existing movement.
        if sign(hspd) = 1 or sign(hspd) = 0
        {
            hspd += acc;
            if hspd > spd hspd = spd;
        }
        else
        {
            hspd = acc;
        }
    }
    else
    {
        hspd = spd;
    }
}

//No Movement.
if (!rkey and !lkey) or (rkey and lkey)
{
    //Check if deacceleration.
    if deacc != -1
    {
        //Check if movement is left.
        if sign(hspd) = -1
        {
            //Deaccelerates.
            hspd += deacc;
            if hspd > 0 hspd = 0;  
        }
        else
        {
            //Deaccelerates.
            hspd -= deacc;
            if hspd < 0 hspd = 0;
        }
    }
    else
    {
        //Stops instantly.
        hspd = 0;
    }
}

//Horizontal Collision.
if place_meeting(x + hspd, y, collision)
{
    //Moves right next to collision.
    while !place_meeting(x + sign(hspd), y, collision)
    {
        x += sign(hspd);
    }
    
    //Stops all movement.
    hspd = 0;
}

//Horizontal Movement.
x += hspd;

//Vertical Collision.
if place_meeting(x, y + vspd, collision)
{
    //Moves right next to collision.
    while !place_meeting(x, y + sign(vspd), collision)
    {
        y += sign(vspd);
    }

    //Stops all movement.
    vspd = 0;
}

//Vertical Movement.
y += vspd;
