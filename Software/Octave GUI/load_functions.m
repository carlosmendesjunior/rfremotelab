%%% Load all Functions
%%% Eindhoven Unversity of Technology
%%% Authors: Dr. Carlos Mendes Jr.

1; % not a function file, but a file with a set of functions

%% Load Octave GUI
source("./Functions/GUI/octave_tabs.m");
  % TabGroupHandle = uitabgroup( FigHandle, PosOpt, PosVal );
  % on_tab_select( Handle, Event, TabGroupHandle, TabPanel );
  % TabPanel = uitab( TabGroupHandle, TitleOpt, TitleVal );
  
source("./Functions/GUI/callback_functions_Tab1.m");
 % matrix_internal(handle,event);
 % matrix_external(handle,event);
 % matrix_reset();
 % matrix_submit();
 
source("./Functions/GUI/callback_functions_Tab2.m");
  % measurement_select()
  % update_plot(obj, init = false)
  % plot_output_values(obj)
  % plot_output(obj)
  % start_sweep(obj)
  % reset_sweep(obj)
  % measure_v1m(obj)
  % measure_v2m(obj)
  % start_frequency_sweep(obj)
  % reset_frequency_sweep(obj)
  % Timebase_select(obj)
  % Vertical_select(obj)
  % Position_select(~,~)
  % Trigger_select(~,~)
  % set_oscilloscope(obj)
  % set_function_generator_1(obj)
  
source("./Functions/GUI/callback_functions_Tab1_Tab2.m");

source("./Functions/GUI/warning_functions.m");
  % warning_voltage(volt)
  % short_circuit(matrix,res)

%% DUT
source("./Functions/DUT/dut_functions.m");
  % data = mapping(vv,rv,miv,mev)
  % res_bits = resistor_map(rv)
  % volts_bits = volts_map(vv)
  % dut_init()
  
%% Equipment
source("./Functions/Equipment/equipment_mapping.m");
  % data = equipment_mapping()
  
%% Plot
source("./Functions/Plot/plot_callback_functions.m");
  % grid_callback()
  % grid_minor_callback()
  % log_y_callback()  
  % log_x_callback()
  % axis_tight_callback()
  % hold_on_callback()
  % clear_plot_callback()
  % save_plot_callback()
  % ticks()
  % labels()
  % plot_labels()
  % str = eng_format(x)
  % retStr = convert_unit(str)
  % retStr = convert_unit_back(num)
  % osc_options()
  % plot_trig_vlvl()
  % plot_callback()

%% Arduino
source("./Functions/Arduino/Arduino_functions.m");
  % retval = cmd2uC(cmd)
  % init_uC(newPort)
  % retval=getVout(ar)
  % retval=getPin(nr) 
  % setFG_1(frequency)
  % setFG_2(frequency)

source("./Functions/Arduino/spi_soft.m");
  % spi_soft();
  
source("./Functions/Arduino/octave2arduino.m");
  % octave2arduino(port,mode,data_in)
  
 %% Voltmeter
source("./Functions/Voltmeter/voltmeter_callback_functions.m");
  % measure_vm_callback()
  % getV1M_callback()
  % getV2M_callback()

%% Oscilloscope
source("./Functions/Oscilloscope/Oscilloscope_functions.m");
  % osc_init()
  % retval=DSO112A(cmd)
  % id=getIdDSO112A()
  % initDSO112A()
  % exitDSO112A()
  % retval = getHeaderDSO112A()
  % retval=dumpDataDSO112A(datasize)
  % traceData=getTraceDSO112A()
  % setParametersDSO112A()
  % getParametersDSO112A()
  % retval = Calc_TS(Timebase)
  % [x,y] = FFT_DS0112A(Data,TS)
  
source("./Functions/Oscilloscope/Oscilloscope_callback_functions.m");
  % update_osc_gui()
  % set_oscilloscope_callback()
  % osc_read_callback()
  % osc_time_callback()
  % osc_fft_callback()
  % osc_position_callback()
  % osc_trigger_callback()
  % osc_timebase_callback()
  % osc_vertical_callback()

%% Power Supply
source("./Functions/PowerSupply/PS_functions.m");	
  % [current_meas,voltage_meas_out,voltage_meas_in] = DC_measurement(ps)
  % [session] = PS_init()
  % PS_set_25(ps)
  % PS_set_6(ps)
  % [current_sweep, voltage, voltage_in] = PS_sweep(ps,f)
  % [current] = PS_read(session)
  % PS_close(session)
  
source("./Functions/PowerSupply/PS_callback_functions.m");
  % start_sweep_callback()
  % set_sweep(obj)
  % v_plot_callback()
  % i_plot_callback()

%% nanoVNA
source("./Functions/nanoVNA/nanoVNA_functions.m");
  % [nanoS11, nanoS21, nanoFrequencies] = VNA_measurement(vna)
  % retval = nanoVNA(cmd);
  % initVNA();
  % retval = getNanoFrequencies();
  % setNanoFrequencies(minFreq,maxFreq);
  % autoSetNanoFrequencies();
  % retval = getNanoData(port);
  % retval = getNanoS11();
  % retval = getNanoS21();
  % retval = nanoInfo();
  % nanoPause();
  % nanoResume();
  
source("./Functions/nanoVNA/nanoVNA_callback_functions.m");  
  % update_VNA_gui()
  % set_VNA_callback()
  % read_VNA_callback()
  % reset_VNA_callback()
  % getS11_callback()
  % getS21_callback()
  % smith_callback()
  % vna_freq_slider_callback()
  
source("./Functions/nanoVNA/smith.m");
  % smith();

%% Signal Generator
source("./Functions/Generator/generator_callback_functions.m");
  % set_generator_callback()
  % waveform_callback()
  % select_generator_callback()

source("./Functions/Generator/generator_functions.m");
  % sg_init()
  % get_sg()
  % set_sg(Frequency,Amplitude, Waveform)
  % retval=FY3200S(cmd)
  % SetWaveform(Waveform)
  % SetFrequency(Frequency)
  % SetAmplitude(Amplitude)
  % SetDCoffset()
  % SetPhase()
  % SetDutyCycle()
  % SetSweepTime()
  % SavePosition()
  % LoadPosition()
  % ControlSweep()
  % ResetCounter()
  % SetSweepMode()
  % SetSweepBeginFreq()
  % SetSweepEndFreq()
  % ResetAmplitude()
  % SetbackAmplitude()