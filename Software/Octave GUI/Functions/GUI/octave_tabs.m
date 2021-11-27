%%% Handling the 'uitab' and 'uitabgroup'
%%% stackoverflow.com/questions/58199830/how-do-you-create-a-uitab-or-uitabgroup
%%% Eindhoven Unversity of Technology
%%% Modified by : Dr. Carlos Mendes Jr.

1; % not a function file, but a file with a set of functions

% Create 3 panels on the same place
function TabGroupHandle = uitabgroup( FigHandle, PosOpt, PosVal )
   TabGroupHandle = uipanel( FigHandle, PosOpt, PosVal);
   setappdata( TabGroupHandle, 'tabs_buttons', {} );
   setappdata( TabGroupHandle, 'tabs_panels', {} );
end

% Update the tab according to the button pressed
function x = on_tab_select( Handle, Event, TabGroupHandle, TabPanel )
   Tabs_buttons = getappdata( TabGroupHandle, 'tabs_buttons'  );  
   Tabs_panels = getappdata( TabGroupHandle, 'tabs_panels' );
   temp_handle = Handle;
   for i=1:length(Tabs_panels); set(Tabs_panels{i}, 'visible', 'off'); end
   set( TabPanel, 'visible', 'on' );
   
   for i = 1:length(Tabs_buttons);
     if(temp_handle == Tabs_buttons{i});
      set(Tabs_buttons{i}, 'value', 0 );   
    else  
      set(Tabs_buttons{i}, 'value', 1 );
    endif
   end
  
end

function TabPanel = uitab( TabGroupHandle, TitleOpt, TitleVal )
   global Tabs_buttons;
   Tabs_buttons = getappdata( TabGroupHandle, 'tabs_buttons'  );
   tabs_panels  = getappdata( TabGroupHandle, 'tabs_panels' );
   TabPanel     = uipanel( TabGroupHandle, 'units', 'normalized', 'position', [ 0, 0, 1, 0.95 ] );
   TabButton    = uicontrol( TabGroupHandle, 'style', 'togglebutton' ,'string', TitleVal, 'units', 'normalized',...
                           'position', [ length(Tabs_buttons) * 0.25, 0.95, 0.25, 0.05 ], 'callback',...
                           {@on_tab_select, TabGroupHandle, TabPanel } );
   Tabs_buttons{end+1} = TabButton;
   tabs_panels{end+1} = TabPanel;
   setappdata( TabGroupHandle, 'tabs_buttons' , Tabs_buttons );
   setappdata( TabGroupHandle, 'tabs_panels', tabs_panels );
end