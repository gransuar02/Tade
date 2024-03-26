----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:41:05 03/19/2024 
-- Design Name: 
-- Module Name:    counter - Behavioral 
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
use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
	 generic(g_DataSize: integer:= 8);
	 
    Port ( i_en : in  STD_LOGIC;
           i_data : in  STD_LOGIC_VECTOR (g_DataSize - 1 downto 0);
           i_clk : in  STD_LOGIC;
           i_rst : in  STD_LOGIC;
           o_data : out  STD_LOGIC_VECTOR (g_DataSize - 1 downto 0);
           o_end : out  STD_LOGIC);
end counter;

architecture Behavioral of counter is
signal sdout: std_logic_vector(g_DataSize - 1 downto 0):= (others => '0');
signal pulse: std_logic:= '0';
signal state, next_state: std_logic_vector(1 downto 0);

begin

process(i_clk, i_rst) is
begin
  
	  if(i_clk'event and i_clk = '1')then
			if(i_rst = '1')then
				sdout <=(others => '0');
				pulse <= '0';
				state <= "00";
			elsif(rising_edge(i_clk))then
				state <= next_state;
				if(sdout = i_data)then
					pulse <= '1';
				   sdout <= (others => '0');
				elsif(state = "01")then
					sdout <= sdout + 1;
				end if;
			end if;
		end if;
					
end process;

STATE_PROC:process(state,next_state)is
begin
	next_state <= state;
	
	case(state)is
		when "00" =>
			if(i_en = '1') then
				next_state <= "01";
			end if;
		when "01" =>							--El cronometro empieza a contar
			if(i_en = '1') then
				next_state <= "10";				--Pausar
			end if;
		when "10" =>							--Cronometro en pausa
			if(i_en = '1') then		
				next_state <= "01";				--Reanudar cuenta
			end if;
		when others =>
			next_state <= "00";				--Reiniciar
	end case;
end process;

o_data <= sdout;
o_end <= pulse;
				
				

end Behavioral;

