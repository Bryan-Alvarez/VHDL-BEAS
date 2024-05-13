--==============================================================================
-- 	               ANIMACIÓN CON MOV Y LABERINTO		            				--
-- 					  M.I. BRYAN EMMANUEL ALVAREZ SERNA									--
-- =============================================================================

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY vga_run IS
PORT(U,D,L,RR, RST, CLK, VIDEO: IN STD_LOGIC; -- RELOJ DE 25 MHz (PLL)
	  HPOS: IN INTEGER RANGE 0 TO 799;
	  VPOS: IN INTEGER RANGE 0 TO 524;-- SALIDAS V y H
	   RGB: OUT STD_LOGIC_VECTOR(2 DOWNTO 0)); -- SALIDA RGB
END vga_run;

ARCHITECTURE BEAS OF vga_run IS
SIGNAL CLK_ASM : STD_LOGIC;

SIGNAL X1: INTEGER RANGE 0 TO 640 := 280;
SIGNAL X2: INTEGER RANGE 0 TO 640 := 320; 
SIGNAL Y1: INTEGER RANGE 0 TO 480 := 200; 
SIGNAL Y2: INTEGER RANGE 0 TO 480 := 240;

SIGNAL X3: INTEGER RANGE 0 TO 640 := 290;
SIGNAL X4: INTEGER RANGE 0 TO 640 := 310; 
SIGNAL Y3: INTEGER RANGE 0 TO 480 := 180; 
SIGNAL Y4: INTEGER RANGE 0 TO 480 := 200;

 

------------------------ CARTA ASM PARA CONTADOR -------------------------
TYPE EDOS IS (INICIO, IZQ, DER, ARR, ABA, RETARDO);
SIGNAL PRES: EDOS := INICIO;
SIGNAL RET: INTEGER RANGE 0 TO 100000 := 0;
SIGNAL AUX: INTEGER RANGE 0 TO 50;

SIGNAL DRAW1, DRAW2:STD_LOGIC;

BEGIN


	
	PROCESS(CLK_ASM, U, D, L, RR, DRAW1, DRAW2)
	BEGIN
		IF RISING_EDGE(CLK) THEN
			CASE PRES IS
				WHEN INICIO => IF DRAW1 = '1' AND DRAW2 = '1' THEN
										X1 <= 280; X2 <= 320;
										Y1 <= 200; Y2 <= 240;
										X3 <= 290; X4 <= 310;
										Y3 <= 180; Y4 <= 200;
										PRES <= INICIO;
									ELSIF U = '0' THEN
										PRES <= ARR;
									ELSIF D = '0' THEN
										PRES <= ABA;
									ELSIF L = '0' THEN
										PRES <= IZQ;
									ELSIF RR = '0' THEN
										PRES <= DER;
									ELSE
										PRES <= INICIO;
									END IF;
									
				WHEN DER => X1 <= X1 + 1; X2 <= X2 + 1;
								X3 <= X3 + 1; X4 <= X4 + 1;
								PRES <= RETARDO;
							 
				WHEN IZQ => X1 <= X1 - 1; X2 <= X2 - 1;
				            X3 <= X3 - 1; X4 <= X4 - 1;
							   PRES <= RETARDO;		
						
				WHEN ARR => Y1 <= Y1 + 1; Y2 <= Y2 + 1;
								Y3 <= Y3 + 1; Y4 <= Y4 + 1;
							   PRES <= RETARDO;
				
				WHEN ABA => Y1 <= Y1 - 1; Y2 <= Y2 - 1;
								Y3 <= Y3 - 1; Y4 <= Y4 - 1;
								PRES <= RETARDO;
							
				WHEN RETARDO => IF RET = 119999 THEN
										 RET <= 0;
										 PRES <= INICIO;
									 ELSE
										 RET <= RET + 1;
									 END IF;
			END CASE;
		END IF;
	END PROCESS;
	
	
	
	PROCESS(CLK, RST, HPOS, VPOS, VIDEO) -- PROCESO PARA COLOREAR LOS PIXELES
	BEGIN
		IF RST = '1' THEN
			RGB <= "000";
		ELSIF FALLING_EDGE(CLK) THEN
			IF VIDEO = '1' THEN
			   ----------------------  FIGURA ---------------------------------------------
				IF (HPOS >= X1 AND HPOS <= X2) AND (VPOS >= Y1 AND VPOS <= Y2) THEN
					RGB <= "100";
					DRAW1 <= '1';
				ELSIF (HPOS >= X3 AND HPOS <= X4) AND (VPOS >= Y3 AND VPOS <= Y4) THEN
					RGB <= "100";
					DRAW1 <= '1';
				-----------------------------------------------------------------------------
			   ---------------------- LABERINTO --------------------------------------------	
				ELSIF (HPOS >= 10 AND HPOS <= 510) AND (VPOS >= 0 AND VPOS <= 40) THEN
						RGB <= "110";
						DRAW2 <= '1';
				ELSIF (HPOS >= 130 AND HPOS <= 510) AND (VPOS >= 400 AND VPOS <= 440) THEN
						RGB <= "110";
						DRAW2 <= '1';
				ELSIF (HPOS >= 580 AND HPOS <= 620) AND (VPOS >= 40 AND VPOS <= 400) THEN
						RGB <= "110";
						DRAW2 <= '1';
				ELSE
					RGB <= "000";
					DRAW1 <= '0'; DRAW2 <= '0';
				END IF;
			END IF;
		END IF;
	END PROCESS;
	

END BEAS;