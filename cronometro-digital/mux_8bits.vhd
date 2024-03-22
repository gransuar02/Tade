----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:06:00 03/11/2024 
-- Design Name: 
-- Module Name:    mux_8bits - muxArch 
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

entity mux_8bits is
	 generic(r: integer := 8);
    Port ( in0 : in  STD_LOGIC_VECTOR (r-1 downto 0);
           in1 : in  STD_LOGIC_VECTOR (r-1 downto 0);
           in2 : in  STD_LOGIC_VECTOR (r-1 downto 0);
           sel : in  std_logic_vector(1 downto 0);
           data_out : out std_logic_vector(r-1 downto 0)
			  );
end mux_8bits;

architecture muxArch of mux_8bits is

begin

with sel select
	data_out <= in1 when "01",
				   in2 when "10",
					in0 when others;

end muxArch;

