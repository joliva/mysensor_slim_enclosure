/* 
*  Open SCAD Name.: magnetic_contact.scad
*  Copyright (c)..: 2018 John Oliva
*
*  Creation Date..: 08/13/2018
*  Description....: TANE-60 QC magnetic contact
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
// MAGNETIC CONTACT
//-------------------------------------------------------------------------------------------------
MAG_CT_ADHESIVE_HEIGHT = 1.2;
magnetic_contact_adhesive = true;
magnetic_contact_size = [50.8, 9.5, magnetic_contact_adhesive ? 8.3 + MAG_CT_ADHESIVE_HEIGHT : 8.3];

module magnetic_contact(color="gold", bbox=false) {
   if (bbox) {
         _magnetic_contact(bbox);
   } else {
         color(color) _magnetic_contact();
   }
}

module _magnetic_contact(bbox) {
   // TANE-60 QC type

   LEN_LOW = magnetic_contact_size.x;
   LEN_HIGH = 38;
   HGT_LOW = magnetic_contact_adhesive ? 1.2 + MAG_CT_ADHESIVE_HEIGHT : 1.2;
   HGT_HIGH = magnetic_contact_size.z;
   WID = magnetic_contact_size.y;
   HOLE_CTR_TO_CTR = 45;
   HOLE_DIA=3.2;
   
   $fn=32;

   difference() {
      union() {
         translate([0,0,HGT_LOW/2]) cube([LEN_LOW,WID,HGT_LOW], center=true);  // bottom
         translate([0,0,HGT_HIGH/2]) cube([LEN_HIGH,WID,HGT_HIGH], center=true);  // bottom
      }

      translate([HOLE_CTR_TO_CTR/2,0,0]) cylinder(h=3*HGT_HIGH, d=HOLE_DIA, center=true);
      translate([-HOLE_CTR_TO_CTR/2,0,0]) cylinder(h=3*HGT_HIGH, d=HOLE_DIA, center=true);
   }

   if (bbox) {
         %translate([0,0,HGT_HIGH/2]) cube([LEN_LOW,WID,HGT_HIGH], center=true);
   }
}
//-------------------------------------------------------------------------------------------------

