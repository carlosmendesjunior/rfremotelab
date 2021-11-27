%%% Breadboard Library
%%% Eindhoven Unversity of Technology
%%% Authors: Prof. Dr. Peter Baltus
%%%          Dr. Carlos Mendes Jr.

1; # not a function file:

% Accessing the Microncontroller

function retval = cmd2uC(cmd)
  global ar;
  s3 = serial(ar.port,9600,5);
  pause(3);
  srl_write(s3,["/", "\n"]);
  srl_write(s3,[cmd, "\n"]);
  [a,l] = srl_read(s3,1000);
  retval = char(a);
  fclose(s3);
  clear s3;
endfunction

function init_uC(newPort)
  global ar;
  if (newPort != ar.port)
    ar.port = newport;
  endif;
  cmd2uC("/");       % Init firmware with default values
  cmd2uC("?3");      % activate ADC A3
  cmd2uC("!3=0");    % set output 3 to 0V
  cmd2uC("t=1000");  % set timebase to 1ms per sample (>> 104 us)
  cmd2uC("l=0");     % set trigger level to 0V
endfunction

function measTF(nrOfPoints)
  global Vins;
  global Vout;
  global Vmax;
  global R;
  global C;
  for Vin=1:nrOfPoints
    setVin(3,Vmax*(Vin-1)/(nrOfPoints-1));  % Only pin A3
    pause(R*C*1.5);                         % Pause for 1.5*RC seconds
    Vins(Vin)=Vmax*(Vin-1)/(nrOfPoints-1);
    Vout(Vin)=getVout();
  endfor
endfunction

function retval=getVout(ar)
  pin = ar.pin;
  retval=5*getPin(pin)/1023;               % Only pin A3
endfunction

function retval=getPin(nr)                  % Analog pin -> A#
  answer=cmd2uC(["?" int2str(nr)]);
  retval=str2double(answer);  
endfunction

function setVin(nr,newVoltage)              % Input in voltage (float)
  global Vmax;                              
  setPin(nr, round(255*newVoltage/Vmax));
endfunction

function setPin(nr,newValue)
  cmd2uC(["!" int2str(nr) "=" int2str(newValue)]);
endfunction

function setTimebase(newValue)
  cmd2uC(["t=" int2str(newValue)]);
endfunction

function setTriggerLevel(newValue)
  global Vmax;
  trig = (newValue*255)/Vmax;
  cmd2uC(["l=" int2str(trig)]);
endfunction

function capture()                   % Pin A3 only
  global Vout;                       % Vector size is 100
  a = cmd2uC("*");
  charNum = (length(a)/100);
  for i = 1:100
    temp = a((1+charNum*(i-1)):(charNum*i));
    Vout(i)=str2double(temp);
  endfor
endfunction

function setVds(newVoltage)
  global Vmax;
  setPin(0, round(newVoltage/Vmax*255))
endfunction
  
function setVgs(newVoltage)
  global Vmax;
  setPin(1, round(255*newVoltage/Vmax))
endfunction

function retval=getId()
  global Vmax;
  retval=Vmax*getPin(2)/255;
endfunction

function plotIdVds(nrOfPoints)
  global Vmax;
  for Vds=1:nrOfPoints
    setVds(Vmax*(Vds-1)/(nrOfPoints-1));
    Id(Vds)=getId();
   endfor
endfunction

function setFG_1(frequency)
    cmd2uC(["f=" int2str(frequency)]);
endfunction

function setFG_2(frequency)
    cmd2uC(["g=" int2str(frequency)]);
endfunction