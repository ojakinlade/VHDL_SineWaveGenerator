library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity addrGen is
  generic(ADDR_WIDTH: integer := 8;
          NUM_ADDR: integer := 100);
  Port (clk: in std_logic;
        en: in std_logic;
        rst: in std_logic;
        addr: out std_logic_vector(ADDR_WIDTH - 1 downto 0));
end addrGen;

architecture addrGen_rtl of addrGen is
    signal addr_reg: unsigned(ADDR_WIDTH - 1 downto 0);
    signal addr_next: unsigned(ADDR_WIDTH - 1 downto 0);
    
begin   
    process(addr_reg)
    begin
        if addr_reg = to_unsigned(NUM_ADDR - 1, addr_reg'length) then
            addr_next <= (others => '0');
        else
            addr_next <= addr_reg + 1;
        end if;
    end process;
    
    addr <= std_logic_vector(addr_reg);
    address_register: process(clk,rst)
    begin
        if rst = '1' then
            addr_reg <= (others => '0');
        elsif rising_edge(clk) then
            if en = '1' then
                addr_reg <= addr_next;
            end if;
        end if;
    end process;
end addrGen_rtl;
