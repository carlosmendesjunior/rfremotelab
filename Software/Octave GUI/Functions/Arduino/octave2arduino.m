%% Arduino Software SPI Code
% Author: Carlos Mendes Jr
% Date: 22/March/2021
% TU/e - IC Group

function retval = octave2arduino(port,mode,data_in)
  
  % Initialize COM-PORT
  s1 = serialport(port,9600);
  set(s1,"FlowControl","none");
  set(s1,"Timeout",1); %0.1
  pause(3);
  
  % Data
  data = [char(data_in) ' '];
  mode = char(mode);
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
    d = read(s1,1);
    while (d != 'c')
      d = read(s1,1);
      d = '1';
    end
  end
  pause(1);
  % Reading
  VDD = 5;
  a = read(s1,1000);
  retval = (str2double(char(a))*VDD)/1023;
  
  % Closing
  pause(0.5);
  clear s1;

end