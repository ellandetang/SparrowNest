function [f,P1] = plotFrequencies(fileName,playBool)

[y,Fs] = audioread(fileName);

songTime = length(y)/Fs;

x = linspace(0,songTime,length(y));

% subplot(2,1,1)
% 
% plot(x,y(:,1))
% grid on
% 
% subplot(2,1,2)

% L = tF-tS;
L = length(x);
Y = fft(y);

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(L/2))/L;
% plot(f,P1)
% title('Single-Sided Amplitude Spectrum of X(t)')
% xlabel('f (Hz)')
% ylabel('|P1(f)|')
% xlim([20,4500])
% grid on

if playBool
    audObj = audioplayer(y,Fs);
    play(audObj)
end

end

