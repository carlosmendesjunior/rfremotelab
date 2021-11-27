
%%% Tab 1 - Circuit Builder
%%% Eindhoven Unversity of Technology
%%% Authors: Prof. Dr. Peter Baltus
%%%          Dr. Carlos Mendes Jr.
%%%          Lino van Mulken BSc 

1; % not a function file, but a file with a set of functions

%% --> Tab 2 <--

% Popoup Menu - Measurements
  tab2.measurement_select = uicontrol ('parent', tab(2),'style', 'popupmenu', 'units', 'normalized', 'horizontalalignment','center',...
                              'backgroundcolor','white', 'string', Measurement_names, 'callback', @measurement_select_callback,
                              'position', [0.52 0.9 0.08 0.0391]);
                              
% Text - Measurements
  tab2.t = uicontrol( 'parent', tab(2), 'style', 'text', 'units', 'normalized', 'horizontalalignment', 'left',...
              'fontsize',10,'string', 'Choose the Domain ', 'position', [0.40 0.9 0.1 0.0391]);                              

%% --- Sub-Panel 1 --- PLOTTING ---
tab2_sp(1) = uipanel ('parent', tab(2), 'title', 'Plotting', 'position', [0.02 0.03 0.3 0.95]); % [left, bottom, width, height]

  % Create axis --> plot(tab2_sp1.ax(1),X,Y)
  tab2_sp1.ax(1) = axes('parent', tab2_sp(1),'position', [0.15 0.45 0.8 0.5]);

  % --- Sub-Sub-Panel 1 --- PLOTTING OPTIONS ---
  tab2_sp1.ssp(1) = uipanel ('parent', tab2_sp(1), 'title', 'Options',...
                    'position', [0.05 0.14 0.9 0.23]);
  
  % Checkbox - grid --> grid(tab2_sp1.ax(1))
  tab2_sp1.cb(1) = uicontrol ('parent', tab2_sp(1),'style', 'checkbox',
                               'units', 'normalized',
                               'string', 'Grid on','value', 0,
                               'callback', @grid_callback,
                               'position', [0.1 0.27 0.20 0.05]);
  
  % Checkbox - Minor grid --> grid(tab2_sp1.ax(1),'minor')
  tab2_sp1.cb(2) = uicontrol ('parent', tab2_sp(1),'style', 'checkbox',
                                   'units', 'normalized',
                                   'string', 'Minor grid',
                                   'callback', @grid_minor_callback,
                                   'value', 0,
                                   'position', [0.6 0.27 0.25 0.05]);
  
  % Checkbox - Logarithmic Scale Y
  tab2_sp1.cb(3) = uicontrol ('parent', tab2_sp(1),'style', 'checkbox',
                               'units', 'normalized',
                               'string', 'Log Y-axis',
                               'value', 0,
                               'callback', @log_y_callback,
                               'position', [0.1 0.22 0.35 0.05]);
                               
  % Checkbox - Logarithmic Scale X 
  tab2_sp1.cb(4) = uicontrol ('parent', tab2_sp(1),'style', 'checkbox',
                               'units', 'normalized',
                               'string', 'Log X-axis',
                               'value', 0,
                               'callback', @log_x_callback,
                               'position', [0.1 0.17 0.35 0.05]);                               
                               
  % Checkbox - Fit window
  tab2_sp1.cb(5) = uicontrol ('parent', tab2_sp(1),'style', 'checkbox',
                                  'units', 'normalized',
                                  'string', 'Axis Tight',
                                  'callback', @axis_tight_callback,
                                  'position', [0.6 0.22 0.25 0.05]);     

  % Checkbox - Hold On
  tab2_sp1.cb(6) = uicontrol ('parent', tab2_sp(1),'style', 'checkbox',
                                  'units', 'normalized',
                                  'string', 'Hold On',
                                  'callback', @hold_on_callback,
                                  'position', [0.6 0.17 0.25 0.05]);                                       
  
  % Button - Save data
  tab2_sp1.pb(1) = uicontrol ('parent', tab2_sp(1),'style', 'pushbutton',
                                  'units', 'normalized',
                                  'string', 'Save Data',
                                  'callback', @save_plot_callback,
                                  'position', [0.55 0.05 0.35 0.04]);
                                  
  % Button - Clear data
  tab2_sp1.pb(2) = uicontrol ('parent', tab2_sp(1),'style', 'pushbutton',
                                'units', 'normalized',
                                'string', 'Clear Plot',
                                'callback', @clear_plot_callback,
                                'position', [0.1 0.05 0.35 0.04]);
                               
  
%% --- Sub-Panel 2 --- MEASUREMENTS ---
tab2_sp(2) = uipanel ('parent', tab(2), 'title', 'Measurement', 'position', [0.34 0.03 0.32 0.85]); % [left, bottom, width, height]


                                 
%% --- Sub-Sub-Panel 2-1 --- DC DOMAIN ---
tab2_sp2.ssp(1) = uipanel ('parent', tab2_sp(2), 'title', 'DC','foregroundcolor', [0.43922,0.18824,0.62745],...
                'FontWeight', 'bold', 'titleposition', 'lefttop','position', [0.05 0.04 0.9 0.9]);
                
