%% Callback Function - Plot 
%% (c) 2021 Carlos Mendes, Jr.

1; % not a function file, but a file with a set of functions

%% Plot Options

% Grid
function grid_callback()
  global tab2_sp1;
  if (get(tab2_sp1.cb(1),'value'))
    grid(tab2_sp1.ax(1),'on');
  else
    grid(tab2_sp1.ax(1),'off');
  end
end

% Grid Minor
function grid_minor_callback()
  global tab2_sp1;
  if (get(tab2_sp1.cb(2),'value'))
    grid(tab2_sp1.ax(1),'minor','on');
  else
    grid(tab2_sp1.ax(1),'minor','off');
  end
end

% Enable Log in Y Axis
function log_y_callback()
  global tab2_sp1;
  if (get(tab2_sp1.cb(3),'value'))
    set(tab2_sp1.ax(1),'YScale','log');
  else
    set(tab2_sp1.ax(1),'YScale','linear');
  end
end

% Enable Log in X Axis
function log_x_callback()
  global tab2_sp1;
  if (get(tab2_sp1.cb(4),'value'))
    set(tab2_sp1.ax(1),'XScale','log');
  else
    set(tab2_sp1.ax(1),'XScale','linear');
  end
end

% Axis Tight
function axis_tight_callback()
  global tab2_sp1;
  axis(tab2_sp1.ax(1),'tight');
end

% Hold On
function hold_on_callback()
  global tab2_sp1;
  if (get(tab2_sp1.cb(6),'value'))
    hold(tab2_sp1.ax(1),'on');
  else
    hold(tab2_sp1.ax(1),'off');
  end
end

% Clear Plot
function clear_plot_callback()
  global tab2_sp1;
  cla(tab2_sp1.ax(1));
  data.x = [];
  data.y = [];
  set(tab2_sp1.ax(1),"xticklabel",[]);
  set(tab2_sp1.ax(1),"yticklabel",[]);
end

% Save Plot
function save_plot_callback()
  global data;
  csvwrite('data.csv',data);
  msgbox('Data saved to data.csv');
  %  sendmail();
end

% Add Ticks to Plot
function ticks()
  
  global data;
  global tab2_sp1;
  data.xticks = [];
  data.yticks = [];
  
  % XTicks and XLabels
  data.xticks = linspace(min(data.x),max(data.x),13);
  data.yticks = linspace(min(data.y),max(data.y),9);
  
  % Set Ticks
  set(tab2_sp1.ax(1), "xtick",data.xticks);
  set(tab2_sp1.ax(1), "ytick",data.yticks); 
  
end

% Add Labels to Plot
function labels()
  
  global data;
  global tab2_sp1;
  data.xlabels = [];
  data.ylabels = [];
  
  % XTicks and XLabels in Eng. Format
  for i = 1:2:length(data.xticks)
    data.xlabels(i) = {eng_format(data.xticks(i))};
  end
  set(tab2_sp1.ax(1),"xticklabel",data.xlabels);
  
  % YTicks and YLabels in Eng. Format
  for i = 1:2:length(data.yticks)
    data.ylabels(i) = {eng_format(data.yticks(i))};
  end
  set(tab2_sp1.ax(1),"yticklabel",data.ylabels);
  
end

function plot_labels()
  
  global tab2_sp1;  
  global data;
  global plot_x_labels;
  global plot_y_labels;
  y_label = plot_y_labels{data.plot_label};
  x_label = plot_x_labels{data.plot_label}; 
  set(tab2_sp1.ax(1),"ylabel",y_label);
  set(tab2_sp1.ax(1),"xlabel",x_label);  
  
endfunction

