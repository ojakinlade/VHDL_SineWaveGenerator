library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

entity bram_sp is
  generic(DATA_WIDTH: integer := 8;
          ADDR_WIDTH: integer := 8;
          NUM_ADDR: integer := 100);
  Port (clk: in std_logic;
        rst: in std_logic;
        rd_en: in std_logic;
        addr: in std_logic_vector(ADDR_WIDTH - 1 downto 0);
        data_out: out signed(DATA_WIDTH - 1 downto 0));
end bram_sp;

architecture bram_sp_rtl of bram_sp is
    type ram_type is array (0 to NUM_ADDR - 1) of 
                            signed(DATA_WIDTH - 1 downto 0);
    signal ram: ram_type := ((others => (others => '0')));
    signal data: signed(DATA_WIDTH - 1 downto 0) := (others => '0');
begin 
    
    -- Initialize sine data in RAM
    sine_data_init: process(rst)
    begin
        if rst = '1' then
            for i in 0 to NUM_ADDR - 1 loop
                ram(i) <= (others => '0');
            end loop;
        else
            for i in 0 to NUM_ADDR - 1 loop
                ram(i) <= to_signed(integer(real(32767.0 * sin((real(i) * 3.14159) / 180.0))), ram(i)'length);
            end loop;
        end if;
    end process;
    
    proc_ram: process(clk)
    begin
        if rising_edge(clk) then
            if rd_en = '1' then
                data <= ram(to_integer(unsigned(addr)));
            end if;
        end if;
    end process;
    data_out <= data;
end bram_sp_rtl;
