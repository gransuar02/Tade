LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY LcdCtrFsm IS
    PORT (
        clk, rst : IN STD_LOGIC;
        rdy, ack : IN STD_LOGIC;
        wr : OUT STD_LOGIC;
        NextChar : OUT STD_LOGIC
    );
END LcdCtrFsm;

ARCHITECTURE arch OF LcdCtrFsm IS

    TYPE lcd_fsm_states IS (WAIT_RDY, WRITE_DATA, WAIT_ACK, NEXT_CHAR);

    SIGNAL lcd_curr_state : lcd_fsm_states;
    SIGNAL lcd_next_state : lcd_fsm_states;

BEGIN

    lcd_fsm_state_transition_logic : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF rst = '1' THEN
                lcd_curr_state <= WAIT_RDY;
            ELSE
                lcd_curr_state <= lcd_next_state;
            END IF;
        END IF;
    END PROCESS;

    lcd_fsm_next_state_logic : PROCESS (lcd_curr_state, rdy, ack)
    BEGIN
        lcd_next_state <= lcd_curr_state;
        CASE lcd_curr_state IS
            WHEN WAIT_RDY =>
                IF rdy = '1' THEN
                    lcd_next_state <= WRITE_DATA;
                END IF;

            WHEN WRITE_DATA =>
                lcd_next_state <= WAIT_ACK;

            WHEN WAIT_ACK =>
                IF ack = '1' THEN
                    lcd_next_state <= NEXT_CHAR;
                END IF;

            WHEN NEXT_CHAR =>
                lcd_next_state <= WRITE_DATA;

            WHEN OTHERS =>
                lcd_next_state <= WAIT_RDY;

        END CASE;
    END PROCESS;

    wr <= '1' WHEN lcd_curr_state = WRITE_DATA ELSE
        '0';
    NextChar <= '1' WHEN lcd_curr_state = NEXT_CHAR ELSE
        '0';

    END ARCHITECTURE;