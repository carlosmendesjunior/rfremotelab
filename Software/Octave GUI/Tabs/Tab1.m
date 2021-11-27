%%% Tab 1 - Circuit Builder
%%% Eindhoven Unversity of Technology
%%% Authors: Dr. Carlos Mendes, Jr.
%%%          Prof. Dr. Peter Baltus          

%% --> Tab 1 <--
 
%% --- Sub-Panel 1 --- COMPONENTS ---
tab1_sp(1) = uipanel ('parent', tab(1), 'title', 'Components', 'position', [0.02 0.515 0.3 0.465]); % [left, bottom, width, height]
	
	% Title for the Picture
	tab1_sp1.t(1) = uicontrol( 'parent', tab1_sp(1), 'style', 'text', 'units', 'normalized','horizontalalignment', 'center',...
						'string', 'CD4007','position', [0.35 0.87 0.3 0.08]);
	
	% Add Picture of the Internal Connections
	tab1_sp1.ax(1) = axes('parent', tab1_sp(1),'position', [0.03 0.21 0.9 0.7]);
	Img = imread (fullfile('./Figures', 'CD4007.png'));
	imshow(Img, []);
	axis image off;
	
	% Title for the Picture
	tab1_sp1.t(2) = uicontrol( 'parent', tab1_sp(1), 'style', 'text', 'units', 'normalized','horizontalalignment', 'center',...
						'string', 'Resistor 1','position', [0.15 0.15 0.3 0.08]);
	
	% Add Picture of the Internal Connections
	tab1_sp1.ax(2) = axes('parent', tab1_sp(1),'position', [0 0.05 0.6 0.12]);
	Img = imread (fullfile('./Figures', 'R1.png'));
	imshow(Img, []);
	axis image off;
	
	% Title for the Picture
	tab1_sp1.t(3) = uicontrol( 'parent', tab1_sp(1), 'style', 'text', 'units', 'normalized','horizontalalignment', 'center',...
						'string', 'Resistor 2','position', [0.55 0.15 0.3 0.08]);
	
	% Add Picture of the Internal Connections
	tab1_sp1.ax(3) = axes('parent', tab1_sp(1),'position', [0.4 0.05 0.6 0.12]);
	Img = imread (fullfile('./Figures', 'R2.png'));
	imshow(Img, []);
	axis image off;
              
