----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    06:20:52 05/05/2024 
-- Design Name: 
-- Module Name:    tmr_top - Behavioral 
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

entity tmr_top is
    Port ( clk, rst : in  STD_LOGIC;
           t_pin : in  STD_LOGIC;
           c_t : in  STD_LOGIC;
           tr : in  STD_LOGIC;
           gate : in  STD_LOGIC;
           int_pin : in  STD_LOGIC;
			  wr_tli: in std_logic;
			  wr_thi: in std_logic;
           mode : in  STD_LOGIC_VECTOR (1 downto 0);
           thi : in  STD_LOGIC_VECTOR (7 downto 0);
           tli : in  STD_LOGIC_VECTOR (7 downto 0);
           tho : out  STD_LOGIC_VECTOR (7 downto 0);
           tlo : out  STD_LOGIC_VECTOR (7 downto 0);
           tf : out  STD_LOGIC);
end tmr_top;

architecture Behavioral of tmr_top is

component clock_divider
	generic( max_count: integer := 24);
	
	port ( clk : in  STD_LOGIC;
          rst : in  STD_LOGIC;
			 en : in std_logic;
          clk_out : out  STD_LOGIC);
end component;


component mode_conf
	Port ( en : in  STD_LOGIC;
			  clk: in std_logic;
			  rst: in std_logic;
			  wr_tli: in std_logic;
			  wr_thi: in std_logic;
           mode : in  STD_LOGIC_VECTOR (1 downto 0);
           thi : in  STD_LOGIC_VECTOR (7 downto 0);
           tli : in  STD_LOGIC_VECTOR (7 downto 0);
           tho : out  STD_LOGIC_VECTOR (7 downto 0);
           tlo : out  STD_LOGIC_VECTOR (7 downto 0);
           tf : out  STD_LOGIC);
end component;

signal clk_timer: std_logic;
signal mux_out, trig_out: std_logic;
signal and_out, or_out: std_logic;

begin

or_out <= (not gate) or int_pin;

and_out <= or_out and tr;

with c_t select
	mux_out <= clk_timer when '0',
				  t_pin when others;
				  
trig_out <= mux_out when and_out = '1' else 'Z';
				  

DIVISOR_1uS:clock_divider
	generic map(
			max_count => 24
			)
	port map(
				clk => clk,
				rst => rst,
				en => '1',
				clk_out => clk_timer);

MODO:mode_conf
	port map(
			en => trig_out,
			clk => clk,
			rst => rst,
			wr_tli => wr_tli,
			wr_thi => wr_thi,
			mode => mode,
			thi => thi,
			tli => tli,
			tho => tho,
			tlo => tlo,
			tf => tf);


end Behavioral;