%% --- Sub-Sub-Sub-Panel 2-1-1 --- SWEEP VOLTAGE --- 
tab2_sp2_ssp1.sssp(1) = uipanel ('parent', tab2_sp2.ssp(1),  'title', 'Voltage Sweep',...
          'titleposition', 'righttop', 'position', [0.05 0.655 0.9 0.27]);    
    
  % Push Button - Set
  tab2_sp2_ssp1.set_sweep = uicontrol ('parent', tab2_sp2_ssp1.sssp(1),'style', 'pushbutton', 'units','pixel',
                            'string', 'Set', 'callback', @set_sweep,
                            'position', [31 16.67 113 24]);
                                
  % Push Button - Read
  tab2_sp2_ssp1.start_sweep = uicontrol ('parent', tab2_sp2_ssp1.sssp(1),'style', 'pushbutton', 'units','pixel',
                            'string', 'Read', 'callback', @start_sweep_callback,
                            'position', [176 16.67 113 24]);
  
  % Edit - Min                           
  tab2_sp2_ssp1_sssp1.voltage_sweep_min = uicontrol ('parent', tab2_sp2_ssp1.sssp(1),'style', 'edit','units',
                                        'pixel','backgroundcolor','white',
                                        'string', '0',
                                        'position', [31 55 63 24]);
                                        
  % Text - Min
  tab2_sp2_ssp1_sssp1.t(1) = uicontrol ('parent', tab2_sp2_ssp1.sssp(1),'style', 'text',
                                          'units', 'pixel',
                                          'string', 'Min [V]',
                                          'horizontalalignment', 'center',
                                          'position', [31 85 63 24]);                                         
                                 
  % Text - To                           
  tab2_sp2_ssp1_sssp1.text_voltage_sweep_to = uicontrol ('parent', tab2_sp2_ssp1.sssp(1),'style', 'text',
                                           'units', 'pixel',
                                           'string', 'to',
                                           'horizontalalignment', 'center',
                                           'position', [103 55 20 24]);    
  
  % Edit - Max  
  tab2_sp2_ssp1_sssp1.voltage_sweep_max = uicontrol ('parent', tab2_sp2_ssp1.sssp(1),'style', 'edit', 'units',
                                        'pixel','backgroundcolor','white',
                                        'string', '0',
                                        'position', [128 55 63 24]);  
  % Text - Max
  tab2_sp2_ssp1_sssp1.t(2) = uicontrol ('parent', tab2_sp2_ssp1.sssp(1),'style', 'text',
                                          'units', 'pixel',
                                          'string', 'Max [V]',
                                          'horizontalalignment', 'center',
                                          'position', [128 85 63 24]);                                        
  
  % Text - With
  tab2_sp2_ssp1_sssp1.text_voltage_sweep_w = uicontrol ('parent', tab2_sp2_ssp1.sssp(1),'style', 'text',
                                          'units', 'pixel',
                                          'string', 'w/',
                                          'horizontalalignment', 'center',
                                          'position', [198 55 20 24]);
  % Edit - Step
  tab2_sp2_ssp1_sssp1.voltage_sweep_steps = uicontrol ('parent', tab2_sp2_ssp1.sssp(1),'style', 'edit', 'units',
                                         'pixel','backgroundcolor','white',
                                         'string', '0',
                                         'position', [226 55 63 24]); 
 
  % Text - Steps
  tab2_sp2_ssp1_sssp1.t(3) = uicontrol ('parent', tab2_sp2_ssp1.sssp(1),'style', 'text',
                                          'units', 'pixel',
                                          'string', 'Steps',
                                          'horizontalalignment', 'center',
                                          'position', [226 85 63 24]); 
           
%% --- Sub-Sub-Sub-Panel 2-1-2 --- PLOT OPTIONS ---
tab2_sp2_ssp1.sssp(2) = uipanel ('parent', tab2_sp2.ssp(1),  'title', 'Output Variable',...
                        'titleposition', 'righttop', 'position', [0.05 0.42 0.9 0.16]);   
  
  % Checkbox - Voltage  
  tab2_sp2_ssp1_sssp2.cb(1) = uicontrol ('parent', tab2_sp2_ssp1.sssp(2),'style', 'checkbox',
                                                   'units', 'pixel',
                                                   'string', 'VM1',
                                                   'value', 0,
                                                   'callback', @v_plot_callback,
                                                   'position', [20 25 113 24]);
  % Checkbox - Current                               
  tab2_sp2_ssp1_sssp2.cb(2) = uicontrol ('parent', tab2_sp2_ssp1.sssp(2),'style', 'checkbox',
                                                   'units', 'pixel',
                                                   'string', 'I(VDD)',
                                                   'value', 0,
                                                   'callback', @i_plot_callback,
                                                   'position', [100 25 113 24]);

  % Push button - Plot
  tab2_sp2_ssp1_sssp2.b(1)  = uicontrol ('parent', tab2_sp2_ssp1.sssp(2),'style', 'pushbutton', 'units','pixel',
                            'string', 'Plot', 'callback', @plot_callback,'position', [180 25 113 24]);
                         