%% --- Sub-Panel 2 --- CIRCUITS SETTINGS ---
tab1_sp(2) = uipanel ( 'parent', tab(1), 'title', 'Circuit Settings', 'position', [0.02 0.03 0.3 0.465]);
	
	% Create the Input Edit - Bias Voltage G1
	tab1_sp2.t(1) = uicontrol( 'parent', tab1_sp(2), 'style', 'text', 'units', 'normalized','horizontalalignment', 'center',...
							'string', 'Bias Voltage (G1)', 'position', [0.13 0.8 0.3 0.08]);
					
	tab1_sp2.e(1) = uicontrol( 'parent', tab1_sp(2), 'style', 'edit', 'units', 'normalized','backgroundcolor','white',...
							'position', [0.13 0.72 0.3 0.08], 'string','0');
	
  % Create the Input Edit - Bias Voltage G2
	tab1_sp2.t(2) = uicontrol( 'parent', tab1_sp(2), 'style', 'text', 'units', 'normalized','horizontalalignment', 'center',...
							'string', 'Bias Voltage (G2)', 'position', [0.13 0.57 0.3 0.08]);
					
	tab1_sp2.e(2) = uicontrol( 'parent', tab1_sp(2), 'style', 'edit', 'units', 'normalized','backgroundcolor','white',...
							'position', [0.13 0.49 0.3 0.08], 'string','0');
							
  % Create the Input Edit - Bias Voltage G3
  tab1_sp2.t(3) = uicontrol( 'parent', tab1_sp(2), 'style', 'text', 'units', 'normalized','horizontalalignment', 'center',...
							'string', 'Bias Voltage (G3)', 'position', [0.13 0.34 0.3 0.08]);
					
	tab1_sp2.e(3) = uicontrol( 'parent', tab1_sp(2), 'style', 'edit', 'units', 'normalized','backgroundcolor','white',...
							'position', [0.13 0.25 0.3 0.08], 'string','0');

  % Create the Input Edit - Supply Voltage      
	tab1_sp2.t(4) = uicontrol( 'parent', tab1_sp(2), 'style', 'text', 'units', 'normalized','horizontalalignment', 'center',...
							'string', 'Supply Voltage(VDD)', 'position', [0.51 0.8 0.4 0.08]);
					
	tab1_sp2.e(4) = uicontrol( 'parent', tab1_sp(2), 'style', 'edit', 'units', 'normalized','backgroundcolor','white',...
							'position', [0.56 0.72 0.3 0.08], 'string','5','enable','off'); 
	
	% Create the Popupmenu - Resistor 1
	tab1_sp2.t(5) = uicontrol( 'parent', tab1_sp(2), 'style', 'text', 'units', 'normalized','horizontalalignment', 'center',...
							'string', 'Resistor 1 (Ohms)', 'position', [0.51 0.57 0.4 0.08]);
					
	tab1_sp2.p(1) = uicontrol(  'parent', tab1_sp(2), 'style', 'popupmenu', 'units', 'normalized','backgroundcolor','white',...
							'position', [0.56 0.49 0.3 0.08], 'string', Res_Names);

  % Create the Popupmenu - Resistor 1      
	tab1_sp2.t(6) = uicontrol( 'parent', tab1_sp(2), 'style', 'text', 'units', 'normalized','horizontalalignment', 'center',...
							'string', 'Resistor 2 (Ohms)', 'position', [0.51 0.34 0.4 0.08]);
					
	tab1_sp2.p(2) = uicontrol( 'parent', tab1_sp(2), 'style', 'popupmenu', 'units', 'normalized','backgroundcolor','white',...
							'position', [0.56 0.25 0.3 0.08], 'string', Res_Names);

	% Create a Button - Reset
	tab1_sp2.b(1) = uicontrol( 'parent', tab1_sp(2), 'style', 'pushbutton' ,'string', 'Reset', 'units', 'pixel',...
							'position', [50 26 113 24], 'callback',{@matrix_reset});  % [0.13 0.08 0.3 0.08] [50 26 115 24]
              
	% Create a Button - Submit					  
	tab1_sp2.b(2) = uicontrol( 'parent', tab1_sp(2), 'style', 'pushbutton' ,'string', 'Submit', 'units', 'normalized',...
							'position', [0.56 0.08 0.3 0.08], 'callback',{@matrix_submit});		
                  
