----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:23:57 04/19/2024 
-- Design Name: 
-- Module Name:    fsm - Behavioral 
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

entity fsm is
	port(
		din: in std_logic_vector(7 downto 0);
		en: in std_logic;
		clk: in std_logic;
		rst: in std_logic;
		data: out std_logic_vector(7 downto 0);
		addr_lcd: out std_logic_vector(4 downto 0);
		rdy, f_da: out std_logic
		);
end fsm;

architecture Behavioral of fsm is

type fsm_states is (init, divide_phase, set_addr,set_char, modify_addr, ENTER, UP, DOWN); 
signal state_reg, state_next: fsm_states;
signal f_com: std_logic;
signal addr_reg, addr_next: std_logic_vector(4 downto 0);
signal b_reg: std_logic_vector(7 downto 0);
signal sel_com: std_logic_vector(1 downto 0);

begin

state_transition:process(clk)
begin
	if(rising_edge(clk))then
		if(rst = '1')then
			state_reg <= init;
			addr_reg <= (others => '0');
		else
			state_reg <= state_next;
			addr_reg <= addr_next;
		end if;
	end if;
end process;


state_logic:process(state_reg,en,f_com,sel_com, addr_reg)
begin

state_next <= state_reg;
addr_next <= addr_reg;

case(state_reg)is
	when init =>
		if(en = '1')then
			state_next <= divide_phase;
		end if;
		
	when divide_phase =>
		if(f_com = '1')then
			state_next <= modify_addr;
		else
			state_next <= set_addr;
		end if;
		
	when set_addr => 
		state_next <= set_char;
		
	when set_char =>
		addr_next <= addr_reg + 1;
		state_next <= init;
		
	when modify_addr =>
		case(sel_com)is
			when "00" =>
				state_next <= ENTER;
			
			when "01" =>
				state_next <= DOWN;
			
			when "10" =>
				state_next <= UP;
			
			when others =>
				state_next <= init;
		end case;
	
	when ENTER =>
		state_next <= init;
		
	when UP =>
		state_next <= init;
		
	when DOWN =>
		state_next <= init;
		
	when others =>
		state_next <= init;
	
	end case;
end process;
		

f_com <= '1' when (din = x"75" or din = x"72" or din = x"5A") else '0';

rdy <= '1' when (state_reg = set_addr or state_reg = set_char or state_reg = ENTER or state_reg = UP or state_reg = DOWN) else '0';

f_da <= '1' when (state_reg = set_addr or state_reg = ENTER or state_reg = UP or state_reg = DOWN) else '0';

data <= b_reg when state_reg = set_char else (others => 'Z');

with state_reg select
	addr_lcd <= addr_reg when set_addr,
					addr_reg + 16 when DOWN,
					addr_reg - 16 when UP,
					"00000" when ENTER,
					"00000" when others;
										

with din select
	sel_com <= "00" when x"5A",
				  "01" when x"75",
				  "10" when x"72",
				  "00" when others;

with din select
	b_reg <= "00110001" when x"16",
				"00110010" when x"1E",
				"00110011" when x"26",
				"00110100" when x"25",
				"00110101" when x"2E",
				"00110110" when x"36",
				"00110111" when x"3D",
				"00111000" when x"3E",
				"00111001" when x"46",
				"00110000" when x"45",
				"01000001" when x"1C",
				"01000010" when x"32",
				"01000011" when x"21",
				"01000100" when x"23",
				"01000101" when x"24",
				"01000110" when x"2B",
				"01000111" when x"34",
				"01001000" when x"33",
				"01001001" when x"43",
				"01001010" when x"3B",
				"01001011" when x"42",
				"01001100" when x"4B",
				"01001101" when x"3A",
				"01001110" when x"31",
				"01001111" when x"44",
				"01010000" when x"4D",
				"01010001" when x"15",
				"01010010" when x"2D",
				"01010011" when x"1B",
				"01010100" when x"2C",
				"01010101" when x"3C",
				"01010110" when x"2A",
				"01010111" when x"1D",
				"01011000" when x"22",
				"01011001" when x"35",
				"01011010" when x"1A",
				"00100000" when x"29",
				"00100000" when others;


		
end Behavioral;

