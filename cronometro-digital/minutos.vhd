----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:17:26 03/10/2024 
-- Design Name: 
-- Module Name:    minutos - minArch 
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

entity minutos is
	 generic(b: integer:= 8);
    Port ( init_pause : in  STD_LOGIC;
           stop : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           sdout : out std_logic_vector(b-1 downto 0)
           );
end minutos;

architecture minArch of minutos is
component counter
	generic(n: integer:= 8);
	port(
		init_pause,stop,clk: in std_logic;
		led_out: out std_logic_vector(n-1 downto 0)
		);
end component;
constant max_count: integer:= 10;
signal clk_div: std_logic:= '0';
signal count10: integer range 0 to max_count;

begin

Div_10: process(clk, stop) is
begin
			if(clk'event and clk = '1') then
					if(stop = '1') then
						clk_div <= '0';
			
					elsif(count10 = max_count) then
						clk_div <= not clk_div;
						count10 <= 0;
					else
						count10 <= count10 + 1;
					end if;
				end if;
end process;

segundos: counter
	port map(
		init_pause => init_pause,
		stop => stop,
		clk => clk_div,
		led_out => sdout
		);


end minArch;