%% --- Sub-Sub-Sub-Panel 2-1-3 --- VOLTMETER ---
tab2_sp2_ssp1.sssp(3) = uipanel ('parent', tab2_sp2.ssp(1),  'title', 'Voltmeter',...
          'titleposition', 'righttop', 'position', [0.05 0.075 0.9 0.27]); 
       
  % Button - Read V
  tab2_sp2_ssp1_sssp3.measure_vm = uicontrol ('parent', tab2_sp2_ssp1.sssp(3),'style', 'pushbutton', 'units',
                                 'pixel', 'string', ' Read', 'callback', @measure_vm_callback,
                                 'position', [31 30 113 24]);     
                                 
  % Edit - Display V 
  tab2_sp2_ssp1_sssp3.vm_value = uicontrol ('parent', tab2_sp2_ssp1.sssp(3),'style', 'edit', 'units',
                                 'pixel','backgroundcolor','white','string', '0',
                                 'position', [176 30 113 24],'enable','off');
                                 
  % Checkbutton - V1M                              
  tab2_sp2_ssp1_sssp3.cb(1) = uicontrol ('parent', tab2_sp2_ssp1.sssp(3),'style', 'checkbox',
                                                   'units', 'pixel',
                                                   'string', 'VM1',
                                                   'callback', @getV1M_callback,
                                                   'value', 0,
                                                   'position', [31 75 60 24]);                                 
                                 
  % Checkbutton - V2M                              
  tab2_sp2_ssp1_sssp3.cb(2) = uicontrol ('parent', tab2_sp2_ssp1.sssp(3),'style', 'checkbox',
                                                   'units', 'pixel',
                                                   'string', 'VM2',
                                                   'callback', @getV2M_callback,
                                                   'value', 0, 
                                                   'position', [95 75 60 24]);  
  % Popupmenu - Horizontal                               
  tab2_sp2_ssp1_sssp3.pm(1) = uicontrol ('parent', tab2_sp2_ssp1.sssp(3),'style',  'popupmenu', 'units',
                                  'pixel', 'backgroundcolor','white',
                                  'string', ar.scale_text,
                                  'position', [176 75 113 24]);                     
                     
                                       
%% --- Sub-Sub-Panel 2-2 --- IMPEDANCE DOMAIN ---
tab2_sp2.ssp(2) = uipanel ('parent', tab2_sp(2), 'title', 'Impedance','foregroundcolor', [0.98039,0.74510,0],...
                'FontWeight', 'bold','titleposition', 'lefttop','position', [0.05 0.04 0.9 0.9]); 
                                     
%% --- Sub-Sub-Sub-Panel 2-2-1 --- FREQUENCY RANGE ---
tab2_sp2_ssp2.sssp(1) = uipanel ('parent', tab2_sp2.ssp(2),  'title', 'Frequency Range',...
                               'titleposition', 'righttop', 'position', [0.05 0.655 0.9 0.27]);
                             
  
  % Button - Set 
  tab2_sp2_ssp2.b(1) = uicontrol ('parent', tab2_sp2_ssp2.sssp(1),'style', 'pushbutton', 'units',
                                 'pixel','string', 'Set', 'callback', @set_VNA_callback,
                                 'position', [31 20 113 24]);        
  
  % Button - Read
  tab2_sp2_ssp2.b(2) = uicontrol ('parent', tab2_sp2_ssp2.sssp(1),'style', 'pushbutton', 'units',
                                 'pixel','string', 'Read', 'callback', @read_VNA_callback,
                                 'position', [176 20 113 24]); 
  
  % Edit - Minimum Frequency                               
  tab2_sp2_ssp2_sssp1.e(1) = uicontrol ('parent', tab2_sp2_ssp2.sssp(1),'style', 'edit', 'units',
                                 'pixel','backgroundcolor','white','string', '0',
                                 'position', [31 55 113 24]);                                
  
  % Edit - Maximum Frequency 
  tab2_sp2_ssp2_sssp1.e(2) = uicontrol ('parent', tab2_sp2_ssp2.sssp(1),'style', 'edit', 'units',
                                 'pixel','backgroundcolor','white','string', '0',
                                 'position', [176 55 113 24]);   
                  
  % Text - Start                             
  tab2_sp2_ssp2_sssp1.t(1) = uicontrol ('parent', tab2_sp2_ssp2.sssp(1),'style', 'text',
                                          'units', 'pixel',
                                          'string', 'Start [Hz]',
                                          'horizontalalignment', 'center',
                                          'position', [31 85 113 24]); 
                        
  % Text - Stop                           
  tab2_sp2_ssp2_sssp1.t(2) = uicontrol ('parent', tab2_sp2_ssp2.sssp(1),'style', 'text',
                                          'units', 'pixel',
                                          'string', 'Stop [Hz]',
                                          'horizontalalignment', 'center',
                                          'position', [176 85 113 24]);                                                

%% --- Sub-Sub-Sub-Panel 2-2-2 --- PLOT OUPUT --- 
tab2_sp2_ssp2.sssp(2) = uipanel ('parent', tab2_sp2.ssp(2),  'title', 'Output Variable',...
        'titleposition', 'righttop', 'position', [0.05 0.42 0.9 0.16]); 
  
  % Checkbox - S11  
  tab2_sp2_ssp2_sssp2.cb(1) = uicontrol ('parent', tab2_sp2_ssp2.sssp(2),'style', 'checkbox',
                                   'units', 'pixel',
                                   'string', 'S11',
                                   'callback', @getS11_callback,
                                   'value', 0,
                                   'position', [20 25 113 24]);
  
  % Checkbox - S21  
  tab2_sp2_ssp2_sssp2.cb(2) = uicontrol ('parent', tab2_sp2_ssp2.sssp(2),'style', 'checkbox',
                                   'units', 'pixel',
                                   'string', 'S21',
                                   'callback', @getS21_callback,
                                   'value', 0,
                                   'position', [100 25 113 24]);
   
