%% Arduino Software SPI Code
% Author: Carlos Mendes Jr
% Date: 11/Jun/2019
% TU/e - IC Group

function spi_soft(sa,sw) % change sw to info
  
  global dut;
 
  % Open waitbar
  h = waitbar (0, 'Preparing...','position', [845 500 400 100]);
  pause(0.2);
  % Initialize COM-PORT
  s1 = serialport(dut.port,9600);
  set(s1,"FlowControl","none");
  set(s1,"Timeout",1); %0.1
  pause(2.5); % 1
  
  % Update waitbar
  waitbar (1/3, h, 'Uploading...');
  for i = 1:25
  waitbar (1/3+(i/3)/25, h, 'Uploading...');    
  pause(0.1);
  end
  
  % Data
  data = [sw ' ']; % sw
  sa = char(sa);
  pause(0.1); % 1
  
  % Initialize
  write(s1, ['/' "\n"]);
  pause(0.1);
  write(s1, [sa "\n"]);
  % Debug output - remove (PB)
  sa;
  pause(0.1);
   
   % Sending data
  for i = 1:length(data)
    write(s1, [data(i) "\n"]);
    % Debug output - remove (PB)
    data(i);
    d = read(s1,1);
    if (d != 'c')
%      [d,n] = read(s1,1); %% I changed here
      % debug output - remove (PB)
      msgbox('Alarm!!!');
      d = read(s1,1);
      d = '';
      i = length(data);
    end
  end
  
  % Update waitbar
  waitbar (2/3, h, 'Closing...');
  
  % Closing
  write(s1, [' ' "\n"]);
  pause(1);
  clear s1;
  
  % Close waitbar
  waitbar (1, h, 'Finished');
  close (h); 

end