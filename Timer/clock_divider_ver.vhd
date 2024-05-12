----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:27:07 05/08/2024 
-- Design Name: 
-- Module Name:    clock_divider_ver - Behavioral 
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

entity clock_divider_ver is
	 --generic( max_count: integer := 5000000);
	 
    Port ( en : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           c_out : out  STD_LOGIC);
end clock_divider_ver;

architecture Behavioral of clock_divider_ver is

constant max_count: integer:= 4999999;
signal counter: integer range 0 to max_count;
signal edge: std_logic:= '1';

begin

process(clk)
begin
	
	if(falling_edge(clk))then
		if(rst = '0')then
			counter <= 0;
			edge <= '1';
		elsif(en = '1')then
			if(counter = max_count)then
				counter <= 0;
				edge <= not edge;
			else
				counter <= counter + 1;
			end if;
		end if;
	end if;
end process;

c_out <= edge;


end Behavioral;

