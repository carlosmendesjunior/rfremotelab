% This script provides access functions for the Jyetech DSO112A oscilloscope
% (c) 2020 Peter Baltus & Carlos Mendes Jr & Lino Mulken

1; % not a function file, but a file with a set of functions
  
function osc_init()
  global osc;
  # open serial-over-USB connection
  osc.h = serial(osc.port,115200,3);
  # remove any remnants from previous communication
  flushinput(osc.h);
end
  
function retval=DSO112A(cmd)
  global osc;
  # send cmd to DSO112A, preceeded by sync
  retval=srl_write(osc.h,["\xFE",cmd]);
endfunction

function id=getIdDSO112A()
  global osc;
  # Query oscilloscope
  DSO112A(["\xE0","\x04","\x00","\x00"]);
  # wait for response
  do
    iFrame=getHeaderDSO112A();
  until iFrame.valid;
  if (iFrame.id==0xE2)
    id_full=dumpDataDSO112A(10);
    id=char(id_full(2:8));
  else
    id="";
  endif
endfunction  

function initDSO112A()
  global osc;
  # switch oscilloscope to USB mode 
  DSO112A(["\xE1","\x04","\x00","\xC0"]);
endfunction

function exitDSO112A()
  global osc;
  # switch oscilloscope to normal mode
  DSO112A(["\xE9","\x04","\x00","\x00"]);
endfunction

function retval = getHeaderDSO112A()
  global osc;
%  flushinput(osc.h);
  do
    [data,count] = srl_read(osc.h,5);
  until (count>0);
  retval.count=count;
  retval.data=data;
  if (count==5) 
    # header has correct length
    retval.sync=data(1);
    retval.id=data(2);
    retval.framesize=uint16(data(3))+0x100*uint16(data(4));
    retval.datatype=data(5);
    if ((retval.sync==0xFE) && (retval.id!=0))
      # sync is correct
      retval.valid=true;
    else
      # incorrect sync, discard
      retval.valid=false;
    endif
  else
    # header too short
    retval.valid = false;
     error("Header incomplete");
  endif
endfunction  

function retval=dumpDataDSO112A(datasize)
  global osc;
  # Try to read datasize bytes of data, report actual bytes read in count
  [data,count]=srl_read(osc.h,datasize);
  retval=data;
endfunction

function traceData=getTraceDSO112A()
  global osc
  # wait for trace data header
  tic();
  tiredOfWaiting=false;
  do
    header=getHeaderDSO112A();
    if (header.valid) && (header.id!=0xC0)
      dumpDataDSO112A(header.framesize-4);
    endif
    tiredOfWaiting=(toc()>1);
  until (tiredOfWaiting) || ((header.valid) && (header.id==0xC0) && (header.datatype==0x32))
  if (!tiredOfWaiting)
    # Read trace
    traceData=dumpDataDSO112A(header.framesize-8); 
    # Remove reserved bytes at end of frame. According to manual should be 4 bytes, but my DSO adds often 1 or more bytes; therefore input buffer needs flushing for parameter reading
    dumpDataDSO112A(4);
  else
    # return dummy trace
    traceData=[0 0 0 0];
  endif
endfunction

function setParametersDSO112A()
  global osc;
  # Create parametervector from DSO structure elements
  parameterVector(1)=osc.Vsens+2;
  parameterVector(2)=osc.Vcpl;
  parameterVector(3)=mod(typecast(int16(osc.VPos),"uint16"),0x100);
  parameterVector(4)=idivide(typecast(int16(osc.VPos),"uint16"),0x100);
  parameterVector(5)=0;
  parameterVector(6)=0;
  parameterVector(7)=0;
  parameterVector(8)=0;
  parameterVector(9)=osc.TimeBase+6;
  parameterVector(10)=0;
  parameterVector(11)=0;
  parameterVector(12)=0;
  parameterVector(13)=osc.TrigMode;
  parameterVector(14)=osc.TrigSlope;
  parameterVector(15)=mod(typecast(int16(osc.TrigLvl),"uint16"),0x100);
  parameterVector(16)=idivide(typecast(int16(osc.TrigLvl),"uint16"),0x100);
  parameterVector(17)=osc.TrigLCR;
  parameterVector(18)=osc.TrigSrc;
  parameterVector(19)=0;
  parameterVector(20)=osc.Measurements;
  parameterVector(21)=mod(osc.RecLen,0x100);
  parameterVector(22)=idivide(osc.RecLen,0x100);
  parameterVector(23)=0;
  parameterVector(24)=0;
  parameterVector(25)=0;
  parameterVector(26)=0;
  parameterVector(27)=mod(osc.HPos,0x100);
  parameterVector(28)=idivide(osc.HPos,0x100);
  parameterVector(29)=0;
  parameterVector(30)=0;
  # send parameter settings header
  DSO112A(["\xC0","\x22","\x00","\x22",char(parameterVector)]);    
