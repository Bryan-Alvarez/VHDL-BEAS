LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY sonic IS
	PORT(CLK, ECHO: IN STD_LOGIC;
				 TRIG: OUT STD_LOGIC;
			 C, D, U: BUFFER INTEGER RANGE 0 TO 9); 
END ENTITY;

ARCHITECTURE BEAS OF sonic IS
TYPE EDOS IS (INICIO, E1,E2,E3,DELAY);
SIGNAL PRES : EDOS := INICIO;
SIGNAL AUX: INTEGER RANGE 0 TO 100000000;
BEGIN

			PROCESS(CLK, ECHO)
			BEGIN
				IF RISING_EDGE(CLK) THEN
					CASE PRES IS
						WHEN INICIO => C <= 0; D <= 0; U <= 0;
						               TRIG <= '1';
											PRES <= E1;
											
						WHEN E1 => TRIG <= '0';
									  PRES <= E2;
									  
						WHEN E2 => TRIG <= '1';
									  IF ECHO = '0' THEN
										  PRES <= INICIO;
									  ELSE
										  PRES <= E3;
									  END IF;
									  
						WHEN E3 => IF ECHO = '0' THEN
										  PRES <= DELAY;
									  ELSE
										  PRES <= E3;
										  IF U = 9 THEN
										     IF D = 9 THEN
											     IF C = 2 THEN
													  C <= 0;
												  ELSE
														C <= C + 1;
														D <= 0;
												  END IF;
											   ELSE
													D <= D + 1;
													U <= 0;
												END IF;
											ELSE
												U <= U + 1;
											END IF;
										END IF;
							
						WHEN DELAY => IF AUX = 15000 THEN
												AUX <= 0;
												PRES <= INICIO;
										  ELSE
												AUX <= AUX + 1;
												PRES <= DELAY;
										  END IF;
					END CASE;
				END IF;
			END PROCESS;
END BEAS;
