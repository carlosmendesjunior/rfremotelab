%%% NanoVNA Functions
%%% Eindhoven Unversity of Technology
%%% Authors: Prof. Dr. Peter Baltus
%%%          Dr. Carlos Mendes Jr.
%%%          Lino van Mulken BSc 

1; % not a function file, but a file with a set of functions

% NanoVNA Measurement
function [nanoS11, nanoS21, nanoFrequencies] = VNA_measurement(vna)

  global vna;
  global nanoS11;
  global nanoS21;
  global nanoFrequencies;

  MinFreq = vna.fmin;
  MaxFreq = vna.fmax;

  initVNA();
  autoSetNanoFrequencies(MinFreq,MaxFreq);
  nanoFrequencies=getNanoFrequencies();
  nanoS11=getNanoS11();
  nanoS21=getNanoS21();

endfunction


# Accessing nanoVNA
function retval=nanoVNA(cmd)
  global vna;
  # send cmd to nanoVNA, append a carriage return (but no linefeed) and return the response as a string
  # Please note that the com port might need to be modified to match the port on a specific computer
  s3=serial(vna.port,115200,5);
  srl_write(s3,[cmd, "\r"]);
  [a,l]=srl_read(s3,100000);
  retval=char(a);
  fclose(s3);
endfunction

function initVNA()
  # set up traces to default values: trace 0 shows S11 in smith chart, trace 1 shows mag S21
  nanoVNA("trace 0 logmag 0"); % smith
  nanoVNA("trace 1 logmag 1");
endfunction

function retval=getNanoFrequencies()
  # return an array of 101 frequency points corresponding to the data points that can be retrieved through getNanoData()
  nanoFrequenciesRaw=strsplit(nanoVNA("frequencies"));
  retval=str2double(nanoFrequenciesRaw(1,2:102));  
endfunction

function setNanoFrequencies(minFreq,maxFreq)
  # set start & stop frequencies. The number of points is fixed at 101
  # other valid commands:
  # sweep start <f>
  # sweep end <f>
  # sweep center <f>
  # sweep span <f>
  # sweep cw <f>
  nanoVNA(["sweep ",num2str(minFreq)," ",num2str(maxFreq)," 101"]);
endfunction

function autoSetNanoFrequencies(MinFreq,MaxFreq)
  setNanoFrequencies(int32(MinFreq),int32(MaxFreq));
endfunction

function retval=getNanoData(port)
  # return a vector of 101 complex numbers representing the s-parameter (S11 for port=1 and S21 for port=2)
  # each element measured at the frequency at the corresponding index of the vector returned by getNanoFrequencies()
  nanoDataRaw=strsplit(nanoVNA(["data ",num2str(port-1)]));
  nanoData1D=str2double(nanoDataRaw(1,3:204));
  retval=nanoData1D(1:2:201)+i*nanoData1D(2:2:202);
endfunction

function retval=getNanoS11()
  # return a vector of 101 copmlex S11 values
  retval=getNanoData(1);
endfunction

function retval=getNanoS21()
  # return a vector of 101 complex S21 values
  retval=getNanoData(2);
endfunction

function retval=nanoInfo()
  # return a string with information about the attached nanoVNA
  retval=nanoVNA("info");
endfunction

function nanoPause()
  # pause the frequency sweep & measurements
  nanoVNA("pause");
endfunction

function nanoResume()
  # resume the frequency sweep & measurements
  nanoVNA("resume")
endfunction