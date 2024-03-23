----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:26:39 03/22/2024 
-- Design Name: 
-- Module Name:    RAM - Behavioral 
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

entity RAM is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           en : in  STD_LOGIC;
           wr : in  STD_LOGIC;
           rd : in  STD_LOGIC;
           din : in  STD_LOGIC_VECTOR (31 downto 0);
           addr : in  STD_LOGIC_VECTOR (7 downto 0);
           dout : out  STD_LOGIC_VECTOR (31 downto 0));
end RAM;

architecture Behavioral of RAM is
type ram_type is array (255 downto 0) of std_logic_vector (31 downto 0);
signal RAM: ram_type;
signal count: integer:= 0;
begin

	process(clk, rst)
	begin
		if(rising_edge (clk))then
			if(rst = '1')then
				for count in 0 to 255 loop
					RAM(count) <= (others => '0');
				end loop;
				--addr <= (others => '0');
			elsif(en = '1')then
				if(rd = '1')then
					dout <= RAM(conv_integer(addr));
				elsif(wr = '1')then
					RAM(conv_integer(addr)) <= din;
				end if;
			end if;
		end if;
	end process;



end Behavioral;

