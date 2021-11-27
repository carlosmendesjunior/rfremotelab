%%% Callback Functions
%%% Eindhoven Unversity of Technology
%%% Author: Dr. Carlos Mendes, Jr.

1; % not a function file, but a file with a set of functions

function matrix_internal(handle,event)
  
  global Mat_Int_Val
  global tab1_sp3_ssp1
  
  temp_val = get( handle, 'value' );
  [temp_row,temp_col] = find(tab1_sp3_ssp1.rb == handle);
  Mat_Int_Val(temp_row,temp_col-1) = temp_val;

  %disp(Mat_Int_Val);

end

function matrix_external(handle,event)
  
  global Mat_Ext_Val
  global tab1_sp3_ssp2;
  
  temp_val = get( handle, 'value' );
  [temp_row,temp_col] = find(tab1_sp3_ssp2.rb == handle);
  Mat_Ext_Val(temp_row,temp_col) = temp_val;

  %disp(Mat_Ext_Val);

end

function matrix_reset()
  
  global Mat_Int_Row_N
  global Mat_Int_Col_N
  global Mat_Ext_Row_N
  global Mat_Ext_Col_N
  global tab1_sp3_ssp1;
  global tab1_sp3_ssp2;
  global tab1_sp2;
  global Mat_Int_Val;
  global Mat_Ext_Val;  
  
  % Dialog Question
  answer = questdlg('Are you sure you want to reset everything?', 'Warning', 'Yes', 'No');
  
  % handle response
  switch answer
      case 'Yes'
        
        % Set radiobuttons to zero
        for i = 1:Mat_Int_Row_N
          for j = 1:Mat_Int_Col_N   
            if (j > i)
              set(tab1_sp3_ssp1.rb(i,j),'value',0)
            end
          end
        end
        
        for i = 1:Mat_Ext_Row_N
          for j = 1:Mat_Ext_Col_N   
            set(tab1_sp3_ssp2.rb(i,j),'value',0)
          end
        end
        
        % Restore values
        set(tab1_sp2.e(1),'string','0');
        set(tab1_sp2.e(2),'string','0');
        set(tab1_sp2.e(3),'string','0');
        set(tab1_sp2.e(4),'string','5');
        set(tab1_sp2.p(1),'value',1);
        set(tab1_sp2.p(2),'value',1);
        
        % Reset color bars
        Mat_Int_Val(:,:) = 0; 
        Mat_Ext_Val(:,:) = 0;        
        set_int_color(Mat_Int_Val);
        set_ext_color(Mat_Ext_Val);  

        % Set signal generators lower 
        ResetAmplitude();
        
        % Reset the DUT
        dut_init();

        % Restore signal generators           
        SetbackAmplitude()          
        
        msgbox('Circuit reset successfully.');        
    case 'No'
      % Do nothing
      
    case 'Cancel'
      % Do nothing
  end
    
end

function matrix_submit()
  
  % Variables
  global tab1_sp2;
  global Volt_Val;
  global Res_Val;
  global Res_Names;
  global Mat_Int_Val;
  global Mat_Ext_Val;
  global Mat_Equ_Val;
  global tab2_sp3;  
  
  f = zeros(1,3);
  
  % Dialog Question
  answer = questdlg('Are you sure you want to submit your circuit?', 'Warning', 'Yes', 'No');
  
  % handle response
  switch answer
      case 'Yes'
         
        % Set signal generators lower 
        ResetAmplitude();

        try 
          Volt_Val(1) = str2num(get(tab1_sp2.e(1),'string')); 
          Volt_Val(2) = str2num(get(tab1_sp2.e(2),'string')); 
          Volt_Val(3) = str2num(get(tab1_sp2.e(3),'string')); 
          Volt_Val(4) = str2num(get(tab1_sp2.e(4),'string')); % VDD, not settable
          % Resistors do not need to be necessarily connected
          Res_Val(1)  = Res_Names(get(tab1_sp2.p(1),'value'));
          Res_Val(2)  = Res_Names(get(tab1_sp2.p(2),'value'));
        catch
          beep();
          f(1) = warndlg('Please, fill in all circuit settings before continuing.','Error');
        end
                
        try 
          warning_voltage(Volt_Val);
        catch
          beep();
          f(2) = warndlg('Voltage cannot be great than 5 V! Try again.','Error');  
        end       
       
        try 
          short_circuit();
        catch
          % Play Short-Circuit Audio 
          % https://www.storyblocks.com/audio/stock/electric-sparky-short-circuit-slqs3shnlwhk0wxsbln.html
          beep();
          f(3) = warndlg('Short-Circuit! Current is too high. Try again.','Error');
        end       
        
        try 
          1;
