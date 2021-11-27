% Function file with all the callback functions used in the GUI for the oscilloscope
% (c) 2020 Lino van Mulken

1; % not a function file, but a file with a set of functions

% Update Oscilloscope GUI
function update_osc_gui()
  
  global osc;
  global tab2_sp2_ssp3_sssp1;
  
  % Get Parameters
  try 
    exitDSO112A();
    pause(1);
    initDSO112A();
    getParametersDSO112A();
    exitDSO112A();  
  catch
    msgbox("Error! Try again."); 
  end
  
  % Update GUI Parameters
  set(tab2_sp2_ssp3_sssp1.sl(2),'Value',osc.TrigLvl);
  set(tab2_sp2_ssp3_sssp1.sl(1),'Value',osc.VPos);
  set(tab2_sp2_ssp3_sssp1.pm(1),'value',osc.TimeBase);
  set(tab2_sp2_ssp3_sssp1.pm(2),'value',osc.Vsens);

end

% Set oscilloscope parameters
function osc_set_callback()
  
  global osc;
  global tab2_sp2_ssp3_sssp1;
  
  % Open waitbar
  h = waitbar (0, 'Reading Parameters...', 'position', [845 500 400 100]);
  
  % Get Id and Parameters
  osc.id = getIdDSO112A();
  for i = 1:2;
     % Update Waitbar
    waitbar ((i/4)/(2), h, 'Reading Parameters...');
    pause(0.1);
  end 
  
  
  % Get Header
  try 
    exitDSO112A();  
    for i = 1:5;
       % Update Waitbar
      waitbar(1/4+(i/8)/(5), h, 'Reading Headers...');
      pause(0.1);
    end
    initDSO112A();
    osc.header = getHeaderDSO112A();
    for i = 1:5;
       % Update Waitbar
      waitbar(1/4+1/8+(i/8)/(5), h, 'Reading Headers...');
      pause(0.1);
    end
    exitDSO112A();
  catch
    msgbox("Error! Try again."); 
  end
  
  % Waitbar
  waitbar (2/4,h,'Setting Parameters...');
  pause(0.5);
  
  % Set Parameters
  try 
    exitDSO112A();  
    for i = 1:5;
       % Update Waitbar
      waitbar(2/4+(i/8)/(5), h, 'Setting Parameters.');
      pause(0.1);
    end
    initDSO112A();
    setParametersDSO112A();
    for i = 1:5;
       % Update Waitbar
      waitbar(2/4+1/8+(i/8)/(5), h, 'Setting Parameters..');
      pause(0.1);
    end
    exitDSO112A();
  catch
    msgbox("Error! Try again."); 
  end

  % Get data once to ensure correct data is displayed.
  try     
    initDSO112A();
    for i = 1:5;
       % Update Waitbar
      waitbar(3/4+(i/8)/(5), h, 'Setting Parameters...');
      pause(0.1);
    end
    osc.data = getTraceDSO112A();
    for i = 1:10;
       % Update Waitbar
      waitbar(3/4+1/8+(i/8)/(10), h, 'Setting Parameters...');
      pause(0.1);
    end
    exitDSO112A(); 
  catch
    msgbox("Error! Try again."); 
  end  
  
  % Close waitbar
  waitbar (1, h, 'Finished!');
  pause(0.5);
  close (h);
  
end

