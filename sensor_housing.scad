/* 
*  Open SCAD Name.: sensor_housing.scad
*  Copyright (c)..: 2018 John Oliva
*
*  Creation Date..: 08/13/2018
*  Last Modified..: 08/27/2018
*  Description....: Contact sensor housing
*  Version........: 2.2
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

use<BOSL/masks.scad>
use<ruler.scad>

include<components/magnetic_contact.scad>
include<components/battery_holder.scad>
include<components/mysensor.scad>

//-------------------------------------------------------------------------------------------------
// Customizer settings
//-------------------------------------------------------------------------------------------------

// Include box 
BOX_EN = true;

// Include lid 
LID_EN = true;

// Enable electronics rendering for design placement
ELECTRONICS_EN = false;

// Transparent box 
BOX_TRANS = false;

// Transparent lid 
LID_TRANS = false;

// Edge Box
BOX_EDGING = "chamfer";  // ["none", "fillet", "chamfer"]

// Engraving, line 1
ENGRAVE_L1 = "sensor housing";

// Engraving, line 2
ENGRAVE_L2 = "version 2.2, 2018";

// Engraving size
ENGRAVE_SIZE = 7;

// Enable rulers for design placement
RULERS_EN = false;

// Enable lid vents
LID_VENTS = false;

// Tolerance between lid and box bottom
TOLERANCE = .08;
//-------------------------------------------------------------------------------------------------

WALL_SIZE = 1.2*1;                     // hide from customizer
EDGE_DETAIL_SIZE = 1*1;                // hide from customizer
BOX_HEIGHT = 22*1;                     // hide from customizer
BBOX_EN = false && false;              // hide from customizer
LID_HEIGHT = 2*1;                      // hide from customizer
BAT_OFFSET_Y = WALL_SIZE*1;            // hide from customizer

BOX_LENGTH = 117.15 + WALL_SIZE + 2;
BOX_WIDTH = 34.75 + WALL_SIZE + BAT_OFFSET_Y + 2.5;

if (RULERS_EN) {
   translate([0,-.1,0]) xrulerSae();
   translate([-.1,0,0]) yrulerSae();
   translate([0,0,0])   zrulerSae();
}

//color("red") cube([50,50,.001],center=true);

//-------------------------------------------------------------------------------------------------
// Conditional Color Transform
//-------------------------------------------------------------------------------------------------
module cond_color(color="gold",enable=false,transparent=false,disable=false) {
   // disable > transparent > enable
   if (disable == true) {
      *children();
   } else if (transparent == true) {
      color("gray",.3) children();  // transparent(%) doesn't work here
   } else if (enable == true) {
      color(color) children();
   } else {
      children();
   }
}
//-------------------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------------------
// Text engraver transform - applied to bottom of box
//-------------------------------------------------------------------------------------------------
module engrave_text(dims_xy, offset_xy=[0,0], txt="Test text string", size=2, depth=0.5) {
    font = "Stone Sans ITC TT:style=Bold";

    difference() {
        children(0);

        translate([dims_xy.x/2+offset_xy.x,3*dims_xy.y/5+offset_xy.y,-.001])
        mirror([1,0,0])
        linear_extrude(depth)
        text(txt, font=font, size=size, halign="center", valign="center", spacing=1.0);
    }
}
//-------------------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------------------
// Box edging, types = chamfer or fillet
//-------------------------------------------------------------------------------------------------
module box_edging(type="chamfer",size=3, dims=[10,10,10], offset=[0,0,0]) {
    difference() {
        children(0);

        translate(offset) {
            // z-axis, p=[x,y]
            for (p = [[0,0],[dims.x,0],[dims.x,dims.y],[0,dims.y]]) {
                if (type == "fillet") {
                    translate([p.x,p.y,0]) fillet_mask_z(l=2*dims.z+0.1, r=size);
                } else {
                    translate([p.x,p.y,0]) chamfer_mask_z(l=2*dims.z+0.1, chamfer=size);
                }
            }

            // x-axis, p=[y,z]
            for (p = [[0,0],[dims.y,0],[dims.y,dims.z],[0,dims.z]]) {
                if (type == "fillet") {
                    translate([0,p.x,p.y]) fillet_mask_x(l=2*dims.x+0.1, r=size);
                } else {
                    translate([0,p.x,p.y]) chamfer_mask_x(l=2*dims.x+0.1, chamfer=size);
                }
            }

            // y-axis, p=[x,z]
            for (p = [[0,0],[dims.x,0],[dims.x,dims.z],[0,dims.z]]) {
                if (type == "fillet") {
                    translate([p.x,0,p.y]) fillet_mask_y(l=2*dims.y+0.1, r=size);
                } else {
                    translate([p.x,0,p.y]) chamfer_mask_y(l=2*dims.y+0.1, chamfer=size);
                }
            }
        }
    }
}
//-------------------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------------------
// COMPONENTS
//-------------------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------------------
// Box bottom
//-------------------------------------------------------------------------------------------------
module box_bottom(size=[50,50,50], wall=1) {
	module top_chamfers(dims=[10,10,10],size=2) {
	    module top_chamfer() {
	        points=[[0,0],[0,size],[size,size]];
	
	        translate([0,dims.y/2-size,dims.z])
	        rotate([0,90,0])
	        linear_extrude(dims.x)
	        polygon(points);
	    }
	
	    translate([0,dims.y/2,0]) {
	        top_chamfer();
	        mirror([0,1,0]) top_chamfer();
	    }
	}

   // box with opening in top accepting dove-tailed lid
   difference() {
      // box with top fillets
	   union() {
         // empty box closed on all sides
		   difference() {
		      cube([size.x, size.y, size.z]);
		
		      translate([wall, wall, wall]) cube([size.x-2*wall, size.y-2*wall, size.z-2*wall+.001]);
		   }
	
	      top_chamfers(dims=size, size=LID_HEIGHT+3*WALL_SIZE);
	   }

      // hole for optionally passing through wires to external contact
      translate([size.x/3,size.y,size.z - 6*wall])
         rotate([90,0,0]) 
            cylinder(d=3.0, h=4*wall, center=true);

      placed_lid(offset=off_lid,edging=BOX_EDGING,tolerance=0);
   }
}
//-------------------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------------------
// Dove-tail lid
//-------------------------------------------------------------------------------------------------
module lid(size=[100,40,2]) {
   module add_vents(enabled) {
      if (enabled == true) {
         offset = [-size.x/2, -size.y/2, 0];

         difference() {
            children(0);
            union() {
               for (row = [1:5]) {
                  for (col = [1:5]) {
                     translate([offset.x + (col+0)*size.y/8,offset.y + row*size.x/20,0])
                        cylinder(h=3*size.z,d=2,center=true);
                     translate([offset.x + (col+20)*size.y/8,offset.y + row*size.x/20,0])
                        cylinder(h=3*size.z,d=2,center=true);
                  }
               }
            }
         }
      } else {
         children(0);
      }
   }

   hdiv2 = size.z/2;
   points = [[0,0],[size.y,0],[size.y,hdiv2],[size.y-hdiv2,size.z],[hdiv2,size.z],[0,hdiv2]];
   
   add_vents(LID_VENTS)
      rotate([90,0,90])
         linear_extrude(size.x, center=true) 
            translate([-size.y/2,0])
               polygon(points);
}
//-------------------------------------------------------------------------------------------------

module placed_battery_holder(offset=[0,0,0]) {
      translate(offset)
         battery_holder(color="blue", clips_en=ELECTRONICS_EN, bbox=BBOX_EN);
}

module placed_magnetic_contact(offset=[0,0,0]) {
   if (ELECTRONICS_EN)
      translate(offset)
         magnetic_contact(color="white", bbox=BBOX_EN);
}

module placed_mysensor(offset=[0,0,0]) {
   if (ELECTRONICS_EN)
      translate(offset) 
         mysensor(bbox=BBOX_EN);
}

module placed_adhesive(offset=[0,0,0]) {
   if (ELECTRONICS_EN)
      color("white")
         translate(offset)
            cube([mysensor_bare_brd_size.x/2, mysensor_bare_brd_size.y, 1.5]);
}

module placed_support(offset=[0,0,0]) {
   // extend from battery holder to internal wall
   size_y = BOX_WIDTH - WALL_SIZE - battery_holder_size.y - BAT_OFFSET_Y + .001;

   color("blue")
      translate(offset)
         cube([mysensor_bare_brd_size.x/2, size_y, 3.5 + .5]);
}

module placed_box_bottom(offset=[0,0,0], edging="none") {
   size = [BOX_LENGTH, BOX_WIDTH, BOX_HEIGHT];

   d=2/3;
   engrave_text(size, txt=ENGRAVE_L1, size=ENGRAVE_SIZE, depth=d)
   engrave_text(size, offset_xy=[0,-1.6*ENGRAVE_SIZE], txt=ENGRAVE_L2, size=ENGRAVE_SIZE, depth=d) {
	   if (BOX_EDGING != "none") {
		   $fn = 64;
		
	      translate(offset)
	         box_edging(type=edging, size=EDGE_DETAIL_SIZE, dims=[BOX_LENGTH, BOX_WIDTH, BOX_HEIGHT])
	            box_bottom(size=[BOX_LENGTH,BOX_WIDTH,BOX_HEIGHT], wall=WALL_SIZE);
	   } else {
	      translate(offset)
	         box_bottom(size=[BOX_LENGTH,BOX_WIDTH,BOX_HEIGHT], wall=WALL_SIZE);
	   }
   }
}

module placed_lid(offset=[0,0,0], edging="none", tolerance=0) {
   fit_adjust_x = (tolerance == 0) ? 0 : 0.4;   // reduce length by 400 um for better fit
   lid_dims = [BOX_LENGTH-WALL_SIZE - fit_adjust_x, BOX_WIDTH-3*WALL_SIZE-tolerance, LID_HEIGHT-tolerance];

   module edged_lid(dims, type) {
      difference() {
         lid(dims);

	      $fn = 64;

         if (type == "chamfer") {
            translate([dims.x/2,0,dims.z]) chamfer_mask_y(l=2*dims.y+0.1, chamfer=EDGE_DETAIL_SIZE);
         } else {
            translate([dims.x/2,0,dims.z]) fillet_mask_y(l=2*dims.y+0.1, r=EDGE_DETAIL_SIZE);
         }
      }
   }

   // box with engraved text
   d=2/3;
   engrave_text(lid_dims, offset_xy=[0, lid_dims.y/20, 0], txt=ENGRAVE_L1, size=ENGRAVE_SIZE-2, depth=d)
   engrave_text(lid_dims, offset_xy=[0,-1.0*ENGRAVE_SIZE], txt=ENGRAVE_L2, size=ENGRAVE_SIZE-2, depth=d) {
      if (edging != "none") {
         translate(offset) edged_lid(dims=lid_dims, type=edging);
      } else {
         translate(offset) lid(lid_dims);
      }
   }
}
//-------------------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------------------
// OFFSETS
//-------------------------------------------------------------------------------------------------
internal_wall_y = BOX_WIDTH - WALL_SIZE;

off_battery =  [  battery_holder_size.x/2 + 4.1 + .001,
                  battery_holder_size.y/2 + BAT_OFFSET_Y + .001,
                  .5 ];
off_contact =  [  magnetic_contact_size.x/2 + WALL_SIZE + 1,
                  internal_wall_y - magnetic_contact_size.y/2,
                  WALL_SIZE ];
off_mysensor = [  magnetic_contact_size.x+mysensor_bare_brd_size.x/2 + WALL_SIZE - 4,
                  internal_wall_y - mysensor_bare_brd_size.y/2,
                  5+WALL_SIZE ];
off_adhesive = [  magnetic_contact_size.x+mysensor_bare_brd_size.x/2 + WALL_SIZE - 16,
                  internal_wall_y - mysensor_bare_brd_size.y,
                  3.5+WALL_SIZE ];
off_support =  [  magnetic_contact_size.x+mysensor_bare_brd_size.x/2 + WALL_SIZE- 16,
                  battery_holder_size.y + BAT_OFFSET_Y,
                  WALL_SIZE - .5 ];
off_bottom =   [  0,
                  0,
                  0 ];
off_lid =      [  (BOX_LENGTH-WALL_SIZE)/2 + WALL_SIZE + .001,
                  BOX_WIDTH/2,
                  BOX_EN ? BOX_HEIGHT-LID_HEIGHT + .001 : 0 ]; // no Z offset if box is not enabled
//-------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------------------
// PLACE COMPONENTS
//-------------------------------------------------------------------------------------------------
if (BOX_EN == true) {
	cond_color(color="gold", enable=false, transparent=false, disable=false)
	   placed_battery_holder(off_battery);
	
	cond_color(color="blue", enable=false, transparent=false, disable=false)
	   placed_support(off_support);
	
	cond_color(color="gold", enable=false, transparent=BOX_TRANS, disable=false)
	   placed_box_bottom(off_bottom, BOX_EDGING);
}

if (ELECTRONICS_EN == true) {
	cond_color(color="gold", enable=false, transparent=false, disable=false)
	   placed_magnetic_contact(off_contact);
	
	cond_color(color="gold", enable=false, transparent=false, disable=false)
	   placed_mysensor(off_mysensor);
	
	cond_color(color="gold", enable=false, transparent=false, disable=false)
	   placed_adhesive(off_adhesive);
}

if (LID_EN == true) {
   // don't offset lid in Z direction if box is not enabled
   if (BOX_EN == false) { off_lid = [off_lid.x, off_lid.y, 0]; }

   cond_color(color="gold", enable=false, transparent=LID_TRANS, disable=false)
      placed_lid(offset=off_lid,edging=BOX_EDGING,tolerance=TOLERANCE);
}

//-------------------------------------------------------------------------------------------------


