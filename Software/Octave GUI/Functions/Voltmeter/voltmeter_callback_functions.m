%% Callback Function - Plot 
%% (c) 2021 Carlos Mendes, Jr.

1; % not a function file, but a file with a set of functions

% Measure V1M
function measure_vm_callback()
  % Global Variables
  global ar;
  global tab2_sp2_ssp1_sssp3;
  % Open waitbar
  f = waitbar(0,'Please wait...', 'position', [845 500 400 100]);

  for i = 1:5;
     % Update Waitbar
    waitbar ((i/2)/(5), f, 'Reading Voltage...');
    pause(0.1);
  end 
   
  % Get correct VM pin 
  if (get(tab2_sp2_ssp1_sssp3.cb(1),'value'))
    ar.pin = '1'; 
  else
    ar.pin = '2';
  end
   
  % Get output voltage
  VM = octave2arduino(ar.port,'v',ar.pin);
  
  % Get unit of pup-up menu menu
  Unit = get(tab2_sp2_ssp1_sssp3.pm(1),'value');
  VM = VM*ar.scale_factor(Unit);
  
  for i = 1:5;
     % Update Waitbar
    waitbar (0.5+(i/2)/(5), f, 'Reading Voltage...');
    pause(0.1);
  end 
  
  % Display value
  set (tab2_sp2_ssp1_sssp3.vm_value, "string", sprintf ("%.2f", VM));
  % Close waitbar
  waitbar (1, f, 'Finished');
  pause(0.5);
  close (f);
endfunction

function getV1M_callback()
  
  global ar; 
  global tab2_sp2_ssp1_sssp3;
  
  if (get(tab2_sp2_ssp1_sssp3.cb(1),'value'))
    set(tab2_sp2_ssp1_sssp3.cb(2),'value',0);   
  end
  
end

function getV2M_callback()
  
  global ar; 
  global tab2_sp2_ssp1_sssp3;
  
  if (get(tab2_sp2_ssp1_sssp3.cb(2),'value'))
    set(tab2_sp2_ssp1_sssp3.cb(1),'value',0);
  end
  
end