----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:49:26 02/25/2024 
-- Design Name: 
-- Module Name:    counter - Behavioral 
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

entity counter is
    Port ( clk,rst : in  STD_LOGIC;
           sdout : out  STD_LOGIC);
end counter;

architecture Behavioral of counter is
	signal state, next_state : std_logic;
begin
	SYNC_PROC: process (clk)
   begin
      if (clk'event and clk = '1') then
         if (rst = '1') then
            state <= "0";
         else
            state <= next_state;
         -- assign other outputs to internal signals
         end if;        
      end if;
   end process;
	
	NEXT_STATE_DECODE: process (state)
   begin
      next_state <= state;
		
      case (state) is
         when "0" =>
            next_state <= "1";
         when "1" =>
            next_state <= "0";
			when others =>
				next_state <= "0";
      end case;      
   end process;
	
	with state select
		sdout <= '0' when "0",
					'1' when others;

end Behavioral;