%  % Checkbox - Impedance Meter
%   tab2_sp2_ssp2_sssp2.cb(3) = uicontrol ('parent', tab2_sp2_ssp2.sssp(2),'style', 'checkbox',
%                                   'units', 'pixel',
%                                   'string', 'Smith Chart', 
%                                   'callback', @smith_callback,
%                                   'value', 0,
%                                   'position', [20 15 113 24]);  
   
  % Button - Plot   
   tab2_sp2_ssp1.plot_frequency_sweep = uicontrol ('parent', tab2_sp2_ssp2.sssp(2),'style', 'pushbutton', 'units',
                                   'pixel', 'string', 'Plot', 'callback', @plot_callback,
                                   'position', [180 25 113 24]);
                                   
%% --- Sub-Sub-Sub-Panel 2-2-1 --- IMPEDANCE METER ---
tab2_sp2_ssp2.sssp(3) = uipanel ('parent', tab2_sp2.ssp(2),  'title', 'Impedance Meter',...
                               'titleposition', 'righttop', 'position', [0.05 0.1 0.9 0.27]);                                                               
                               
  % Slider - Frequency slider
  tab2_sp2_ssp2_sssp3.sl(1) = uicontrol ('parent', tab2_sp2_ssp2.sssp(3),'style', 'slider', 'units',
                                 'pixel','backgroundcolor','black', 'Min',1,'Max',101,
                                 'callback', @vna_freq_slider_callback,'value',50,
                                 'position', [143 85 140 16]); 
                                                               
  % Edit - Display Frequency                                            
  tab2_sp2_ssp2_sssp3.e(1) = uicontrol ('parent', tab2_sp2_ssp2.sssp(3),'style', 'edit', 'units',
                                          'pixel','backgroundcolor','white','string', 'Frequency',
                                          'position', [32 80 100 24],'enable','off');                                  
  % Text - Real Impedance                               
  tab2_sp2_ssp2_sssp3.t(1) = uicontrol ('parent', tab2_sp2_ssp2.sssp(3),'style', 'text',
                                          'units', 'pixel',
                                          'string', 'Re{Z}:',
                                          'horizontalalignment', 'center',
                                          'position', [25 50 113 24]);   
                                          
  % Edit - Display Real Impedance                                            
  tab2_sp2_ssp2_sssp3.e(2) = uicontrol ('parent', tab2_sp2_ssp2.sssp(3),'style', 'edit', 'units',
                                          'pixel','backgroundcolor','white','string', '0',
                                          'position', [143 50 140 24],'enable','off');                                   
          
  % Text - Imaginary Impedance                              
  tab2_sp2_ssp2_sssp3.t(2) = uicontrol ('parent', tab2_sp2_ssp2.sssp(3),'style', 'text',
                                          'units', 'pixel',
                                          'string', 'Im{Z}:',
                                          'horizontalalignment', 'center',
                                          'position', [25 20 113 24]);     
                                    
  % Edit - Display Imaginary Impedance                                            
  tab2_sp2_ssp2_sssp3.e(3) = uicontrol ('parent', tab2_sp2_ssp2.sssp(3),'style', 'edit', 'units',
                                          'pixel','backgroundcolor','white','string', '0',
                                          'position', [143 20 140 24],'enable','off'); 
        
                               
                                         
%% --- Sub-Sub-Panel 2-3 --- TIME DOMAIN ---
tab2_sp2.ssp(3) = uipanel ('parent', tab2_sp(2), 'title', 'Time','foregroundcolor', [0,0.69020,0.54902],...
                'FontWeight', 'bold','titleposition', 'lefttop','position', [0.05 0.04 0.9 0.9]);
            
