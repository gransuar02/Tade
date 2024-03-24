--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:56:42 03/24/2024
-- Design Name:   
-- Module Name:   /home/ise/Proyectos/PE2/Buffer_32Bytes/buff_sim.vhd
-- Project Name:  Buffer_32Bytes
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: buff_32x8bits
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY buff_sim IS
END buff_sim;
 
ARCHITECTURE behavior OF buff_sim IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT buff_32x8bits
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         en : IN  std_logic;
         we : IN  std_logic;
         din : IN  std_logic_vector(7 downto 0);
         addr : IN  std_logic_vector(4 downto 0);
         dout : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal en : std_logic := '0';
   signal we : std_logic := '0';
   signal din : std_logic_vector(7 downto 0) := (others => '0');
   signal addr : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal dout : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: buff_32x8bits PORT MAP (
          clk => clk,
          rst => rst,
          en => en,
          we => we,
          din => din,
          addr => addr,
          dout => dout
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      rst <= '1';
      wait for 25 ns;
		rst <= '0';
		en <= '1';
		we <= '1';
		
		din <= x"0A";
		addr <= "00000";
		wait for clk_period;
		
		din <= x"CB";
		addr <= "00001";
		wait for clk_period;
		
		din <= x"04";
		addr <= "00010";
		wait for clk_period;
		
		din <= x"F3";
		addr <= "00011";
		wait for clk_period;
		en <= '0';
		
		wait for clk_period*5;
		
		en <= '1';
		we <= '0';
		addr <= "00011";
		wait for clk_period;
		
		addr <= "00001";
		wait for clk_period;
		
		addr <= "00000";
		wait for clk_period*2;
		
		rst <= '1';
		

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
