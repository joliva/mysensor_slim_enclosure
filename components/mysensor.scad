/* 
*  Open SCAD Name.: mysensor.scad
*  Copyright (c)..: 2018 John Oliva
*
*  Creation Date..: 08/14/2018
*  Description....: MySensor board (populated)
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

include<mysensor_bare_brd.scad>
include<nrf24l01.scad>
include<dip28_socket.scad>
include<atmega328.scad>

//-------------------------------------------------------------------------------------------------
// MYSENSOR BOARD
//-------------------------------------------------------------------------------------------------
mysensor_size = [69.1,15.2,11.6]; 

module mysensor(bbox=false) {
   LEN = mysensor_size.x;
   WID = mysensor_size.y;
   HGT = mysensor_size.z;

   RADIO_BRD_OFFSET = 10.5;
   DIP28_SOCKET_OFFSET = 3.5;
   DIP28_OFFSET = 5;
   ATMEGA328_OFFSET = 3.5;

   color("red") mysensor_bare_brd();

   radio_offset =  mysensor_bare_brd_size.x/2 + nrf24l01_brd_size.x/2 - RADIO_BRD_OFFSET; 
   color("sienna") translate([radio_offset,0,0]) nrf24l01_brd();

   dip28_offset_x =  -DIP28_SOCKET_OFFSET;
   dip28_offset_z =  mysensor_bare_brd_size.z;
   color("gray") translate([dip28_offset_x,0,dip28_offset_z]) dip28_socket();

   atmega328_offset_x =  -ATMEGA328_OFFSET;
   atmega328_offset_z =  mysensor_bare_brd_size.z + dip28_socket_size.z + 1.6;
   color("darkslategray") translate([atmega328_offset_x,0,atmega328_offset_z]) atmega328();

   if (bbox) {
         %translate([9.24,0.01,4.2]) cube([LEN,WID,HGT], center=true);
   }
}
//-------------------------------------------------------------------------------------------------