%% --- Sub-Sub-Sub-Panel 2-3-2 --- FUNCTION GENERATOR ---                                            
tab2_sp2_ssp3.sssp(2) = uipanel ('parent', tab2_sp2.ssp(3),  'title', 'Signal Generator',...
                                 'titleposition', 'righttop', 'position', [0.05 0.6825 0.9 0.27]);
                               
  % Button - Set Generator 1                             
  tab2_sp2_ssp3.b(1) = uicontrol ('parent', tab2_sp2_ssp3.sssp(2),'style', 'pushbutton', 'units',
                                 'pixel','string', 'Set', 'callback', @set_generator_callback,
                                 'position', [195 15 113 24]);
  
  % Text - Frequency                               
  tab2_sp2_ssp3_sssp2.t(1) = uicontrol ('parent', tab2_sp2_ssp3.sssp(2),'style', 'text',
                                          'units', 'pixel',
                                          'string', 'Frequency [Hz]',
                                          'horizontalalignment', 'left',
                                          'position', [10 85 113 24]); 
                                          
  % Edit - Frequency Gen 1                                           
  tab2_sp2_ssp3_sssp2.e(1) = uicontrol ('parent', tab2_sp2_ssp3.sssp(2),'style', 'edit', 'units',
                                          'pixel','backgroundcolor','white','string', '0',
                                          'position', [115 85 70 24]);
                   
  % Edit - Frequency Gen 2                                          
  tab2_sp2_ssp3_sssp2.e(3) = uicontrol ('parent', tab2_sp2_ssp3.sssp(2),'style', 'edit', 'units',
                                          'pixel','backgroundcolor','white','string', '0',
                                          'position', [115 85 70 24]);                     
                                          
  % Text - Amplitude                               
  tab2_sp2_ssp3_sssp2.t(2) = uicontrol ('parent', tab2_sp2_ssp3.sssp(2),'style', 'text',
                                          'units', 'pixel',
                                          'string', 'Amplitude [Vpp]',
                                          'horizontalalignment', 'left',
                                          'position', [05 50 113 24]); 
                                          
  % Edit - Amplitude Gen 1     
  tab2_sp2_ssp3_sssp2.e(2) = uicontrol ('parent', tab2_sp2_ssp3.sssp(2),'style', 'edit', 'units',
                                          'pixel','backgroundcolor','white','string', '0',
                                          'position', [115 50 70 24]);
                                          
   % Edit - Amplitude Gen 2     
  tab2_sp2_ssp3_sssp2.e(4) = uicontrol ('parent', tab2_sp2_ssp3.sssp(2),'style', 'edit', 'units',
                                          'pixel','backgroundcolor','white','string', '0',
                                          'position', [115 50 70 24]);                                                                                
                                          
  % Checkbox - Sine Waveform - Generator 1                           
  tab2_sp2_ssp3_sssp2.cb(1) = uicontrol ('parent', tab2_sp2_ssp3.sssp(2),'style', 'checkbox',
                                   'units', 'pixel',
                                   'string', 'Sine',
                                   'callback', @waveform_callback,
                                   'value', 0,
                                   'position', [25 15 70 24]);
                                   
  % Checkbox - Square Waveform - Generator 1                           
  tab2_sp2_ssp3_sssp2.cb(2) = uicontrol ('parent', tab2_sp2_ssp3.sssp(2),'style', 'checkbox',
                                   'units', 'pixel',
                                   'string', 'Square',
                                   'callback', @waveform_callback,
                                   'value', 0,
                                   'position', [105 15 70 24]);  
                                   
  % Checkbox - Sine Waveform - Generator 2                           
  tab2_sp2_ssp3_sssp2.cb(3) = uicontrol ('parent', tab2_sp2_ssp3.sssp(2),'style', 'checkbox',
                                   'units', 'pixel',
                                   'string', 'Sine',
                                   'callback', @waveform_callback,
                                   'value', 0,
                                   'position', [25 15 70 24]);
                                   
  % Checkbox - Square Waveform - Generator 2                           
  tab2_sp2_ssp3_sssp2.cb(4) = uicontrol ('parent', tab2_sp2_ssp3.sssp(2),'style', 'checkbox',
                                   'units', 'pixel',
                                   'string', 'Square',
                                   'callback', @waveform_callback,
                                   'value', 0,
                                   'position', [105 15 70 24]); 
                                   
                                   
  % Checkbox - Generator 1                           
  tab2_sp2_ssp3_sssp2.cb(5) = uicontrol ('parent', tab2_sp2_ssp3.sssp(2),'style', 'checkbox',
                                   'units', 'pixel',
                                   'string', 'Generator 1',
                                   'callback', @select_generator_callback,
                                   'value', 0,
                                   'position', [205 85 110 24]);
                                   
  % Checkbox - Generator 2                           
  tab2_sp2_ssp3_sssp2.cb(6) = uicontrol ('parent', tab2_sp2_ssp3.sssp(2),'style', 'checkbox',
                                   'units', 'pixel',
                                   'string', 'Generator 2',
                                   'callback', @select_generator_callback,
                                   'value', 0,
                                   'position', [205 50 110 24]);  
                                   
% Turn off edit box for signal generator 2
set([tab2_sp2_ssp3_sssp2.e(3),tab2_sp2_ssp3_sssp2.e(4), tab2_sp2_ssp3_sssp2.cb(3), tab2_sp2_ssp3_sssp2.cb(4)],'visible','off');  

% Set generator to 1, sine waveform and check the checkbox
set([tab2_sp2_ssp3_sssp2.cb(3),tab2_sp2_ssp3_sssp2.cb(1), tab2_sp2_ssp3_sssp2.cb(5)] ,'value',1);  
sg.Generator = 1;  
sg.Waveform_1 = 1;                          
sg.Waveform_2 = 1;                                                
                                 
