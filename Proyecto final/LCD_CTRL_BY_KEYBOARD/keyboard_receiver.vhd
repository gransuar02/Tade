----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:32:23 04/11/2024 
-- Design Name: 
-- Module Name:    keyboard_receiver - Behavioral 
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

entity keyboard_receiver is

port ( clk, reset: in std_logic;
		ps2d, ps2c: in std_logic;   --key data, key clock
		rx_en : in std_logic ;
		rx_done_tick: out std_logic;
		dout: out std_logic_vector (7 downto 0)
		);

end keyboard_receiver;

architecture Behavioral of keyboard_receiver is

type statetype is (idle, dps, load);
signal state_reg , state_next : statetype; 
signal filter_reg , filter_next : std_logic_vector (7 downto 0);
signal f_ps2c_reg, f_ps2c_next : std_logic ; 
signal b_reg , b_next : std_logic_vector (10 downto 0);
signal n_reg , n_next : std_logic_vector (3 downto 0);  
signal fall_edge : std_logic ;   


begin

process(clk)
begin
	
	if(rising_edge(clk))then
		if(reset = '1')then
			filter_reg <= (others => '0');
			f_ps2c_reg <= '0';
		else
			filter_reg <= filter_next;
			f_ps2c_reg <= f_ps2c_next;
		end if;
	end if;
end process;

filter_next <= ps2c & filter_reg(7 downto 1);

with filter_reg select
	f_ps2c_next <= '1' when "11111111",
						'0' when "00000000",
						f_ps2c_reg when others;

--f_ps2c_next <= '1' when filter_reg ="llllllll" else 
					--'0' when filter_reg ="00000000" else
					--f_ps2c_reg;
					
fall_edge <= f_ps2c_reg and (not f_ps2c_next);

--===================================
-- fsmd to extract the 8-bit data  
--===================================

process(clk)
begin

	if(rising_edge(clk))then
		if(reset = '1')then
			state_reg <= idle;
			n_reg <= (others => '0');
			b_reg <= (others => '0');
		else
			state_reg <= state_next;
			n_reg <= n_next;
			b_reg <= b_next;
		end if;
	end if;
	
end process;

-- next-state logic 

process(state_reg,n_reg,b_reg,fall_edge,rx_en,ps2d)
begin

rx_done_tick <= '0';
state_next <= state_reg;
n_next <= n_reg;
b_next <= b_reg;

case state_reg is
	when idle =>
		if(fall_edge = '1' and rx_en = '1')then
			b_next <= ps2d & b_reg(10 downto 1);
			n_next <= "1001";
			state_next <= dps;
		end if;
	when dps =>
		if(fall_edge = '1')then
			b_next <= ps2d & b_reg(10 downto 1);
			if(n_reg = 0)then
				state_next <= load;
			else
				n_next <= n_reg - 1;
			end if;
		end if;
	when load =>
		state_next <= idle;
		rx_done_tick <= '1';
end case;
end process;

dout <= b_reg(8 downto 1) when state_reg = load else
        (others => '0');

end Behavioral;

