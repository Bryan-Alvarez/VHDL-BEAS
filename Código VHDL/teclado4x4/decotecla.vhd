LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY decotecla IS
	PORT(CUENTA: IN STD_LOGIC_VECTOR(0 TO 3);
	      TECLA: OUT INTEGER RANGE 0 TO 15);
END decotecla;

ARCHITECTURE BEAS OF decotecla IS
BEGIN

	WITH CUENTA SELECT
		TECLA <= 0 WHEN "0100",
		         1 WHEN "0011",
		         2 WHEN "0111",
					3 WHEN "1011",
					4 WHEN "0010",
					5 WHEN "0110",
					6 WHEN "1010",
					7 WHEN "0001",
					8 WHEN "0101",
					9 WHEN "1001",
				  10 WHEN "1111", -- A
				  11 WHEN "1110", -- B
				  12 WHEN "1101", -- C
				  13 WHEN "1100", -- D
				  14 WHEN "1000", -- #
				  15 WHEN "0000"; -- *		

END BEAS; 