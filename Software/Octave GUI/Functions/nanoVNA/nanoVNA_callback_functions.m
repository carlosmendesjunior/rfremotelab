% Function file with all the callback functions used in the GUI for the VNA
% (c) 2020 Lino van Mulken

1; % not a function file, but a file with a set of functions

function update_VNA_gui()
  
  global vna;
  global tab2_sp2_ssp2_sssp1;
  
  % Get Parameters
  try 
    pause(0.5);
    temp_freq = getNanoFrequencies();
    str_fmin = eng_format(min(temp_freq));
    str_fmax = eng_format(max(temp_freq));
  catch
    msgbox("Error! Try again."); 
  end
  
  % Update GUI Parameters
  set(tab2_sp2_ssp2_sssp1.e(1),'string',str_fmin);
  set(tab2_sp2_ssp2_sssp1.e(2),'string',str_fmax);

end
  
function set_VNA_callback()
  
  % Global variables
  global vna;
  global tab2_sp2_ssp2_sssp1;
  
  f = zeros(1,6);
  % Dialog Question
  answer = questdlg('Are you sure you want to set the VNA?', 'Warning', 'Yes', 'No');
  
  % Handle response
  switch answer
      case 'Yes'
        try 
          % Get the input Fmin
          str = get(tab2_sp2_ssp2_sssp1.e(1),'string');
          % Check if units have been used, e.g. k,M,G.
          vna.fmin = convert_unit(str);
          % Get the input Fmax          
          str = get(tab2_sp2_ssp2_sssp1.e(2),'string');
          % Check if units have been used, e.g. k,M,G.         
          vna.fmax = convert_unit(str);          
        catch
          f(1) = warndlg('Please, fill in all sweep settings before continuing.','Error');
        end 
        try 
          warning_frequency_low(vna.fmin,vna.fmax);
        catch
          f(2) = warndlg('Minimum frequency of 0 Hz exceded.','Error');
        end       
        try 
          warning_frequency_high(vna.fmin,vna.fmax);
        catch
          f(3) = warndlg('Maximum frequency of 900 MHz exceded.','Error');
        end  
        try 
          warning_sweep(vna.fmin,vna.fmax);
        catch
          f(4) = warndlg('Min frequency must be less than max frequency!','Error');                   
        end
    case 'No'
          f(5) = warndlg('','Error');
    case 'Cancel'
          f(6) = warndlg('','Error');      
  end
  
  if ~any(f)
    
    % Open waitbar
    f = waitbar(0,'Please wait...', 'position', [845 500 400 100]);
    for i = 1:5;
       % Update Waitbar
      waitbar ((i/2)/(5), f, 'Setting VNA...');
      pause(0.1);
    end   
    
    % Set Frequency Measurement
    try 
      initVNA();
      pause(0.5);
      waitbar(1/2,f,'Setting VNA...');
      autoSetNanoFrequencies(vna.fmin,vna.fmax);
    catch
      msgbox("Error! Try again."); 
    end
    
    % Close waitbar
    for i = 1:20;
       % Update Waitbar
      waitbar (1/2+(i/2)/(20), f, 'Setting VNA...');
      pause(0.3);
    end  
    waitbar(1,f,'Done!');
    pause(0.5);
    close(f);    

  else
    msgbox('VNA not started.');
  end
  
end

function read_VNA_callback()
  
  % Global variables
  global vna;
  global tab2_sp2_ssp2_sssp1;
  global tab2_sp2_ssp2_sssp2;

  % Open waitbar
  f = waitbar(0,'Please wait...', 'position', [725 500 400 100]);
    for i = 1:5;
       % Update Waitbar
      waitbar ((i/5)/(5), f, 'Reading VNA...');
      pause(0.1);
    end   
  
  % Start Measurement
  try 
    for i = 1:10;
       % Update Waitbar
      waitbar (1/5+(i/5)/(10), f, 'Reading VNA...');
      pause(0.1);
    end   
    vna.freq = getNanoFrequencies();
    for i = 1:10;
       % Update Waitbar
      waitbar (2/5+(i/5)/(10), f, 'Reading VNA...');
      pause(0.1);
    end  
    value = getNanoS11();
    vna.s11 = 10*log10(abs(value));
    vna.imp = value;
    for i = 1:10;
       % Update Waitbar
      waitbar (3/5+(i/5)/(10), f, 'Reading VNA...');
      pause(0.1);
    end  
    vna.s21 = 10*log10(abs(getNanoS21()));
  catch
    msgbox("Error! Try again."); 
  end

  % Reset Plot Options    
  set(tab2_sp2_ssp2_sssp2.cb(1),'value',0);
  set(tab2_sp2_ssp2_sssp2.cb(2),'value',0);
  
  % Update VNA GUI
  update_VNA_gui();

  % Close waitbar
    for i = 1:5;
       % Update Waitbar
      waitbar (4/5+(i/5)/(5), f, 'Reading VNA...');
      pause(0.1);
    end  
  waitbar(1,f,'Done!');
  pause(0.5);
  close(f);    
  
end

function reset_VNA_callback()
  global tab2_sp2_ssp2_sssp1;
  set(tab2_sp2_ssp2_sssp1.e(1),'string','min Freq (Hz)');
  set(tab2_sp2_ssp2_sssp1.e(2),'string','max Freq (Hz)');
end

function getS11_callback()
  
  global vna;
  global data;
  global tab2_sp2_ssp2_sssp2;
  
  if (get(tab2_sp2_ssp2_sssp2.cb(1),'value'))
    data.plot_label = 3;   
    plot_select_callback();      
    data.x = vna.freq;
    data.y = vna.s11;  
  end
  
end

function getS21_callback()
  
  global vna;
  global data;
  global tab2_sp2_ssp2_sssp2;  
  
  if (get(tab2_sp2_ssp2_sssp2.cb(2),'value'))
    data.plot_label = 4; 
    plot_select_callback();       
    data.x = vna.freq;
    data.y = vna.s21; 
  end
  
end

function smith_callback() % Currently not working
  global data;
  global tab2_sp1;
  if (get(tab2_sp2_ssp2_sssp2.cb(3),'value'))
    plot(tab2_sp1.ax(1),data.y);
    ticks_eng();    
    smith(tab2_sp1.ax(1)) 
  else
    plot_callback();
  end
end

function vna_freq_slider_callback()

  % Variables
  global vna;
  global tab2_sp1;
  global tab2_sp2_ssp2_sssp3;
  
  % Convert S11 to Z
  Z_0 = 50;
  vna.imp_z= Z_0 * (1 + vna.imp) ./ (1 - vna.imp);
  
  % Get slider value frequency
  vna.imp_freq = vna.freq(1,round(get(tab2_sp2_ssp2_sssp3.sl(1),'Value')));
  
  % Get slider value impedance
  vna.imp_imp = vna.imp_z(1,round(get(tab2_sp2_ssp2_sssp3.sl(1),'Value')));  
  
  % Display frequency value
  set (tab2_sp2_ssp2_sssp3.e(1), "string", sprintf ([convert_unit_back(vna.imp_freq)," Hz"]));
  
  % Display Impedance value
  set (tab2_sp2_ssp2_sssp3.e(2), "string", sprintf ("%.2f",(real(vna.imp_imp))));
  
  set (tab2_sp2_ssp2_sssp3.e(3), "string", sprintf ("%.2f",(imag(vna.imp_imp))));  
  
endfunction
