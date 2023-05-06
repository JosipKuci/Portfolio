----------------------------------------------------------------------------------
-- Engineer: Josip Simun Kuci
-- Create Date:    15:52:11 05/06/2023 
-- Module Name:    Counter - Behavioral 
-- Project Name: Johnson Counter
-- Description: A simple Johnson counter made to be implemented on the E2LP development system using its LED diodes
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Counter is
	Port   (clk: in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           y : out  STD_LOGIC_VECTOR (7 downto 0)
			  );

end Counter;

architecture Behavioral of Counter is
	signal temp: std_logic_vector(7 downto 0):= "00000000";
	begin
		process(clk,rst)
		begin
			if rst = '1' then
				temp <= "00000001";
			elsif (clk'event and clk='1') then
				temp(1) <= temp(0);
				temp(2) <= temp(1);
				temp(3) <= temp(2);
				temp(4) <= temp(3);
				temp(5) <= temp(4);
				temp(6) <= temp(5);
				temp(7) <= temp(6);
				temp(0) <= not temp(7);
			end if;
		end process;
		y <= temp;
end Behavioral;

