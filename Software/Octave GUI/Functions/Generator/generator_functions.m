# This script provides a library for the FYS3200S
# (C) Lino van Mulken

1; % not a function file, but a file with a set of functions

function sg_init()
  global sg;
  % Resetting Generator 2
  sg.port  = sg.port_2;
  set_sg(0,0,1);
  % Resetting Generator 1
  sg.port  = sg.port_1;
  set_sg(0,0,1);
end

function get_sg()
  global sg;
  global tab2_sp2_ssp3_sssp2; 
  % Get Information 
  sg.DCoffset = 0; % DC Offset (default is zero)
  sg.Frequency_1 = convert_unit(get(tab2_sp2_ssp3_sssp2.e(1),'string')); % Frequency [k, M, G] 
  sg.Amplitude_1 = get(tab2_sp2_ssp3_sssp2.e(2),'string'); % Amplitude  
  sg.Frequency_2 = convert_unit(get(tab2_sp2_ssp3_sssp2.e(3),'string')); % Frequency [k, M, G] 
  sg.Amplitude_2 = get(tab2_sp2_ssp3_sssp2.e(4),'string'); % Amplitude    
end
  
function set_sg(Frequency,Amplitude, Waveform)
  global sg;
  
  % Open waitbar
  f = waitbar(0,'Setting Parameters...', 'position', [845 500 400 100]); 
  pause(0.2);
  % Signal +
  sg.Channel = 1;
    SetWaveform(Waveform);
    waitbar(0.1,f,'Setting Parameters...');     
    SetFrequency(Frequency);
    waitbar(0.2,f,'Setting Parameters...');      
    SetAmplitude(Amplitude);
    waitbar(0.3,f,'Setting Parameters...');       
    SetDCoffset();
    waitbar(0.4,f,'Setting Parameters...');        
  % Signal -
  sg.Channel = 2;
    SetWaveform(Waveform);
    waitbar(0.5,f,'Setting Parameters...');        
    SetFrequency(Frequency);
    waitbar(0.6,f,'Setting Parameters...');        
    SetAmplitude(Amplitude);
    waitbar(0.7,f,'Setting Parameters...');        
    SetDCoffset();
    waitbar(0.8,f,'Setting Parameters...');        
    SetPhase();
     waitbar(0.9,f,'Setting Parameters...');        
  % Signal +
  sg.Channel = 1;
  
  % Close waitbar 
  waitbar(1,f,'Done');
  pause(1);
  close(f); 
  
end

function retval=FY3200S(cmd)
  global sg;
  # send cmd to FY3200S, append a carriage return (but no linefeed) and return the response as a string
  # Please note that the com port might need to be modified to match the port on a specific computer
  s3=serial(sg.port,9600,10);
  # Set either main or sub channel. 
  if(sg.Channel == 1)
    srl_write(s3,["b", cmd, "\n"]);   
  elseif(sg.Channel == 2)
    srl_write(s3,["d", cmd, "\n"]);
  endif  
  [a,l]=srl_read(s3,15);
  retval=char(a);
  fclose(s3);
endfunction

function SetWaveform(Waveform)
  # Sets the type of the main waveform represented by 1 digit
  # 0 for sine
  # 1 for triangular (sawtooth)
  # 2 for square wave
  cmd = ["w", num2str(Waveform)];
  FY3200S(cmd);
endfunction

function SetFrequency(Frequency)
  # Sets the frequency represented by 9 digits
  # frequency is in cHz -> multiplied by 100.
  value = Frequency * 100;
  value = num2str(value,'%09.f');
  cmd = ["f", value];
  FY3200S(cmd);
endfunction

function SetAmplitude(Amplitude)
  # Sets the amplitude
  value = num2str(Amplitude,'%2.1f');
  cmd = ["a", value];
  FY3200S(cmd);
endfunction

function SetDCoffset()
  global sg;
  # Sets the DC Offset
  value = num2str(sg.DCoffset,'%3.1f');
  cmd = ["o", value];
  FY3200S(cmd);
endfunction

function SetPhase()
  global sg;
  # Sets the Phase of the subsidiary waveform relative to the main waveform
  if(sg.Channel == 2)
    if(sg.Phase < 0)
      value = sg.Phase + 360;
    else
      value = sg.Phase; 
    endif 
    value = num2str(value,'%3.0f');
    cmd = ["p", value];
    FY3200S(cmd);
  else
    disp('Error, Phase can only be set for channel 2');
  endif
endfunction

function SetDutyCycle()
  global sg;
  # Sets the amplitude represented by 2 digits
  value = sg.DutyCycle * 10;
  value = num2str(value,'%2.0f');
  cmd = ["d", value];
  FY3200S(cmd);
