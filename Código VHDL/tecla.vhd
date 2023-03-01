--Lectura de datos de teclado matricial de 4x4.
-- M.I. Bryan Emmanuel Alvarez Serna.

Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;


Entity tecla is 
	PORT(COL: OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
		  FIL: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		  SAL: OUT INTEGER RANGE 0 TO 15;
	    HABQ: OUT STD_LOGIC;
		  CLK: IN STD_LOGIC);
END tecla;

ARCHITECTURE BEAS OF tecla IS 
SIGNAL CUENTA: STD_LOGIC_VECTOR (3 DOWNTO 0);
SIGNAL HAB: STD_LOGIC;

BEGIN

	  PROCESS(CLK)
	  BEGIN 
	     IF FALLING_EDGE (CLK) THEN
			IF HAB = '1' THEN 
				CUENTA<=CUENTA;
		    ELSIF CUENTA="1111" THEN
				CUENTA<="0000";
			ELSE 
				CUENTA<=CUENTA + "0001";
			END IF;
		 END IF;
	END PROCESS;
		
	WITH CUENTA(1 DOWNTO 0) SELECT
		HAB <= COL(0) WHEN "00", --MSB
			    COL(1) WHEN "01",
		       COL(2) WHEN "10",
             COL(3) WHEN "11"; --LSB
    
	PROCESS(CLK)
	BEGIN
		IF RISING_EDGE (CLK) THEN
			HABQ <= HAB;
		END IF;
	END PROCESS;
              
   WITH CUENTA (3 DOWNTO 2) SELECT 
		FIL <= "0001" WHEN "00",
			    "0010" WHEN "01",
			    "0100" WHEN "10",
			    "1000" WHEN "11";
	
	WITH CUENTA SELECT
		SAL <= 0 WHEN "",
				 1 WHEN "",
				 2 WHEN "",
				 3 WHEN "",
				 4 WHEN "",
				 5 WHEN "",
				 6 WHEN "",
				 7 WHEN "",
				 8 WHEN "",
				 9 WHEN "",
				 10 WHEN "",
				 11 WHEN "",
				 12 WHEN "",
				 13 WHEN "",
				 14 WHEN "",
				 15 WHEN OTHERS;
    
END BEAS;