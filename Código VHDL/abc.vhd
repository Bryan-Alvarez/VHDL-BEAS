LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY abc IS
	PORT(LETRA: IN INTEGER RANGE 0 TO 26;
	       SEG: OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END abc;

ARCHITECTURE BEAS OF abc IS
BEGIN
	
	WITH LETRA SELECT
		 SEG <= "00010001" WHEN 0, -- A
				  "11000001" WHEN 1, -- b
				  "01100001" WHEN 2, -- C
				  "10000101" WHEN 3, -- d
				  "01100001" WHEN 4, -- E
				  "01110001" WHEN 5, -- F
				  "01000001" WHEN 6, -- G
				  "11010001" WHEN 7, -- H
				  "10011111" WHEN 8, -- I
				  "10000111" WHEN 9, -- J
				  "01010001" WHEN 10, -- K
				  "11100011" WHEN 11, -- L
				  "01101101" WHEN 12, -- M
				  "00010011" WHEN 13, -- n
				  "01010101" WHEN 14, -- ñ
				  "11000101" WHEN 15, -- o
				  "00110001" WHEN 16, -- P
				  "00011001" WHEN 17, -- q
				  "11110101" WHEN 18, -- r
				  "01001001" WHEN 19, -- S
				  "11100001" WHEN 20, -- t
				  "10000011" WHEN 21, -- U
				  "10111001" WHEN 22, -- v
				  "01000111" WHEN 23, -- w
				  "10010001" WHEN 24, -- X
				  "10001001" WHEN 25, -- Y
				  "00100101" WHEN 26, -- Z
				  "11111111" WHEN OTHERS; -- Apaga todo si la entrada no es válida 
	
END BEAS;