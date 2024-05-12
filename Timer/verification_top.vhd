----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:41:25 05/08/2024 
-- Design Name: 
-- Module Name:    verification_top - Behavioral 
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

entity verification_top is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           dout : out  STD_LOGIC_VECTOR (7 downto 0));
end verification_top;

architecture Behavioral of verification_top is

component clock_divider_ver
	
	port ( clk : in  STD_LOGIC;
          rst : in  STD_LOGIC;
			 en : in std_logic;
          c_out : out  STD_LOGIC);
end component;

component tmr_top
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
end component;

signal p_5Hz: std_logic;
constant low: std_logic:= '0';
constant high: std_logic:= '1';
constant mode_init: std_logic_vector(1 downto 0):= "10";
constant init_values: std_logic_vector(7 downto 0):= x"00";

begin

DIVISOR_5Hz:clock_divider_ver

	port map(
				clk => clk,
				rst => rst,
				en => '1',
				c_out => p_5Hz);
				
TIMER0:tmr_top
	port map(
		clk => clk,
		rst => rst,
		t_pin => p_5Hz,
		c_t => '1',
		tr => '1',
		gate => '0',
		int_pin => '0',
		wr_tli => '0',
		wr_thi => '0',
		mode => "10",
		tli => x"00",
		thi => x"00",
		tlo => dout
		);

end Behavioral;