%          warning_ext_matrix(); % allow single column connection
        catch
          beep();
          f(4) = warndlg('Only one external connection per column. Try again.','Error');
        end   
        
        if (~any(f))
          try
            temp_data = switches(Res_Val,Mat_Int_Val,Mat_Ext_Val);
            if (Volt_Val(1)~=0) 
              data_out = dig_pot(1,Volt_Val(1),temp_data); % Pot G1
              spi_soft('d', char(data_out)); % Send data
            end
            if (Volt_Val(2)~=0) 
              data_out = dig_pot(2,Volt_Val(2),temp_data); % Pot G2
              spi_soft('d', char(data_out)); % Send data
            end
            if (Volt_Val(3)~=0) 
              data_out = dig_pot(3,Volt_Val(3),temp_data); % Pot G3
              spi_soft('d', char(data_out)); % Send data
            end
            if ((Volt_Val(1) == 0) && (Volt_Val(2) == 0) && (Volt_Val(3) == 0))
              spi_soft('d', char(temp_data)); % Send data
            end
            set_int_color(Mat_Int_Val);
            set_ext_color(Mat_Ext_Val);  
            
            % Set equipment panel
            [temp_data] = equipment_mapping(Mat_Equ_Val);
            spi_soft('m', char(zeros(1,length(temp_data))+48)); % Reset all
            spi_soft('m', char(temp_data)); % Send data   
     

            % Restore signal generators           
            SetbackAmplitude()  
            
            msgbox('Circuit submitted successfully. Proceed to the measurement tab.');
          catch
            msgbox('Control signal was not sent. Circuit not submitted.');
          end       
        else
          beep();
          warndlg('Circuit not submitted.');
        end
             
        
    case 'No'
      % Do nothing
    case 'Cancel'
      % Do nothing 
    end
 
end

function matrix_equipment(handle,event)
  
  global Mat_Equ_Val;
  global tab2_sp3;
  
  temp_han = handle;
  temp_val = get( handle, 'value' );
  
  [temp_row,temp_col] = find(tab2_sp3.rb == handle);
  Mat_Equ_Val(temp_row,temp_col) = temp_val;

  % Check for Toggle Pair
  toggle_pair(temp_han,temp_val);

end

function set_bar_color(temp_han,temp_val)
  
  global tab2_sp3;
  
  % Set the color of the row bars
  if (temp_val == 0)
   for i = length(tab2_sp3.rb);
     [temp_row,temp_col] = find(tab2_sp3.rb == temp_han);
     set(tab2_sp3.l(temp_row,temp_col),'backgroundcolor', [0.94118,0.94118,0.94118]);
   end  
  elseif (temp_val == 1);
   for i = length(tab2_sp3.rb);
     [temp_row,temp_col] = find(tab2_sp3.rb == temp_han);
     set(tab2_sp3.l(temp_row,temp_col),'backgroundcolor', 'green');
   end      
  endif 
 
endfunction 

function set_int_color(Mat_Val)

  global tab1_sp2;
  global tab1_sp3_ssp1;  
  
  % Change internal matrix lines to green
  [temp_row_1,temp_col_1] = find(Mat_Val == 1); 
  for i = 1:length(temp_row_1)
    set(tab1_sp3_ssp1.l2(1,temp_row_1(i)),'backgroundcolor', 'green')        
  end  
  
  for i = 1:length(temp_col_1)  
    set(tab1_sp3_ssp1.l1(1,temp_col_1(i)+1),'backgroundcolor', 'green')    
  end   
  
  [temp_row_2,temp_col_2] = find(Mat_Val == 0); 
  
  for i = 1:length(temp_row_1)            
    temp_row_2 = temp_row_2(temp_row_2~=temp_row_1(i));           
  end
  
  for i = 1:length(temp_col_1)            
    temp_col_2 = temp_col_2(temp_col_2~=temp_col_1(i));             
  end  
  
  for i = 1:length(temp_row_2)
    set(tab1_sp3_ssp1.l2(1,temp_row_2(i)),'backgroundcolor', [0.94118,0.94118,0.94118])         
  end
  
  for i = 1:length(temp_col_2)     
    set(tab1_sp3_ssp1.l1(1,temp_col_2(i)+1),'backgroundcolor', [0.94118,0.94118,0.94118])    
  end             
            
endfunction  

