% Arduino functions used in the GUI

function set_generator_callback()
  
  global sg;
  w = 0; 
  
  % Get data from GUI into global variable sg
  get_sg();
  
  % Check which generator to set
  if(sg.Generator == 1)
  sg.port  = sg.port_1;
  Frequency = sg.Frequency_1;
  Amplitude = sg.Amplitude_1; 
  Waveform = sg.Waveform_1;  
  elseif(sg.Generator == 2)
  sg.port  = sg.port_2; 
  Frequency = sg.Frequency_2; 
  Amplitude = sg.Amplitude_2; 
  Waveform = sg.Waveform_2;
  endif 
  
  % Check for Over-voltage
  try 
    warning_voltage(str2num(Amplitude));
  catch
    beep();
    w = warndlg('Voltage cannot be great than 5 V! Try again.','Error');  
  end       

  try 
    % Set to Generator 1
    if (~w)
      set_sg(Frequency,Amplitude, Waveform);  
    else
      beep();
      warndlg('Generator not set.');
    end
  catch
    msgbox("Error! Try again."); 
  end  
 
    
end

function waveform_callback()
  global sg;
  global tab2_sp2_ssp3_sssp2;
 
  switch(gcbo) 
    case {tab2_sp2_ssp3_sssp2.cb(1)}
      set(tab2_sp2_ssp3_sssp2.cb(2),'value',0);
      sg.Waveform_1 = 0;
    case {tab2_sp2_ssp3_sssp2.cb(2)}
      set(tab2_sp2_ssp3_sssp2.cb(1),'value',0);
      sg.Waveform_1 = 1; 
    case {tab2_sp2_ssp3_sssp2.cb(3)}
      set(tab2_sp2_ssp3_sssp2.cb(4),'value',0);
      sg.Waveform_2 = 0;
    case {tab2_sp2_ssp3_sssp2.cb(4)}
      set(tab2_sp2_ssp3_sssp2.cb(3),'value',0);
      sg.Waveform_2 = 1;       
  endswitch
end

function select_generator_callback()
  global sg;
  global tab2_sp2_ssp3_sssp2;
  
  switch(gcbo)
    case {tab2_sp2_ssp3_sssp2.cb(5)} % Generator 1
      set(tab2_sp2_ssp3_sssp2.cb(6),'value',0);
      set([tab2_sp2_ssp3_sssp2.e(1),tab2_sp2_ssp3_sssp2.e(2), tab2_sp2_ssp3_sssp2.cb(1), tab2_sp2_ssp3_sssp2.cb(2)],'visible','on'); 
      set([tab2_sp2_ssp3_sssp2.e(3),tab2_sp2_ssp3_sssp2.e(4), tab2_sp2_ssp3_sssp2.cb(3), tab2_sp2_ssp3_sssp2.cb(4)],'visible','off');      
      sg.Generator = 1;
    case (tab2_sp2_ssp3_sssp2.cb(6)) % Generator 2
      set([tab2_sp2_ssp3_sssp2.e(3),tab2_sp2_ssp3_sssp2.e(4), tab2_sp2_ssp3_sssp2.cb(3), tab2_sp2_ssp3_sssp2.cb(4)],'visible','on'); 
      set([tab2_sp2_ssp3_sssp2.e(1),tab2_sp2_ssp3_sssp2.e(2), tab2_sp2_ssp3_sssp2.cb(1), tab2_sp2_ssp3_sssp2.cb(2)],'visible','off');     
      set(tab2_sp2_ssp3_sssp2.cb(5),'value',0);
      sg.Generator = 2; 
  endswitch
end


