%%% Callback Functions
%%% Eindhoven Unversity of Technology
%%% Authors: Dr. Carlos Mendes, Jr.
%%%          Lino van Mulken BSc 

1; % not a function file, but a file with a set of functions

% Select measurement tab from popup-menu.
function measurement_select_callback()
  
  % Global Variables
  global tab2;
  global tab2_sp2;
  global tab2_sp3;
  global tab2_sp2_ssp1;
  global tab2_sp2_ssp2;
  global tab2_sp2_ssp3;
  global tab2_sp3_ssp1;  
  global tab2_sp3_ssp2;
  global tab2_sp3_ssp3;  
  global tab2_sp2_ssp1_sssp2;
  global tab2_sp2_ssp1_sssp1;
  global tab2_sp2_ssp2_sssp2;  
  global tab2_sp2_ssp2_sssp3; 
  global tab2_sp2_ssp3_sssp1; 

  names = get(tab2.measurement_select, "string"){get (tab2.measurement_select, "value")};
  
  % Turn off/on tabs
  switch names
    case 'DC'  
      set([tab2_sp2.ssp(1), tab2_sp3.ssp(1)],'visible','on')
      set([tab2_sp2.ssp(2),tab2_sp2.ssp(3), tab2_sp3.ssp(2), tab2_sp3.ssp(3)],'visible','off')     
    case 'Time'   
      set([tab2_sp2.ssp(3), tab2_sp3.ssp(2)],'visible','on')        
      set([tab2_sp2.ssp(1),tab2_sp2.ssp(2), tab2_sp3.ssp(1), tab2_sp3.ssp(3)],'visible','off')        
    case 'Impedance' 
      set([tab2_sp2.ssp(2), tab2_sp3.ssp(3)],'visible','on')    
      set([tab2_sp2.ssp(1),tab2_sp2.ssp(3), tab2_sp3.ssp(1), tab2_sp3.ssp(2)],'visible','off')        
    end 
         
end

function plot_select_callback()
  
   global tab2_sp2_ssp1_sssp2;   
   global tab2_sp2_ssp2_sssp2;  
   global tab2_sp2_ssp3_sssp1;
   global data;
   
   check_button = data.plot_label;
   
   switch check_button
    case 1  
      set(tab2_sp2_ssp2_sssp2.cb(2),'value',0); % S21 
      set(tab2_sp2_ssp2_sssp2.cb(1),'value',0); % S11    
      set(tab2_sp2_ssp3_sssp1.cb(2),'value',0); % FFT
      set(tab2_sp2_ssp3_sssp1.cb(1),'value',0); % Time  
      set(tab2_sp2_ssp1_sssp2.cb(2),'value',0); % Current     
    case 2
      set(tab2_sp2_ssp1_sssp2.cb(1),'value',0); % Voltage
      set(tab2_sp2_ssp2_sssp2.cb(2),'value',0); % S21 
      set(tab2_sp2_ssp2_sssp2.cb(1),'value',0); % S11    
      set(tab2_sp2_ssp3_sssp1.cb(2),'value',0); % FFT
      set(tab2_sp2_ssp3_sssp1.cb(1),'value',0); % Time    
    case 3
      set(tab2_sp2_ssp1_sssp2.cb(1),'value',0); % Voltage
      set(tab2_sp2_ssp1_sssp2.cb(2),'value',0); % Current         
      set(tab2_sp2_ssp2_sssp2.cb(2),'value',0); % S21 
      set(tab2_sp2_ssp3_sssp1.cb(2),'value',0); % FFT
      set(tab2_sp2_ssp3_sssp1.cb(1),'value',0); % Time    
    case 4 
      set(tab2_sp2_ssp1_sssp2.cb(1),'value',0); % Voltage
      set(tab2_sp2_ssp1_sssp2.cb(2),'value',0); % Current         
      set(tab2_sp2_ssp2_sssp2.cb(1),'value',0); % S11  
      set(tab2_sp2_ssp3_sssp1.cb(2),'value',0); % FFT
      set(tab2_sp2_ssp3_sssp1.cb(1),'value',0); % Time     
    case 5
      set(tab2_sp2_ssp1_sssp2.cb(1),'value',0); % Voltage
      set(tab2_sp2_ssp1_sssp2.cb(2),'value',0); % Current         
      set(tab2_sp2_ssp2_sssp2.cb(1),'value',0); % S11  
      set(tab2_sp2_ssp3_sssp1.cb(2),'value',0); % FFT
      set(tab2_sp2_ssp2_sssp2.cb(2),'value',0); % S21        
     case 6 
      set(tab2_sp2_ssp1_sssp2.cb(1),'value',0); % Voltage
      set(tab2_sp2_ssp1_sssp2.cb(2),'value',0); % Current         
      set(tab2_sp2_ssp2_sssp2.cb(1),'value',0); % S11  
      set(tab2_sp2_ssp3_sssp1.cb(1),'value',0); % Time 
      set(tab2_sp2_ssp2_sssp2.cb(2),'value',0); % S21   
     otherwise
      %% do nothing
   endswitch  

end