library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_Basys3 is
    Port (
        clk       : in  STD_LOGIC;  -- 100 MHz clock
        reset     : in  STD_LOGIC;  -- Reset button
        car       : in  STD_LOGIC;  -- Car sensor input
        pedestrian: in  STD_LOGIC;  -- Pedestrian button input
        red       : out STD_LOGIC;  -- Red light output
        yellow    : out STD_LOGIC;  -- Yellow light output
        green     : out STD_LOGIC   -- Green light output
    );
end top_Basys3;

architecture Behavioral of top_Basys3 is

    -- Internal signals
    signal slow_clk : STD_LOGIC;
    signal fsm_red, fsm_yellow, fsm_green : STD_LOGIC;

    -- Component declaration for FSM
    component stoplight_fsm
        Port (
            clk       : in  STD_LOGIC;
            reset     : in  STD_LOGIC;
            car       : in  STD_LOGIC;
            pedestrian: in  STD_LOGIC;
            red       : out STD_LOGIC;
            yellow    : out STD_LOGIC;
            green     : out STD_LOGIC
        );
    end component;

    -- Component declaration for Clock Divider
    component clock_divider
        generic ( k_DIV : natural := 50_000_000 );  -- 1Hz clock output
        port (
            i_clk   : in  std_logic;  -- 100 MHz clock
            i_reset : in  std_logic;  -- Asynchronous reset
            o_clk   : out std_logic   -- Divided clock output
        );
    end component;

begin

    -- Instantiate the Clock Divider
    CLK_DIV: clock_divider
        generic map ( k_DIV => 50_000_000 )  -- 1Hz clock
        port map (
            i_clk   => clk,     -- 100 MHz input
            i_reset => reset,   -- Reset input
            o_clk   => slow_clk -- 1Hz output
        );

    -- Instantiate the FSM
    FSM: stoplight_fsm
        port map (
            clk        => slow_clk,  -- Use divided 1Hz clock
            reset      => reset,
            car        => car,
            pedestrian => pedestrian,
            red        => fsm_red,
            yellow     => fsm_yellow,
            green      => fsm_green
        );

    -- Assign FSM outputs to top-level outputs
    red    <= fsm_red;
    yellow <= fsm_yellow;
    green  <= fsm_green;

end Behavioral;