%% --- Sub-Sub-Sub-Panel 2-3-1 --- OSCILLOSCOPE --- % [left, bottom, width, height]                   
tab2_sp2_ssp3.sssp(1) = uipanel ('parent', tab2_sp2.ssp(3),  'title', 'Oscilloscope',...
                                 'titleposition', 'righttop', 'position', [0.05 0.255 0.9 0.38]);
    
  % Text - Horizontal   
  tab2_sp2_ssp3_sssp1.t(1) = uicontrol ('parent', tab2_sp2_ssp3.sssp(1),'style', 'text',
                                 'units', 'pixel','string', 'Horizontal','horizontalalignment', 'center',
                                 'position', [31 145 113 24]); 
                                 
  % Popupmenu - Horizontal                               
  tab2_sp2_ssp3_sssp1.pm(1) = uicontrol ('parent', tab2_sp2_ssp3.sssp(1),'style',  'popupmenu', 'units',
                                  'pixel', 'backgroundcolor','white',
                                  'string', osc.hscaletext, 'callback', @osc_timebase_callback,
                                  'position', [31 120 113 24]);    
  
  % Text - Vertical  
  tab2_sp2_ssp3_sssp1.t(2) = uicontrol ('parent', tab2_sp2_ssp3.sssp(1),'style', 'text',
                                 'units', 'pixel','string', 'Vertical','horizontalalignment', 'center',
                                 'position', [31 90 113 24]);
                                 
  % Popupmenu - Vertical                 
  tab2_sp2_ssp3_sssp1.pm(2) = uicontrol ('parent', tab2_sp2_ssp3.sssp(1),'style',  'popupmenu', 'units',
                                  'pixel', 'backgroundcolor','white',
                                  'string', osc.vscaletext, 'callback', @osc_vertical_callback,
                                  'position', [31 65 113 24]);  
  
  % Text - Position Level - Posit
  tab2_sp2_ssp3_sssp1.t(3) = uicontrol ('parent', tab2_sp2_ssp3.sssp(1),'style', 'text',
                                   'units', 'pixel', 'foregroundcolor', 'blue','fontsize',9,
                                   'string', "Posit",'horizontalalignment', 'Left',
                                   'position', [203.5 113 50 20]);
                                   
  % Text - Position Level - Lvl  
  tab2_sp2_ssp3_sssp1.t(4) = uicontrol ('parent', tab2_sp2_ssp3.sssp(1),'style', 'text',
                                   'units', 'pixel', 'foregroundcolor', 'blue','fontsize',9,
                                   'string', "Lvl",'horizontalalignment', 'Left',
                                   'position', [203.5 93 50 20]);    

  % Text - Position Level - -4  
  tab2_sp2_ssp3_sssp1.t(5) = uicontrol ('parent', tab2_sp2_ssp3.sssp(1),'style', 'text',
                                   'units', 'pixel', 'foregroundcolor', 'blue','fontsize',9,
                                   'string', "-4",'horizontalalignment', 'Left',
                                   'position', [203.5 65 50 20]);  
                                   
  % Text - Position Level - +4  
  tab2_sp2_ssp3_sssp1.t(6) = uicontrol ('parent', tab2_sp2_ssp3.sssp(1),'style', 'text',
                                   'units', 'pixel', 'foregroundcolor', 'blue','fontsize',9,
                                   'string', "+4",'horizontalalignment', 'Left',
                                   'position', [203.5 145 50 20]);                                     
  
  % Slider - Position Level
  tab2_sp2_ssp3_sssp1.sl(1) = uicontrol ('parent', tab2_sp2_ssp3.sssp(1),'style', 'slider', 'units',
                                    'pixel','backgroundcolor','blue', 'Min',-124,'Max',124, 
                                    'callback', @osc_position_callback,'value',0,
                                    'position', [180 65 16 95]);   
  
  % Text - Trigger Level - Trig 
  tab2_sp2_ssp3_sssp1.t(7) = uicontrol ('parent', tab2_sp2_ssp3.sssp(1),'style', 'text',
                                   'units', 'pixel', 'foregroundcolor', 'magenta','fontsize',9,
                                   'string', "Trig",'horizontalalignment', 'Left',
                                   'position', [270 113 50 20]);
                                   
  % Text - Trigger Level - Lvl  
  tab2_sp2_ssp3_sssp1.t(8) = uicontrol ('parent', tab2_sp2_ssp3.sssp(1),'style', 'text',
                                   'units', 'pixel', 'foregroundcolor', 'magenta','fontsize',9,
                                   'string', "Lvl",'horizontalalignment', 'Left',
                                   'position', [270 93 50 20]);    

  % Text - Trigger Level - -4  
  tab2_sp2_ssp3_sssp1.t(9) = uicontrol ('parent', tab2_sp2_ssp3.sssp(1),'style', 'text',
                                   'units', 'pixel', 'foregroundcolor', 'magenta','fontsize',9,
                                   'string', "-4",'horizontalalignment', 'Left',
                                   'position', [270 65 50 20]);  
                                   
  % Text - Trigger Level - +4  
  tab2_sp2_ssp3_sssp1.t(10) = uicontrol ('parent', tab2_sp2_ssp3.sssp(1),'style', 'text',
                                   'units', 'pixel', 'foregroundcolor', 'magenta','fontsize',9,
                                   'string', "+4",'horizontalalignment', 'Left',
                                   'position', [270 145 50 20]);                                     
  
  % Slider - Trigger Level  
  tab2_sp2_ssp3_sssp1.sl(2) = uicontrol ('parent', tab2_sp2_ssp3.sssp(1),'style', 'slider', 'units',
                                 'pixel','backgroundcolor','black', 'Min',-124,'Max',124,
                                 'callback', @osc_trigger_callback,'value',0,
                                 'position', [246.5 65 16 95]);
                                   
  % Button - Set    
  tab2_sp2_ssp3_sssp1.pb(1) = uicontrol ('parent', tab2_sp2_ssp3.sssp(1),'style', 'pushbutton', 'units',
                                 'pixel','string', 'Set', 'callback', @osc_set_callback,
                                 'position', [31 25 113 24]);  
  
  % Button - Read
  tab2_sp2_ssp3_sssp1.pb(2) = uicontrol ('parent', tab2_sp2_ssp3.sssp(1),'style', 'pushbutton', 'units',
                                 'pixel','string', 'Read', 'callback', @osc_read_callback,
                                 'position', [176 25 113 24]);  
                              
