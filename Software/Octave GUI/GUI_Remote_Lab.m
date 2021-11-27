%% User Interface - Remote Lab 
% Eindhoven Unversity of Technology
% Authors: Dr. Carlos Mendes Jr.
%          Prof. Dr. Peter Baltus    
%          Lino van Mulken

%% Clean System
close all; clear all; clc; 
format short; % eng;

%% Load Packages
graphics_toolkit qt
pkg load signal
pkg load instrument-control
pkg load image-acquisition


%% Load Source Files
source("./load_functions.m");
source("./global_variables.m");
%warning("off");

%% Main GUI (Add a loading bar)
% Create a Window
clf
f = figure(1,'name','Remote Lab'); 
set(f, 'units', 'pixels', 'position', [10, 40, 1280, 720 ],...
    'numbertitle','off');
    %,'closerequestfcn', 'NotClose'); % 720p

% Create the Tabs inside the Window
tabgp = uitabgroup( f, 'position', [0, 0, 1, 1] );

% Define the Tabs
tab(1) = uitab( tabgp, 'title', 'Circuit Builder' );
tab(2) = uitab( tabgp, 'title', 'Measurements' );

% Call Tab1
source("./Tabs/Tab1.m");

% Call Tab2
source("./Tabs/Tab2.m");

% --> RESET ALL HARDWARE

% Make tab(1) Visible for Startup and turn off togglebuttons
drawnow
for i=1:length(tab); set(tab(i), 'visible', 'off'); end
set( tab(1), 'visible', 'on' );
global Tabs_buttons;
for i=2:1:length(tab); set(Tabs_buttons{i}, 'value', 1 ); end

% Refresh
set(f, 'position', [10, 40, 500, 500 ]);
pause(0.1);
set(f, 'position', [320, 180, 1280, 720 ]);

% Initialization
osc_init();
##dut_init();
##sg_init();
update_osc_gui();
update_VNA_gui();	
msgbox('Initialization complete!');					  