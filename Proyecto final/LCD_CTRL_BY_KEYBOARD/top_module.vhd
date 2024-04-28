----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    05:03:05 04/21/2024 
-- Design Name: 
-- Module Name:    top_module - Behavioral 
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

entity top_module is
    Port ( ps2d : in  STD_LOGIC;
           ps2c : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           data : out  STD_LOGIC_VECTOR (7 downto 0);
           en : out  STD_LOGIC;
           rs : out  STD_LOGIC;
           rw : out  STD_LOGIC;
           sfce : out  STD_LOGIC);
end top_module;

architecture Behavioral of top_module is

component keyboard_receiver
	port ( clk, reset: in std_logic;
		ps2d, ps2c: in std_logic;   --key data, key clock
		rx_en : in std_logic ;
		rx_done_tick: out std_logic;
		dout: out std_logic_vector (7 downto 0)
		);
end component;

component buff_32x8bits
	Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  en : in  STD_LOGIC;
			  ack_tx: in std_logic;
           din : in  STD_LOGIC_VECTOR (7 downto 0);
			  rdy : out std_logic;
           dout : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component fsm
	port(
		din: in std_logic_vector(7 downto 0);
		en: in std_logic;
		clk: in std_logic;
		rst: in std_logic;
		data: out std_logic_vector(7 downto 0);
		addr_lcd: out std_logic_vector(4 downto 0);
		rdy, f_da: out std_logic
		);
end component;

component lcd
	Port ( --system signals
			  clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  --host signals
           byte : in  STD_LOGIC_VECTOR (7 downto 0);
           addr : in  STD_LOGIC_VECTOR (4 downto 0);
           auto : in  STD_LOGIC;
           wr : in  STD_LOGIC;
           ack : out  STD_LOGIC;
           rdy : out  STD_LOGIC;
			  --lcd signals
			  data : out  STD_LOGIC_VECTOR (7 downto 0);
           rs : out  STD_LOGIC;
           en : out  STD_LOGIC;
			  --configuration specific signals
           rw : out  STD_LOGIC;
           sfce : out  STD_LOGIC
			  );
end component;

signal keyboard_tx_done: std_logic;
signal ack_rx: std_logic;
signal data_key_buff: std_logic_vector(7 downto 0);
signal en_fsm: std_logic;
signal data_fsm: std_logic_vector(7 downto 0);
signal ascii_byte: std_logic_vector(7 downto 0);
signal address: std_logic_vector(4 downto 0);
signal en_lcd, auto_lcd: std_logic;
signal rdy_tx: std_logic;

begin


KEYBOARD_HOST:keyboard_receiver
port map(
		clk => clk,
		reset => rst,
		ps2d => ps2d,
		ps2c => ps2c,
		rx_en => rdy_tx,
		rx_done_tick => keyboard_tx_done,
		dout => data_key_buff
		);
		
BUFFER0:buff_32x8bits
port map(
		clk => clk,
		rst => rst,
		en => keyboard_tx_done,
		din => data_key_buff,
		ack_tx => ack_rx,
		rdy => en_fsm,
		dout => data_fsm
		);
		
TO_ASCII_FSM:fsm
port map(
		clk => clk,
		rst => rst,
		en => en_fsm,
		din => data_fsm,
		data => ascii_byte,
		addr_lcd => address,
		rdy => en_lcd,
		f_da => auto_lcd
		);
		
LCD_CTRL:lcd
port map(
		clk => clk,
		rst => rst,
		wr => en_lcd,
		auto => auto_lcd,
		byte => ascii_byte,
		addr => address,
		data => data,
		en => en,
		rs => rs,
		rw => rw,
		sfce => sfce,
		ack => ack_rx,
		rdy => rdy_tx
		);

end Behavioral;

