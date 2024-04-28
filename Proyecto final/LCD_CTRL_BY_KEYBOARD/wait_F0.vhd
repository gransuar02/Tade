----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:41:03 04/26/2024 
-- Design Name: 
-- Module Name:    wait_F0 - Behavioral 
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

entity wait_F0 is
    Port ( byte : in  STD_LOGIC_VECTOR (7 downto 0);
           en : in  STD_LOGIC;
			  clk: in std_logic;
			  rst: in std_logic;
           dout : out  STD_LOGIC_VECTOR (7 downto 0);
           filter_en : out  STD_LOGIC);
end wait_F0;

architecture Behavioral of wait_F0 is

type state_machine is(init,waiting,catch);
signal state_curr, state_next: state_machine;
signal flag: std_logic;

begin

process(clk)
begin
	if(rising_edge(clk))then
		if(rst = '1')then
			state_curr <= init;
		else
			state_curr <= state_next;
		end if;
	end if;
end process;

process(state_curr,en,flag)
begin

	state_next <= state_curr;
	
	case(state_curr)is
		when init =>
			if(en = '1')then
				if(flag = '1')then
					state_next <= waiting;
				end if;
			end if;
		
		when waiting =>
			state_next <= catch;
			
			
		when catch =>
			if(en = '1' and byte /= x"E0")then
				state_next <= init;
			end if;
		
		when others =>
			state_next <= init;
			
	end case;
end process;

dout <= byte when (state_curr = catch and en = '1' and byte /= x"E0") else (others => '0');

filter_en <= '1' when (state_curr = catch and en = '1' and byte /= x"E0") else '0';

flag <= '1' when byte = x"F0" else '0';
	

end Behavioral;