%% --- Sub-Sub-Sub-Panel 2-2-2 --- PLOT OUPUT ---  % [left, bottom, width, height]   
tab2_sp2_ssp3.sssp(3) = uipanel ('parent', tab2_sp2.ssp(3),  'title', 'Output Variable',...
                                'titleposition', 'righttop', 'position', [0.05 0.0475 0.9 0.16]);                           
   
  % Checkbox - Time                                 
  tab2_sp2_ssp3_sssp1.cb(1) = uicontrol ('parent', tab2_sp2_ssp3.sssp(3),'style', 'checkbox',
                                   'units', 'pixel','string', 'Time',
                                   'value', 0, 'callback', @osc_time_callback,
                                   'position', [25 25 113 24]);  
  
  % Checkbox - FFT  
  tab2_sp2_ssp3_sssp1.cb(2) = uicontrol ('parent', tab2_sp2_ssp3.sssp(3),'style', 'checkbox',
                                   'units', 'pixel','string', 'FFT',
                                   'value', 0, 'callback', @osc_fft_callback,
                                   'position', [105 25 113 24]);
                        
  % Button - Plot    
  tab2_sp2_ssp3.refresh_oscilloscope = uicontrol ('parent', tab2_sp2_ssp3.sssp(3),'style', 'pushbutton', 'units',
                                 'pixel','string', 'Plot', 'callback', @plot_callback,
                                 'position', [180 25 113 24]);    
                                   
                                 
  % Init -> Turn off tabs that are not dc-domain
  set([tab2_sp2.ssp(2)],'visible','off') 
  set([tab2_sp2.ssp(3)],'visible','off')     
                
%% --- Sub-Panel 3 ---  EQUIPMENT PANEL ---
tab2_sp(3) = uipanel ('parent', tab(2), 'title', 'Equipment Panel', 'position', [0.68 0.515 0.3 0.465]); % [left, bottom, width, height]

%% --- DC DOMAIN EQUIPMENT ---  % [left, bottom, width, height]

tab2_sp3.ssp(1) = uipanel ('parent', tab2_sp(3),  'title', 'DC','foregroundcolor', [0.43922,0.18824,0.62745],...
                  'FontWeight', 'bold', 'titleposition', 'righttop', 'position', [0.05 0.25 0.9 0.7]);    

  for i = 1:length(Equ_DC_Names)
    % Text - DC Equipment
    tab2_sp3.t(i) =  uicontrol ('parent', tab2_sp3.ssp(1),'style', 'text','units', 'pixel', ...
                  'fontsize',8, 'horizontalalignment', 'center','string', Equ_DC_Names(i),...
                  'position', [10 170-32*(i-1) 113 20]);
    % Text - DC Equipment
    tab2_sp3.t2(i) = uicontrol ('parent',tab2_sp3.ssp(1),'style', 'text', 'units', 'pixel',...
                  'horizontalalignment', 'center', 'string', Equ_DC_Connect(i),'fontsize',8,...
                  'position', [191 170-32*(i-1) 113 20]);
    % Row lines underneath buttons
    tab2_sp3.l(i) = uipanel ('parent', tab2_sp3.ssp(1), 'units', 'pixels',...
                  'backgroundcolor', [0.94118,0.94118,0.94118],...   
								  'position', [125 176-32*(i-1) 100 5]); % 0.83                        
    % Radiobutton - DC Equipment
    tab2_sp3.rb(i) = uicontrol ('parent',tab2_sp3.ssp(1),'style', 'radiobutton', 'units', 'pixel',...
                  'horizontalalignment', 'center', ...
                  'position', [167.5 170-32*(i-1) 15 20],'callback',{@matrix_equipment});                
  end
 
%% --- TIME DOMAIN EQUIPMENT ---  % [left, bottom, width, height]

