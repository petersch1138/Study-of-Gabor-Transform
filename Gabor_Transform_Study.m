clear all; close all; clc;
% Peter Schultz 
% Feb 15 2019
% AMATH 582 A2 Part 1 

load handel
% p8 = audioplayer(y,Fs);
% playblocking(p8);
%%
v = y'/2;
n=length(v);
L=length(v)/Fs;
t=(1:n)/Fs;
k=(1/L)*(-n/2:(n/2)-1);
% figure(1)
% plot(t,v);
% xlabel('Time [sec]');
% ylabel('Amplitude');
% title('Signal of Interest, v(n)');
%% Gabor
% figure(2)
tslide=0:0.1:L;
% tslide=0:1:L;
x=linspace(0,L,n);
spc=[];

for j=1:length(tslide)
     g=exp(-(10^3)*(t-tslide(j)).^10); % small num is wide, high is narrow, -0.5 is normal
%     g=-(heaviside(x-(tslide(j)))-heaviside((x-tslide(j))+1));
    vwind=g.*v;
    vwindt=fft(vwind);
    row = abs(fftshift(vwindt));
    spc=[spc; row];
    
    subplot(3,1,1)
    plot(t,v, 'k-',t,g,'r-', 'Linewidth',2);
    xlabel 'Time (s)'; ylabel 'Signal';
    title 'Handel Signal with Gabor Window'

    subplot(3,1,2)
    plot(t,vwind, 'k-','Linewidth',2);
    xlabel 'Time (s)'; ylabel 'Signal';
    title 'Handel Signal within Window'

    axis([0 L -1 1])
    subplot(3,1,3)
    plot(k,row/max(row),'k-','Linewidth',2)
    axis([-Fs/2 Fs/2 0 1])
    xlabel 'Frequency (Hz)'; ylabel 'Power';
    title 'Handel Frequency Spectrum within Window'

    pause(0.05)

end

%% Spectrogram
figure(3)
pcolor(tslide, k, spc.'), shading interp, colormap(hot), colorbar
axis([0 L 0 Fs/2])
xlabel 'Time (s)'; ylabel 'Frequency (Hz)';
title 'Handel Spectrograph (Square Window)'
