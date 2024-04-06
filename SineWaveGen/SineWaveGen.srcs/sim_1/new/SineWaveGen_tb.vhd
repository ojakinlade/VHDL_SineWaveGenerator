library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SineWaveGen_tb is
--  Port ( );
end SineWaveGen_tb;

architecture Behavioral of SineWaveGen_tb is
    constant CLK_PERIOD : time := 10 ns;
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal sine_out : signed(15 downto 0);


begin
    dut : entity work.SineWaveGen(rtl)
        port map (
            clk => clk,
            rst => rst,
            sine_out => sine_out
        );
    
    clk_process: process
    begin
        clk <= not clk;
        wait for CLK_PERIOD / 2;
    end process;
    
    stimulus: process
    begin
        rst <= '1';
        wait for CLK_PERIOD / 2;
        rst <= '0';
        wait;
    end process stimulus;
    
end Behavioral;
