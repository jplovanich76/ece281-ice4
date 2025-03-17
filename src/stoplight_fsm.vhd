library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity stoplight_fsm is
    Port (
        clk       : in  STD_LOGIC;
        reset     : in  STD_LOGIC;
        car       : in  STD_LOGIC;
        pedestrian: in  STD_LOGIC;
        red       : out STD_LOGIC;
        yellow    : out STD_LOGIC;
        green     : out STD_LOGIC
    );
end stoplight_fsm;

architecture Behavioral of stoplight_fsm is
    type state_type is (S_RED, S_GREEN, S_YELLOW);
    signal current_state, next_state : state_type;

    signal count : INTEGER range 0 to 15 := 0;  -- Count directly in seconds (1Hz clock)

    constant RED_TIME    : INTEGER := 10;  -- 10 seconds
    constant GREEN_TIME  : INTEGER := 7;   -- 7 seconds
    constant YELLOW_TIME : INTEGER := 3;   -- 3 seconds

begin
    process (clk, reset)
    begin
        if reset = '1' then
            current_state <= S_RED;
            count <= 0;
        elsif rising_edge(clk) then
            if count >= RED_TIME and current_state = S_RED then
                current_state <= S_GREEN;
                count <= 0;
            elsif count >= GREEN_TIME and current_state = S_GREEN then
                current_state <= S_YELLOW;
                count <= 0;
            elsif count >= YELLOW_TIME and current_state = S_YELLOW then
                current_state <= S_RED;
                count <= 0;
            else
                count <= count + 1;
            end if;
        end if;
    end process;

    -- Output Logic
    process (current_state)
    begin
        case current_state is
            when S_RED =>
                red    <= '1';
                yellow <= '0';
                green  <= '0';

            when S_GREEN =>
                red    <= '0';
                yellow <= '0';
                green  <= '1';

            when S_YELLOW =>
                red    <= '0';
                yellow <= '1';
                green  <= '0';

            when others =>
                red    <= '1';
                yellow <= '0';
                green  <= '0';
        end case;
    end process;
end Behavioral;