endfunction

function SetSweepTime()
  global sg;
  # Sets the Sweep time represented by 2 digits
  value = num2str(sg.SweepTime,'%2.0f');
  cmd = ["t", value];
  FY3200S(cmd);
endfunction

function SavePosition()
  global sg;
  # Save the current parameters (Frequency, Duty Cycle, Amplitude etc.) to a ...
  # specific postion. (0-9)
  cmd = ["s", num2str(sg.SavePosition)];
  FY3200S(cmd);
endfunction

function LoadPosition()
  global sg;
  # Load the current parameters (Frequency, Duty Cycle, Amplitude etc.) from a ...
  # specific postion. (0-9)
  cmd = ["l", num2str(sg.LoadPosition)];
  FY3200S(cmd);
endfunction

function ControlSweep()
  global sg;
  # Stops/Starts the sweep represented by 1 digit
  # 0 = Start sweep
  # 1 = Pause sweep
  cmd = ["r", num2str(sg.ControlSweep)];
  FY3200S(cmd);
endfunction

function ResetCounter()
  # Resets Counter
  cmd = ["c"]
  FY3200S(cmd);
endfunction

function SetSweepMode()
  global sg;
  # Sets the sweep mode represented by 1 digit
  # 0 = Linear
  # 1 = Logarithmic
  value = num2str(sg.SweepMode);
  cmd = ["t", value];
  FY3200S(cmd);
endfunction

function SetSweepBeginFreq()
  global sg;
  # Sets the begin frequency of the sweep represented by 9 digit
  # frequency is in cHz -> multiplied by 100.
  value = sg.SweepBeginFreq * 100;
  value = num2str(value,'%09.f');
  cmd = ["b", value];
  FY3200S(cmd);
endfunction

function SetSweepEndFreq()
  global sg;
  # Sets the end frequency of the sweep represented by 9 digit
  # frequency is in cHz -> multiplied by 100.
  value = sg.SweepEndFreq * 100;
  value = num2str(value,'%09.f');
  cmd = ["e", value];
  FY3200S(cmd);
endfunction

function ResetAmplitude()
  global sg;
  
  h = waitbar (0, 'Preparing Board...','position', [845 500 400 100]);    
  pause(0.2);  
  % Resetting Generator 2
  sg.port  = sg.port_2;    
  % Signal +
  sg.Channel = 1;
  SetAmplitude(0);
  SetFrequency(0);    
  waitbar (1/4, h, 'Preparing Board.','position', [845 500 400 100]);  
  % Signal -
  sg.Channel = 2;       
  SetAmplitude(0);
  SetFrequency(0);    
  waitbar (2/4, h, 'Preparing Board..','position', [845 500 400 100]);  
  % Resetting Generator 1
  sg.port  = sg.port_1;    
  % Signal +
  sg.Channel = 1;
  SetAmplitude(0);
  SetFrequency(0);    
  waitbar (3/4, h, 'Preparing Board...','position', [845 500 400 100]);   
  % Signal -
  sg.Channel = 2;       
  SetAmplitude(0);
  SetFrequency(0);     
  % Signal +
  sg.Channel = 1; 
  
  waitbar (1, h, 'Finished...','position', [845 500 400 100]);  
  close (h);   
  
endfunction

function SetbackAmplitude()
  global sg;
  
  h = waitbar (0, 'Setting Board...','position', [845 500 400 100]);    
  pause(0.2);
 get_sg()
  
  % Resetting Generator 1
  sg.port  = sg.port_1;    
  % Signal +
  sg.Channel = 1;
  SetAmplitude(sg.Amplitude_1);   
  SetFrequency(sg.Frequency_1);     
  waitbar (1/4, h, 'Setting Board.','position', [845 500 400 100]);   
  % Signal -
  sg.Channel = 2;       
  SetAmplitude(sg.Amplitude_1);
  SetFrequency(sg.Frequency_1);  
  waitbar (2/4, h, 'Setting Board..','position', [845 500 400 100]);     
  % Signal +
  sg.Channel = 1; 
  
  % Resetting Generator 2
  sg.port  = sg.port_2;    
  % Signal +
  sg.Channel = 1;
  SetAmplitude(sg.Amplitude_2); 
  SetFrequency(sg.Frequency_2);    
  waitbar (3/4, h, 'Setting Board...','position', [845 500 400 100]);     
  % Signal -
  sg.Channel = 2;       
  SetAmplitude(sg.Amplitude_2);
  SetFrequency(sg.Frequency_2);    
 
  % Signal +
  sg.Channel = 1; 
  
  waitbar (1, h, 'Finished...','position', [845 500 400 100]);  
  close (h);    
  
endfunction