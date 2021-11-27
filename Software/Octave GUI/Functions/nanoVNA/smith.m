function smith(h)
% Create a smith chart. With hold on/hold off your data can be plotted on top of it.
% Author: Marcin Mleczko <dr.k.nick@gmx.de>
% Modified by Peter Baltus <p.g.m.baltus@tue.nl> into an embeddable function

  %retain hold status
  hold_status=ishold();
  hold(h,'on');
  linecolor=[0.8 0.8 0.8];
  plot(h,exp(1i.*[1:1:359]./360.*2.*pi),'color', linecolor) 
  z=0.2+[-10:0.1:10].*i;
  plot(h,h,(z-1)./(z+1),'color', linecolor)
  z=0.5+[-10:0.1:10].*i;
  plot(h,(z-1)./(z+1),'color', linecolor)
  z=1+[-10:0.1:10].*i;
  plot(h,(z-1)./(z+1),'color', linecolor)
  z=5+[-10:0.1:10].*i;
  plot(h,(z-1)./(z+1),'color', linecolor)
  z=2+[-10:0.1:10].*i;
  plot(h,(z-1)./(z+1),'color', linecolor)
  z=10+[-10:0.1:10].*i;
  plot(h,(z-1)./(z+1),'color', linecolor)

  z=[0:0.1:10]-0.2i;
  plot(h,(z-1)./(z+1),'color', linecolor)
  z=[0:0.1:10]-0.5i;
  plot(h,(z-1)./(z+1),'color', linecolor)
  z=[0:0.1:10]-1i;
  plot(h,(z-1)./(z+1),'color', linecolor)
  z=[0:0.1:10]-5i;
  plot(h,(z-1)./(z+1),'color', linecolor)
  z=[0:0.1:10]+0.0000001i;
  plot(h,(z-1)./(z+1),'color', linecolor)
  z=[0:0.1:10]+0.2i;
  plot(h,(z-1)./(z+1),'color', linecolor)
  z=[0:0.1:10]+0.5i;
  plot(h,(z-1)./(z+1),'color', linecolor)
  z=[0:0.1:10]+1i;
  plot(h,(z-1)./(z+1),'color', linecolor)
  z=[0:0.1:10]+5i;
  plot(h,(z-1)./(z+1),'color', linecolor)
  %ax=gca;
  %ax.Box='off'
  %legend(' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ')
  %legend( off);
  axis(h,'off');
  if hold_status
    hold(h,'on');
  else
    hold(h,'off');
  end
endfunction