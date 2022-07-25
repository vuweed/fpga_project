

LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

ENTITY lcd_example_new IS
  PORT(
      clk       : IN  STD_LOGIC;  --system clock
      rw, rs, e : OUT STD_LOGIC;  --read/write, setup/data, and enable for lcd
		f		    : OUT STD_LOGIC;
		relay		 : IN STD_LOGIC;
      lcd_data  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)); --data signals for lcd
END lcd_example_new;

ARCHITECTURE behavior OF lcd_example_new IS
  SIGNAL   lcd_enable : STD_LOGIC;
  SIGNAL   lcd_bus    : STD_LOGIC_VECTOR(9 DOWNTO 0);
  SIGNAL   lcd_busy   : STD_LOGIC;
  SIGNAL    reset_n    : STD_LOGIC;
  SIGNAL   temp       : STD_LOGIC ;
  SIGNAL   flag       : STD_LOGIC ;
  signal   count 		: integer range 0 to 25000000 :=0;
--  signal   count1 	: integer range 0 to 120 :=0;
  signal   min : integer range 0 to 60 :=0;
  signal   hour : integer range 0 to 12 :=0;
  COMPONENT lcd_controller_new IS
    PORT(
       clk        : IN  STD_LOGIC; --system clock
       reset_n    : IN  STD_LOGIC; --active low reinitializes lcd
       lcd_enable : IN  STD_LOGIC; --latches data into lcd controller
       lcd_bus    : IN  STD_LOGIC_VECTOR(9 DOWNTO 0); --data and control signals
       busy       : OUT STD_LOGIC; --lcd controller busy/idle feedback
       rw, rs, e  : OUT STD_LOGIC; --read/write, setup/data, and enable for lcd
       lcd_data   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)); --data signals for lcd
  END COMPONENT;
BEGIN
	f <= temp;
  --instantiate the lcd controller
  dut: lcd_controller_new
    PORT MAP(clk => clk, reset_n => '1', lcd_enable => lcd_enable, lcd_bus => lcd_bus, 
             busy => lcd_busy, rw => rw, rs => rs, e => e, lcd_data => lcd_data);
  
  PROCESS(clk)
    VARIABLE char  :  INTEGER RANGE 0 TO 9 := 0;
  BEGIN
    IF(clk'EVENT AND clk = '1') THEN
				count <= count + 1;
			if (relay = '0') then --relay on
					temp <= '1';			--output is on
					
				elsif (relay = '1') then
					temp <= '0';
				--	char := 0;
				
			  end if;
--			  if (relay <= not relay) then
--			  char := 0 ;
--			  end if;
			  --------------------------------
      IF(lcd_busy = '0' AND lcd_enable = '0') THEN
        lcd_enable <= '1';
			
						if (char < 9  ) then
								--if ( count = 25000000) then
								char := char + 1;			--else 
						--	count <= 0;
						--	end if;
--						elsif (char =9  and count = 500000) then --o (temp /= temp)
--								 count <= 0;
--								char := 0;
							elsif (flag = '1' ) then	
								char := 0;
								flag <= '0';
								if(count > 76000) then 
									--lcd_bus <= "0010000000";
										lcd_bus <= "0000000010";
										count <= 0;
										end if;
							
						--reset_n <= '0';
						end if;
						if ( temp = '0'  ) then
					--	if ( temp = '1' and (flag <= not flag) ) then 
							 CASE char IS
						  --PUMPING
							 WHEN 1 => lcd_bus <= "1001010000";
							 WHEN 2 => lcd_bus <= "1001010101";
							 WHEN 3 => lcd_bus <= "1001001101"; --------
							 WHEN 4 => lcd_bus <= "1001010000";
							 WHEN 5 => lcd_bus <= "1001001001";--
							 WHEN 6 => lcd_bus <= "1001001110";
							 WHEN 7 => lcd_bus <= "1001000111";
							 WHEN 8 => lcd_bus <= "1000100001"; 
											--if ( count = 50000) then
											flag <= '1';
--											if(count > 76000) then 
--									--lcd_bus <= "0010000000";
--										lcd_bus <= "0000000010";
--										count <= 0;
--										end if;
											--reset_n <= '0';
											--count <= 0;
											--end if;
									--	flag <= not flag	;
											--char:=0;
							-- WHEN 9 => lcd_bus <= "1000111001";
							 WHEN OTHERS => lcd_enable <= '0';
												--flag <= not flag	;
--												if (count < 76000) then
											--lcd_bus <= "0000000001";
--												count <= 0;
--												end if;
						  END CASE;
						 
					
	--						  if (relay <= not relay  ) then
--							char := 0;
						end if;
						if ( temp = '1' ) then --and (flag <= not flag) ) then 
					--	if ( temp = '0'  ) then
							--if(count > 76000) then 
									--lcd_bus <= "0010000000";
								--	lcd_bus <= "0000000010";
										--count <= 0;
										--end if;
										if ( char > 3) then
											char := 0;
									if(count > 76000) then 
								--	lcd_bus <= "0010000000";
									lcd_bus <= "0000000010";
										count <= 0;
										end if;
										end if;
						 CASE char IS
							 WHEN 1 => lcd_bus <= "1001011110";
							 WHEN 2 => lcd_bus <= "1000101110";
							 WHEN 3 => lcd_bus <= "1001011110"; --------
										-- flag <= not flag;
										 flag <= '1';
							 WHEN OTHERS => lcd_enable <= '0';	
											--lcd_bus <= "0000000001";
						  END CASE;
						  -------------------------
--							if (relay <= not relay  ) then
--							char := 0;
--							end if;
						 --elsif temp  = '1' then 
						 end if;
						
						
--				
				-- end if; 
				-- end  if; 
		
      ELSE
        lcd_enable <= '0';
		  
      END IF;
   END IF;
  END PROCESS;
  
--  process (clk)
--  VARIABLE char  :  INTEGER RANGE 0 TO 9 := 0;
--  begin
--	if (rising_edge (clk)) then
--		if ( relay /= relay) then
--						char := 0;
--		end if;
--	end if;
--  end process;
  
END behavior;
