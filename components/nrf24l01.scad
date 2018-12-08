/* 
*  Open SCAD Name.: nrf24l01.scad
*  Copyright (c)..: 2018 John Oliva
*
*  Creation Date..: 08/14/2018
*  Description....: nRF24L01 radio board
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
// NRF24L01 RADIO BOARD
//-------------------------------------------------------------------------------------------------
RADIO_SOCKET_OFFSET = 2.5;
RADIO_PIN_OFFSET = 2.0;
radio_inserted = true;

nrf24l01_brd_size = [29,15,4.4];

module nrf24l01_brd() {
   LEN = nrf24l01_brd_size.x;
   WID = nrf24l01_brd_size.y;
   HGT = nrf24l01_brd_size.z;

   // center on x,y and sitting at z=0
   translate([0,0,radio_inserted ? RADIO_SOCKET_OFFSET + RADIO_PIN_OFFSET + .55 : .55])
   rotate([90,0,0])
   import("components/nRF24L01.stl");
}
//-------------------------------------------------------------------------------------------------


