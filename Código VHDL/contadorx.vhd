LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY contadorx IS
PORT(CLK, HAB: IN STD_LOGIC;
              CUENTA: BUFFER INTEGER RANGE 0 TO 9;
             CARRY: OUT STD_LOGIC);
END ENTITY;
ARCHITECTURE BEAS OF contadorx IS
BEGIN
                PROCESS(CLK, HAB)
                BEGIN
                   IF FALLING_EDGE (CLK) THEN
                      IF HAB = ‘1’ THEN
                         IF CUENTA = 9 THEN
                             CUENTA <= 0; CARRY <= ‘1’;
                         ELSE
                             CUENTA <= CUENTA + 1; CARRY <= ‘0’;
                         END IF;
                       ELSE
                            CUENTA <= CUENTA;
                       END IF;
                    END IF;
                END PROCESS;
END BEAS;
