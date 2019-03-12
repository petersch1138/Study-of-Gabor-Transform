clear all; close all; clc;
% Peter Schultz 
% Feb 15 2019
% AMATH 582 A2 Part 2 

% Piano
% L=16; % record time in seconds
% [y, Fs]=audioread('music1.wav'); n=length(y);
% y=y';
% cutoff=100;
% plot((1:length(y))/Fs,y);
% xlabel('Time [sec]'); ylabel('Amplitude');
% title('Mary had a little lamb (piano)'); drawnow
% p8 = audioplayer(y,Fs); playblocking(p8);

% Recorder
L=14; % record time in seconds
[y, Fs]=audioread('music2.wav'); n=length(y);
y=y';
cutoff=50;
% plot((1:length(y))/Fs,y);
% xlabel('Time [sec]'); ylabel('Amplitude');
% title('Mary had a little lamb (recorder)');
% p8 = audioplayer(y,Fs); playblocking(p8);

k=(1/L)*(-(n/2):(n/2)-1);
t=(0:(n-1))/Fs;
tslide=0:0.4:L;
%%
freqs=zeros(1,length(tslide));
for j=1:length(tslide)
    gauss=exp(-(10^9)*(t-tslide(j)).^10); %smaller scalar creates wide windowlarger: narrow, -0.5 is normal
    ywind=gauss.*y;
    ywindt=fft(ywind);
    row = abs(fftshift(ywindt));
    [val, i] = max(row);
    
    if val > cutoff
        freqs(j)=(abs(k(i)));
    end
    
    subplot(3,1,1)
    plot(t,y, 'k-',t,gauss,'r-', 'Linewidth',2);
    xlabel 'Time (s)'; ylabel 'Signal';
    title 'MHALL on Recorder with Gabor Window'

    subplot(3,1,2)
    plot(t,ywind, 'k-','Linewidth',2);
    xlabel 'Time (s)'; ylabel 'Signal';
    title 'Signal within Gabor Window'
    axis([0 L -1 1])
    
    subplot(3,1,3)
    plot(k,row,'k-','Linewidth',2)
    axis([-2500 2500 0 1000])
    xlabel 'Frequency (Hz)'; ylabel 'Power';
    title 'Sample Short Time Fourier Transform of Recorder MHALL'

    pause(.01)

end
figure(2);
scatter((1:length(tslide))*0.4,freqs)
axis([0 16 750 1100])
title 'Notes in MHALL Sequence - Recorder'
xlabel 'Time (s)'; ylabel 'Frequency (Hz)';

