
   
pv = 3.5;
c = fliplr(dec2bin(round((pv/5)*255),8)); % fliplr(dec2bin(128,8)); % '00000001';
ce = fliplr('000'); % G1
data = [fliplr([c ce]) rest];
disp(data);
spi_soft('d',char(data)); % Send data

pv = 2.5;
b = fliplr(dec2bin(round((pv/5)*255),8));
be = fliplr('001'); % G2
data = [fliplr([b be]) rest];
disp(data);
spi_soft('d',char(data)); % Send data

pv = 4.5;
d = fliplr(dec2bin(round((pv/5)*255),8));
de = fliplr('010'); % G3
data = [fliplr([d de]) rest];
disp(data);
spi_soft('d',char(data)); % Send data