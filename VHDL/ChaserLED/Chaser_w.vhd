--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   08:55:49 05/07/2023
-- Design Name:   
-- Module Name:   /home/ise/ChaserLED/Chaser_w.vhd
-- Project Name:  ChaserLED
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Chaser
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Chaser_w IS
END Chaser_w;
 
ARCHITECTURE behavior OF Chaser_w IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Chaser
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         led : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal led : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Chaser PORT MAP (
          clk => clk,
          rst => rst,
          led => led
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin			
		rst<='1';
      wait for 100 ns;
		rst<='0';

      wait;
   end process;

END;
