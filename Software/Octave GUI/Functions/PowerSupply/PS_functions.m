%% Power supply functions
% Author: L.B.B. van Mulken
% Remote Lab
1;

function DC_measurement()
% Open waitbar
  f = waitbar(0,'Please wait...', 'position', [845 500 400 100]);
  waitbar(0,f,'Loading data');
  pause(0.1) % 1
   
% Variables
  global ps;
  global ar;
  ar.pin = '1';
  
% Create matrices to store variables
  ps.vout = 0;
  ps.vin = linspace(ps.sweepVstart,ps.sweepV,ps.sweepSteps);
   
% Initialization
  PS_init();
  
% Initialize P6V and set max current
  fprintf (ps.serial,  'INST P6V');
  fprintf (ps.serial,  'CURR 0.1');
  
% Sweep loop
  for n = 1:ps.sweepSteps
    % Update waitbar  
    waitbar((n)/ps.sweepSteps,f,'Measuring step...');
    % Set P6V to sweepvoltage
    ps.sixV = ps.vin(n);
    PS_set_6();
    pause(1);  
    %% Current not working due to circuit board.
##    fprintf (ps.serial,'INST P25V'); % CHANGE THE POWER SUPPLY BACK 
##    % Update waitbar     
##    Put waitbar here
##    % Wait for current to update    
##    pause(2);
##    % Update waitbar   
##    Put waitbar here
##    % Read current
##    ps.i(n) = str2num(char(PS_read(ps.serial)));
##    % Read voltage
    pause(2); % 1
    ps.vout(n) = octave2arduino(ar.port,'v',ar.pin);
    
    fprintf (ps.serial,'INST P6V');    
  end
  
##  % Normalize Current
##  ps.i = ps.i - ps.i(1);
    
% Turn off output power supply (remove when not necessary) and close connection
  pause(1); % 5
  fprintf(ps.serial,'OUTP OFF'); 
   
% Close waitbar
  waitbar(1,f,'Done');
  pause(0.1); % 2
  close(f);
 end
 
function PS_init()
   % Variables
   global ps; 
   % Initialize
   ps.serial = serialport(ps.port, 9600);
   set(ps.serial, 'timeout', 10);
   fprintf(ps.serial, 'SYSTem:REMote'); % Set the power supply to remote control,                                
end

function PS_set_25()
  % Variable
  global ps;
  % Open waitbar 
  f = waitbar(0,'Please wait...', 'position', [725 500 400 100]);
  waitbar(0,f,'Loading your data');
  pause(1)
  % Set max values  
  ps.MAX_V = 5;  
  % Initialize serial
  PS_init();
  % Create Strings
  VPLUS = cstrcat('VOLT ',num2str(ps.Vdd));        % P25V
  CURRENT6 = cstrcat('CURR ',num2str(ps.max_cur)); % Current
  % Set Voltage P25V
  fprintf (ps.serial,'INST P25V');
  fprintf (ps.serial,VPLUS);
  fprintf (ps.serial,CURRENT6);
  fprintf (ps.serial,'OUTP ON');      % Turn on power supply
end


function PS_set_6()
  % Variable
  global ps;
  % Initialize serial
  PS_init();  
  % Check if P6V does not exceed max. voltage.
  VPLUS6 = cstrcat('VOLT'," ",num2str(ps.sixV));      % P6V
  CURRENT6 = cstrcat('CURR'," ",num2str(ps.max_cur)); % Current
  % Set voltage P6V
  fprintf (ps.serial,  'INST P6V');
  fprintf (ps.serial,  VPLUS6);
  fprintf (ps.serial,  CURRENT6);
  fprintf (ps.serial,'OUTP ON');   
end

function [current] = PS_read(session)
  fprintf(session, 'MEAS:CURRent:DC?');
  read_current = read(session,10000);
  current = char(read_current);
end

function PS_close(session)
    fprintf(session,'OUTP OFF'); 
%    fclose(session); 
endfunction