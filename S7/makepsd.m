function [freq,psdx] = makepsd(x,Fs)

N = size(x,1)
N = 2^nextpow2(N)
xdft = fft(x,N);
size(xdft)
xdft = xdft(1:N/2+1);
psdx = (1/(Fs*N)) * abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);
freq = 0:Fs/N:Fs/2;