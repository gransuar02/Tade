----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:35:22 02/27/2019 
-- Design Name: 
-- Module Name:    lcd_tx_fsm - Behavioral 
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

entity lcd_tx_fsm is
    Port ( --system signals
			  clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  --tx control signals
			  byte : in STD_LOGIC_VECTOR (7 downto 0);
			  stb : in  STD_LOGIC;
           done : out  STD_LOGIC;
			  --lcd signals
			  mode : in  STD_LOGIC;
			  data : out  STD_LOGIC_VECTOR (7 downto 0);
           rs : out  STD_LOGIC;
           en : out  STD_LOGIC
			  );
end lcd_tx_fsm;

architecture Behavioral of lcd_tx_fsm is

type lcd_tx_fsm_states is (IDLE, INIT_TX, ENABLE_TX, WAIT_230NS, FINISH_TX, TX_DONE);

signal lcd_tx_curr_state: lcd_tx_fsm_states;
signal lcd_tx_next_state: lcd_tx_fsm_states;

signal cnt230ns : integer range 0 to 11;

begin

lcd_tx_fsm_state_transition_logic: process(clk)
begin
if rising_edge(clk) then
	if rst = '1' then
		lcd_tx_curr_state <= IDLE;
	else
		lcd_tx_curr_state <= lcd_tx_next_state;
	end if;
end if;
end process;

lcd_tx_fsm_next_state_logic: process(lcd_tx_curr_state, stb, cnt230ns)
begin
lcd_tx_next_state <= lcd_tx_curr_state;
case lcd_tx_curr_state is
	when IDLE =>
		if stb = '1' then
			lcd_tx_next_state <= INIT_TX;
		end if;
		
	when INIT_TX =>
		lcd_tx_next_state <= ENABLE_TX;
		
	when ENABLE_TX =>
		lcd_tx_next_state <= WAIT_230NS;
		
	when WAIT_230NS =>
		if cnt230ns = 11 then
			lcd_tx_next_state <= FINISH_TX;
		end if;
		
	when FINISH_TX =>
			lcd_tx_next_state <= TX_DONE;	
		
	when TX_DONE =>
		lcd_tx_next_state <= IDLE;
		
	when others =>
		lcd_tx_next_state <= IDLE;
	
end case;
end process;

lcd_230ns_count_logic: process(clk)
begin
if rising_edge(clk) then
	if rst = '1' then
		cnt230ns <= 0;
	else
		if lcd_tx_curr_state = WAIT_230NS then
			if cnt230ns /= 11 then
				cnt230ns <= cnt230ns + 1;
			else
				cnt230ns <= 0;
			end if;
		end if;
	end if;
end if;
end process;

done <= '1' when lcd_tx_curr_state = TX_DONE else '0'; 

data <= byte;
rs <= not mode;
en <= '1' when lcd_tx_curr_state = WAIT_230NS else '0';

end Behavioral;

