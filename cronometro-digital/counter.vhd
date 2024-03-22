----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:03:35 03/08/2024 
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
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
	 generic(n: integer:= 8);
    Port ( init_pause : in  STD_LOGIC;
           stop : in  STD_LOGIC;
           clk50MHz : in  STD_LOGIC;
           led_out : out std_logic_vector(n-1 downto 0)
			  );
end counter;

architecture Behavioral of counter is
 
signal state, next_state : std_logic_vector(1 downto 0);
constant max_count : integer := 50000000;                 --Maxima cantidad de ciclos para hacer 500ms
signal count: integer range 0 to max_count;					 --Contador para el divisor de frecuencia
signal sdout: std_logic_vector(7 downto 0) := "00000000";

begin

SYNC_PROC: process(clk50MHz, stop) is
begin
	if(clk50MHz'event and clk50MHz = '1') then
		if(stop = '1') then
			state <= "00";									--Estado inicial
			sdout <= "00000000";
		elsif(count = max_count) then					--Cada 500ms detecta una subida de reloj
			count <= 0;
			state <= next_state;							--Pasa al proximo estado
			if(sdout = "11111111") then				--Si el contador llega al maximo vuelve al inicio
				sdout <= "00000000";
			elsif(state = "01") then					--Sigue contando
				sdout <= sdout + "00000001";
			end if;
		else
			count <= count + 1;							
		end if;
	end if;
end process;

--"00"=> Inicio
--"01"=> Contar
--"10"=> Pausar

STATE_PROC: process(state, init_pause) is
begin
	next_state <= state;
	
	case(state) is
		when "00" =>							--Estado inicial
			if(init_pause = '1') then
				next_state <= "01";
			end if;
		when "01" =>							--El cronometro empieza a contar
			if(init_pause = '1') then
				next_state <= "10";				--Pausar
			end if;
		when "10" =>							--Cronometro en pausa
			if(init_pause = '1') then		
				next_state <= "01";				--Reanudar cuenta
			end if;
		when others =>
			next_state <= "00";				--Reiniciar
	end case;
end process;

led_out <= sdout;
				
end Behavioral;

