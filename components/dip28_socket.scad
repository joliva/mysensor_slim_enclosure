/* 
*  Open SCAD Name.: dip28_socket.scad
*  Copyright (c)..: 2018 John Oliva
*
*  Creation Date..: 08/14/2018
*  Description....: 28 pin DIP socket
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
// DIP28 SOCKET
//-------------------------------------------------------------------------------------------------
DIP28_SOCKET_OFFSET = 1.35;
DIP28_PIN_OFFSET = 0.5;
dip28_inserted = true;

dip28_socket_size = [35.60, 10.16, 2.8];

module dip28_socket() {
   LEN = dip28_socket_size.x;
   WID = dip28_socket_size.y;
   HGT = dip28_socket_size.z;

   // center on x,y and sitting at z=0
   translate([1.94,30.29 + WID/2,dip28_inserted ? DIP28_SOCKET_OFFSET + DIP28_PIN_OFFSET - 17.08 : -17.08])
   //translate([1.94,30.29 + WID/2,-17.08])
   rotate([90,0,0])
   import("components/dip28_socket.stl");
}
//-------------------------------------------------------------------------------------------------

