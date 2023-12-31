1000 '#########################################################################
1010 '
1020 'MEVIOUS, Fujitsu FM-7, September 19, 2023, ported by KUSHIKATSU.
1030 '
1040 'MEVIOUS, NEC PC-8001, Micom BASIC Magazine, Sep. 1983.
1050 'Ported the original PC-8001 version by Mr. Yoshinao Mori to FM-7
1060 'The FM-7 version is much slower because of the difference between
1070 'the FM-7 without text VRAM, and the PC-8001 with it.
1080 '
1090 'YouTube: https://www.youtube.com/channel/UC8-RK6KfuLMHC85hlQfQzxg
1100 'X(Twitter): https://twitter.com/KushikatsuKushi
1110 '
1120 '#########################################################################
1130 '
1140 '#### Explanation
1150 COLOR 7,0:CLS
1160 PRINT "MEVIOUS"
1170 PRINT
1180 PRINT "Operation:"
1190 PRINT "2 key to move down,"
1200 PRINT "4 key to move left,"
1210 PRINT "5 key to stop,"
1220 PRINT "6 key to move right,"
1230 PRINT "8 key to move up."
1240 PRINT
1250 PRINT "Push spacebar to start game."
1260 IF INKEY$<>" " THEN 1260
1270 '#### Initialize
1280 WIDTH 40,25:CONSOLE 3,22,0,0:COLOR 4,0:'#### If speeding up, CONSOLE 3,22,0,0 -> 0,25,0,0
1290 DEFINT A-Z:X=20:Y=7:VX=20:VY=24
1300 B$(0)=CHR$(&HE4)+CHR$(&H87)+CHR$(&HE5):'#### Obstacle 1, BACURA
1310 B$(1)=CHR$(&HE4)+CHR$(&HEF):'#### Obstacle 2, BARRA, upper part
1320 B$(2)=CHR$(&HEF)+CHR$(&HEE):'#### Obstacle 2, BARRA, lower part
1330 '#### Title
1340 LINE( 1,0)-(37, 2),"=",1,B
1350 LINE( 0,0)-( 0, 2),"+",4,B
1360 LINE(38,0)-(38, 2),"+",4,B
1370 LOCATE 16,1:COLOR 5:PRINT "MEVIOUS"
1380 '#### Background
1390 LINE( 0,3)-(38,23),"+",4,BF
1400 '#### Main
1410 FOR T=0 TO 1500
1420 LOCATE 0,23:COLOR 4:PRINT CHR$(31)+STRING$(39,"+")
1430 LX=RND(1)*36:COLOR 5
1440 IF (T MOD 2)=0 THEN LOCATE LX,23:PRINT B$(0)
1450 IF (T MOD 2)=1 THEN LOCATE LX,23:PRINT B$(1):LXX=LX:FL=1
1460 IF ((T MOD 2)=0) AND (FL=1) THEN LOCATE LXX,23:PRINT B$(2):FL=0
1470 LOCATE X,Y-1:COLOR 4:PRINT "+"
1480 I$=INKEY$
1490 IF I$="2" THEN DY=1
1500 IF I$="4" THEN DX=-1
1510 IF I$="6" THEN DX=1
1520 IF I$="8" THEN DY=-1
1530 IF I$="5" THEN DX=0:DY=0
1540 X=X+DX+(X>37)-(X<1)
1550 Y=Y+DY+(Y>22)-(Y<5)
1560 IF CHR$(SCREEN(X,Y))<>"+" THEN GOTO 1640
1570 LOCATE X,Y:COLOR 7:PRINT CHR$(&HE9):VY=VY-2:'#### You, SOLVALOU
1580 LOCATE VX,VY+1:COLOR 4:PRINT"+"
1590 VX=VX+SGN(X-VX):C=6+(C=6)*4
1600 LOCATE VX,VY:COLOR C:PRINT CHR$(&HED);'#### Enemy, ZAKATO
1610 IF VY<5 THEN VY=24:VX=RND(1)*38
1620 S=S+Y:BEEP 1:BEEP 0:NEXT T
1630 '#### Ending
1640 LOCATE 14,10:PRINT S*10;"pts."
1650 IF INKEY$<>" " THEN 1650 ELSE RUN