endfunction

function getParametersDSO112A()
  global osc;
  flushinput(osc.h);
  # request parameter settings
  DSO112A(["\xC0","\x04","\x00","\x21"]);    
  # wait for parameter data header
  do
    header=getHeaderDSO112A();
    if (!header.valid)
      # Invalid frame
    endif
    if (header.valid) && (header.id!=0xC0)
      # Discarding data
      dumpDataDSO112A(header.framesize-4);
    endif
  until (header.valid) && (header.id==0xC0) && (header.datatype==0x31)
  parameterVector=dumpDataDSO112A(header.framesize-4);     
  # Assign parameters to DSO structure elements
  osc.Vsens=uint16(parameterVector(1))-2;
  osc.Vcpl=uint16(parameterVector(2));
  osc.VPos=typecast(uint16(parameterVector(3))+0x100*uint16(parameterVector(4)),"int16");
  osc.TimeBase=uint16(parameterVector(9))-6;
  osc.TrigMode=uint16(parameterVector(13));
  osc.TrigSlope=uint16(parameterVector(14));
  osc.TrigLvl=typecast(uint16(parameterVector(15))+0x100*uint16(parameterVector(16)),"int16");
  osc.TrigLCR=uint16(parameterVector(17));
  osc.TrigSrc=uint16(parameterVector(18));
  osc.Measurements=uint16(parameterVector(20));
  osc.RecLen=uint16(parameterVector(21))+0x100*uint16(parameterVector(22));
  osc.HPos=uint16(parameterVector(27))+0x100*uint16(parameterVector(28));
endfunction

function retval = Calc_TS(Timebase)
  % Calculate TS used for the FFT
      if(Timebase == 0x11)
      retval = (20e-3)/25;    
    elseif(Timebase == 0x12)
      retval  = (10e-3)/25;  
    elseif(Timebase == 0x13)
      retval  = (5e-3)/25;   
    elseif(Timebase == 0x14)
      retval  = (2e-3)/25;   
    elseif(Timebase == 0x15)
      retval  = (1e-3)/25; 
    elseif(Timebase == 0x16)
      retval  = (0.5e-3)/25;  
    elseif(Timebase == 0x17)
      retval  = (0.2e-3)/25;   
    elseif(Timebase == 0x18)
      retval  = (0.1e-3)/25; 
    elseif(Timebase == 0x19)
      retval  = (50e-6)/25;
    elseif(Timebase == 0x1A)
      retval  = (20e-6)/25; 
    elseif(Timebase == 0x1B)
      retval  = (10e-6)/25;
    elseif(Timebase == 0x1C)
      retval  = (5e-6)/25;   
    elseif(Timebase == 0x1D)
      retval  = (2e-6)/25;    
    elseif(Timebase == 0x1E)
      retval  = (1e-6)/25;   
    endif  
end

function [x,y] = FFT_DS0112A(Data,TS)
  L = length(Data);
  Y = fft(Data);
  P2 = abs(Y/L);                % Two-sided Amplitude Spectrum
  P1 = P2(1:L/2+1);             % One-sided Amplitude Spectrum
  P1(2:end-1) = 2*P1(2:end-1);
  y(1:length(P1),1) = 20*log10(P1);             % Log of Amplitude Spectrum
  x(1:length(0:(L/2)),1) = (1/TS)*(0:(L/2))/L;       % Frequency Vector
end