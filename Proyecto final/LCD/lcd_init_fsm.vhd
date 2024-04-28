----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:33:40 02/27/2019 
-- Design Name: 
-- Module Name:    lcd_init_fsm - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lcd_init_fsm is
    Port ( --system signals
			  clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  --init status signals
			  rdy : out  STD_LOGIC;
			  --tx control signals
			  byte : out STD_LOGIC_VECTOR (7 downto 0);
			  stb : out  STD_LOGIC;
			  mode : out  STD_LOGIC;
           done : in  STD_LOGIC
			  );
end lcd_init_fsm;

architecture Behavioral of lcd_init_fsm is

type lcd_init_fsm_states is (WAIT_15MS, FIRST_3WR, WAIT_4P1MS, SECOND_3WR, WAIT_100US, THIRD_3WR, WAIT_40US, FOURTH_2WR, CMD38H, CMD06H, CMD0CH, CMD01H, WAIT_1P64MS, READY); 

signal lcd_init_curr_state: lcd_init_fsm_states;
signal lcd_init_next_state: lcd_init_fsm_states;

signal cnt15ms : integer range 0 to 749999;
signal cnt4p1ms : integer range 0 to 204999;
signal cnt1p64ms : integer range 0 to 81999;
signal cnt100us : integer range 0 to 4999;
signal cnt40us : integer range 0 to 1999;

signal flag40us : integer range 0 to 4;

begin

lcd_init_fsm_state_transition_logic: process(clk)
begin
if rising_edge(clk) then
	if rst = '1' then
		lcd_init_curr_state <= WAIT_15MS;
	else
		lcd_init_curr_state <= lcd_init_next_state;
	end if;
end if;
end process;

lcd_init_fsm_next_state_logic: process(lcd_init_curr_state, cnt15ms, cnt1p64ms, cnt4p1ms, cnt100us, cnt40us, flag40us, done)
begin
lcd_init_next_state <= lcd_init_curr_state;
case lcd_init_curr_state is
	when WAIT_15MS =>
		if cnt15ms = 749999 then
			lcd_init_next_state <= FIRST_3WR;
		end if;
		
	when FIRST_3WR =>
		if done = '1' then
			lcd_init_next_state <= WAIT_4P1MS;
		end if;
		
	when WAIT_4P1MS =>
		if cnt4p1ms = 204999 then
			lcd_init_next_state <= SECOND_3WR;
		end if;

	when SECOND_3WR =>
		if done = '1' then
			lcd_init_next_state <= WAIT_100US;
		end if;		
		
	when WAIT_100US =>
		if cnt100us = 4999 then
			lcd_init_next_state <= THIRD_3WR;
		end if;	
		
	when THIRD_3WR =>
		if done = '1' then
			lcd_init_next_state <= WAIT_40US;
		end if;

	when WAIT_40US =>
		if cnt40us = 1999 then
			case flag40us is
				when 0 =>
					lcd_init_next_state <= FOURTH_2WR;
					
				when 1 =>
					lcd_init_next_state <= CMD38H;
					
				when 2 =>
					lcd_init_next_state <= CMD06H;

				when 3 =>
					lcd_init_next_state <= CMD0CH;

				when 4 =>
					lcd_init_next_state <= CMD01H;

				when others =>
					lcd_init_next_state <= READY;	
					
			end case;
		end if;

	when FOURTH_2WR =>
		if done = '1' then
			lcd_init_next_state <= WAIT_40US;
		end if;
		
	when CMD38H =>
		if done = '1' then
			lcd_init_next_state <= WAIT_40US;
		end if;	
	
	when CMD06H =>
		if done = '1' then
			lcd_init_next_state <= WAIT_40US;
		end if;	
	
	when CMD0CH =>
		if done = '1' then
			lcd_init_next_state <= WAIT_40US;
		end if;	
	
	when CMD01H =>
		if done = '1' then
			lcd_init_next_state <= WAIT_1P64MS;
		end if;	
		
	when WAIT_1P64MS =>
		if cnt1p64ms = 81999 then
			lcd_init_next_state <= READY;	
		end if;

	when READY =>
		lcd_init_next_state <= READY;		
		
	when others =>
		lcd_init_next_state <= READY;
		
end case;
end process;

lcd_15ms_count_logic: process(clk)
begin
if rising_edge(clk) then
	if rst = '1' then
		cnt15ms <= 0;
	else
		if lcd_init_curr_state = WAIT_15MS then
			if cnt15ms /= 749999 then
				cnt15ms <= cnt15ms + 1;
			else
				cnt15ms <= 0;
			end if;
		end if;
	end if;
end if;
end process;

lcd_4p1ms_count_logic: process(clk)
begin
if rising_edge(clk) then
	if rst = '1' then
		cnt4p1ms <= 0;
	else
		if lcd_init_curr_state = WAIT_4P1MS then
			if cnt4p1ms /= 204999 then
				cnt4p1ms <= cnt4p1ms + 1;
			else
				cnt4p1ms <= 0;
			end if;
		end if;
	end if;
end if;
end process;

lcd_1p64ms_count_logic: process(clk)
begin
if rising_edge(clk) then
	if rst = '1' then
		cnt1p64ms <= 0;
	else
		if lcd_init_curr_state = WAIT_1P64MS then
			if cnt1p64ms /= 81999 then
				cnt1p64ms <= cnt1p64ms + 1;
			else
				cnt1p64ms <= 0;
			end if;
		end if;
	end if;
end if;
end process;

lcd_100us_count_logic: process(clk)
begin
if rising_edge(clk) then
	if rst = '1' then
		cnt100us <= 0;
	else
		if lcd_init_curr_state = WAIT_100US then
			if cnt100us /= 4999 then
				cnt100us <= cnt100us + 1;
			else
				cnt100us <= 0;
			end if;
		end if;
	end if;
end if;
end process;

lcd_40us_count_logic: process(clk)
begin
if rising_edge(clk) then
	if rst = '1' then
		cnt40us <= 0;
	else
		if lcd_init_curr_state = WAIT_40US then
			if cnt40us /= 1999 then
				cnt40us <= cnt40us + 1;
			else
				cnt40us <= 0;
			end if;
		end if;
	end if;
end if;
end process;

lcd_flag40us_logic: process(clk)
begin
if rising_edge(clk) then
	if rst = '1' then
		flag40us <= 0;
	else
		if lcd_init_curr_state = FOURTH_2WR then
			flag40us <= 1;
		elsif lcd_init_curr_state = CMD38H then
			flag40us <= 2;
		elsif lcd_init_curr_state = CMD06H then
			flag40us <= 3;
		elsif lcd_init_curr_state = CMD0CH then
			flag40us <= 4;
		end if;
	end if;
end if;
end process;

mode <= '1';

rdy <= '1' when lcd_init_curr_state = READY else '0';
stb <= '1' when (lcd_init_curr_state = FIRST_3WR or lcd_init_curr_state = SECOND_3WR or lcd_init_curr_state = THIRD_3WR or lcd_init_curr_state = FOURTH_2WR or lcd_init_curr_state = CMD38H or lcd_init_curr_state = CMD06H or lcd_init_curr_state = CMD0CH or lcd_init_curr_state = CMD01H) else '0';

with lcd_init_curr_state select
byte <= "00000011" when FIRST_3WR,
		  "00000011" when SECOND_3WR,
		  "00000011" when THIRD_3WR,
		  "00000010" when FOURTH_2WR,
		  "00111000" when CMD38H,
		  "00000110" when CMD06H,
		  "00001100" when CMD0CH,
		  "00000001" when CMD01H,
		  "00000000" when others;
		 
end Behavioral;

