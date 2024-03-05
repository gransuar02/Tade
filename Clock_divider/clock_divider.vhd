----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    06:48:38 02/27/2024 
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
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_divider is
    Port ( clk50MHz : in  STD_LOGIC;
           clk : out  STD_LOGIC);
end clock_divider;

architecture Behavioral of clock_divider is

	constant max_count: integer := 50000000;
	signal count: integer range 0 to max_count;
	signal clk_state: std_logic := '0';
	
begin

	process(clk50MHz, clk_state, count)
	begin
		if(clk50MHz'event and clk50MHz = '1') then
			if(count < max_count) then
				count <= count + 1;
			else
				clk_state <= not clk_state;
				count <= 0;
			end if;
		end if;
	end process;
	
	clk <= clk_state;

end Behavioral;

