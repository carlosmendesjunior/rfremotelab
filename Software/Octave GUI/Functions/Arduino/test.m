
  global ar;  % Arduino
  ar.port   = "/dev/ttyUSB1";

  %% Load Packages
  graphics_toolkit qt
  pkg load signal
  pkg load instrument-control
  
  % Initialize COM-PORT
  s1 = serialport(ar.port,115200);
  set(s1,"FlowControl","none");
  set(s1,"Timeout",0.1);
  pause(3);
  
  % Data
  data = char(['1' ' ']);
  mode = char('v');
  retval = [];
  pause(0.1);
  
  % Initialize
  write(s1, ['/' "\n"]);
  pause(0.1);
  write(s1, [mode "\n"]);
  pause(0.1);
   
   % Sending data
  for i = 1:length(data)
    write(s1, [data(i) "\n"]);
%    pause(0.1);
    d = read(s1,1)
    while (d != 'c')
      d = read(s1,1)
      d = '1';
    end
  end
  
  a = read(s1,1000)
  retval = 5*(str2double(char(a))/1023)
  disp(retval)

  % Closing
  pause(0.1);
  clear s1;
