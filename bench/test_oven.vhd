library IEEE;
use IEEE.std_logic_1164.all;

library LIB_oven;

entity test_oven is
end test_oven;

architecture test1 of test_oven is

  component oven
    port (
      reset, clk, Half_power, Full_power, Start, s30, s60, s120, Time_set, Door_open : in  std_logic;
      Full, Half, In_light, Finished                                                 : out std_logic);
  end component;

  signal reset_sig, clk_sig, Half_power_sig, Full_power_sig, Start_sig, s30_sig, s60_sig, s120_sig, Time_set_sig, Door_open_sig : std_logic := '0';
  signal Full_sig, Half_sig, In_light_sig, Finished_sig : std_logic;

 signal Full_sig_binary, Half_sig_binary, In_light_sig_binary, Finished_sig_binary : std_logic;
 signal Full_sig_onehot, Half_sig_onehot, In_light_sig_onehot, Finished_sig_onehot : std_logic;
 signal Full_sig_gray, Half_sig_gray, In_light_sig_gray, Finished_sig_gray : std_logic;


-- PSL default clock is (clk_sig'event and clk_sig='1');
-- PSL property propOutputs is always( (Full_sig = Full_sig_binary and Full_sig_binary =  Full_sig_onehot and  Full_sig_onehot = Full_sig_gray ) and ( Half_sig = Half_sig_binary and Half_sig_binary = Half_sig_onehot and Half_sig_onehot = Half_sig_gray) and ( In_light_sig = In_light_sig_binary and In_light_sig_binary = In_light_sig_onehot and In_light_sig_onehot = In_light_sig_gray) and ( Finished_sig = Finished_sig_binary and Finished_sig_binary = Finished_sig_onehot and Finished_sig_onehot = Finished_sig_gray) );
-- PSL assert propOutputs;


 begin

 o:oven port map(reset_sig, clk_sig, Half_power_sig, Full_power_sig, Start_sig, s30_sig, s60_sig, s120_sig, Time_set_sig, Door_open_sig,Full_sig, Half_sig, In_light_sig, Finished_sig);


 binary:oven port map(reset_sig, clk_sig, Half_power_sig, Full_power_sig, Start_sig, s30_sig, s60_sig, s120_sig, Time_set_sig, Door_open_sig,Full_sig_binary, Half_sig_binary, In_light_sig_binary, Finished_sig_binary);

 onehot:oven port map(reset_sig, clk_sig, Half_power_sig, Full_power_sig, Start_sig, s30_sig, s60_sig, s120_sig, Time_set_sig, Door_open_sig,Full_sig_onehot, Half_sig_onehot, In_light_sig_onehot, Finished_sig_onehot);

 gray:oven port map(reset_sig, clk_sig, Half_power_sig, Full_power_sig, Start_sig, s30_sig, s60_sig, s120_sig, Time_set_sig, Door_open_sig,Full_sig_gray, Half_sig_gray, In_light_sig_gray, Finished_sig_gray);


clocktime: process 
begin  -- process clocktime
	wait for 500 ms;
    	clk_sig <= not clk_sig;
end process clocktime;	

reset_sig <= '1' after 1.25 sec , '0' after 2.25 sec;

Half_power_sig <='1' after 5.25 sec, '0' after 7.25 sec, '1' after 9.25 sec;

Full_power_sig <='1' after 7.25 sec, '0' after 9.25 sec ;


s30_sig <= '1' after 12.25 sec, '0' after 14.25 sec; 
s60_sig <= '1' after 15.25 sec;
s120_sig <= '1' after 14.25 sec, '0' after 15.25 sec; 



Time_set_sig <= '1' after 18.25 sec, '0' after 19.25 sec; 

Start_sig <= '1' after 23.25 sec,'0' after 25.25 sec, '1' after 31.25 sec, '0' after 32.25 sec ; 

Door_open_sig <= '1' after 16.25 sec, '0' after 17.25 sec,'1' after 18.25 sec, '0' after 20.25 sec,'1' after 21.25 sec,'0' after 22.25 sec, '1' after 26.25 sec,'0' after 30.25 sec,'1' after 90.25 sec,'0' after 91.25 sec; 

end test1;


library LIB_oven;
library LIB_oven_BENCH;

configuration config2 of LIB_oven_BENCH.test_oven is 
    for test1 

       for o:oven use configuration LIB_oven.config1;
	end for;
       for binary:oven use configuration LIB_oven.config_binary_encoding;
	end for;
       for onehot:oven use configuration LIB_oven.config_onehot_encoding;
	end for;
       for gray:oven use configuration LIB_oven.config_gray_encoding;
       	end for;

    end for; 
end config2; 







