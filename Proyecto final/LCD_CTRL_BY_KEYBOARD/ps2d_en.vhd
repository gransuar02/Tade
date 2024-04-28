----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:22:19 04/21/2024 
-- Design Name: 
-- Module Name:    ps2d_en - Behavioral 
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ps2d_en is
    Port ( ps2d_in : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           ps2d_out : out  STD_LOGIC;
           pulse : out  STD_LOGIC);
end ps2d_en;

architecture Behavioral of ps2d_en is

type FSM is(init,wait_11_cycles);
signal state_reg, state_next: FSM;
signal count: integer range 0 to 27499;
signal count_init: integer range 0 to 2499;

begin

clk_logic:process(clk)
begin
	
	if(rising_edge(clk))then
		if(rst = '1')then
			state_reg <= init;
		else
			state_reg <= state_next;
			if((state_reg = init and ps2d_in = '0') or state_reg = wait_11_cycles)then
				ps2d_out <= ps2d_in;
			end if;
		end if;
	end if;
end process;

next_state_logic:process(state_reg,ps2d_in,count,count_init)
begin
	
	state_next <= state_reg;
	
	case(state_reg)is
		when init =>
			if(ps2d_in = '0' and count_init = 2499)then
				state_next <= wait_11_cycles;
			end if;
		
		when wait_11_cycles =>
			if(count = 24999)then
				state_next <= init;
			end if;
		
		when others =>
			state_next <= init;
	end case;
end process;

COUNT_24999_PROCESS:process(clk)
begin
	if(rising_edge(clk))then
		if(rst = '1')then
			count <= 0;
		elsif(state_reg = wait_11_cycles)then
			if(count /= 24999)then
				count <= count + 1;
			else
				count <= 0;
			end if;
		end if;
	end if;
end process;

COUNT_INIT_PROCESS:process(clk)
begin
	if(rising_edge(clk))then
		if(rst = '1')then
			count_init <= 0;
		elsif(state_reg = init and ps2d_in = '0')then
			if(count_init /= 2499)then
				count_init <= count_init + 1;
			else
				count_init <= 0;
			end if;
		end if;
	end if;
end process;


pulse <= '1' when (state_reg = init and ps2d_in = '0') else '0';


end Behavioral;

