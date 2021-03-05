clear
close all

if exist('audioData.mat','file')
    load('audioData.mat')
else
    [y,Fs] = audioread('Steven Universe - Escapism Instrumental.mp3');
    save('audioData','y','Fs')
end

songTime = length(y)/Fs;


tS = .8;
tF = 5;
selectionIndices = 1+(round(Fs*tS)):round(Fs*tF);


% Plot timeseries
% figure(1) 
% 
% plot(x(selectionIndices),y(selectionIndices,1))
% grid on


% semilogx(f,P1)
% title('Single-Sided Amplitude Spectrum of X(t)')
% xlabel('f (Hz)')
% ylabel('|P1(f)|')
% grid on


dt = 1/30;
lengthT = 1;

% Split sounds into octaves

octaveBounds = [440 880]/(2^4);

freqPowerDiff = log10(2)/12;

noteNames = {'A','A#','B','C','C#','D','D#','E','F','F#','G','G#'};

figure
keyboard

v = VideoWriter('soundProfile.mp4','MPEG-4');
v.FrameRate = 30;
open(v);

for ind3 = 1:60
    clf
    
    tS = (ind3-1)*dt;
    tF = (ind3-1)*dt+lengthT;
    selectionIndices = 1+(round(Fs*tS)):round(Fs*tF);

    L = length(selectionIndices);
    Y = fft(y(selectionIndices));

    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);

    f = Fs*(0:(L/2))/L;
    
    
    for ind2 = 1:7
        subplot(7,1,ind2)
        
        octaveBoundLow = octaveBounds(1)*(2^(ind2-1));
        octaveBoundHigh = octaveBounds(2)*(2^(ind2-1));
        
        octaveSelectionIndices = f >= octaveBoundLow & f < octaveBoundHigh;
        semilogx(f(octaveSelectionIndices),P1(octaveSelectionIndices))
        xlim([octaveBoundLow,octaveBoundHigh])
        ylim([0,.1])
        
        % Plot lines for dividing notes
        
        noteBoundsPowers = (log10(octaveBoundLow)+freqPowerDiff/2):freqPowerDiff:log10(octaveBoundHigh);
        noteBounds = 10.^noteBoundsPowers;
        
        for ind1 = 1:length(noteBounds)
            line(noteBounds(ind1)*[1 1]',[0 .1]','color',[0 0 0])
            text(noteBounds(ind1),.1,noteNames{ind1},'HorizontalAlignment','right','VerticalAlignment','top')
        end
    end
    
    frame = getframe(gcf);
    writeVideo(v,frame);
    
end

close(v);

%% Play the segment
% audObj = audioplayer(y(selectionIndices),Fs);
% play(audObj)

%% Notes Map


noteFrequencies = logspace(log10(440),log10(880),13);
majorIndices = [1,3,4,6,8,9,11,13];
majorNotes = 'ABCDEFGA';
minorIndices = [2,5,7,10,12];

% for ind1 = 1:length(noteFrequencies)
%     line(noteFrequencies(ind1)*[1 1]',[0 .1]','color',[0 0 0])
% end


% linspace(log10(440),log10(880),13)

%% Grab the largest 6 notes

% P2Temp = P2;
% notes =
% for ind1 = 1:6
%     []
% end