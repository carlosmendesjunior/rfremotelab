%%% Warning Functions
%%% Eindhoven Unversity of Technology
%%% Author: Dr. Carlos Mendes, Jr.

1; % not a function file, but a file with a set of functions

function warning_voltage(volts)

  len = length(volts);
  for i = 1:len
    if (volts(i) > 5)
		beep();
		error('Voltage is too high');
    end
  end
  
end

function short_circuit()
  
  global Mat_Int_Val;
  global Mat_Ext_Val;
  global Res_Val;
  
  if any(Mat_Ext_Val(end-1,:) & Mat_Ext_Val(end,:))
    error('VDD and GND short circuit!');
  end
  
  if any(sum(Mat_Ext_Val(1:4,:)) > 1 )
    error('VDD and GND short circuit!');
  end
  
  % 5 volts on 50 ohms resistor --> 100 mA
  % Maximum rating of the switch is 200 mA
  % CD4007 maximum rating is only 10 mA
  % Potentiometer has maximum rating of +-20 mA
  
  % get col and row and check for short circuits
  % get value of the resistor and check current
  % I need to define combinations of short circuits
  
end

function warning_ext_matrix()
  
  global Mat_Ext_Val;

  for i = 1:8
    if sum(Mat_Ext_Val(:,i)) > 1
      error('Only one connection per column.');
    end
  end
  
  % --> For the rows
  
end

function warning_voltage_low(volt)
											   
  len = length(volt);
  for i = 1:len
    if (volt(i) < 0)
      beep();
      error('Voltage is too low');
    end
  end
  
end

function warning_steps(steps)
  
  len = length(steps);

  for i = 1:len
    if (steps(i) > 20)
      beep();
      error('Amount of steps is too high!');
    elseif (steps(i) < 1)
      beep();
      error('Amount of steps is too low!');
    end
  end
  
end

function warning_sweep(min,max)
  
    if (min > max)
      beep();
      error('Vmin > Vmax!');
    end
  
end

function warning_frequency_low(min,max)
   
    if (min < 0)
      beep();
      error('minF < 0!');
    elseif (max < 0)
      beep();
      error('maxF < 0!');
    endif
end

function warning_frequency_high(min,max)
   
    if (min > 900*(10^6))
      beep();
      error('minF > 900 MHz!');
    elseif (max > 900*(10^6))
      beep();
      error('maxF > 900 Mhz!');
    endif
end