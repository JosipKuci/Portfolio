----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Josip Simun Kuci
-- 
-- Create Date:    07:48:18 05/07/2023 
-- Design Name: 
-- Module Name:    Chaser - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: A simple LED chaser code made for the E2LP platform
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
use IEEE.NUMERIC_STD.ALL;


entity Chaser is
	port(
		clk,rst: in std_logic;
		led: out std_logic_vector(7 downto 0)
	);
end Chaser;

architecture Behavioral of Chaser is
signal temp: std_logic_vector(7 downto 0);
begin

	process(clk, rst)
	variable t: std_logic;
	begin
		if(rst='1') then
			temp<="00000001";
			t:='0';
		else if(clk'event and clk='1') then
			if(t='0') then
				temp(1) <= temp(0);
				temp(2) <= temp(1);
				temp(3) <= temp(2);
				temp(4) <= temp(3);
				temp(5) <= temp(4);
				temp(6) <= temp(5);
				temp(7) <= temp(6);
				temp(0) <= temp(7);
				if(temp(6)='1') then
					t:='1';
				end if;
			else
				temp(0) <= temp(1);
				temp(1) <= temp(2);
				temp(2) <= temp(3);
				temp(3) <= temp(4);
				temp(4) <= temp(5);
				temp(5) <= temp(6);
				temp(6) <= temp(7);
				temp(7) <= temp(0);
				if(temp(1)='1') then
					t:='0';
				end if;
			end if;
			end if;
			end if;
	end process;
	led<=temp;
end Behavioral;