tab2_sp3.ssp(2) = uipanel ('parent', tab2_sp(3),  'title', 'Time','foregroundcolor', [0,0.69020,0.54902],...
                  'FontWeight', 'bold', 'titleposition', 'righttop', 'position', [0.05 0.25 0.9 0.7]);    
 
   for i = 1:length(Equ_Time_Names)
    % Text - Time Equipment
    tab2_sp3.t(i+length(Equ_Time_Names)) =  uicontrol ('parent', tab2_sp3.ssp(2),'style', 'text','units', 'pixel', ...
                  'fontsize',8, 'horizontalalignment', 'center','string', Equ_Time_Names(i),...               
                  'position', [20 170-32*(i-1) 113 20]);
    % Text - Time Equipment
    tab2_sp3.t2(i+length(Equ_Time_Names)) = uicontrol ('parent',tab2_sp3.ssp(2),'style', 'text', 'units', 'pixel',...
                  'horizontalalignment', 'center', 'string', Equ_Time_Connect(i),'fontsize',8,...
                  'position', [196 170-32*(i-1) 113 20]);                     
    % Row lines underneath buttons
    tab2_sp3.l(i+length(Equ_Time_Names)) = uipanel ('parent', tab2_sp3.ssp(2), 'units', 'pixels',...
                  'backgroundcolor', [0.94118,0.94118,0.94118],...   
								  'position', [125 176-32*(i-1) 100 5]); % 0.83                      
    % Radiobutton - Time Equipment
    tab2_sp3.rb(i+length(Equ_Time_Names)) = uicontrol ('parent',tab2_sp3.ssp(2),'style', 'radiobutton', 'units', 'pixel',...
                  'horizontalalignment', 'center', ...
                  'position', [167.5 170-32*(i-1) 15 20],'callback',{@matrix_equipment});
  end
                   
  % Radiobutton - Oscilloscope PIN 1
  tab2_sp3.rb(11) = uicontrol ('parent',tab2_sp3.ssp(2),'style', 'radiobutton', 'units', 'pixel',...
                  'horizontalalignment', 'center', 'string', Equ_Time_Connect(5),'fontsize',8,...
                  'position', [167.5 170-32*(4) 15 20],'callback',{@matrix_equipment});  
                  
  % Radiobutton - Oscilloscope PIN 2
  tab2_sp3.rb(12) = uicontrol ('parent',tab2_sp3.ssp(2),'style', 'radiobutton', 'units', 'pixel',...
                  'horizontalalignment', 'center', 'string', Equ_Time_Connect(6),'fontsize',8,...
                  'position', [167.5 170-32*(5) 15 20],'callback',{@matrix_equipment});
                  
  %% --- IMPEDANCE DOMAIN EQUIPMENT ---  % [left, bottom, width, height]
  
  tab2_sp3.ssp(3) = uipanel ('parent', tab2_sp(3),  'title', 'Impedance','foregroundcolor', [0.98039,0.74510,0],...
                  'FontWeight', 'bold', 'titleposition', 'righttop', 'position', [0.05 0.25 0.9 0.7]);    
                                   
   for i = 1:length(Equ_VNA_Names)
    % Text - VNA Equipment
    tab2_sp3.t(i+length(Equ_Time_Names)+length(Equ_DC_Names)) =  uicontrol ('parent', tab2_sp3.ssp(3),'style', 'text','units', 'pixel', ...
                   'fontsize',8, 'horizontalalignment', 'center','string', Equ_VNA_Names(i),...               
                   'position', [26 138-32*(i-1) 113 20]);
    % Text - VNA Equipment
    tab2_sp3.t2(i+length(Equ_Time_Names)+length(Equ_DC_Names)) = uicontrol ('parent',tab2_sp3.ssp(3),'style', 'text', 'units', 'pixel',...
                    'horizontalalignment', 'center', 'string', Equ_VNA_Connect(i),'fontsize',8,...
                    'position', [191 138-32*(i-1) 113 20]);                     
    % Row lines underneath buttons
    tab2_sp3.l(i+length(Equ_Time_Names)+length(Equ_DC_Names)) = uipanel ('parent', tab2_sp3.ssp(3), 'units', 'pixels',...
                    'backgroundcolor', [0.94118,0.94118,0.94118],...
								    'position', [125 144-32*(i-1) 100 5]); % 0.83                      
    % Radiobutton - Time Equipment
    tab2_sp3.rb(i+length(Equ_Time_Names)+length(Equ_DC_Names)) = uicontrol ('parent',tab2_sp3.ssp(3),'style', 'radiobutton', 'units', 'pixel',...
                    'horizontalalignment', 'center', ...
                    'position', [167.5 138-32*(i-1) 15 20],'callback',{@matrix_equipment});
  end                 

%% --- SUBMIT BUTTON ---  % [left, bottom, width, height]  
  % Button - Submit    
  tab2_sp3.b(1) = uicontrol ('parent', tab2_sp(3),'style', 'pushbutton', 'units','pixel',
                  'horizontalalignment', 'center','string', 'Submit',...
                  'position', [215.67 26 113 24],'callback', {@equipment_submit});
                  
%% --- RESET BUTTON ---  % [left, bottom, width, height]  
  % Button - Submit    
  tab2_sp3.b(2) = uicontrol ('parent', tab2_sp(3),'style', 'pushbutton', 'units','pixel',
                  'horizontalalignment', 'center','string', 'Reset',...
                  'position', [51.33 26 113 24],'callback', {@equipment_reset});                  

% Init -> Turn off equipment tabs that are not dc-domain
set([tab2_sp3.ssp(2)],'visible','off') 
set([tab2_sp3.ssp(3)],'visible','off') 
  
%% --- Sub-Panel 4 --- CAMERA ---
tab2_sp(4) = uipanel ('parent', tab(2), 'title', 'Video Camera', 'position',  [0.68 0.03 0.3 0.465]);
              
  % Checkbutton - Camera 1   % [left, bottom, width, height]
  tab2_sp4.cb(1) = uicontrol ('parent',tab2_sp(4),'style', 'checkbox','units','pixel',
                              'string', 'Camera 1','callback',{@webcam1_tab2},
                              'value', 0,'position', [70 25 120 24]);   
                              
  % Checkbutton - Camera 2   % [left, bottom, width, height]
  tab2_sp4.cb(2) = uicontrol ('parent',tab2_sp(4),'style', 'checkbox','units','pixel',
                              'string', 'Camera 2','callback',{@webcam2_tab2},
                              'value', 0,'position', [220 25 120 24]);         
