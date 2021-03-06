
-- Counter for the Oven project

library IEEE;
use IEEE.std_logic_1164.all;

entity Oven_count is
    port(reset, clk, start, stop, s30, s60, s120: in std_logic; 
         aboveth: out std_logic;
         seg_val_hex0 : out INTEGER range 0 to 127;
         seg_val_hex1 : out INTEGER range 0 to 127;
         seg_val_hex2 : out INTEGER range 0 to 127
         );
end Oven_count;

architecture Impl of Oven_count is
type States is (idle, counting, stopped);
signal state, nextstate: States;
signal c, nextc: natural range 0 to 120;
signal digit1,digit0 : natural range 0 to 10;

begin
  process (state, c, start, stop, s30, s60, s120)
  begin
    case state is
       when idle =>
          if start='1' then nextstate <= counting;
                            nextc <=  c+1; -- fill here
          else nextstate <= idle;
               nextc <=  0;-- fill here
          end if;
       when counting =>
          if stop = '1' then nextstate <= stopped;
                             nextc <= c; -- fill here
          elsif ((s30='1' and c >= 30) or (s60='1' and c >= 60) or 
                 (s120='1' and c >= 120)) then nextstate <= idle;
                                               nextc <= 0; -- fill
                                                           --here
          else nextstate <= counting;
               nextc <= c+1; -- fill here
          end if;
       when stopped =>
          if start='1' then nextstate <= counting;
                            nextc <= c+1;  -- fill here
          else nextstate <= stopped;
               nextc <= c; -- fill here
          end if;
    end case;
  end process; 
  process (reset, clk)
  begin
    -- if asynchronous reset
    if (reset = '0') then state <= idle;
                          c <= 0; -- fill here
    -- if rising edge
    elsif (clk'event and clk='1') then
        state <= nextstate;
        c <= nextc; -- fill here
    end if;
  end process;
  
  aboveth <= '1' when ((s30='1' and c >= 30) or (s60='1' and c >= 60) or 
                       (s120='1' and c >= 120)) else '0';

-- purpose: display the count number
-- type   : combinational
-- inputs : c
-- outputs: 
countdisplay: process (c)
begin  -- process contdisplay
  if c >= 100 then
    seg_val_hex2 <= 2#1001111#;
  else
    seg_val_hex2 <= 2#0000001#;
  end if;
  --digit0 <= (c rem 100)/10;
         
  case (c rem 100)/10 is
    when 0 =>
      seg_val_hex1 <= 2#0000001#;       --0
    when 1 =>
      seg_val_hex1 <= 2#1001111#;       --1
    when 2 =>
      seg_val_hex1 <= 2#0010010#;       --2
    when 3 =>
      seg_val_hex1 <= 2#0000110#;       --3
    when 4 =>
      seg_val_hex1 <= 2#0000001#;       --4
    when 5 =>
      seg_val_hex1 <= 2#0100100#;       --5
    when 6 =>
      seg_val_hex1 <= 2#0100000#;       --6
    when 7 =>
      seg_val_hex1 <= 2#0001111#;       --7
    when 8 =>
      seg_val_hex1 <= 2#0000000#;       --8
    when 9 =>
      seg_val_hex1 <= 2#0000100#;       --9
    when others =>
      seg_val_hex1 <= 2#1111111#;
  end case;


  
  --digit0 <= c rem 10;

  case c rem 10 is
    when 0 =>
      seg_val_hex0 <= 2#0000001#;       --0
    when 1 =>
      seg_val_hex0 <= 2#1001111#;       --1
    when 2 =>
      seg_val_hex0 <= 2#0010010#;       --2
    when 3 =>
      seg_val_hex0 <= 2#0000110#;       --3
    when 4 =>
      seg_val_hex0 <= 2#0000001#;       --4
    when 5 =>
      seg_val_hex0 <= 2#0100100#;       --5
    when 6 =>
      seg_val_hex0 <= 2#0100000#;       --6
    when 7 =>
      seg_val_hex0 <= 2#0001111#;       --7
    when 8 =>
      seg_val_hex0 <= 2#0000000#;       --8
    when 9 =>
      seg_val_hex0 <= 2#0000100#;       --9
    when others =>
      seg_val_hex0 <= 2#1111111#;
  end case;

end process countdisplay; 
  
end Impl; 
