library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

entity SineWaveGen is
  generic(DATA_WIDTH: integer := 16;
          ADDR_WIDTH: integer := 9;
          NUM_ADDR: integer := 360);
  Port (clk: in std_logic;
        rst: in std_logic;
        sine_out: out signed(15 downto 0));
end SineWaveGen;

architecture rtl of SineWaveGen is
    signal addr: std_logic_vector(ADDR_WIDTH - 1 downto 0);
begin
    RAM: entity work.bram_sp(bram_sp_rtl)
    generic map(DATA_WIDTH => DATA_WIDTH, ADDR_WIDTH => ADDR_WIDTH, NUM_ADDR => NUM_ADDR)
    port map(clk => clk,
             rst => rst,
             rd_en => '1',
             addr => addr,
             data_out => sine_out);
             
    ADDR_GEN: entity work.addrGen(addrGen_rtl)
    generic map(ADDR_WIDTH => ADDR_WIDTH, NUM_ADDR => NUM_ADDR)
    port map(clk => clk,
             rst => rst,
             en => '1',
             addr => addr);
end rtl;