function set_ext_color(Mat_Val)
  
  global tab1_sp2;
  global tab1_sp3_ssp2;
  
  % Change external matrix lines to green
  [temp_row_1,temp_col_1] = find(Mat_Val == 1); 
  for i = 1:length(temp_row_1) 
    set(tab1_sp3_ssp2.l2(1,temp_row_1(i)),'backgroundcolor', 'green')       
  end 
  for i = 1:length(temp_col_1)   
    set(tab1_sp3_ssp2.l1(1,temp_col_1(i)),'backgroundcolor', 'green')    
  end   
 
  [temp_row_2,temp_col_2] = find(Mat_Val == 0); 
  
  for i = 1:length(temp_row_1)             
    temp_row_2 = temp_row_2(temp_row_2~=temp_row_1(i));             
  end
  
  for i = 1:length(temp_col_1)             
    temp_col_2 = temp_col_2(temp_col_2~=temp_col_1(i));              
  end  
  
  for i = 1:length(temp_row_2) 
    set(tab1_sp3_ssp2.l2(1,temp_row_2(i)),'backgroundcolor', [0.94118,0.94118,0.94118])       
  end 
  for i = 1:length(temp_col_2)   
    set(tab1_sp3_ssp2.l1(1,temp_col_2(i)),'backgroundcolor', [0.94118,0.94118,0.94118])    
  end           
            
endfunction 

function toggle_pair(temp_han,temp_val)
  
  global Mat_Equ_Val;
  global tab2_sp3;
    
  if (temp_han == tab2_sp3.rb(11) && temp_val == 1)
    set( tab2_sp3.rb(12), 'value', 0 )   
    Mat_Equ_Val(1,12) = 0;    
  end
  
  if (temp_han == tab2_sp3.rb(12) && temp_val == 1)
    set( tab2_sp3.rb(11), 'value', 0 )   
    Mat_Equ_Val(1,11) = 0;
  end
  
  if (temp_han == tab2_sp3.rb(13) && temp_val == 1)
    set( tab2_sp3.rb(14), 'value', 0 );   
    Mat_Equ_Val(1,14) = 0;    
  end
  if (temp_han == tab2_sp3.rb(14) && temp_val == 1)
    set( tab2_sp3.rb(13), 'value', 0 );    
    Mat_Equ_Val(1,13) = 0;    
  end
  
  if (temp_han == tab2_sp3.rb(15) && temp_val == 1)    
    set( tab2_sp3.rb(16), 'value', 0 );    
    Mat_Equ_Val(1,16) = 0;   
  end
  if (temp_han == tab2_sp3.rb(16) && temp_val == 1)    
    set( tab2_sp3.rb(15), 'value', 0 );     
    Mat_Equ_Val(1,15) = 0;    
  end
  
end

function equipment_submit(handle,event)
  
  global Mat_Equ_Val;
  global tab2_sp3;
  f = 0;

  f = zeros(1,3);
  
  % Dialog Question
  answer = questdlg('Are you sure you want to submit the equipment?', 'Warning', 'Yes', 'No');

  switch answer
      case 'Yes'       
        % Set signal generators lower
        ResetAmplitude();
        pause(2.5);
        
        try
          [temp_data] = equipment_mapping(Mat_Equ_Val);
          spi_soft('m', char(zeros(1,length(temp_data))+48)); % Reset all
          spi_soft('m', char(temp_data)); % Send data   
          
          % Restore signal generators
          SetbackAmplitude()   
        
          msgbox('Equipment and circuit connected successfully.');
        catch
          beep();
          f = warndlg('Control signal was not sent. Equipment not connected.');
        end 
      
        if ~any(f)
          % Set bar to green or red.
          for i = 1:length(tab2_sp3.rb);   
            temp_val = get( tab2_sp3.rb(i), 'value'); 
            set_bar_color(tab2_sp3.rb(i), temp_val);    
          end 
        endif
     case 'No'
       % Do nothing
     case 'Cancel'
       % Do nothing
  endswitch     
   
end

function equipment_reset(handle,event)
  
  global Mat_Equ_Val;
  global tab2_sp3; 
  f = 0;
  
  % Set signal generators lower
  ResetAmplitude();
  
  % Disconnect the equipment
  try
    [temp_data] = equipment_mapping(Mat_Equ_Val);
    spi_soft('m', char(zeros(1,length(temp_data))+48)); % Reset all
    
    % Restore signal generators
    SetbackAmplitude()     
  
    msgbox('Equipment circuit reset successfully.');
  catch
    beep();
    f = warndlg('Control signal was not sent. Equipment is not reset.');
  end 
  
  if ~any(f)
    % Reset radiobuttons and make bar red
    for i = 1:length(tab2_sp3.rb);   
      set( tab2_sp3.rb(i), 'value', 0 ); 
      set_bar_color(tab2_sp3.rb(i),0)       
      [temp_row,temp_col] = find(tab2_sp3.rb == tab2_sp3.rb(i));
      Mat_Equ_Val(temp_row,temp_col) = 0;    
    end
  endif  
        
   
end
