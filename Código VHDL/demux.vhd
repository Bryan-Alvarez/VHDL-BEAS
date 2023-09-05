LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY demux IS
	PORT(A: IN INTEGER RANGE 0 TO 9;
		NUM: IN INTEGER RANGE 0 TO 9;
	     Y: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)); -- # de displays
END ENTITY;

ARCHITECTURE BEAS OF demux IS
BEGIN
	
	PROCESS(A)
	BEGIN
		IF A = 0 THEN
			CASE NUM IS
				WHEN 1 => Y <= "00000011"; -- 0
				WHEN 2 => Y <= "10011111"; -- 1
				WHEN 3 => Y <= "00100101"; -- 2
				WHEN 4 => Y <= "00001101"; -- 3 
				WHEN 5 => Y <= "10011001"; -- 4
				WHEN 6 => Y <= "01001001"; -- 5
				WHEN 7 => Y <= "01000001"; -- 6
				WHEN OTHERS => Y <= "11111111";
			END CASE;
				
		ELSIF A = 1 THEN
			CASE NUM IS
				WHEN 1 => Y <= "00010001"; -- A
				WHEN 2 => Y <= "11000001"; -- b
				WHEN 3 => Y <= "01100011"; -- C
				WHEN 4 => Y <= "10000101"; -- d
				WHEN 5 => Y <= "01100001"; -- E
				WHEN 6 => Y <= "01110001"; -- F
				WHEN 7 => Y <= "01000001"; -- G
				WHEN OTHERS => Y <= "11111111";
			END CASE;
		END IF;
	END PROCESS;
			  
END BEAS;