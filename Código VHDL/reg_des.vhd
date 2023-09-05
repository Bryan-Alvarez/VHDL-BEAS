LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY reg_d IS
PORT(NUM: IN INTEGER RANGE 0 TO 9;
     CLK, RST: IN STD_LOGIC;
	  R1, R2, R3, R4: BUFFER INTEGER RANGE 0 TO 9);
END ENTITY;

ARCHITECTURE BEAS OF reg_d IS
BEGIN

	PROCESS(CLK, RST) -- Desplazamiento a la izquierda
	BEGIN
		IF RISING_EDGE(CLK) THEN
			IF RST = '1' THEN
				R4 <= 0; R3 <= 0; R2 <= 0; R1 <= 0;
			ELSE	
				R4 <= NUM;
				R3 <= R4;
				R2 <= R3;
				R1 <= R2;
			END IF;
		END IF;
	END PROCESS;
	
--	PROCESS(CLK) -- Desplazamiento a la derecha
--	BEGIN
--		IF RISING_EDGE(CLK) THEN
--			R1 <= NUM;
--			R2 <= R1;
--			R3 <= R2;
--			R4 <= R3;
--		END IF;
--	END PROCESS;
	
END BEAS;