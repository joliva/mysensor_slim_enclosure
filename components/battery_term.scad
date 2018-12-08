/* 
*  Open SCAD Name.: battery_term.scad
*  Copyright (c)..: 2018 John Oliva
*
*  Creation Date..: 08/14/2018
*  Description....: Battery terminal (non-spring)
*
*
*  Built On: Open SCAD version 2018.03.17
*
*  This program is free software; you can redistribute it and/or modify it under the
*  terms of the GNU General Public License as published by the Free Software
*  Foundation; either version 2 of the License, or (at your option) any later version.
*
*  This program is distributed in the hope that it will be useful, but WITHOUT ANY
*  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
*  PARTICULAR PURPOSE.  See the GNU General Public License for more details.
* 
*/ 

//-------------------------------------------------------------------------------------------------
// BATTERY TERMINAL
//-------------------------------------------------------------------------------------------------
battery_term_size = [112.412, 18.5, 14.0];

module battery_term(color="gold") {
   color(color) _battery_term();
}

module _battery_term(bbox) {
   LEN = battery_term_size.x;
   WID = battery_term_size.y;
   HGT = battery_term_size.z;

   // center on x,y and sitting at z=0
   rotate([-90,0,-90])
   import("components/battery_term.stl");
}
//-------------------------------------------------------------------------------------------------

