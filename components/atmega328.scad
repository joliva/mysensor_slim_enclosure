/* 
*  Open SCAD Name.: atmega328.scad
*  Copyright (c)..: 2018 John Oliva
*
*  Creation Date..: 08/14/2018
*  Description....: 28 pin ATMEGA328
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
// ATMEGA328
//-------------------------------------------------------------------------------------------------
ATMEGA328_PIN_OFFSET = 0.8;
atmega328_inserted = true;

atmega328_size = [35.20, 7.87, 3.8];

module atmega328() {
   LEN = atmega328_size.x;
   WID = atmega328_size.y;
   HGT = atmega328_size.z;

   // center on x,y and sitting at z=0
   translate([0,0,atmega328_inserted ? ATMEGA328_PIN_OFFSET - 0.9 : -0.9])
   rotate([180,0,0])
   import("components/atmega328.stl");
}
//-------------------------------------------------------------------------------------------------

