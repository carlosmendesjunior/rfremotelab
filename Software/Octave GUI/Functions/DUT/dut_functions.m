%% Mapping Bits to the DUT
% Author: Carlos Mendes Jr
% Date: 11/Nov/2020
% TU/e - IC Group

1; % not a function file, but a file with a set of functions

function data = switches(rv,miv,mev) % (Volt_Val,Res_Val,Mat_Int_Val,Mat_Ext_Val)

  data = []; % char(zeros(1,22*8)+48);
  miv = char(miv+48);
  mev = char(mev+48);

  % Internal Circuit
  sw(1,:)  = [  miv(1,[1:6 8 10])                                       ]; % DN1
  sw(2,:)  = [  miv(1,[11:12 14])   miv(2,[3:4 6 8 10])                 ]; % DN1 G2
  sw(3,:)  = [  miv(2,[11:12 14])   miv(3,[3 5:8])                      ]; % G2 SN2
  sw(4,:)  = [  miv(3,[9:10 12 14]) miv(4,[4:6 8])                      ]; % SN2 DN2
  sw(5,:)  = [  miv(4,[10:12 14])   miv(5,[6 8 10:11])                  ]; % DN2 G3
  sw(6,:)  = [  miv(5,[12 14])      miv(6,[6:10 12])                    ]; % G3 SN3
  sw(7,:)  = [  miv(6,14)           miv(7,[8 10:12 14]) miv(8,[8 10])   ]; % SN3 D3 SP3 
  sw(8,:)  = [  miv(8,[11:12 14])   miv(9,[9:10 12 14]) miv(10,10)      ]; % SP3 DP2 SP2
  sw(9,:)  = [  miv(10,[11:12 14])  miv(11,[11:12 14])  miv(12,[12 14]) ]; % SP2 DP1 G1
  
  % External Connection
  sw(10,:)  = [ mev(1,[2:3 5:6 12 14 16]) mev(2,2)          ]; % VIN1 VIN2
  sw(11,:)  = [ mev(2,[3 5:6 12 14 16])   mev(3,2:3)        ]; % VIN2 VIN3
  sw(12,:)  = [ mev(3,[5:6 12 14 16])     mev(4,[2:3 5])    ]; % VIN3 VIN4
  sw(13,:)  = [ mev(4,[6 12 14 16])       mev(5,[1 3:4 6])  ]; % VIN4 VO1
  sw(14,:)  = [ mev(5,[9 11 14 16])       mev(6,[1 3:4 6])  ]; % VO1 VO2
  sw(15,:)  = [ mev(6,[9 11 14 16])       mev(7,[1:2 4:5])  ]; % VO2 VDD
  sw(16,:)  = [ mev(7,[7:8 10 12 14 16])  mev(8,[2:3])      ]; % VDD GND
  sw(17,:)  = [ mev(8,[5:7 9 11:12 14 16])                  ]; % GND

  % Resistors
  sw(18,:)  = resistor_map(char(rv(1))); % R1
  sw(19,:)  = resistor_map(char(rv(2))); % R2
  
  % Filling data vector
  for i = 1:19
    data = [fliplr(sw(i,:)) char(data)];
  end

end

function res_bits = resistor_map(rv) % From PCB design
  
  switch rv
    case '--'
      %error('Not a resistor value.');
      res_bits = '00000000';
    case '200k' 
      res_bits = '00000001';
    case '110k'
      res_bits = '00000010';
    case '56k'
      res_bits = '00000100';
    case '33k'
      res_bits = '00001000';
    case '18k'
      res_bits = '00010000';
    case '9.1k'
      res_bits = '00100000';
    case '5.1k'
      res_bits = '01000000';
    case '51'
      res_bits = '10000000';
  end  
  
end

function data_out = dig_pot(pot_number,volt_val,data_in) % From AD5204 datasheet

  switch pot_number
    case 1 % G1
      pot_name = fliplr('000');
    case 2 % G2
      pot_name = fliplr('001');
    case 3 % G3
      pot_name = fliplr('010');
  end
      
  pot_bits = fliplr(dec2bin(round((volt_val/5)*255),8));
  data_out = [fliplr([pot_bits pot_name]) data_in];
 
end

function dut_init() % Reset all       
        
  data_out = dig_pot(1,0,char(zeros(1,152)+48));
  spi_soft('d', data_out); 
  data_out = dig_pot(2,0,char(zeros(1,152)+48));
  spi_soft('d', data_out); 
  data_out = dig_pot(3,0,char(zeros(1,152)+48));
  spi_soft('d', data_out); 
  
end