10200 screen 5,2
10210 for i=0 to 5:sp$=""
	10220 for j=0 to 31
		10230 read a$
		10240 sp$=sp$+chr$(val(a$))
	10250 next J
	10260 sprite$(i)=sp$
10270 next i
10280 for i=0 to 5:sp$=""
	10290 for j=0 to 15
		10300 read a$
		10310 sp$=sp$+chr$(val(a$))
	10320 next J
	10330 color sprite$(i)=sp$
10340 next I
10350 rem sprites data definitions
10360 rem data definition sprite 0, name: Sprite_name0
10360 data 0,0,0,0,0,255,223,255
10370 data 255,255,31,127,124,0,0,0
10380 data 0,0,0,0,0,240,240,255
10390 data 255,252,224,192,0,0,0,0
10400 rem data definition sprite 1, name: Sprite_name1
10400 data 0,0,0,0,0,0,0,0
10410 data 0,3,7,15,63,127,127,20
10420 data 0,0,0,0,0,0,0,0
10430 data 0,224,112,120,252,254,252,60
10440 rem data definition sprite 2, name: Sprite_name2
10440 data 1,1,3,7,15,15,3,3
10450 data 3,3,3,3,3,7,7,7
10460 data 128,192,224,240,248,248,96,96
10470 data 96,96,96,96,96,112,112,240
10480 rem data definition sprite 3, name: Sprite_name3
10480 data 0,0,0,0,0,0,0,0
10490 data 0,255,255,255,255,239,255,255
10500 data 0,0,0,0,0,0,0,0
10510 data 0,255,255,255,247,247,255,255
10520 rem data definition sprite 4, name: Sprite_name4
10520 data 3,7,7,7,15,15,7,0
10530 data 0,0,0,0,0,255,255,255
10540 data 224,248,252,252,252,252,248,192
10550 data 192,192,192,192,192,255,255,255
10560 rem data definition sprite 5, name: Sprite_name5
10560 data 0,0,126,63,31,7,1,7
10570 data 1,15,15,31,56,0,0,0
10580 data 0,0,0,224,240,240,134,254
10590 data 134,240,224,128,0,64,0,0
10600 rem data colors definitions sprite 0, name: Sprite_name0
10600 data 0,0,0,0,0,10,10,7,7,8,8,8,8,8,8,8
10610 rem data colors definitions sprite 1, name: Sprite_name1
10610 data 0,0,0,0,0,0,0,0,0,8,5,5,6,6,6,6
10620 rem data colors definitions sprite 2, name: Sprite_name2
10620 data 7,7,7,7,7,7,14,14,14,14,14,14,14,13,13,8
10630 rem data colors definitions sprite 3, name: Sprite_name3
10630 data 0,0,0,0,0,0,0,0,0,6,9,9,8,8,8,8
10640 rem data colors definitions sprite 4, name: Sprite_name4
10640 data 3,3,3,3,3,3,3,3,3,6,9,9,8,8,8,8
10650 rem data colors definitions sprite 5, name: Sprite_name5
10650 data 0,0,12,3,3,3,13,9,13,3,3,3,12,12,12,12
10660 put sprite 0,(20*0,100),,0
10670 put sprite 1,(20*1,100),,1
10680 put sprite 2,(20*2,100),,2
10690 put sprite 3,(20*3,100),,3
10700 put sprite 4,(20*4,100),,4
10710 put sprite 5,(20*5,100),,5
10720 goto 10720
