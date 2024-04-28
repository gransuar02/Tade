----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:31:55 02/27/2019 
-- Design Name: 
-- Module Name:    lcd - Behavioral 
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

entity lcd is
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
end lcd;

architecture Behavioral of lcd is

	COMPONENT lcd_host_if
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		data : IN std_logic_vector(7 downto 0);
		addr : IN std_logic_vector(4 downto 0);
		auto : IN std_logic;
		wr : IN std_logic;
		done : IN std_logic;          
		ack : OUT std_logic;
		byte : OUT std_logic_vector(7 downto 0);
		mode : OUT  std_logic;
		stb : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT lcd_init_fsm
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		done : IN std_logic;          
		rdy : OUT std_logic;
		byte : OUT std_logic_vector(7 downto 0);
		mode : OUT  std_logic;
		stb : OUT std_logic
		);
	END COMPONENT;	
	
	COMPONENT lcd_tx_fsm
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		byte : IN std_logic_vector(7 downto 0);
		stb : IN std_logic;
		mode : IN std_logic;          
		done : OUT std_logic;
		data : OUT std_logic_vector(7 downto 0);
		rs : OUT std_logic;
		en : OUT std_logic
		);
	END COMPONENT;	
	
	signal lcdrdy : std_logic;

	signal txstb : std_logic;
	signal hstb : std_logic;
	signal istb : std_logic;
	signal txmode : std_logic;
	signal hmode : std_logic;
	signal imode : std_logic;
	signal txdone : std_logic;
	
	signal txbyte : std_logic_vector(7 downto 0);
	signal hbyte : std_logic_vector(7 downto 0);
	signal ibyte : std_logic_vector(7 downto 0);
	
	constant LCD_WRITE_ONLY : std_logic := '0';
	constant SF_DISABLED : std_logic := '1';
	
begin

	rw <= LCD_WRITE_ONLY;
	sfce <= SF_DISABLED;
	
	rdy <= lcdrdy;
	
	txstb <= istb when lcdrdy = '0' else hstb;
	txmode <= imode when lcdrdy = '0' else hmode;
	txbyte <= ibyte when lcdrdy = '0' else hbyte;
	
	Inst_lcd_tx_fsm: lcd_tx_fsm PORT MAP(
		clk => clk,
		rst => rst,
		byte => txbyte,
		stb => txstb,
		mode => txmode,
		done => txdone,
		data => data,
		rs => rs,
		en => en
	);
	
	Inst_lcd_init_fsm: lcd_init_fsm PORT MAP(
		clk => clk,
		rst => rst,
		rdy => lcdrdy,
		byte => ibyte,
		stb => istb,
		mode => imode,
		done => txdone
	);
	
	Inst_lcd_host_if: lcd_host_if PORT MAP(
		clk => clk,
		rst => rst,
		data => byte,
		addr => addr,
		auto => auto,
		wr => wr,
		ack => ack,
		byte => hbyte,
		stb => hstb,
		mode => hmode,
		done => txdone
	);	

end Behavioral;

