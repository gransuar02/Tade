----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:34:49 02/27/2019 
-- Design Name: 
-- Module Name:    lcd_host_if - Behavioral 
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

entity lcd_host_if is
    Port ( --system signals
			  clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  --host signals
           data : in  STD_LOGIC_VECTOR (7 downto 0);
           addr : in  STD_LOGIC_VECTOR (4 downto 0);
           auto : in  STD_LOGIC;
           wr : in  STD_LOGIC;
           ack : out  STD_LOGIC;
			  --tx control signals
			  byte : out STD_LOGIC_VECTOR (7 downto 0);
			  stb : out  STD_LOGIC;
			  mode : out  STD_LOGIC;
           done : in  STD_LOGIC		  
			  );
end lcd_host_if;

architecture Behavioral of lcd_host_if is

type lcd_host_if_states is (IDLE, INIT_WR, ADDR_PHASE, DATA_PHASE, WAIT_40US, ACK_PHASE);

signal lcd_host_if_curr_state : lcd_host_if_states;
signal lcd_host_if_next_state : lcd_host_if_states;

signal dack : std_logic;

signal phy_addr : std_logic_vector(6 downto 0);

signal cnt40us : integer range 0 to 1999;

begin

lcd_host_if_state_transition_logic: process(clk)
begin
if rising_edge(clk) then
	if rst = '1' then
		lcd_host_if_curr_state <= IDLE;
	else
		lcd_host_if_curr_state <= lcd_host_if_next_state;
	end if;
end if;
end process;

lcd_host_if_next_state_logic: process(lcd_host_if_curr_state, wr, auto, done, cnt40us, dack)
begin
lcd_host_if_next_state <= lcd_host_if_curr_state;
case lcd_host_if_curr_state is
	when IDLE =>
		if wr = '1' then
			lcd_host_if_next_state <= INIT_WR;
		end if;
		
	when INIT_WR =>
		if auto = '1' then
			lcd_host_if_next_state <= DATA_PHASE;
		else
			lcd_host_if_next_state <= ADDR_PHASE;
		end if;	
	
	when ADDR_PHASE =>
		if done = '1' then
			lcd_host_if_next_state <= WAIT_40US;
		end if;	
	
	when DATA_PHASE =>
		if done = '1' then
			lcd_host_if_next_state <= WAIT_40US;
		end if;
		
	when WAIT_40US =>
		if cnt40us = 1999 then
			lcd_host_if_next_state <= ACK_PHASE;
		end if;		

	when ACK_PHASE =>
		if dack = '1' then
			lcd_host_if_next_state <= IDLE;
		else
			lcd_host_if_next_state <= DATA_PHASE;
		end if;	
	
	when others =>
		lcd_host_if_next_state <= IDLE;
		
end case;
end process;

lcd_host_if_dack_logic: process(clk)
begin
if rising_edge(clk) then
	if rst = '1' then
		dack <= '0';
	else
		if lcd_host_if_curr_state = DATA_PHASE then
			dack <= '1';	
		elsif lcd_host_if_curr_state = ADDR_PHASE then
			dack <= '0';			
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
		if lcd_host_if_curr_state = WAIT_40US then
			if cnt40us /= 1999 then
				cnt40us <= cnt40us + 1;
			else
				cnt40us <= 0;
			end if;
		end if;
	end if;
end if;
end process;

stb <= '1' when (lcd_host_if_curr_state = ADDR_PHASE or lcd_host_if_curr_state = DATA_PHASE) else '0';

mode <= '1' when lcd_host_if_curr_state = ADDR_PHASE else '0';

byte <= ('1' & phy_addr) when lcd_host_if_curr_state = ADDR_PHASE else data;

with addr(4) select
phy_addr <= "000" & addr(3 downto 0) when '0',
				"100" & addr(3 downto 0) when '1',
				(others => '0') when others;
				
ack <= '1' when (lcd_host_if_curr_state = ACK_PHASE and dack = '1') else '0';


end Behavioral;

