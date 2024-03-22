----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:24:59 03/10/2024 
-- Design Name: 
-- Module Name:    chrono - Behavioral 
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

entity chrono is
    Port ( init_pause : in  STD_LOGIC;
           stop : in  STD_LOGIC;
			  sel0: in std_logic;
			  sel1: in std_logic;
           clk : in  STD_LOGIC;
           led0 : out  STD_LOGIC;
           led1 : out  STD_LOGIC;
           led2 : out  STD_LOGIC;
           led3 : out  STD_LOGIC;
           led4 : out  STD_LOGIC;
           led5 : out  STD_LOGIC;
           led6 : out  STD_LOGIC;
           led7 : out  STD_LOGIC);
end chrono;

architecture Behavioral of chrono is
component counter
	generic(n: integer:= 8);
	port(
		init_pause,stop,clk: in std_logic;
		led_out: out std_logic_vector(n-1 downto 0)
		);
end component;

component minutos
	generic(b: integer:= 8);
	port(
		init_pause,stop,clk: in std_logic;
		sdout: out std_logic_vector(b-1 downto 0)
		);
end component;

component horas
	generic(h: integer:= 8);
	port(
		init_pause,stop,clk: in std_logic;
		sdout: out std_logic_vector(h-1 downto 0)
		);
end component;

component mux_8bits
	generic(r: integer:= 8);
	port(
		in0, in1, in2: in std_logic_vector(r-1 downto 0);
		sel: in std_logic_vector(1 downto 0);
		data_out: out std_logic_vector(r-1 downto 0)
		);
end component;

signal inter0,inter1,inter2: std_logic_vector(7 downto 0);

begin		

seconds: counter
	port map(
		init_pause => init_pause,
		stop => stop,
		clk => clk,
		led_out => inter0
		);

minutes: minutos
	port map(
		init_pause => init_pause,
		stop => stop,
		clk => clk,
		sdout => inter1
		);

hours: horas
	port map(
		init_pause => init_pause,
		stop => stop,
		clk => clk,
		sdout => inter2
		);
		
mux: mux_8bits
	port map(
		in0 => inter0,
		in1 => inter1,
		in2 => inter2,
		sel(0) => sel0,
		sel(1) => sel1,
		data_out(0) => led0,
		data_out(1) => led1,
		data_out(2) => led2,
		data_out(3) => led3,
		data_out(4) => led4,
		data_out(5) => led5,
		data_out(6) => led6,
		data_out(7) => led7
		);
		

end Behavioral;