% Read Oscilloscope Data
function osc_read_callback()
  
  global osc;
  global tab2_sp2_ssp3_sssp1;
  
  % Flush before continue
  % flushinput(osc.h);
  
  % Open waitbar
  h = waitbar (0, 'Reading Parameters...', 'position', [845 500 400 100]);
  
  % Waitbar
  waitbar (1/3,h,'Reading Data...');
  pause(0.2);
  
  % Get Data
  try 
    exitDSO112A();
    for i = 1:10;
       % Update Waitbar
      waitbar((i/10)/(10), h, 'Reading Data...');
      pause(0.1);
    end
    initDSO112A();
    for i = 1:5;
       % Update Waitbar
      waitbar(1/10+(i/10)/(5), h, 'Reading Data...');
      pause(0.1);
    end
    osc.data = getTraceDSO112A();
    for i = 1:10;
       % Update Waitbar
      waitbar(1/5+1/10+(i/10)/(10), h, 'Reading Data...');
      pause(0.1);
    end
    exitDSO112A();  
    for i = 1:10;
       % Update Waitbar
      waitbar(1/5+2/10+(i/10)/(10), h, 'Reading Data...');
      pause(0.1);
    end
    initDSO112A();
    for i = 1:5;
       % Update Waitbar
      waitbar(2/5+2/10+(i/10)/(10), h, 'Reading Data...');
      pause(0.1);
    end
    osc.data = getTraceDSO112A();
    for i = 1:10;
       % Update Waitbar
      waitbar(2/5+3/10+(i/10)/(10), h, 'Reading Data...');
      pause(0.1);
    end
    exitDSO112A();     
  catch
    msgbox("Error! Try again."); 
  end
    
  % Waitbar
  for i = 1:2;
     % Update Waitbar
    waitbar(9/10+(i/10)/(2), h, 'Reading Data...');
    pause(0.1);
  end
  
  % Processing
  osc.voltage = (single(osc.data)-single(osc.VPos)-127)*osc.vscalefactor(osc.Vsens)/(24); %-single(osc.VPos)-147
  osc.time = [0:osc.RecLen-1]*osc.hscalefactor(osc.TimeBase)/(300/12);
  
  % Clear
  set(tab2_sp2_ssp3_sssp1.cb(1),'value',0);
  set(tab2_sp2_ssp3_sssp1.cb(2),'value',0);
  
  % Reset trig and pos lvl plots
  osc.c(1) = 0;
  osc.c(2) = 0;
  
  update_osc_gui();
  
  % Close waitbar
  waitbar (1, h, 'Finished!');
  pause(0.5);
  close (h);
  
end

% Set Time Data
function osc_time_callback()
  
  global osc;
  global data;
  global tab2_sp1;
  global tab2_sp2_ssp3_sssp1;
  data.xticks = [];
  data.yticks = [];
  
  % Limits
  data.xlim = [0,12*osc.hscalefactor(osc.TimeBase)];
  data.ylim = [-4*osc.vscalefactor(osc.Vsens),4*osc.vscalefactor(osc.Vsens)];  
  
  if (get(tab2_sp2_ssp3_sssp1.cb(1),'value'))
    data.plot_label = 5;
    plot_select_callback();      
    data.x = osc.time;
    data.y = osc.voltage + double(osc.VPos)*(data.ylim(2)/124);  
  end   
  
  % Scale Ticks
  data.xticks = linspace(data.xlim(1),data.xlim(2),13);
  data.yticks = linspace(data.ylim(1),data.ylim(2),9);
  
end

% Set FFT Data
function osc_fft_callback()
  
  global osc;
  global data;
  global tab2_sp2_ssp3_sssp1;
  
  if (get(tab2_sp2_ssp3_sssp1.cb(2),'value'))
    data.plot_label = 6;
    plot_select_callback();       
    [data.x,data.y] = FFT_DS0112A(osc.voltage,diff(osc.time(1:2))); 
  end  
end


% Slider callback Position Level Select
function osc_position_callback()

  % Variables
  global osc;
  global tab2_sp2_ssp3;
  global tab2_sp2_ssp3_sssp1;
    
  % Get slider value
  osc.VPos = round(get(tab2_sp2_ssp3_sssp1.sl(1),'Value'));
  
  % Check for previous trigger and position lvl plots
  if(osc.c(1) ~= 0)
  delete(osc.c(1))
  delete(osc.c(2))
  endif
  plot_trig_vlvl(); 
        
endfunction

% Slider callback Trigger Level Select
function osc_trigger_callback()

  % Variables
  global osc;
  global tab2_sp2_ssp3;
  global tab2_sp2_ssp3_sssp1;
  
   % Get slider value
   osc.TrigLvl = round(get(tab2_sp2_ssp3_sssp1.sl(2),'Value'));
   
  % Check for previous trigger and position lvl plots
  if(osc.c(1) ~= 0)
  delete(osc.c(1))
  delete(osc.c(2))
  endif
  plot_trig_vlvl();
  
endfunction

% Set timebase
function osc_timebase_callback()
  global osc;
  global tab2_sp2_ssp3_sssp1;
  % Get selected timebase in popup-menu
  temp_TB = get(tab2_sp2_ssp3_sssp1.pm(1), "value");
  if (temp_TB >= 11)
    osc.TimeBase = temp_TB;
  else
    msgbox("Values above 20 ms/Div are not allowed!");
    set(tab2_sp2_ssp3_sssp1.pm(1), "value", 11); 
    osc.Timebase = 11; 
  end
endfunction

% Set Vertical Sensitivity
function osc_vertical_callback()
  global osc;
  global tab2_sp2_ssp3_sssp1;
  % Get selected timebase in popup-menu
  osc.Vsens = get(tab2_sp2_ssp3_sssp1.pm(2), "value");   
endfunction