%% --- Sub-Panel 3 --- CONNECTION MATRIX
tab1_sp(3) = uipanel ('parent', tab(1), 'title', 'Connection Matrix', 'position', [0.34 0.03 0.32 0.95]);	
	
	% Create a Sub-Sub-Panel 3.1 --- INTERNAL CONNECTIONS ---
	tab1_sp3.ssp(1) = uipanel ('parent', tab1_sp(3), 'title', 'Internal Circuit', 'titleposition', 'righttop',...
						'position', [0.05 0.42 0.9 0.55]); % [0.05 0.02 0.9 0.95]
   
    % Add Columns Lines
   	for k = 1:Mat_Int_Col_N
      tab1_sp3_ssp1.l1(k) = uipanel ('parent', tab1_sp3.ssp(1), 'units', 'normalized', 'backgroundcolor', [0.94118,0.94118,0.94118],...
              'position', [((k/(Mat_Int_Col_N+1))+0.128-(k-1)*0.0105) 0.13 0.015 0.80]);
    end
    
    % Add Row Lines
    for k = 1:Mat_Int_Row_N
      tab1_sp3_ssp1.l2(k) = uipanel ('parent', tab1_sp3.ssp(1), 'units', 'normalized', 'backgroundcolor', [0.94118,0.94118,0.94118],...
								'position', [0.13 (0.98 - (k/(Mat_Int_Row_N+1))+(k-1)*0.01) 0.80 0.015]); % 0.83
    end            
  	
    % Add Picture of Columns Names
    tab1_sp3_ssp1.ax(1) = axes('parent', tab1_sp3.ssp(1), 'position', [0.157 -0.13 0.795 0.4]); 
    Img = imread (fullfile('./Figures', 'Columns.png'));
    imshow(Img, []);
    axis image off;
		
		% Create INTERNAL Crosspoint Matrix with Radiobuttons
		for i = 1:Mat_Int_Row_N
      % Add Row Names
			tab1_sp3_ssp1.t1(i) = uicontrol ('parent',tab1_sp3.ssp(1),'style', 'text', 'units', 'normalized',...
								'foregroundcolor', [1 0 0],'backgroundcolor', [0.94118,0.94118,0.94118],...
                'FontWeight', 'bold', 'horizontalalignment', 'right', 'fontsize', 8,...
								'string', Mat_Int_Row_Names(i), 'position', [0 (0.95 - (i/(Mat_Int_Row_N+1))+(i-1)*0.01) 0.1 0.06]); % 0.98
      for j = 1:Mat_Int_Col_N   
        % Add Radiobuttons
				if (j >= i)
					tab1_sp3_ssp1.rb(i,j) = uicontrol ('parent', tab1_sp3.ssp(1), 'style', 'radiobutton', 'units', 'normalized',...
									'Position', [ ((0.1725+(j-1)/(Mat_Int_Col_N+1))-(j-1)*0.0104) ((0.9675-(i/(Mat_Int_Row_N+1)))+(i-1)*0.0101)...
                  (1/Mat_Int_Col_N)-0.0275 0.042 ], 'callback',{@matrix_internal});
          if (j == i)
            set(tab1_sp3_ssp1.rb(i,j),'Value',1,'enable','off');
          end
				end
			end
		end
    
    % --> Disable Non-used Radiobuttons
    RB_Off_Row = [1 1 1  1  2 2 2 2 2  2  3 3  3  3  4 4 4  4  5 5 5 5  5  6  6  6  7 7 7  7  8 8  8  9  9  9  10 10 11 11 12 12];
    RB_Off_Col = [7 9 13 15 2 5 7 9 13 15 4 11 13 15 7 9 13 15 5 7 9 13 15 11 13 15 7 9 13 15 9 13 15 11 13 15 13 15 13 15 13 15]+1;
    for i = 1: length(RB_Off_Row)
      set(tab1_sp3_ssp1.rb(RB_Off_Row(i),RB_Off_Col(i)),'Value',0,'enable','off', 'visible','off');
    end
    
		
	% Create a Sub-Sub-Panel 3.2 --- EXTERNAL CONNECTIONS ---
	tab1_sp3.ssp(2) = uipanel ('parent', tab1_sp(3), 'title', 'External Circuit', 'titleposition', 'righttop',...
						'position', [0.05 0.02 0.9 0.38]);
		  
   % Add Columns lines
   	for k = 1:Mat_Ext_Col_N
      tab1_sp3_ssp2.l1(k) = uipanel ('parent', tab1_sp3.ssp(2), 'units', 'normalized', 'backgroundcolor', [0.94118,0.94118,0.94118],...
              'position', [((k/(Mat_Ext_Col_N+1))+0.128-(k-1)*0.0105) 0.13 0.015 0.80]);
    end
    
    % Add Row Lines
    for k = 1:Mat_Ext_Row_N
      tab1_sp3_ssp2.l2(k) = uipanel ('parent', tab1_sp3.ssp(2), 'units', 'normalized', 'backgroundcolor', [0.94118,0.94118,0.94118],...
								'position', [0.13 (1 - (k/(Mat_Ext_Row_N+1))+(k-1)*0.01) 0.80 0.0217]); % 0.83
    end    
  	
    % Add Picture of the Columns Names
    tab1_sp3_ssp2.ax(1) = axes('parent', tab1_sp3.ssp(2), 'position', [0.157 -0.13 0.795 0.4]); 
    Img = imread (fullfile('./Figures', 'Columns.png'));
    imshow(Img, []);
    axis image off;
		
    % Create EXTERNAL Crosspoint Matrix with Radiobuttons
		for i = 1:Mat_Ext_Row_N
      % Add Row Names
			tab1_sp3_ssp2.t1(i) = uicontrol ('parent',tab1_sp3.ssp(2),'style', 'text', 'units', 'normalized',...
								'foregroundcolor', [0.26667,0.44706,0.76863],'backgroundcolor', [0.94118,0.94118,0.94118],...
                'FontWeight', 'bold', 'horizontalalignment', 'right', 'fontsize', 8,...
								'string', Mat_Ext_Row_Names(i), 'position', [0 (0.98 - (i/(Mat_Ext_Row_N+1))+(i-1)*0.01) 0.1 0.06]);
      for j = 1:Mat_Ext_Col_N   
        % Add Radiobuttons
        tab1_sp3_ssp2.rb(i,j) = uicontrol ('parent', tab1_sp3.ssp(2), 'style', 'radiobutton', 'units', 'normalized',...
                'Position', [ ((0.1725+(j-1)/(Mat_Ext_Col_N+1))-(j-1)*0.0104) ((0.985 - (i/(Mat_Ext_Row_N+1)))+(i-1)*0.0101)...
                (1/Mat_Ext_Col_N)-0.0275 0.057 ], 'callback',{@matrix_external}); 
			end
		end
    
    % --> Disable Non-used Radiobuttons
    RB_Off_Row = [1 1 1 1 1 1  1  1  1  2 2 2 2 2 2  2  2  2  3 3 3 3 3 3  3  3  3  4 4 4 4 4 4  4  4  4  5 5 5 5 5  5  5  5  6 6 6 6 6  6  6  6  7 7 7 7  7  7  8 8 8 8  8  8];
    RB_Off_Col = [1 4 7 8 9 10 11 13 15 1 4 7 8 9 10 11 13 15 1 4 7 8 9 10 11 13 15 1 4 7 8 9 10 11 13 15 2 5 7 8 10 12 13 15 2 5 7 8 10 12 13 15 3 6 9 11 13 15 1 4 8 10 13 15];
    for i = 1: length(RB_Off_Row)
      set(tab1_sp3_ssp2.rb(RB_Off_Row(i),RB_Off_Col(i)),'Value',0,'enable','off','visible','off');
    end

