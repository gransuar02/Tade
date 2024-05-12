----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    06:23:05 05/05/2024 
-- Design Name: 
-- Module Name:    clock_divider - Behavioral 
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

entity clock_divider is
	 generic( max_count: integer := 24);
	 
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  en : in std_logic;
           clk_out : out  STD_LOGIC);
end clock_divider;

architecture Behavioral of clock_divider is

signal counter, counter_next, counter_next_2: std_logic_vector(22 downto 0);
signal edge, edge_next: std_logic;

begin

--MEMORIA DE ESTADO--
process(clk)
begin
	
	if(falling_edge(clk))then
		if(rst = '0')then
			counter <= (others => '0');
			edge <= '1';
		else
			counter <= counter_next_2;
			edge <= edge_next;
		end if;
	end if;
end process;

--CLC DEL PROXIMO ESTADO--
counter_next <= counter + 1 when counter /= max_count else (others => '0');

counter_next_2 <= counter_next when en = '1' else counter;

edge_next <= not edge when counter = max_count else 
				 edge;

--CLC DE SALIDA--
clk_out <= edge;

end Behavioral;

