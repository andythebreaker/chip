/*

MIT License

Copyright (c) 2020 Debtanu Mukherjee

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
東 - East
西 - West
南 - South
北 - North
*/

`include "block.v"
module systolic_array(inp_west0, inp_west9, inp_west18, inp_west27, inp_west36, inp_west45, inp_west54, inp_west63, inp_west72,
		      inp_north0, inp_north1, inp_north2, inp_north3, inp_north4, inp_north5, inp_north6, inp_north7, inp_north8,
		      clk, rst, done);
	
	input [3:0] inp_west0, inp_west9, inp_west18, inp_west27, inp_west36, inp_west45, inp_west54, inp_west63, inp_west72,
		      inp_north0, inp_north1, inp_north2, inp_north3, inp_north4, inp_north5, inp_north6, inp_north7, inp_north8;
	output reg done;
	input clk, rst;
	reg [3:0] count;
	
	
	
	wire [3:0] inp_west0, inp_west9, inp_west18, inp_west27, inp_west36, inp_west45, inp_west54, inp_west63, inp_west72;
	wire [3:0] inp_north0, inp_north1, inp_north2, inp_north3, inp_north4, inp_north5, inp_north6, inp_north7, inp_north8;
	wire [3:0] outp_south0, outp_south1, outp_south2, outp_south3, outp_south4, outp_south5, outp_south6, outp_south7, outp_south8, outp_south9, outp_south10, outp_south11, outp_south12, outp_south13, outp_south14, outp_south15, outp_south16, outp_south17, outp_south18, outp_south19, outp_south20, outp_south21, outp_south22, outp_south23, outp_south24, outp_south25, outp_south26, outp_south27, outp_south28, outp_south29, outp_south30, outp_south31, outp_south32, outp_south33, outp_south34, outp_south35, outp_south36, outp_south37, outp_south38, outp_south39, outp_south40, outp_south41, outp_south42, outp_south43, outp_south44, outp_south45, outp_south46, outp_south47, outp_south48, outp_south49, outp_south50, outp_south51, outp_south52, outp_south53, outp_south54, outp_south55, outp_south56, outp_south57, outp_south58, outp_south59, outp_south60, outp_south61, outp_south62, outp_south63, outp_south64, outp_south65, outp_south66, outp_south67, outp_south68, outp_south69, outp_south70, outp_south71, outp_south72, outp_south73, outp_south74, outp_south75, outp_south76, outp_south77, outp_south78, outp_south79, outp_south80 ;
	wire [3:0] outp_east0, outp_east1, outp_east2, outp_east3, outp_east4, outp_east5, outp_east6, outp_east7, outp_east8, outp_east9, outp_east10, outp_east11, outp_east12, outp_east13, outp_east14, outp_east15, outp_east16, outp_east17, outp_east18, outp_east19, outp_east20, outp_east21, outp_east22, outp_east23, outp_east24, outp_east25, outp_east26, outp_east27, outp_east28, outp_east29, outp_east30, outp_east31, outp_east32, outp_east33, outp_east34, outp_east35, outp_east36, outp_east37, outp_east38, outp_east39, outp_east40, outp_east41, outp_east42, outp_east43, outp_east44, outp_east45, outp_east46, outp_east47, outp_east48, outp_east49, outp_east50, outp_east51, outp_east52, outp_east53, outp_east54, outp_east55, outp_east56, outp_east57, outp_east58, outp_east59, outp_east60, outp_east61, outp_east62, outp_east63, outp_east64, outp_east65, outp_east66, outp_east67, outp_east68, outp_east69, outp_east70, outp_east71, outp_east72, outp_east73, outp_east74, outp_east75, outp_east76, outp_east77, outp_east78, outp_east79, outp_east80;
	wire [15:0] result0, result1, result2, result3, result4, result5, result6, result7, result8, result9, result10, result11, result12, result13, result14, result15, result16, result17, result18, result19, result20, result21, result22, result23, result24, result25, result26, result27, result28, result29, result30, result31, result32, result33, result34, result35, result36, result37, result38, result39, result40, result41, result42, result43, result44, result45, result46, result47, result48, result49, result50, result51, result52, result53, result54, result55, result56, result57, result58, result59, result60, result61, result62, result63, result64, result65, result66, result67, result68, result69, result70, result71, result72, result73, result74, result75, result76, result77, result78, result79, result80;
	
	
	
	//from north and west
	block P0 (inp_north0, inp_west0, clk, rst, outp_south0, outp_east0, result0);
	//from north
	block P1 (inp_north1, outp_east0, clk, rst, outp_south1, outp_east1, result1);
	block P2 (inp_north2, outp_east1, clk, rst, outp_south2, outp_east2, result2);
	block P3 (inp_north3, outp_east2, clk, rst, outp_south3, outp_east3, result3);
	block P4 (inp_north4, outp_east3, clk, rst, outp_south4, outp_east4, result4);
	block P5 (inp_north5, outp_east4, clk, rst, outp_south5, outp_east5, result5);
	block P6 (inp_north6, outp_east5, clk, rst, outp_south6, outp_east6, result6);
	block P7 (inp_north7, outp_east6, clk, rst, outp_south7, outp_east7, result7);
	block P8 (inp_north8, outp_east7, clk, rst, outp_south8, outp_east8, result8);

	//from west
	block P9 (outp_south0, inp_west9, clk, rst, outp_south9, outp_east9, result9);
	block P18 (outp_south9, inp_west18, clk, rst, outp_south18, outp_east18, result18);
	block P27 (outp_south18, inp_west27, clk, rst, outp_south27, outp_east27, result27);
	block P36 (outp_south27, inp_west36, clk, rst, outp_south36, outp_east36, result36);
	block P45 (outp_south36, inp_west45, clk, rst, outp_south45, outp_east45, result45);
	block P54 (outp_south45, inp_west54, clk, rst, outp_south54, outp_east54, result54);
	block P63 (outp_south54, inp_west63, clk, rst, outp_south63, outp_east63, result63);
	block P72 (outp_south63, inp_west72, clk, rst, outp_south72, outp_east72, result72);

	
	//no direct inputs
	//second row
	block P10 (outp_south1, outp_east9, clk, rst, outp_south11, outp_east11, result11);
	block P11 (outp_south2, outp_east10, clk, rst, outp_south12, outp_east12, result12);
	block P12 (outp_south3, outp_east11, clk, rst, outp_south13, outp_east13, result13);
	block P13 (outp_south4, outp_east12, clk, rst, outp_south14, outp_east14, result14);
	block P14 (outp_south5, outp_east13, clk, rst, outp_south15, outp_east15, result15);
	block P15 (outp_south6, outp_east14, clk, rst, outp_south16, outp_east16, result16);
	block P16 (outp_south7, outp_east15, clk, rst, outp_south17, outp_east17, result17);
	block P17 (outp_south8, outp_east16, clk, rst, outp_south18, outp_east18, result18);

	//third row
	block P19 (outp_south10, outp_east18, clk, rst, outp_south19, outp_east19, result19);
	block P20 (outp_south11, outp_east19, clk, rst, outp_south20, outp_east20, result20);
	block P21 (outp_south12, outp_east20, clk, rst, outp_south21, outp_east21, result21);
	block P22 (outp_south13, outp_east21, clk, rst, outp_south22, outp_east22, result22);
	block P23 (outp_south14, outp_east22, clk, rst, outp_south23, outp_east23, result23);
	block P24 (outp_south15, outp_east23, clk, rst, outp_south24, outp_east24, result24);
	block P25 (outp_south16, outp_east24, clk, rst, outp_south25, outp_east25, result25);
	block P26 (outp_south17, outp_east25, clk, rst, outp_south26, outp_east26, result26);

	//fourth row
	block P28 (outp_south19, outp_east27, clk, rst, outp_south28, outp_east28, result28);
	block P29 (outp_south20, outp_east28, clk, rst, outp_south29, outp_east29, result29);
	block P30 (outp_south21, outp_east29, clk, rst, outp_south30, outp_east30, result30);
	block P31 (outp_south22, outp_east30, clk, rst, outp_south31, outp_east31, result31);
	block P32 (outp_south23, outp_east31, clk, rst, outp_south32, outp_east32, result32);
	block P33 (outp_south24, outp_east32, clk, rst, outp_south33, outp_east33, result33);
	block P34 (outp_south25, outp_east33, clk, rst, outp_south34, outp_east34, result34);
	block P35 (outp_south26, outp_east34, clk, rst, outp_south35, outp_east35, result35);

	//fifth row
	block P37 (outp_south28, outp_east36, clk, rst, outp_south37, outp_east37, result37);
	block P38 (outp_south29, outp_east37, clk, rst, outp_south38, outp_east38, result38);
	block P39 (outp_south30, outp_east38, clk, rst, outp_south39, outp_east39, result39);
	block P40 (outp_south31, outp_east39, clk, rst, outp_south40, outp_east40, result40);
	block P41 (outp_south32, outp_east40, clk, rst, outp_south41, outp_east41, result41);
	block P42 (outp_south33, outp_east41, clk, rst, outp_south42, outp_east42, result42);
	block P43 (outp_south34, outp_east42, clk, rst, outp_south43, outp_east43, result43);
	block P44 (outp_south35, outp_east43, clk, rst, outp_south44, outp_east44, result44);

	//sixth row
	block P46 (outp_south37, outp_east45, clk, rst, outp_south46, outp_east46, result46);
	block P47 (outp_south38, outp_east46, clk, rst, outp_south47, outp_east47, result47);
	block P48 (outp_south39, outp_east47, clk, rst, outp_south48, outp_east48, result48);
	block P49 (outp_south40, outp_east48, clk, rst, outp_south49, outp_east49, result49);
	block P50 (outp_south41, outp_east49, clk, rst, outp_south50, outp_east50, result50);
	block P51 (outp_south42, outp_east50, clk, rst, outp_south51, outp_east51, result51);
	block P52 (outp_south43, outp_east51, clk, rst, outp_south52, outp_east52, result52);
	block P53 (outp_south44, outp_east52, clk, rst, outp_south53, outp_east53, result53);

	//seventh row
	block P55 (outp_south46, outp_east54, clk, rst, outp_south55, outp_east55, result55);
	block P56 (outp_south47, outp_east55, clk, rst, outp_south56, outp_east56, result56);
	block P57 (outp_south48, outp_east56, clk, rst, outp_south57, outp_east57, result57);
	block P58 (outp_south49, outp_east57, clk, rst, outp_south58, outp_east58, result58);
	block P59 (outp_south50, outp_east58, clk, rst, outp_south59, outp_east59, result59);
	block P60 (outp_south51, outp_east59, clk, rst, outp_south60, outp_east60, result60);
	block P61 (outp_south52, outp_east60, clk, rst, outp_south61, outp_east61, result61);
	block P62 (outp_south53, outp_east61, clk, rst, outp_south62, outp_east62, result62);
	//eighth row
	block P64 (outp_south55, outp_east63, clk, rst, outp_south64, outp_east64, result64);
	block P65 (outp_south56, outp_east64, clk, rst, outp_south65, outp_east65, result65);
	block P66 (outp_south57, outp_east65, clk, rst, outp_south66, outp_east66, result66);
	block P67 (outp_south58, outp_east66, clk, rst, outp_south67, outp_east67, result67);
	block P68 (outp_south59, outp_east67, clk, rst, outp_south68, outp_east68, result68);
	block P69 (outp_south60, outp_east68, clk, rst, outp_south69, outp_east69, result69);
	block P70 (outp_south61, outp_east69, clk, rst, outp_south70, outp_east70, result70);
	block P71 (outp_south62, outp_east70, clk, rst, outp_south71, outp_east71, result71);
	//nineth row
	block P73 (outp_south64, outp_east72, clk, rst, outp_south73, outp_east73, result73);
	block P74 (outp_south65, outp_east73, clk, rst, outp_south74, outp_east74, result74);
	block P75 (outp_south66, outp_east74, clk, rst, outp_south75, outp_east75, result75);
	block P76 (outp_south67, outp_east75, clk, rst, outp_south76, outp_east76, result76);
	block P77 (outp_south68, outp_east76, clk, rst, outp_south77, outp_east77, result77);
	block P78 (outp_south69, outp_east77, clk, rst, outp_south78, outp_east78, result78);
	block P79 (outp_south70, outp_east78, clk, rst, outp_south79, outp_east79, result79);
	block P80 (outp_south71, outp_east79, clk, rst, outp_south80, outp_east80, result80);
	
	always @(posedge clk or posedge rst) begin
		if(rst) begin
			done <= 0;
			count <= 0;
		end
		else begin
			if(count == 9) begin
				done <= 1;
				count <= 0;
			end
			else begin
				done <= 0;
				count <= count + 1;
			end
		end	
	end 
	
		      
endmodule
		      
