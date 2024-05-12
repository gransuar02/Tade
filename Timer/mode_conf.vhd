----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    06:32:18 05/05/2024 
-- Design Name: 
-- Module Name:    mode_conf - Behavioral 
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

entity mode_conf is
    Port ( en : in  STD_LOGIC;
			  clk: in std_logic;
			  rst: in std_logic;
			  wr_thi,wr_tli: in std_logic;
           mode : in  STD_LOGIC_VECTOR (1 downto 0);
           thi : in  STD_LOGIC_VECTOR (7 downto 0);
           tli : in  STD_LOGIC_VECTOR (7 downto 0);
           tho : out  STD_LOGIC_VECTOR (7 downto 0);
           tlo : out  STD_LOGIC_VECTOR (7 downto 0);
           tf : out  STD_LOGIC);
end mode_conf;

architecture Behavioral of mode_conf is

signal count_reg, count_next,count_next_2: std_logic_vector(15 downto 0);
signal filter_edge_reg, filter_edge_next: std_logic_vector(7 downto 0);
signal f_en_reg, f_en_next, fall_edge: std_logic;
signal flag, flag_next: std_logic;

begin

--MEMORIA DE ESTADO--
NEXT_STATE_LOGIC:process(clk)
begin
	
	if(rising_edge(clk))then
		if(rst = '0')then
			count_reg <= (others => '0');
			filter_edge_reg <= (others => '0');
			f_en_reg <= '0';
			flag <= '0';
		else
			count_reg <= count_next;
			filter_edge_reg <= filter_edge_next;
			f_en_reg <= f_en_next;
			flag <= flag_next;
		end if;
	end if;
end process;

--CLC DEL PROXIMO ESTADO
--LOGICA DEL FRENTE DE CAIDA DE EN
filter_edge_next <= en & filter_edge_reg(7 downto 1);

with filter_edge_reg select
	f_en_next <= '1' when "11111111",
					 '0' when "00000000",
					 f_en_reg when others;

fall_edge <= f_en_reg and (not f_en_next);

MODE_STATE_LOGIC:process(mode,fall_edge,count_reg,count_next_2,flag)
begin
	
	count_next <= count_next_2;
	flag_next <= flag;
	
	if(fall_edge = '1')then	
		flag_next <= '0';
		
		case(mode)is
			when "01" =>									--MODO 1: CONTADOR/TIMER DE 16 BITS SIN RECARGA
				if(count_reg = x"FFFF")then
					count_next <= x"0000";
					flag_next <= '1';
				else
					count_next <= count_reg + 1;
				end if;				
			
			when "10" =>									-- MODO 2: CONTADOR/TIMER DE 8 BITS CON AUTORECARGA
				if(count_reg(7 downto 0) = x"FF")then
					count_next(7 downto 0) <= count_reg(15 downto 8);
					flag_next <= '1';
				else
					count_next(7 downto 0) <= count_reg(7 downto 0) + 1;
				end if;
			
			when others =>						--EN CUALQUIER OTRO CASO, EL TIMER NO CUENTA
				count_next <= x"0000";
			
		end case;
	end if;
end process;

count_next_2(7 downto 0) <= tli when wr_tli = '1' else count_reg(7 downto 0);
count_next_2(15 downto 8) <= thi when wr_thi = '1' else count_reg(15 downto 8);


--CLC DE SALIDA
tlo <= count_reg(7 downto 0);
tho <= count_reg(15 downto 8);
tf <= flag;			

end Behavioral;

