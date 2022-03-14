LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY asm IS
	PORT(INC,DEC,CLK: IN STD_LOGIC;
	          CUENTA: BUFFER INTEGER RANGE 0 TO 9 := 0);
END ENTITY;

ARCHITECTURE BEAS OF asm IS
TYPE EDOS IS (INICIO,E1,E2,RETARDO);
SIGNAL PRES: EDOS := INICIO;
SIGNAL AUX: INTEGER RANGE 0 TO 100000 := 0;
BEGIN

	PROCESS(CLK,INC)
	BEGIN
		IF RISING_EDGE(CLK) THEN
			CASE PRES IS
				WHEN INICIO => IF INC = '0' THEN
									   PRES <= E1;
									ELSIF DEC = '0' THEN
										PRES <= E2;
									ELSE
										PRES <= INICIO;
									END IF;
									
				WHEN E1 => IF CUENTA = 9 THEN
								  CUENTA <= 9;
							  ELSE
									CUENTA <= CUENTA + 1;
							  END IF;
							  
							  PRES <= RETARDO;
											
				WHEN E2 => IF CUENTA = 0 THEN
								  CUENTA <= 0;
							  ELSE
									CUENTA <= CUENTA - 1;
							  END IF;
							  
							  PRES <= RETARDO;
											
				WHEN RETARDO => IF AUX = 100000 THEN
										 AUX <= 0;
										 PRES <= INICIO;
									 ELSE
									    AUX <= AUX + 1;
									 END IF;
			END CASE;
		END IF;
	 END PROCESS;
											

END BEAS;