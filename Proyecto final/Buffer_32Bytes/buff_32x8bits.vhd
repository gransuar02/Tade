----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:34:18 03/24/2024 
-- Design Name: 
-- Module Name:    buff_32x8bits - Behavioral 
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
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity buff_32x8bits is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  en : in  STD_LOGIC;
           we : in  STD_LOGIC;
           din : in  STD_LOGIC_VECTOR (7 downto 0);
           addr : in  STD_LOGIC_VECTOR (4 downto 0);
           dout : out  STD_LOGIC_VECTOR (7 downto 0));
end buff_32x8bits;

architecture Behavioral of buff_32x8bits is

type buff_type is array(31 downto 0) of std_logic_vector(7 downto 0);
signal BUFF: buff_type;

begin

	process(clk,rst,en)
	variable i: integer:= 0;
	begin
		if(rising_edge(clk))then
			if(rst = '1')then
				for i in 0 to 31 loop
					BUFF(i) <= (others => '0');
				end loop;
			elsif(en = '1')then
				if(we = '1')then
					BUFF(conv_integer(addr)) <= din;
				else
					dout <= BUFF(conv_integer(addr));
				end if;
			end if;
		end if;
	end process;
			

end Behavioral;

