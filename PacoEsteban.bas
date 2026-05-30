
   dim _BitOp_01 = y ; generic purporse
   dim _Bit0_Reset = y ;Store reset button value

  ; Playfield limits for sprites
   const Top = 10
   const Bottom = 90
   const Left = 1
   const Right = 152

__Start_Restart

  ;Muting audio
   AUDV0 = 0 : AUDV1 = 0
   COLUPF = $2C ;Set our text colour
   COLUBK = 0   ;Set our bacground colour
  

  ;The og Atari2600 has a resset switch, we will just 
   _Bit0_Reset{0} = 1


  ;Sprites 1 and 0 initial positions
   player0x = 77 : player0y = 53
   player1x = 69 : player1y = 53
  
  ;Defining the sprites
   player0:
   %00000000
   %00011000
   %00011000
   %11111111
   %11111111
   %11111110
   %11111100
   %01010000
end
   player1:
   %00000000
   %00000110
   %00000110
   %11111111
   %10111111
   %11111111
   %00011111
   %00010101
end

 ;Drawing the text using the backgroun
   playfield:
   ................................
   ................................
   ....XXX...X...XX..XX............
   ....X.X..X.X.X...X..X...........
   ....XX...XXX.X...X..X...........
   ....X....X.X..XX..XX............
   .XX..XX.XXX.XX.XXX..............
   .X...X...X..X..X.X..X..X...X....
   .XX..X...X..XX.XX..X.X.XX..X...
   .X...X...X..X..X.X.XXX.X.X.X....
   .XX.XX...X..XX.XX..X.X.X..XX....
end

__Main_Loop
   COLUP1 = $9C ;Set our sprites colours
   COLUP0 = $9C

  
   if joy0up && player0y > Top then player0y = player0y - 1

   if joy0down && player0y < Bottom then player0y = player0y + 1

   if joy0left && player1x > Left then player0x = player0x - 1

   if joy0right && player0x < Right then player1x = player1x + 1
   if joy0right &&  player0x < Right then player0x = player0x + 1

   if joy0up && player1y > Top then player1y = player1y - 1

   if joy0down && player1y < Bottom then player1y = player1y + 1

   if joy0left && player1x > Left then player1x = player1x - 1

   drawscreen

  ;Back to the begining of the loop
   if _Bit0_Reset{0} then goto __Main_Loop