% Format Number to String of Eng. Format
function str = eng_format(x)
  if (x == 0)
    str = sprintf('0.0');
  else
    Exponent = 3 * floor(log10(x) / 3);
    y = x / (10 ^ Exponent);
    ExpValue = [9, 6, 3, 0, -3, -6, -9];
    ExpName = {'G', 'M', 'k', '', 'm', 'u', 'n'};
    ExpIndex = (Exponent == ExpValue);
    if (any(ExpIndex))  % Found in the list:
      str = sprintf('%.1f%s', y, ExpName{ExpIndex});
    else
      str = sprintf('%.1fe%1d', y, Exponent);
    end
  end
end

% Convert Units
function retStr = convert_unit(str)
  % Check if units have been used [k, M, G]
  if(strchr(str, "k") > 0)
    retStr = str2num(regexprep(str,"k","*10^3"));  
  elseif(strchr(str, "M") > 0)         
    retStr = str2num(regexprep(str,"M","*10^6")); 
  elseif(strchr(str, "G") > 0)       
    retStr = str2num(regexprep(str,"G","*10^9"));
  else
  % Incase none of the characters have been used, convert string to nmbr          
    retStr = str2num(str);
  end        
end

function retStr = convert_unit_back(num)
  % Check if units can be converted to k, M, G
  if(num >= 1000) & (num < 1000000)
    num = num*10^(-3);
    retStr = [num2str(num),"k"];  
  elseif(num >= 1000000) & (num <1000000000)
    num = num*10^(-6);
    retStr = [num2str(num),"M"];  
  elseif(num >= 1000000000)
    num = num*10^(-9);
    retStr = [num2str(num),"G"];  
  else
  % Incase none of the characters have been used, convert string to nmbr          
    retStr = num2str(num);
  end        
end

% Oscilloscope Plotting Options
function osc_options()
  
  global osc;
  global data;
  global tab2_sp1;
  
  % Set Limits
  xlim(tab2_sp1.ax(1),data.xlim);
  ylim(tab2_sp1.ax(1),data.ylim);
  
  % Set Ticks
  set(tab2_sp1.ax(1), "xtick",data.xticks);
  set(tab2_sp1.ax(1), "ytick",data.yticks); 
  
  % Set Labels
  labels();
  
end

function plot_trig_vlvl()
  
  global osc;
  global data;
  global tab2_sp1;
  
  % Plot the Trigger and Position
  trigger_y = ones(1,length(data.x))*double(osc.TrigLvl)*(data.ylim(2)/124);
  level_y = ones(1,length(data.x))*double(osc.VPos)*(data.ylim(2)/124);
  if (ishold(tab2_sp1.ax(1)))
    osc.c(1) = plot(tab2_sp1.ax(1),data.x,trigger_y,'color','magenta');
    osc.c(2) = plot(tab2_sp1.ax(1),data.x,level_y,'color','blue');
  else
    hold(tab2_sp1.ax(1),'on');
    osc.c(1) = plot(tab2_sp1.ax(1),data.x,trigger_y,'color','magenta');
    osc.c(2) = plot(tab2_sp1.ax(1),data.x,level_y,'color','blue');
    hold(tab2_sp1.ax(1),'off');
  end
end

% -> Plot Callback
function plot_callback()
  
  global data;
  global tab2_sp1;
  global tab2_sp2_ssp3;
  global tab2_sp2_ssp3_sssp1;  
  
  % Check if oscilloscope is plotted
  if (tab2_sp2_ssp3.refresh_oscilloscope) & (get(tab2_sp2_ssp3_sssp1.cb(1),'value')) 
    data.osc = 1; % data comes from oscilloscope
  endif
  
  if (isempty(data.x))
    error('No data! Please, set a plotting option.');
  else
    plot(tab2_sp1.ax(1),data.x,data.y,'linewidth',2);
    if (data.osc == 1)
      osc_options();
      plot_trig_vlvl();
      data.osc = 0;
      grid_callback();
      grid_minor_callback();      
    else
      %limits();
      ticks();
      labels();
      grid_callback();
      grid_minor_callback();
      log_y_callback();
      log_x_callback();
      axis_tight_callback();      
    end
    
      plot_labels();
  end

    
end
