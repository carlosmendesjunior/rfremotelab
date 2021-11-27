%% Mapping Bits to the Motherboard
% Author: Carlos Mendes, Jr.
% Date: 29/12/2021
% TU/e - IC Group

1; % not a function file, but a file with a set of functions

function data = equipment_mapping(meq) % (Mat_Equ_Val)
  
  data = []; % char(zeros(1,22*8)+48);
  meq = char(meq+48);

  % Equipment Switches --> IC1
  sw(1,1)   = meq(1,15);                             % VNA P2  <-> VOUT 1
  sw(1,2)   = meq(1,16);                             % VNA P2  <-> VOUT 2
  sw(1,3)   = char(not(str2num(meq(1,13)))+48);      % VNA P1  <-> VIN 1 not
  sw(1,4)   = char(not(str2num(meq(1,14)))+48);      % VNA P1  <-> VIN 2 not
  % Equipment Switches --> IC2
  sw(1,5)   = meq(1,4);                              % BIAS 3  <-> DUT
  sw(1,6)   = meq(1,1);                              % V SWEEP <-> VIN 3
  sw(1,7)   = char(not(str2num(meq(1,2)))+48);       % BIAS 1  <-> DUT not
  sw(1,8)   = char(not(str2num(meq(1,3)))+48);       % BIAS 2  <-> DUT not
  % Equipment Switches --> IC3
  sw(1,9)   = meq(1,9);                              % SG2+    <-> VIN 3
  sw(1,10)  = meq(1,10);                             % SG2-    <-> VIN 4
  sw(1,11)  = char(not(str2num(meq(1,7)))+48);       % SG1+    <-> VIN 1 not 
  sw(1,12)  = char(not(str2num(meq(1,8)))+48);       % SG1-    <-> VIN 2 not
  % Equipment Switches --> IC4
  sw(1,13)  = meq(1,5);                              % VM1     <-> VOUT 1
  sw(1,14)  = meq(1,6);                              % VM2     <-> VOUT 2
  sw(1,15)  = char(not(str2num(meq(1,11)))+48);      % OSC     <-> VOUT 1 not
  sw(1,16)  = char(not(str2num(meq(1,12)))+48);      % OSC     <-> VOUT 2 not
  
  data = sw;
    
end