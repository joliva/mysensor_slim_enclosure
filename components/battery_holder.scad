/* 
*  Open SCAD Name.: battery_holder.scad
*  Copyright (c)..: 2018 John Oliva
*
*  Creation Date..: 08/14/2018
*  Description....: 2 AA battery holder
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

include<battery_term.scad>
include<battery_term_spring.scad>

//-------------------------------------------------------------------------------------------------
// BATTERY HOLDER
//-------------------------------------------------------------------------------------------------
battery_holder_size = [112.412, 18.5, 14.0];

module battery_holder(color="gold", clips_en=true, bbox=false) {
   if (bbox) {
         _battery_holder(bbox);
   } else {
         color(color) _battery_holder();
   }

   if (clips_en == true) {
      translate([0,0,8.5]) {
         translate([52.5,0,0]) battery_term_spring(color="silver");
         translate([-52.5,0,0]) battery_term(color="silver");
      }
   }
}

module _battery_holder(bbox) {
   LEN = battery_holder_size.x;
   WID = battery_holder_size.y;
   HGT = battery_holder_size.z;

   // center on x,y and sitting at z=0
   translate([-1.8,0,8.446])
   rotate([0,0,90])
   import("components/2aa_battery_holder.stl");

   if (bbox) {
         %translate([0,0,HGT/2]) cube([LEN,WID,HGT], center=true);
   }
}
//-------------------------------------------------------------------------------------------------

