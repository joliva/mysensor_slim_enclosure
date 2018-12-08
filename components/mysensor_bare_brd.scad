/* 
*  Open SCAD Name.: mysensor_bare_brd.scad
*  Copyright (c)..: 2018 John Oliva
*
*  Creation Date..: 08/14/2018
*  Description....: MySensor bare board 
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
// MYSENSOR BARE BOARD
//-------------------------------------------------------------------------------------------------
mysensor_bare_brd_size = [50.6, 15.2, 1.0];

module mysensor_bare_brd() {
   LEN = mysensor_bare_brd_size.x;
   WID = mysensor_bare_brd_size.y;
   HGT = mysensor_bare_brd_size.z;

   // center on x,y and sitting at z=0
   translate([LEN/2,-WID/2,0]) 
   rotate([90,0,0])
   import("components/mysensors_slim_aa_node_board.stl");
}
//-------------------------------------------------------------------------------------------------

