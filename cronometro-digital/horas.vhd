----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:21:33 03/10/2024 
-- Design Name: 
-- Module Name:    horas - Behavioral 
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

entity horas is
	 generic(h: integer:= 8);
    Port ( init_pause : in  STD_LOGIC;
           stop : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           sdout : out  STD_LOGIC_VECTOR (h-1 downto 0));
end horas;

architecture hoursArch of horas is

component minutos
	generic(b: integer:= 8);
	port(
		init_pause,stop,clk: in std_logic;
		sdout: out std_logic_vector(b-1 downto 0)
		);
end component;
constant max_count: integer:= 3;
signal clk_div: std_logic:= '0';
signal count3: integer range 0 to max_count;


begin

Div3: process(clk, stop) is
begin
	if(clk'event and clk = '1') then
		if(stop = '1') then
			clk_div <= '0';
			count3 <= 0;
		elsif(count3 = max_count) then
			clk_div <= not clk_div;
			count3 <= 0;
		else
			count3 <= count3 + 1;
		end if;
	end if;
end process;

minutes: minutos
	port map(
		init_pause => init_pause,
		stop => stop,
		clk => clk_div,
		sdout => sdout
		);
			

end hoursArch;

