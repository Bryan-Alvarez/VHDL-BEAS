--==============================================================================
-- 	                    Figura con movimiento 		            				 =
-- 					  M.I. BRYAN EMMANUEL ALVAREZ SERNA									 =
-- =============================================================================

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY vga_run IS
PORT(U, D, L, RI, CLK,RST, VIDEO: IN STD_LOGIC; -- RELOJ DE 25 MHz (PLL)
	  HPOS: IN INTEGER RANGE 0 TO 799;
	  VPOS: IN INTEGER RANGE 0 TO 524;-- SALIDAS V y H
  R, G, B: OUT STD_LOGIC_VECTOR(0 to 3)); -- SALIDA RGB de 4 bits
END vga_run;

ARCHITECTURE BEAS OF vga_run IS
SIGNAL CLK_ASM : STD_LOGIC;


-- POSICIÓN INICIAL DE LA FIGURA
SIGNAL X1: INTEGER RANGE 0 TO 640 := 260;
SIGNAL X2: INTEGER RANGE 0 TO 640 := 340; 
SIGNAL Y1: INTEGER RANGE 0 TO 480 := 180; 
SIGNAL Y2: INTEGER RANGE 0 TO 480 := 260;

------------------------ CARTA ASM PARA CONTADOR -------------------------
TYPE EDOS IS (INICIO, IZQ, DER, ARR, ABA, RETARDO);
SIGNAL PRES: EDOS := INICIO;
SIGNAL RET: INTEGER RANGE 0 TO 100000 := 0;
SIGNAL AUX: INTEGER RANGE 0 TO 50;


BEGIN


	
	PROCESS(CLK_ASM, U, D, L, RI)
	BEGIN
		IF RISING_EDGE(CLK) THEN
			CASE PRES IS
				WHEN INICIO => IF U = '0' THEN
										PRES <= ARR;
									ELSIF D = '0' THEN
										PRES <= ABA;
									ELSIF L = '0' THEN
										PRES <= IZQ;
									ELSIF RI = '0' THEN
										PRES <= DER;
									ELSE
										PRES <= INICIO;
									END IF;
									
				WHEN DER => X1 <= X1 + 1; X2 <= X2 + 1;
								PRES <= RETARDO;
							 
				WHEN IZQ => X1 <= X1 - 1; X2 <= X2 - 1;
							   PRES <= RETARDO;		
						
				WHEN ARR => Y1 <= Y1 + 1; Y2 <= Y2 + 1;
							   PRES <= RETARDO;
				
				WHEN ABA => Y1 <= Y1 - 1; Y2 <= Y2 - 1;
								PRES <= RETARDO;
							
				WHEN RETARDO => IF RET = 119999 THEN
										 RET <= 0;
										 PRES <= INICIO;
									 ELSE
										 RET <= RET + 1;
										 PRES <= RETARDO;
									 END IF;
			END CASE;
		END IF;
	END PROCESS;
			
	
	
	PROCESS(RST, CLK, HPOS, VPOS, VIDEO) -- PROCESO PARA COLOREAR LOS PIXELES
	BEGIN
		IF RST = '1' THEN
				R <= "0000"; G <= "0000"; B <= "0000";
		ELSIF FALLING_EDGE(CLK) THEN
			IF VIDEO = '1' THEN
			   ----------------------  FIGURA ---------------------------------------------
				IF (HPOS >= X1 AND HPOS <= X2) AND (VPOS >= Y1 AND VPOS <= Y2) THEN
					R <= "1111"; G <= "0000"; B <= "0000";
				ELSE
					R <= "0000"; G <= "0000"; B <= "0000";
				END IF;
			END IF;
		END IF;
	END PROCESS;
	

END BEAS;