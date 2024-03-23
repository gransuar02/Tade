--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:21:10 03/23/2024
-- Design Name:   
-- Module Name:   /home/ise/Proyectos/PE2/CC/noise_sup_sim.vhd
-- Project Name:  CC
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: noise_suppressor
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY noise_sup_sim IS
END noise_sup_sim;
 
ARCHITECTURE behavior OF noise_sup_sim IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT noise_suppressor
    PORT(
         i_clk : IN  std_logic;
         i_rst : IN  std_logic;
         i_data : IN  std_logic;
         o_data : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal i_clk : std_logic := '0';
   signal i_rst : std_logic := '0';
   signal i_data : std_logic := '0';

 	--Outputs
   signal o_data : std_logic;

   -- Clock period definitions
   constant i_clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: noise_suppressor PORT MAP (
          i_clk => i_clk,
          i_rst => i_rst,
          i_data => i_data,
          o_data => o_data
        );

   -- Clock process definitions
   i_clk_process :process
   begin
		i_clk <= '0';
		wait for i_clk_period/2;
		i_clk <= '1';
		wait for i_clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
	
      i_rst <= '1';
      wait for 70 ns;
		
		i_rst <= '0';
		wait for 10 ns;
		
		i_data <= '1';
		wait for 5 ns;
		i_data <= '0';
		wait for 5 ns;
		
		i_data <= '1';
		wait for 10 ns;
		i_data <= '0';
		wait for 5 ns;
		
		i_data <= '1';
		wait for 20 ns;
		i_data <= '0';
		wait for 10 ns;
		
		if(o_data /= '0')then
			report "ERROR: count 2";
		else
			report "PASS: count 2";
		end if;
		
		i_data <= '1';
		wait for i_clk_period*30;
		
		if(o_data /= '1')then
			report "ERROR: count 20";
		else
			report "PASS: count 20";
		end if;
		
		i_data <= '0';
		wait for 2 ns;
		i_data <= '1';
		wait for i_clk_period;
		
		i_data <= '0';
		wait for 5 ns;
		i_data <= '1';
		wait for i_clk_period/2;
		
		i_data <= '0';
		wait for 10 ns;
		i_data <= '1';
		wait for i_clk_period/4;
		i_data <= '0';
		
		if(o_data /= '1')then
			report "ERROR: count 30";
		else
			report "PASS: count 30";
		end if;

      wait for i_clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