%% --- Sub-Panel 4 --- INFORMATION ---
tab1_sp(4) = uipanel ('parent', tab(1), 'title', 'Design Flow', 'position', [0.68 0.515 0.3 0.465]);

  % Create the Input Edit - Info 1   
	tab1_sp4.t(1) = uicontrol( 'parent', tab1_sp(4), 'style', 'text', 'units', 'normalized', 'horizontalalignment', 'left',...
							'fontsize',9,'string', '1 - On QUCS-S, simulate the desired circuit;', 'position', [0.1 0.82 0.8 0.1]); 
              
  % Create the Input Edit - Info 2  
	tab1_sp4.t(2) = uicontrol( 'parent', tab1_sp(4), 'style', 'text', 'units', 'normalized', 'horizontalalignment', 'left',...
							'fontsize',9,'string', ['2 - Under Circuit Settings, set the Bias Voltages and', sprintf('\n'),...
              'the Resistors values (if any);'], 'position', [0.1 0.62 1 0.2]);
              
  % Create the Input Edit - Info 3   
	tab1_sp4.t(3) = uicontrol( 'parent', tab1_sp(4), 'style', 'text', 'units', 'normalized', 'horizontalalignment', 'left',...
							'fontsize',9,'string', ['3 - Under Connection Matrix, make the Internal', sprintf('\n'),...
              'connections of the desired circuit;'], 'position', [0.1 0.42 0.8 0.2]);
              
  % Create the Input Edit - Info 4   
	tab1_sp4.t(4) = uicontrol( 'parent', tab1_sp(4), 'style', 'text', 'units', 'normalized', 'horizontalalignment', 'left',...
							'fontsize',9,'string', ['4 - Under Connection Matrix, make the External', sprintf('\n'),...
              'connections of the desired circuit;'], 'position', [0.1 0.22 0.8 0.2]);

  % Create the Input Edit - Info 5   
	tab1_sp4.t(5) = uicontrol( 'parent', tab1_sp(4), 'style', 'text', 'units', 'normalized', 'horizontalalignment', 'left',...
						 'fontsize',9,'string', ['5 - Under Circuit Settings, press Submit and', sprintf('\n'),...
             'proceed to the Measurements tab.'], 'position', [0.1 0.02 0.8 0.2]);
         
%% --- Sub-Panel 5 --- CAMERA ---
tab1_sp(5) = uipanel ('parent', tab(1), 'title', 'Video Camera', 'position', [0.68 0.03 0.3 0.465]);
              
  % Checkbutton - Camera 1   % [left, bottom, width, height]
  tab1_sp5.cb(1) = uicontrol ('parent',tab1_sp(5),'style', 'checkbox','units','pixel',
                              'string', 'Camera 1','callback',{@webcam1_tab1},
                              'value', 0,'position', [70 25 120 24]);   
                              
  % Checkbutton - Camera 2   % [left, bottom, width, height]
  tab1_sp5.cb(2) = uicontrol ('parent',tab1_sp(5),'style', 'checkbox','units','pixel',
                              'string', 'Camera 2','callback',{@webcam2_tab1},
                              'value', 0,'position', [220 25 120 24]);         