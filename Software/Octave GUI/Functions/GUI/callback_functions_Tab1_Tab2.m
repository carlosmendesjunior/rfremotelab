## Callback Functions
## Eindhoven Unversity of Technology
## Author: Dr. Carlos Mendes, Jr.

1; % not a function file, but a file with a set of functions

function webcam1_tab1()
  
  global cam1;
  global cam2;
  global tab1_sp;
  global tab1_sp5;
  
  if ( get(tab1_sp5.cb(1),'value') == 1 )
    tab1_sp5.ax(1) = axes('parent', tab1_sp(5),'position', [0.05 0.21 0.9 0.7],'visible','off'); 
    set(tab1_sp5.cb(2),'value', 0);
    stop(cam2);
    start(cam1, 1);
    img = getsnapshot(cam1);
    imshow(img, []);
    axis image off;
  else  
    stop(cam1);
  end

   id = add_input_event_hook(@webcam_tab1);
   remove_input_event_hook(id);
  
end

function webcam2_tab1()
  
  global cam1;
  global cam2;
  global tab1_sp;
  global tab1_sp5;
  
  if ( get(tab1_sp5.cb(2),'value') == 1 )
    tab1_sp5.ax(1) = axes('parent', tab1_sp(5),'position', [0.05 0.21 0.9 0.7],'visible','off'); 
    set(tab1_sp5.cb(1),'value', 0);
    stop(cam1);
    start(cam2, 1);
    img = getsnapshot(cam2);
    imshow(img, []);
    axis image off;
  else  
    stop(cam2);
  end
  
end

function webcam1_tab2()
  
  global cam1;
  global cam2;
  global tab2_sp;
  global tab2_sp4;
  
  if ( get(tab2_sp4.cb(1),'value') == 1 )
    tab2_sp4.ax(1) = axes('parent', tab2_sp(4),'position', [0.05 0.21 0.9 0.7],'visible','off'); 
    set(tab2_sp4.cb(2),'value', 0);
    stop(cam2);
    start(cam1, 1);
    img = getsnapshot(cam1);
    imshow(img, []);
    axis image off;
  else  
    stop(cam1);
  end
  
end

function webcam2_tab2()
  
  global cam1;
  global cam2;
  global tab2_sp;
  global tab2_sp4;
  
  if ( get(tab2_sp4.cb(2),'value') == 1 )
    tab2_sp4.ax(1) = axes('parent', tab2_sp(4),'position', [0.05 0.21 0.9 0.7],'visible','off'); 
    set(tab2_sp4.cb(1),'value', 0);
    stop(cam1);
    start(cam2, 1);
    img = getsnapshot(cam2);
    imshow(img, []);
    axis image off;
  else  
    stop(cam2);
  end
  
end