%%% Global Variables
%%% Eindhoven Unversity of Technology
%%% Authors: Dr. Carlos Mendes, Jr.

1; % not a function file, but a file with a set of functions

%% Equipment Connections
global dut; % Device Under Test
global ps;  % Power Supply
global ar;  % Arduino
global vna; % Vector Network Analyzer
global osc; % Oscilloscope
global sg;  % Signal Generator

%% COM Ports (on Windows COM below 10)
dut.port  = "/dev/ttyUSB3";
ar.port   = "/dev/ttyUSB4";
vna.port  = "/dev/ttyACM0";
osc.port  = "/dev/ttyUSB2";
ps.port   = "/dev/ttyS0";
sg.port_1  = "/dev/ttyUSB1"; % sg1
sg.port_2  = "/dev/ttyUSB0"; % sg2

%% Webcam 1 
global cam1 = videoinput("v4l2", "/dev/video0");
set(cam1, "VideoFormat", "RGB24");
set(cam1, "VideoResolution", 2*[320 240]);

%% Webcam 2
global cam2 = videoinput("v4l2", "/dev/video2"); % 1 or 2
set(cam2, "VideoFormat", "RGB24");
set(cam2, "VideoResolution", [320 240]);

%% Circuit Settings
global Volt_Val   = [0,0,0,5]; % [VB1,VB2,VB3,SUP]
global Res_Val    = {'200k', '200k'};
global Res_Names  = {'--','200k','110k','56k','33k','18k','9.1k','5.1k','51'};

%% Connection Matrix - Internal
global Mat_Int_Row_N = 12;
global Mat_Int_Col_N = 16;
global Mat_Int_Row_Names = {'DN1','G2','SN2','DN2','G3','SN3','D3','SP3','DP2','SP2','DP1','G1','R1P','R1N','R2P','R2N'};
global Mat_Int_Val = zeros(Mat_Int_Row_N,Mat_Int_Col_N-1);

%% Connection Matrix - External
global Mat_Ext_Row_N = 8;
global Mat_Ext_Col_N = 16;
global Mat_Ext_Row_Names = {'VIN1','VIN2','VIN3','VIN4','VO1','VO2','VDD','GND','VB1','VB2','VB3'};
global Mat_Ext_Val = zeros(Mat_Ext_Row_N,Mat_Ext_Col_N);

%% Connection Matrix - Equipment
global Equ_DC_Names     = {'Voltage Sweep','Bias Voltage 1','Bias Voltage 2','Bias Voltage 3','Voltmeter (VM1)','Voltmeter (VM2)'};
global Equ_DC_Connect   = {'VIN3','G1','G2','G3','VO1','VO2'};
global Equ_Time_Names   = {'SIGNAL 1+','SIGNAL 1-','SIGNAL 2+','SIGNAL 2-','OSCILLOSCOPE','OSCILLOSCOPE'};
global Equ_Time_Connect = {'VIN1','VIN2','VIN3','VIN4','VO1','VO2'};
global Equ_VNA_Names    = {'VNA PORT 1','VNA PORT 1','VNA PORT 2','VNA PORT 2'};
global Equ_VNA_Connect  = {'VIN1','VIN2','VO1','VO2'};
global Mat_Equ_Val      = zeros(1,length(Equ_DC_Connect) + length(Equ_Time_Connect) + length(Equ_VNA_Connect));

%% Tabs
global tab2;
global tab1_sp;
global tab1_sp1;
global tab1_sp2;
global tab1_sp3;
global tab1_sp4;
global tab1_sp5;
global tab1_sp3_ssp1;
global tab1_sp3_ssp2;
global tab2_sp;
global tab2_sp1;
global tab2_sp2;
global tab2_sp3;
global tab2_sp4;
global tab2_sp2_ssp1;
global tab2_sp2_ssp2;
global tab2_sp2_ssp3;
global tab2_sp3_ssp1;  
global tab2_sp3_ssp2;
global tab2_sp3_ssp3;
global tab2_sp2_ssp1_sssp1;
global tab2_sp2_ssp1_sssp2;
global tab2_sp2_ssp1_sssp3;						   
global tab2_sp2_ssp2_sssp1;
global tab2_sp2_ssp2_sssp2;
global tab2_sp2_ssp2_sssp3; 
global tab2_sp2_ssp3_sssp1;
global tab2_sp2_ssp3_sssp2;

%% Init plot
global data;
global plot_on = 0;
global plot_x_labels = {'Vin [V]', 'Vin [V]', 'Frequency [Hz]', 'Frequency [Hz]' ...
                       'Time [s]','Frequency [Hz]'};
global plot_y_labels = {'Vout [V]', 'Current [A]','S_{11} [dB]','S_{21} [dB]' ...
                       'Vout [V]', 'Magnitude [dB]'};

%% Tab - Pop-up menu
global Measurement_names = {'DC', 'Time', 'Impedance'};

%% DC Measurements
global current_meas;
global voltage_meas_out;
global voltage_meas_in; 
global V1M;
global V2M;
ps.max_cur = 50e-3;
ar.scale_text = {'uV','mV','V'};
ar.scale_factor = [10^(6), 10^(3), 1];

%% VNA Measurements
global nanoS11;
global nanoS21;
global nanoFrequencies;
vna.freq = 0;

%% Signal Generator
sg.Waveform = 0;
sg.Frequency = 100;
sg.Amplitude = 0.01;
sg.DCoffset = 0;
sg.DutyCycle = 50;
sg.SweepTime = 10;
sg.ControlSweep = 0;
sg.SweepBeginFreq = 10000;
sg.SweepEndFreq = 20000;
sg.SweepMode = 1;
sg.Channel = 1;
sg.Phase = 180;

%% oscilloscope Measurements
global Timebase_names = {'20ms/div','10ms/div','5ms/div','2ms/div','1ms/div','0.5ms/div','0.2ms/div','0.1ms/div', '50us/div','20us/div','10us/div', '5us/div','2us/div','1us/div'};
global Vertical_sens_names = {'20V/div','10V/div','5V/div','2V/div','1V/div','0.5V/div','0.2V/div','0.1V/div','50mV/div','20mV/div','10mV/div','5mV/div','2mV/div'}
global Timebase = 0x11;       % 20 ms/div standard
global Vertical_sens = 0x03;  % 20 V/div standard
osc.vscalefactor = [20 10 5 2 1 0.5 0.2 0.1 0.05 0.02 0.01 0.005 0.002];
osc.vscaletext = {"20V/div" "10V/div" "5V/div" "2V/div" "1V/div" "0.5V/div" "0.2V/div" "0.1V/div" "50mV/div" "20mV/div" "10mV/div" "5mV/div" "2mV/div"}; 
osc.hscalefactor = [50 20 10 5 2 1 0.5 0.2 0.1 0.05 0.02 0.01 0.005 0.002 0.001 0.0005 0.0002 0.0001 0.00005 0.00002 0.00001 0.000005 0.000002 0.000001];
osc.hscaletext = {"50s/div" "20s/div" "10s/div" "5s/div" "2s/div" "1s/div" "0.5s/div" "0.2s/div" "0.1s/div" "50ms/div" "20ms/div" "10ms/div" "5ms/div" "2ms/div" "1ms/div" "0.5ms/div" "0.2ms/div" "0.1ms/div" "50us/div" "20us/div" "10us/div" "5us/div" "2us/div" "1us/div"};

data.osc = 0;
osc.c(1) = 0;
osc.c(2) = 0;
osc.data = zeros(1,512);

% Waitbar
global h;